Return-Path: <netdev+bounces-38038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C47B8B30
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9F9B6281741
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C91F5F2;
	Wed,  4 Oct 2023 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGOLugBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B81B27F
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A765AC433C7;
	Wed,  4 Oct 2023 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445280;
	bh=iOe3yiBqvNEzyZE58IbaBP55/gzFuPI3U1iKp4mINDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NGOLugBfED2lS0FBXQFyKEL2ddul/Oqd9Nh90VHghzHJ/sSYTuOAeXIcSQ7Vx32UD
	 oJisuVjQdO5S8CbdNIvwBCO7E4RLjWlbUeNJAHemewZmRNFh96kHuhjbNlRsiZyeJm
	 QOaaz5n/1oBJ6KiYbZ//G521IxNREIT2U+ArAdCi/boRRfJIAh3ijsfuCkS0WEi1Ht
	 cTuEOROzfLRXuIEm1oC7plr3cWAzeqOcEJHCU4Tx3+eW1SxU1VPqv2/PBbaPhito1E
	 1WbxiIOJ08/Dn1Sbi/9x2qSPWpan49G6P0vKwpc02GF+9aYMDZETk72fp9t8CcJ9xE
	 xzXer6Q/TP7mg==
Date: Wed, 4 Oct 2023 11:47:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Kahurani <k.kahurani@gmail.com>
Cc: xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 wei.liu@kernel.org, paul@xen.org
Subject: Re: [PATCH] net/xen-netback: Break build if netback slots >
 max_skbs + 1
Message-ID: <20231004114758.44944e5d@kernel.org>
In-Reply-To: <20230927082918.197030-1-k.kahurani@gmail.com>
References: <20230927082918.197030-1-k.kahurani@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 11:29:18 +0300 David Kahurani wrote:
> If XEN_NETBK_LEGACY_SLOTS_MAX and MAX_SKB_FRAGS have a difference of
> more than 1, with MAX_SKB_FRAGS being the lesser value, it opens up a
> path for null-dereference. It was also noted that some distributions
> were modifying upstream behaviour in that direction which necessitates
> this patch.

MAX_SKB_FRAGS can now be set via Kconfig, this allows us to create
larger super-packets. Can XEN_NETBK_LEGACY_SLOTS_MAX be made relative
to MAX_SKB_FRAGS, or does the number have to match between guest and
host? Option #2 would be to add a Kconfig dependency for the driver
to make sure high MAX_SKB_FRAGS is incompatible with it.

Breaking the build will make build bots very sad.

We'll also need a Fixes tag, I presume this is a fix?
-- 
pw-bot: cr

