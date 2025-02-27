Return-Path: <netdev+bounces-170348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E1A4849A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E23BB8BF
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A761DC070;
	Thu, 27 Feb 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="duYvUfIW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850291D90A9;
	Thu, 27 Feb 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672681; cv=none; b=Q6d/QwMPcsd4oKIAKMTN+NufbH38DIx0Xfpdtd89b6qIJsshp+C6ocwNnOawazkT0TzTASMyccBdRiWUAhKb5WWsYjYvIj9C0cHnQu7DXjksMP0s/oZ7Ik+YMWvvSCRX6yRPGD+lfBc6tz75Zwnf/wq8siVpZa4/cePoelA7GlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672681; c=relaxed/simple;
	bh=AasfbRxE5RxG0WVQv7bHsR9rMbwQ2B1BEQlbmPOtDd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZij0nKT1JoobPUEFf3uhQOsfjpBFDySdLn/ipUYpT474wZjAPl3h0mR6OPjkuIPuDzz/ru7V7waiemf1UXrGHe+thVCFCommGvhTVwh26d+W9H1+q6nNqBLCJ2OR7F9ARTkQwlykbvPK5SVMiK2OvFowJwRSpPUgrWe1VzQnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=duYvUfIW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3R+G0Ru66nijwIA8AzEk+aq6Up3B3H5obO4zwh9G9NA=; b=duYvUfIWSCqtN6b670YA4LrKth
	eGlyqL7GgZSVYWL+evwmdpGuNk0aPzh3xZ5/fZFAaDaJ+2OTALsIt5o61+yqWv0khg4VSM8gGUORo
	FbkYrK/F37mhYni+nnVPWHOh7yRD5tgcOE7YLl8L5TB4XCAMBl7hNeaAf/TwE0ey07lQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tngTh-000eCE-MQ; Thu, 27 Feb 2025 17:11:13 +0100
Date: Thu, 27 Feb 2025 17:11:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 0/3] net: phy: nxp-c45-tja11xx: add support for TJA1121
 and errata
Message-ID: <6c37165e-4b8a-41fd-b9c1-9e2b8d39162f@lunn.ch>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>

On Thu, Feb 27, 2025 at 06:00:53PM +0200, Andrei Botila wrote:
> This patch series adds support for TJA1121 and two errata for latest
> silicon version of TJA1120 and TJA1121.

Should the errata fixes be back ported to stable for the TJA1120? If
so, you need to base them on net, and include a Fixes: tag. Adding the
new device is however net-next material.

	Andrew

