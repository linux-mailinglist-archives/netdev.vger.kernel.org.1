Return-Path: <netdev+bounces-106239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC8915716
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323B6B20968
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB219FA75;
	Mon, 24 Jun 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ehc26ce9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7319EECD;
	Mon, 24 Jun 2024 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257038; cv=none; b=mrWY/SPZNXwe++jYujO9peceR3dHBd1RSYm9JGyHOezsN0GWvTR3VueZcq5BcKPZzCVCpEH9hhXeuqoWwLTfFW8Zn5IgcE2pvVtO6c4aQCcqUZbnB6TMjKIY2laKt/vewDojadYof/ky+ZMIuHQmUXHvZwlWdq3I+9G8UFstCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257038; c=relaxed/simple;
	bh=uS45FsoDnmGhqd1yyIKYROBb8wY/xZoRPYuHuZCNOd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFrrFpgTkOLmRXOEVmG73qg6RaPU3//4IoBmuaw3INt9Sqagfy3UOQIf6iuzzzvv06tXvu2f6zbS41FwxSKS3F0hYp9/Hm4xBQZQKNrX7QDEfXw3JzBBSFg9yhm+PtYSo2Jy5LwbnjLunHG8LykBlFJiN/5x8GwASMfPKRr9He0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ehc26ce9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LDPuana11XaeCfLjbxgCsmZdocdME4soGyTWYePyut4=; b=Ehc26ce9Z4UTlbakqaCm1XtxvI
	a5JrE48XWCLfrJPMgg973CIAnV1/K3gMvsDEl+0DMqWNumSZfhlSjezkjYPY2N3DWeq9AMyTSJk90
	WRlhY6w+TM161ur71zyTTtPsGqLQAV9UPXu+zkEK8Z8jrf3Lzbe08FfEUqz1HLcaR/Pg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLpHy-000sZR-6X; Mon, 24 Jun 2024 21:23:42 +0200
Date: Mon, 24 Jun 2024 21:23:42 +0200
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
Subject: Re: [PATCH net-next v7 3/9] ethtool: Add an interface for flashing
 transceiver modules' firmware
Message-ID: <f17b31a1-e2c3-4a7b-bdd1-53606627a16f@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-4-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624175201.130522-4-danieller@nvidia.com>

On Mon, Jun 24, 2024 at 08:51:53PM +0300, Danielle Ratson wrote:
> CMIS compliant modules such as QSFP-DD might be running a firmware that
> can be updated in a vendor-neutral way by exchanging messages between
> the host and the module as described in section 7.3.1 of revision 5.2 of
> the CMIS standard.
> 
> Add a pair of new ethtool messages that allow:
> 
> * User space to trigger firmware update of transceiver modules
> 
> * The kernel to notify user space about the progress of the process
> 
> The user interface is designed to be asynchronous in order to avoid
> RTNL being held for too long and to allow several modules to be
> updated simultaneously. The interface is designed with CMIS compliant
> modules in mind, but kept generic enough to accommodate future use
> cases, if these arise.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

