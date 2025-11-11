Return-Path: <netdev+bounces-237753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA7C4FEAE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45AE34E399F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81758352FBA;
	Tue, 11 Nov 2025 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dptVLhkO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA27352F9F
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897745; cv=none; b=qsHRI6qKNxAUKX351szrtrBqbU75/eV5TqjD8G7cMGip3lJliQKxny5jiMw7Vs321KuAxlu73+6fRt6Zpk3xjpi7bF5HoZxUD4KZ5gMQ0cgXO2APr/ZVUYvM8nL2CpA02Ysj3Kzk0jEnCcZ/th2K/2rCt5efkU+1h/X6Qsp68PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897745; c=relaxed/simple;
	bh=HazR8CqJhUu1uIJ9p7MiM9lIkzS/gH/lnx5BvPD4AI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsDf+Ow9yG/Sclqdf5zz1hwJZXDcrp7++Ul1xv3mkT/rlmNcvjFV6OGUuLyrSQv8hPW0DrIaMg/zWHtbVl0oFR5vRTE7FEeOec53IurrR2RWI2p/zxpPtjZ62tHucGDtHrjc7nhJEOtDUQFRBodDEM8sheQH5TA2ftwvKZzaSMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dptVLhkO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b387483bbso87242f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897741; x=1763502541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5gYGKOD5g+XgiHN+l99EBmbKyBU6gv7FhNJ2n/oH3k=;
        b=dptVLhkO+0TfwZa0ROAxBcSVeQoLhccW/cM4lt7c506FbaNptVvVDXwx85e56F0oc5
         Po5dt94mxgyivxnE9eAZ+6y58lY6bF3pe4h5E5HcxIDq5BMOgoEjdYflIrfT2nPTHpTX
         aXyWBa6EIJ9LIjoded7+MXCHSUmGLBsXppwwO3dCK2D1KF5lqQ2/uyrO4BzUD1grJH6c
         e0z+8BoTm6uZgee1AZ8TYJK0y5NdFDcaJAMhbzWyivQPXqVqiDiUWR/9yGx7sIDKmsEE
         5kK8tQGDMHFFiPAudXN+y/2O/gXmrCruSftWMk09++iSkUOHDMPhSBqxjZUYNhPsp2d5
         672g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897741; x=1763502541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5gYGKOD5g+XgiHN+l99EBmbKyBU6gv7FhNJ2n/oH3k=;
        b=CJA7ScFCneL3/CsTMcQk8N5iPx6OtaSD+E8QJm4jKbvFBbsttf+pWF9xft5qvCQa2Z
         8dmjLLn4XkkAyy3cOH2CNJnjRijEb+8OubwUxaq+teSB3RaEeUOfTN7HI55hbCrTh9Es
         eMxDxGNbzx2Ozq1N02Esg3lfCmRHaaBUsos+gSYOmN8buchUdYiTGKMOTB89VIgpHlBf
         yOVGYZNdTa7k1PALY3fGrI8XBByNK3PvzId751I99RqAn+J+J05HfoHcwJ4uh3AeAT/k
         CrUPh6kTmzE5KI4e5+CRNl7S2w54j0d0VZn62ARVh6xi13tfb8NKNRRz3hccb/AgHg8T
         +azw==
X-Gm-Message-State: AOJu0YxwU+OA/B3ixjJ6iMS3PIZZIcd28b+ad7y700uuav/HBOO7arMH
	Sc81tNvvUvttM4TM0UOENcUmBkDCivZPN2FMrcTFqmZgZSfr1jgelxKQ1952HPFhElC9V8Kuc+d
	kraxBGWOXzwLBIw10TXfVsdSbeiDOnNQnvOT1T17ZpGBJ4cFBYnlmamdKFpxe2R10f6Q=
X-Gm-Gg: ASbGncshl/aV1GW0RwRE9rrzmcI6+QpU8iWO3UIjHzYyrAFn30K0InzU3W38cve7FW8
	j0TuWLB8rmBsFR4zQe66XTU+HQmDXc6OdXDPtdkLYQJGXAHy39AEUSiob+mUmE1endY8+IwwklJ
	fceku6peq/2t2gleDBvl7sORFb35lQtWgjx7+DUqJIQVeLzbC59ip9n1ccuwvDWLmmZaWJLpD4o
	tKEDvKHBnO4C8dn2J5Ze7wW4KjFrQ0/Uc3tuZHOL3CxCJ/mffp9JouN9CWrDBdncJy1zDvuqJRM
	WU/rN0Q9MK48NF1LtdMBmG2eJQwtQH/6hhLFCVkdI+oeNzc4NG/3CLkzGRkCzUkCwV2IG3ugGQq
	bTf0/gMWXvK+AVyoU+M5JvNY0hEYByKSTGPzgjL8hJG4hz3xj4K5ZvKwONfTSIJhGiq/4o8MMHD
	PtgSUb6duesSX4Uz0E9MouWmkA
X-Google-Smtp-Source: AGHT+IHt+Wqdxy0+tQ+9whROAariDSdpH22nTT8AXQIDAlaU3cGH7c/fH7qPcYzKNflh/3v2n7tb8A==
X-Received: by 2002:a05:6000:2c0f:b0:42b:2e39:6d58 with SMTP id ffacd0b85a97d-42b4bdb3809mr527776f8f.51.1762897741435;
        Tue, 11 Nov 2025 13:49:01 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:49:01 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 7/8] ovpn: use bound device in UDP when available
Date: Tue, 11 Nov 2025 22:47:40 +0100
Message-ID: <20251111214744.12479-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111214744.12479-1-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Use the socket’s bound network interface if it’s explicitly specified
via the --bind-dev option in openvpn.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..328819f27e1e 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -154,6 +154,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		.fl4_dport = bind->remote.in4.sin_port,
 		.flowi4_proto = sk->sk_protocol,
 		.flowi4_mark = sk->sk_mark,
+		.flowi4_oif = sk->sk_bound_dev_if,
 	};
 	int ret;
 
@@ -231,7 +232,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		.fl6_dport = bind->remote.in6.sin6_port,
 		.flowi6_proto = sk->sk_protocol,
 		.flowi6_mark = sk->sk_mark,
-		.flowi6_oif = bind->remote.in6.sin6_scope_id,
+		.flowi6_oif = sk->sk_bound_dev_if ?:
+				      bind->remote.in6.sin6_scope_id,
 	};
 
 	local_bh_disable();
-- 
2.51.0


