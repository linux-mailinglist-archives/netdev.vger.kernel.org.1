Return-Path: <netdev+bounces-107625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CD91BBD5
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A08DB21A1D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839A2AF05;
	Fri, 28 Jun 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="GIAsv1I9"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DB1C683
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568018; cv=none; b=a5h2vgCPbJGbbCynZenzrpmkFxnriXkVRxj/+tKaTn3uefXGUXJRWpoLlZCVkj/iOnsHBEq6HWFyPxXJZr2oIdgC4Dio92xf8gq/qbTZ8QQiwlw7s0loNj7BpPRNc2czNQ64HcgLCMvthu3WE8OdvefmIwkUru6uN5KC5DeCZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568018; c=relaxed/simple;
	bh=1xKqc6qoBTv/vN4V/aBtclcwfjAR/nGmXLd+WMMMH8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1iJBOwtzM7pabdk/Az0jLO2pO12ICsuCnp+NPIx1u/i1FCs3/YYK+NgtyCqC+Zv7u2pVX7awa8ZW/B50Wh87jhGddJDbWxQoXN5kNFIG4qWZiPV3DhC+PR62OjeaCVg9L5GfWZXhKPYQzWt10PCnnxzIaPraHjJ5GODbieNHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=GIAsv1I9; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1719568005;
	bh=1xKqc6qoBTv/vN4V/aBtclcwfjAR/nGmXLd+WMMMH8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GIAsv1I97LOZyRLNYU1Mk+LJv8QymvFaVJ8KBlFHtVSXMMuyKk3NKA6FWSXfshgDx
	 bOIrXau2SH6y+wSIL2wYmE0CxU93uCjr5PReKLs8hL1a7tNHikn42WhE8Q2M/V7a0j
	 3WH6YP4VICGueHXShxyOqUetOr76AKUD4trO9fTFFBHPBLm2ygKaOQAN9kVItJPygg
	 5J7WuHKmsUXk5Kh53/6uA7Vgf9gqEJTc9y/mYurj6fNInDpRV9Z4dhm0orbXL1+keP
	 FHjUY/MyU2QfoyzmEILnM0QQe5MuM7l4fm0MHEDBrNpoOyqIBKqZ7dBxaGEvunjxM6
	 A/eZPYI3d+lOw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 04F236007A;
	Fri, 28 Jun 2024 09:46:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 1F76F201D9E;
	Fri, 28 Jun 2024 09:46:29 +0000 (UTC)
Message-ID: <e2ffbc92-5a73-464f-9979-446b5373e80e@fiberby.net>
Date: Fri, 28 Jun 2024 09:46:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC iproute2-next] tc: f_flower: add support for matching on
 tunnel metadata
To: Davide Caratti <dcaratti@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, aclaudi@redhat.com,
 Ilya Maximets <i.maximets@ovn.org>, echaudro@redhat.com,
 netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
References: <897379f1850a50d8c320ca3facd06c5f03943bac.1719506876.git.dcaratti@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <897379f1850a50d8c320ca3facd06c5f03943bac.1719506876.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide,

Thank you for the patch.

Overall I think it looks good, I only have a few comments.

On 6/27/24 4:55 PM, Davide Caratti wrote:
> extend TC flower for matching on tunnel metadata.
> smoke test:
> 
>   # ip link add name myep type dummy
>   # ip link set dev myep up
>   # ip address add dev myep 192.0.2.1/24
>   # ip neigh add dev myep 192.0.2.2 lladdr 00:c1:a0:c1:a0:00 nud permanent
>   # ip link add name mytun type vxlan external
>   # ip link set dev mytun up
>   # tc qdisc add dev mytun clsact
>   # tc filter add dev mytun egress protocol ip pref 1 handle 1 matchall action tunnel_key \
>   >    set src_ip 192.0.2.1 dst_ip 192.0.2.2 id 42 csum nofrag continue index 1
>   # tc filter add dev mytun egress protocol ip pref 2 handle 2 flower action continue index 30
>   # tc filter add dev mytun egress protocol ip pref 3 handle 3 flower enc_src_ip 192.0.2.1 action continue index 30
>   # tc filter add dev mytun egress protocol ip pref 4 handle 4 flower enc_flags tundf action pipe index 100
>   # mausezahn mytun -c 1 -p 100 -a 00:aa:bb:cc:dd:ee -b 00:ee:dd:cc:bb:aa -t icmp -q
>   # expect 2 packets below
>   # tc -s action get action gact index 30
>   # expect 1 packet below
>   # tc -s action get action gact index 100
> 
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>   include/uapi/linux/pkt_cls.h |  8 +++++++
>   tc/f_flower.c                | 42 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 229fc925ec3a..24795aad7651 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -554,6 +554,9 @@ enum {
>   	TCA_FLOWER_KEY_SPI,		/* be32 */
>   	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
>   
> +	TCA_FLOWER_KEY_ENC_FLAGS,	/* u32 */
> +	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* u32 */
> +

FYI: I will do a v1 of the kernel side soon, where the comments
above will change to be32.

>   	__TCA_FLOWER_MAX,
>   };
>   
> @@ -674,6 +677,11 @@ enum {
>   enum {
>   	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
>   	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
> +	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 3),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 4),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 5),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 6),
>   };
>   
>   enum {
> diff --git a/tc/f_flower.c b/tc/f_flower.c
> index 08c1001af7b4..45fc31dc380f 100644
> --- a/tc/f_flower.c
> +++ b/tc/f_flower.c
> @@ -17,6 +17,7 @@
>   #include <linux/tc_act/tc_vlan.h>
>   #include <linux/mpls.h>
>   #include <linux/ppp_defs.h>
> +#include <linux/if_tunnel.h>
>   
>   #include "utils.h"
>   #include "tc_util.h"
> @@ -28,6 +29,7 @@
>   
>   enum flower_matching_flags {
>   	FLOWER_IP_FLAGS,
> +	FLOWER_ENC_DST_FLAGS,
>   };
>   
>   enum flower_endpoint {
> @@ -92,6 +94,7 @@ static void explain(void)
>   		"			erspan_opts MASKED-OPTIONS |\n"
>   		"			gtp_opts MASKED-OPTIONS |\n"
>   		"			pfcp_opts MASKED-OPTIONS |\n"
> +		"			enc_flags  ENC-FLAGS |\n"

Maybe add a "ENC-FLAGS := foo,bar,..." below, could be generated from flag_to_string[],
properly best to do separately as it requires moving the flag_to_string[] definition.

>   		"			ip_flags IP-FLAGS |\n"

IP-FLAGS is also not defined, properly a good time to fix that.

>   		"			l2_miss L2_MISS |\n"
>   		"			enc_dst_port [ port_number ] |\n"
> @@ -205,6 +208,11 @@ struct flag_to_string {
>   static struct flag_to_string flags_str[] = {
>   	{ TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT, FLOWER_IP_FLAGS, "frag" },
>   	{ TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST, FLOWER_IP_FLAGS, "firstfrag" },
> +	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM, FLOWER_ENC_DST_FLAGS, "csum" },
> +	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT, FLOWER_ENC_DST_FLAGS, "tundf" },
> +	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM, FLOWER_ENC_DST_FLAGS, "oam" },
> +	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT, FLOWER_ENC_DST_FLAGS, "crit" },
> +

Nit: I would prefix all of these with "tun_".

>   };
>   
>   static int flower_parse_matching_flags(char *str,
> @@ -1461,6 +1469,29 @@ static int flower_parse_enc_opts_pfcp(char *str, struct nlmsghdr *n)
>   	return 0;
>   }
>   
> +static int flower_parse_enc_dstflags(char *str, struct nlmsghdr *n)
> +{
> +
> +	__u32 dst_flags, dst_flags_mask;
> +	int err;
> +
> +	err = flower_parse_matching_flags(str,
> +					  FLOWER_ENC_DST_FLAGS,
> +					  &dst_flags,
> +					  &dst_flags_mask);
> +
> +	if (err < 0 || !dst_flags_mask)
> +		return -1;
> +	err = addattr32(n, MAX_MSG, TCA_FLOWER_KEY_ENC_FLAGS, htonl(dst_flags));
> +	if (err < 0)
> +		return -1;
> +	err = addattr32(n, MAX_MSG, TCA_FLOWER_KEY_ENC_FLAGS_MASK, htonl(dst_flags_mask));
> +	if (err < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>   static int flower_parse_mpls_lse(int *argc_p, char ***argv_p,
>   				 struct nlmsghdr *nlh)
>   {
> @@ -2248,6 +2279,13 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
>   				fprintf(stderr, "Illegal \"pfcp_opts\"\n");
>   				return -1;
>   			}
> +		} else if (matches(*argv, "enc_flags") == 0) {
> +			NEXT_ARG();
> +			ret = flower_parse_enc_dstflags(*argv, n);
> +			if (ret < 0) {
> +				fprintf(stderr, "Illegal \"enc_flags\"\n");
> +				return -1;
> +			}

I agree that flower_parse_opt() is a bit crowded, but splitting it out to it's own function like this
implicitly also means that you can't specify enc_flags over multiple enc_flags argument, as addattr32()
is called once per enc_flags argument, instead of after all the arguments have been handled.

[..] flower ip_flags frag ip_flags firstfrag [..] is valid, and is equivalent to
[..] flower ip_flags frag/firstfrag [..].

IMHO I would completely mirror the way that ip_flags are handled, except the call to matches(),
so as to avoid adding any new quirks.


>   		} else if (matches(*argv, "action") == 0) {
>   			NEXT_ARG();
>   			ret = parse_action(&argc, &argv, TCA_FLOWER_ACT, n);
> @@ -3262,6 +3300,10 @@ static int flower_print_opt(const struct filter_util *qu, FILE *f,
>   				    tb[TCA_FLOWER_KEY_FLAGS],
>   				    tb[TCA_FLOWER_KEY_FLAGS_MASK]);
>   
> +	flower_print_matching_flags("enc_flags", FLOWER_ENC_DST_FLAGS,
> +				    tb[TCA_FLOWER_KEY_ENC_FLAGS],
> +				    tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]);
> +
>   	if (tb[TCA_FLOWER_L2_MISS]) {
>   		struct rtattr *attr = tb[TCA_FLOWER_L2_MISS];
>   

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

