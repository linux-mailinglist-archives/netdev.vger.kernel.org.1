Return-Path: <netdev+bounces-216938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4213B3630C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2868A3F0F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2DD34A30E;
	Tue, 26 Aug 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VxGvECl1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmlq3ilp"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079A134DCD4
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214232; cv=none; b=BWEofxaNXR7Q7JqAs8DZTBXFQHz6acUqGcutnoe9NKt7aIlddZ63x9ZL8eKcFd4FOpL3whlNAHT1GL4G+Db97EUbZ7oSR7lbZAZp3ilu3qEmjJF3stpc1qsuZUeegffV5GrcUUSWmEqbWP1+ijnmxrxoG5EwX2fUXQI7n0uTNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214232; c=relaxed/simple;
	bh=j/OuYAZEeHhlfrji8Ak94cl5gpMTGNvvbIClbj5VUCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCxBHHnATvU+Gjywba4dDc+OsbVtE8lFf9gd2W8UdXUQ76U/RjV9M1XfAjbBItRJwrqobc7rBCaldmgT1S/dlEHjj57uJlPuye2jNd9jwSRdkUDa5RfXY9wRWnokZohtRJOo6ZH+1CU8hCK4TSHPT8afjxLdjjku5TgNEBdAbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VxGvECl1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmlq3ilp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A4F17A0158;
	Tue, 26 Aug 2025 09:17:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 26 Aug 2025 09:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214229; x=
	1756300629; bh=oB4omMNHPzDr8LcfG+VFA62WLfIxWqYWIEBwasSnJfA=; b=V
	xGvECl1tKgFHZfvjL60HkBrD+USULWWSlcZsO3run00DnRh1ZOAJ1cHuKhr5HhIe
	DIsYSRLqsEM/tPkiDOYqAQGlIEvh2ZNGEvFlQhZdHD2TfVAouqiYKkJj05vvgWuQ
	E36dTKLvqgIOKiH6bxfHtAbbFIIS5Q/AS50W3tGr9iLHOcsam8qyUn6v6pWK+kcb
	rAQcfKcTby2pqpb3xQociGBJCd3ORnbVw6Qibg4MYngx8ssgn1Jc3BTCLJtfbeZ7
	UAXfyQ38TdNne2tj5YMpdDIwkmYdSCbpQz3p7p6enuouviwIfrzH3xuL8ZdjUMVA
	VW3Kt5w4a9YULIA+dQL+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214229; x=1756300629; bh=o
	B4omMNHPzDr8LcfG+VFA62WLfIxWqYWIEBwasSnJfA=; b=kmlq3ilpGljmcqPpt
	LToV9alRWNQTg5N8PSNJVfV72qo9zsw4MGOGJLGT1MIkemNCbXcUdqa1845oZ1Hb
	ZOm9MdL5sTZeh+bNqXV0elBx5ix/TAsLWsAxMUlzjizX6jZO4Mj+22NfFWEeNRoq
	VFOKZyhJyek3XcMaBi6NvTHdf7PzsvD0XHbg3qfz4QG9fLKDsnBb0bqvwgAcRrDN
	0GqIoLBCYD6wopb4ik22ypM6LzSw5G3T7nIJgAGOAHbE11SGyjpQN/tiwSR+HMqi
	pTnyZZd7pEHIhNXxfBOrPzjT4E1eWoSD8stBbObJKNxldVp0nYjYDGDC34cIezbC
	yoblg==
X-ME-Sender: <xms:1bOtaKsz_V6f6qMOX_2jVNVkSG7bYM51WtafzBg2Uv_hl8IXd4iB_w>
    <xme:1bOtaPqXJw5-271ndXjN5PcQF3oZbtnm2dEGen7Qana7pC6WfmrnhKbCSiYpoe5zD
    d55O9yn_no8_FvDJic>
X-ME-Received: <xmr:1bOtaHmauKcsWydpzSXbgAdMP_Jr8YbX2C3VtsZLfTqoCMLYe4ZgHaKrDtZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:1bOtaDz5tIPU0q9WllTnReV0AMMeuXIvb5d5bwopWtJM20NFU02SUA>
    <xmx:1bOtaPnx4RTKNiZdg1BVgPM7MGiPwelseP2XHmLEzApRDvlW7QuYHg>
    <xmx:1bOtaMdvur47_NFAUku9Sz9Gj61aguy5QKm8uQpRIdI7v_s62ZCB5w>
    <xmx:1bOtaFpZFAVMN5kbN_4CnjXpjqDLOnbA11QE5JM_LBqmcv2V7mfYKg>
    <xmx:1bOtaNRgoHYfCECigpiSoFh11o6w0JKTtz7iWdLT7en8TfSI0kM2bZKN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:09 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 09/13] macsec: replace custom checks on IFLA_MACSEC_ICV_LEN with NLA_POLICY_RANGE
Date: Tue, 26 Aug 2025 15:16:27 +0200
Message-ID: <398cf16191a634ab343ecd811c481d7bdd44a933.1756202772.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1756202772.git.sd@queasysnail.net>
References: <cover.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing checks already force this range.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 463fd9650b31..9589e8f9a8c9 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3760,7 +3760,7 @@ static const struct device_type macsec_type = {
 static const struct nla_policy macsec_rtnl_policy[IFLA_MACSEC_MAX + 1] = {
 	[IFLA_MACSEC_SCI] = { .type = NLA_U64 },
 	[IFLA_MACSEC_PORT] = { .type = NLA_U16 },
-	[IFLA_MACSEC_ICV_LEN] = { .type = NLA_U8 },
+	[IFLA_MACSEC_ICV_LEN] = NLA_POLICY_RANGE(NLA_U8, MACSEC_MIN_ICV_LEN, MACSEC_STD_ICV_LEN),
 	[IFLA_MACSEC_CIPHER_SUITE] = { .type = NLA_U64 },
 	[IFLA_MACSEC_WINDOW] = { .type = NLA_U32 },
 	[IFLA_MACSEC_ENCODING_SA] = { .type = NLA_U8 },
@@ -4260,9 +4260,6 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 	case MACSEC_CIPHER_ID_GCM_AES_XPN_128:
 	case MACSEC_CIPHER_ID_GCM_AES_XPN_256:
 	case MACSEC_DEFAULT_CIPHER_ID:
-		if (icv_len < MACSEC_MIN_ICV_LEN ||
-		    icv_len > MACSEC_STD_ICV_LEN)
-			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
-- 
2.50.0


