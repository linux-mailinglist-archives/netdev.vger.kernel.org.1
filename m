Return-Path: <netdev+bounces-61572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C608244BC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC692283819
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E1B23755;
	Thu,  4 Jan 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPz4XUuA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C1241E6
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8ABC433C7;
	Thu,  4 Jan 2024 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704381260;
	bh=v6614NUQxxQFqdzDcCq3mOxpqrODShl6Y7sTIYidATA=;
	h=Date:From:To:Cc:Subject:From;
	b=GPz4XUuAS+tdbWkBX5qY8SKG4QNFpIOirfMh+nDHV36+1neWWm+ZMZNz5r0LBRD5/
	 too1+UymL8iWw955XwylzQxxoO7Q8D3O0sfnarpZbxZBCQDsIVktYWLtGpE2SlOKEB
	 TqKCxK6d5wCHfMPfQ8cylFcDNyfetmE/e4h/j94aB+7cB8A6avN4DEYB6J6Ezbl2Gz
	 JvVzmLtwTu/1ZrOn8X8TE97KYUCFNrV2zgqMBmAFncED7CRdumYZg6r+AJu3BNTgbU
	 XtSs5DwN5nFhhL1X7nD23aAGiLtjxL81oT60Z/C9Z0tPTo+SxwPt9HZzgkX9w8zJaR
	 0IpuA9PfTddRQ==
Date: Thu, 4 Jan 2024 16:14:16 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Subject: ethtool ioctl ABI: preferred way to expand uapi structure
 ethtool_eee for additional link modes?
Message-ID: <20240104161416.05d02400@dellmb>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

the legacy ioctls ETHTOOL_GSET and ETHTOOL_SSET, which pass structure
ethtool_cmd, were superseded by ETHTOOL_GLINKSETTINGS and
ETHTOOL_SLINKSETTINGS.

This was done because the original structure only contains 32-bit words
for supported, advertising and lp_advertising link modes. The new
structure ethtool_link_settings contains member
  s8 link_mode_masks_nwords;
and a flexible array
  __u32 link_mode_masks[];
in order to overcome this issue.

But currently we still have only legacy structure ethtool_eee for EEE
settings:
  struct ethtool_eee {
    __u32 cmd;
    __u32 supported;
    __u32 advertised;
    __u32 lp_advertised;
    __u32 eee_active;
    __u32 eee_enabled;
    __u32 tx_lpi_enabled;
    __u32 tx_lpi_timer;
    __u32 reserved[2];
  };

Thus ethtool is unable to get/set EEE configuration for example for
2500base-T and 5000base-T link modes, which are now available in
several PHY drivers.

We can remedy this by either:

- adding another ioctl for EEE settings, as was done with the GSET /
  SSET

- using the original ioctl, but making the structure flexible (we can
  replace the reserved fields with information that the array is
  flexible), i.e.:

  struct ethtool_eee {
    __u32 cmd;
    __u32 supported;
    __u32 advertised;
    __u32 lp_advertised;
    __u32 eee_active;
    __u32 eee_enabled;
    __u32 tx_lpi_enabled;
    __u32 tx_lpi_timer;
    s8 link_mode_masks_nwords; /* zero if legacy 32-bit link modes */
    __u8 reserved[7];
    __u32 link_mode_masks[];
    /* filled in if link_mode_masks_nwords > 0, with layout:
     * __u32 map_supported[link_mode_masks_nwords];
     * __u32 map_advertised[link_mode_masks_nwords];
     * __u32 map_lp_advertised[link_mode_masks_nwords];
     */
  };

  this way we will be left with another 7 reserved bytes for future (is
  this enough?)

What would you prefer?

Marek

