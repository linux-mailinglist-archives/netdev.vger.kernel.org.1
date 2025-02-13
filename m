Return-Path: <netdev+bounces-165767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919DA33505
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAE4188AD9D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED8132103;
	Thu, 13 Feb 2025 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOklJTdD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8718EB0;
	Thu, 13 Feb 2025 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411727; cv=none; b=YgZJZmRut8re6J2fi/E7jS9AR1ZmoaLch7sYGhJJHSc/GOx2/B4EfFzZp55KuPfoJveVV128xg8i2gNFUEB7vHAU3wP5E3aOy7sBCNd8msRnsiPs5pR9jOyqbkbLJEJ7Iac2uxTix+Qimth4wLslBrdu8l5p4ay5DA/m+kDqJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411727; c=relaxed/simple;
	bh=iHz3/lz8by3vyfJfWdwvgvbN/HigLmoOkJ804e/e2OE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ybh7r4J1PbZJ27PKFZv8Be0YPkfzu5nDeronvSli2exu2EPDbuDUWhAD114gyW/lC+RG+pFPJ0b/T/cncdGHKe6kjLbJuYxQP711djgSnYx9zelo5o8JhpnIyrtGPUFNi/w9SAIfPE7XzpfjXcsaCzP60BFxijYwbyprWV+cydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOklJTdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E09C4CEDF;
	Thu, 13 Feb 2025 01:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411726;
	bh=iHz3/lz8by3vyfJfWdwvgvbN/HigLmoOkJ804e/e2OE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uOklJTdD9MPwJna+bt6mER7qr7rzwQqUrG/tLpLMhJWROffn2rfqcos/ZRxog2+cB
	 rk9RsOprMWjZBQa5D9GsDwPGgIddTd2nmDebMAd3i6ChvOiaN3WtKyGttk+wNR4a8R
	 qlE++skhleUYz1BzPX6SpCpvdhnkW/MRq4f6XJ/4Ck96JDWDyio/HHkdISfao8Q4vi
	 DaL8/Sfxbsl9Zrmx+8DZDY0I0+Wh5u8xaPJ0Hqiyzi6UMF7gltkvZIPsxiiBoG6Fqo
	 bYfEJ3VG+dtFBkLg4IA8xRAiAwRNdiVZthYp8ypHlAv0bny4/wTKgqa+0uuhR8tAVv
	 qrJT9QcYsfF9A==
Date: Wed, 12 Feb 2025 17:55:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, Louis Peens
 <louis.peens@corigine.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Pravin B Shelar <pshelar@ovn.org>, Yotam Gigi
 <yotam.gi@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dev@openvswitch.org, linux-hardening@vger.kernel.org, Ilya Maximets
 <i.maximets@ovn.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v2] net: Add options as a flexible array to
 struct ip_tunnel_info
Message-ID: <20250212175525.4e658590@kernel.org>
In-Reply-To: <d98d0c20-741d-4d87-b39e-5aa8eed4624c@nvidia.com>
References: <20250212140953.107533-1-gal@nvidia.com>
	<f9adb864-8ed5-4368-a880-b2aac8aac885@intel.com>
	<d98d0c20-741d-4d87-b39e-5aa8eed4624c@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 20:13:28 +0200 Gal Pressman wrote:
> > You could leave this macro inplace and just change `(info) + 1` to
> > `(info)->options` avoiding changes in lots of files and adding casts
> > everywhere.  

+1

> I'd rather not, having a macro to do 'info->options' doesn't help code
> readability IMHO.

It'd avoid having to explicitly cast the types everywhere, too.

