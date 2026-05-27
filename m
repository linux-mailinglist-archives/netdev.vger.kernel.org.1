Return-Path: <netdev+bounces-292124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGSGAt2XFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09A5E033D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B332B301CA6E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96922339;
	Wed, 27 May 2026 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="oIcHBI6z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDF3B7B98
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865538; cv=none; b=CXRy+Ac60/VFqN4MauXv5yK0FK/bpxQCpW1MKUseWeLg5FPifWACGi9YUttKQ52Gp2/TsUwKrWJN6aQuApuZr4OErbHbLZ1IN9Wxa8YSLx3QnDCnAdqZcHCxG58svr2lBbSHyPrXwGLQxfQ+wQQbOtutj6vgVoKjlixfIHyLYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865538; c=relaxed/simple;
	bh=SXpWLNV/B2+Gd3bFDoq9pSzvpQqpLFBhTP7Pzq8PjfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXXlv/MAbJbTG003Ybuh8cjGdKD1CrQQNQlN8ULlUXZfAPDU/dnYfjxa5sSupjOQAe6zCL2I5DWuDuVe7KpHWlBNQJ2mlZ5ayoNdrclfKJhEaAkiI8vCx+jpHmq7beUBQPEIG6nsTWqwWJ1qX+ZmcUugnzYVUQQQ+UcHi7joAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=oIcHBI6z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45e7c636e74so6024226f8f.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779865535; x=1780470335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bzDufY+rhzuN24EB/ByRcUw+iGLl6v/2HEmTjGXKLI=;
        b=oIcHBI6zsJVOS/M8k8j62jANEpWPqmfjwv5wSqljv3jsEA3XsR54ZyH3ALQfJeKkQt
         AY+Hk6KLG2DQpjMe0INgbvcvOK4FUpRoF6M0EJiWk/IDMhevig4Ho+hYnv3EhPUOxAcT
         hFTOpYDaNOCCvqlDAqfmLTCIOGPzCGnS35ghJHGZ975McBLK98alujnG19NVclIRVDzF
         qdxBM7EvUV1JRMcUslTBHBaQLgdUnRIRlybdqThyOMJXLO99xqUZof9byNYPuIun/b8l
         98AauEoEfe/0Z4f5BIdcpb3K9AvXlbVtV+r4nr6/TxOoK9URcHT22ks3ubDAvqJ3ISD5
         a8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779865535; x=1780470335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bzDufY+rhzuN24EB/ByRcUw+iGLl6v/2HEmTjGXKLI=;
        b=riQK4rfpRT+waA65jYHcFSMpJkihQG2qJsW7PHROWEAOitht6nUNsBcF8YiUUHOg3l
         UUA/CEak8fkPO6pycn1JsW3fHJYNpHMvepJbWzghmePrYIeoWRanBnlakBUT9bBUe9J7
         46Lkp2L0InMgdrsKZUDYGosc3Adi3svfrbIYMWD5nBZ3WBwRW0gIvUsBRrqq0zQ0cg5y
         hpCDTl+pO9ZTBWDEbnAt3omE2M8iyxejdrWjdRm9EQ1WnDDry0vPjfgd9E6OevM0uUrP
         aZxcaj+el+eJ73+QwzULSgj2TNImwVPKfCp+V6JRVTNuQe1Z/kLZ+sLlgNmTHHOYSBCO
         o4ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vKaJYmafrJ9b2u0e20g3XFqFZjUBcl1Ei7JSFPFB9vIsalkjYLC+ehRmw6IxaO96nmzMUKSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOU1Rbxu3FlCGNzDHvnuyUhC4Dz1L8swEFhblMZheq65XGKKIH
	XGNugnaNmUWUiNxXrSYQI+eg+K5OFJ+43rwjal0T0BYBCp0npI0EwQU7IjaY2ZAAHgI=
X-Gm-Gg: Acq92OE29Lcp0QYKzTa+QHBD3FfS8O/jXdU0W5aGR6y5iuRmUANE7HNAZAXeYy7VUpy
	MazyoMgJS9fX7Y/uR4vIi6KVHXKxux3amVPaOBxzTlAxniBn8AbwyqL24R8U1N9QdMWwQ4iSryN
	DLaqYPGjo95nyt97imy7VbEGRSjPaENn68eM5UeqzMPCAQ+/nIc2roSiygSf/rbIEkZVM38D6B4
	0jOTW2xD78pUNBq05A+pk9ipi8nkeunMgRswusBTHeZ3d95CnV/yaKZWKJ4tYAZsCyf/bGFBQfX
	2/OeLR6ufTEboL7EJdToJufULf5KK0K+/mMS+Q5mgdPzLaZN92+5oJyQWafUm+HeGGnc+TzrKTI
	PJux5Ll0QRFYmBXJ0ntUDbYasJ0PfouyC8CtltvQqcK08ts98D32XSn/h8oczp7FoHmCbA2VA79
	o8XZiJAB978DdOrXjmlAN3jSv4cXXnqWXZrSNGexUXJ6ZZVtg0AvXwOYisOQsPAVIp
X-Received: by 2002:a05:6000:25fd:b0:45b:d5d7:1f59 with SMTP id ffacd0b85a97d-45eb38a64f8mr34118871f8f.24.1779865535006;
        Wed, 27 May 2026 00:05:35 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558dd0sm3778481f8f.16.2026.05.27.00.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 00:05:33 -0700 (PDT)
Message-ID: <946d52d4-1456-4cf8-9dfa-9bba96121dcb@blackwall.org>
Date: Wed, 27 May 2026 10:05:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: bridge: mdb: add
 MDB_FLAGS_STREAM_RESERVED flag
Content-Language: en-US, bg
To: Luke Howard <lukeh@padl.com>, netdev@vger.kernel.org
Cc: Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>,
 Cedric Jehasse <cedric.jehasse@luminex.be>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <cover.1779841530.git.lukeh@padl.com>
 <45e7cd01f9449c8ef15a5affd587fe7645ecddb7.1779841530.git.lukeh@padl.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <45e7cd01f9449c8ef15a5affd587fe7645ecddb7.1779841530.git.lukeh@padl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B09A5E033D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/05/2026 03:42, Luke Howard wrote:
> Add a new MDB entry flag, MDB_FLAGS_STREAM_RESERVED, that userspace
> can set on RTM_NEWMDB to mark a multicast destination as belonging
> to a reserved stream (e.g. IEEE 802.1Q Stream Reservation Protocol /
> IEEE 1722 / TSN). The bridge core does no admission control on the
> basis of the flag; it is metadata propagated through switchdev to
> hardware drivers that can themselves enforce admission of AVB / SR
> priority traffic only to flagged destinations.
> 
> The flag is settable via the new nested attribute MDBE_ATTR_FLAGS
> (NLA_U32 bitmask, validated against MDB_FLAGS_SETTABLE_MASK), and is
> reflected in dump output via br_mdb_entry.flags as is done today for
> the OFFLOAD/BLOCKED/STAR_EXCL flags.
> 
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
>   include/net/switchdev.h        |  4 ++++
>   include/uapi/linux/if_bridge.h |  2 ++
>   net/bridge/br_mdb.c            | 12 ++++++++++++
>   net/bridge/br_private.h        |  2 ++
>   net/bridge/br_switchdev.c      | 17 +++++++++++------
>   5 files changed, 31 insertions(+), 6 deletions(-)
> 

We don't add hw-only functionality, if you'd like to have this flag
you'll have to do a software implementation of this feature first.
Also please check the slop(code) that Claude generates before sending
it, there are obvious issues in this patch.

Cheers,
  Nik

> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index ee500706496b0..03d176708b768 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -111,10 +111,14 @@ struct switchdev_obj_port_vlan {
>   	container_of((OBJ), struct switchdev_obj_port_vlan, obj)
>   
>   /* SWITCHDEV_OBJ_ID_PORT_MDB */
> +
> +#define SWITCHDEV_MDB_F_STREAM_RESERVED		BIT(0)
> +
>   struct switchdev_obj_port_mdb {
>   	struct switchdev_obj obj;
>   	unsigned char addr[ETH_ALEN];
>   	u16 vid;
> +	u32 flags;
>   };
>   
>   #define SWITCHDEV_OBJ_PORT_MDB(OBJ) \
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 21a700c02ef76..51ec314994bec 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -705,6 +705,7 @@ struct br_mdb_entry {
>   #define MDB_FLAGS_STAR_EXCL		(1 << 2)
>   #define MDB_FLAGS_BLOCKED		(1 << 3)
>   #define MDB_FLAGS_OFFLOAD_FAILED	(1 << 4)
> +#define MDB_FLAGS_STREAM_RESERVED	(1 << 5)
>   	__u8 flags;
>   	__u16 vid;
>   	struct {
> @@ -760,6 +761,7 @@ enum {
>   	MDBE_ATTR_IFINDEX,
>   	MDBE_ATTR_SRC_VNI,
>   	MDBE_ATTR_STATE_MASK,
> +	MDBE_ATTR_FLAGS,
>   	__MDBE_ATTR_MAX,
>   };
>   #define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index e0c7020b12f5f..1320ccd81b0a1 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -146,6 +146,8 @@ static void __mdb_entry_fill_flags(struct br_mdb_entry *e, unsigned char flags)
>   		e->flags |= MDB_FLAGS_BLOCKED;
>   	if (flags & MDB_PG_FLAGS_OFFLOAD_FAILED)
>   		e->flags |= MDB_FLAGS_OFFLOAD_FAILED;
> +	if (flags & MDB_PG_FLAGS_STREAM_RESERVED)
> +		e->flags |= MDB_FLAGS_STREAM_RESERVED;
>   }
>   
>   static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip,
> @@ -664,6 +666,7 @@ static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
>   						  MCAST_INCLUDE),
>   	[MDBE_ATTR_SRC_LIST] = NLA_POLICY_NESTED(br_mdbe_src_list_pol),
>   	[MDBE_ATTR_RTPROT] = NLA_POLICY_MIN(NLA_U8, RTPROT_STATIC),
> +	[MDBE_ATTR_FLAGS] = NLA_POLICY_MASK(NLA_U32, MDB_FLAGS_STREAM_RESERVED),
>   };
>   
>   static bool is_valid_mdb_source(struct nlattr *attr, __be16 proto,
> @@ -1072,6 +1075,8 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
>   	if (entry->state == MDB_PERMANENT)
>   		flags |= MDB_PG_FLAGS_PERMANENT;
>   
> +	flags |= cfg->pg_flags;
> +
>   	if (br_multicast_is_star_g(&group))
>   		return br_mdb_add_group_star_g(cfg, mp, brmctx, flags, extack);
>   	else
> @@ -1225,6 +1230,13 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
>   		cfg->rt_protocol = nla_get_u8(mdb_attrs[MDBE_ATTR_RTPROT]);
>   	}
>   
> +	if (mdb_attrs[MDBE_ATTR_FLAGS]) {
> +		u32 user_flags = nla_get_u32(mdb_attrs[MDBE_ATTR_FLAGS]);
> +
> +		if (user_flags & MDB_FLAGS_STREAM_RESERVED)
> +			cfg->pg_flags |= MDB_PG_FLAGS_STREAM_RESERVED;
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 02671e648dac7..b9ee19448e38b 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -111,6 +111,7 @@ struct br_mdb_config {
>   	struct br_mdb_src_entry		*src_entries;
>   	int				num_src_entries;
>   	u8				rt_protocol;
> +	unsigned char			pg_flags;
>   };
>   #endif
>   
> @@ -317,6 +318,7 @@ struct net_bridge_fdb_flush_desc {
>   #define MDB_PG_FLAGS_STAR_EXCL		BIT(3)
>   #define MDB_PG_FLAGS_BLOCKED		BIT(4)
>   #define MDB_PG_FLAGS_OFFLOAD_FAILED	BIT(5)
> +#define MDB_PG_FLAGS_STREAM_RESERVED	BIT(6)
>   
>   #define PG_SRC_ENT_LIMIT	32
>   
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 18b558a931ad9..bc05cda2f5350 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -548,7 +548,8 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>   }
>   
>   static void br_switchdev_mdb_populate(struct switchdev_obj_port_mdb *mdb,
> -				      const struct net_bridge_mdb_entry *mp)
> +				      const struct net_bridge_mdb_entry *mp,
> +				      const struct net_bridge_port_group *pg)
>   {
>   	if (mp->addr.proto == htons(ETH_P_IP))
>   		ip_eth_mc_map(mp->addr.dst.ip4, mdb->addr);
> @@ -560,6 +561,9 @@ static void br_switchdev_mdb_populate(struct switchdev_obj_port_mdb *mdb,
>   		ether_addr_copy(mdb->addr, mp->addr.dst.mac_addr);
>   
>   	mdb->vid = mp->addr.vid;
> +	mdb->flags = 0;
> +	if (pg && (pg->flags & MDB_PG_FLAGS_STREAM_RESERVED))
> +		mdb->flags |= SWITCHDEV_MDB_F_STREAM_RESERVED;
>   }
>   
>   static void br_switchdev_host_mdb_one(struct net_device *dev,
> @@ -575,7 +579,7 @@ static void br_switchdev_host_mdb_one(struct net_device *dev,
>   		},
>   	};
>   
> -	br_switchdev_mdb_populate(&mdb, mp);
> +	br_switchdev_mdb_populate(&mdb, mp, NULL);
>   
>   	switch (type) {
>   	case RTM_NEWMDB:
> @@ -622,6 +626,7 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
>   				      unsigned long action,
>   				      enum switchdev_obj_id id,
>   				      const struct net_bridge_mdb_entry *mp,
> +				      const struct net_bridge_port_group *pg,
>   				      struct net_device *orig_dev)
>   {
>   	struct switchdev_obj_port_mdb mdb = {
> @@ -632,7 +637,7 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
>   	};
>   	struct switchdev_obj_port_mdb *pmdb;
>   
> -	br_switchdev_mdb_populate(&mdb, mp);
> +	br_switchdev_mdb_populate(&mdb, mp, pg);
>   
>   	if (action == SWITCHDEV_PORT_OBJ_ADD &&
>   	    switchdev_port_obj_act_is_deferred(dev, action, &mdb.obj)) {
> @@ -671,7 +676,7 @@ void br_switchdev_mdb_notify(struct net_device *dev,
>   	if (!pg)
>   		return br_switchdev_host_mdb(dev, mp, type);
>   
> -	br_switchdev_mdb_populate(&mdb, mp);
> +	br_switchdev_mdb_populate(&mdb, mp, pg);
>   
>   	mdb.obj.orig_dev = pg->key.port->dev;
>   	switch (type) {
> @@ -740,7 +745,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
>   		if (mp->host_joined) {
>   			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
>   							 SWITCHDEV_OBJ_ID_HOST_MDB,
> -							 mp, br_dev);
> +							 mp, NULL, br_dev);
>   			if (err) {
>   				spin_unlock_bh(&br->multicast_lock);
>   				goto out_free_mdb;
> @@ -754,7 +759,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
>   
>   			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
>   							 SWITCHDEV_OBJ_ID_PORT_MDB,
> -							 mp, dev);
> +							 mp, p, dev);
>   			if (err) {
>   				spin_unlock_bh(&br->multicast_lock);
>   				goto out_free_mdb;


