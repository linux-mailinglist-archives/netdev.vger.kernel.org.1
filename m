Return-Path: <netdev+bounces-106690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CF91749F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B646B284ECC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC36149C6E;
	Tue, 25 Jun 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKQy0p8z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9320146A64
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357429; cv=none; b=MWcs8jl/0DD6trHLVuIyVpWXExYsOZgOcYUjBYXSqkz30lSMM2A7EIrMSDUtehvcAvvBUIyx2ltLgNOTTIQeRLuRZ/xMB6KRKuieHxP3htUhIsVEJKFHnc7b6HWAmtoEgNMjTHqfMkODcvcQm6xVTwS7S4TOcO+TiZi7qynjOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357429; c=relaxed/simple;
	bh=cQMYxRyVTXxLQev4l9DTh3+BNG7mEy5YO2l5igcvI3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp6kjXic1JrQibTj8/yP8LbCYOl6twg9r+LloQrBzzxBziLNUus/kgALxdyL2XpWjJESTYqh73siycpKCNpJoUeOQ4n3LazMU46lozuxVVYy451N1Qom6QZVD++Ctr16GmUbfsm9hGFA9f6KtrPeN7Veoaj/W4ZGF92CVBtP5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKQy0p8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6629C32781;
	Tue, 25 Jun 2024 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719357429;
	bh=cQMYxRyVTXxLQev4l9DTh3+BNG7mEy5YO2l5igcvI3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QKQy0p8z1qIscrERxkW+LxZJm3soIgsrRLvNHJYTp60TrWthA3TAVaiyuCs+eZPKg
	 YPyouXrmjuMg51t7aRKMuGoAMMGy/ipOKyOQErGbO0mYpWIv/NCxgJZDd52czRVO0P
	 9bwKa6oXbPBu3znPkdyRFsbojfBP+UxMVg82WCNMkv79mUCn47ZLIRUQ38uttyYRUm
	 k5AuuVZS0r6FQ5+15U4KhsA9qyZT0uUiA2KGBBva7o7r2P0rnWsK7oJtuEaKhUPqct
	 2O//bDlSteIzWpM28BGiuJZYuXWO9EddoVnXqa8e77mNXgqB1ToLhypOTrQAjz8jWC
	 ohh5oDrPjWbQg==
Date: Tue, 25 Jun 2024 16:17:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Singhai, Anjali" <anjali.singhai@intel.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Boris Pismenny <borisp@nvidia.com>, "gal@nvidia.com"
 <gal@nvidia.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>,
 "rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>,
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
 "tariqt@nvidia.com" <tariqt@nvidia.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>, "Acharya, Arun Kumar"
 <arun.kumar.acharya@intel.com>
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Message-ID: <20240625161707.07642769@kernel.org>
In-Reply-To: <CO1PR11MB499345FE6E5A2056D03DE66293D52@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
	<CO1PR11MB49939F947A63E4A5F8C5246A93C82@CO1PR11MB4993.namprd11.prod.outlook.com>
	<20240621173043.4afac43f@kernel.org>
	<CO1PR11MB499345FE6E5A2056D03DE66293D52@CO1PR11MB4993.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 22:05:13 +0000 Singhai, Anjali wrote:
> 1. Master key rotation, this needs to be not just from top but also
> from device side because of the master key sharing in some cases and
> a common SPI space that can roll over. So need to have an event
> mechanism from device driver back to kernel for key rotation. Please
> add this.

Sorry I don't need it myself, you'll need to add that once my patches
are merged.

> 2. Header additions in the driver, for now we can do this, but
> ideally it should move to the stack, so that it can be common for all
> devices.

That's fair, I only have mlx5 implementation so I wasn't sure how much
of it is reusable. Once we have 2 drivers we can extrapolate?

