Return-Path: <netdev+bounces-111851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413089339A3
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E3B20C91
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3A39AFD;
	Wed, 17 Jul 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="OmKsc1OZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57519A
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207329; cv=none; b=SpY8E3DpyN3cxXH+uZiV2k6sm4HzKDon7BErDyHOKOB87qLYA9K6nzS/wo8lbeVkFd8dUfYh2tRyhktfEj4tgDcve0vWBZ9H8EX+JhWr+kzTX/GX+zq06SICuBLrmgofYEXvc+7Rf4n3RKaAKQcbdyD+uSPZiG53fRx7gQffxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207329; c=relaxed/simple;
	bh=2FdxH/q0NBjdw19vXSVVP1q8o88J/r0xbCVxQer7e84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgMaPXFgxFD2NtigYf6o6eECrUBfbTJjzqIaihvnJ2btOoF7iemIi5KC5ZIZLlMsAJgDiTnRbCb/mIEMZPGBd7gHTersTBRTYnRES3jhfWg0iNC7U4E+C+66zIy8nW/KSU+TSJSteXa3GhhYtagD/U3tjcej77clDcSZMJQa1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=OmKsc1OZ; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id 79FD25A0002;
	Wed, 17 Jul 2024 11:08:44 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z039gySwpYuY; Wed, 17 Jul 2024 11:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1721207323;
	bh=2FdxH/q0NBjdw19vXSVVP1q8o88J/r0xbCVxQer7e84=;
	h=From:To:Cc:Subject:Date:From;
	b=OmKsc1OZaadWcDiI3yXDmgAM9nAD94Ydw+j8owO3JKaNOLZhnqZ/30P23UfbSuBgl
	 K6vZoL354D57y7LqqtzX6pERydd5EIH3DFP6qEHt/JD2Dt/GNLydx2g2HcQ4Y+IzHS
	 bKy/EWGxMJLSMH/8Fnwpp8Rke1NnWb/AhgHfeTPbxNpGthSHud88hAFGI8hAUlmnH5
	 M11iVeVLUDcpPbGrSrOk6q9t0jR3YIEIzkAv1uv+fKceZF3LXKq9131SGpANz8qgw9
	 eeXwQHR4/FwzQjDHncoIp5oJsnzCm8biI0kK0JOjfLgKEturCEjSVfxf6KU6ILiBaC
	 fvWgHMlJaTuSQ==
Received: from think.home (unknown [185.12.128.224])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 149BE5A0001;
	Wed, 17 Jul 2024 11:08:43 +0200 (CEST)
From: Martin Willi <martin@strongswan.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Murali Krishna Policharla <murali.policharla@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net v2 0/2] net: dsa: Fix chip-wide frame size config in some drivers
Date: Wed, 17 Jul 2024 11:08:18 +0200
Message-ID: <20240717090820.894234-1-martin@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DSA chips support a chip-wide frame size configurations, only. Some
drivers adjust that chip-wide setting for user port changes, overriding 
the frame size requirements on the CPU port that includes tagger overhead.

Fix the mv88e6xxx and b53 drivers and align them to the behavior of other
drivers.

v2: 
  - Skip chip-wide config for non-CPU ports instead of finding the maximim
    MTU over all ports
  - Add a patch fixing the b53 driver as well

v1: https://lore.kernel.org/netdev/20240716120808.396514-1-martin@strongswan.org/

Martin Willi (2):
  net: dsa: mv88e6xxx: Limit chip-wide frame size config to CPU ports
  net: dsa: b53: Limit chip-wide jumbo frame config to CPU ports

 drivers/net/dsa/b53/b53_common.c | 3 +++
 drivers/net/dsa/mv88e6xxx/chip.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0


