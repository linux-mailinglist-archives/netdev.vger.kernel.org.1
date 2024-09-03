Return-Path: <netdev+bounces-124338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433C9690D5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC61283C63
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 01:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4AD1A2C1F;
	Tue,  3 Sep 2024 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzSrNgmS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038CF1A287B;
	Tue,  3 Sep 2024 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725325934; cv=none; b=UiqBGHE1GkhnbKxSAZ7KpFkbiPTGVab6j7CnAb87vQyzYRQlrxp21hSMIHjy+zqWRfeSVB8Dl5wuZrEaWY94IK+79r1uR84DRkz/oULaAnAUs0tVRi8TTJ2p1whjIUzG775HHpJP+/I5fhCONOj9vHBLFWOYOyNOVP8+0F/cFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725325934; c=relaxed/simple;
	bh=T/H285DEwZ7StL39iMYzEulcVZmGCvSXusf7aj3byJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1qEFU8fPJgJXhxiPe2QtYTK1107l9X8m7dBF+3NxcT55iDlhrr7huaoGacRfINL0cFklbLG3aNK0Cnw/BLFdaCJmsoe0uT/jNfqOmY9M72N6GhmwtuB4l16RM9mdAYff2Uf/vWUmGecaVkiveSpQoJR8NqxEYENVIQvc6n63p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzSrNgmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEA6C4CEC2;
	Tue,  3 Sep 2024 01:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725325933;
	bh=T/H285DEwZ7StL39iMYzEulcVZmGCvSXusf7aj3byJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gzSrNgmSOwdH5eFA45twgnyKxP+nNA/OOWubcU3CmoJFjRHEQ8A7O7hFN7j6Xa/Eg
	 C11Qy/ps0xQ2Ue7fFge81DSppBvo11s4H18+gs60ceiQ7E9Ds04wnVR/Gi0XSvkD08
	 ucjauj5cocPl27qIDISwRjCs20VX19Yxulb6ZjsQunuyGhvL/fxCkoQd0n/Qgq3A0A
	 XRwNYTRNjX0yDi8GnyELJHamCNhh83/xYqnZ91vTZ4/NofjcBGOjnTb2spT/BJ2oK6
	 mifowFqX/ppRpwEYPsFHzCLVGSVcDFbKbNWUaA2OxWTfPRkifONMPS9A5CxN0lTFpU
	 iQZn7QkK+LuEg==
Date: Mon, 2 Sep 2024 18:12:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
 amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac()
 return drop reasons
Message-ID: <20240902181211.7ca407f1@kernel.org>
In-Reply-To: <CADxym3bkVFApps1wJpSQME=WcN_Xy1_biL94TZyhQucBHaRc5w@mail.gmail.com>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
	<20240830020001.79377-7-dongml2@chinatelecom.cn>
	<20240830162627.4ba37aa3@kernel.org>
	<CADxym3bkVFApps1wJpSQME=WcN_Xy1_biL94TZyhQucBHaRc5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Sep 2024 20:47:27 +0800 Menglong Dong wrote:
> > > @@ -1620,7 +1620,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
> > >
> > >       /* Ignore packet loops (and multicast echo) */
> > >       if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
> > > -             return false;
> > > +             return (u32)VXLAN_DROP_INVALID_SMAC;  
> >
> > It's the MAC address of the local interface, not just invalid...
> >  
> 
> Yeah, my mistake. It seems that we need to add a
> VXLAN_DROP_LOOP_SMAC here? I'm not sure if it is worth here,
> or can we reuse VXLAN_DROP_INVALID_SMAC here too?

Could you take a look at the bridge code and see if it has similar
checks? Learning the addresses and dropping frames which don't match
static FDB entries seem like fairly normal L2 switching drop reasons.
Perhaps we could add these as non-VXLAN specific?

The subsystem reason API was added for wireless, because wireless
folks had their own encoding, and they have their own development
tree (we don't merge their patches directly into net-next).
I keep thinking that we should add the VXLAN reason to the "core"
group rather than creating a subsystem..

> > >       /* Get address from the outer IP header */
> > >       if (vxlan_get_sk_family(vs) == AF_INET) {
> > > @@ -1635,9 +1635,9 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
> > >
> > >       if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
> > >           vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
> > > -             return false;
> > > +             return (u32)VXLAN_DROP_ENTRY_EXISTS;  
> >
> > ... because it's vxlan_snoop() that checks:
> >
> >         if (!is_valid_ether_addr(src_mac))  
> 
> It seems that we need to make vxlan_snoop() return skb drop reasons
> too, and we need to add a new patch, which makes this series too many
> patches. Any  advice?

You could save some indentation by inverting the condition:

 	if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
		return (u32)SKB_NOT_DROPPED_YET;

	return vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni);

But yes, I don't see a better way than having vxlan_snoop() return a
reason code :(

The patch limit count is 15, 12 is our preferred number but you can go
higher if it helps the clarity of the series.

