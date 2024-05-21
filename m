Return-Path: <netdev+bounces-97400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB648CB4A3
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 22:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF91F2249A
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 20:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA9148821;
	Tue, 21 May 2024 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fvVpODKc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FFC3FB8B
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322889; cv=none; b=oOYiwekynYGmglKPRA7TzSvoORzwyl9OYT2QgWRm2i1+Arz7qqvYKiyf6vj2MZg2SuNSCWHaPHHaZP2X/7uOibVFHAMxOdON4GT3G0SIRUoOf7hHijkuV5xTCJPr2dxnp4vq3rNXPgQ0N8SOO7DE7+PfnYhgRuMA0xFBUM8Hbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322889; c=relaxed/simple;
	bh=+MAw74a0JQdL/ZY8ZBertdyC3ZMCdu1gGe7pDwiLGEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4+CW7Jp1pP0pSBrd0GcoboK//Z6/yj0hsbJQoVX4kcDLwVr6xae6ghqmHuGWEZPHzqomnDm3Z6S9ntfpIGw6OLzvHg5If53K2nK4gUqnOvwkDAVlUwJJuImAOVXejA6HlR0p2ZeqtafXv3p7SPiA1VTvamNdYJP62mHrREuRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fvVpODKc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9/Oe3ECgYir6dat/46lX7n7MsyjSILrOsPoSBNE3Wgc=; b=fvVpODKcEBIt+ySRKQgMCCNlLx
	CnstnrjQdmMUo0S+0jaI7cMWRkeZ6pkr2/HrbPmZrXLMA7c9BoBjKWlM/NC+O8vMxKS3z5dxnKueK
	vmWpDrpA5MUQtQQkhU6aDY5Le6SLIRbWASxYgPyW5hy1fqUA7AkdzyeSXw2Hu1X2yuNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9Vz5-00FmcD-Dr; Tue, 21 May 2024 22:21:19 +0200
Date: Tue, 21 May 2024 22:21:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Michal Kubecek <mkubecek@suse.cz>, Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Message-ID: <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>

> sending genetlink packet (76 bytes):
>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
>     ETHTOOL_MSG_MODULE_EEPROM_GET
>         ETHTOOL_A_MODULE_EEPROM_HEADER
>             ETHTOOL_A_HEADER_DEV_NAME = "eth3"
>         ETHTOOL_A_MODULE_EEPROM_LENGTH = 128
>         ETHTOOL_A_MODULE_EEPROM_OFFSET = 128
>         ETHTOOL_A_MODULE_EEPROM_PAGE = 3
>         ETHTOOL_A_MODULE_EEPROM_BANK = 0
>         ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS = 80
> received genetlink packet (96 bytes):
>     msg length 96 error errno=-22

This is a mellanox card right?

mlx4_en_get_module_info() and mlx4_en_get_module_eeprom() implement
the old API for reading data from an SFP module. So the ethtool core
will be mapping the new API to the old API. The interesting function
is probably fallback_set_params():

https://elixir.bootlin.com/linux/latest/source/net/ethtool/eeprom.c#L29

and my guess is, you are hitting:

	if (offset >= modinfo->eeprom_len)
		return -EINVAL;

offset is 3 * 128 + 128 = 512.

mlx4_en_get_module_info() is probably returning eeprom_len of 256?

Could you verify this?

      Andrew

