Return-Path: <netdev+bounces-123522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3623B9652A5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB41DB22704
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6591B9B27;
	Thu, 29 Aug 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5WrG/wI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BF18A927;
	Thu, 29 Aug 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969377; cv=none; b=CoyHyKVCGd9H+jGOUn2lbejeVWK8jlwTurZvPfZyAFZaSpwBymgnfgQPeCl9xlH1/T9gSM4kT5uZ1YZmbl5k/kvYApZ6rF3R3b9lnH49WscfAyMFTSVuOmjyHQfbZv2Ws/YPKmU4GGgWDKsJnfMgXu4aBEFV3al3ir43IytP+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969377; c=relaxed/simple;
	bh=K0yf+BZjYpmo8s/fP7pgZDRDTOVWXRZClgwyLlXQSrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ag0D9O9LdLNaezuqXPpiEDW2Ry5cpckjJKzSk+c/pJQ77H1y6g0x20XM80Hrc1/g8Tz+ddioazh7GNX9mD9up5NigPwOwkXGbTrdw77BQR6neVTJeBZk5NzbhOh//3BcmEWYFBmw+l9swbm1D7lLOOkJvc9zxLvZFZLloqiOfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5WrG/wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B995C4CEC1;
	Thu, 29 Aug 2024 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724969377;
	bh=K0yf+BZjYpmo8s/fP7pgZDRDTOVWXRZClgwyLlXQSrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d5WrG/wIde7Fx5H0kxMod/JaewYpYa/l8z9+83rEy1MTXaQ9eTj5ajYZe10WhlP6P
	 Ux3IfOZfOmI5tmhpoc9Wh62f/VTSzj26wMlSyzf/U++EDPsBhjC9POK3PS7smcZFZ4
	 cdevf9hkfRvQxUI1A0DfLd26nYqKEZSegm8g35wULUsL7WSoRidFnbZrfgjL/8Z9Zl
	 68rv6kSYdjSG2ogOuSy3uogCuIgIyMSyg6acGl29HWb+b4+8ZnjHGmWHGwCBARyur5
	 baA5Mm7dO0q52f49BWCMDPhuUY+/98M0/D2aAlkCgcjcI/dDXZM9F53qG2moi+kYkv
	 no0nvOAO8wagg==
Date: Thu, 29 Aug 2024 15:09:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 4/5] netdev-genl: Dump gro_flush_timeout
Message-ID: <20240829150935.18b3e79c@kernel.org>
In-Reply-To: <20240829131214.169977-5-jdamato@fastly.com>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-5-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 13:12:00 +0000 Joe Damato wrote:
> +        type: u64

uint

