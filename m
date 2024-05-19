Return-Path: <netdev+bounces-97144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242588C95EF
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 20:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A557FB20BFB
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03286DD0D;
	Sun, 19 May 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mTeSF7we"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA446DCF5
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716144231; cv=none; b=MtkYjEBVs0VVmBjoJkFg0zS3CP3XHR+gdb/sWMTiynRX4Je+bGEV9UIh166WWUH7ZBUE4QutuLdunUS3qNFFP7dSxLL5+XQlqGesA5mxuyjp7NKMlqUqOTDA2QKfROY2SW9vTB+HemxTQT5zcqQSXuWfHi4KWVKWMkZTNXg3OAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716144231; c=relaxed/simple;
	bh=HdfOe988cZvdqNREXUOD1Zb+/Z0i72CdcE7/shmz+aM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=URzyR5GWrMWAvdmGJH6Ar0bIjfrpQKDWlhk40C7zro1vuLaeqfrVAKFJWLs3Di3Ry0CKEO99k6jVPbI9ggSi/LNpyrZIArUKFS4zVF8M6V+A1CiWNJCBvqWG5hs/mrS5FNwdVQhVBdzv2fgolfCBHGFbzD7n3qFV7Y3Sz8SGZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mTeSF7we; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 50B7B205E5;
	Sun, 19 May 2024 20:36:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mqww1mpOXW2G; Sun, 19 May 2024 20:36:23 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 155D620190;
	Sun, 19 May 2024 20:36:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 155D620190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716143783;
	bh=UioEjfeuqNftEda+11zF21I+X9LEcZDRweYGsoYBmKM=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=mTeSF7weI73CXbCVi+OAStjXha4+/+lbvREEnVrJIuwpLJAVADNHY90bSnGjg1sRX
	 hrtBLKe9d8dsZhwtuKnmKZaYzgdqLY3rjkOPVfeStVrn7z1yexRxl07LkzYn696+id
	 RqafRMwiQaNyzc7ymq7OKu9ytq+zeEwA5idvy0zYj20nHg//gZpMKCl4ZaLTvyp5Kw
	 HjbmNI0tuVED81qBU9EOrzy2zL9R4P9tRGlkp/U+L0XBdJXbr+a7METWmuC1x8x5pS
	 /q5wgo4i5RhJKR8EVXsunnd7sdtVDBtQGj4DyxO8AGeZ4KbItcjKvERshRk3r5TOES
	 +wuiDIuHSMgzg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 050BE80004A;
	Sun, 19 May 2024 20:36:23 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:36:22 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 May
 2024 20:36:22 +0200
Date: Sun, 19 May 2024 20:36:14 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@gmail.com>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Eyal Birger <eyal.birger@gmail.com>, "Nicolas
 Dichtel" <nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>,
	Christian Hopps <chopps@chopps.org>, Antony Antony
	<antony.antony@secunet.com>
Subject: [PATCH RFC iproute2-next 0/3] xfrm: Add support for SA direction and
 output cleanup
Message-ID: <cover.1716143499.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Kernel added SA direction in commit
    179a6f5df8da ("Merge tag 'ipsec-next-2024-05-03' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next")

    This commit adds iproute2 support for SA direction.
    Additionally, redundant fields in the "ip xfrm state" output  are
    removed when SA direction is set. This series keeps the old behavior
    when the direction is not set.

    Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
Antony Antony (3):
  uapi: Update kernel headers xfrm.h
  xfrm: support xfrm SA direction attribute
  xfrm: update ip xfrm state output for SA with direction attribute

 include/uapi/linux/xfrm.h |   6 ++
 ip/ipxfrm.c               | 126 +++++++++++++++++++++++++++-----------
 ip/xfrm_state.c           |  44 +++++++++++--
 3 files changed, 136 insertions(+), 40 deletions(-)

--
2.30.2


