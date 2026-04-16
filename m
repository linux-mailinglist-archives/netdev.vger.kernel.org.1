Return-Path: <netdev+bounces-278911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1KFdN0FV4Gl5fAAAu9opvQ
	(envelope-from <netdev+bounces-278911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:19:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9ED409E5E
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97066306E364
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F827AC57;
	Thu, 16 Apr 2026 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaPreFgq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2522541C
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776309563; cv=none; b=iqdpzfaFLm5ja43MZ+vAQBGqa+eR5NNEbqTEdA5sHWbhYbXYMrEA1NOz43l5DQpTdvjwZNPangmSlhqUEfqFXQSeMzOLM6HAQn5ky+xViSNrdbTeo/JJkbv0PL8JvhHM/c7xaBZOL02/N+YSdi4oVC/pyrRiXNkbdaeS+N0W9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776309563; c=relaxed/simple;
	bh=6gffQwVrZbWmmoZmS6ntD3kXVEXf3L650/1kWkyePIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYgGBY1J8sKtuS/q2u9wlL6mVzbqOWH+ztarmoGpRmpGHPy0oaNr2Y/4IlBdiWOKHpDunCccS1iTI2LZRguxp+6s8jm2QZ2t9zxxQ5T5k/2vmWj6LxX+JSYL5HmEfyUiSHh6YlBYkAUG2jbMmFhMVRm8BgKQ4Q/tyP0ewlQLfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaPreFgq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb40149037so695585985a.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 20:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776309560; x=1776914360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgBzs6EKzyDLWZ+aqE87/ScBh1gHb7gMVIBVANVXsG8=;
        b=VaPreFgqvH6YxdHi7lpfMyQ8zQHsFSai9T1koCoIkNPxbjCkYMK/NNaRkJYWC79mpk
         XcU29drJP427G9fYkn0q/U7P5v51t3MNzKYGskE2ShwIvZ464bXMlVzg3WbrD5s5qo4r
         iuuZQHh2EufS1CQIiGqyNnk+de0K5c6DIjsbcaBAuVRJ3Lq4IPM/hwcUuyQn8dNpC0zv
         eZfFRpzS4DWJX2PRsr13c6Gs5fOECcA9vmzjq5lvqMX8U0julgXQqm1NzJl1ph1ShERi
         BpbMxDgN30zBimN6LircLEgTNU98k+Lw58NB7poGNl/Dzna8dYplLnG3U24w0bJYiboR
         Lv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776309560; x=1776914360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgBzs6EKzyDLWZ+aqE87/ScBh1gHb7gMVIBVANVXsG8=;
        b=o7WXJMpd2783VP1lnbjn3b/lmv25SM0jvhT6lZ3zsp+RlVYWkzj9s6PaGFAL/6O8kd
         +q36twKNHx+7+ecHy8CjS9trshGp11NYWuUq5Dlicha573jy+r5yCn/Nv+O5r/uI9FMc
         4VzT+1J+39oXwxn0sJ65bOsa+LTJMmt2Qd5D3/Wr4oZ6ETsKt3NwTLuvFJbYEZBDIh2K
         fTTUI4kPpkxMvRGAMGaG2Mzz9NRekZjJRlUR/HDtJogAfONhRYryXa2k8XfnUAdb3d8O
         mNJwloc4d0kFofCbw0X4ParCUwqaiIICAOpXicf31lgp6aZfcGex2gGfYyBerXpF8i0d
         /ZLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yW7nGP4G2xvz60wvQFerlS5YoYdFI/X15qzPPgHvgS9S5cio70H66RaTXRgo5+3ccX1EU1ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/nmmLS/4pLqICSDpExvZUUGM38AcEut03Ylmn2AVuakh4CnJS
	SC+p/qclAcJdeTgxxJEmXVgpJ+biZlSVvLFU6ejHSwqXoI1f025xre9W
X-Gm-Gg: AeBDiesb9MDzK7rACY/rOAee3Jbyz8LocuybeY6KOGvpHV5ARPcbW0xeIr5LaIPyLOW
	Yfv+H0esQwNdhp0xQdBNTX53E9QYC3qD59m9pGuRTKAk6B9HgTYPUzPBOQTOcrauHtpqMiVd3IP
	RPvlyRcWwGWvWU+wyGmTojxVJspjCtAOpzT59gUN2qy0F8eEjKfoz9X9RDu/EQ9a0Zm2Vzc7jHC
	2CoyaLRwXjnit3L6s6xDcq7lMC+HP703OL2wl2vGfszJj0IFEpYJav5v1VnOT8iox9QmXkpQtSV
	P9H52DZdz999QlA/4/HpAWXiFysoYnViA7e1gi+C0FS7cWuF6xYz/3Ul5sugGgeX6aCaMQ4Q/YW
	Lo+CEBQpz2xAXNxpUiYv2pjpHpKlQSELLTJSAVGUp440FuDV81J2T5FxJPrMh64ZM3BaFmBZSER
	gufN3wU1JFnZBlTqsyrocEdJsZsf8chtERLU1Bg5Mk9b0pMx6tf+XQa1Gv30le/d5uHSmx6C0XK
	OoGEOUn4eAZUenCh/dPtGL0SH0crHnb+dusTNqIrXzyXr3/pLvzFA==
X-Received: by 2002:a05:620a:29d1:b0:8dc:eca0:35bd with SMTP id af79cd13be357-8ddcd11942bmr3421071185a.5.1776309560487;
        Wed, 15 Apr 2026 20:19:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4eed6eef3sm297805585a.2.2026.04.15.20.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 20:19:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-sctp@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
Date: Wed, 15 Apr 2026 23:19:03 -0400
Message-ID: <20260416031903.1447072-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278911-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC9ED409E5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sctp_getsockopt_peer_auth_chunks() checks that the caller's optval
buffer is large enough for the peer AUTH chunk list with

    if (len < num_chunks)
            return -EINVAL;

but then writes num_chunks bytes to p->gauth_chunks, which lives
at offset offsetof(struct sctp_authchunks, gauth_chunks) == 8
inside optval.  The check is missing the sizeof(struct
sctp_authchunks) = 8-byte header.  When the caller supplies
len == num_chunks (for any num_chunks > 0) the test passes but
copy_to_user() writes sizeof(struct sctp_authchunks) = 8 bytes
past the declared buffer.

The sibling function sctp_getsockopt_local_auth_chunks() at the
next line already has the correct check:

    if (len < sizeof(struct sctp_authchunks) + num_chunks)
            return -EINVAL;

Align the peer variant with its sibling.

Reproducer confirms on v7.0-13-generic: an unprivileged userspace
caller that opens a loopback SCTP association with AUTH enabled,
queries num_chunks with a short optval, then issues the real
getsockopt with len == num_chunks and sentinel bytes painted past
the buffer observes those sentinel bytes overwritten with the
peer's AUTH chunk type.  The bytes written are under the peer's
control but land in the caller's own userspace; this is not a
kernel memory corruption, but it is a kernel-side contract
violation that can silently corrupt adjacent userspace data.

Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 05fb00c9c335..f5d442753dc9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7033,7 +7033,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct sock *sk, int len,
 
 	/* See if the user provided enough room for all the data */
 	num_chunks = ntohs(ch->param_hdr.length) - sizeof(struct sctp_paramhdr);
-	if (len < num_chunks)
+	if (len < sizeof(struct sctp_authchunks) + num_chunks)
 		return -EINVAL;
 
 	if (copy_to_user(to, ch->chunks, num_chunks))
-- 
2.53.0


