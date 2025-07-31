Return-Path: <netdev+bounces-211105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B857B1698A
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 02:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7431AA09B1
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 00:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940DA32;
	Thu, 31 Jul 2025 00:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTI02V6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6EA2D
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753920403; cv=none; b=JA9yTXgh4GN0XlOEGAA8HNzBfdDS4yni9Ja0TpzTGHAuBwdwvdldanFHTf3Jjf1G6WOOoN+zIHhpe+cEEJ4GFrooRZkFWROEGWkiq2sCmW0qxOf1XK4Gsq5+aEk7XUMe3whjUhbm3hSu70KXkBwEmBbe8ODbhEO2XJB1PgCYIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753920403; c=relaxed/simple;
	bh=0IOU8j6hPh3L47Z/f7CXNjePDbmFmQU3pdmkv15foN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9V0CUc2Xg6xCXZXuSAGI6dzm2RhdZ//1VG8phfqvL6g4uG3tipr9a29atl7x6y3uupiMZBCZiEc5M6r7HncfCL63EX3jrAbw0lp3nqgFYszHUgJ0UYdSO/xyLAs/xELosYSoZARaUT0/CMeWrPtdqO1GsVbqr6dGZuD2CwALYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTI02V6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6549EC4CEE3;
	Thu, 31 Jul 2025 00:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753920402;
	bh=0IOU8j6hPh3L47Z/f7CXNjePDbmFmQU3pdmkv15foN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lTI02V6wmqdfjpGUEpGdab7YrJPb1gXMvf0EgbDrVwZN9lCu6MF3stqYjnxG2jN7T
	 bmFRS8EY32gPxBYmsuvrX162vxk3OKKBW/C5tu4+tq0Q7su08+bZZlgK8JCEQUOgyZ
	 PrWFFBHHYG8hDN0s+VjtzoTxQn9AR/7CHiCF704g+fH2amdvDlkNOqQGKgGRvZRRe7
	 wNAgkpB73ezh6P1GD53DHk/O4byTXQV/A04cZi9AXt9m+tzr8S4Eq7STybIikk1dGh
	 ozU4CGkJIOU6dCdk81rhR3huCAiw8crS2NicgLIZZP1z7k8gooKCxDIqPgvqopuWE9
	 2EEVJYwyE3UoA==
Date: Wed, 30 Jul 2025 17:06:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>, Simon Horman
 <horms@kernel.org>, "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
Message-ID: <20250730170641.208bbce5@kernel.org>
In-Reply-To: <55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
	<20250714165505.GR721198@horms.kernel.org>
	<CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
	<b7265975-d28c-4081-811c-bf7316954192@intel.com>
	<f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
	<20250730152848.GJ1877762@horms.kernel.org>
	<20250730134213.36f1f625@kernel.org>
	<55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 15:10:45 -0700 Jacob Keller wrote:
> > FWIW I will still object. The ethtool priv flag is fine, personally 
> > I don't have a strong preference on devlink vs ethtool priv flags.
> > But if you a module param you'd need a very strong justification..  
> 
> I think just the ethtool private flag is sufficient. The primary
> downside appears to be the "inability" to easily set the flag at boot,
> but...

I haven't played with udev in a while but it used to have the ability
to run a command / script when device appears. So that'd be my first
choice if how to hook the setting in when device is probed.

