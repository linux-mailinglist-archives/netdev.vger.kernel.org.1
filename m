Return-Path: <netdev+bounces-304412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zmKtD0loR2peXwAAu9opvQ
	(envelope-from <netdev+bounces-304412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:44:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897626FFAED
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=lYGFopeq;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304412-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304412-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 035DC3074798
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAC3655EA;
	Fri,  3 Jul 2026 07:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCC35F8D2
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:34:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064065; cv=none; b=sjJ+yY5DBHKCSdlheDAMv4TcJneO1C5piPRn1XBOFprHenU4I7EDG2E0vwSd56RdTz/Al7KA2H3acULSy+jEm6vv9+ewBwbivoR0MDHBtWNSsPv3Jsx8tsaSoIcvF5n+CCugAMWTEbDZzmZfgLhU3XgLohHFZVpJ3JrwbiTmlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064065; c=relaxed/simple;
	bh=tVn9O9BGVyGOIjguCc/mLQfJqWG2NCeIK+eTfbZbuGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLA7ppeG1Zlmgvyhb64tJ4T00/eSaUV9AuzJ1AV6BfaXsuQD0apdjtOyCy+TdawiaBclia+1KTe+xLMgAZu2NRbBqxvFvJfqZD9v1rkYXUbInGb2luvHjwiEFJ84CghC0OinZfuazWCOHPhQ8ZBBHjMJQD7ZjlM+5TqiUe0bw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lYGFopeq; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4745492ed3aso147222f8f.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1783064062; x=1783668862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hLETDnygn58F8xxBZ3Mcm3EVRjK0eC7Y6SGm1DIAAg=;
        b=lYGFopeqxD+/yA4dgjJsjIS/N3yAMzrbgcNJdn+Z0nRvfmpZ74N/GvKGVJRB3x0/By
         2mNJfrFBQWejHtsOcKum9q2JGrJNkx+szxV8sEcxNCgV+O7IS/3d/bFNEknaE3qdIUCD
         l+m12Qc77RNaI10CTxiVJXdol2mWxO07w+RarISPiMKdNUHUGtaxxzWPY5PRMAbPxIjU
         bkfpZLM2yEOOdpfQf6KDkWmi7GNvRaOxLYi6gT1DT29vOxLOpBASMyZPQcJoa2BtC4P4
         8aayOJLFGzM1lDH1U4s2f9gf1pR9+swSXQq+cy5/pqcMNsWs4mssGcoDIV4gFISDK/P9
         /TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783064062; x=1783668862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hLETDnygn58F8xxBZ3Mcm3EVRjK0eC7Y6SGm1DIAAg=;
        b=r/6cZlPYVVHOPhsQlDeQ7Czppw8tAYJO1hYAE40cd4NXzZQFeTAHvR6jT/gfsT7nRx
         pdNNHGD6jSic0uRWTK18BSMe/k4n0eSmL7ISG9ZEF7rUhe556wDwi8E3bm3z9MvNygYf
         5rH8wlAZdZu1T479Db0zXE88Sg59X2vNdTs+kKaO1dItLHipeFez9dPW1lADQSB3GJCi
         61j4zvZxIWviK6V+9NuaGejD36pBLNxD6N1kdpAaL/r+POR06nqDjTzV6DDOe0pT145w
         uypdGx/ciKLLl/9QFH1d7BHUXfIlc4QZJACe50+21KA/NXVJTlJrU38D9cE9lWnzM8x+
         Iqyw==
X-Forwarded-Encrypted: i=1; AHgh+RqnG3zO99c/DUJg5Dbew+jWdaAPU1QBQDVGl8+RRfKbiuTrhGHVAsvGMac+leXJwvj3FFoQa0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSLjYl/kHrmYZNb3IWN9hvVw0tpCsAmKxOYSXa8y/GMCnfm4+
	9dlpuMTuXavvnG+g27xeiYeF5CFC/G3G7YrutTflUCElW+bboXhZQgKWeoQum7iijdQ=
X-Gm-Gg: AfdE7cnr/LCB2lVun/rP3acifGkovN1XFhPWC1gMOyXVVsA2VUCuXjyZeq+1hIyPKEW
	rK8KwZ4NfexPhIy6/AKu0Ip/PlitsFJK3F2g32ydQO0Zu/sFWN/SfKGPvoeAlZW0r37wSsSNq3B
	4S9AI10RcnHhbderuxmOqqGkpkXcyKbi62p4SZahyhXmxJ/2hAoj817H6KIhmybKDS6fPngQpAE
	1n19J5VuP4vbFZkMZoXoyblVs3oNMNwYrFdt1P7+Knfvwy+eBRc1K2nXesnDzdzKjbuSDCcTzqm
	kfW8FO0v3xofx4XitYbkhz/HKraTHV3jBo6UO8Fx17yD/E3sCyypyuu2ar9nZSk/lgRJCpLK2PC
	6/QYFUjV9WhPx/5P1FSIJ5FKciEzkthVNNs0bcQDPdNJG5yw6gPiic0y/fk+KeA4IF+ApBA/fT/
	jzpzbyiDZMW35XRdPB6zDMUCydnbOWRNrYuJ1jueuES22Ryn0n6swtnA==
X-Received: by 2002:adf:fa06:0:b0:475:f100:360a with SMTP id ffacd0b85a97d-4775a6d1b39mr10482015f8f.57.1783064061000;
        Fri, 03 Jul 2026 00:34:21 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbacbsm16180990f8f.4.2026.07.03.00.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:34:20 -0700 (PDT)
Message-ID: <45fa2de3-1b56-48b3-a946-ae4c7ea26a22@blackwall.org>
Date: Fri, 3 Jul 2026 10:34:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: bridge: add BRIDGE_VLAN_INFO_DYNAMIC
 flag
Content-Language: en-US, bg
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260703-vlan-dynamic-entry-v1-1-c2cbb134036c@padl.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260703-vlan-dynamic-entry-v1-1-c2cbb134036c@padl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304412-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:idosch@nvidia.com,m:horms@kernel.org,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,padl.com:email,vger.kernel.org:from_smtp,blackwall.org:from_mime,blackwall.org:dkim,blackwall.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 897626FFAED

On 03/07/2026 09:54, Luke Howard wrote:
> Dynamic VLAN entries as specified in IEEE Std 802.1Q-2022,
> Clause 8.8.5. These allow a user-space VLAN registration
> protocol such as MVRP to mark a bridge's VLAN entries as
> dynamic, so they can be distinguished from administratively
> configured static entries.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
> This patch adds support for Dynamic VLAN Entries, as specified
> in 802.1Q. I have marked it as RFC as a similar patch to add
> support for Dynamic Reservation Entries to the FDB was rejected
> on the argument that the dynamic bit should be stored separately.
> 
> Our MVRP implementation [1] will use this flag if available.
> 
> [1] https://github.com/PADL/OpenSRP

Hi,
Do this tracking entirely in your app, it doesn't bring anything to the
kernel and just adding flags because it is convenient is not acceptable.
These VLANs are the same from kernel POV and this flag doesn't change
anything functionally.
Alternatively perhaps a proto field similar to routes could help you out to
distinguish who installed a VLAN entry, not sure if that would help your
user-space app though, and you'll have to add a new rt proto id that should
get accepted.

Cheers,
  Nik

> ---
>   include/uapi/linux/if_bridge.h |  1 +
>   net/bridge/br_netlink.c        |  6 ++++++
>   net/bridge/br_vlan.c           | 18 ++++++++++++++----
>   3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 21a700c02ef76..a3abbfe79694b 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -134,6 +134,7 @@ enum {
>   #define BRIDGE_VLAN_INFO_RANGE_END	(1<<4) /* VLAN is end of vlan range */
>   #define BRIDGE_VLAN_INFO_BRENTRY	(1<<5) /* Global bridge VLAN entry */
>   #define BRIDGE_VLAN_INFO_ONLY_OPTS	(1<<6) /* Skip create/delete/flags */
> +#define BRIDGE_VLAN_INFO_DYNAMIC	(1<<7) /* 802.1Q Dynamic VLAN Registration Entry */
>   
>   struct bridge_vlan_info {
>   	__u16 flags;
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index b2cd4e39326d0..90f2e103f53d5 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -388,6 +388,9 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
>   		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
>   			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
>   
> +		if (v->flags & BRIDGE_VLAN_INFO_DYNAMIC)
> +			flags |= BRIDGE_VLAN_INFO_DYNAMIC;
> +
>   		if (vid_range_start == 0) {
>   			goto initvars;
>   		} else if ((v->vid - vid_range_end) == 1 &&
> @@ -440,6 +443,9 @@ static int br_fill_ifvlaninfo(struct sk_buff *skb,
>   		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
>   			vinfo.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
>   
> +		if (v->flags & BRIDGE_VLAN_INFO_DYNAMIC)
> +			vinfo.flags |= BRIDGE_VLAN_INFO_DYNAMIC;
> +
>   		if (nla_put(skb, IFLA_BRIDGE_VLAN_INFO,
>   			    sizeof(vinfo), &vinfo))
>   			goto nla_put_failure;
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 5560afcaaca32..e6bc59e3a4c4f 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -54,9 +54,11 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
>   	vg->pvid = 0;
>   }
>   
> -/* Update the BRIDGE_VLAN_INFO_PVID and BRIDGE_VLAN_INFO_UNTAGGED flags of @v.
> - * If @commit is false, return just whether the BRIDGE_VLAN_INFO_PVID and
> - * BRIDGE_VLAN_INFO_UNTAGGED bits of @flags would produce any change onto @v.
> +/* Update the BRIDGE_VLAN_INFO_PVID, BRIDGE_VLAN_INFO_UNTAGGED and
> + * BRIDGE_VLAN_INFO_DYNAMIC flags of @v.
> + * If @commit is false, return just whether the BRIDGE_VLAN_INFO_PVID,
> + * BRIDGE_VLAN_INFO_UNTAGGED and BRIDGE_VLAN_INFO_DYNAMIC bits of @flags
> + * would produce any change onto @v.
>    */
>   static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
>   				bool commit)
> @@ -71,7 +73,8 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
>   
>   	/* check if anything would be changed on commit */
>   	change = !!(flags & BRIDGE_VLAN_INFO_PVID) == !!(vg->pvid != v->vid) ||
> -		 ((flags ^ v->flags) & BRIDGE_VLAN_INFO_UNTAGGED);
> +		 ((flags ^ v->flags) & (BRIDGE_VLAN_INFO_UNTAGGED |
> +					BRIDGE_VLAN_INFO_DYNAMIC));
>   
>   	if (!commit)
>   		goto out;
> @@ -86,6 +89,11 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
>   	else
>   		v->flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
>   
> +	if (flags & BRIDGE_VLAN_INFO_DYNAMIC)
> +		v->flags |= BRIDGE_VLAN_INFO_DYNAMIC;
> +	else
> +		v->flags &= ~BRIDGE_VLAN_INFO_DYNAMIC;
> +
>   out:
>   	return change;
>   }
> @@ -1874,6 +1882,8 @@ static bool br_vlan_fill_vids(struct sk_buff *skb, u16 vid, u16 vid_range,
>   		info.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
>   	if (flags & BRIDGE_VLAN_INFO_PVID)
>   		info.flags |= BRIDGE_VLAN_INFO_PVID;
> +	if (flags & BRIDGE_VLAN_INFO_DYNAMIC)
> +		info.flags |= BRIDGE_VLAN_INFO_DYNAMIC;
>   
>   	if (nla_put(skb, BRIDGE_VLANDB_ENTRY_INFO, sizeof(info), &info))
>   		goto out_err;
> 
> ---
> base-commit: 2bb62a85aff6d4c14a62a476dfabaada3c1cc014
> change-id: 20260703-vlan-dynamic-entry-56a028e8990e
> 
> Best regards,
> --
> Luke Howard <lukeh@padl.com>
> 


