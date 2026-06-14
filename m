Return-Path: <netdev+bounces-299134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UPzSDI4nLmq9qAQAu9opvQ
	(envelope-from <netdev+bounces-299134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:01:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E25486804FF
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:01:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ALbGQxW5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299134-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299134-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 531143004DFE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 04:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1181B263C8C;
	Sun, 14 Jun 2026 04:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E325B0A3
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:01:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409674; cv=none; b=jsf6eENoA1EmvHNaBJ2Uhy5yuCRsicbylThtGGrSTAGyQPdgkEStYJXduEccwiaMjPTm3tkWN0sUYvYDUhoFQQv50R9PEAl2ReQ7ZJ7AzSsd0d06bJMftUwLf0kQEfikVIuoCTHuGrGTF2Aa+2BPCMMfuU6A9WQgCSWOd8ssm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409674; c=relaxed/simple;
	bh=kVe9FAvNFPj+G4X6bAwAQlGssRU/9ayG2veBdgiq+m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Esh8nJM4Po94+rYF1yGrSXUkpLPP50wc3jKdETT6vImPQH8Ctz0qe01xsS34iBgyvzkm/+kkV3qg10H5pEYlCtcvqRa5uZ8QJJk2Lj9ok8tPAQGhCZtUvsjIB93d83evX711W7T7tOPBui7LUJfR5Eb94S9tWkNM4aZ4bGPoLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALbGQxW5; arc=none smtp.client-ip=209.85.215.172
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c858b392697so1016870a12.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781409672; x=1782014472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Crq5yHDjMfevdls0e5Awy2sd/URrn7kB/WguSFGm/w=;
        b=ALbGQxW53+/BmF4GJhTKWo4NU65U+1wSG6NtHemim0BPrdiJYXL0jbcwHF9KRe0WAc
         gXCtGWubcnrdLDIrjNxbwn4qp+9m1rbxP1T6NxzKkWActUo99dso8LvkeRfpkMLCLnah
         Mp/jlx0PDtKdBhCxawQxGAVHfAnRbiaXmneDB0eczswssTrZviVnUmynYQcLnWAQuBVA
         5i8lEJfR5VqbIVI+pfx+WrnROPKUDLVgYUH6ZcPM/jtyLg5vB6ZrnmoLl3ElWEGjqo7T
         QJUJS9tcQ3UW6osHKE9l3ZXLmms99hDBcOQSK/re9j3I4LuRiJosGP+WYPdqSqG0DPA3
         iX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781409672; x=1782014472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Crq5yHDjMfevdls0e5Awy2sd/URrn7kB/WguSFGm/w=;
        b=N3R2fc3y3FdYmF2N8Ptc3a3G7qf8vpJBDxmCCRvV8C/FQ3Ws/kz8G1YY9hLgdAN9zl
         L5sEuoA3Rc3Td44DCqfYAPgvH5ez0n9WUKEvjGOW5cwELsZGAG7h/ilUCNGoBj651bVu
         /Ag5iJMARSo3nVvSH+LSV925yXUv53flbLq9R5/maWUwU7CCpBs9fCv7+/7BtJ4Xn+Za
         JXm0boY3hEsJcKn1ok04MH2qpvR0AGV4H4kA7TeZTkr7SAz7kN4lHK18jyQQ60aOR9R9
         wCLySRpWh/0lToXZYWwTvqCBUZ6SiT70ok6heakWpjdiYFYuzyWV7qaQgLBrVKobstfE
         c60Q==
X-Gm-Message-State: AOJu0YyRjdNrbYjDq0urbsoz8i8q0mDONrjHhCyQJDG1/LS6nSq/faoS
	CQ8lSK7BLJBH2wVuq44J5/LFyt6YWYTGwBDpW136HT7qshnajZfubuj1Xj1j3ZGk
X-Gm-Gg: Acq92OE3SvoSlkotQalfb/U8v+2Wo1oCATB6/2YavHUZ2jA4ViirOo4Byk7at5NEyGm
	QWbyHGpxOYq8O1JLtCeloAGEJvh6YYpP70KuIgg21bHIJHDomwkFhtIadfJ7JVIb6wwR6DkuajC
	veUKM9vvXRFIuioa4Rb/M1zdfgHWa6Ux2CZsL5MgChCDSdRABq8VTf9wcisyaCq62CVIx6Ureak
	VdumQMNmRYky3tMzchyc98Ha+VeR6pfSz1sjiLH+Tao56W1N6xKeBUfSdQztLWw+xhXe7uoHoml
	/04UPvjZM7p9M47LdfdSviGguRf6JBlJL+hX1aoHDBv6+tsUrlK+xqpWSzMKYCqGlI6uCs3VVZC
	UbJrB83aps2e8I+1DMKmqtcArOQ5NJnlg46wleGkorhBGxs9c9bszhgoAUUzQ/shuwe02pWzGZt
	EC2zyOlMDJK+gZlTiEVbE=
X-Received: by 2002:a05:6a21:6f17:b0:3b2:8675:4866 with SMTP id adf61e73a8af0-3b78415d3f1mr10802330637.31.1781409672295;
        Sat, 13 Jun 2026 21:01:12 -0700 (PDT)
Received: from mincom1 ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm5676983a12.0.2026.06.13.21.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 21:01:11 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [RFC PATCH net-next 3/7] arm64: dts: airoha: add EN7581 SOE node
Date: Sun, 14 Jun 2026 13:00:28 +0900
Message-ID: <20260614040032.1567994-4-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614040032.1567994-1-hurryman2212@gmail.com>
References: <20260614040032.1567994-1-hurryman2212@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299134-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gondor.apana.org.au,secunet.com,vger.kernel.org,gmail.com,collabora.com,lists.infradead.org,nbd.name];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:ansuelsmth@gmail.com,m:nbd@nbd.name,m:linux-kernel@vger.kernel.org,m:hurryman2212@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E25486804FF

Describe the EN7581 SOE register window and interrupt so the Ethernet driver can discover and initialize the packet offload engine.

Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 arch/arm64/boot/dts/airoha/en7581.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index ff6908a76e8e..a3c1033d2437 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -347,6 +347,12 @@ i2c1: i2c@1fbf8100 {
 			status = "disabled";
 		};
 
+		soe: soe@1fbfa000 {
+			compatible = "airoha,en7581-soe";
+			reg = <0x0 0x1fbfa000 0x0 0x268>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		eth: ethernet@1fb50000 {
 			compatible = "airoha,en7581-eth";
 			reg = <0 0x1fb50000 0 0x2600>,
-- 
2.53.0


