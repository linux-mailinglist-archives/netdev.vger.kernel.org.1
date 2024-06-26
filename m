Return-Path: <netdev+bounces-106882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F7917EE9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92B228206B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72493181B98;
	Wed, 26 Jun 2024 10:51:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E418180A96;
	Wed, 26 Jun 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399087; cv=none; b=IK3uhrEvckQasps0gtDkVSvApovyRJx8NMrN6IFN9/FpTWChftGh6r0TsIdQshbmk6zXX/cM9Mn6GJWf5uWQO/HJv0L2Ydlt8s0+DVn3W+6omLQjzA645k6wcqiNEL8YGglD0W/LVRJWlerfkNtfwAcFDmbhPeQM/3+dbG7RKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399087; c=relaxed/simple;
	bh=G4v032TMs/DtKtlhkSHcekZEisjs9TnIGRG3w7nPIrc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kInfSrzJDylyPxTANIJXws27iT3CxNq2qwgbFAQ/UXzqtIw6GuCzhmrXkxSnphxV0NZmNzt9yEdV5i2nqzwEzfmGfQT0lyt+yP8EKy4ye0kPDTzvsktlIR6SNIHccxzl7HMNrsbdDGrHmqjOIK63KYyWCp+tGZSPRWrr+a634oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1A81C0004;
	Wed, 26 Jun 2024 10:51:20 +0000 (UTC)
Message-ID: <f4e9f3db-d9bf-49a9-aa2d-db40b472c82f@ovn.org>
Date: Wed, 26 Jun 2024 12:51:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, dev@openvswitch.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Pravin B Shelar <pshelar@ovn.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample
 action
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-6-amorenoz@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20240625205204.3199050-6-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 6/25/24 22:51, Adrian Moreno wrote:
> Add support for a new action: emit_sample.
> 
> This action accepts a u32 group id and a variable-length cookie and uses
> the psample multicast group to make the packet available for
> observability.
> 
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  Documentation/netlink/specs/ovs_flow.yaml | 17 +++++++++
>  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
>  net/openvswitch/Kconfig                   |  1 +
>  net/openvswitch/actions.c                 | 45 +++++++++++++++++++++++
>  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++++-
>  5 files changed, 123 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> index 4fdfc6b5cae9..a7ab5593a24f 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml
> @@ -727,6 +727,12 @@ attribute-sets:
>          name: dec-ttl
>          type: nest
>          nested-attributes: dec-ttl-attrs
> +      -
> +        name: emit-sample
> +        type: nest
> +        nested-attributes: emit-sample-attrs
> +        doc: |
> +          Sends a packet sample to psample for external observation.
>    -
>      name: tunnel-key-attrs
>      enum-name: ovs-tunnel-key-attr
> @@ -938,6 +944,17 @@ attribute-sets:
>        -
>          name: gbp
>          type: u32
> +  -
> +    name: emit-sample-attrs
> +    enum-name: ovs-emit-sample-attr
> +    name-prefix: ovs-emit-sample-attr-
> +    attributes:
> +      -
> +        name: group
> +        type: u32
> +      -
> +        name: cookie
> +        type: binary
>  
>  operations:
>    name-prefix: ovs-flow-cmd-
> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index efc82c318fa2..8cfa1b3f6b06 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
>  };
>  #endif
>  
> +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
> +/**
> + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_SAMPLE
> + * action.
> + *
> + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
> + * sample.
> + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that contains
> + * user-defined metadata. The maximum length is OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE
> + * bytes.
> + *
> + * Sends the packet to the psample multicast group with the specified group and
> + * cookie. It is possible to combine this action with the
> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being emitted.
> + */
> +enum ovs_emit_sample_attr {
> +	OVS_EMIT_SAMPLE_ATTR_GROUP = 1,	/* u32 number. */
> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> +
> +	/* private: */
> +	__OVS_EMIT_SAMPLE_ATTR_MAX
> +};
> +
> +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
> +
>  /**
>   * enum ovs_action_attr - Action types.
>   *
> @@ -966,6 +991,8 @@ struct check_pkt_len_arg {
>   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
>   * argument.
>   * @OVS_ACTION_ATTR_DROP: Explicit drop action.
> + * @OVS_ACTION_ATTR_EMIT_SAMPLE: Send a sample of the packet to external
> + * observers via psample.
>   *
>   * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  Not all
>   * fields within a header are modifiable, e.g. the IPv4 protocol and fragment
> @@ -1004,6 +1031,7 @@ enum ovs_action_attr {
>  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
>  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
>  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
>  
>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>  				       * from userspace. */
> diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
> index 29a7081858cd..2535f3f9f462 100644
> --- a/net/openvswitch/Kconfig
> +++ b/net/openvswitch/Kconfig
> @@ -10,6 +10,7 @@ config OPENVSWITCH
>  		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
>  				     (!NF_NAT || NF_NAT) && \
>  				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
> +	depends on PSAMPLE || !PSAMPLE
>  	select LIBCRC32C
>  	select MPLS
>  	select NET_MPLS_GSO
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 964225580824..1f555cbba312 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -24,6 +24,11 @@
>  #include <net/checksum.h>
>  #include <net/dsfield.h>
>  #include <net/mpls.h>
> +
> +#if IS_ENABLED(CONFIG_PSAMPLE)
> +#include <net/psample.h>
> +#endif
> +
>  #include <net/sctp/checksum.h>
>  
>  #include "datapath.h"
> @@ -1299,6 +1304,37 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
>  	return 0;
>  }
>  
> +static void execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
> +				const struct sw_flow_key *key,

The 'key' is not used in the function.

> +				const struct nlattr *attr)
> +{
> +#if IS_ENABLED(CONFIG_PSAMPLE)

IIUC, the general coding style guideline is to compile out the whole
function, instead of only the parts.  i.e. something like:

#if IS_ENABLED(CONFIG_PSAMPLE)
static void execute_emit_sample(...) {
    <body>
}
#else
#define execute_emit_sample(dp, skb, attr)
#endif


Otherwise, we'll also need to mark the arguments with __maybe_unused.

The rest of the patch looks good to me.

Best regards, Ilya Maximets.

