Return-Path: <netdev+bounces-145176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271259CD631
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 05:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A339B2318B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABFB7346D;
	Fri, 15 Nov 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1bAB0is"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C392F37;
	Fri, 15 Nov 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731644562; cv=none; b=MLrxizgHRSA/HATZbwezMWMv/N6VWvBdM+1r4u3K6zjK5XQ579Ev0SsCN/q0x8TaYPo6TCwuppCkrHgI48M1/iwZW+nxSj7WeQid5byNrOmfZ0kjP/J4AxoIv32/kA5BISXCdaxdLnMfUrcwsEoyM1FiQfmNsXHTiYJzjS6kDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731644562; c=relaxed/simple;
	bh=m7B26eLPxM82/IheoSRtmtSfessm8pmWpHudPdVi9jY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9Dd5HhIHNExbkHBWw6RyecsTe2HRPzSYdqb0I+ASNSIlC70nZAVKIHveU6zErhHiEJWx/p0p3oWvyw9arRpBawvmKkdVlWD51jJ/Q/fCeMXCCOQVkg7OYtqUtzvJKCxduDVinOrQvMg+KGtSwipNb9BH1iL6lCdKnU9cIQOGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1bAB0is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49611C4CECF;
	Fri, 15 Nov 2024 04:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731644562;
	bh=m7B26eLPxM82/IheoSRtmtSfessm8pmWpHudPdVi9jY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i1bAB0is4HUz75eU66efBln6zDxtrstTaBLEPdSh9KgXqrtGx1rmc5oOYYQsJpmoP
	 n7M9nTZ7ME9gz3gxTFP9uAEFe4CAIA4BXK4bh/SvBn4vJwFuoCdLx/i842EG54jrSx
	 STV5O+0mBkNl3IskrCImgVjmKVqPUtXQj9yOrbGGaakWP1tFnARfqpwhUmaSmOZD7v
	 taFZkWuQtLuAMG+aGQLrhroGvvPDIUg1zpXdMpVOtXU13PXZXrKIoTDRMRv9RbRXCo
	 YKekIXNU1uOVEcIZ+6Ta02WYcnVPhfMzQJgO1pOc32mvG30oAQnQjNNAUZBbKkgU2q
	 QBUNFD7w5ggpQ==
Date: Thu, 14 Nov 2024 20:22:39 -0800
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
Subject: Re: [PATCH net-next v5 2/7] net: ethtool: add tcp_data_split_mod
 member in kernel_ethtool_ringparam
Message-ID: <20241114202239.3c80ef6a@kernel.org>
In-Reply-To: <20241113173222.372128-3-ap420073@gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
	<20241113173222.372128-3-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 17:32:16 +0000 Taehee Yoo wrote:
> When tcp-data-split is UNKNOWN mode, drivers arbitrarily handle it.
> For example, bnxt_en driver automatically enables if at least one of
> LRO/GRO/JUMBO is enabled.
> If tcp-data-split is UNKNOWN and LRO is enabled, a driver returns
> ENABLES of tcp-data-split, not UNKNOWN.
> So, `ethtool -g eth0` shows tcp-data-split is enabled.
> 
> The problem is in the setting situation.
> In the ethnl_set_rings(), it first calls get_ringparam() to get the
> current driver's config.
> At that moment, if driver's tcp-data-split config is UNKNOWN, it returns
> ENABLE if LRO/GRO/JUMBO is enabled.
> Then, it sets values from the user and driver's current config to
> kernel_ethtool_ringparam.
> Last it calls .set_ringparam().
> The driver, especially bnxt_en driver receives
> ETHTOOL_TCP_DATA_SPLIT_ENABLED.
> But it can't distinguish whether it is set by the user or just the
> current config.
> 
> The new tcp_data_split_mod member indicates the tcp-data-split value is
> explicitly set by the user.
> So the driver can handle ETHTOOL_TCP_DATA_SPLIT_ENABLED properly.

I think this can work, but it isn't exactly what I had in mind.

I was thinking we'd simply add u8 hds_config to 
struct ethtool_netdev_state (which is stored inside netdev).
And update it there if user request via ethnl_set_rings() succeeds.

That gives the driver and the core quick and easy access to checking if
the user forced the setting to ENABLED or DISABLED, or didn't (UNKNOWN).

As far as the parameter passed to ->set_ringparam() goes we could do
(assuming the new fields in ethtool_netdev state is called hds):

	kernel_ringparam.tcp_data_split = 
		nla_get_u32_default(tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT],
				    dev->ethtool->hds);

If the driver see UNKNOWN it means user doesn't care.
If the driver sees ENABLED/DISABLE it must comply, doesn't matter if
the user requested it in current netlink call, or previous and hasn't
reset it, yet.

Hope this makes sense...

