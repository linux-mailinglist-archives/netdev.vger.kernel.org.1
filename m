Return-Path: <netdev+bounces-123526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDFC9652EA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363BE2835E8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05E18C324;
	Thu, 29 Aug 2024 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3FjH4LB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4A1898E5;
	Thu, 29 Aug 2024 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970668; cv=none; b=sJrUj4h1jxhPTc4zCjtlEimUpK4S7pzQMo5hIKpSIoKJGRfiG5iN0S2Fy3FMnmVaiLUggMZIwjru2tX/0x51YNhltMG4qjqLKfg04DHXhgB70Et2ro/DrYxCok2yPc15HFcXMhPPn+RdD2veDOxftExu+fWxA42zTQ7bp4o6gOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970668; c=relaxed/simple;
	bh=GmUtugi96RylMyNbK1sQ3Q2qj+mOwcN3Uj6cKe70mQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3nhQ+sajMSSlX7jetjJ7BfaibvUWJ+NwVWjkUL6JsbrxcrazmIIVNoch2QB3tCvM864b/opPtCIoNfIkAqepTmCxJEuatI997ki9kk4bxH/x8/jmVs4A2A26GiwpWv+3xbwuu7PyS5rR2BQkXbfbareH9Xk0Y+hnfH1TCJLbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3FjH4LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F187FC4CEC1;
	Thu, 29 Aug 2024 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724970667;
	bh=GmUtugi96RylMyNbK1sQ3Q2qj+mOwcN3Uj6cKe70mQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V3FjH4LBvU+ACitWhSGudNT1zydTrjaUcBkMoyI9YXKATbFumtR9Xtwj/dVZlqzVR
	 Xe+WgwjKWfztrxpie+NjM4HphRfecgf3zoB1P280OPA5zo7fmuIcteiSgS3pMNHn1w
	 hOVSD0iVUyBord2SnXOV7/TkzikilcEmkLywe3ufGRQkju5qYbrvS8NkiKyixqIHU2
	 6hVxQYo2y1dRwNKq5c6TLWPUZWKLI6xAF2VdDjhmBch/kEhVb1y/SOwUzq7YkGHdtS
	 1aatcJNwZZztQWPsVM9vnNGfxpEQvIO81pwl+m4d0jpI4SBJnP8nEy5+nFHtfyEjmA
	 txAYoZguptnWw==
Date: Thu, 29 Aug 2024 15:31:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20240829153105.6b813c98@kernel.org>
In-Reply-To: <20240829131214.169977-6-jdamato@fastly.com>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-6-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 13:12:01 +0000 Joe Damato wrote:
> +	napi = napi_by_id(napi_id);
> +	if (napi)
> +		err = netdev_nl_napi_set_config(napi, info);
> +	else
> +		err = -EINVAL;

if (napi) {
...
} else {
	NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID])
	err = -ENOENT;
}

> +      doc: Set configurable NAPI instance settings.

We should pause and think here how configuring NAPI params should
behave. NAPI instances are ephemeral, if you close and open the
device (or for some drivers change any BPF or ethtool setting)
the NAPIs may get wiped and recreated, discarding all configuration.

This is not how the sysfs API behaves, the sysfs settings on the device
survive close. It's (weirdly?) also not how queues behave, because we
have struct netdev{_rx,}_queue to store stuff persistently. Even tho
you'd think queues are as ephemeral as NAPIs if not more.

I guess we can either document this, and move on (which may be fine,
you have more practical experience than me). Or we can add an internal
concept of a "channel" (which perhaps maybe if you squint is what
ethtool -l calls NAPIs?) or just "napi_storage" as an array inside
net_device and store such config there. For simplicity of matching
config to NAPIs we can assume drivers add NAPI instances in order. 
If driver wants to do something more fancy we can add a variant of
netif_napi_add() which specifies the channel/storage to use.

Thoughts? I may be overly sensitive to the ephemeral thing, maybe
I work with unfortunate drivers...

