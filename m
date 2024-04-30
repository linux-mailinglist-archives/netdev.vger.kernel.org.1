Return-Path: <netdev+bounces-92333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E298B6B1E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D7B1F227FB
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24D1C291;
	Tue, 30 Apr 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kJxzq7Ba"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFF3BBC2
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460898; cv=none; b=mxJGy2Ee+UgOzuM3E+RWcUna3eJq25OfOvZi4omjMD9TRjb2tQKWOAZQe9LNDSnr2VeQQzFuYOqbVYAN1xuyR5MecQ8ZUh3vL43fmk5ytQiVXw2T+Ww61IIcOcKQ7JZ4jSr8m0rlsxsen/7mt6Sv1EoKtVb1Gy+8GDPe/Y6wXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460898; c=relaxed/simple;
	bh=bcHeKkSBxCEKMvMJ2F+I8Eag7LbEF1VFsKJ/0NELaVU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uk41dWxAtacXPknLtcDgY6UsI1Zn0fSSBt4jRDEVkSclB62LqISk7llJRv4f5wpCfTyjgI6Wnauy8Ipdm683RcSa6BH43Cn8J82Z04OpId6Lfzud3zFCWgrbThuyWMNe9ZFlLdHzie3jnJPkxBnbF1j39I15LgmSK6tL+473cSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kJxzq7Ba; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BD1612074B;
	Tue, 30 Apr 2024 09:08:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id meuDoljA_bAh; Tue, 30 Apr 2024 09:08:13 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 36F89201E5;
	Tue, 30 Apr 2024 09:08:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 36F89201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714460893;
	bh=nUV4Dy14dskht7tqzs4ZFgJTdHPIsi07BEtZptAyBfo=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=kJxzq7Bai1eGs/e+lZYZfEMWblm94Z/qRwuiJLSvtuJXTL6R71/vdXg68Uzs/5Pvx
	 Cd3NEuDQ5T6xt0kc/Hn+Q3iFsNofocJoZEDjWtPNm10o4pteYKmLRaMW0BdnFnysPG
	 E3pYSaiyzXzxMtKSX3cRGiCgNwhI5XUpXK7y/LuQTS1KVTnS1hklLv7sQKqPr+Y38i
	 ZiVo/V8+aLPkNvzHKgEPaYgzA0DyBgCL5sCL7a9NV90ouJWkaBjpnKT2NGwZkpiUzM
	 Nl8GP9mCtA1WVanS1QmeGlIGfgAOq4o6SUxomAE26NxOm4s+sjZ46nIoDBnVsKwVdV
	 N5caajFwa5SrA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 29CB480004A;
	Tue, 30 Apr 2024 09:08:13 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Apr 2024 09:08:12 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Apr
 2024 09:08:12 +0200
Date: Tue, 30 Apr 2024 09:08:06 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v14 0/4] xfrm: Introduce direction attribute for SA
Message-ID: <cover.1714460330.git.antony.antony@secunet.com>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi,

Inspired by the upcoming IP-TFS patch set, and confusions experienced in
the past due to lack of direction attribute on SAs, add a new direction
"dir" attribute. It aims to streamline the SA configuration process and
enhance the clarity of existing SA attributes.

This patch set introduces the 'dir' attribute to SA, aka xfrm_state,
('in' for input or 'out' for output). Alsp add validations of existing
direction-specific SA attributes during configuration and in the data
path lookup.

This change would not affect any existing use case or way of configuring
SA. You will notice improvements when the new 'dir' attribute is set.

v14: add more SA flag checks.
v13: has one fix, minor documenation updates, and function renaming.

Antony Antony (4):
  xfrm: Add Direction to the SA in or out
  xfrm: Add dir validation to "out" data path lookup
  xfrm: Add dir validation to "in" data path lookup
  xfrm: Restrict SA direction attribute to specific netlink message
    types

 Documentation/networking/xfrm_proc.rst |   6 +
 include/net/xfrm.h                     |   1 +
 include/uapi/linux/snmp.h              |   2 +
 include/uapi/linux/xfrm.h              |   6 +
 net/ipv6/xfrm6_input.c                 |   7 ++
 net/xfrm/xfrm_compat.c                 |   7 +-
 net/xfrm/xfrm_device.c                 |   6 +
 net/xfrm/xfrm_input.c                  |  11 ++
 net/xfrm/xfrm_policy.c                 |   6 +
 net/xfrm/xfrm_proc.c                   |   2 +
 net/xfrm/xfrm_replay.c                 |   3 +-
 net/xfrm/xfrm_state.c                  |   8 ++
 net/xfrm/xfrm_user.c                   | 162 ++++++++++++++++++++++++-
 13 files changed, 218 insertions(+), 9 deletions(-)

--
2.30.2


