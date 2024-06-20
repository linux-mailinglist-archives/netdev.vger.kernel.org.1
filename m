Return-Path: <netdev+bounces-105104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF55590FAFC
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 03:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8BB2837D8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3580101F7;
	Thu, 20 Jun 2024 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlvHl+h3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352113ACC;
	Thu, 20 Jun 2024 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847303; cv=none; b=cVjluA7QZlK9XKcdDukY83nLjFWjVAABxNRnCPJMkytYPZma+0uzZ0K0DSmLT2HWU9xOfenW0K6CMgZt3lELrEQcZ8fBzwM2GTlPfn29gST1QwiO+X0YnNogJTCP9+qB89ZdRUyD9/NBIjDUS3UFMmRhZcTTYxUKSpaPTMBtGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847303; c=relaxed/simple;
	bh=9ktI4LPNXVV+BQFvLQmZDXGh7ooxfS0m2y049M5iUe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIrvjUIjsTqNDyFQDjEd655EdW/nZJe4/VmbrN2N4k0WSzntywLXznfrRsPP15pQAnQDR5olFavKcE0HbnC8iZK6DKR80OqKrqQCucWcJfwbd74U0oCJKLiBSo+vyxHt7NzbaDhRlMiBKPU3D+y/3O6avm9fqw87k1R8RlNLWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlvHl+h3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E92DC2BBFC;
	Thu, 20 Jun 2024 01:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718847302;
	bh=9ktI4LPNXVV+BQFvLQmZDXGh7ooxfS0m2y049M5iUe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QlvHl+h3S4kAdh2OalGsSF6vU99rkNTv1Y7HE+GK5SDlYZPDrV9sAVCnVr1PEUsGn
	 laD9RxCHbPdSJq5om6f1W4SiGrGwvhb3JetTZU6LjLypjilWPRADnQjdfbx7CcBVDh
	 POFsxlP8hycgOp5IiT3LE1uM22GF5D90LxV3g0fVVzmycsSFnrqnTFGjkPjeUZkPuo
	 00YHo3ohCef1WC/YRPCBJc8p9IrLJ9DpQ56SMo8L0jQdmarIHBuEGfWiNFgB1Ixy7O
	 WBNvUv1YpHvTBXw1rMfW2brTG4E/RZwIuhH6tR6EJRc1NdGM051SjvD5Msl1h8mxcP
	 2Iee6ouGdyWGA==
Date: Wed, 19 Jun 2024 18:35:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <idosch@nvidia.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v6 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <20240619183500.5635a7a1@kernel.org>
In-Reply-To: <20240619121727.3643161-10-danieller@nvidia.com>
References: <20240619121727.3643161-1-danieller@nvidia.com>
	<20240619121727.3643161-10-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 15:17:27 +0300 Danielle Ratson wrote:
> +	switch (sk_priv->type) {
> +	case ETHTOOL_SOCK_TYPE_MODULE_FW_FLASH:
> +		ethnl_module_fw_flash_sock_destroy(sk_priv);
> +	default:
> +		break;

The compilers are nit picking on this:

net/ethtool/netlink.c:57:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
   57 |         default:
      |         ^
net/ethtool/netlink.c:57:2: note: insert 'break;' to avoid fall-through
   57 |         default:
      |         ^
-- 
pw-bot: cr

