Return-Path: <netdev+bounces-118999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C60953CDE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2948428713E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396015445D;
	Thu, 15 Aug 2024 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="RTANqz+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3315381A
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758377; cv=none; b=Vh5QQV1lw0La1jnm4QZsVvLRGeIjQqv4TkudhMpB2YCMiLTUhe2P2bx3Zp0Jnb+j5QQWqG/i3kwd/a93lXkw9DM9LpneXfRrUrDHhUv2YbwOMvWQ4InkKFyu65MQsIEQJ95lSLR7DmxiK5v/xzFxTdVYSZ/dUOcwtj993MqFZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758377; c=relaxed/simple;
	bh=UBnlbylDQiGGFqb824hJ8LOfBeF2it/cgHiViI1JVBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWp9DYvko/3i29euAo5mFWb8rOFXhz8qFFP98lX0HgfYFBlTUDXmngX4+Cpwe2fegrx3r8zszZL/rNGnodmZP5rLcpsnzGvCv3DF5OKHZyPN/IhR/JU3oMaD13LcFaZInIdG5aXeNTFTqjFGDX1rnhkoPc76BGJmlxtm5l3kDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=RTANqz+8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso566504a91.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758375; x=1724363175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f2VEr48rqS/xVUGYX/zdpL28CXVAGtsS1olIt5KoRY=;
        b=RTANqz+8mSqAebiXiE57zKg/4jxXcdRtzkeLGiHzrye8VN1LiauEsp9kWaFoAM08ER
         UwRQrURLrkqpxg38ViBhKkheFUsF4cND1vz4GqUhJ3CMr43bPflumPIo5YR8CMDCxnHa
         +YEdthpqMI2V4B7zs5uQ4FImaUTc2/NA9M0YwDlGNtRgI5u0KLmo+y1TgsX3SNKwB3zS
         0+uGduep0U6OBkc6XrVUfDIhTbLiFR4+IeESRO0w994FijiL4WMoFRoXOV33ppnGFwwM
         jj95yG8avDHHrGBFQf2OMZvQUeC8GZjh4g/lWEiGkLPz9Uvskmtg7SREeN3uIdJpnRMB
         YEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758375; x=1724363175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f2VEr48rqS/xVUGYX/zdpL28CXVAGtsS1olIt5KoRY=;
        b=ZGWr1nniOZFdawAgVpmEZxIDXBYjZfLLmdZLR1oxjBLinE7cTZ+tUkj12aNeXE/Us6
         N3PllBsk+u5b4MbJ7bQ/qKSa5/stT00CElJgdHKVy5sgpEyqO2vDDF8B4gVEAaHnPXhh
         SodX7H4MSpbuyVEO3HyfVlPH+AdgPlLfqweiE+9XMVU87ok5A3Mo1IqBaejTEc2jhLd9
         3y372rsPjlcmEv1wl94GSqPgGfuhvg9REfjvK8V5NsiqVESrSBUFwgVD6RHPQyD+z+/r
         yohrxzoADiJcUJVtv+S42+McR4U43H0jLYE4rBhyeFabrJVpDYGg6XQ7XuHusdDMElXA
         xPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+8XgjBP8nMwMldeAvVVyd0X53rGEfiTCbMiRrnoAJoOpeojz26tbjaoHvREpnkJst7nH/sAux1k/aZoz5u7NK37oI6nba
X-Gm-Message-State: AOJu0Yx8jSxvSuQ10jrMIG8InuRm4Ji0BqU0ExB2EjqjOy/SCuSwq7yq
	09mFslxPBrsjIPdEXgx4OMu3F0+i1JvVv/rmihI9zOBQph89dvuxkuj/O1ZWkA==
X-Google-Smtp-Source: AGHT+IH38zZyVOwq3xvlSO8GAw6H4f9Q7vdPuONKGe+qQAIILL+/EILHrLuKfnyzg+isGH+UU+2Hlg==
X-Received: by 2002:a17:90a:6d89:b0:2cb:e429:f525 with SMTP id 98e67ed59e1d1-2d3e055f018mr1088797a91.33.1723758374702;
        Thu, 15 Aug 2024 14:46:14 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:14 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 02/12] udp_encaps: Add new UDP_ENCAP constants
Date: Thu, 15 Aug 2024 14:45:17 -0700
Message-Id: <20240815214527.2100137-3-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214527.2100137-1-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add constants for various UDP encapsulations that are supported

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/uapi/linux/udp.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 1a0fe8b151fb..0432a9a6536d 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -36,6 +36,7 @@ struct udphdr {
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
 
 /* UDP encapsulation types */
+#define UDP_ENCAP_NONE		0
 #define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */
 #define UDP_ENCAP_ESPINUDP	2 /* draft-ietf-ipsec-udp-encaps-06 */
 #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
@@ -43,5 +44,17 @@ struct udphdr {
 #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
 #define UDP_ENCAP_RXRPC		6
 #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
+#define UDP_ENCAP_TIPC		8
+#define UDP_ENCAP_FOU		9
+#define UDP_ENCAP_GUE		10
+#define UDP_ENCAP_SCTP		11
+#define UDP_ENCAP_RXE		12
+#define UDP_ENCAP_PFCP		13
+#define UDP_ENCAP_WIREGUARD	14
+#define UDP_ENCAP_BAREUDP	15
+#define UDP_ENCAP_VXLAN		16
+#define UDP_ENCAP_VXLAN_GPE	17
+#define UDP_ENCAP_GENEVE	18
+#define UDP_ENCAP_AMT		19
 
 #endif /* _UAPI_LINUX_UDP_H */
-- 
2.34.1


