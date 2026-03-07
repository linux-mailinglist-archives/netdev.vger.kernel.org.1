Return-Path: <netdev+bounces-265081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Np+J7u0q2klfwEAu9opvQ
	(envelope-from <netdev+bounces-265081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 06:16:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8622A312
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 06:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C7FF301C570
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 05:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517EA37266E;
	Sat,  7 Mar 2026 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1B8JGp4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380E371065
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772860599; cv=none; b=HnKLrR58yr61eS1Y2rnLbJGO/2xxHPVMmZhRycEPUNGJIovhmDg9yNx0e6+GMokm0r9YlyFWSZpFZHCDtg//gBEE8v3BQWi/dYnMG9GAE6bg9RfF1+zswKP8xher5yWrOQHYQh3VYTHn/1s7Z+wF4BmF3NTcoDEpAbFSy82CVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772860599; c=relaxed/simple;
	bh=9aGS6nxKLQqNm6XhMPr/fXQzmmKIMbBZBAt6bAhM4UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLrc6SJ0Sca4JtBDdPoI4Nwuc0h5zDi+DI+HOew/YYOjWa6WmkM9yBO4jNMPJkgrU2/Fe4oaV41cJ3om4QU78Pj/TWrf0pXFw/L8hLpoK/N5ZsAHU3V5nRqUcSg7Bel5ee6O8GG32bZ9T36YHWTWhfNUS2utyWhn7G3Cx8DA4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1B8JGp4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so5810702a91.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 21:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772860596; x=1773465396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4SHhL3IQHK8BJPh45Tf4rhpNzb7emKmkuPpomwobj0=;
        b=O1B8JGp4MmZgRpBa61eqIx1JPmzM8lHo4Tpghb3K5FZUYlarME59XbBD07lLp41KVX
         vMpH0yUU6maocLnYdy5Vmaq1ECwKyzWzF8vcaltJLcKQWLAl4A5K127mKgYv4TvD1zJp
         i75d9Oyio4tzdGr0d7XVjRD8CRqfGjBnEt6N5ssLTFnbn1EekkAkcGbRim7F9Eey4Mvz
         OT1Yg7g3vt8fr6FS4EYKhMG8KJ+LPPwstLItekk8KUHn+uRDlTP4mQRWMCLAyUe6Am5N
         is4TfDVSno10TzoX0xv6Z1WEqsaFyLXnFLHBBcKwsIBhSeluvgeMkI1zPVFJDO3eGNbF
         vW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772860596; x=1773465396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4SHhL3IQHK8BJPh45Tf4rhpNzb7emKmkuPpomwobj0=;
        b=MaDTBJL42uXVTXD8RevFlZ5xbdkGHCtHudzOXkqmtOZAODpBc8idz51soWzrBlarAq
         pykAziNsoVZR26CN1J9K+WyqoN8Y8zzkRj97+nDpM243qDggVlxfaWX9BPdUlVguHcEt
         CzYv92G+wHm1lYZa66GvEgsF4GBV+PgQy4ry49aKYvx7E4lACgB0vHStY6VSGxk8m1KX
         EaZUUiLZadi0pZv2S3FP9BXwI7idX9uUyOurmQVYIK2jW9B/PnCcbNS3XVnY5cA6aFtv
         WyXa82b1C7PhV/km7duMqZgdiZ9ydLU/zj6EeMDmiqzNLkBaWJRMYBb1KfdGy16HI9zt
         cfkQ==
X-Gm-Message-State: AOJu0YwURzlbuIrg1wSbzXEtLiWYdEQnM3/E/I7Gn1FPGL7kdeGcD/mX
	B+7cRzyZcKwOnjUz6np4R1hXxiHp5uUFNRqkON90dyzBbceaYBACjyz6t8QdCeJtQ4DxJflJ
X-Gm-Gg: ATEYQzxzpQ9ewUtsOz4IIngo0tC9wK/vq5haHHD7cWD6gbROcb+W5OgSx6l6uuOUdye
	6yOMDreubQJESR6qcCME+n3QvKsfF8hqz44tAMJLBPDGKghfTiZyHK8kEO8jZJnky1q4Xg3zNo8
	mX4ZbskW0DOcCHXVOgiCUKMl7TP/Prw/QRQSPYWnE9j2uA1ZZtzjb/T0VCP81UtywZ3p7QkUP1i
	qTG8HJAHPPdAfdZ+TqObWdRzaQv7VJCvtQJOZ5SLtX8B6PlyTjs98bwKXctF/mLxN0wBZO1kaZh
	w1VDkHWOP+qgqNKc1tWbueKozmwY30NKzkQDGilmr5PUnOWlSH6pf6xRxf8QjTQ2DH48KUv2PN/
	yT1hUckaLVPC8grzM1Y1BF54oV6T9trcyoOKGs2GXJZMS9eokPaiqAqWnVO50Rk+QW/rVB9RasH
	QlgbRP8P+7Et3hmErJfx7iS7cw9tuufVW9QSeavOOiNaxJ2lbfq15vfFn+zt+qZahJcAyon1asR
	fb+9YfIOgulxHBob1PUuTmCLCa2dvPi+QDqWTdo6PWQFiSAqcrJ+QNjfasx
X-Received: by 2002:a17:902:d54f:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2ae823a4d58mr46378475ad.23.1772860596162;
        Fri, 06 Mar 2026 21:16:36 -0800 (PST)
Received: from localhost.localdomain (133-32-152-230.east.dxpn.ucom.ne.jp. [133.32.152.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fb4401sm37435395ad.74.2026.03.06.21.16.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Mar 2026 21:16:35 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jakub@cloudflare.com,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next v2] tcp: remove unused hash_size from struct tcp_out_options
Date: Sat,  7 Mar 2026 14:16:19 +0900
Message-ID: <20260307051619.51685-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 44A8622A312
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,cloudflare.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-265081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

hash_size is declared but never read. The MD5 path always uses a
fixed size of 16, and the TCP-AO path uses tcp_ao_maclen().

This closes a 7-byte hole and reduces the struct size from 96 to
88 bytes.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Changes in v2:
  - Added struct size improvement details to commit message (Jakub)
  - Added Reviewed-by tag

 net/ipv4/tcp_output.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f0ebcc7e2..4377b3673 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -441,7 +441,6 @@ struct tcp_out_options {
 	u8 ws;			/* window scale, 0 to disable */
 	u8 num_accecn_fields:7,	/* number of AccECN fields needed */
 	   use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
-	u8 hash_size;		/* bytes in hash_location */
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */

base-commit: f4ac0cc88e9949d41bbdd101caa3117afe983ec9
-- 
2.53.0


