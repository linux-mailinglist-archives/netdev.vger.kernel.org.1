Return-Path: <netdev+bounces-204315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456CAFA0F6
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69B4560064
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E2201032;
	Sat,  5 Jul 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emnI5DV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C915A864
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751733456; cv=none; b=ZK8rA1zmWHNdUCifbVQQAKdaN5wIJFzf6PcbFWrFsjynCUYDZFEIGE3wsW5lgcu5/T5rPXynShUabfKuF/W9Lxh6045QQUMkK2gL2Yn7SfPXTn02YQszpIFlSauFO68NpYrFH7akrZk0zsZAWNdF1w1LJS82lIRn6X/sEoMa94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751733456; c=relaxed/simple;
	bh=bpEfMJs8e9ArpurmqPH1aMCwQmhMzG5uqy2rm0sq/DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ay/nAKRdcKCMe2Ou1HWoWcvk/UF9PRjVVlXR2toG3kxsEd50t35vnWNwHCrFhc2RwSdQ4GR92z5b9lvac6Z36OORY/MrpfgC2gv1jLn8WyW4ymwtXQ0jQJx1ER0KokeruMtBsXF96HATTkSvYbjL+I65j7ats6+uRrleL46ZtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emnI5DV6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so416956a91.1
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751733454; x=1752338254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15N/9RGbtN0ibAbyvgksx/lLbHh3evmAYS3TJQW3xZk=;
        b=emnI5DV6MUe2Tgk4qiVgJT2QM7OaFT9JsoS5Gv74jKBtTGReMWnAbPze75iweUtAp8
         aJXELjfD5y3DHqpMr1ZzxSzjDAk40VdPwzzAjKaXlGw20cwa2eKwDRKySKp2npoxL6de
         u+VPwvyyCjidNDEmX3Uqcr5TVgRklF+H0AP3yrCKM8lGtkwE8ujnvd4c5ZQF8YBoESN+
         nihKNJ9Ej+3gcqSsPY5uEKdgyMJ0GYIcHVAPjYVAg9iacSqLud7SiTd3HQ4Fg8ZUnViJ
         T3hfp5GtdbJNSLmlEXd0G2SqG9dM9/dv2h5DVvhnCTBqxgGGpArANzmAd7NehOygks4i
         zZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751733454; x=1752338254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15N/9RGbtN0ibAbyvgksx/lLbHh3evmAYS3TJQW3xZk=;
        b=mblGYQe/GFBUHAH8naVVJp4BN0uFw4WvEVYj6dqt1zhoA1uTW4JK+fEnST15VZnTbd
         AS+NauAMsXHyK7dmwuI7LyyxbUkeiERQR2RkLKPJMJI8tZGkxTwYgeDnE6uT9WjHoLWx
         U6To5W6AK3CwstP22imQizH/1LwbjhbEsfvhLYfXAwiil+DVgv3KvFBf1ISO+ppBi/2F
         2udUg9tj5/UuNTh9oszV4O42GHNznkpY4YFE07hCpau1TqI0iivZrzND7iOpbpiuzfyv
         cnVq3aYh6yq8EobsLPszLVgAA7wvTiKtRbJbnpctCv6SDPM9N2Kjj+2NB4aUcZ5IMIEd
         2iig==
X-Gm-Message-State: AOJu0YyWJE2JXakijnq5IUNW/qvw3pQSS7NMReTiVRGFLUt8WAXZVT4f
	qLDSjHqHddEUbd+fS6bQaDnQn3711k8U3WvOHpIlEnorPMVs+ZuDxro=
X-Gm-Gg: ASbGncsGbu8vr7S2/SAg8RRaLwkb3SkU6mylqSk7RF4Ul+gNjr0OPA8IAI04HSU9IXB
	7hgdCi5m9eLAno+can9XpbJR8HN6PYNXaemHadr+YH1PkJFtnAG97ib5dCXpPQAkt6WB4HX9oKV
	FHBtrq9Gx6lRzKPMgRI3ZjNg6YTlSY77VsRbFZFDJRdiKb86HODJTdzyQ/8IHO8C9cdgHXlXn8S
	pjuGXEGZQKvkWZV1fQtjBkH+QRyzpHR/XfudtDNXP64sEcaW7obXTC1bZ4zKxl/LKzjMGBgabWm
	muqLAfFomibrz+G0G6hqCd+1Sbc9/eniQ45gZkZtwBwVy/eEJRnPmWRdu7LstrCpOG8IA/pAzkn
	myw==
X-Google-Smtp-Source: AGHT+IF+ZQlgJzx0h9TpvyKk2RN6ZlY1FCiRZNM1HublucYMI11IurJtMQPGso4JRIwyf8RO3dpp6w==
X-Received: by 2002:a17:903:2406:b0:23c:8f18:7987 with SMTP id d9443c01a7336-23c8f187bb1mr17315025ad.9.1751733454146;
        Sat, 05 Jul 2025 09:37:34 -0700 (PDT)
Received: from jiaoziyan-Precision-5510.. ([23.163.8.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a373sm45460895ad.7.2025.07.05.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 09:37:33 -0700 (PDT)
From: Xin Guo <guoxin0309@gmail.com>
To: ncardwell@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Xin Guo <guoxin0309@gmail.com>
Subject: [PATCH net-next v1] tcp: update the outdated ref draft-ietf-tcpm-rack
Date: Sun,  6 Jul 2025 00:36:47 +0800
Message-ID: <20250705163647.301231-1-guoxin0309@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As RACK-TLP was published as a standards-track RFC8985,
so the outdated ref draft-ietf-tcpm-rack need to be updated.

Signed-off-by: Xin Guo <guoxin0309@gmail.com>
---
v1:including the other two ref draft-ietf-tcpm-rack
---
 Documentation/networking/ip-sysctl.rst | 2 +-
 net/ipv4/tcp_input.c                   | 2 +-
 net/ipv4/tcp_recovery.c                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2cad74e18f71..14700ea77e75 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -431,7 +431,7 @@ tcp_dsack - BOOLEAN
 
 tcp_early_retrans - INTEGER
 	Tail loss probe (TLP) converts RTOs occurring due to tail
-	losses into fast recovery (draft-ietf-tcpm-rack). Note that
+	losses into fast recovery (RFC8985). Note that
 	TLP requires RACK to function properly (see tcp_recovery below)
 
 	Possible values:
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 79e3bfb0108f..e9e654f09180 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3714,7 +3714,7 @@ static int tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
 }
 
 /* This routine deals with acks during a TLP episode and ends an episode by
- * resetting tlp_high_seq. Ref: TLP algorithm in draft-ietf-tcpm-rack
+ * resetting tlp_high_seq. Ref: TLP algorithm in RFC8985
  */
 static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
 {
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index bba10110fbbc..c52fd3254b6e 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -35,7 +35,7 @@ s32 tcp_rack_skb_timeout(struct tcp_sock *tp, struct sk_buff *skb, u32 reo_wnd)
 	       tcp_stamp_us_delta(tp->tcp_mstamp, tcp_skb_timestamp_us(skb));
 }
 
-/* RACK loss detection (IETF draft draft-ietf-tcpm-rack-01):
+/* RACK loss detection (IETF RFC8985):
  *
  * Marks a packet lost, if some packet sent later has been (s)acked.
  * The underlying idea is similar to the traditional dupthresh and FACK
-- 
2.43.0


