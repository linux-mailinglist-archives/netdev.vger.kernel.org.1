Return-Path: <netdev+bounces-234164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6555C1D761
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 22:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5871B4E3018
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8431A056;
	Wed, 29 Oct 2025 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="FPz/K/Y2"
X-Original-To: netdev@vger.kernel.org
Received: from out26.tophost.ch (out26.tophost.ch [46.232.182.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C213C914;
	Wed, 29 Oct 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774022; cv=none; b=V1nLRBC0SbrO6s8jwASxSYZsvkmJ/n579dRwcaOD/Cxdn4UPT62qzrOoUk5LdK1qac7ipO/Mh3wzvSz5SqvcU2/I+gUix4yvbRJNRijT2H1ntu9XroGX4gr7EZyoQ6gGkTNtvinqvp52xKNumnU/UKlcZbQPTl3ljYwWrmI3Qe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774022; c=relaxed/simple;
	bh=KsLICYSdai358ng0LbivT+XEiH/kal9SLt5IS1MUsRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bucPGpF2T3y3gzRJSw2JLchlCxvI9An5Ugkxt7ZTBLDp3R4k1dKFjRo85W0BQH8yPCL1KxmBMlK5U/cNpFlyakdPfALKM3JyjhBFIeITqr6oQ5MfioPE72vrM9y5+jhcU5gYmdNxWlHGoHG7PJzQbCAZdv4/miCZeFn5vGq0d4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=FPz/K/Y2; arc=none smtp.client-ip=46.232.182.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter4.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vEDeP-00EABt-KW; Wed, 29 Oct 2025 22:24:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MCaTi5+1GdvtDvu93JLcxGyOsiwEWFfOOZdGKf+f5WM=; b=FPz/K/Y2Fn/1cbmSQ6IdK2LtDl
	62el0AbYDSohkObKYK1HerVTZwU9l5OKqbFA6NOLcaXPTDC5tLoAMLmzHaKz45fx0VAeh7qiK6+mZ
	h47Wv1eyltgc/7p+UGd4NbNkyEpKzxH6xnWFmXMW8wdrykqT+FrGebST95E+sa7ZXgarz10wiGJ6L
	U5IkhOUgnAQhJN7dIveDupoXNqZnOo0OO/OQ30jqWLdV90oSnKbkBCuQDwBdaMUQNLhQZdF510Kib
	4oOfEHmXcRFmM3yeXkYVBYYDlRab0zTJfv7NT6TuO5y9So3yK2IrZIs7mymliiVX+XeI2k5ZOL9Lr
	khQX7ZvQ==;
Received: from [2001:1680:4957:0:9918:f56f:598b:c8cf] (port=39522 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vEDeP-0000000Bf5t-1AjL;
	Wed, 29 Oct 2025 22:24:11 +0100
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
Subject: [PATCH net-next v3 2/2] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Date: Wed, 29 Oct 2025 22:23:10 +0100
Message-ID: <20251029212312.108749-3-thomas@wismer.xyz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029212312.108749-1-thomas@wismer.xyz>
References: <20251029212312.108749-1-thomas@wismer.xyz>
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
 daZjkYv0hq6Ot6Cbd9hg3807OZKQzthz0vNkOX8Em4cj6D/wdel5pGtBZGkILbtkwjuL+TU9W7vD
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
 AboBIkUL/j1Y48GvmeURQjjEeKVXbbsuQxCT7KwYHrWmLStOsQFbw8vrkGLslTiuxw4nPK5DkQL/
 /M3fHsVNrsMGJz4RQfBVfxkAwoVpA4J/KzRZEq6vMKhJ9oG2v1yvThzPEGEatp9rvw0eoI0HqUDY
 Z5lBVqqSQepN0b2sqifLOj/1zwA5Elj0L2+pr2KRBXGwDoDEJrayfp9Tsh2+VPTlfegw9R5Cyryt
 +7lKCjnJY+t4m7skVkCUrb1O+GFi8/GtOCoPdeOKuroIXJBF3iBhveOWAg2/DdpIH6kX9BAh5T56
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


