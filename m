Return-Path: <netdev+bounces-264140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JUsHBDqqGnAygAAu9opvQ
	(envelope-from <netdev+bounces-264140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:27:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485320A2E4
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12D9530217E6
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAFE258CE5;
	Thu,  5 Mar 2026 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/HBjRQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5A45BE3
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677643; cv=none; b=SZEO4hdDHWmCW6qHi5YU43sAw9cl0LPga9urJVb7hcasZR86DG5aa9+u3/S4/nvXFZv/FIfqaZ5J3+7xjPdjFuheGBsC80yrecJexd5DVTDua6ixhYaCIGiltkFg5dJMIgEc+ISrpGrQWZunZYz6dImJILo3OYnG7urEbDxxPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677643; c=relaxed/simple;
	bh=VzzyG4X9qMInfMfzq5jCcYjtMsJpzG271GSjgZfyavI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SxpfcgFq5HDNrHke4gYYUWvPxidc6jz8Yog1741BrMEoxwnrVcJ2oIic4XPhsaKBZjBM2t16403Q7xNBCfI13afGtFPwEWrtTernFoMejhvP6j8SMEatPcNXRNnmC5lT3TiTGK3+cI6PDKjLlFgSfhzaxukqlxcoEFA6cnbSaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/HBjRQ7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82748095892so3706102b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 18:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772677642; x=1773282442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkMPhuGO93KuU6yRsug30lnR/bg4ii0iaHzSwQ3ioDg=;
        b=J/HBjRQ7ZDoANacMwSv1ENgxzuUJWyu/oNsRvmtKAw1nQL543pzLfJIH1ToMTf3y0F
         IC9E6aCsDHmUunD5vds+hgTR3UFSepHq1l0WSx7mJ9iEPOY4tBHyKW03DpFzVnj3vzdx
         OnMhjJUCQffROLoeCBDqSs3XYI8BP5lVBq6+7FjGj2NtMTOQPObU19GPk+oDb0It2UUJ
         QrFuUVCimVNR+SO4e9HKIBNRa09w/sW1bxGXfiDMcjgY88fQE5P/qk8nhHvO3ZphpDPk
         wAoakMwTzIZH++0l0kvJgUqHUKN/8M5S7oq3j6kw9JCBoYJTmMwO6x+T0nqK9ZVi9jSC
         lsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772677642; x=1773282442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkMPhuGO93KuU6yRsug30lnR/bg4ii0iaHzSwQ3ioDg=;
        b=TAbHDPisPqe2UKzzMTJFMge0sQGwMrSAIri01Lq2/YT4dt/DvMe7nVCYLdMN6arXtB
         P5H7M2ViIUhe0wK+Cil2zgBdwecvd7PyX7wbFuNlTbRhbR5tEHD/FkKWO03ZonWrIjC1
         7m+catSYBbfP+Mfh/asSgsmzz90Ox4HBTXOIjk1GP9m9ML0zEQBT1XUkZ5CxQrR3HvFg
         M0/lVkB4jWXq5e+t4mXypO07NDRxyLw2uHTEuqVbRSYolFKxEAvWx9c4A3PP3kLuPaZy
         O+KiZoSdCAjnPn2IkmZBNTlrsZ+sA91fWvEkXypip/wVCNCUQFkW9IzQvLsIOceXcvzz
         zX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtVQxiO807TxLsT2Rf5XTnTmAfTtvMvltdxLLmka+cOH4flkG/MBtA3xTl9u8wwFxD8LlNEtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mKWfm5nRjRR5xPO3tBhpuDhkvDH7b5BcfQqQf9pY59wNgr1a
	ewxjxEezwoSOoY1jzwVn2q/QFFTHNvKrAURkLm4102UabQsRGlEClhYU
X-Gm-Gg: ATEYQzyPAxpcSF+zcCciuRbE/e/ZFI2noPGcBg08ZDAjbQJo/vgUJbuM8h74XswcA3k
	+fQznpW8gvjvTazqi9TDyYuQVn1bUzB4RCV56hnrsGTcFbRejttCXT0CaYV10r2ze2X1riX9NyZ
	8puJ2kQHtSbUU483h32mzu+1z74nZBCbDya1jf8Qj4A3pJGrkxi8O+6qr3D3lw5WbEx8daHL+2y
	p4uxa4Z7zKewL3QREjgPcWYgwz0BiUsJT/OV0UNaTEqIsIoV8L1/zcNn4yAYi4kHKhp2Ux0mJ1l
	vBRI/U1knktTxiC1JXJ68+g9OPJqBGrMj26PubpynWh6jhqI9pMWSURmgz1s+APHVTb4rbt0XKa
	EPw7lXUP5PhwiS/1ZmxHQS2K/yW2ao5TRRwT/mPd4lAWKDFH9AHHTkTf9U4q0Fxuel4Y41u0C0m
	IBlmLD7FipObTV0kRtzgmOBnALAFVNPZ1oQaqUWRB8FFF1k2Dym6WB0+wcVlrSltZx2CQqBGfAu
	GE7YoGvipJm
X-Received: by 2002:a17:90b:2fc8:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-359a6a3d14cmr3510152a91.16.1772677641554;
        Wed, 04 Mar 2026 18:27:21 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2e14821sm242654a91.17.2026.03.04.18.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 18:27:21 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next] tcp: remove unused hash_size from struct tcp_out_options
Date: Thu,  5 Mar 2026 11:27:03 +0900
Message-Id: <20260305022703.3946470-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0485320A2E4
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
	FREEMAIL_CC(0.00)[google.com,kernel.org,cloudflare.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-264140-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

hash_size is declared but never read. The MD5 path always uses a
fixed size of 16, and the TCP-AO path uses tcp_ao_maclen().

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
---
 net/ipv4/tcp_output.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 63ee037f46e50..f0e04ebd8b723 100644
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

base-commit: 21fc6b53f12379f3f9b29830be3597a322261df8
-- 
2.34.1


