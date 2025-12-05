Return-Path: <netdev+bounces-243747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C382CA74DD
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEF04342246C
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E623ED5B;
	Fri,  5 Dec 2025 07:35:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891A34EEF0;
	Fri,  5 Dec 2025 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764920129; cv=none; b=QcbhhW2nfDXsBG6fb7Z2IRG4ofGhcaBpvxUT8obuKTJf8ZaJmcvKIG4isFWYpxyVNV9Re3yZX/ozGWS2ESFTxvpkGam/xUTLQmLkjiF6A2LoQErvTK04ydUkAnYG2eobf8yfo76ejJ0zTLSgSMkq9DtXdBjHmfFk9hXSaFibNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764920129; c=relaxed/simple;
	bh=6SQduscJa9+drl+V5KBbvJUgjneSLa7l2tc4wt+SHpU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=O9fBUGDN7HXL72nzhSseipoHl4CkWAOmQKd4HdrCqtouJhreAisbxPVTaWX1pMEJMhEaDlSeCUloHTNoUnA/cxuLHcrTno26J/Q1NC2/tOX7YdrR2DOooWFF080bTNwKimsjDgHfhR7U4/0TIYHeHqJo1P1ALV+wWxcGdlT5+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9E7FB47530;
	Fri, 05 Dec 2025 08:35:16 +0100 (CET)
Date: Fri, 05 Dec 2025 08:35:12 +0100
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH net-next] net: veth: Disable netpoll support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Breno Leitao <leitao@debian.org>, leit@meta.com,
	open list <linux-kernel@vger.kernel.org>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240805094012.1843247-1-leitao@debian.org>
	<1764839728.p54aio6507.astroid@yuna.none>
	<20251204173421.23841106@kernel.org>
In-Reply-To: <20251204173421.23841106@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.17.0 (https://github.com/astroidmail/astroid)
Message-Id: <1764919679.7wwurfe3mz.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1764920068281

On December 5, 2025 2:34 am, Jakub Kicinski wrote:
> On Thu, 04 Dec 2025 10:20:06 +0100 Fabian Gr=C3=BCnbichler wrote:
>> On August 5, 2024 11:40 am, Breno Leitao wrote:
>> > The current implementation of netpoll in veth devices leads to
>> > suboptimal behavior, as it triggers warnings due to the invocation of
>> > __netif_rx() within a softirq context. This is not compliant with
>> > expected practices, as __netif_rx() has the following statement:
>> >=20
>> > 	lockdep_assert_once(hardirq_count() | softirq_count());
>> >=20
>> > Given that veth devices typically do not benefit from the
>> > functionalities provided by netpoll, Disable netpoll for veth
>> > interfaces. =20
>>=20
>> this patch seems to have broken combining netconsole and bridges with
>> veth ports:
>>=20
>> https://bugzilla.proxmox.com/show_bug.cgi?id=3D6873
>>=20
>> any chance this is solvable?
>=20
> What's the reason to set up netcons over veth?

I don't think there is a particular reason to do so, the veth devices
just get "caught in the crossfire", so to speak - if the netconsole
setup includes the bridge that the veth device is plugged into.

> Note that unlike normal IP traffic netcons just blindly pipes out fully
> baked skbs, it doesn't use the IP stack. So unlike normal IP traffic
> I think you can still point it at the physical netdev, even if that
> physical netdev is under a bridge.

yes, pointing it at a physical bridge port works!

I mainly wanted to make you aware of this regression, since it seems it
was not on the radar when the original patch was written and applied. if
fixing it is too much of a hassle/has too many other unwanted side
effects, I do think (hope? ;)) people can live with this restriction. I
definitely agree that restricting netconsole to the actual links where
the traffic is supposed to go out is the sensible choice in any case.


