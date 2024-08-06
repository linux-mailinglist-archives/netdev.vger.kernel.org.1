Return-Path: <netdev+bounces-116149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED5949476
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E085A289586
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A34A1799B;
	Tue,  6 Aug 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDU9/Myg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F2622094
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957902; cv=none; b=IB3MzHw34SRdzvVjdCmb6kyxICUTavMgAuBYKD7uwqKEkgnNc5eTLF1j2aFq1w0w7P0iy15RZsU6Y/zKpsQ/4ODSmreQ+ieBToVkjDtZKW76mLVigAMjDk1WBIxUpxJlcfHU660vAKvzW30GALOXnOdOza+jgJ/Q583z1YggTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957902; c=relaxed/simple;
	bh=UQqIkm4zZzILfWaM1mpeuH+fO2MYikREskLWK2pU/s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbYphqQzb3eMaun7vvmnROlSUofUsO1OmeMK/MTESLrw00ss4wsEP1opBOg6pt7OWH/ACROXyaPfUCR34SKBsAQIjcLOIaGPFm1Os1JHz9x01pnjh0nKI2I7A3KZnXcmJKR1pIEZHrfdWkTMK2xWm89K9BDPzbVFiMfHfwTptSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDU9/Myg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D15DC4AF0C;
	Tue,  6 Aug 2024 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722957901;
	bh=UQqIkm4zZzILfWaM1mpeuH+fO2MYikREskLWK2pU/s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDU9/MygWNy8s2slWBHCZ6KOk9LyI6UOtq8ZAccFpNe1blzy+42au6ScyJb07c1YD
	 dQTun70Au17JJIBxVwiVfkVn+BKcPSVSYPDueJuAomtWnO/ENBTXjMDNouN3E06Z4a
	 SGNeelTXQnV1EKxCRNHeCIrcbPXYX8Oj3XjzRSpTOT9SmkdN5HFeqb4So9SRaIpkie
	 P0Ij2uaZ4DzPa1E/GtQm+0dAbASFIQW5YYg3UNcW7QRwuTPdnAaKla/sNgQUZNTsmi
	 M23Dfo+xSAxHP5MnITnnA/Sszx+NIf6tZaL2wvFrlfXoozs9NRcOI+dQd2gfmji4lh
	 dPGp3rqIPXrYQ==
Date: Tue, 6 Aug 2024 16:24:57 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v8 08/16] xfrm: iptfs: add user
 packet (tunnel ingress) handling
Message-ID: <20240806152457.GA2636630@kernel.org>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-9-chopps@chopps.org>
 <20240805171040.GN2636630@kernel.org>
 <m27ccuosuu.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m27ccuosuu.fsf@ja-home.int.chopps.org>

On Tue, Aug 06, 2024 at 06:19:28AM -0400, Christian Hopps wrote:
> 
> Simon Horman via Devel <devel@linux-ipsec.org> writes:
> 
> > On Sun, Aug 04, 2024 at 04:33:37PM -0400, Christian Hopps wrote:
> > > From: Christian Hopps <chopps@labn.net>
> > > 
> > > Add tunnel packet output functionality. This is code handles
> > > the ingress to the tunnel.
> > > 
> > > Signed-off-by: Christian Hopps <chopps@labn.net>
> > 
> > ...
> > 
> > > +static int iptfs_prepare_output(struct xfrm_state *x, struct sk_buff *skb)
> > > +{
> > > +	if (x->outer_mode.family == AF_INET)
> > > +		return iptfs_encap_add_ipv4(x, skb);
> > > +	if (x->outer_mode.family == AF_INET6) {
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +		return iptfs_encap_add_ipv6(x, skb);
> > 
> > iptfs_encap_add_ipv6 is flagged as unused when IPV6 is not enabled.
> > Perhaps it should also be wrapped in a CONFIG_IPV6 check.
> 
> Done, and tested with CONFIG_IPV6=n.

Thanks!

