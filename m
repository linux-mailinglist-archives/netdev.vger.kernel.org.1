Return-Path: <netdev+bounces-108263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972491E8F1
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E681C218DD
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F62170858;
	Mon,  1 Jul 2024 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="c3OdeJVY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4061170826
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863737; cv=none; b=H+nWhedf5EclYLGQUqyVvcqjzN424OkH5uZB5JL2U2OZcyp678fz13cprD04pvD8ygPKiUbhAroCntDvuUXu2j2RLs0cSETGW2X/bR0BeZwwrBh05hlJIpAf57CeZWtk5SDIsdF9NLSoQEVmi5ao3S45dCiYkMKQByp/TPCE0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863737; c=relaxed/simple;
	bh=GZ98B7Q28bj+vvHAshJE4H1aoAeK0Hw6/9KepOq/cvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfPMiWAkgG+CStUFZkqwg+uGxsvKZLTyKx+ruFfmYIIypBoi1bBoz4sKejnLEoACz4bPhLEKlBrUfx+KKNDKbLFqQtgdwX6y84v/YXJuLyzqTegPJwPEildnC27YjJnJ6iPDyfwKR1LUe9Jt7yP+53Eg83yt29eIVvcfQ9UYpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=c3OdeJVY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-713fa1aea36so1258688a12.1
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719863735; x=1720468535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/M6v5lKpYaQVZGJ17bh1FRQoB9KGM6O7+m3kCZRwhk=;
        b=c3OdeJVYpz2WTKQgLqgYF9890Zrjy+zPk6Nsm15BwZVOJg5O5U86GwanqysfgKo8s+
         LrzigfyzSx1EqIN8qFMDfegzEypGKiboCXk0iWF+7d48wlS2s+RiKGjtH4osQfR/w12w
         EkMt3xxxJ2Ip6BWgJrtM5nfX0Sb5hcEJ8OgGUePFIXSAFQzxT6FwxT0E88z6b/lUhZKh
         T9iELburS/RPWz3xcYWhjXO4IK3rqRQTYmbfv9XqcObCQEu5UsCpjWdsnf3zLDQbo+Hu
         WR/dt85ulzjWOE350R4Kd5FGOoJVn4jDmVfVKs82+S1lvkyd4f1BitZgWQdS7KukAz2+
         xeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863735; x=1720468535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/M6v5lKpYaQVZGJ17bh1FRQoB9KGM6O7+m3kCZRwhk=;
        b=aLqtAwPQwykPJcpr4u2wZoStEE5y5Bx46wYqD5RtvXuPKmeEhB9eqHPy51PwSgTkwP
         4jrJSGKyfM8p4Yl5O9ikUX5nveW+87AgvnxDEgPPlGgFaj9neRtsjJKuFt13EvA1VfIi
         uYna309kb51p6aAKzLbzIT+KsJbVVJ9ThKq8aofMI3+B8gKc/ptvRM8wRnuDh4Pt4dlK
         rWCR55G/SM9bCHZ1NPBQED6jX03KAP6kos9qRhvY0Fv0Yhy8+u+yIOF0sNOS7oynUKHc
         WR7bj7pBGaEKnilk7OoA0285exp0yH0xFu2mSiCOpzCvHwCePZOvKJm86h43McL0aTQS
         yvPw==
X-Forwarded-Encrypted: i=1; AJvYcCWNcIAJCkEkEMoQe/xvtrE+OkmGKzRB4WOrG0xOrVXowO/kzxmmoAS4THVAJvaKkqGdOGD9nudrYtchS2dO3fKgomedHXlN
X-Gm-Message-State: AOJu0YzuMCh6Eu1pQMhenHKFMVryYw5nWq1JpffwjOzTV9mndHfGYp8x
	YW62Ahp40qgZYPjiltFECSp1YC74Aw0ZD2Hgy0WgEhv4+FMl4LmpsoBqwELQ9w==
X-Google-Smtp-Source: AGHT+IF3YYs3j5ljp4XUT2xe6XlmhrEizM4rqTJKBPqozlr5ykr4P0K+b5D/ODHTY8J6YOiMeGTyaw==
X-Received: by 2002:a05:6a20:7344:b0:1bf:d46:a6f6 with SMTP id adf61e73a8af0-1bf0d46be35mr4107296637.54.1719863734921;
        Mon, 01 Jul 2024 12:55:34 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:56da:44f:4289:b808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm68785155ad.273.2024.07.01.12.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:55:34 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 2/7] i40e: Don't do TX csum offload with routing header present
Date: Mon,  1 Jul 2024 12:55:02 -0700
Message-Id: <20240701195507.256374-3-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701195507.256374-1-tom@herbertland.com>
References: <20240701195507.256374-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When determining if the L4 checksum in an IPv6 packet can be offloaded
on transmit, call ipv6_skip_exthdr_no_rthdr to check for the presence
of a routing header. If a routing header is present, that is the
function return less than zero, then don't offload checksum and call
skb_checksum_help instead.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 22 +++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c006f716a3bd..b89761e3be7f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3296,16 +3296,13 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 
 			l4_proto = ip.v4->protocol;
 		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-			int ret;
-
 			tunnel |= I40E_TX_CTX_EXT_IP_IPV6;
 
 			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
-			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
-					       &l4_proto, &frag_off);
-			if (ret < 0)
-				return -1;
+			if (ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+						      &l4_proto, &frag_off) < 0)
+				goto no_csum_offload;
 		}
 
 		/* define outer transport */
@@ -3324,6 +3321,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
+no_csum_offload:
 			if (*tx_flags & I40E_TX_FLAGS_TSO)
 				return -1;
 
@@ -3377,9 +3375,10 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 
 		exthdr = ip.hdr + sizeof(*ip.v6);
 		l4_proto = ip.v6->nexthdr;
-		if (l4.hdr != exthdr)
-			ipv6_skip_exthdr(skb, exthdr - skb->data,
-					 &l4_proto, &frag_off);
+		if (l4.hdr != exthdr &&
+		    ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+					      &l4_proto, &frag_off) < 0)
+			goto no_csum_offload;
 	}
 
 	/* compute inner L3 header size */
@@ -3405,10 +3404,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
-		if (*tx_flags & I40E_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto no_csum_offload;
 	}
 
 	*td_cmd |= cmd;
-- 
2.34.1


