Return-Path: <netdev+bounces-126057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58A296FD32
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCE61F226B5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347A13E03E;
	Fri,  6 Sep 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LRgmsziq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D913D251;
	Fri,  6 Sep 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657407; cv=none; b=FTZMlR8XcMdF7FpSfA8zyYFRk45bwTkFttuV4VPhMxslh51l/cV9MwQQvaPkFuK5veSL/FK0skIfJEah4+zAK0LDNpvJC0TA0v0FlxNI7qlIugb7Tq9yOb/GWNRpUMuGeqgcQx/dV4FoBQy9KmvD2VC59ca9kS3P27m7LnLHn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657407; c=relaxed/simple;
	bh=YJoSs7rfpvyOmkdHjTVZWEY5+o9w4HmCrB3tnvXbIKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTCRyeiivbtrxgFH3JyOEUbTbW04zmvPzJ0P23+VZAKVTb5YizZelZsz1z61yMHWvaoyl/GB8l0FGHO9kyY5EWze6DgnynrvhZbnTsokAHMtVQksRgnBMLH1q8XsH0UwERCvc5CohlVwRMfDu9sM1bf2xHL3leUjmOCpNWglqr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LRgmsziq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8nFQHo2ghyhvokHZ6+EGLSubemTGhRk/G+4dRIbMtbY=; b=LRgmsziqFqunwIT6m6FdlhMbpB
	2Ta4V3S2iBQ+IuAW4S6p9MjpLJRdCSDTgZwCZitXANJQsDZEU7vXutCLCuWHP3eXrWqfEXuOAtr7l
	p1Z1BwVC1cyrXSHLze5GQw1rO6qYCGfpMhf1AewYr4QHffDWJv5wHSjMkhu0SE7I9+ME=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smgJk-006rO3-5P; Fri, 06 Sep 2024 23:16:32 +0200
Date: Fri, 6 Sep 2024 23:16:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Daly <jeffd@silicom-usa.com>
Cc: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ixgbe: Manual AN-37 for troublesome link partners for
 X550 SFI
Message-ID: <ac2faac2-a946-4052-9f61-b0c1c644ee59@lunn.ch>
References: <20240906104145.9587-1-jeffd@silicom-usa.com>
 <becaaeaf-e76a-43d2-b6e1-e7cc330d8cae@lunn.ch>
 <VI1PR04MB5501C2A00D658115EF4E7845EA9E2@VI1PR04MB5501.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5501C2A00D658115EF4E7845EA9E2@VI1PR04MB5501.eurprd04.prod.outlook.com>

> It turns out that the patch works fine for the specific issue it's trying to address (Juniper switch), 
> but for (seemingly all) other devices it breaks the autonegotiation.

So it sounds like you need to figure out the nitty-gritty details of
what is going on with the Juniper switch. Once you understand that,
you might be able to find a workaround which works for all systems.

    Andrew

