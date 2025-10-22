Return-Path: <netdev+bounces-231904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31BCBFE677
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7793A3A7FDC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E98F30505E;
	Wed, 22 Oct 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="JnLzqJqq"
X-Original-To: netdev@vger.kernel.org
Received: from out18.tophost.ch (out18.tophost.ch [46.232.182.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20762F363E;
	Wed, 22 Oct 2025 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171737; cv=none; b=VudXWiZBzHG0sbzi4HE3Oq3Z4v7PvARIyuJXjiz74DGoQHPOLxj5f3JA2NxOktsk7z9lQlSgFWyvnM5q/a1qIiJuJB7WA2pO0PGFsM/4VzAPtYG0kUE2WLrNKAEmK63boznZzFvbLzwbn5IPC1e2ZCRsi1eZbTvs73oh5L4QC8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171737; c=relaxed/simple;
	bh=WKx5VvpZNIXxWSYiYC+4avNcCV6AWjTCyle+CNU/ffo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ti6yIGknzhezr1XtcS0geZjr0QTUVTC88XcjKDFj1d9wPUQdqS1nz4NIZcozUD0PfVy5xHbocmETuu6g7XIXfqb10FzU/EgTlNzyp7ZNhEuHc9IvRjveGZ5QjbJ1lTOt3ceMvPlN8MI3hmd/fL5yKgCfM9KY9HN9Nv94AuEoA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=JnLzqJqq; arc=none smtp.client-ip=46.232.182.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter1.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vBgxs-00ClhJ-0o; Thu, 23 Oct 2025 00:05:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Dy0GeLCtSDklZ5vNeH6AXOOm7u8pUx5rde9zVsUzSpI=; b=JnLzqJqqcR46wU6fZi+lXWYlIf
	O08yRgRIb9TOYVoNUZyhJFMOJjAtta2s8QJSQ7hHBRtl+icXcHrkXR6f9QeJSuq6kh8ShUbGSgXp2
	sARcytkO6STf8UKcSSxP6jdCHtrqmCajo5xo57IXLdOJCxIctOm5kneINiu7f1On5PCJaXkAdUT9T
	7YoFu/aaIUIs7u3vj0CM+8AtvKlye7qnMmnhQtRtSJx3u5oJ5k6sif03oredLv9L8ju4Fh9KVatUc
	oBu8wOkcc+FR6RzHs9cAtOCUlZh6GWuXtXJ+CcX97vd39KDqh9/CrkthI4HiKvqaNOo8cF1Ys7l3N
	josL15/w==;
Received: from 82-220-106-230.ftth.solnet.ch ([82.220.106.230]:62831 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vBgxr-0000000APCP-2JwG;
	Thu, 23 Oct 2025 00:05:49 +0200
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: pse-pd: Add TPS23881B support
Date: Thu, 23 Oct 2025 00:05:16 +0200
Message-ID: <20251022220519.11252-2-thomas@wismer.xyz>
X-Mailer: git-send-email 2.43.0
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
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zE2i
 BUVsDEZgnbMbPvvOYsOCn3oZFShGuGVczvnnMQuyCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYvkfoqFqk9QphLZk+yqk+tIzthz0vNkOX8Em4cj6D/wdUjFxsH/4KTYIVqFSP1MaBk9W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoanVmeCF7bI0BP7dENKtPTBPq+vGO3Vx+SwwWschmkdvs376y2A4
 OBi1/UyqO7jQnnICeA+KlS7G8xqewTcs6w6HLg3eq1lKkYVFbZT99AeINpdbOTIWFiLv1jhppNXa
 xS6MN8xFxlxHZge6OlcoYA//qN5p5dmu6xjQN9nmCfj7VmpmZJyx9iy0UVkVD75IgLollI+8fg4q
 Ktu8I/h2Z0dHZM6qE0STp2v0JiRE8jha5ZR/nf5efcITxrfNKzy0W9Bd37g8M9SCqD8uOq9nJ+Mm
 AyVp7BgHET6y8CCeFlQ7QPOIjlkSAfAYMUguLL/iJ9vYqKPILmSoZcvfXhdPMA/OB6L3DS5gd1SE
 E3USj80Z55NePwA7jxwlhcjVdk/mr85ytrd63MVeviF0i7IZfcqGEigUra+zu74YMVqBb/nqBf/o
 O9ENx2nriip8WhgYbnEnhEbOEzk5yB9ZHNSFnOUf5Q/AoIx5sTYq7iOI4vCrDScUfr46OzpJNOSz
 cdwyiT3dKxLhoxcmaInYbR5vlqGvSe+dDtUIqP45C5A7LqP3b1xqO73zx9HsLZFTQ55zlz9aPc+7
 R744868L+j9WjFdaiDCoaRMMLJurWmXEnoYHaIfVaCHpEB6cFH6WJxE4ZpdasxsGznVQ8gQCuamI
 BuT6nbBE5ChZV4BXMzDRZJe4rWywFD40ZHFHauI8E1FjrVQSo1zEvYJi0O+7gv2MANPskD2hG/WB
 q49TQI4s7Zk25QzEh4fdO1UVosIGSxnPvA8wgBLtVZogJpSXh3l1gykJmv2lNIo4lDSAwCBIOnEB
 yG0AYw9A3oZxIE5agCoT+FgCzw1EjraHBUo7Xjr97ZY6lVqPCo/SwFbRV8YvNj9QUec8VPZi63hI
 VDdSxAySkA2y1dwxX/fOLxBYDd5BmItKTzNBSIyW/mb8GD9YbxmVCZr9pTSKOJQ0gMAgSDpxAXyp
 F5LUwHZNY/+yVAGZIWgbevr4I2GfjWs7NecHzbPrZnM57PQ4Zhz+lPAiIO8rB9tRBN1MQm1SbNQ8
 mfig9wuAva9NlDz7O8ptuOziYJtS9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

This patch series aims at adding support for the TI TPS23881B PoE
PSE controller.

Changes in v2:
- Repost after net-next reopened
- Split off bugfix commit
- Improve commit messages
- Link to v1: https://lore.kernel.org/netdev/20251004180351.118779-2-thomas@wismer.xyz/

Thomas Wismer (2):
  net: pse-pd: tps23881: Add support for TPS23881B
  dt-bindings: pse-pd: ti,tps23881: Add TPS23881B

 .../bindings/net/pse-pd/ti,tps23881.yaml      |  1 +
 drivers/net/pse-pd/tps23881.c                 | 65 +++++++++++++++----
 2 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.43.0


