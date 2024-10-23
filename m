Return-Path: <netdev+bounces-138178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B89AC844
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21FE1F22FB7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC191A3AA9;
	Wed, 23 Oct 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SoWiQDYd"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28291A0BF1
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680841; cv=none; b=G8yxOFQysZGs7Pz8d5T3qntn/uahoNnQGGTwfZrINSYPh4kCE8DHJYIkq1LXkxdF+0+foHUq6JXwOtNEdBUj5Ylfjl+ddAMv41s3kyqwSlUeq4uvOIeh+IDnkM5dH7VCBsFulYBSWRKCh9maweTKg5Io9L0Kvq+FKhTD42kGNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680841; c=relaxed/simple;
	bh=4zLqCMA4FdcqwLOxtv0ARFzl/DoP/PFneT8H6XaozuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ouzmjp7Zw7PHupcw/26RuNSYecWoSf6QrjjNQiH2atgw0eVlAR7YqqLkwoQs7zbjSP/iHqU9X7zm7/T/3MgfCy7KA7gGpETQhVuaTqrheOXkZgkGYt8Ncn4OqAd4DnpHFdO4nSbhZRFUjWN3ri6Vhse0PjbGKF/3BOtias7sDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SoWiQDYd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0884720854;
	Wed, 23 Oct 2024 12:53:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFaeJMiVvdJD; Wed, 23 Oct 2024 12:53:51 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 84145207CA;
	Wed, 23 Oct 2024 12:53:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 84145207CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729680831;
	bh=4zLqCMA4FdcqwLOxtv0ARFzl/DoP/PFneT8H6XaozuA=;
	h=From:To:CC:Subject:Date:From;
	b=SoWiQDYdAKioOQKtmp7zSY+xwrxX194J3yyLNp8Fn9vqFSp/x46HC3hwjIr1k8iEC
	 O1nBKIR4iV6tIZiO7lOnzyCn6X282iIXbojd4AvpHznPgcDzShVVf0Hzha3eQzJC4X
	 IO/vqwLKybzw0OFH//x17Md0t9YyckR1ld+l77LCwltCtPcTMQGgBsgndXiH0Lo4m/
	 +DSa7Pt952DT5WDBuJyFFcOg/V5eu7Y9EBn0mGOWenxoCQfM54WsiCQqWbxODLOTro
	 bKNxgDY6/1L0KwtQjaVXGNGPdkb6DRvlyOQ/gcrYITHI5YvdEZswdbImWnxeDjP/eV
	 qeGYp6R4o5qsw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 12:53:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:53:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B76F83181A55; Wed, 23 Oct 2024 12:53:50 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>
CC: Steffen Klassert <steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<devel@linux-ipsec.org>
Subject: [PATCH v3 ipsec-next 0/4] Add support for RFC 9611 per cpu xfrm states.
Date: Wed, 23 Oct 2024 12:53:41 +0200
Message-ID: <20241023105345.1376856-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
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

Changes from v2:

- Rebase to ipsec-next

- Describe new xfrm_policy struct member state_cache_list

- Drop a missplaced semicolon

Changes from v1:

- Add compat layer attributes

- Fix a 'use always slowpath' condition

- Document get_cpu() usage

- Fix forgotten update of xfrm_expire_msgsize()

Thanks!


