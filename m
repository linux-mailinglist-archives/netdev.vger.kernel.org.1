Return-Path: <netdev+bounces-121523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD53B95D80A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DB72817BE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C421953BA;
	Fri, 23 Aug 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="SYIHC3Vj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QnvbyAbW"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DD192B89
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446110; cv=none; b=Y7a3Xf4u9QxjAEDPPF2sccMs2K9OVb84gyHPKFNn/hNr0n4o4yjAG1l98MvbS0ot3crlKvnl2xbzrXihQzAnJ8ld9+NHdy0YruObqOXMeXm8qt23NuLAEe1HrwNcHBfGd1EjGsh9RGQbUM7zHsCCbIEmM+1V1GQkE+35PU+gSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446110; c=relaxed/simple;
	bh=eqIV3buavZPOozmbhk4DGQqIDxbjnsf6rHn1QhJMcTY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=CtL2hD8c6nXxhUgXCx/kkour7ZTq6lkhQNxs+zbWaeMRX9r8YQ0DSejhEm/qZdgT1HdfG/KB9PsJarF+qP1D+CtxjPszhBUFnkqFxNeO63e/Ytkohwl/JUguLG7c227bqvZhuer4PlWpOgOmnQJGPf2w+4I3b7tqu4FQoXZWTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=SYIHC3Vj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QnvbyAbW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 636881151AB6;
	Fri, 23 Aug 2024 16:48:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Aug 2024 16:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1724446108; x=1724532508; bh=AFiRZjc8ZK2PNMC6cMz4K
	bbkFLZM735+7/VSVDzO0ME=; b=SYIHC3VjLQfhKSjgC8o/7Cy0Kr2/Tx9g85IK5
	GrXjh04dtreoohImBPepFiVLOGI85HKjLGUYrjmLX6QaWe8QEZ6CZIXc47I8w7VZ
	+PJEnPidOChMPbuKIYX0myh3rvjfeUxLiw0vGcty2AEXhenKd2o8qtcbaEw9NDUl
	fi6/dyV0X0JZtnmDuxocF4SM/YHb6pn230QqVRs6hMRKNKlHZFNWF35F1meySH5V
	SD4RA+3kgobilNUrGzvcmbPzwSdTuN6uCbXX9po9HuDJNwtCCgso8FpcvNIuJOF9
	FdsK9IC9LCG5k0A85oejji5PurBtp0n86r26rxZQgynZRYGvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724446108; x=1724532508; bh=AFiRZjc8ZK2PNMC6cMz4KbbkFLZM
	735+7/VSVDzO0ME=; b=QnvbyAbWahtqrBeyNMldMkXJdQWCbgAwi1LWbfZqjlmj
	eVYLd3B8ZGEtZDgAArEG1Ige8oDjToCy6+u7HinAcnK8m7mEeSNbFxpc+fBTpE9c
	pdu+9bJZGxRc9zjZvajhgC7iJ7Outq7r3rJ1ngyJThmfDP0iEt9X5LAlvXV0IBzr
	pbhFZTx++wunxldGOCieDsIbGGDOghW4gzUg4XX8nFN/oPsf/qRqQbs/x37m9k/l
	7Kx1WY0HdSV+N4xzFTGhJAcnM/FNzrE/PHZX63nNoVAnlnCAhgH8KGqYHfrftzUL
	VBn4BqixCVh4NH54PZVN4jvMsAoFiqCCLGucJ27DnA==
X-ME-Sender: <xms:m_XIZv2oBPE79xoIlVCa3ApTGSHByExNh-A1E9MGuZlRXVnNAS2QQA>
    <xme:m_XIZuFdAUbw_hgWlyhFj66DoaO9fW1vGZQDXoJLNTqhR14ckwyNGYN3vlJOd5DCO
    0PFDge5fhGVv6zWnMk>
X-ME-Received: <xmr:m_XIZv52uambe6nSKqHK9CmLNeJlzTSxP7Wyxfv2kpUAIhGkPUEegHnTvPUiZJPKt1FB3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    vdenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeeuffevvddvfedujeefuedugfdtgfdutedtveef
    ieelfffhgffhtdejkefhiedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhho
    shgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtphhtthho
    pegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhhrghngh
    gsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirghnsgholhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtohepthgrrhhiqhhtsehnvhhiughirgdrtghomhdprh
    gtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvth
X-ME-Proxy: <xmx:m_XIZk1K6x9IGo6eXimktGue6UFzxmQJ8QaYwv7iqM74HXCyK2FJgQ>
    <xmx:m_XIZiGVL33b1T5bRs7Nu6GVMZKsJYUAo0c7GZAGhJEHdHBAqmh9cg>
    <xmx:m_XIZl_BkKZoLn0apSZdHUU4SszzRad_Vl5ZgiCHvhkXII2LC9bKFg>
    <xmx:m_XIZvlAjxEDTyc3-Xn3Gv3kDy4aBCp_M1mK213K47GS1Pe_Ql7v_w>
    <xmx:nPXIZpdxYQugrCb-i-ZquzW_0zg_FiTW0hpkOLviOMxHK-xFNBnxoTXe>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 16:48:27 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 4FB189FBF6; Fri, 23 Aug 2024 13:48:26 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4C9589FBC2;
	Fri, 23 Aug 2024 13:48:26 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Eric Dumazet <edumazet@google.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
    Sabrina Dubroca <sd@queasysnail.net>,
    Simon Horman <horms@kernel.org>,
    Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv4 net-next 0/3] Bonding: support new xfrm state offload
 functions
In-reply-to: <20240821105003.547460-1-liuhangbin@gmail.com>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 21 Aug 2024 18:50:00 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <195354.1724446106.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Aug 2024 13:48:26 -0700
Message-ID: <195355.1724446106@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
>xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
>added by Jianbo's patchset [1]. I will add the bonding xfrm policy offloa=
d
>in future.

	These look ok to me from a code point of view, but I'm not
familiar enough with IPsec to comment on whether those aspects are
correct.  A cursory examiniation suggests that none of the new functions
being called might sleep.

	For the series:

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J

>v4: Ratelimit pr_warn (Sabrina Dubroca)
>v3: Re-format bond_ipsec_dev, use slave_warn instead of WARN_ON (Nikolay =
Aleksandrov)
>    Fix bond_ipsec_dev defination, add *. (Simon Horman, kernel test robo=
t)
>    Fix "real" typo (kernel test robot)
>v2: Add a function to process the common device checking (Nikolay Aleksan=
drov)
>    Remove unused variable (Simon Horman)
>v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com
>
>Hangbin Liu (3):
>  bonding: add common function to check ipsec device
>  bonding: Add ESN support to IPSec HW offload
>  bonding: support xfrm state update
>
> drivers/net/bonding/bond_main.c | 97 ++++++++++++++++++++++++++++-----
> 1 file changed, 84 insertions(+), 13 deletions(-)
>
>-- =

>2.45.0

---
	-Jay Vosburgh, jv@jvosburgh.net

