Return-Path: <netdev+bounces-122470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0596171E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88571B211DA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B484D34;
	Tue, 27 Aug 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8H9YBrm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C5770F1
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783998; cv=none; b=MNpOOq6OueUcqIvUrMO4FMwtXq6lO4tX7PaTf59nyGbCYM8DvSxl6wpRA1rig1O+LakkTfzPoxryqysrVDxWObcfbdvAWBWDqaayLBH9H9FCwmcka63AoX873bPZclASier5Fhs5t5Gog4OKFY67LB2kWfg5zFt5HGh6yQuhByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783998; c=relaxed/simple;
	bh=2zP8fL38EeALubD4Ee5znz+AOHfPp707vnQdFXBCCPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTKbYKAEXTt1ZRYig7zzdLU86ip+C/Cvz9y2GQWHckh4UtCWsuPHITQdhpwGfmhf59XNWDRbKzb3cbhCIseznDnXr4vvko2ZVvchddl4SqxwFeMIA76VEjd4nelEj+GftURDSXPu1NSKzr0bxcJiEB6nd7pnQdNeJ1LeV8zCPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8H9YBrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5B4C4E698;
	Tue, 27 Aug 2024 18:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724783998;
	bh=2zP8fL38EeALubD4Ee5znz+AOHfPp707vnQdFXBCCPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D8H9YBrmSxP3UKQ1BZV2YtRO3zsli/YCJyTcg477XGp65qsxuk8BWoOb7WnJ2/xPr
	 KME8Zcp+Oc9onHVBloq9Dtgh3MM7cfM4hpC9my0FbvJ0UP6BBc9gErWT8AsGFy2Fmz
	 VuS0mjsakiRZz0SULnVOA9VktdKX88c3p5GzPcuXn7FxK9jU7tULqKGM91KTk3r4O+
	 p58faBozwptXHjXTL3GzT2lSbCGzezDiDZcMjj6SXGOotQnQDXtIkHrMOrdh+jE2tE
	 Q4lXJEuLOv/0zhW+kDqjv9Reng1lK8HKCDW8CZ+eeysJK3kjj4J4TIsGT3Qkfo6YYE
	 +KIRJYZ99v1Kg==
Date: Tue, 27 Aug 2024 11:39:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "Arinzon, David" <darinzon@amazon.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>, David
 Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky,
 Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Beider, Ron" <rbeider@amazon.com>, "Chauskin, Igor" <igorch@amazon.com>,
 "Bernstein, Amit" <amitbern@amazon.com>, Cornelia Huck <cohuck@redhat.com>,
 Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Message-ID: <20240827113956.6f007a66@kernel.org>
In-Reply-To: <a4448066-7278-4fc2-b859-4de7a555e7f2@nvidia.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
	<20240813081010.02742f87@kernel.org>
	<8aea0fda1e48485291312a4451aa5d7c@amazon.com>
	<20240814121145.37202722@kernel.org>
	<6236150118de4e499304ba9d0a426663@amazon.com>
	<20240816190148.7e915604@kernel.org>
	<0b222f4ddde14f9093d037db1a68d76a@amazon.com>
	<460b64a1f3e8405fb553fbc04cef2db3@amazon.com>
	<20240821151809.10fe49d5@kernel.org>
	<d66b079f-c6b7-48c5-ba6f-68cc3e43d1c7@nvidia.com>
	<20240827110402.0c8c5fc6@kernel.org>
	<a4448066-7278-4fc2-b859-4de7a555e7f2@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 21:33:55 +0300 Gal Pressman wrote:
> > Why do you say "perhaps he could". AFAICT all he did is say "they
> > aren't replying" after I CCed them. Do I need to spell out how to
> > engage with development community on the Internet?  
> 
> My phrasing is due to the fact that I'm in no position to tell David
> what to do.. I just got the feeling that he didn't get your hint.
> 
> I understand your motivation, but my point is that even without him
> being a "good citizen" these counters are already out there, should they
> really block new ones?

Agreed, not great to block them.. Unfortunately it's literally 
the only lever we have as maintainers.

Amazon's experience and recommendation needs to be communicated to
the folks working on the virtio spec. IDK if they follow the list,
but there's a process for the spec, and a GH PR to which I linked.

