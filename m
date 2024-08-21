Return-Path: <netdev+bounces-120742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB095A7B3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D718B21852
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 22:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91817BB12;
	Wed, 21 Aug 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcqeNDoY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921E179957
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278692; cv=none; b=H79otHhxcnWKI51MW69NJZh/oa6eO9tVtGat6L47zRsagyBQ7MZfc4xhZmk2qQpovjZ3YULKTylc9B7I0q/MfvIiMOvQkkssBDuIDAP1f6qBIjL8MyBg0v6eMP+UQ4MDaDRJiQFIDgUxwIQeMyUMo/GulNvVXVt8SrUP+toJIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278692; c=relaxed/simple;
	bh=3A+LLgNRSk/dgh7O3KgPEFiw8dy7O/3Y/Ac7vFPGGTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ycp/g7Xd8JDNOxV3dZCI+GQ+0Ni58tjFDwqQNuzPh2Px+7LHr5AD7YeZmkasAzkKHMo8GvzTQjhyEljTFIeOqJv7W9ZzwD9Vr4FZAOaPLZJ4yLp+FMJrm7AsgWTKFRrkPOKdnuZ4LEZx+kUnlwFzzVQn2Didkf7tgPxhtwoyYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcqeNDoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F51C32781;
	Wed, 21 Aug 2024 22:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724278692;
	bh=3A+LLgNRSk/dgh7O3KgPEFiw8dy7O/3Y/Ac7vFPGGTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PcqeNDoYKBV1cstISg8zQzXvWDDBrw+efn/Vj08bnNw+Dq69gV5yRHSf66ntEisE5
	 lAkQBMPCyXZapfC7/T2FRrkXYr5rKpgujTvXRX/IL0+0schq5pHs1TOD0pPhw4nw/7
	 nqFV3K5EZAXWD4BzrmiZLS3sNg3JxpfaQoFpCAHbPJ+CfMixrbMG50t42/c1e76RvB
	 nWur5q/uPabuq3QszKXFeEBpQa2NeohOmp/XC2ybQNUOgVrAJnkt5gYXs4sYbhVYqx
	 Rt3VYyDYI3YyQhzyEngmClCvUAZmWfmahmAK2V3TE6BfkvVMAQ5j8Zu2V6PL3r9xyE
	 5sK3ek0VDOmHA==
Date: Wed, 21 Aug 2024 15:18:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
 <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>,
 "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>,
 "Bshara, Nafea" <nafea@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, "Beider, Ron" <rbeider@amazon.com>, "Chauskin, Igor"
 <igorch@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, Parav Pandit
 <parav@nvidia.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Message-ID: <20240821151809.10fe49d5@kernel.org>
In-Reply-To: <460b64a1f3e8405fb553fbc04cef2db3@amazon.com>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 18:03:27 +0000 Arinzon, David wrote:
> I see that there's no feedback from Xuan or Michael.
> 
> Jakub, what are your thoughts about my suggestion?

I suggest you stop pinging me.

