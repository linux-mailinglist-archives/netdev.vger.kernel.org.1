Return-Path: <netdev+bounces-305569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Kr4Ev1GTWp8xgEAu9opvQ
	(envelope-from <netdev+bounces-305569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:35:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E771EA94
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:35:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T6YlOIQs;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305569-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305569-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DFB230293D4
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6F43F4AC;
	Tue,  7 Jul 2026 18:35:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D353FFAC1
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 18:35:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449332; cv=none; b=qKoRKtbd+in9Aas3Cpf55fBpwtL/yiQuhLIIjLyurhemZvKKDthaI89uhQOtEx1+STc8OtwZgPwCpcqRb+Ko3GEzOCD9XK/k5Rj5jAGQZw/C6ld9x2fXu3nATM0oZM2wYYqsT/3mneD6winSBGfyzsJAjhv3i5OBiwV3L5HSrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449332; c=relaxed/simple;
	bh=LTNIWWWHNfOkmzU80JlTfNalGkQHDxa1lYfF+7hTDXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOEdXTOloRKbwAIQpYn8yeGhdZVnT1DWWOLP0LhdLVm5MmzuqMkd3zirM4FtxTFvIEICqPtXDesCF8FcIlr7+3HfuHSbN/6nniM8o8odowyRPI3A11XY3n9hr4/MBbDdLgse4Hz/zovSdjak639dpazsFxCmHMEk07CN/UfRV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6YlOIQs; arc=none smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51bfbe05683so30245571cf.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783449330; x=1784054130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtzdIfG9XZcnEgeVPPq/84u21ReObj8E02cU3lMTv1U=;
        b=T6YlOIQs9C37ShWDnxj4F5UBRJhNYECQiletgkC/by5NzCSiM1q8pkgX53nnbuRMAm
         kt2VLmtZDWHgTCjULqxF/oCf7olb9IwlalNapcZJmbbJ2K1HFjut7eAvhQtRG4k5p+RM
         KNzXZrj89XZayz/BA+yACs5fC7rr9r+yZ1gqqbLZm56O0JdqQU3SW/1QFDmOhoPV91rf
         Qp7BcEgy8GFfxKFga2KJapzeqrz4N9/IYWRyZbYBSpeXCdVNgUsOfM7Ulo0lKEkYYciq
         E5SQtwiQZEtOWCubakah0PesPlnmyIXITsmnCxuKEX6hbtK3WuKnh0rnk9kgHR7daupm
         bbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783449330; x=1784054130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtzdIfG9XZcnEgeVPPq/84u21ReObj8E02cU3lMTv1U=;
        b=MrDrCTiy6WHpbp3ael9JZDePxGl8Xb87FsElepBbA6NZ2EqryGyrF4Xqxv+Ymnh+3b
         PDD9mmcZFgueNLqGpPMsoP0rer8nqTNfoAXoyq++Q25uO5WsWyLERWEce1faxJ4t8CcH
         l6Y1vVwIfu/5DpNS9wCtLFvpHZ6mYwnuP5KCgiGvXKNS3/ZjZzzxD5lJEWuaD8kbHi4a
         5L1+YpS0BeuvNPSC8Jh/0692mq5s+wB10cQtrep3ss7UV7UXE4hZSnq4VgWfD5ZYhy+l
         KixReA/Z12yu0pdOJUNfyHNPJt3WcAG+gHGp5wzJDtzifZguKcddS6Ht5CopXFHJjB4b
         ylWQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+YreLdyzgYnJqHNlNuDaZSyjo0QehI+RWp9x3W7MKX6sOM7WrcU/2zTA5OAb7eycIl36HJPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgajjFYZGpey+lYHcKFrnJtmwrQkRtHrjhtT0BgP+fAYCr2e8
	0ToXg9opx6rEtxo6SXTju+AZa3oxNLFYD01GZ/FvKJ6qwvIAiVMZLR+U
X-Gm-Gg: AfdE7cnE6yzndIhPVAMUHqkhh9js+994UsP+K8GgEFP7CatrBtlCWrGqrI2Jig+VuyN
	PEGjp3ZoQ5zAblrH5gZyWDzJdQYelE1Ea+D6GliAHeDXOo/GsveqYrpJvKlhEaelMGYcKqKebPi
	blTy7436fYTYA7KEcfrlZXDwf9CjMYUv/q0jqINj8JpLw3phS2Ul0nwnLTkGABUGzBvDlbOFcNA
	4p/6/dkl+C3OIcf+Bdi8hD1FgNBV+xLhxsSg0KMlPnG1/gH+nAX5pgRpPAegvZ7f9Ww33ti8+Uo
	LlU/QaG3KIFpS3p8DXWgOTvDZCynS3qjq/RHARZTEyGaJRl4JgGPI7kScCNKXuzxzgGJ2dRubHr
	8BLqVruoGU0AJW+fFmaiIxkg5ias6T6bctMEcfeJ2jdbJ/dh9P1s5+Zc0SjlbmftMCrRraRYXPx
	9dUmY/eUNeZ8Uv7bSt3XdQb1C6DlFFmHMt5bl95I7Ujw==
X-Received: by 2002:ac8:7c54:0:b0:51c:1590:8e28 with SMTP id d75a77b69052e-51c747be191mr71047181cf.25.1783449329472;
        Tue, 07 Jul 2026 11:35:29 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d688sm124822691cf.17.2026.07.07.11.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:35:29 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: david@ixit.cz,
	oe-linux-nfc@lists.linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] nfc: llcp: Fix nfc_dev refcount leak in connect
Date: Tue,  7 Jul 2026 14:35:18 -0400
Message-ID: <20260707183518.1888697-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-305569-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shuangpeng.kernel@gmail.com,m:shuangpengkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C60E771EA94

llcp_sock_connect() takes a reference to the NFC device with
nfc_get_device() and stores it in llcp_sock->dev before moving the
socket to LLCP_CONNECTING.

If such a pending connection is released before reaching
LLCP_CONNECTED, llcp_sock_destruct() does not drop that device
reference because it only handles connected sockets. This leaks the
nfc_dev reference acquired during connect.

Drop the device reference for LLCP_CONNECTING sockets as well.

Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 net/nfc/llcp_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index feab29fc62f4..44639ccd438e 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -960,7 +960,8 @@ static void llcp_sock_destruct(struct sock *sk)
 
 	pr_debug("%p\n", sk);
 
-	if (sk->sk_state == LLCP_CONNECTED)
+	if (sk->sk_state == LLCP_CONNECTED ||
+	    sk->sk_state == LLCP_CONNECTING)
 		nfc_put_device(llcp_sock->dev);
 
 	skb_queue_purge(&sk->sk_receive_queue);
-- 
2.43.0


