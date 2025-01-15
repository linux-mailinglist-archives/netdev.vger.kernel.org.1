Return-Path: <netdev+bounces-158600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB4A12A41
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C33188AD47
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFB8189F5C;
	Wed, 15 Jan 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqkLEpP0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968B5223
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963636; cv=none; b=ZbtsvPvtCDurL8HQ0DCS/sUJvv2JDIxPRji/69oRq2htUq+isGy8PVS0E1vKyyt+PjGRJNxDQYSqNBRc+hOGrFpjnWbR2UMH0TO8rOUDBLawBc8HYbRlDANRHCQke0DLwTlUplAfzc6c37xWkKadcFe0IMTpbvd/9vGh1LPUzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963636; c=relaxed/simple;
	bh=MxM1f4F929uFKL3kH0qwfcmWJtgy9V/Xe2D6XWlWZQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVd4GiBiX/sZddMixTIvo+qykJueZ6MfvnWnx4SUwKpfRRfEGb538G7rY/i/7IL45Kr9NeT++YPCtVi8XeLlfubp4S3tH+3lou2pdffuEBU5ga1sBF2hZlaRuxP0WBgKSxEsqVK/aAFZFegfzK+zadjuGmlo3TPxiQqfPwIqHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqkLEpP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB20C4CED1;
	Wed, 15 Jan 2025 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736963635;
	bh=MxM1f4F929uFKL3kH0qwfcmWJtgy9V/Xe2D6XWlWZQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqkLEpP0AdBqDn0+nwtn2lc1nYZboN7lSRuhuyZ/1od/+ndqHp5kPszu52q5JIxFL
	 PahS3/cwZEyyjBHFGx1pqpmJlL+zjXm0+YBpP40e3SnfqCeETEbjGXpVFFqDgQWsYN
	 pCW2IgY4WpoA7DjuCVWcWkdsij2NKymCfJMie9yMOXuVa2O1dNOYxCDxD7X01Ba4mR
	 kxFAAA0/6tU+mNgaj6EmPO0gEFswFSq9tk5WnORL2Uu6hNGIHXP8tZlEbNvdQCVRMD
	 yX2WwiQswzHW9eRfaVADMAdaK5ThHaV4wSuhjMzaz55FxCf01jXUUjJACJRc7JmTBZ
	 S3eROr+AQedww==
Date: Wed, 15 Jan 2025 09:53:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 03/10] ethtool: allow ethtool op set_eee to
 set an NL extack message
Message-ID: <20250115095353.32a4f7e3@kernel.org>
In-Reply-To: <545f25c5-a497-4896-8763-fe17568599ef@gmail.com>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
	<e3165b27-b627-41dd-be8f-51ab848010eb@gmail.com>
	<20250114150043.222e1eb5@kernel.org>
	<545f25c5-a497-4896-8763-fe17568599ef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 18:46:35 +0100 Heiner Kallweit wrote:
> On 15.01.2025 00:00, Jakub Kicinski wrote:
> > On Sun, 12 Jan 2025 14:28:22 +0100 Heiner Kallweit wrote:  
> >> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> >> index f711bfd75..8ee047747 100644
> >> --- a/include/linux/ethtool.h
> >> +++ b/include/linux/ethtool.h
> >> @@ -270,6 +270,7 @@ struct ethtool_keee {
> >>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
> >>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
> >>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
> >> +	struct netlink_ext_ack *extack;
> >>  	u32	tx_lpi_timer;
> >>  	bool	tx_lpi_enabled;
> >>  	bool	eee_active;  
> > 
> > :S I don't think we have a precedent for passing extack inside 
> > the paramter struct. I see 25 .set_eee callbacks, not crazy many.
> > Could you plumb this thru as a separate argument, please?  
> 
> I see your point regarding calling convention consistency.
> Drawback of passing extack as a separate argument is that we would
> have to do the same extension also to functions in phylib.
> Affected are phy_ethtool_set_eee and genphy_c45_ethtool_set_eee,
> because extack is to be used in the latter.
> Passing extack within struct ethtool_keee we don't have to change
> the functions in the call chain. So passing extack separately
> comes at a cost. Is it worth it?

I doubt it will be uglier than stuffing transient pointers into a config
struct. But we will only know for sure once the code is written..

