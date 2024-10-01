Return-Path: <netdev+bounces-130793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B698B8FF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF57D28398D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068CB1A08A8;
	Tue,  1 Oct 2024 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmzj8KAm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69FE1A073B
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777449; cv=none; b=ETcNIpE8Zl4mJK2FDb5pFNk3DYTAlUsSt4I0Y3Kpg30sqvkWO0XeBy5vK8omnlls7rYU7nBARBRZohWPXTxJZbtOWJn5Zg1KemOuZmTz+miBTpJW7RNlWFVzA4wr2REX8iyIoUljX+lgD2/FlED9TxxBkmMtDdku8nuvkaVilws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777449; c=relaxed/simple;
	bh=PQvz2OTl7+pmW7TEaHC3UE6z9ZKgTtlcsgx/ouMCEu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ksCxXNAThrMneucEPSH3Bfw/p0P9f9jpsATMGtLB2EaZBNwpel/Ho0v/QDDdFbNwjTWY7xhjxsa+PRyHjRCz0c03jIVoD6IsexC+WnHM8Yd8KjySHoa2XnZYibkIKb9JqnhAysYJLQtOCk+F3UDGUXz1xsXvlubbKhQH/uJG4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmzj8KAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF1DC4CECD;
	Tue,  1 Oct 2024 10:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727777449;
	bh=PQvz2OTl7+pmW7TEaHC3UE6z9ZKgTtlcsgx/ouMCEu4=;
	h=From:Subject:Date:To:Cc:From;
	b=jmzj8KAmkEn9UsRjQyXBxPfT2z8puBdMbmD/0qvGd5MN5QrCeuk9F+RnXbxhhVBc+
	 23Ggy7+qxQOauyeOh3XvWwxLH4BD/fyF0f1h4AZVXqNlm3Q8TDPQSCBA6YljOUuObz
	 14KV7ryYgrlsKImH4uuuq/TMnuSG7keWYm/1w7blI9PcphV1KFCy3j0xTHCrGHiFuA
	 ZcntQQugL/ekuazwqVhyjlHPV3jP4n7zeqfyO2mGPFWZW9CsAHpxbsPcZdx1pZIBH9
	 3tb4hDflDpJ43mbRcBLl9tJqn7ySOkLPtBLQ8TWb1l5jO7N7uWulHXsJJScxzl6xKu
	 A9mRqvISQ+ZBg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/2] net: airoha: Fix PSE memory configuration
Date: Tue, 01 Oct 2024 12:10:23 +0200
Message-Id: <20241001-airoha-eth-pse-fix-v2-0-9a56cdffd074@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJDK+2YC/22Nyw6CMBBFf4XM2jF94AJX/odhUeqUTjQtmRKCI
 fy7lbh0eU5yz92gkDAVuDYbCC1cOKcK5tSAjy6NhPyoDEaZVnXGomPJ0SHNEadCGHjFYJXVtiX
 lfYA6nISqPqL3vnLkMmd5Hx+L/tpfzqp/uUWjwtDqYIK9uGHobk+SRK9zlhH6fd8/PunkgLUAA
 AA=
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, upstream@airoha.com
X-Mailer: b4 0.14.1

Align PSE memory configuration to vendor SDK.
Increase initial value of PSE reserved memory in
airoha_fe_pse_ports_init() by the value used for the second Packet
Processor Engine (PPE2).
Do not overwrite the default value for the number of PSE reserved pages
in airoha_fe_set_pse_oq_rsv().
Post this series to net-next since these are not issues visible to the
user.

---
Changes in v2:
- fixed commit logs
- Link to v1: https://lore.kernel.org/r/20240930-airoha-eth-pse-fix-v1-0-f41f2f35abb9@kernel.org

---
Lorenzo Bianconi (2):
      net: airoha: read default PSE reserved pages value before updating
      net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()

 drivers/net/ethernet/mediatek/airoha_eth.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
---
base-commit: c824deb1a89755f70156b5cdaf569fca80698719
change-id: 20240923-airoha-eth-pse-fix-f303134e0ccf

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


