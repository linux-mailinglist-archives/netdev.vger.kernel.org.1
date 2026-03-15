Return-Path: <netdev+bounces-267884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGMzCvH6tWkI8AAAu9opvQ
	(envelope-from <netdev+bounces-267884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:18:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E7228FA45
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B41F30515DD
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73F189BB6;
	Sun, 15 Mar 2026 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="W/reoBBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717D1C84DE
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533841; cv=none; b=jKOP1P3oT1bT8KVh83aNjJ3HVP8fOntLw4nVg5tfE98mLHemD4Ui44Geap7e+TbaDlwbpvuvOigO7CVjR0tnWyxxSqndOklJsmCgmf7X4liptgCemeKdsU+sdgiJ+KKaqgh78LuxaJdDijxuivi1om51ozCSd63x32ghrjIEphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533841; c=relaxed/simple;
	bh=HFDqIUM0RCg+Of301a7DoNZGnl7i7o9L9+T8VComMR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acQxmb0pR/MoJ1PUC+p7kRh2zrIxb+K1WDvTI7cGmP3KOfGpuBfPTCapYc07J3KXu5bK9SvrTlLBa5y/7x4r0yDXuB8xRol7ng085ItnnDmLukv0E81bgU0fETvM9lwzW75nXGq/NEkicfR16XpxisdiqRQDlWy+EfmR+hKFZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=W/reoBBo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35b95a7444bso128251a91.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533839; x=1774138639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqTEDtO0A2QzBBz8Ai348A40xh0+VgvW2TcEGOiI54U=;
        b=W/reoBBowd48IsQ2VO1zkzts7MOJxSF9VlRx/L+wzOxaGIZ/9NXBlwizdzubw7bq/h
         vWzX/bahZB4MZb4m2Nc7BhoSWW10f3VzLYWzxoPuvXQp8H0tnhUbZq3khroSdxF7O9bH
         fubhNEJTcioTgvnHVXp+RmoWJVKd5sBRamID4txbEHDgKiR8nYdaZNy34BF1Tv6uExSJ
         OGUssBcJx1C0V67caGN0lQyf54JdkCSr6Ycm6t9V3KQQ/xvWUmJMsYuTJMfv4K3GzMOZ
         268cHk07yVsFK73wHXvPfsnO9uLFrK4EfVvLGA8w22pWI/pmzdXLZ9C7xVnhx1Od8PRS
         pDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533839; x=1774138639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqTEDtO0A2QzBBz8Ai348A40xh0+VgvW2TcEGOiI54U=;
        b=jjnKwRQVFc+NdrREvlV9GXHCr7kK+kcYJZnQW+rHXjA1Tt/pelmKkUSPd76oHHgsZ5
         vIj8kItlyBDjQxBE6IsiFjLrFKR/BXw4ZLBbUgdi9Fp4uFFl0cESD4Rrs9bqE1qMBUX2
         UwFPIdTM2LvUePcYtEXN74GSGs3A+VjrEkvnZDaA8AuzovlCCx9M1fjTvybJKr2tlGCY
         aWxpQXT0rBVl2tuO5fnvu1izdBR4c5v5ElPWbjWT91f6TyFSEGWsDf4gCtX/9+wqaOVd
         CLt86Jt9TMQT1JDnR8YWMBOIm78Fb/1AI4LNQQxa6Msa7Hw4NYcFl39cKAPy9UY3Nqwg
         hlUg==
X-Gm-Message-State: AOJu0YxrcbzKw1HrbijRtfOMo+aMrAA/4yi6zQtC+0P8O/t95B22m0QC
	maq87rUkcfxukAnWCwuKUdaU3jFsEx98pVa40cX7FgaU3HTrr7Z4FylpY+5XUelJH6t8NpRXk6a
	e4BU/
X-Gm-Gg: ATEYQzxcyLohik8l2dGrI7+ybmPTGLXbzyId0LWMq0ZCL+T9j+D2ohbXXpTHQBOMSzs
	ecqAMQeF3coi6/ADx0uH2+HrwTq3SSIMyQATzTomSqMMqdj03xmQnW+64wiH8sFghHVfr98H9gM
	fGe08KwpfWABA8lDSe9COOMvziIDchX9Vlzk/kr1yVeFhaSHZnCaJywVFxAOrDpaBfSdghtwFsa
	BvFoti9kafzcS9B/RvX+AI9u8D/0rhy6b+WXPfUGmtM+C2kVKCDpiAxOB1RoEhn1xINPONtlz6R
	Ib9PXQVrMT6sFFywKF9b9hlS2XjYaDp2zDE53fy2a6HmOKKSobG97t2uZJKWWx91mc8wfj6wrbr
	V+6ZZjSE6mx5a9yPkxwpluC9xVTPd0m8nqcO2kOLIOEffA3xPyKHazkGu6VrOjVcJ0tG7CyQdl5
	yCyk1LitORf0kNyOz3lj0NvOY0pSugyFPlSSPZAdfPEuY=
X-Received: by 2002:a17:903:1b4f:b0:2ae:bf92:5acc with SMTP id d9443c01a7336-2aeca9a9b0emr89768995ad.3.1773533839581;
        Sat, 14 Mar 2026 17:17:19 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v2 08/10] net/sched: netem: null-terminate tfifo linear queue tail
Date: Sat, 14 Mar 2026 17:14:12 -0700
Message-ID: <20260315001649.23931-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267884-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 80E7228FA45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When tfifo_enqueue() appends a packet to the linear queue tail,
nskb->next is never set to NULL. The list terminates correctly
only by accident if the skb arrived with next already NULL.

Explicitly null-terminate the tail to prevent list corruption.

Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 6a91693bd89b..3bed25f494d3 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -409,6 +409,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 			q->t_tail->next = nskb;
 		else
 			q->t_head = nskb;
+		nskb->next = NULL;
 		q->t_tail = nskb;
 	} else {
 		struct rb_node **p = &q->t_root.rb_node, *parent = NULL;
-- 
2.51.0


