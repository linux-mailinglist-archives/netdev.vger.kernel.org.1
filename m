Return-Path: <netdev+bounces-157919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE8A0C52E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BAF3A79EE
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE41F9F51;
	Mon, 13 Jan 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obEu3jb3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93421F9F41;
	Mon, 13 Jan 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809717; cv=none; b=iWIoy2m8WlyIMDLlvfIgIz3kP1IXcp9KZ57ZF0Ca7y38t47cWOXv4/jZq/cflMDDmyB4Hz3ju0q1IVyMEZ0wMnktGyHVE0cVk8SSJjw7STGHRRpQqTuonkM4maHm7a0VGnOdYe4tmp2aX9V/fNSStbK9YVP+f1POqfgRZ5FXL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809717; c=relaxed/simple;
	bh=6Pr8sRn/Rq5+odPii8sgehP4s/inRUn/CvARMw36TaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdJKWwKOqgDyGx02oHczHJDneOSGR3sICsDuXC00jDbA7E9uMoyVOJuOi2NxT52AihN10cTsE31MTMtg2YSEWE1JpEElx1leCKEWZNoVGsX9G1gdezIVfvZ2kv5EpOzNdszx2MyKA2smyBdZQwvNlv3T1ZVLwGwq0ZL1fZZIBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obEu3jb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD075C4CEE3;
	Mon, 13 Jan 2025 23:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809717;
	bh=6Pr8sRn/Rq5+odPii8sgehP4s/inRUn/CvARMw36TaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obEu3jb3cK/4jP5A0JHywLxL5xe4+d9LP2Hn+9+P/d/CTFxy4AAigiUX6ngIU/txU
	 u1Nu2fh6X0i5JJv3G/LGowjzjqYJlO+tcHcAsDkE8qwIV14zLRWx6fX+FznRtSRBNT
	 gGwIQEYJWaNOfB0vrY2rpw9Fxfa2nQQFEnjvVkUJlDUv/n3QL74DRMPg6wNH3spZLo
	 NmVP64fnKSGEVgZCR2yhW6MlygXhryFvN8r9PtZBPpm1iKDDR9Fw7M4tzg7AuaZC52
	 vF2vLe6M5oQfbywSb+3eepSMcfvLZxPsGcTqAqYIz0JZX5IRpTL9I3s2fBQ3txIe3v
	 yangHiINDHhfA==
Date: Mon, 13 Jan 2025 15:08:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, almasrymina@google.com, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com, andrew+netdev@lunn.ch,
 hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk,
 sdf@fomichev.me, asml.silence@gmail.com, brett.creeley@amd.com,
 linux-doc@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v8 0/10] bnxt_en: implement tcp-data-split and
 thresh option
Message-ID: <20250113150834.729de40d@kernel.org>
In-Reply-To: <20250111144513.1289403-1-ap420073@gmail.com>
References: <20250111144513.1289403-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 14:45:03 +0000 Taehee Yoo wrote:
> This series implements hds-thresh ethtool command.
> This series also implements backend of tcp-data-split and
> hds-thresh ethtool command for bnxt_en driver.
> These ethtool commands are mandatory options for device memory TCP.

Patch 9 doesn't apply cleanly, could you rebase and repost?

Applying: net: ethtool: add hds_config member in
ethtool_netdev_state Applying: net: ethtool: add support for configuring hds-thresh
Applying: net: devmem: add ring parameter filtering
Applying: net: ethtool: add ring parameter filtering
Applying: net: disallow setup single buffer XDP when tcp-data-split is enabled.
Applying: bnxt_en: add support for rx-copybreak ethtool command
Applying: bnxt_en: add support for tcp-data-split ethtool command
Applying: bnxt_en: add support for hds-thresh ethtool command
Applying: netdevsim: add HDS feature
Using index info to reconstruct a base tree...
M	drivers/net/netdevsim/netdev.c
M	drivers/net/netdevsim/netdevsim.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/netdevsim/netdevsim.h
Auto-merging drivers/net/netdevsim/netdev.c
Applying: selftest: net-drv: hds: add test for HDS feature
-- 
pw-bot: cr

