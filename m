Return-Path: <netdev+bounces-203782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FDAF72C9
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F313A8883
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B832E6D06;
	Thu,  3 Jul 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gSM2xjWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655782E6119
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543164; cv=none; b=o3neZFLEUS64SWvrdI4k3sSP80iaMYY8mH5/d/ILoG+jqdA7PU1FCrQSvrl+ujjdZD7LsUF+7xnORjTHRrTY3v9dYqoOuLSSstmjXqZV23KMt1fqVhxW9JJhOCCE2roKUjNPp1foa97n/N7gnX/T3cjA9FQ/tyk8w0nRtQARIWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543164; c=relaxed/simple;
	bh=OaHL0WoVtSCHBsZtnFRPQP+sCQ5TBUCdEkm2wJZn4MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWLwT2HI0LPZuHyStzNA8N/kCqR/YmPF3E4rWgnvopjlafhz2dumh4IRk9b8TZCOCz4Eu7rxppS8VL03/UbDYfw2lTpsxcRxE1cn2a+y+wb5KTATfVqsi5twGvizJTRl+UxbJ/+Q6oPttR9xmsa+IX9R4iJJX7JEXpuQozWtRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gSM2xjWZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so53837095e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1751543160; x=1752147960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdn+w2J+xAdzSMamo0dJ/TGTDwnlFGPsWPEFbY1YCPo=;
        b=gSM2xjWZKNg0O/8ftC9unG6zzcQl8QUc/iEuRzpu3huo/XklFyHeHQ9T6zR1XqF7sw
         Qg+f92rzP3xYVK+AdWMd8qVY/6sV+CQG6bgE/H7P/6/kBRFzX3gvoWneG1S5KKz+nGTY
         QjSmPJ0RaKfqJvhY2DbTkdAW2RzHo93jAfsXfN+1C2ZChJIL6sBft+ADzCYShP2ZycGW
         FqzB5Jx87Vyv5MmDBG8jLVvUXlmsUoYrELKiaHvTdMajx4+u81/NMP2WiaRQJY9Yt40U
         uqnJ41d8LE1SmOkpRL9amTpJ6Ott9hEnWPd7Fx28SE7m9pbGhfkx7sw4eEIC/B6hDAAg
         Y1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543160; x=1752147960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdn+w2J+xAdzSMamo0dJ/TGTDwnlFGPsWPEFbY1YCPo=;
        b=s5YjtxZu+7698JJFVBBMpXLKBGgcaQR1tXC1PWAxEFOFK66+p2f/T7ntKS1IFi7CHO
         sSQgCj4zjj2MM3Do6JULrPEPcEGYw6E4n4MW2t+x4TzzyPh5OgHpVjXEhnp1ai7yFttF
         vNhPM74qUMuOvLEg3jA58ZS8A1iIYpiqCkQ0sraPcIWY3axnFKvAnZriAcrDQGk4THeZ
         puVSHQpjjv46zv/Fa419fhlxcyZo5zFdhGQPOnAH4v0+7w4p8MihoAdIkKLAfyAyl/lH
         ar/qMOxcIVzpyOAQfbeBUnsqd2avfBzPIIi3VdEUKUZWvPwwMZKjxC6cjcoBkzSSMZmL
         yR0g==
X-Gm-Message-State: AOJu0YzBP0LOFNwl+JFC6Bn9uI/OfluSVAy/bFg7ww2M27Oty48X5MyY
	kkgw/7SAYK+EizUmU1LFO1DotxiDFoYgkX9YnHfFtrvt4LwYUiMGeiegCtpIaZGJedS4pLAUPpT
	pv5QQwLZxORPyfT1XbnmASbz0hx1Zb6bf5nlX0DGcIQYR565Vqv0BSFpiANPEuWJb
X-Gm-Gg: ASbGncvMvQ616icQWcqqfc8hw6HD6Zz6+mce2yh7lnMuTkESTpkfz+ZsrxZPKE7Ld9/
	tupWxav8jCHX0qJ3Pn5hNBvZUpAG1NawVFU6yMFczjfy0WtJ9oJDM5Kme1HPARWzr31UeKhqlgO
	ELi/pfRQFnQ4EguULCRjJx7rxNq3pXJWgjuAHoxkoCvKCaYIoScZ0mleb9J0ufAKLjPB9iSd2yo
	Wo9Hx1dwGArK8P8wZ+cUKyvAJRfC2kBZa5qthqz5kbwwnANsOL+a6fSOkdA5akcPux6R9mOUf0t
	x7Cn4nueHzbhJIP08+m7A5fj/YivLPvPRyei4GRildyLYQFTu72wYgSo6qznwondut/Sj7OnHdB
	hG9PVtgLG
X-Google-Smtp-Source: AGHT+IFE3Wk6vZOjF6/LSa4SZImlydRgb0jq4IDhrvlJpJDFVSS8tM07gAX5Fb5PWPPq87asEGYrPg==
X-Received: by 2002:a05:600c:19d4:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-454ab3a90c4mr22091155e9.22.1751543160261;
        Thu, 03 Jul 2025 04:46:00 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:aeb1:428:2d89:85bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9be5bbfsm24174145e9.34.2025.07.03.04.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:45:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gert Doering <gert@greenie.muc.de>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/3] ovpn: reset GSO metadata after decapsulation
Date: Thu,  3 Jul 2025 13:45:12 +0200
Message-ID: <20250703114513.18071-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703114513.18071-1-antonio@openvpn.net>
References: <20250703114513.18071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

The ovpn_netdev_write() function is responsible for injecting
decapsulated and decrypted packets back into the local network stack.

Prior to this patch, the skb could retain GSO metadata from the outer,
encrypted tunnel packet. This original GSO metadata, relevant to the
sender's transport context, becomes invalid and misleading for the
tunnel/data path once the inner packet is exposed.

Leaving this stale metadata intact causes internal GSO validation checks
further down the kernel's network stack (validate_xmit_skb()) to fail,
leading to packet drops. The reasons for these failures vary by
protocol, for example:
- for ICMP, no offload handler is registered;
- for TCP and UDP, the respective offload handlers return errors when
  comparing skb->len to the outdated skb_shinfo(skb)->gso_size.

By calling skb_gso_reset(skb) we ensure the inner packet is presented to
gro_cells_receive() with a clean state, correctly indicating it is an
individual packet from the perspective of the local stack.

This change eliminates the "Driver has suspect GRO implementation, TCP
performance may be compromised" warning and improves overall TCP
performance by allowing GSO/GRO to function as intended on the
decapsulated traffic.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Reported-by: Gert Doering <gert@greenie.muc.de>
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/4
Tested-by: Gert Doering <gert@greenie.muc.de>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ebf1e849506b..3e9e7f8444b3 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -62,6 +62,13 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	unsigned int pkt_len;
 	int ret;
 
+	/*
+	 * GSO state from the transport layer is not valid for the tunnel/data
+	 * path. Reset all GSO fields to prevent any further GSO processing
+	 * from entering an inconsistent state.
+	 */
+	skb_gso_reset(skb);
+
 	/* we can't guarantee the packet wasn't corrupted before entering the
 	 * VPN, therefore we give other layers a chance to check that
 	 */
-- 
2.49.0


