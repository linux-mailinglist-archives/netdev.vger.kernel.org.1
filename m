Return-Path: <netdev+bounces-64661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C994C836331
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 13:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E671B20A8A
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BD23B790;
	Mon, 22 Jan 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtSjANMV"
X-Original-To: netdev@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3093CF43
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926292; cv=none; b=CYBNYlYLgrhl/vSPNUNpS0UnZghB3d15bN5DIqzXlj9xLtCQqrso06y4pQR7mN+ybXitAxUcZ/xQKE+67xzL33ntwU33UsNTw5Q3yqp4F1858k8lOB3niSh1p/zSeHa6aWxqP5Q+ZCy39NIcAtULQtSVcYZUDXJmGVIRid3s7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926292; c=relaxed/simple;
	bh=1vPCL+hXp5d2hF4hyeY6ExLiER5oX1KpKEtYMmuNo28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1JerhDYgB0PTlxshQhfCzFcBKyj8HPo9anHgd/VFQuPJa2mK1yXYWDXRoRYLKnPWL3MgUCs0w+bwB00+AZnBwYweYabDDOBNCcz5ITelZ49dOtvmD2F0oAg1GXK7N42iERlQ0gYfT2+qzhfZ1hLHWFZBuQHPA5swlFTJP676FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtSjANMV; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 335FC5C0105;
	Mon, 22 Jan 2024 07:24:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 22 Jan 2024 07:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705926287; x=1706012687; bh=8y2Ffo4BVr+R16XlQrPK27zig33B
	07C2uHU9JBY8BzE=; b=YtSjANMVVGMYbuZE8G0n4K1qW8Ajobwk3Rqyac7XfFcc
	0/9SsnSXRPe7tvaVrnFvXyTMvwuudbCxwS0jY50luNlTIzjQHp1yUaTx/2yWnmRr
	LjX2EFL3Dcli5VjHGI3vRp1H9DvGQNgASXBDTrRgDCg3gVSG1Th7UsHS9xBz1AbQ
	CL+iFqmqhYb+sYbuWaZTOQCuXN1AV+oMEFbVLlRdWDq7yaaeCHRfxEMzc9ZNKboW
	cFrFBhAS71CCH9ZBVpf0YLeMDgSldDlgnV9Ezmdc6aExsGh6UsXPFKGNTrWrFjy1
	sg5DbRPE+LJyiCDDYsJYZusbok8/NH9uiJi1IiO72g==
X-ME-Sender: <xms:jl6uZeusyl9v80qC3svg-OkKcLYMEr6N62WZVnwSv_aHL4xjmwZSOw>
    <xme:jl6uZTfeQFv5RQa2usyXcVPGFPb9TvSvcJcZfXR0CzUEMAau2WIxXDNXBXPJ90wFR
    z5_Uyx2nxkvXR8>
X-ME-Received: <xmr:jl6uZZxfWKZNIPlO86dWrJ6aqydGXwoe9I6IuvJMMySS5XPgpsTo_ldHUGS6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:jl6uZZNJOurvDb_rwkKam-wykjRgxI9yh0XdxfMElbp6qeNsBhFqEA>
    <xmx:jl6uZe8ps6I9Fv1eJL8KS_5JG8hKYfeD47YPLXLGUcUqnsiV26PJdQ>
    <xmx:jl6uZRUxMKkD9CZPBVvdSsh-VlVa2Nru2qbLQ4quqrzXshOZYMH7_g>
    <xmx:j16uZQLmeX3pU05J9RYs-PICfuSUs1Zjf94TQhMhVjAGqF2nr47S6g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 07:24:46 -0500 (EST)
Date: Mon, 22 Jan 2024 14:24:43 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	Vincent Bernat <vincent@bernat.ch>, dsahern@gmail.com
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Message-ID: <Za5eizfgzl5mwt50@shredder>
References: <20240120124418.26117-1-alce@lafranque.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120124418.26117-1-alce@lafranque.net>

s/flowlab/flowlabel/ in subject

My understanding is that new features should be targeted at
iproute2-next. See the README.

On Sat, Jan 20, 2024 at 06:44:18AM -0600, Alce Lafranque wrote:
> @@ -214,10 +214,16 @@ static int vxlan_parse_opt(struct link_util *lu, int argc, char **argv,
>  			NEXT_ARG();
>  			check_duparg(&attrs, IFLA_VXLAN_LABEL, "flowlabel",
>  				     *argv);
> -			if (get_u32(&uval, *argv, 0) ||
> -			    (uval & ~LABEL_MAX_MASK))
> -				invarg("invalid flowlabel", *argv);
> -			addattr32(n, 1024, IFLA_VXLAN_LABEL, htonl(uval));
> +			if (strcmp(*argv, "inherit") == 0) {
> +				addattr32(n, 1024, IFLA_VXLAN_LABEL_POLICY, VXLAN_LABEL_INHERIT);
> +			} else {
> +				if (get_u32(&uval, *argv, 0) ||
> +				    (uval & ~LABEL_MAX_MASK))
> +					invarg("invalid flowlabel", *argv);
> +				addattr32(n, 1024, IFLA_VXLAN_LABEL_POLICY, VXLAN_LABEL_FIXED);

I think I mentioned this during the review of the kernel patch, but the
current approach relies on old kernels ignoring the
'IFLA_VXLAN_LABEL_POLICY' attribute which is not nice. My personal
preference would be to add a new keyword for the new attribute:

# ip link set dev vx0 type vxlan flowlabel_policy inherit
# ip link set dev vx0 type vxlan flowlabel_policy fixed flowlabel 10

But let's see what David thinks.

> +				addattr32(n, 1024, IFLA_VXLAN_LABEL,
> +					  htonl(uval));
> +			}
>  		} else if (!matches(*argv, "ageing")) {
>  			__u32 age;
>  
> @@ -580,12 +586,25 @@ static void vxlan_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			print_string(PRINT_ANY, "df", "df %s ", "inherit");
>  	}
>  
> -	if (tb[IFLA_VXLAN_LABEL]) {
> -		__u32 label = rta_getattr_u32(tb[IFLA_VXLAN_LABEL]);
> -
> -		if (label)
> -			print_0xhex(PRINT_ANY, "label",
> -				    "flowlabel %#llx ", ntohl(label));
> +	enum ifla_vxlan_label_policy policy = VXLAN_LABEL_FIXED;
> +	if (tb[IFLA_VXLAN_LABEL_POLICY]) {
> +		policy = rta_getattr_u32(tb[IFLA_VXLAN_LABEL_POLICY]);
> +	}

Checkpatch says:

WARNING: Missing a blank line after declarations
#112: FILE: ip/iplink_vxlan.c:590:
+       enum ifla_vxlan_label_policy policy = VXLAN_LABEL_FIXED;
+       if (tb[IFLA_VXLAN_LABEL_POLICY]) {

WARNING: braces {} are not necessary for single statement blocks
#112: FILE: ip/iplink_vxlan.c:590:
+       if (tb[IFLA_VXLAN_LABEL_POLICY]) {
+               policy = rta_getattr_u32(tb[IFLA_VXLAN_LABEL_POLICY]);
+       }

> +	switch (policy) {
> +	case VXLAN_LABEL_FIXED:
> +		if (tb[IFLA_VXLAN_LABEL]) {
> +			__u32 label = rta_getattr_u32(tb[IFLA_VXLAN_LABEL]);
> +
> +			if (label)
> +				print_0xhex(PRINT_ANY, "label",
> +					    "flowlabel %#llx ", ntohl(label));
> +		}
> +		break;
> +	case VXLAN_LABEL_INHERIT:
> +		print_string(PRINT_FP, NULL, "flowlabel %s ", "inherit");
> +		break;
> +	default:
> +		break;
>  	}
>  
>  	if (tb[IFLA_VXLAN_AGEING]) {
> -- 
> 2.39.2
> 
> 

