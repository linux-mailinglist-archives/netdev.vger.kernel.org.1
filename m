Return-Path: <netdev+bounces-91585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85F8B31F3
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD17F1F220CE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518813C900;
	Fri, 26 Apr 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="o0OUE/X/"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90EE13BC28
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118697; cv=none; b=Nyw16gfikVVv2jU3puSYXTLPXxMl3L94DG0mCQcvqKCrtJk7LAB3NMkW1F96rD5TuZNIAZknW0iT+t9OYg1uhQ4tNPnC/2ySllCndwM/7tlvW7pNjf5LHDtG8LcyN19r8jCv1bmwPMsDtc+nP1MtRLxz7v209SIDUzbZpxkGZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118697; c=relaxed/simple;
	bh=C4PyG1tXM/vfK7v9QyhZU9CCmMSCJVMADSvWWxXQASo=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qbq0kDlxxZHNaZqsYmMcisx8NJYxsCFWCFH0szpUrycx3dy8T/rp1c9ETXNX30R4Cl5k69AvqnSfu52B6ARIbCJ9EPDh1iLkGbGf11lQSe8ab1LAWT2ILAAyyyFIYoBKZ4FM52Jqf0TMBfD1FUfoDvTeO4RGDFiuRN0sOEKamzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=o0OUE/X/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 64F2C20870;
	Fri, 26 Apr 2024 10:04:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XpeFKPomrnw7; Fri, 26 Apr 2024 10:04:49 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D4C7A201AA;
	Fri, 26 Apr 2024 10:04:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D4C7A201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714118689;
	bh=hnxkqYNkBSvO57EueCogZ7YmH592aqFO9S6wEMBKBlA=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=o0OUE/X//OveWWxPTSdoKsIPT8RA+Ondz4aJhqZ2RYrARDx41DPs9zU5eTtoiNwBI
	 hqX6D6VI5yw2t5SUg7qhD4bhlfPspS0X3cRkHwBgousdadlBHehmmhnXia4vkglM5H
	 BXhtL4JsTD7hck95bW/bNjCddnpxgpz2F08D3TFe7UJvQzA9rreZBXBGRtOXZu0UbT
	 e+nhB4S5daElQxp7bncs0MotgHzUMfFbSft8fIL2+KuhJw+JkZHiSP7in+AzNo+lQL
	 N5XljiGOisiUg/2shTHq/KIXUhSBOcseuc4uFvsEGTRy0dxOvZxPbYKnfrtsM1c3q2
	 0l8yj4ymAlxvw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id C7BB680004A;
	Fri, 26 Apr 2024 10:04:49 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 26 Apr 2024 10:04:49 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 26 Apr
 2024 10:04:48 +0200
Date: Fri, 26 Apr 2024 10:04:42 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v13 0/4] xfrm: Introduce direction attribute for SA
Message-ID: <cover.1714118266.git.antony.antony@secunet.com>
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

v13 has one fix, minor documenation updates, and function renaming.

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
 net/xfrm/xfrm_user.c                   | 149 ++++++++++++++++++++++++-
 13 files changed, 205 insertions(+), 9 deletions(-)

--
2.30.2


