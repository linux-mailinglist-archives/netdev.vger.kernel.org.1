Return-Path: <netdev+bounces-155263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB9AA0190F
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 11:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0958C3A0265
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ABE1465BE;
	Sun,  5 Jan 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UJZxZ8Hm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F902145B21
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736073709; cv=none; b=A9lYCP9rwXzmuPow1vgwczrHue8kHEtN0QczPixspTss1D/Zi5e/7y16Nzfer8gaM3iBSPKj4TqA6p2O3hD/AjR0/vZqlEC8AnEMdd49rMQEp6WQvCU5vAJr0++i+WBGK9C7cMZsKTB5s88j8GFDzqxhXJwFDIAFS/jiOKOkA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736073709; c=relaxed/simple;
	bh=BIgFATLRDoxmIQOxc9R3NjS7wUdpqhSaXKSK3Lz1JZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5zF7v8P5MG624Tj0lAzIl3YAazK4JHH78zW5ftFEP+Mfpw1DVpnPDfUvYrWYvG2DMkEEVqpT5YcEfUeQvCkxBOtYJo7RgMADXaQSAT6KaC5eBY3595wl0UA0TDbQAsRShBH2BULU9vCtDfp4mX57OwhPFBl0y7DCzYU9SLBvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UJZxZ8Hm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SGqrtcpkm3CGzZZm5VE0Uo6+6TgwNgq+xj1G4w9m9n4=; b=UJZxZ8HmYCGMXOwgXvjxqaL2n7
	q8vFRSPbGRkGMGoZEkEdbpeudv+42lFu3wkVVuGKYTXMXjUIykXDtHBrD4YcqNr/b7iT1mfNeNjXG
	CJrjknBZ9jYVPXMXZG5DcGzNmYmmmDbFhwXg2224mIayy5pRYkQ6oJm+cS57lWxfu67b2Hl4ZDN0K
	oLazQx5l7Y5RdYvVb2qgyB7mRFTTKU8Vjqm8Kdu0rc+l3jJS8r0pjgeO7aYe1DspXo1JzIjn7k3MG
	3e8CTJTDQ8J9ayK9gD63AWvYijkWiMjQ4X3KdbWVlhuSaaZueVQeqYAsRZFnOqU8dj+miGAUPYYmB
	KfLTpHmA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41870)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tUO4g-0004h1-2N;
	Sun, 05 Jan 2025 10:41:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tUO4a-0003Ek-1b;
	Sun, 05 Jan 2025 10:41:32 +0000
Date: Sun, 5 Jan 2025 10:41:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com,
	marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
Message-ID: <Z3ph3P9AFankiZxW@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk>
 <87zfk974br.fsf@waldekranz.com>
 <Z3bIF7xaXrje79D8@shell.armlinux.org.uk>
 <87pll26z2b.fsf@waldekranz.com>
 <Z3mxsEziH_ylpCD_@shell.armlinux.org.uk>
 <87msg66uh4.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msg66uh4.fsf@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jan 05, 2025 at 12:16:07AM +0100, Tobias Waldekranz wrote:
> On lör, jan 04, 2025 at 22:09, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > Host system:
> >
> >   ---------------------------+
> >     NIC (or DSA switch port) |
> >      +-------+    +-------+  |
> >      |       |    |       |  |
> >      |  MAC  <---->  PCS  <-----------------------> PHY, SFP or media
> >      |       |    |       |  |     ^
> >      +-------+    +-------+  |     |
> >                              |   phy interface type
> >   ---------------------------+   also in-band signalling
> >                                  which managed = "in-band-status"
> > 				 applies to
> 
> This part is 100% clear

Apparently it isn't, because...

> In other words, my question is:
> 
> For a NIC driver to properly support the `managed` property, how should
> the setup and/or runtime behavior of the hardware and/or the driver
> differ with the two following configs?
> 
>     &eth0 {
>         phy-connection-type = "sgmii";
>         managed = "auto";
>     };
> 
> vs.
> 
>     &eth0 {
>         phy-connection-type = "sgmii";
>         managed = "in-band-status";
>     };

if it were, you wouldn't be asking this question.

Once again. The "managed" property defines whether in-band signalling
is used over the "phy-connection-type" link, which for SGMII will be
between the PCS and PHY, as shown in my diagram above that you claim
to understand 100%, but by the fact you are again asking this question,
you do not understand it AT ALL.

I don't know how to better explain it to you, because I think I've been
absolutely clear at every stage what the "managed" property describes.
I now have nothing further to add if you still can't understand it, so,
sorry, I'm giving up answering your emails on this topic, because it's
just too frustrating to me to continue if you still don't "get it".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

