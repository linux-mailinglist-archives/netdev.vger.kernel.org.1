Return-Path: <netdev+bounces-237747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C7C4FEB2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD3B3B1581
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBE2EA470;
	Tue, 11 Nov 2025 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DzmAqR3s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFC35CBCE
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897739; cv=none; b=o5UYNZ0vy+DvWyvgUDakXx32auWqQlJgsTX9QHYZeUIOZ/F61xYxVQle3/3VCLOjixHSmplZaEC1CeFtKBMPXg2vdcCpa0hgupzg6Ebgm9BKUVDmE7p9kNRBQ/a/SAk3+329cb9/9UMmQXQqCqqBhyuu4FMYDXkqomQQSfIYFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897739; c=relaxed/simple;
	bh=WbWFkBn7/Uc3GjaH90E99B1s6+26+MtIWsESBXrITe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXPJJ89yT2JIRb23HYnx+b2c+YxsMSzhj2zUKO+1EJFejOIdg6mnC+1402qn6jfsT3v7KHrrA6lbGJu/4htlsjOu+eNyuIXKxP1iAfnsf/IMZuFrTg5KF1oKavtHPu7hxPjqTClIwtlRxa4l4s67DYagQDhmLtPJv+tSLNz7cVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DzmAqR3s; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b312a08a2so112591f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897735; x=1763502535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu3e0laAZR6g+0GcgWld6eK+Gyf6INhJCyJnWWcsVq8=;
        b=DzmAqR3ssKNgiJC9YCz5N3OywDbdILW+UD816fQ8WbbVcCvqvmv3gx/+J3t43oiSSd
         lVo0uH/zwy4+5//0M9gtO+xz+tSbkrRPAMn9IHcU7JtLIozrAKaZewwwJSql0IcOekUD
         KO+N3532kHYTXC71XpfrbPiBU6+O9tcXLZ+Mj0R1bILp3mkH8tmYW6tG4jdCXh7FnKou
         a0pCEUz55mY43p86ZNFfIJ5FR3YEQ7rlcr4AmfljSPvjNPrhIFhmmu6czjHePeBzaCXQ
         QJQEO3IsOp4ZgVw0/GFhLBBPzmtwFFc6kz+1slrfOoDaXhufzTLmcgvy8kHwm6dUba7y
         ltkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897735; x=1763502535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uu3e0laAZR6g+0GcgWld6eK+Gyf6INhJCyJnWWcsVq8=;
        b=kJyOnnyqOy1ucG3uPNXG5DNSaTvpJFU48WnO7cunNFdsNMwwTTSr4uoC32oib/Vxmn
         bpHH3UXiVykNRbrGTd1nooW6vW+m/Eh68MqhXiYdCQd6iyOBRnrleZaTWq/gPLcb29QE
         ETLyu5L4vNabgUpY97lIwI5ypE/QOLA/z/osGMT43veEbuqriRNwJNPM8c6bB+9SLd5x
         IDQQ9eQ1TBITPovPtcpSSu8pq/iXCSq1J+/N8EvUTkDL4b/CuaNhyaeUXABd+ZCh3m7T
         G/ldST9PTLjSMgdsAInXVN5IAtVTJi9WwkDFmM8JWHhDPlEUs5k9m4y10ArucDSUkD6a
         J5Yw==
X-Gm-Message-State: AOJu0Yz8U4383koLc/JmslLRMxMp8tDfgnKaoHqd+wcehJtsetY/in6S
	ZedbYCqSHX9giul+xwVhtdS9tw4INSYushlPPoJPAQ8RyrcKPYmqgygaYDH2Is3jwmV4LaliIqo
	6FHxgW6PJUb+YsST2P7K5qaM/jfwNzCuz0OdfILmsDZDjIStJRTjXAx1Y5y2rLv4pgH8=
X-Gm-Gg: ASbGncsF5hUILzkAs6ash5YnyIOtMZgcJazBJEZyAPRjP6cKCEbL7K2MX4eIEdNbLeQ
	1fVmvxM/Sl5eEu89W5LAvQ5TZzghgJQuP2BRIxEfqXvZxwR59hxj6v0H2evdVQPHbIBqwkvPKzJ
	n6aaoIZDJn0elrk3q6cUvzOg0DSlN5vmEy2kbx+mCjRflNulDll4IO6HIgbpckkLm0h3NjOyZyT
	wvYpBsMOnmokBXKeSZsZuVI4Iq6ujbIjHG/5rD/WVkTAGr23fky8VAAiyVsVk0Kxy7MI/eeBL3y
	d0Ncs1+4iAZf7wsWp019LYSSTrw5+1Xtap/W/+UMKCnBYMhxO/4IL7xbCoNr1V2cIrGa6Ob+um2
	YfZob8Emkn8IY6krIexEHRZJ4DJJhn7s/037B6TMk1a9dTkURD0KbSsNl33YgdRKehUTbuFrzk+
	AQjV7DMTFJ+rcjPg==
X-Google-Smtp-Source: AGHT+IFE3vbCruWaad9I9Dt3bD00CgArqBGgiQRPVuXl5qZkIQFaBiqjIOnjXAKPKcAqD2C0Sooxrg==
X-Received: by 2002:a05:6000:26d2:b0:42b:396e:2817 with SMTP id ffacd0b85a97d-42b4bd9b823mr534400f8f.40.1762897735385;
        Tue, 11 Nov 2025 13:48:55 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:48:54 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 1/8] ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit
Date: Tue, 11 Nov 2025 22:47:34 +0100
Message-ID: <20251111214744.12479-2-antonio@openvpn.net>
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

From: Sabrina Dubroca <sd@queasysnail.net>

In ovpn_nl_key_swap_doit, the attributes array used to parse the
OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.

Fixes: 203e2bf55990 ("ovpn: implement key add/get/del/swap via netlink")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c7f382437630..fed0e46b32a3 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1061,8 +1061,8 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
-- 
2.51.0


