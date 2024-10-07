Return-Path: <netdev+bounces-132593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA1992522
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165B1B22CB8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C462815CD58;
	Mon,  7 Oct 2024 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DwIg9fTh"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A315B0E4
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284045; cv=none; b=ABMiXAi/a20dLFA3AP+RihNKi3xrVGcnXTcOiO61/feeNG/Yu2l1M5a8l/0S7UBczBuArWbnPrBNwWpUA9qrhCkN5dCsFnoqdRaya93pECvQxK08lskIGHIGxfA9Wuug2Gscjzab1cRvdTqkWGpwR2Ed/JtFJZDAqviRg/Q1u0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284045; c=relaxed/simple;
	bh=1Ow9skhil0G7eorkY/X+nXFsytd4PUIirPjg3H3QYYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGxfHlzclehJ2BSH4yarr0Bm1/drthE8Sdv+IgX/eBiOSlKn6Iii5wNVrA3/7wZmL8M57OA4LxYsWi170tAwzVvyrvUSu73LoA3NQ8kQ2gjl9Y9CKBuh9wUPA/MnJS3RuY/g0Rkul3uWoxQcA1RqZWAmTHnMtm6lbK2XwcLALMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DwIg9fTh; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 718062074F;
	Mon,  7 Oct 2024 08:45:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zzRfLfn0ovQ8; Mon,  7 Oct 2024 08:45:19 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 42FFB207B2;
	Mon,  7 Oct 2024 08:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 42FFB207B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728283518;
	bh=1Ow9skhil0G7eorkY/X+nXFsytd4PUIirPjg3H3QYYE=;
	h=From:To:CC:Subject:Date:From;
	b=DwIg9fThuDkqBpYBtzxHnbJD4rJZV49PlNmPv6ncaHMPUL5/iZ/K4ceL7l0W5PuUB
	 WY+PHNwhPe7M5jrUXPgUR5z5DDjBAuV5p4J9jMBEbRw2DUNw4wN90o0GboqWC0tNqf
	 jnvlUExD1EuVN/IFMtJzleP3nl64TCgnFJ3+nZFAwpeqbOGm6YXzohx0tbfAfqGHX8
	 IL9Xe8LUpUnibC4LQ3aeoEYKtazyaOBLAg/EmcDXBsonNPLur2+6z9ms5qNjTJI05V
	 5KHjag9Rdh/I8qTPvWaiF/oQOIYjIV4qJ+19zsSBe/cEFZ9GsT2qVWcMVpbUQGVtP1
	 5jAIqMVE1MlJA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 08:45:18 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 08:45:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 401F03182A38; Mon,  7 Oct 2024 08:45:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, <netdev@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, <devel@linux-ipsec.org>
Subject: [PATCH 0/4] xfrm: Add support for RFC 9611 per cpu xfrm states
Date: Mon, 7 Oct 2024 08:44:49 +0200
Message-ID: <20241007064453.2171933-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

This patchset implements the xfrm part of per cpu SAs as specified in
RFC 9611.

Patch 1 adds the cpu as a lookup key and config option to to generate
acquire messages for each cpu.

Patch 2 caches outbound states at the policy.

Patch 3 caches inbound states on a new percpu state cache.

Patch 4 restricts percpu SA attributes to specific netlink message types.

Please review and test.

---

Changes from v1:

- Add compat layer attributes

- Fix a 'use always slowpath' condition

- Document get_cpu() usage

- Fix forgotten update of xfrm_expire_msgsize()

