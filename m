Return-Path: <netdev+bounces-301980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ieYIpI7PWoBzwgAu9opvQ
	(envelope-from <netdev+bounces-301980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:30:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5486C6A7A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:30:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ghto8w2p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301980-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301980-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 286FF302CF3F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016C369D53;
	Thu, 25 Jun 2026 14:24:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F70369965
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:24:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397449; cv=none; b=aAeUT0MAelDOEFGQq6QtU2+ZrlHxCo+Eb6yC12xqxr+ciAMrUDrQu9WmqcAn83a2GHcexaG5/Ru6W92WducvCwuBMg4UTskY7e+nzbQdIqHtU7+M0WlsJW2GTlCs/T6tp89p6pu6lSbUjjaRQ7e/i2PRzvz0O/KUeg2HZkkHWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397449; c=relaxed/simple;
	bh=rCIrhKaVvNsvBmWDzhf3JByNk8xelVBOQxmn+E99qrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEiDykZ920T79AVnODnDgZq9Xm2ZDjuS3xEdaD9jxbzzihRlfTrUic4EY6ONMJvuOI5efgHp4u0sJXebbTbIK7K/YWkml9q8mtxNuAYXSMDc1wCZBFW1/SphsMrYrTLgV4FJPm34M06Bgf9MBGpuYALg04AAnkgVmgUvSp8qpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghto8w2p; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49249072f03so13489205e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782397446; x=1783002246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5/8DfMwYFHn82COsAU7YI6hnYfW2lO8oL7jTwFmEsY=;
        b=Ghto8w2pcGq+cRzAObj7GCDoVMbUEAvzA6ntf+vY8mkbNiDM/qudMiOwuhqJvM454j
         /8wk5nqFlPLh7OYgkqiioPuB+3+AnMLuudH7SWj1ZxhWEOXzM7CaNQXekRv8sNOBoY89
         BewZ7JzfJXTw81xXYUVOg1YfQY2QWf4Oy4F2LooKSyobNtp/R3J7qzl5cHkKZuCQSPl2
         LAqOChn5OsQJmWcIGVdYddLtLke2Ya+K/RHphKUvCXlhHS9Df3p/FIQ9yMCwCc0WbNRw
         /EiP2BO19FibKD4MivPAWZSnBKCApenhIXk27wWT4F8eh1mkA74mytVTZYH5nKiitFKa
         Pxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782397446; x=1783002246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5/8DfMwYFHn82COsAU7YI6hnYfW2lO8oL7jTwFmEsY=;
        b=EzKV3krdcIOPG5BLY/nlnOv5Juy0ifbKly3vRhmvXgparSvna4p0Au7gPlr4vLb8ig
         qGQzyMi3Dd0dI1t9fiCeuxLipjkEfQrxEyhh7jqBpJlBbDoHRBkKhbROepiuYEy5zkbb
         rkjpCbSQTF4XGiCPU6h4/zG54ZXlGn8sAlq5RLHzhQFcAVlUWmW1IZXI4XDEFG1b5/D5
         0EgszcZQcNNCrbAXkyYl4vRHqgEw8Gu77iWo1P/3iJBZJfU2RDK3sw2/QS0PTOA2goVr
         UN7KrG5/roW2ddjT5jz3dCL/chUFPZHPgB4+UnFLwM4D+loj6HEc6n052NjTDbXg8+GO
         OLrg==
X-Forwarded-Encrypted: i=1; AFNElJ8ePA2AwlK+zzDB3ncJqgYV0m8+4nZQj1Ot8vSMR7Xb0d1pbE94gVdcJNgQSpPphDD8BpYHCgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmkE+pzZLOlorF2mKrlzzsJpn4iRxKWbUz0ovrl7zh73wW4iw
	EoUXKEO47MauWVr3ORuFzkAjN3JHvJV571+8C985x8UuRp5NyV4xVDO4
X-Gm-Gg: AfdE7cnPUC22jHU1cepL7QdUYQ6IH2DeOKBTQ7y0gyS7TT9eaf6sa0V45OqG61w6XKh
	MmgffRifdfcIJnSA508q8jx+mILVGWIk/IEEHqvghJPfxxSOX3H1QXaA/iEsFk4nCf9C/eyijvS
	X27HsNVe7vpXSghf/GJkEq/50KMZTW5nSdxfvzoEBgyTNN73gNeSo9WUuSjLAkG30z3/txPuAOU
	Os/ie0nHkDxRxq1Bn+yDqQ0CjRYzO904bVRNRjgHbx5D5HRdEO7iDLtdHuZU8grV5ROeD5MzKGV
	4Rlk6lerUiskh/4RjF8JfGnZgkAZ0N2QjwCiVpduh6OwNMpPJ/Wd5jrxjHZI92t9XPQGu2PBdIa
	JL6GsZlZrzX8p/OKpIOQEwyNGEdKlFrftG35bRUftr9lu4Eh+yFqVJ0D93T7r4ICfUnE6h2ecbP
	XXxLHxRXom39nO5lyPfnUdKleF7g==
X-Received: by 2002:a05:600c:8b25:b0:492:40a1:1e16 with SMTP id 5b1f17b1804b1-4926684a70bmr39636275e9.8.1782397445676;
        Thu, 25 Jun 2026 07:24:05 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fc0d36sm1997075e9.2.2026.06.25.07.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 07:24:05 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net v2] sctp: fix SCTP_RESET_STREAMS stream list length limit
Date: Thu, 25 Jun 2026 16:23:54 +0200
Message-ID: <20260625142354.2600-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301980-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alhouseenyousef@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F5486C6A7A

SCTP_RESET_STREAMS carries a flexible array of u16 stream IDs, but the
optlen clamps treat USHRT_MAX as a byte count and then multiply
sizeof(__u16) by the fixed header size.

That caps the copied and validated option buffer at about 64 KiB, which
rejects valid requests containing more than about half of the u16 stream
ID range.

Use struct_size_t() for the maximum struct sctp_reset_streams layout
instead, so the bound matches the flexible array described by
srs_number_streams.

Fixes: 5960cefab9df ("sctp: add a ceiling to optlen in some sockopts")
Acked-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Add Fixes and Acked-by tags from Xin Long.
- v1: https://lore.kernel.org/r/20260624122213.4052-1-alhouseenyousef@gmail.com

 net/sctp/socket.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 66e12fb0c..b8f13044a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4111,8 +4111,9 @@ static int sctp_setsockopt_reset_streams(struct sock *sk,
 	if (optlen < sizeof(*params))
 		return -EINVAL;
 	/* srs_number_streams is u16, so optlen can't be bigger than this. */
-	optlen = min_t(unsigned int, optlen, USHRT_MAX +
-					     sizeof(__u16) * sizeof(*params));
+	optlen = min_t(unsigned int, optlen,
+		       struct_size_t(struct sctp_reset_streams, srs_stream_list,
+				     USHRT_MAX));
 
 	if (params->srs_number_streams * sizeof(__u16) >
 	    optlen - sizeof(*params))
@@ -4598,8 +4599,8 @@ static int sctp_setsockopt(struct sock *sk, int level, int optname,
 	if (optlen > 0) {
 		/* Trim it to the biggest size sctp sockopt may need if necessary */
 		optlen = min_t(unsigned int, optlen,
-			       PAGE_ALIGN(USHRT_MAX +
-					  sizeof(__u16) * sizeof(struct sctp_reset_streams)));
+			       PAGE_ALIGN(struct_size_t(struct sctp_reset_streams,
+							srs_stream_list, USHRT_MAX)));
 		kopt = memdup_sockptr(optval, optlen);
 		if (IS_ERR(kopt))
 			return PTR_ERR(kopt);
-- 
2.54.0

