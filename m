Return-Path: <netdev+bounces-128310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAB978F3C
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218981C21A48
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7B113B7A3;
	Sat, 14 Sep 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl4ukgfL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492F43149;
	Sat, 14 Sep 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726303860; cv=none; b=BVi35CemFCO0aMV+OZbT7QvPrQPnCUepwggwos3BfbvYNHxdC7JZutpv4ptvShrfIOhsPiQNrVZvEyZ2MC+pCAhvrKoOi/iF3fYgBIN30SJlsOOxw7ULkdSdmZ+7XvdWUkrjjMaDpR0qSdYzSrrHng/m0A3jgA3wWbzRQ9+8L+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726303860; c=relaxed/simple;
	bh=U1Xe8VWc9lPnI26ycrtkx58exZ1JVi2vN9lSMIIHdKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0x3u1fzU3hnq+VNt3jzOYgiu6Q2rsOjNPcVTQT73m5806hf39yJexpdEArNWhjfPgVioCHC82EABP3YrWlv111t+sdjG+BKbF5P5KRXC5voW8HRGvTKS7dHg7nFJ5eBl0veQIOy8GzQ6iVV8gYIhUQ5nPEkuF/MOGoK69JirGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl4ukgfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BF8C4CEC0;
	Sat, 14 Sep 2024 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726303859;
	bh=U1Xe8VWc9lPnI26ycrtkx58exZ1JVi2vN9lSMIIHdKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dl4ukgfLu9/GFBMk1Qx08zxWceaseD5a+J/WKg0kCoCXcJg3jDxoaDQhdl8dJ7hZa
	 kmgCN64MxshYhGaDaVsOQ2/CfOzw7GITRaixJEKW6NYUEIUaHq1Yn8yN7mZ7dypHjP
	 4SmtAzG/lPRxwq2om2k38FrpQWY27FfbdZVm/wcHrlYBHMQrmhoh3X2uY09z+S4be2
	 Vx90Q2No6JU1Pv6xxMTPRGe2jIJrBwHEMknhnHM8bp5UGSCVoHUjfbla+qcfXR65hX
	 cPzs3625kpzxhDv2tWMx5wqJQgMHwjZJtvb2aZZ1WBmzQxpVwYD4bIp29hYlhtsW5f
	 KUHjDFDB4x26A==
Date: Sat, 14 Sep 2024 09:50:54 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: dsa: populate dp->link_dp for cascade
 ports
Message-ID: <20240914085054.GB12935@kernel.org>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
 <20240913131507.2760966-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913131507.2760966-4-vladimir.oltean@nxp.com>

On Fri, Sep 13, 2024 at 04:15:06PM +0300, Vladimir Oltean wrote:
> Drivers may need to walk the tree hop by hop, activity which is
> currently impossible. This is because dst->rtable offers no guarantee as
> to whether we are looking at a dsa_link that represents a direct
> connection or not.
> 
> Partially address the long-standing TODO that we have, and do introduce
> a link_dp member in struct dsa_port. This will actually represent the
> adjacent cascade port.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

...

> @@ -307,9 +308,23 @@ static struct dsa_link *dsa_link_touch(struct dsa_port *dp,
>  	INIT_LIST_HEAD(&dl->list);
>  	list_add_tail(&dl->list, &dst->rtable);
>  
> +	if (adjacent)
> +		dp->link_dp = link_dp;
> +
>  	return dl;
>  }
>  
> +/**
> + * dsa_port_setup_routing_table(): Set up tree routing table based on
> + *	information from this cascade port
> + * @dp: cascade port
> + *
> + * Parse the device tree node for the "link" array of phandles to other cascade
> + * ports, creating routing table elements from this source to each destination
> + * list element found. One assumption is being made, which is backed by the
> + * device tree bindings: that the first "link" element is the directly
> + * connected cascade port.
> + */

Hi Vladimir,

Another minor nit from my side (I think this is the last one).

Please consider documenting the return value of functions that return
a value using a "Return:" or "Returns:" section.

Flagged by ./scripts/kernel-doc -none -Wall

>  static bool dsa_port_setup_routing_table(struct dsa_port *dp)
>  {
>  	struct dsa_switch *ds = dp->ds;
> @@ -317,6 +332,7 @@ static bool dsa_port_setup_routing_table(struct dsa_port *dp)
>  	struct device_node *dn = dp->dn;
>  	struct of_phandle_iterator it;
>  	struct dsa_port *link_dp;
> +	bool adjacent = true;
>  	struct dsa_link *dl;
>  	int err;
>  

...

