Return-Path: <netdev+bounces-102325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31A9025F6
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797DC283F17
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D64E140E4D;
	Mon, 10 Jun 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iv9SZ0HF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4012F5B3
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034389; cv=none; b=R1Xch1GWCmSC9f39BBtHZHO6v56vkSJ1/5IdAhBt2diOykKYXsJYeAYuqG58zksnNvqVT6VfVfhRHyU/hOBND15J7PwQfs+UMMHSzw6y07gKRAHYWZAgyx+kQudv0ptwRijdL00u8dGYQgnuks9ug6XE+eCgmGbnsWc7kOUQ9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034389; c=relaxed/simple;
	bh=YuQg2CmuQIFxyJB/IJAzJ1AY1yVg8OFQ73lw+4/Rjag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oo+QIFPHqWp2aZPzVdF95o+TKOm2PrIJQc8RZWXdfgQ047AAEwbgavK0spEMz2EwL8bk0XCu6qmIgfNllMTM+KGxZKXFCfa7ti3+XPRV3I1oEWvC4ICgjZPgeNGQx64C9+RJAcqZFpianyyhnemSe55NuAC6Q5mhLkozCP+h5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iv9SZ0HF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718034386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TW7A+pbVuZ7mrt5C8kjm1+mKBDQa2Val5XYX/apHDUk=;
	b=iv9SZ0HF2RlZ8BCExKXGw0AWwUEoVZPlkLGoqAQQpu5G+DvCOPK1Nnni4Ll8kLLkmkwIuU
	gou1fRwH2QF0OsRy9dXzOxkWw5kjBMxJaQzBUgbULGIWUdrkMYEf8VHpsTJMSjmXQ49ZjM
	SYPvPqQejF8GuaTnsQ7cJ1K/HEeYy+E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-SERSt8DuM3ajapck7RcKPQ-1; Mon,
 10 Jun 2024 11:46:21 -0400
X-MC-Unique: SERSt8DuM3ajapck7RcKPQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDE2319560B6;
	Mon, 10 Jun 2024 15:46:19 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.10.68])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D18A21956048;
	Mon, 10 Jun 2024 15:46:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Paolo Abeni
 <pabeni@redhat.com>,  Donald Hunter <donald.hunter@gmail.com>,
  linux-kernel@vger.kernel.org,  i.maximets@ovn.org,  Eric Dumazet
 <edumazet@google.com>,  horms@kernel.org,  Jakub Kicinski
 <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v2 5/9] net: openvswitch: add
 emit_sample action
In-Reply-To: <20240603185647.2310748-6-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 3 Jun 2024 20:56:39 +0200")
References: <20240603185647.2310748-1-amorenoz@redhat.com>
	<20240603185647.2310748-6-amorenoz@redhat.com>
Date: Mon, 10 Jun 2024 11:46:14 -0400
Message-ID: <f7ted94rebd.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Adrian Moreno <amorenoz@redhat.com> writes:

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

I saw some of the nits Simon raised - I'll add one more below.

I haven't gone through the series thoroughly enough to make a detailed
review.

>  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
>  include/uapi/linux/openvswitch.h          | 25 ++++++++++++
>  net/openvswitch/actions.c                 | 50 +++++++++++++++++++++++
>  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++-
>  4 files changed, 124 insertions(+), 1 deletion(-)
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
> index efc82c318fa2..a0e9dde0584a 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -914,6 +914,30 @@ struct check_pkt_len_arg {
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
> + * user-defined metadata. The maximum length is 16 bytes.
> + *
> + * Sends the packet to the psample multicast group with the specified group and
> + * cookie. It is possible to combine this action with the
> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being emitted.
> + */
> +enum ovs_emit_sample_attr {
> +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
> +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> +	__OVS_EMIT_SAMPLE_ATTR_MAX
> +};
> +
> +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
> +
> +
>  /**
>   * enum ovs_action_attr - Action types.
>   *
> @@ -1004,6 +1028,7 @@ enum ovs_action_attr {
>  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
>  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
>  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
>  
>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>  				       * from userspace. */
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 964225580824..3b4dba0ded59 100644
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
> @@ -1299,6 +1304,46 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
>  	return 0;
>  }
>  
> +static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
> +			       const struct sw_flow_key *key,
> +			       const struct nlattr *attr)
> +{
> +#if IS_ENABLED(CONFIG_PSAMPLE)
> +	struct psample_group psample_group = {};
> +	struct psample_metadata md = {};
> +	struct vport *input_vport;
> +	const struct nlattr *a;
> +	int rem;
> +
> +	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
> +	     a = nla_next(a, &rem)) {
> +		switch (nla_type(a)) {
> +		case OVS_EMIT_SAMPLE_ATTR_GROUP:
> +			psample_group.group_num = nla_get_u32(a);
> +			break;
> +
> +		case OVS_EMIT_SAMPLE_ATTR_COOKIE:
> +			md.user_cookie = nla_data(a);
> +			md.user_cookie_len = nla_len(a);
> +			break;
> +		}
> +	}
> +
> +	psample_group.net = ovs_dp_get_net(dp);
> +
> +	input_vport = ovs_vport_rcu(dp, key->phy.in_port);
> +	if (!input_vport)
> +		input_vport = ovs_vport_rcu(dp, OVSP_LOCAL);
> +
> +	md.in_ifindex = input_vport->dev->ifindex;
> +	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> +
> +	psample_sample_packet(&psample_group, skb, 0, &md);
> +#endif
> +
> +	return 0;

Why this return here?  Doesn't seem used anywhere else.

> +}
> +
>  /* Execute a list of actions against 'skb'. */
>  static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  			      struct sw_flow_key *key,
> @@ -1502,6 +1547,11 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  			ovs_kfree_skb_reason(skb, reason);
>  			return 0;
>  		}
> +
> +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> +			err = execute_emit_sample(dp, skb, key, a);
> +			OVS_CB(skb)->cutlen = 0;
> +			break;
>  		}
>  
>  		if (unlikely(err)) {
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index f224d9bcea5e..eb59ff9c8154 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
>  		case OVS_ACTION_ATTR_TRUNC:
>  		case OVS_ACTION_ATTR_USERSPACE:
>  		case OVS_ACTION_ATTR_DROP:
> +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
>  			break;
>  
>  		case OVS_ACTION_ATTR_CT:
> @@ -2409,7 +2410,7 @@ static void ovs_nla_free_nested_actions(const struct nlattr *actions, int len)
>  	/* Whenever new actions are added, the need to update this
>  	 * function should be considered.
>  	 */
> -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 24);
> +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 25);
>  
>  	if (!actions)
>  		return;
> @@ -3157,6 +3158,29 @@ static int validate_and_copy_check_pkt_len(struct net *net,
>  	return 0;
>  }
>  
> +static int validate_emit_sample(const struct nlattr *attr)
> +{
> +	static const struct nla_policy policy[OVS_EMIT_SAMPLE_ATTR_MAX + 1] = {
> +		[OVS_EMIT_SAMPLE_ATTR_GROUP] = { .type = NLA_U32 },
> +		[OVS_EMIT_SAMPLE_ATTR_COOKIE] = {
> +			.type = NLA_BINARY,
> +			.len = OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE
> +		},
> +	};
> +	struct nlattr *a[OVS_EMIT_SAMPLE_ATTR_MAX  + 1];
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_PSAMPLE))
> +		return -EOPNOTSUPP;
> +
> +	err = nla_parse_nested(a, OVS_EMIT_SAMPLE_ATTR_MAX, attr, policy,
> +			       NULL);
> +	if (err)
> +		return err;
> +
> +	return a[OVS_EMIT_SAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
> +}
> +
>  static int copy_action(const struct nlattr *from,
>  		       struct sw_flow_actions **sfa, bool log)
>  {
> @@ -3212,6 +3236,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>  			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
>  			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
>  			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
> +			[OVS_ACTION_ATTR_EMIT_SAMPLE] = (u32)-1,
>  		};
>  		const struct ovs_action_push_vlan *vlan;
>  		int type = nla_type(a);
> @@ -3490,6 +3515,12 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>  				return -EINVAL;
>  			break;
>  
> +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> +			err = validate_emit_sample(a);
> +			if (err)
> +				return err;
> +			break;
> +
>  		default:
>  			OVS_NLERR(log, "Unknown Action type %d", type);
>  			return -EINVAL;


