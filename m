Return-Path: <netdev+bounces-122458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 175FC961658
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D1C1F2495B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD1E1D2F70;
	Tue, 27 Aug 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNXJCnef"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A311D27A8
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781845; cv=none; b=mcqAQOEscSngjAk93FJofz2ty+GwzFvqk2dQy74o4LOqLv8mN2fTSwN8D/rjA/PPjb3ObOMxpLorjCuNIDpN3kE/S8A/h0kUYyg1OS1RMv9WrbncHBOtI9dA1rrY6MXIkbbWmpMopz0wD1ed+1DzXcWjLX/WTLBLmU45gzmg+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781845; c=relaxed/simple;
	bh=XYTyipsWEKmyX1Oq7sVPVf1XltkboVDQ+4gWJR8/wXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHay2namtl2vRZgVti4UgUMCm5Sx1jfY6rK8buDOs2/5h6ks6u2v//dMCcqx+VxkYiQCihoiTJ6ilMJdi3CcCN5GrODi+TCV06k6kBMjul50dYgHGlW11FV8miBw6zNVkIC4c1+AeTJaVDq2LgNXOIgBOHcGa7n3JD8eO5GkPU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNXJCnef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E601EC4DE05;
	Tue, 27 Aug 2024 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724781845;
	bh=XYTyipsWEKmyX1Oq7sVPVf1XltkboVDQ+4gWJR8/wXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNXJCnefsgxTWpdJu8q55yQTO6Gr5m+29uWcp5cgfMImaf6rjfKqTabpCpwmFifrZ
	 IM3ORQhOQMhqVfqxGlQH5xVukeBVF016hO7M+mQvhOxZwpeoSYZdnGzvCaMGtY1AG5
	 gpWfSHC+BS2k1c8+4IGXrjRi96kUoN3nhO4+bZUxZ+toKdxF5C3muiztlf/vO0fQD3
	 oplPGtyl1m351PVR73JIMR8BbuVM508JE9jNwpOlHUkk5Xj3YKX0bS8lbtFXqQf27f
	 MV+WmfmuBEdCH2grLp9aHUXqJ3qjFFc7itdVITsBSFXMboZirTu4lCqhKVD2Hadw89
	 ow8HzF+IQdd/g==
Date: Tue, 27 Aug 2024 11:04:02 -0700
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
Message-ID: <20240827110402.0c8c5fc6@kernel.org>
In-Reply-To: <d66b079f-c6b7-48c5-ba6f-68cc3e43d1c7@nvidia.com>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 19:41:47 +0300 Gal Pressman wrote:
> Perhaps David can show some good will and help sort out the virtio
> stuff,

Why do you say "perhaps he could". AFAICT all he did is say "they
aren't replying" after I CCed them. Do I need to spell out how to
engage with development community on the Internet?

