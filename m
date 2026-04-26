Return-Path: <netdev+bounces-281170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA83B8Ul7mn0qwAAu9opvQ
	(envelope-from <netdev+bounces-281170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:48:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7464C46A6B6
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 540A93056D11
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414FA36CDE2;
	Sun, 26 Apr 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E11hbNXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E336D500
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214600; cv=none; b=kltTXJ4eNd5+Uxc5K17v86UT06Ta/8Y1XzP2d4nkasfqglcjHj4OyJ71SqWEEryHt2J3MtlIrwOlQpZYnilsnIusLHP8se4aTH9iYvini6xrCjz6qltA4Lro4vgdjAWacumUzyB70huClersPONRjobXjwd0sDwSRmbeAjeB7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214600; c=relaxed/simple;
	bh=omBg6V4Fvn8LmVTYDPlZGWlmNNg8jjHRCnm2bN1y8CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7tTCgviUWdTrVMGnQWmuCcV8JC1C6ztbN3fntOb34zcz7NcCyzSwNiLx7B4bQHgAwDf1j2QfTdRjOFZRZBaCIlDQ50FG0PXBaQNY1Gb4uFoKiRadjNWegzoxz6HNzP5adWp7e2oBB+u90adiDLsY65mIomE9w3GgjDYkIMfxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E11hbNXz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so156598615e9.2
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214592; x=1777819392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BIOcSBCSL76yWTH37hlldgnFggOiRZJIQY7KqIeVNg=;
        b=E11hbNXzs4GGTMoQ2hl3uxU/F1i8fd/D9KFLI3VMyVNKIp9AxnoWMsItpxZ0v0CjIb
         16zpLaAmU95mNphj1ppaC9j02951OArxB+AZKyAsuH76p0SOK50XGFhzq4Xvh1rmBPat
         zsnTFiFd1VIyxAlXYY7cQ7TXO/UaGgBcLAlxGMRxnieEJyV/mfxeRKIHLNibG6tUtIbO
         yUW+JywEcZQvFgW2o9FIG8smD6Exn5Fa/mGam1QxLMXM8UJQ6ph3oFB20LCx86XBejvo
         Yunp/Yw5ICY0C6Lym+zYO1bbGBm1IecWPTbZsFe5wTiVLWg5ukjo9At/NKZiIV5fNPEe
         zSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214592; x=1777819392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BIOcSBCSL76yWTH37hlldgnFggOiRZJIQY7KqIeVNg=;
        b=Jub+3OAVp9V23M8B2hVYTES0Jc6eb/tc+njqYmR7HmMAiC9ueYXiz5wF3tjAQV6F1N
         cfUMZubq3cv52UntFpiWACAinMWNGpRCj9PvgrE5h0x3yNoL+fj1rWbxHNczhBgd4aK6
         3ZfFovugzMqW4xKiZtiUcfi1OyZRUbTfnJjNebFPMSs+k9RN1y7am2Mlyev44wNNP7Js
         WA0te25wqdQDeLPaTrrffngdtWrifAnwEXgoouclPhSDYmnABZOZ4JEgc9/QABr+S58m
         s/4W84QAISLISZqCJPlYB9jMliTJ0CfEJio0T2J80D34TptD33dowhwVaE89GToTK0iU
         n5jg==
X-Gm-Message-State: AOJu0Yyg8GRiMD3gZ0RyyCdPHaKxPqdFpfIzYPfvD0krdE+ZcbRcGm0u
	kkyGnX7G/+/hdvLBJSG8Mskp7K/QwZaI/O5JqLd9w7PZGTI1Ke384YMjycyPAA==
X-Gm-Gg: AeBDies0TBuu1gzQ7+923KH4PY0Tb6griYcSVaCcdhbLNYLT5MyBcEGtUTH7Nt/i4jt
	WLptdwxXjbRaNl0o/7rWlSqDnGDVSt4JuF+HRMkgybefjwLVMPO2SST0SUdIRlgWYauDsd8emKU
	dDIy1GHOcT9UjsVZ2pcMD1mq66iuIzcSVw8kfjtxf1NzyyXx1NwTuqI5g5d+x7Sh0CpqitG81bO
	qZ09b/g9z6/a8OrnqqnCcfGpnEqdXTXQ6VUtpsmo+q42q3eepffTXS0mXz3FtyXGPqEB1Nd7iFQ
	zQBLhz2W8tYwwtSzu70kq3TsCduM9yzHVmRL8nm2tPAUfEIhxMpendk7piuI6sr5Od+ttOlKgPx
	GEWDj/yuQJynNoMdRsNgkFHBsCsBwIZhazPaz8LVvaZmL9RDMbGm4nlTU1TTub3ZpTOxMjL7Pb1
	WXQUBAe26io4kjaQPupsz0mYIdJ3EBG/fUaEkz5n1skhMh+je+GEuf6fc8QFKIzVoBzv671Bh1o
	Liono2sNn0pK628CKXu/gZ46g==
X-Received: by 2002:a05:600c:c09c:b0:48a:5363:8cac with SMTP id 5b1f17b1804b1-48a53638e07mr263908545e9.22.1777214591567;
        Sun, 26 Apr 2026 07:43:11 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm658230335e9.8.2026.04.26.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:43:10 -0700 (PDT)
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH net 5/5] rose: guard rose_neigh_put() against NULL in timer expiry
Date: Sun, 26 Apr 2026 16:43:05 +0200
Message-ID: <20260426144305.984349-6-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
References: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7464C46A6B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281170-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In rose_timer_expiry(), the ROSE_STATE_2 branch calls
rose_neigh_put(rose->neighbour) without first checking whether the
pointer is NULL.  After commit 5de7665e0a07 ("net: rose: fix timer
races against user threads") the timer is re-armed when the socket is
owned by a user thread; between the re-arm and the next firing, a
device-down event or concurrent teardown via rose_kill_by_device() can
set rose->neighbour to NULL, leading to a NULL-pointer dereference
inside rose_neigh_put().

Add a NULL check before the put and clear the pointer afterwards.

Fixes: 5de7665e0a07 ("net: rose: fix timer races against user threads")
Tested-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
---
 net/rose/rose_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index bb60a1654d61..d997d24ab081 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -180,7 +180,10 @@ static void rose_timer_expiry(struct timer_list *t)
 		break;
 
 	case ROSE_STATE_2:	/* T3 */
-		rose_neigh_put(rose->neighbour);
+		if (rose->neighbour) {
+			rose_neigh_put(rose->neighbour);
+			rose->neighbour = NULL;
+		}
 		rose_disconnect(sk, ETIMEDOUT, -1, -1);
 		break;
 
-- 
2.51.0


