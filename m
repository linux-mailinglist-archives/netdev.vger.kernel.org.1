Return-Path: <netdev+bounces-231908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D86BFE761
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC3D3A53AC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64CE2FF15F;
	Wed, 22 Oct 2025 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="ryg89jSg"
X-Original-To: netdev@vger.kernel.org
Received: from out12.tophost.ch (out12.tophost.ch [46.232.182.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6120B7E1;
	Wed, 22 Oct 2025 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173922; cv=none; b=IMUbq+ABngNvLBVc5cqSce48ap24WxVbLexl4HcG8N4kLKigtQdp6UKf1axiB6By8um6jB9VHldId6v6V6kIcF1OFL6jJzx9ZtQyVW+3/NOFykHNxF0b9bPgu2BM7PSHas73sFOYMw+bNqw0e+EJFAnan96wWWnCu8aZEiByxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173922; c=relaxed/simple;
	bh=KsLICYSdai358ng0LbivT+XEiH/kal9SLt5IS1MUsRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m65Nih4OgJ+LCmpapbt4jMUZpBsWFGfI2df2Z1Q+MLqjFaNhuNIadDt7VALennwSSOFPuQTW4X7zMTGHzxDWQgzvm0ZjZOUe1CvKIyciOFqpFRyeI6YZ/Mis+JNZo9BH9D7N9yIZVd/nhnT51GOjgSPWfQCmYLQ+U/S8CwDTqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=ryg89jSg; arc=none smtp.client-ip=46.232.182.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter2.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vBgyW-00CosU-PH; Thu, 23 Oct 2025 00:06:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MCaTi5+1GdvtDvu93JLcxGyOsiwEWFfOOZdGKf+f5WM=; b=ryg89jSgYjRXtbMp71nffVLvF7
	bK+XtBg6dOPThYY1dvOoCV5873sAhbYD7peZNxyHNf0YlplJDSvre1jZAe7jVaCWTIvzxh4HDEFch
	3pSXhbY8LQlE5ZKG5N2O75oVzAZbdla3yd0qDnz7X66LqVXIuHOeyUX8q0YZUiqeVV48na4bnLamk
	eHGqi9Dv29wHmYC9ibVz7Je9eHBPi7qgqGfoWe8QTcc/aCAgv8UxSYyLiV7FL54ytVBAb4P6WFrJP
	rqMcde6y3hGnM+3bqqfbeJyyRnDePWvdl1SCk1aBd9KKjHuIjwVKXgJ4lmQMw6V1ZB6rRZ4fNHqJ9
	1Di9zXLA==;
Received: from 82-220-106-230.ftth.solnet.ch ([82.220.106.230]:62831 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vBgyY-0000000APCP-1Fe3;
	Thu, 23 Oct 2025 00:06:32 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Wismer <thomas@wismer.xyz>,
	Thomas Wismer <thomas.wismer@scs.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v2 2/2] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Date: Thu, 23 Oct 2025 00:05:20 +0200
Message-ID: <20251022220519.11252-6-thomas@wismer.xyz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022220519.11252-2-thomas@wismer.xyz>
References: <20251022220519.11252-2-thomas@wismer.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV5syPzpWv16mXo6WqDDpKEChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zC9N
 dw2t5iMEflZxRNqEOiZKZR2tNRPIxp/vINc/oXVUCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYvkfoqFqk9QphLZk+yqk+tIzthz0vNkOX8Em4cj6D/wdR983ISMXlZYfkTQnVvsLb89W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoanVmeCF7bI0BP7dENKtPTBPq+vGO3Vx+SwwWschmkdvs376y2A4
 OBi1/UyqO7jQnnICeA+KlS7G8xqewTcs6w6HLg3eq1lKkYVFbZT99AeINpdbOTIWFiLv1jhppNXa
 xS6MN8xFxlxHZge6OlcoYA//qN5p5dmu6xjQN9nmCfj7VmpmZJyx9iy0UVkVD75IgLollI+8fg4q
 Ktu8I/h2Z0dHZM6qE0STp2v0JiRE8jha5ZR/nf5efcITxrfNKzy0W9Bd37g8M9SCqD8uOq9nJ+Mm
 AyVp7BgHET6y8CCeFlQ7QPOIjlkSAfAYMUguLL/iJ9vYqKPILmSoZcvfXhdPMA/OB6L3DS5gd1SE
 E3USj80Z55NePwA7jxwlhcjVdk/mr85ytrd63MVeviF0i7IZfcqGEigUra+zu74YMVqBb/nqBf/o
 O9ENx2nriip8WhgYbnEnhEbOEzk5yB9ZHNSFnOX3WOuu10rVtxDPgG7Vtev3VUWM7vJdUMhhfiBi
 T4p0qQinxQdAM7oWNvokRStU21kywDQw+mt8yiYotxY5kTqW31/E3ahF5MMcDI7KdpjQKSCN+J6l
 bGev7o3ca3HK7nAdJ4O6PN0m2d+J9ACj3NF3yf2emCiQ6AuTowflAWn4v/afTNuGqIKbeT3Q0BtD
 AboBIkUL/j1Y48GvmeURQjjEeKVXbbsuQxCT7KwYHrWmLbItcTNXm2BdnEVFmeo/ena0Plo1EUkF
 Ir9EYAa2pWQkJz4RQfBVfxkAwoVpA4J/KzRZEq6vMKhJ9oG2v1yvThzPEGEatp9rvw0eoI0HqUDY
 Z5lBVqqSQepN0b2sqifLOj/1zwA5Elj0L2+pr2KRBXGwDoDEJrayfp9Tsh2+VPTlRNFzmCOqbe4N
 XpcflqR9TOt4m7skVkCUrb1O+GFi8/GtOCoPdeOKuroIXJBF3iBhveOWAg2/DdpIH6kX9BAh5T56
 bZ65fgYTpVbNpCTXfzY/9c8AORJY9C9vqa9ikQVx1Rhgh1oSgTV2HRO5RU/ccaLd8PL+e7kGwNtP
 GEbZHUTlo9rdeDz1q6e5q9bAUPzG/Nre5J0/CRkN14v1yHfTQHe0DazGWAam0o2Vp5zQ/L8xL7hr
 JSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

From: Thomas Wismer <thomas.wismer@scs.ch>

Add the TPS23881B I2C power sourcing equipment controller to the list of
supported devices.

Falling back to the TPS23881 predecessor device is not suitable as firmware
loading needs to handled differently by the driver. The TPS23881 and
TPS23881B devices require different firmware. Trying to load the TPS23881
firmware on a TPS23881B device fails and must therefore be omitted.

Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
index bb1ee3398655..0b3803f647b7 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - ti,tps23881
+      - ti,tps23881b
 
   reg:
     maxItems: 1
-- 
2.43.0


