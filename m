Return-Path: <netdev+bounces-141008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D09B9127
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DD21C20F36
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CF6172BD3;
	Fri,  1 Nov 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0BQFSZe6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45762563
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464415; cv=none; b=IkdImILqngMgGbF7Jii1ONuoirLrsR/jHatbCK/9Ix+WN5sKlNh4ilmGy/T/WAMOMlImcWxZHj7D9SMgHPgHkV06L2evnIBUIjgHPh1hY1FlSCGa8UHMl3k/XWjMIpys+Pk0VwwMETzVPtUymwhIWMOXqPktQssptjqyRMIxMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464415; c=relaxed/simple;
	bh=ueThmUhoyxaGP1TZf3CQaaH0bUqGHXrhz2C6bp+onM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qogDN+T8VUwi4avUcjE5LwJj9ORZ6ieU+GvOtNy+/vsNYz96odm2ukKAajEgLing7xX6cszUD2Mh3f3J1GoyLLMzANnDS3pBESYlaW5oxEOFHHlXNUHbKZk4uYyY7Qrv3gaF7w5lMOPERSULlxr2PkAaa7UR28JMEn2ze6GXmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0BQFSZe6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q/VLsDwjwU4Mz7XgHOtUjm+RJ7bqHlUHCpXhJQne+Kw=; b=0BQFSZe6TSpSxZB5MCcITuASQO
	062M0bq1AB2myNdc6wq5XzT4ga3qoo9N/UJ6RuNOkZ5/CfZZelarloM9WKGcf/SRXUCTrLri9KlZK
	T9hGOjt4Iqd2RY5LidNwhtEWAp08OIj+kjTzuWs84buBicHwrR4Zflu4RNoL16PrF0+U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6qqB-00BsSd-Uz; Fri, 01 Nov 2024 13:33:23 +0100
Date: Fri, 1 Nov 2024 13:33:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, vadim.fedorenko@linux.dev, hmohsin@meta.com
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <61830f21-f943-4d84-82c1-fce0e2659ac7@lunn.ch>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
 <757b4a24-f849-4dae-9615-27c86f094a2e@lunn.ch>
 <97383310-c846-493a-a023-4d8033c5680b@gmail.com>
 <4bc30e2c-a0ba-4ccb-baf6-c76425b7995b@lunn.ch>
 <e2c12a98-acf3-46df-8831-4b898387bfa0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c12a98-acf3-46df-8831-4b898387bfa0@gmail.com>

On Thu, Oct 31, 2024 at 03:13:40PM -0700, Mohsin Bashir wrote:
> On 10/31/24 5:43 AM, Andrew Lunn wrote:
> > On Wed, Oct 30, 2024 at 05:51:53PM -0700, Mohsin Bashir wrote:
> > > Hi Andrew,
> > > 
> > 
> > > Basically, in addition to the RX TCAM (RPC) that you mentioned, we
> > > also have a TCAM on the TX path that enables traffic redirection for
> > > BMC. Unlike other NICs where BMC diversion is typically handled by
> > > firmware, FBNIC firmware does not touch anything host-related. In
> > > this patch, we are writing MACDA entries from the RPC (Rx Parser and
> > > Classifier) to the TX TCAM, allowing us to reroute any host traffic
> > > destined for BMC.
> > 
> > Two TCAMs, that makes a bit more sense.
> > 
> > But why is this hooked into set_rx_mode? It is nothing to do with RX.
> 
> We are trying to maintain a single central function to handle MAC updates.

So you plan to call set_rx_mode() for any change to the TCAM, for any
reason? When IGMP snooping asks you to add an multicast entry due to
snooping?  ethtool --config-ntuple? Some TC actions? i assume you are
going to call it yourself, not rely on the stack call set_rx_mode()
for you?

> 
> > I assume you have some mechanism to get the MAC address of the BMC. I
> > would of thought you need to write one entry into the TCAM during
> > probe, and you are done?
> > 
> > 	Andrew
> 
> Actually, we may need to write entries in other cases as well. The fact that
> the BMC can come and go independently of the host would result in firmware
> notifying the host of the resulting change. Consequently, the host would
> need to make some changes that will be added in the following patch(es).

And the MAC address changes when the firmware goes away and comes back
again? It is not burned into an OTP/EEPROM? What triggers
set_rx_mode() being called in this condition?

	Andrew

