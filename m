Return-Path: <netdev+bounces-155701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D7A035AC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 04:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD918829C2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6F274059;
	Tue,  7 Jan 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab3mJaPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB14A31;
	Tue,  7 Jan 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736219099; cv=none; b=kprLG3EWm8HkZShde7KH4GZXqwd3ChQg5Kupxi6yYyS4qXLAUpZglI3W1YP97O/DdJpD0NEqeLHYmsMAKl8dFnBABpHBVRZaWa08BnpFa9MCqRGXTY6G9l4m0h9YgAXQY5gXK1a93XRfX97tdi6k9nvCBwJY8Q5TwC79kTUSdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736219099; c=relaxed/simple;
	bh=XRQGQDclMXF3+wJ0brTDCwnprKvS4klWAuuNKV0M2AU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGZ43LOcnMTWOCp2wXaex+UhLMuFHO60S3T0mjWcqjZBGUui5IDwN/2pbO6N0pXbe7KtS2YVnDodrVaRbr+cNPnmD8VTs5egYj0rdZ21Yb01LCfXeP+rwBmCRxem+awooqFNvpwNIl6G+DLQZhJX7YRR5q3HQlCT1dbhqhFr+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab3mJaPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2808C4CED2;
	Tue,  7 Jan 2025 03:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736219099;
	bh=XRQGQDclMXF3+wJ0brTDCwnprKvS4klWAuuNKV0M2AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ab3mJaPO8VG16HhzrX1c7hk/T9oHcGDYGkTFdMfUgKOfjc9RaS+jWQXyHcAI109th
	 n6P4+QOjlv4ktjK69xc2GjwUoMBm7lFT8Skf8bmnJwQykPS+lj7wsmit9pRj5OOmGQ
	 glJRuHcQGeGPPW5CetAM5tqvxKI4aWyjyFQgyKvq/jhKJ0uGk4X5JXu2XPaI5NMLH+
	 bUI5j+BkMUX9k0wRdlXkIAqN0baYoO2osOTq9ORMeu4XERn7NYgyTrFSuwWHroijsp
	 RoeRJnfS0D9buU8lvpub4dWyOJnjIe9NjKOgW4V4IFmpgxDuk7l2wvEk4S+VhoqL2i
	 oPtGPUwIhKArA==
Date: Mon, 6 Jan 2025 19:04:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v7 02/10] net: ethtool: add support for
 configuring hds-thresh
Message-ID: <20250106190456.104e313e@kernel.org>
In-Reply-To: <20250106184854.4028c83d@kernel.org>
References: <20250103150325.926031-1-ap420073@gmail.com>
	<20250103150325.926031-3-ap420073@gmail.com>
	<20250106184854.4028c83d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 18:48:54 -0800 Jakub Kicinski wrote:
> >   * @module_fw_flash_in_progress: Module firmware flashing is in progress.
> > @@ -1141,6 +1148,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
> >  struct ethtool_netdev_state {
> >  	struct xarray		rss_ctx;
> >  	struct mutex		rss_lock;
> > +	u32			hds_thresh;  
> 
> this value is checked in devmem.c but nothing ever sets it.
> net/ethtool/rings.c needs to handle it like it handles
> dev->ethtool->hds_config

Oh, I see you set it in the driver in patch 8.
That should work, my only concern is that this is not how
any of the other ethtool config options work today.
And there isn't any big warning in the code here telling
driver authors that they are responsible for the state update.

So even tho your patches are correct I still think it's better 
to handle it like hds_config, just for consistency.

