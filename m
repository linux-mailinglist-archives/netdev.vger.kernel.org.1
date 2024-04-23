Return-Path: <netdev+bounces-90534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE998AE6E6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F69FB23188
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A5127E12;
	Tue, 23 Apr 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gMqIsohm"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46427E765
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876546; cv=none; b=CzRu9DCu3h/95majB8C+5CnYHlWkq3PuJaBUBqNAVq0PtLESfzCjkvGGCXHi9JUd+GjO4w6Jenzz9glnK+JxkLIVu7RdLqIUuKFcsP1EgiIRX6mUv1AUJ/CN/LwfDD8PX8+agG2zjvMmTeSD1Vb/sdFxFtc2pYmgY1yfVUJu3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876546; c=relaxed/simple;
	bh=PEaHPyRWdC2vlCZldOD6tTtUMOeM14ID4vQm6qq6+Ao=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ULpkce0UgP0N4O9vJA1fMehWh47if+ZETcuXF5gkkXdNVO/c/guo5Mq85sbh/5xlCEm8Ne61H3vQGOjfVNi6+ao6Ys+FdhTB0C+Lxg4YC4kviEzgYEoEfuNPo6DRQN2ir3y/b4NG5TQhFyiIMEGBM/WEVZYXs4jRpvyTcyE8sks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gMqIsohm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3A752207D8;
	Tue, 23 Apr 2024 14:48:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJmZ5eFXd-Y6; Tue, 23 Apr 2024 14:48:55 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AB055207D5;
	Tue, 23 Apr 2024 14:48:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AB055207D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713876535;
	bh=sJpAz3ZL12uPhh2YJMujiNka98ma11ETIjxh5z0cHn4=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=gMqIsohm1IyaupZHwp6K2LHJjoZtWLVqBugBwnFrPgZq9YeHH5X9zOwUs5pX/j/C+
	 TfBb1lxEEVxovbqL93S+M/defNLvarCL9XpRdSdJLrYQHoVeK8Jl8tvESwIvozkm9v
	 FXFqlY/gL7yG1T1oypfMAydM94IyGmF/UTt31iZWxtJSIYlf9FCXW6LYr03jXqZ1a7
	 CXm9qmZnSfpXHGd3kxRj+GvVz3xl0+PJbLvOeEUcyrdSWO+GXOS/VW3RQd7yVUcqwM
	 1h11ljwnuzQrmJdBO7TRI1+NQCfibLU5TWFUq/95DBeRxv3skiQV1IE9zpMLt7tGxU
	 gFD0B5oRKYIwQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 9D9AA80004A;
	Tue, 23 Apr 2024 14:48:55 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 14:48:55 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 23 Apr
 2024 14:48:55 +0200
Date: Tue, 23 Apr 2024 14:48:48 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v12 0/4] xfrm: Introduce direction attribute for SA
Message-ID: <cover.1713874887.git.antony.antony@secunet.com>
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
 net/xfrm/xfrm_state.c                  |   5 +
 net/xfrm/xfrm_user.c                   | 149 ++++++++++++++++++++++++-
 13 files changed, 202 insertions(+), 9 deletions(-)

--
2.30.2


