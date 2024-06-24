Return-Path: <netdev+bounces-106247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6F915776
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F091C235DD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BD71A01AD;
	Mon, 24 Jun 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5DhZ1MDG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D322313;
	Mon, 24 Jun 2024 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259048; cv=none; b=kdmM3DO8sSGZ0hcX7xFO16EnbWdtxZ6sAD7V7Mc4PIrANOpaAjcPU1FoC0q1NQ5a3FfmYNqiLYBLRnSYvPBc/+Jkfs3eS9Bk8+mqqw9grjK7bsV91u0uUAKUO3LHsEGtlvohYYcu7TzCuDnT/AxSqxVttgardQvTucDvYorW48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259048; c=relaxed/simple;
	bh=upgGjOgKxNvCRyAmYv5Ll2icNt+vDymQ3iTZeWE0qCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQOhwnElrGNpVh5jDw37mpc4SLuXDuFQzvNI66zXmmYnzzNzI3jvU6iwJ8FZQgYfBZNpb1cxvto5kKKdWxgYhMlT0847MO4JvP1Ywv4kT5p30SQRIEblPjd8rz47nZShVLydv4XpK09gA5yFCiZIOBbSBywuo4FWHBsyd5NHgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5DhZ1MDG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fb9cS9ErNodhZemY9huqhVErgGUP15fGMqWGrjz00UU=; b=5DhZ1MDGxSB6931aB2nA7spgfc
	2G5SGizTpjCq8PmWtUoBDXwfmClahP1kr9XuVKhbPEnAogJFv0fWYytLI+1p2+zGKZLODMfiqKz6V
	alwTrC2R01moO7XJ7x/YWyMTzFs/uHJffkJbwR678aLjARxVcrrAydHXJ8SnOtC9fgMk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLpoN-000sl4-Tj; Mon, 24 Jun 2024 21:57:11 +0200
Date: Mon, 24 Jun 2024 21:57:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 8/9] ethtool: cmis_fw_update: add a layer for
 supporting firmware update using CDB
Message-ID: <34a8b5b8-75ac-45b4-85d4-6b38aadf880c@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-9-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624175201.130522-9-danieller@nvidia.com>

> +static int cmis_fw_update_reset(struct net_device *dev)
> +{
> +	__u32 reset_data = ETH_RESET_PHY;
> +
> +	return dev->ethtool_ops->reset(dev, &reset_data);

Is there a test somewhere that this op is actually implemented?

Maybe the next patch.

      Andrew

