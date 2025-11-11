Return-Path: <netdev+bounces-237754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDA9C4FEB1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E8EF4E631E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67A35C18C;
	Tue, 11 Nov 2025 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JlkEPD3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7526B352FA5
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897746; cv=none; b=pyrS41H4kmDGQOY3V98Z92m3pkHM9KUWyuiT04FTdMPqgp6YEDJEIVbdabZp7H9uQtLaSTHY0LRpN0VBeEmPnKaGoOq2ej7INCNTIt7YFIHCtVXLKStisLESA4V8FGGp3d461IKk5X+mU25gTarJXpc1xtRn6E1Epqq84f18kmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897746; c=relaxed/simple;
	bh=bwWNaXvMOluSc68batfwjVHwgS453xioParyfq4DW+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpAlROkwaiZ+beSoT9jVqbCO+0GhWtSa5eft+DQvwK60RlWMOaI2r0ozuTQ/5A9zznehgcDC8Zfudv3QmOs0vofWrbYS4oa9ZhYLrpanRBWyM/lTxU0T1rFTTOnB/tv+3lJLPPK6ttyKoq3eRZvsT/Eu/JWuGKA2FUBenJosAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JlkEPD3K; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so65321f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897742; x=1763502542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjTRymSnvS7OjWFJtOErUZPFYTH1dji+pnfaLd7dkDw=;
        b=JlkEPD3KvTIIrZs5YsSnpR/WV48uGScCuLXAeLdlU32BBKio/KS1yaMtsYyZWTO9AW
         QfB0B30kezhVSGb53AFJmBrwtpWQmo7CXhrEYX3/g8OaWAeM5dbT6nyCendfZugYrDIs
         N0iJ8DBlsq+JdqITiUZbYkqfAphWO6j0MenL4nRwuCOauw+JGTYXlPOa1j0gf3KP+LAf
         7/E/zU6bPBDym6TthTjmJoHJFFpa++nrqsky8iJMDLhMQf6tEZU2w0IAaBhr7eQ8xmmA
         E5GMDdgr9mNutlUdV/v/YJbQzGBZBkFm6kk9i+GkmJhMPXpwaxT++PrZV4cviRgWwm/k
         DWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897742; x=1763502542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjTRymSnvS7OjWFJtOErUZPFYTH1dji+pnfaLd7dkDw=;
        b=YGM7yMfJV0YIwKi7sb0qUkv6Z7VzJ+PfdIwgwAeeCkrO8QpGcKKaWwHjAHCssvAHte
         GyCyfNknQ2SlOZsViJyLnqQa/S8/4USYVXgUHXtisFzIvUobK7hx+sfbcLC3IChBlstX
         K9AGhRokbDWGqKm04Wkj1SGB/a8U6prPaI/58c12DXLENOIEZcklnNvWMo1zSPU4IDza
         Q0sPexagpzW2Kqjal0B3LrRbqX+lm6MKebfAEYaleP3zUQBKkGw/5uKSFGGjsMUrxgr2
         NWH9RFsTrKHYLzS2l++d0IzNGg5rJA23JyBuZwY92o2kGbiNg6peysZ4CxfdKpMJKA78
         IVbA==
X-Gm-Message-State: AOJu0YyNRU/enlTJr3p4H+N0JFO4EA3J3GesvR7ArS2LkayX2T/K1L/K
	a1FIsONrXoB4C/kAPPkir+/poa5h4Kn307Smh5Mx2UBQPrE6crIhEIQp1gSkfzU8QCbaywbkAFZ
	2XQBI0pEAhlhV1zVFID2Q0rzHSd/ngSX86WbRnpCJ2ZlwffJMe1lHr+2Mhqe2i14Qms8=
X-Gm-Gg: ASbGncsoGBxtngwCcwJrC527w038Z0odeIoHZm9sWkqDeqAesLWQglfcPv7lzpEDcqf
	i0PYKwQ85JwIum5rO0/e8dghEgS/TPsZXoq1po/cIZ0nQv1+2GZJlPKDBy2HLxvKSBLxuA9yWEY
	Se3JNDgVLCVGpBaFGd8mOj2xUH9qIhcZDHdAgE3YlqrWr6Oz47CXOsxxcyiSOI3TP7qPGHq4LJw
	8jXfMXFVWNMJsglNNZE5051rl02bEUzrnblPPqBc/9Oyq32gM1ugSnYniZ5I+QruaYOIXexFXwx
	qv7O8pn6s7GogZs+01VuJyyq231w06aap7fwJNjFIUM8iRU830YIDulnzIzRusWOqBlWwmtDRCp
	ydyUQXnYKOWLquEeex2ZIPDV771KmiAWSP0r4/xjkRqe+GDUtqgScXR3HW6axxI6fUFf8iWJ5JI
	NfgUzWwDN3scJ+lXm2zg8xX8un
X-Google-Smtp-Source: AGHT+IF21d3c/TqOi4P6QVYRM+DtpSxkpb/kLYQaQ8y3jRoSZzq6Df8exZe3kMn04PBrbCXOQ/YH6w==
X-Received: by 2002:a05:6000:2583:b0:429:cce9:9b76 with SMTP id ffacd0b85a97d-42b4bdb81afmr448265f8f.50.1762897742391;
        Tue, 11 Nov 2025 13:49:02 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.49.01
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
Subject: [PATCH net-next 8/8] ovpn: use bound address in UDP when available
Date: Tue, 11 Nov 2025 22:47:41 +0100
Message-ID: <20251111214744.12479-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111214744.12479-1-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Use the socket's locally bound address if it's explicitly specified via
the --local option in openvpn.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 328819f27e1e..42798aca7bce 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -148,7 +148,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 {
 	struct rtable *rt;
 	struct flowi4 fl = {
-		.saddr = bind->local.ipv4.s_addr,
+		.saddr = inet_sk(sk)->inet_rcv_saddr ?: bind->local.ipv4.s_addr,
 		.daddr = bind->remote.in4.sin_addr.s_addr,
 		.fl4_sport = inet_sk(sk)->inet_sport,
 		.fl4_dport = bind->remote.in4.sin_port,
@@ -226,7 +226,9 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	struct flowi6 fl = {
-		.saddr = bind->local.ipv6,
+		.saddr = ipv6_addr_any(&sk->sk_v6_rcv_saddr) ?
+				 bind->local.ipv6 :
+				 sk->sk_v6_rcv_saddr,
 		.daddr = bind->remote.in6.sin6_addr,
 		.fl6_sport = inet_sk(sk)->inet_sport,
 		.fl6_dport = bind->remote.in6.sin6_port,
-- 
2.51.0


