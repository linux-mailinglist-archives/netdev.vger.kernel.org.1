Return-Path: <netdev+bounces-186159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24404A9D51C
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344BC9C69F5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49022E3FC;
	Fri, 25 Apr 2025 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JCbsml0H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570022AE41
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618846; cv=none; b=L0ryMoPk80PnmS9qk8/4g+zjySAvW1VZOu5qUaD2jrKtUhHxxwdgzmr9PVRKKrNrpcLKia/Y65vs5HDH97YufrCdAgWb9yXQusE9DMfQjjJ2q81Q94Qs9Fg5wfqeWI2MR2cv1y3oOiefgx3GoC1EJW7wh3GTVkMaVE7GsT126E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618846; c=relaxed/simple;
	bh=K8uadt/CgTlH2cox3hTnLUnJurHls5mvmqQhZVEg2aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4Fo/A2h5RW0p7cZhN1rzP3ZLSihO/OmiKnaN/fELkGw66WRqtaZoKCt9opYS3G+YHaKvA1Cfem3xvtHMzgX1pYfSn7uX5DTJZZ92p5xtk7437anYv+ipdkGKs4B7kFyroFPJnBQM7+uWiLYsp0igob+uMvqMtxhxHlEJCn7cIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=JCbsml0H; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22409077c06so44377745ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745618844; x=1746223644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3E65rbjDHCCZtK69BPzwmMEV4c3p9usAeDrDMF/M8A=;
        b=JCbsml0H6CZH27qZE8QWlxqdOnv+MtcD0bIlpSiNvtr6aTTEAeQ5nmHKe7GX2lZTv7
         b1KUaH/rvuDILmWFEGMAmj1GTfuiw4BGj/PmGf8WJmHfANxGl81Wkzl43WuaS7CUkNjf
         B59fdACsWHcOM56gaV/WV0P2UOGhNwtD2ezDlCse0H+CgBFAsIUrk7v0eptTjBQXP2yz
         pkHGVqWokq7Hb7wGc7gR2mA/HNoZPsNT/FNLkEsnYXcqntMf7dfzsUqhCGj3Atvzv8PB
         k3kjlAFzPkoqjpqGx/kxslmo3tZ+HOeZ423kyR+aODZXeICgOIgmdXAvjBDkh6HwIWpC
         IRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618844; x=1746223644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3E65rbjDHCCZtK69BPzwmMEV4c3p9usAeDrDMF/M8A=;
        b=cGrsDPsqCReHBClG6z/QJxhfSmS+/GdX/plmACgJTRRulk+i9LFHjx5uVjcXLxO6q+
         Trh4JfSnU/kfKUBKKnFJIdkcQYiHrknsK83HjKbCIwPFnFiy0jMHQMcly+UOvR/8w1Cd
         Zdx0DqnEXk3/dwnZ9U+6sbKIfZUpbNgDAmuWVvgWaJrk3DEMMpcMaxLvKsgbrU4hs9QO
         w3stuqLCbr/jxETF6Y7Qwpye/PIDxu4xfFIKTxFuVjbKfMneHRq4jHZvwOGYPB1yaebN
         MffMF8/ym/gnPYo3nUkRNfnePrMPO4ESo0TIIBuBn/kOTEBLAGhqtwEt9jkIUWsMy+eM
         5ZSw==
X-Gm-Message-State: AOJu0YwnGVwpPjSPMcIufNre+3xwizzg5TzBmAONwUVPskQb/V6ek5Pp
	RFK0LD2Lq3PrCxJi3KhVJ5TSfSEGUYPlvmGT+L3Ebp6NEPuuIbhPXusedrri5ka/QG1xU9D5qHM
	=
X-Gm-Gg: ASbGncup7CmMg/jXvUc/CQJsQ0Q9cGrHpvO76GHZ53BnOxAnFvwnxNk2KC/3xM3kBL3
	TaXS2QxhD7lzYDwhaFxQi/rUQzTu4OXtynFzqMywVVJAJuBHDrlNhT6x3Ged5/UKfMH56xXcBj1
	NQ/HWXOjHi+5h7RuzPYO2TZD6bxEWGMqVvTKI+Evggoy3Qd5dTj/cPWprMSG4v1H63HhO9PMIhP
	Kt9buZXR15qsbrmFe0tQ1XJpUIYP5j0gW9vL78TMEODeVirXlzkQqBdV/+ndD0YsHjDXX0ViyyN
	g4ERrLZlDR9yTU8LD8M5Lrz537xvY6cIoB4o5bbNBJtJ8lGAv9l7xQ==
X-Google-Smtp-Source: AGHT+IFqRlyYX1UQbmqyTvDSFa58E+5x4mKpTNaut9PyZxjhubyo2A7TAuojRqdAnTI6LY3eruMegw==
X-Received: by 2002:a17:903:2351:b0:220:e655:d77 with SMTP id d9443c01a7336-22dbf63d288mr64300965ad.36.1745618843992;
        Fri, 25 Apr 2025 15:07:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c0:73b:9a6c:c614:cc79:b1ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc3b7bsm37753185ad.100.2025.04.25.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:07:23 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com,
	stephen@networkplumber.org
Subject: [PATCH net v3 2/5] net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
Date: Fri, 25 Apr 2025 19:07:06 -0300
Message-ID: <20250425220710.3964791-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425220710.3964791-1-victor@mojatatu.com>
References: <20250425220710.3964791-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], we have a UAF case when an hfsc class
has a netem child qdisc. The crux of the issue is that hfsc is assuming
that checking for cl->qdisc->q.qlen == 0 guarantees that it hasn't inserted
the class in the vttree or eltree (which is not true for the netem
duplicate case).

This patch checks the n_active class variable to make sure that the code
won't insert the class in the vttree or eltree twice, catering for the
reentrant case.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_hfsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 6c8ef826cec0..cb8c525ea20e 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1569,7 +1569,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first) {
+	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
-- 
2.34.1


