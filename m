Return-Path: <netdev+bounces-203835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA9AF769E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744E54E644D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A122EA16A;
	Thu,  3 Jul 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QGlOh+YN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCNqWh9b"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430D2E7F12
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551342; cv=none; b=q7Ttu76OGv2hHbkfKWmM1nrTyawR9Wn5v4Q/XNiBmD4qAtryCyYqXvuLID56mu2PWMzVVzTL1cIBmDl0zR4qEEIioDgjZRCAqPuB4H0i26UxPFgdGdITjMzCKCYt9rw1m2cFieB1JZG1mlisjxy8CifYsj+d6YKqywmxPwDvDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551342; c=relaxed/simple;
	bh=jmlR8sVdyKjMSOhiF/OQGtXNE0vMN6QZOXB5rOxdqDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWsELFJEVT3uZ/JLUSTftTyJNnLc9o8JpymrF5uKIVoya78/BWDq9jziZpQWTEfK9fMJxUpZ+A823E1UD6Nec/Yixj4iQiJaKIKx9Rjoo3GZZkBBWng3pOyj4ywmy7H89pUOj3tbJTY+kF2Z0+A8Q6oXaSbR912T+VeEz1Zm0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QGlOh+YN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCNqWh9b; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C92127A015D;
	Thu,  3 Jul 2025 10:02:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 03 Jul 2025 10:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1751551335; x=
	1751637735; bh=nUhKb/OYv1RQz4wb8zJ4zPaNb681U3QPzd8Xk110poA=; b=Q
	GlOh+YN0PjmGCKxqA7Uw5vYHiNpKTNha0lXA+E64UymKRLRGBOeigJo+zijUDECE
	4wRLu84DBt0BncKDHY51G0H+U1XTXy3/EjRoIRpIRXhVunQ0QguRxjpFjRgHtgpw
	aOz4e5eWCX48Akbor2+6d1azf1ObpKFJR4b+WNhuIHzhztEAL0nx2hLSdgz/CCVr
	+GT3Zw2wrP07sElvCVtJcQc/NWfbjf+8sAv2xaQARZs0jLNtQsk5oG69gTeVTNiP
	fFyV1WqbLNRYzCmIqRz75odwPxsVp4vivXP22bxhqmWUqxN+ppMo3SPnits4WwD5
	6fCcaRUeZlHlb+VbVhn7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751551335; x=1751637735; bh=nUhKb/OYv1RQz4wb8zJ4zPaNb681U3QPzd8
	Xk110poA=; b=mCNqWh9beheinZHODvcAVJ0noiG9dlSBaCWrOhBBlP9iS28npp+
	gWjI3Xo04j73lq8POk5AvLY7iTzCiQ69GmRuAbu63f2+0tJlo0sRTax/zcowo4jl
	xfJ8BPWffh/cboI0RAtfWrjUL1dYdncbbZCp4zqzCCN+ByuP01EhrU9CIiYWrq8c
	RMR31nwVaolfvCNEU2itYDJmd9sLz5cRwIaIzQSo4656bY+dccZiRtHdfI4jEDTK
	yDxe6mQ2WgHCXEWwdgJcV6o5cgZZOaYS3taQyyhroNa510Q9Kjdga/+Ev6Una/2u
	uJCHcW9ef68RgrcztC+FwwOoSl6XlEjyqZw==
X-ME-Sender: <xms:Z41maJZXW7qspooc6bqPTFTkAfuuG5rOsO32w7MtAbL3cTs5JcXScA>
    <xme:Z41maAYr04PCu7mOlO2G_YbpuXwMJrzlCYt516BPwZPlk8oJibhAHomOIrO06lFHV
    LUhBBDNc4UL4v2q5k8>
X-ME-Received: <xmr:Z41maL8Nea4p1NIWS-94lYDfaRv0pbJtciQx3SXgoRtpbvd8OoVVT7QKyDMC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeetueeihfekgefhueefteefkeeijedvvdeuueduheegvdetleffjeelkedu
    tedvveenucffohhmrghinhepmhgrihhlqdgrrhgthhhivhgvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihs
    nhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrlhhfsehmrg
    hnuggvlhgsihhtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgv
    ughhrghtrdgtohhm
X-ME-Proxy: <xmx:Z41maHrg255NOdAQbA1Xft49gSTlD1Z1ai2Vtbb3sE2hOzGOLvsDYA>
    <xmx:Z41maEr0ByhACO4z2yWGHYbmbrTImt-eW_wOxtLh-7tQ7qrgfH53fg>
    <xmx:Z41maNQb_BF889wXXXOMaGIRYtHOuXLwTLwCDdEwTWd5_tk3qpKNUw>
    <xmx:Z41maMriZRsKGMQjS34F6-gHleTecyHlgLsi6EBiwCCsoDXYmotxPw>
    <xmx:Z41maBPwpO_6edavbN974dQfhp-FXBk_HbBk0z3m-I4teFTqUmd_FyTG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 10:02:14 -0400 (EDT)
Date: Thu, 3 Jul 2025 16:02:12 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/3] ovpn: propagate socket mark to skb in UDP
Message-ID: <aGaNZAUvuh68ljK9@krikkit>
References: <20250703114513.18071-1-antonio@openvpn.net>
 <20250703114513.18071-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703114513.18071-2-antonio@openvpn.net>

2025-07-03, 13:45:10 +0200, Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> OpenVPN allows users to configure a FW mark on sockets used to
> communicate with other peers. The mark is set by means of the
> `SO_MARK` Linux socket option.
> 
> However, in the ovpn UDP code path, the socket's `sk_mark` value is
> currently ignored and it is not propagated to outgoing `skbs`.

Probably worth adding a small selftest? (not necessarily as part of
this series, though I think it would be ideal to have the fix and the
corresponding test together)

> This commit ensures proper inheritance of the field by setting
> `skb->mark` to `sk->sk_mark` before handing the `skb` to the network
> stack for transmission.
> 
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> Link: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31877.html
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

A Fixes tag would be welcome for all those bugfixes. For this patch:

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")


With this:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

