Return-Path: <netdev+bounces-100716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCF8FBA86
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61E91C2157F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87FA1494CB;
	Tue,  4 Jun 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBxb3xra"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAA146D7D
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522441; cv=none; b=E+96XnC36sNEPUDOe2z+pJIC1Vtqz9HjKiTic0Bqmp0wwh57eFA/5CLC0yMggEA3Kri1g37oVen/nohofTlEKaycTTcGpoY/NHJr3F5ZspVYN0zu6s9vkZH7BaX8k7hQZMIm2peLdI2O3ESrTzbS1IND7oteefvakv3lJy8iWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522441; c=relaxed/simple;
	bh=rND62xOz1HfVeRVWmXUMARj5eY0NoLokADTifhRF46k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuVBCNw+U4ShvkNJnVj4euDqXCXeW2RYEe+/try2Vz7GLeKNpN4UwyGNDZ8JJwuj3zD1+NKoSddl/X/KZngayxy9eGsWkaZIiax7jcM0P9cVefY3y/LjX1I5VzISL8B2qt45bLUxVD8c276E1ileL3ATi9RpGu7TGgQw+ZMfVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBxb3xra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CA4C2BBFC;
	Tue,  4 Jun 2024 17:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522441;
	bh=rND62xOz1HfVeRVWmXUMARj5eY0NoLokADTifhRF46k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mBxb3xraaZRBCxSmcVoz3Wxn9uA6svZKS7+RxgeWrorKbCq3qTHKOvxYXHjIN2dpe
	 ZqWnytmEPCbbVS1WUhPFxnSMWMRdEKoRBaY1pUhBFRmAIzk/LadjlGiUO95JTsXEe7
	 wCsjXP7tZb+Bsq3rTzzsrj7yAnkhS3P1uL6MX5lZYtzch6kLRCXOGLm21Ht0as1WLi
	 usa0C891rZMniN4ERoTNtSpRQnRfbC3+k5qpBkKug2v2BXCS7cXfxUhla0nJ+cgZ9A
	 0HvJn7e26e+c0b2FaALqUACQOnA2BZr6LDYwdXAZ/7rgo+5wzdqX9UGJlCz//fwRCZ
	 /NzmVueKwF66Q==
Date: Tue, 4 Jun 2024 10:33:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
Message-ID: <20240604103359.7b7be651@kernel.org>
In-Reply-To: <e0d451be-8c22-332b-bd6b-09edc4d25c97@gmail.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
	<20231120205614.46350-2-ahmed.zaki@intel.com>
	<20231121152906.2dd5f487@kernel.org>
	<4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
	<20231127085552.396f9375@kernel.org>
	<81014d9d-4642-6a6b-2a44-02229cd734f9@gmail.com>
	<20231127100458.48e0ff6e@kernel.org>
	<b062c791-7e4b-ca89-b07b-5f3af6ecf804@gmail.com>
	<20240603161752.70eee7a4@kernel.org>
	<e0d451be-8c22-332b-bd6b-09edc4d25c97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 15:58:02 +0100 Edward Cree wrote:
> > Can we avoid the confusion by careful wording of the related kdoc?
> > "context" is the current state, while "params" describe the intended
> > configuration. If we move the "no_change" bits over to "params", 
> > I hope it wouldn't be all that confusing.  
> 
> I think "no_change" should stay in "context", but be renamed.
> ("params" has them implicitly via setting indir_size to
>  ETH_RXFH_INDIR_NO_CHANGE or key_size to zero.)
> The bits in "context" mean that indir or key has *never* been
>  configured for this context, and therefore the driver should
>  make up a default.  In that case, if the context has to be
>  recreated (e.g. after a device reset, or maybe an ethtool -L
>  changing the number of RXQs), the driver could generate a
>  different table.  (Also, unless the driver decides to write
>  the generated default table back into "context" by hand, the
>  core won't be able to show it to userspace in netlink dumps
>  when those get added.)

Ah, great point!

> So I guess context.indir_no_change should really be called
>  something like .indir_unspecified?

/me looks at the code
We already have IFF_RXFH_CONFIGURED, and corresponding
netif_is_rxfh_configured(). Should we stick to "${field}_configured"?

> Or should the core just insist on handling default generation
>  itself (but then it can't be sure of producing defaults that
>  a device with limited resources can honour), or have yet
>  another op to populate the defaults into params when the
>  user didn't specify them?

Thinking this over during breakfast I concluded we should leave out
feeding the defaults into drivers for now.

The only useful fields we could pre-populate are indir table and
key (useful because it'd save drivers calling some ethtool_default*
helpers). But both of those are fairly complex. Key may not be
populated for dynamically created contexts at all. Indir table
may have different sizes and has to be re-calculated when queue
count changes.

