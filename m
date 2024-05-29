Return-Path: <netdev+bounces-99052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C958D38C3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513C51C20D36
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E21D6A8;
	Wed, 29 May 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p0IsSdNg"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF731CA9E;
	Wed, 29 May 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991781; cv=none; b=DnHeLf7VQ0bdZmLX94fjiW4vdTwRsXgwtl6eWrLniRM3cLN/pCQj+9VASA0UMMr49G0bFY4zrNqBXsY1HP2BRDsg7/9wFr8SUSr39vEhpCit2YiFvubJM3CNMwv2RKYAdzWfZBiYYjY8WJFE8HqFJ2HdeyvDzGVFqK79u44fywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991781; c=relaxed/simple;
	bh=6RKhsjylzAiRwIo2wwjLgww6LdH42VeDcjmrpc0rXsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ug9Ky95xfYdg11ckbFke8mLJ16kRuNRJVsQdqIawA313XlvIWwKyGHSaAJ/OkZvEdV5u542P3GDS1V+mHOCIyql8SZC0UdNvcRk7Tqpz4tUs7ILqmJEG2Qdqchp/2NWa/mbJfGyggfVdPUhkzpBT+Ftoycth6wxUJKARaEipYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p0IsSdNg; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C09E340003;
	Wed, 29 May 2024 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7W8ecLudPpFqSbJRrJMLaE+hJjxzBDOvmHDTYNwekL0=;
	b=p0IsSdNgW2U11l1ihWyP+asGoPBxFTkFCURBWvXZVSTU1Ijxyx+EG3b0RaAWff+tnFe4NJ
	PGyFMZ/HAGfrNiSGZMr2rmg8oyZyUePFGQYK2vGYuRPFCYor/Wmkp0+2UcOqg+iUm/Cc3N
	MBPbMYLh04CSY0hVeGXjYWfbsIKhbS7aHmWMg47UpGCJx0YsrxeHzyV6GXhhQMUoVRanUE
	GVRTb966fFwAZzcbkzrcB8hKujx0rabAThxA3u5IZRr1shTMnN1l+fY0ESzsZ1YGSE1v7o
	a4figyPqPm9LbE0CnTap9EgxMGdRgZD7fhfWIqhD0aLwqa5GsCfp5wQhewZJZw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 16:09:28 +0200
Subject: [PATCH 1/8] net: pse-pd: Use EOPNOTSUPP error code instead of
 ENOTSUPP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-feature_poe_power_cap-v1-1-0c4b1d5953b8@bootlin.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
In-Reply-To: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP as reported by
checkpatch script.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/linux/pse-pd/pse.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 6d07c95dabb9..6eec24ffa866 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -167,14 +167,14 @@ static inline int pse_ethtool_get_status(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 struct pse_control_status *status)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pse_ethtool_set_config(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 const struct pse_control_config *config)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline bool pse_has_podl(struct pse_control *psec)

-- 
2.34.1


