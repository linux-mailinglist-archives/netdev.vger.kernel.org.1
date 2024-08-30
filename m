Return-Path: <netdev+bounces-123804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20F5966909
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC111F21565
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA6A3DBB6;
	Fri, 30 Aug 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji35NO57"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5053161326
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043142; cv=none; b=pSvytrMOiKjtHyH/fi532XHWvj65tIZpsNhkpCGJztKGiAkeIU2bGjHTRAMyAoytyQALv8muoC534jpqr3c504rdkysjImFGNOZ2QEvDQGY3mhS/I4pdD016eRi0Svd5nVd3wz2arFoRPxeG5Ec06pCRYXKr4kmfNLOeR7KiBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043142; c=relaxed/simple;
	bh=+FNB0A+ZfQZEONkif8a4AtC96GYJQ09mwFqBFIdEIWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSl/B+GfqpUwz2rmQkEUmFSLOwUlKyuuV7o3pUZb0zC+ZBjYQjNuei/DX0Ak4o2GmZ2trMx/DWJY4U+gTp4le0LYoga+vayI9NDlC3iil3Cbae/uqAKOekWMyJu5s7a7hFjG6SE509N4YttESdV8ZS3d1CL3rqNg06O7ZIdh650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji35NO57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEF7C4CEC2;
	Fri, 30 Aug 2024 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043142;
	bh=+FNB0A+ZfQZEONkif8a4AtC96GYJQ09mwFqBFIdEIWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ji35NO57+040w7GP2YXQX+rUOiqmpm80A/Ht3wvP+Np6VPf7KuaDeplS68Z6kMxa3
	 cDdj/+epX8sFvJQZ1kz6f7olm/WH9zwyw0BZLgW48/8esk609HZaFiVi6omvKEPQlL
	 YJPLCcGNHrrt3q4Y0mpK46MQgp25b2K5Y8f/5ZpgyZJTfC6G5RCNSOVcSinRF6Pi9C
	 1ioO0/b+9F7IXvusRmy4lyKjSl2qyga5DsI1kPZlcBquR/jUOqETOagygzMAncY1br
	 H8SSmNnmc0FGTg3MMJpjhMW+50Naay9Sx+I7SCj8TZUzmoozsomL3y12Gx3iSPSuS0
	 1qcrHa/FeZ5uA==
Date: Fri, 30 Aug 2024 11:39:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get
 operation
Message-ID: <20240830113900.4c5c9b2a@kernel.org>
In-Reply-To: <57ef8eb8-9534-4061-ba6c-4dadaf790c45@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
	<20240829182019.105962f6@kernel.org>
	<57ef8eb8-9534-4061-ba6c-4dadaf790c45@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 12:55:05 +0200 Paolo Abeni wrote:
> On 8/30/24 03:20, Jakub Kicinski wrote:>> +/* Initialize the context 
> fetching the relevant device and
> >> + * acquiring a reference to it.
> >> + */
> >> +static int net_shaper_ctx_init(const struct genl_info *info, int type,
> >> +			       struct net_shaper_nl_ctx *ctx)
> >> +{
> >> +	struct net *ns = genl_info_net(info);
> >> +	struct net_device *dev;
> >> +	int ifindex;
> >> +
> >> +	memset(ctx, 0, sizeof(*ctx));
> >> +	if (GENL_REQ_ATTR_CHECK(info, type))
> >> +		return -EINVAL;
> >> +
> >> +	ifindex = nla_get_u32(info->attrs[type]);  
> > 
> > Let's limit the 'binding' thing to just driver call sites, we can
> > redo the rest easily later. This line and next pretends to take
> > "arbitrary" type but clearly wants a ifindex/netdev, right?  
> 
> There is a misunderstanding. This helper will be used in a following 
> patch (7/12) with a different 'type' argument: 
> NET_SHAPER_A_BINDING_IFINDEX. I've put a note in the commit message, but 
> was unintentionally dropped in one of the recent refactors. I'll add 
> that note back.

What I'm saying is that if you want to prep the ground for more
"binding" types you should also add:

	if (type != ...IFINDEX) {
		/* other binding types are TBD */
		return -EINVAL;
	}

> I hope you are ok with the struct net_shaper_binding * argument to most 
> helpers? does not add complexity, will help to support devlink objects 
> and swapping back and forth from/to struct net_device* can't be automated.

I am "okay" in the American sense of the word which AFAIU is "unhappy
but won't complain unless asked".

> > Maybe send a patch like this, to avoid having to allocate this space,
> > and special casing dump vs doit:
> > 
> > diff --git a/include/net/genetlink.h b/include/net/genetlink.h
> > index 9ab49bfeae78..7658f0885178 100644
> > --- a/include/net/genetlink.h
> > +++ b/include/net/genetlink.h
> > @@ -124,7 +124,8 @@ struct genl_family {
> >    * @genlhdr: generic netlink message header
> >    * @attrs: netlink attributes
> >    * @_net: network namespace
> > - * @user_ptr: user pointers
> > + * @ctx: storage space for the use by the family
> > + * @user_ptr: user pointers (deprecated, use ctx instead)
> >    * @extack: extended ACK report struct
> >    */
> >   struct genl_info {
> > @@ -135,7 +136,10 @@ struct genl_info {
> >   	struct genlmsghdr *	genlhdr;
> >   	struct nlattr **	attrs;
> >   	possible_net_t		_net;
> > -	void *			user_ptr[2];
> > +	union {
> > +		u8		ctx[48];
> > +		void *		user_ptr[2];
> > +	};
> >   	struct netlink_ext_ack *extack;
> >   };  
> 
> Makes sense. Plus likely:
> 
> #define NETLINK_CTX_SIZE 48
> 
> and use such define above and in linux/netlink.h

Aha, would be good to also have a checking macro. Maybe rename

NL_ASSERT_DUMP_CTX_FITS()

to apply more broadly? or add a new one? Weak preference for former.

