Return-Path: <netdev+bounces-234173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58375C1D8EA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4E3AABC1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD165312816;
	Wed, 29 Oct 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="dOiiR7/C"
X-Original-To: netdev@vger.kernel.org
Received: from out19.tophost.ch (out19.tophost.ch [46.232.182.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0802F5A32;
	Wed, 29 Oct 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775524; cv=none; b=tcwOLI5Tp6iukttaEHqL+YWVaVzl/H2pE7iPOyeffgrZCpTryOxoMG7Kr2zTg5jBlc5xOswoYTPjet31nC0rqt+5fIE/8F1Ma9L1Lpj0K142xy0Kr1nmK0K50zCcKxix7ZHsVjlKqWVivN3JgDLEodrIa8l0rl+M5fSNMfQ9AOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775524; c=relaxed/simple;
	bh=lItdCUYG1d6UQm85Qss0GbZq85EMHtgNMgGd/rNTbxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTALkVfWCT/u5W7iTyv3ggLz9FfsYbT9DeRZ4CJ3sEvQwJntc1eobb6Xin/Rg5zMlu3zpGRGNPF5D0V0+mwyDTAUYgcwD7TUH4Gw1Wq9qzmapcknWrM3r/w2mXe2YW8D/CDlUgKvD67ZYJY86dR/q1RnLxn0Pbxk/Kl7fc5ziuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=dOiiR7/C; arc=none smtp.client-ip=46.232.182.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter1.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vEDdp-0042tJ-SZ; Wed, 29 Oct 2025 22:23:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QgqV9QPXVsvYbwJwR/tZmtDFiHEZLdUm5PrQpDLHRlU=; b=dOiiR7/Cc5qn2AmTBesQfi8YU5
	kaZ0DutfrzOBcOxTZIDNZ2wdTcS4mhPHc/7bxUtyv4z78AnkxMeKEgE8FgsseGuGxi5PLhSk7MUZN
	ZTRT2nl90ZOrTwjKNPACPCVJJzybHCHLVI0neKuIROxSaj0KM9wIfpbpfzWXd5jed7Woop9hJEVya
	SCR4RzdwajUqr4mydCH/UtOqcWKwuA9Mmxombn+or/gQ2aVQHPyUwDqgypKWcJsQG/T+FB9G1oM41
	G6VApjYsj++b8YT36Aa/oTlGPXU4+Ltm5QvxIU2hQxIP4rlBj8K/OuYVf7zxEdX7Fb55NvYFvUJQk
	uHhmIbAQ==;
Received: from [2001:1680:4957:0:9918:f56f:598b:c8cf] (port=39522 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vEDdq-0000000Bf5t-0g6g;
	Wed, 29 Oct 2025 22:23:36 +0100
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
Subject: [PATCH net-next v3 0/2] net: pse-pd: Add TPS23881B support
Date: Wed, 29 Oct 2025 22:23:08 +0100
Message-ID: <20251029212312.108749-1-thomas@wismer.xyz>
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
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zHbl
 xp7QWjUgnsevh5dXQOeCn3oZFShGuGVczvnnMQuyCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYv0hq6Ot6Cbd9hg3807OZKQzthz0vNkOX8Em4cj6D/wdUjFxsH/4KTYIVqFSP1MaBk9W7vD
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
 BuT6nbBE5ChZV4BXMzDRZJe4unb0slCpezWAv8geAoSsO1QSo1zEvYJi0O+7gv2MANPskD2hG/WB
 q49TQI4s7Zk25QzEh4fdO1UVosIGSxnPvA8wgBLtVZogJpSXh3l1gykJmv2lNIo4lDSAwCBIOnEB
 yG0AYw9A3oZxIE5agCoT+LyHJnLBAIRTv7sWoxVUM9BU2lqHZA4o2f8o2ucO3XHWUec8VPZi63hI
 VDdSxAySkA2y1dwxX/fOLxBYDd5BmItKTzNBSIyW/mb8GD9YbxmVCZr9pTSKOJQ0gMAgSDpxAXyp
 F5LUwHZNY/+yVAGZIWgbevr4I2GfjWs7NecHzbPrZnM57PQ4Zhz+lPAiIO8rB9tRBN1MQm1SbNQ8
 mfig9wuAva9NlDz7O8ptuOziYJtS9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

This patch series aims at adding support for the TI TPS23881B PoE
PSE controller.

Changes in v3:
- Incorporate review comments from Oleksij
- Link to v2: https://lore.kernel.org/netdev/20251022220519.11252-2-thomas@wismer.xyz/

Changes in v2:
- Repost after net-next reopened
- Split off bugfix commit
- Improve commit messages
- Link to v1: https://lore.kernel.org/netdev/20251004180351.118779-2-thomas@wismer.xyz/

Thomas Wismer (2):
  net: pse-pd: tps23881: Add support for TPS23881B
  dt-bindings: pse-pd: ti,tps23881: Add TPS23881B

 .../bindings/net/pse-pd/ti,tps23881.yaml      |  1 +
 drivers/net/pse-pd/tps23881.c                 | 69 +++++++++++++++----
 2 files changed, 55 insertions(+), 15 deletions(-)

-- 
2.43.0


