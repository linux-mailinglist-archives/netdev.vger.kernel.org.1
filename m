Return-Path: <netdev+bounces-243044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D85C98C91
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 19:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA8E64E1FCC
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55D238C3B;
	Mon,  1 Dec 2025 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Vq2yUfPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56021C8FBA
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615538; cv=none; b=RfrEMddVgDlfrQ0PWJYmM9bvgX/Y7d9pC88IyDSViRYaK2zMjY1nBK2v2Ckv3+pyIU92WmAsduybs8YcgLZrqH0iodhE3/HUygKyJOGLsiXq2h9lxjqyyFwLXqKH8JArTHs7nVvvFEKQp1aMLsHRjGS+HclJDA7K0g4+/my3Tcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615538; c=relaxed/simple;
	bh=UI1VewAiM633aztJoxnTHBvOFdsA4iIED9tYM2JR68A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRWKKBanKiMCztVJeR5f08wkLrTogl6F/naOXe5Y0i593O1VB6+Ttyh+hW3tGr987rtuNGcsAjIGAfu1KB6JP5MJquLsL6/XBpzR7creajKAvGkSqETI792jNImAlTyKelZ5+rOhlfYvvimo8Cn6IvLj4SMUpOKrSYjaJ1Hqecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Vq2yUfPc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso5228808b3a.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1764615536; x=1765220336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqH/ONEPv5Gjy+JhHOyryPQ0gBAqolyCf+4MHSnzJX4=;
        b=Vq2yUfPcRIS39KHfhW14pbQf/zugQustkp3OF6guRY6ThwyBNGqERVhFYC2j3VvYyJ
         n7JRrFKfIuy5ZqhDQ3qjA/OH+dPqSpJuAd+GQJ/L/xh1FGEpQUz5J00xk/jJoz7Qcato
         L+cuFsIMyS/g835npOAHOmqStYqmLMXyeq+s8gqIC2KbE/MMnzzhU4HPmxMwceooZJ6/
         3H/iNUlTr0FGx0RdDEXCjTdOxrp4gca8TR79lqpkqYA5EJi2aDwiKdsf57Iqe6sRLI4Q
         hISa5MbnRjhUe1DVcPicj7NcWSSKI+GGYCu2VS9hh93kD/Msgb3gNgtHu8YgRowtZVak
         1hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615536; x=1765220336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xqH/ONEPv5Gjy+JhHOyryPQ0gBAqolyCf+4MHSnzJX4=;
        b=EMc9PEQCaaXzMU4+eFyECtAvQtWuKIeBHLfaSHMm9gvD8YsAddaf8fMV3TYSHnNcC3
         pVSyrUiQrFFjUHRjFV6q2AA3fwp+gfU/2AV8ORvc3HBNS8+v+s5VebVpgkvZr2ilr8mE
         x/K9yHhH3bSzigBgo3UUILd45R/5DEfBJxKzniZE932QBeTxabcb1RdsT3fgg/FmEGQO
         CQnYBfXt7hEVHI1hYMNrqXXIamld+dLfCHnKv9HCcDnADXqShRB2O7FG+wZmKe2CRobP
         tK+zSXHztVRV4bByX2p49kLHGoPq7f6tJyyyfqWB7h+U8DbrRGPF3THH8zxEkaLnAanL
         868A==
X-Forwarded-Encrypted: i=1; AJvYcCWEjyu99CPAJUGQb+imPCN0zQsM4/7hWaCDmnG7c3vIGGV4LpTw6W13bWgIhEdnTLzRrhVUtGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcALHd+d+w1BIZxYRAaxSUuzxK+vxfCtGBDpP/AHQJ+NVQbnNN
	crGXiE2c6YLsXbKmRnyw1n4MkJb+Tyy//3o08w0wX0VcZtghkwaznkgqdGweHTbXMQ==
X-Gm-Gg: ASbGncsqyny1K8bQbtuqsq8XeqhlPuCxdG8JhV2bOx2oBR7MgRfk2pkcKE8OQtOuE8j
	OrZwQdkctIGJRjHr+jUl7EaS1t4WpkkRRXemh2lO5CrXMB+/zIPZSjFuQRgha5M9lNckceAidHs
	rjwh7bih0Up4dXYRISQofl8ksptKMDge7enWgYg/bKp3krq7N33+xlCyLh6trF6MpwqdmzISXZf
	yxsap+pdo6asFRWfVVf1gy80F/2yiAFAkgfe6C8LNS6FU2ilM1Tbxvr/VYJBM+t0gj9SVkeEo2e
	wsAQmI4CF958p0Ve3Lr3n6r6/UwS6riZ4C7wTHXfEdD2OEIGTBWt4LDlqi8zOysPYAV70C8ynaO
	f2bKFFcfuTVVj1mykVxTknsCl0ClnHpCEyk+m6zRRc1+vU9z7ovv+bngl3k+OTXwtX3QMr8Wmyz
	16ih8Bk1xtTtPDVptZh1epHTDF1jDzJnFsPV5Naw/b1RviT3PRPU7aT/ce
X-Google-Smtp-Source: AGHT+IGgeJpHOvuUk5uwIzEkFAdNrP8FOQpLryMnqTgQuZWk+G1MXtwtN/CfDJiinsn6QhTlDK4Biw==
X-Received: by 2002:a05:6a00:1482:b0:7b6:1c9b:28c with SMTP id d2e1a72fcca58-7c58c2ab14fmr35455651b3a.5.1764615536125;
        Mon, 01 Dec 2025 10:58:56 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:14e3:ac6f:380c:fcf3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1520a03a3sm14522852b3a.29.2025.12.01.10.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:58:55 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/5] ipv6: Disable IPv6 Destination Options RX processing by default
Date: Mon,  1 Dec 2025 10:55:31 -0800
Message-ID: <20251201185817.1003392-3-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201185817.1003392-1-tom@herbertland.com>
References: <20251201185817.1003392-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set IP6_DEFAULT_MAX_DST_OPTS_CNT to zero. This disables
processing of Destinations Options extension headers by default.
Processing can be enabled by setting the net.ipv6.max_dst_opts_number
to a non-zero value.

The rationale for this is that Destination Options pose a serious risk
of Denial off Service attack. The problem is that even if the
default limit is set to a small number (previously it was eight) there
is still the possibility of a DoS attack. All an attacker needs to do
is create and MTU size packet filled  with 8 bytes Destination Options
Extension Headers. Each Destination EH simply contains a single
padding option with six bytes of zeroes.

In a 1500 byte MTU size packet, 182 of these dummy Destination
Options headers can be placed in a packet. Per RFC8200, a host must
accept and process a packet with any number of Destination Options
extension headers. So when the stack processes such a packet it is
a lot of work and CPU cycles that provide zero benefit. The packet
can be designed such that every byte after the IP header requires
a conditional check and branch prediction can be rendered useless
for that. This also may mean over twenty cache misses per packet.
In other words, these packets filled with dummy Destination Options
extension headers are the basis for what would be an effective DoS
attack.

Disabling Destination Options is not a major issue for the following
reasons:

* Linux kernel only supports one Destination Option (Home Address
  Option). There is no evidence this has seen any real world use
* On the Internet packets with Destination Options are dropped with
  a high enough rate such that use of Destination Options is not
  feasible
* It is unknown however quite possible that no one anywhere is using
  Destination Options for anything but experiments, class projects,
  or DoS. If someone is using them in their private network then
  it's easy enough to configure a non-zero limit for their use case
---
 include/net/ipv6.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 74fbf1ad8065..723a254c0b90 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -86,8 +86,11 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination options. By default
+ * packets received with Destination Options headers are dropped to thwart
+ * Denial of Service attacks (see sysctl documention)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 0
 #define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
-- 
2.43.0


