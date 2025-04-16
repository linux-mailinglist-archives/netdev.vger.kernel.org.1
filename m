Return-Path: <netdev+bounces-183224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88060A8B6BD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC701903BC8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CC247DEA;
	Wed, 16 Apr 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3GU8XnvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF62253BB
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799085; cv=none; b=jqvp1fPEuft6kncPaZPXtDRJQLJO0yI9/65owjsyY40k6h+o569ww7ZhFWWHb7L3MZpfx+smSgcKP3LxsAt+mIwW0n2TaO8ElG4nmQqc6dO4Uw/utXNgliUIn75NtRlYfgilj/1EDFogIE4LuStDEWtjwyUESqrwU9/ITE/Jq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799085; c=relaxed/simple;
	bh=bKqoWOiVCChZZntCtwcDy3lN4TbaFAKlEkpw2lMw9Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIxfqyUxxyWPBEIK02bizRffsjfVJBY+CgETKQ7+Mp0t4Awrw7Y8ONdiuesAq4I5cD7JxrUhTR3kHrZAMeR/s8bxnDP5bb2ldC1G5lJ0dlBwgyS/wRQzS7AcYzynwnpizX/QOeTaslF7CRmlQcnEB/GF1yq40loGufs+MLEcsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3GU8XnvS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301302a328bso6482272a91.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744799082; x=1745403882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZtvdl+5p3OgFbJBXGbjAg9XrQzePGnuE3sWtUwT6Lg=;
        b=3GU8XnvS42a+vaoHGaPJMq1YeAaMm7CYtZYOal6QzNfjXw4aIkPAsqYHRbNBHlrM9H
         p9XeitR5z1Ei3slIrJ5B15IY7jBdS1q/dla3EyK7ca9CVJJnnmUL0HIw34jPKld+wPwE
         itNKcAzhrcKm37npSiKapn+sjrJboD3d3Arl2gNtdx4GMpKOjg+uvo1kn3l1R0LIqb2l
         zfcz9yF+UT9inRp+1U5Yo3wA7apiwHzCjv0TTNInmpEPm6orTPFSad06c0XZB99Dub0h
         bOYEUHzYrN2x49A48UK2WhkGBUotV54vVgiWIHt/G2yHvGXjgGqtBuzllp+/XyvjRHa+
         jSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799082; x=1745403882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZtvdl+5p3OgFbJBXGbjAg9XrQzePGnuE3sWtUwT6Lg=;
        b=YVdhK5txMlmGElJAXJf7AYZjm01YyuEAF+RMkyJJ+tAJEAmkVlg1+wdJvuRn5cLXD6
         Jb/NN6SNrBeB27saWQKV86RRGO9YdVlf3CsTuMtnp2NE0tZYPh0VeipSKInkyXL0eOa6
         KHLzko4H3044kegqwvEjbGdoY9e6dMOwcQ5WhoPzDY41V+26AeLOh/BP438to870IhMV
         A7x22d2qEzzgdVkCK/3MsIx8oVVgbhw1ABh9keLJ5fjc8Zz1ZMB3GDb86a53BFHKsH1t
         h/mgXrsPlOd+qT1WOjeqkuDfa9KX+rBTfV+WgmhKdVrPGUgf6xi8e6FlH4HB93TfTUtx
         6jkg==
X-Gm-Message-State: AOJu0YwBRKc1UrC3Vx/mLGl15oc4Bh0cKsmKak770sU+w6PvvUImxitl
	Vkbvfm67dWhCsJUs/ISCuZ1DNM+J30gSCYAqeYoZL34IBfxZJX7w2iI+/XsE7U5AUvzUvMK2F90
	=
X-Gm-Gg: ASbGncvWGslmKdIbHk95qhEJqj/mpo15vXtyN+IcR4D5yR66BQPHSXngjc4X+mq15UT
	J7EDhmnNHmmi7KjximTjDNGE4oNawn5XvSKC2KpkbkWjaoBA7L73DyWNeZ4h8/7WHguwLkX1w5d
	O9RcbnjeX1P6AjnXNd9PWF7zAa5LVJVBlZmsvJScdBObI/iN1TwvkvzQ6Zt2BRCLJxWrNowhCaD
	2XdMn//cbJuorLHVSirY/sLlUrMKH7XOU8H2kX/IaU7gB5JbdNSKRFuTYjxCzVxze+V7Rkj+NZE
	zIRlap/btCbvRbUHM95YL92SJCfHonOL2wPobl9A9GJSXSm89BeQF5y7oPNaFHjm
X-Google-Smtp-Source: AGHT+IEkdIlanGMKqGd2VnHhoCjSa3mrivtk1YCunHCiTeilUv7K/VYDrFE76YGweLIqP79PRxa+Iw==
X-Received: by 2002:a17:90b:384c:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-30864178c33mr1609017a91.30.1744799081656;
        Wed, 16 Apr 2025 03:24:41 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613cb765sm1193075a91.43.2025.04.16.03.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:24:41 -0700 (PDT)
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
	pctammela@mojatatu.com
Subject: [PATCH net v2 2/5] net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
Date: Wed, 16 Apr 2025 07:24:24 -0300
Message-ID: <20250416102427.3219655-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416102427.3219655-1-victor@mojatatu.com>
References: <20250416102427.3219655-1-victor@mojatatu.com>
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
index ce5045eea065..73b0741ffd99 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1564,7 +1564,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first) {
+	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
-- 
2.34.1


