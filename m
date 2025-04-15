Return-Path: <netdev+bounces-182979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12986A8A801
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BDC44429F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252A250BFA;
	Tue, 15 Apr 2025 19:29:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6432505A2;
	Tue, 15 Apr 2025 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745361; cv=none; b=Q6BlEazSIB8RU2zqAHL5eIkDTwmt2+vqkLZo1dvnpCCVECRm5NB1WxwqbPXWXpnapDwwIxT2Yf1xZFBqz4iLtqhBNkDnqyZAnBS+hJmA82A27CNDavWVzZDwhuSa/GE4mahr1E6fci7UcCvLj+CbbEsksi+ebdZr021NIq0cJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745361; c=relaxed/simple;
	bh=nxywYiBmzJG5ZGAgxVmCJ72hCLXBd9nxLm5C7qQo6Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhR0F2gxBJW/qKIG+yJNmD4HHo6orWF3lac0l5cd5NHYp3MWszOo9VeZ51qqz9yI5iNyhMPzc10ov3tCDAkovrZGu/GhUHoPp3EvYDY29WJvMZntDS58bGdgqlOV0aHKQpVX953ckuIcYeGOU5qqSZ7zgOmf2UvVmdjv2sKSAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac34257295dso1116056566b.2;
        Tue, 15 Apr 2025 12:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745358; x=1745350158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHWnoUY43/CNyBqqCrApGuqRk6IM6iTEIgL8pI3dxvk=;
        b=Xj89HvT1mt1gfbE5jYSx+rNMv/sfLB2EV3/sw3SarG/h19WAyBcfQ07oZpMZbBG2rW
         Wgk22dZHMN/BhX+1pq0dc65ezGZuOq9TNEfXvJXrPVF6OzipMBtOLIYkk38aqnXeTqAr
         ZGf1Y01Muemr6P+Ztdmzec2zTiu5akyW+JxxM9/I4NoTs/wcjq8Vs64Hofx4DcAstVGM
         22j3+Y6doU+TqH1454GjHUyBCOR5fXBJ0AkoSWwvQMQQJH+BIrhvwnnUcD6UVbqp+NiT
         GN3Vu0OHumCdzBsD9K39Sv+Qe9tYN/VeDQQytYCYsZIRxhbfWOTeMtr22zlukM39sxqp
         RBPA==
X-Forwarded-Encrypted: i=1; AJvYcCWsEPsyAvtDEVS6hm8NWbmJ68fBVtGR4jMxxO63cx81W57JDwjD3p8BUz+Ti0XyI+3wyTPvpJ9olAryhyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbIxvyQiET+SICUMTMxHDr9bFjcPWUFvSpG73JCKNZPtRMIBP
	yEVpe44B8JiLaKwXXcFf7Kdb1222qDp8nrumaU7jHBBZE/DP3vgK
X-Gm-Gg: ASbGnctZK2L0bYvpZpzFq2gXTaKpsKQOSb1qK55xLEIj6M2v4mGRLoV8CabNDMZtz3V
	Kfbdp4I0oG2T9o4SA2rcE3zVVu+7/Nhcxe+zfWtoGo0XqTxkns+GuVAse95sryxT9aUaAmcQdyw
	hpu89/SYgg02/ul9iO+er+6TQsJ1tjX2HrtKuGjIbPZXg8aYGwhssoXlcHd7EJuUUs7KYcOWZIL
	XpongQBhmPs6v0eFIlac/0r0ZeKihizlmDqn+Lm4ww/o8VPGolLB+YwyoUeM5eT4JydapjVt29s
	0wEnMQAUA4qGIPaoVEi955m7PDCOtSA=
X-Google-Smtp-Source: AGHT+IHXvSST23AOisF6PCSUFeiGo1ABusCZDQlLyzYOKYYSG+1TllTheL4d6IdTPg5SS20H31BbRA==
X-Received: by 2002:a17:907:3d0a:b0:ac2:88df:6a5b with SMTP id a640c23a62f3a-acb384f2e24mr29995066b.42.1744745357779;
        Tue, 15 Apr 2025 12:29:17 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb40c0sm1161278966b.109.2025.04.15.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:58 -0700
Subject: [PATCH net-next 7/8] ipv4: Use nlmsg_payload in ipmr file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-nlmsg_v2-v1-7-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784; i=leitao@debian.org;
 h=from:subject:message-id; bh=nxywYiBmzJG5ZGAgxVmCJ72hCLXBd9nxLm5C7qQo6Lo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOCtcfJVayR2TnwIdRVp8aA/WIa53eYQnHV2
 73nHprv6OSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zggAKCRA1o5Of/Hh3
 bQavD/9Z7OEeGshFbdqTn9Kya/6/7eClmtdLOu/HK+QjhpHwRgAITExI8EGvQ2O1ehMMOOtikWe
 XXDJWtvu5x4yc6Vsll0xcDmRL3PvXYPJLW5eN4Y5YE+cEDGhac5adEPYDmD0ajk87LRfV2Z6jxu
 FVmynsTvTnsYDK14HjmAlZPBJ6rgFcdHtb4Fs2a4C/sRLy+FQq0bQZPdzfEMP5Ku3hckqpw/QC/
 bCkAeg3K4yC58yhXWaklmYZ5XAML9UR3ZtFvPuTnyIH4U6bAlO1HLJ3CCCEBeFtqSG3cmXfnNjl
 j7vFVFpzTfuoSL9po04RGpPWaABc13DBfPTN0EHXlNJd8QGPSFfYBb6iYoUGMFqYtj78QVOh5B/
 vzGP40HyAKG9IM8EsV+wQ4iGjGCkJBjnC7rGiDZV9jLNlbYx9xbfyUyRAdEDt0REjC0KtFGbOPy
 QPb490+wa89e/DlLSZbahKNd6vrqKrauIuo6kJ/Mf7o2TTBeAbddCYWAMjKeq3gPidoBRuLNgTp
 vya//PDjibtGghhEP5Fq7nvBYBu4bi+22T8j1PZMeCsG4nd9LqKgW33q0f5xk3x5lQTkztA7FzV
 +kZOcM77JoIAqb0K9amEI6kG06n1MMcUYrHeVOzISZy/XQ0OcJnHsRiVDEuocrOtsA3Hqg1ULHc
 fFiD82XR8PhRfDQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/ipmr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index a8b04d4abcaae..3b5677d8467ef 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2511,7 +2511,8 @@ static int ipmr_rtm_valid_getroute_req(struct sk_buff *skb,
 	struct rtmsg *rtm;
 	int i, err;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
+	rtm = nlmsg_payload(nlh, sizeof(*rtm));
+	if (!rtm) {
 		NL_SET_ERR_MSG(extack, "ipv4: Invalid header for multicast route get request");
 		return -EINVAL;
 	}
@@ -2520,7 +2521,6 @@ static int ipmr_rtm_valid_getroute_req(struct sk_buff *skb,
 		return nlmsg_parse_deprecated(nlh, sizeof(*rtm), tb, RTA_MAX,
 					      rtm_ipv4_policy, extack);
 
-	rtm = nlmsg_data(nlh);
 	if ((rtm->rtm_src_len && rtm->rtm_src_len != 32) ||
 	    (rtm->rtm_dst_len && rtm->rtm_dst_len != 32) ||
 	    rtm->rtm_tos || rtm->rtm_table || rtm->rtm_protocol ||
@@ -2836,7 +2836,8 @@ static int ipmr_valid_dumplink(const struct nlmsghdr *nlh,
 {
 	struct ifinfomsg *ifm;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+	ifm = nlmsg_payload(nlh, sizeof(*ifm));
+	if (!ifm) {
 		NL_SET_ERR_MSG(extack, "ipv4: Invalid header for ipmr link dump");
 		return -EINVAL;
 	}
@@ -2846,7 +2847,6 @@ static int ipmr_valid_dumplink(const struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	ifm = nlmsg_data(nlh);
 	if (ifm->__ifi_pad || ifm->ifi_type || ifm->ifi_flags ||
 	    ifm->ifi_change || ifm->ifi_index) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for ipmr link dump request");

-- 
2.47.1


