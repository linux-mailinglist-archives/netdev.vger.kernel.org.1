Return-Path: <netdev+bounces-166601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23BA368ED
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED431705B5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A561FC7F8;
	Fri, 14 Feb 2025 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="agIi6qRj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BD1A83F2;
	Fri, 14 Feb 2025 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574887; cv=none; b=tfRjPQ1c3B7D2AmdTl74nXhGCpjaNLPDNX/c8bdsafl1j2CMV2gFtj5zzvT5OgOmIO4vOt2XFEhET8G6DOza+We64eYAHjUzFjZvqOLrD6b6UCF9Ew6NvCtSwRj06tgRz/nbT5Cd4gAGfdgpyghDE5SWav3QnIfJhbMcGuiQ4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574887; c=relaxed/simple;
	bh=1GnOUs9v0zeK9+TBQU6oA2dEewTonpB1L5pwtVU3N6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw8fqsFp8oAWYwrc+nGn6E1Ya/fVUpcPOPS3xTp4Q+7lpj8VnwUtkLwBBRMkI5UNZtndWUsDJnjpQgDW/oFJRJOvNrwYCcCO0eICI0O7ABLT9Qjww4qDxlC7euWnscTnLDzizKi/aD6vrX9HsvGdG36qRvSRJH3iWlpxVy7dGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=agIi6qRj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lrMbF6SKpzRsZcdU5n3Dhh4SWTlhmlrTpgLKCFyuhaE=; b=agIi6qRjp/+97QHQ6Zdgmr9Rwm
	VSqMZ1gHLlGHfexaWHWdMJ5GWLuKRvkmnu1FPpVjV9mOsrH9p/qeDI+gtiCAZOuxujn/8jsc6YHvJ
	O5eMBNlfyB2xGczQ1otEUA7ClLhAj1Ruhce+hbYXi0eN8WsKruHs/AWB74HgYIla3XHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tj4tH-00EDSy-1v; Sat, 15 Feb 2025 00:14:35 +0100
Date: Sat, 15 Feb 2025 00:14:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: cadence: macb: Report standard stats
Message-ID: <19e578ec-b71d-4b22-b1db-016f19c5801d@lunn.ch>
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
 <20250214212703.2618652-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214212703.2618652-3-sean.anderson@linux.dev>

> +static const struct ethtool_rmon_hist_range gem_rmon_ranges[] = {
> +	{   64,    64 },
> +	{   65,   127 },
> +	{  128,   255 },
> +	{  256,   511 },
> +	{  512,  1023 },
> +	{ 1024,  1518 },
> +	{ 1519, 16384 },
> +	{ },
> +};

static const struct ethtool_rmon_hist_range a5psw_rmon_ranges[] = {
	{ 0, 64 },
	{ 65, 127 },
	{ 128, 255 },
	{ 256, 511 },
	{ 512, 1023 },
	{ 1024, 1518 },
	{ 1519, A5PSW_MAX_MTU },
	{}
};

static const struct ethtool_rmon_hist_range axienet_rmon_ranges[] = {
        {   64,    64 },
        {   65,   127 },
        {  128,   255 },
        {  256,   511 },
        {  512,  1023 },
        { 1024,  1518 },
        { 1519, 16384 },
        { },
};

static const struct ethtool_rmon_hist_range bcmasp_rmon_ranges[] = {
        {    0,   64},
        {   65,  127},
        {  128,  255},
        {  256,  511},
        {  512, 1023},
        { 1024, 1518},
        { 1519, 1522},
        {}
};

static const struct ethtool_rmon_hist_range mlxsw_rmon_ranges[] = {
        {    0,    64 },
        {   65,   127 },
        {  128,   255 },
        {  256,   511 },
        {  512,  1023 },
        { 1024,  1518 },
        { 1519,  2047 },
        { 2048,  4095 },
        { 4096,  8191 },
        { 8192, 10239 },
        {}
};

static const struct ethtool_rmon_hist_range mlx5e_rmon_ranges[] = {
        {    0,    64 },
        {   65,   127 },
        {  128,   255 },
        {  256,   511 },
        {  512,  1023 },
        { 1024,  1518 },
        { 1519,  2047 },
        { 2048,  4095 },
        { 4096,  8191 },
        { 8192, 10239 },
        {}
};

Could we maybe have one central table which drivers share? I assume
IETF defined these bands as part or RMON?

	Andrew

