Return-Path: <netdev+bounces-219283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD43B40E5B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334237A3C8E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81934AB1E;
	Tue,  2 Sep 2025 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7guYwG/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E72E6114
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843719; cv=none; b=P7R2qJfyvkB3M7gaCE0uPrxshR6HruV3QtgbHuT05BfRvBln7JGtMxlFMxkY5sez95xdkEhcl4NDkjc6oe+jQILK7naxihdotKiOYR9BkgzLOiJ0BnJhR/2YO2Aj3psEscg1Z3+5465fRUUkOsUQ4XrkB2667O64xjWB0vP0Q6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843719; c=relaxed/simple;
	bh=8XxXICposh1reVF1u8udfgmAVlkF+ORZNbLdKff+TRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOcYpWx05olC8CLgl1d0AKrQhcesikr7E4SoN5HbTY1PKqGVRn6Z2ydLLdHMdXXlchyMgWcrHke6vu8wMu4LDPPX7wQmiTvmHGbOWxzIXV+lQvWH7Cwpd0RgKHUTShFeHcrAg4ArodvLBGZNUMSD0IzIHojwf0Qm+iPJJBwf3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7guYwG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA46C4CEF4;
	Tue,  2 Sep 2025 20:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756843718;
	bh=8XxXICposh1reVF1u8udfgmAVlkF+ORZNbLdKff+TRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7guYwG/HGGGNBeBpArVcSYwkPUdSwCskWPG8TDyHg0NKUkaB3bhKtv0esWyfL2nk
	 IzidRJb5P0jVVnEfAWxzYU5elsw6rGMpFooG+Fb8G5VQEoABE+5YPmnGRQvwxNNs9C
	 CadTgMLbRXA9loObzm1hP9upYhc4I9ElSWLN8gle6hHkmoegKTu++Zdcn3PWN9VVLd
	 wDK+yzUq18rwrDyyRCuKUpLeB+IzPCYVVN7OHOL0IXFeAIZPGISzcTSyB14tGmVuOb
	 rsUafYNK9CMuUJLPuE75ZEG26JJI3VgMIo9I9PXkYKq2XwN7UV9W+dMQaAuVaWF5p5
	 fhAqRsur57uSg==
Date: Tue, 2 Sep 2025 13:08:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v10 00/19] add basic PSP encryption for TCP
 connections
Message-ID: <20250902130836.65e4af41@kernel.org>
In-Reply-To: <aLdIUZbwF83DbUiv@x130>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
	<aLdIUZbwF83DbUiv@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 12:41:05 -0700 Saeed Mahameed wrote:
> Also As Jakub pointed out on V7, mlx5_ifc changes need to be separated into
> own patch, "net/mlx5e: Support PSP offload functionality" need to split at
> the point where we cache ps caps on driver load, so main.c and mlx5_if.c in
> that patch have to go into own patch and then pulled into mlx5-next branch
> to avoid any conflict. Let me know if you need any assistance.

Could you take the ifc.h changes as one patch into mlx5-next and send 
a PR, ASAP?

