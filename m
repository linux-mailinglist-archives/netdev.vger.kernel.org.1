Return-Path: <netdev+bounces-298625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2eOhB478K2o6JAQAu9opvQ
	(envelope-from <netdev+bounces-298625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:33:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E86795E6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:33:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RW90IJz6;
	dkim=pass header.d=redhat.com header.s=google header.b=DXzM8ZDP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298625-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298625-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 403193006222
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353E3DB652;
	Fri, 12 Jun 2026 12:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB115B971
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:33:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267587; cv=none; b=rYgBer1SPKYLRQl+64w1lD9s4c/Si/KzR7J9UHH/+2gHXH33pt1LBIU6V842rOYWHlF47Pm/6ZxCVlAy1vQm4MIADP2VkMy6MLK+fnptmepwPReh/ZOOd3GDjBSMoFP+KxH/BeYUPzDfq4uHXuH5kZL/lbVOJAIS4mQoCK8+W6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267587; c=relaxed/simple;
	bh=neqF3ZJ0RM58yRx8EhB87dBgrW1cPu5BIRNKi5z4ylk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lt1pJrLdM2qWkKUIg44OPB1gXsyG10GM/IxnaXAnmdMO3jaY6oBCytlIMwupZuhfrEUh8KnuK64km4LatC0xmbu6sHQm/elR9yFeiGaaSlUQI3fULcZDg3xoSm7gWwXlTxfryvHRwYHQZaefolVwSAJW/z9xsDeooeFHmfeG0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RW90IJz6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXzM8ZDP; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781267583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sitiNtJI2vvGtaVwoQZDdJSQ/FtwXIAN0T9g+Ogu2g=;
	b=RW90IJz60LbXPKPgXydDNFvYuufj0HiTsIBooSueAmuuiQoGvdFSAoVsg/l3Oiczlg65E+
	Xv/Ax5H3krgjKasXY2ugWK+oEcHhPoOkgFZmuUGyCcIOO21VGRGgWzYs8W3/+kWD/cdJuc
	qg84LpPCkkMe/hqDK8Eff0XcqoEyZN4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-9bk_-ZqKM9uPC2nG0WI2JA-1; Fri, 12 Jun 2026 08:33:02 -0400
X-MC-Unique: 9bk_-ZqKM9uPC2nG0WI2JA-1
X-Mimecast-MFC-AGG-ID: 9bk_-ZqKM9uPC2nG0WI2JA_1781267581
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-691ac5b31cbso806948a12.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781267581; x=1781872381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sitiNtJI2vvGtaVwoQZDdJSQ/FtwXIAN0T9g+Ogu2g=;
        b=DXzM8ZDPSD+lufhUrO5jfWonNy3ynZnZDzCuGUGWad5WAw5kMSDEQDaoGjf3+Z2dn/
         ToW9V/bd2uT4RnD/rmPTMXDvlL2phhTYCyYgtvf9rsRA6+QvQTz12nVQD8hIdk5LMvhK
         XGZuujUF0xXkkBQTZ+XUQ+/woERt6cn4UvhKt1c4YxTA5yVrv9OGO4EEvM3oKV3t9lM0
         YIpnbYz25SglYKxbFwChZLfD/QLmyxLWlGwosW5P5EmHi/yWiopu0mOP9BtfYwi6BjAM
         dODEgb2x7SH0ccu157iNCpbka7Nab+zmw/C3uwdm4WOwf9G24PNgR5o2rQZgMGtF87BL
         S0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781267581; x=1781872381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2sitiNtJI2vvGtaVwoQZDdJSQ/FtwXIAN0T9g+Ogu2g=;
        b=VJtAyDpJ36vAAomAxMO0X9nPI5RlaVfSK5sJteCtgy+wCsnKEw62t2TjeXqan4Wojd
         QeKfr4jHTxCPaQlm/ikBOwH+WkcY7Gzw8u2CLK32EA81nMs5oJemo3CsDlDaYh0ccKcP
         9liZNspQKuWHMjM3eXc9VXu6ivtfVVFsW8U0wdOZJGiJIU82l8wWgG6bUeBn2UH5EUah
         Pr1CrXVzjOeplnbGHgZ/IeGh4KNUTIlqWA4C9bYJ2je2UxrQrZ1GHCOC0z2mgrJUVATF
         1T5ebN6b4VazL6uU4ZPAemf1e6TdQgDmZ/HsnCoUYUZxSMSNGBpY/DTF4/9rxFVXDE7/
         yamQ==
X-Gm-Message-State: AOJu0YwoviGwjoxac2pl5Qeu24Ck1QWy+lpyBVzdMoA5v7jJaL82I57D
	VzjFv4hMApfpkdEFQGKj+y09HgiPl2Ifjows092B34qHnt8zwgcRTFHNJuWG5+RgMqZdsuUruP/
	JU3yq8qWOCejGDRntF9SjXFe5eim3mo25kk0BDY5FF/yKmMkRvvR/AOrDZA==
X-Gm-Gg: Acq92OG0PZzuzMIWJYzrG+aoh1Z9jBqcPlbwq28saJy+YF7z527qdS5SXxj97EX9w5+
	JaTgIC4QSmMJXhaDv70Wlo8o9rjNGxGtjjvVNbQxh9KALxPGkIIlh+v/nkQFo+Pz2tonkVUaZq1
	H3ZG//Cu8croNwrSwpZki/mJbh0LaJqo93VuZTByUJXSq5OejK3D44vxpj6jW/Rh8pYDIkb3YpM
	zC2GdSUtSyXD8yP8iY9V+ewKW9RtOkYQyG07mVG6R1Hn+kmiKCYUidrtv/iPZyOS5xle1dsUzD/
	beZs8/cqL7Q5Pkj7q0Eo1/rWtyrQd9Rt0G/WHuz4IPi+wzo+TGx/XbpDhzPoY+7xukpwru/YUMP
	N2pxw1Dgz+EdxBLKqysbG1eFblEarOMbV2dj82XxuvYN+f0k6c8hggpIBLVDzPz2KO3GTP8k=
X-Received: by 2002:a05:6402:5203:b0:68f:cc95:8c11 with SMTP id 4fb4d7f45d1cf-69378a5ecf3mr1241826a12.28.1781267580674;
        Fri, 12 Jun 2026 05:33:00 -0700 (PDT)
X-Received: by 2002:a05:6402:5203:b0:68f:cc95:8c11 with SMTP id 4fb4d7f45d1cf-69378a5ecf3mr1241809a12.28.1781267580205;
        Fri, 12 Jun 2026 05:33:00 -0700 (PDT)
Received: from [10.44.49.141] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937938a0acsm637062a12.19.2026.06.12.05.32.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:32:58 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, pabeni@redhat.com,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 "open list:OPENVSWITCH" <dev@openvswitch.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/4] net: openvswitch: make flow_table an rcu
 pointer
Date: Fri, 12 Jun 2026 14:32:54 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <747F3742-1EEC-47FA-AE5A-FDA6C469C42F@redhat.com>
In-Reply-To: <20260611045817.1302665-2-amorenoz@redhat.com>
References: <20260611045817.1302665-1-amorenoz@redhat.com>
 <20260611045817.1302665-2-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298625-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:amorenoz@redhat.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:pabeni@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 467E86795E6

On 11 Jun 2026, at 6:58, Adrian Moreno wrote:

> This patch turns "flow_table" from being embedded into "datapath" to
> being an rcu protected pointer. No functional change intended.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Hi Adrian,

Thanks for the series. I need some time to take a look, as this is
the first time I reviewed this series. I'll probably reply to the
other patches early next week.

Some small comments below.

Cheers,
Eelco

[...]

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c

[...]

> @@ -752,12 +759,16 @@ static struct genl_family dp_packet_genl_family _=
_ro_after_init =3D {
>  static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stat=
s *stats,
>  			 struct ovs_dp_megaflow_stats *mega_stats)
>  {
> +	struct flow_table *table =3D ovsl_dereference(dp->table);
>  	int i;
>
>  	memset(mega_stats, 0, sizeof(*mega_stats));
> +	memset(stats, 0, sizeof(*stats));
>
> -	stats->n_flows =3D ovs_flow_tbl_count(&dp->table);
> -	mega_stats->n_masks =3D ovs_flow_tbl_num_masks(&dp->table);
> +	if (table) {
> +		stats->n_flows =3D ovs_flow_tbl_count(table);
> +		mega_stats->n_masks =3D ovs_flow_tbl_num_masks(table);
> +	}

The memset above seems like an overkill, why not do this:

    if (table) {
		stats->n_flows =3D ovs_flow_tbl_count(table);
		mega_stats->n_masks =3D ovs_flow_tbl_num_masks(table);
	} else {
		stats->n_flows =3D 0;
	}

>
>  	stats->n_hit =3D stats->n_missed =3D stats->n_lost =3D 0;

[...]

> @@ -1598,8 +1639,13 @@ static int ovs_dp_cmd_fill_info(struct datapath =
*dp, struct sk_buff *skb,
>  	struct ovs_dp_stats dp_stats;
>  	struct ovs_dp_megaflow_stats dp_megaflow_stats;
>  	struct dp_nlsk_pids *pids =3D ovsl_dereference(dp->upcall_portids);
> +	struct flow_table *table;
>  	int err, pids_len;
>
> +	table =3D ovsl_dereference(dp->table);
> +	if (!table)
> +		return -ENODEV;

ovs_dp_cmd_fill_info() can now return -ENODEV when table is
NULL, but every caller immediately follows with:

	BUG_ON(err < 0);

so this would panic the kernel. I guess you fix this in the 3rd patch,
but just mentioning this as patch 1 is unsafe to apply in isolation.

>  	ovs_header =3D genlmsg_put(skb, portid, seq, &dp_datapath_genl_family=
,
>  				 flags, cmd);
>  	if (!ovs_header)

[...]

> @@ -1917,7 +1972,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, st=
ruct genl_info *info)
>  /* Called with ovs_mutex. */
>  static void __dp_destroy(struct datapath *dp)
>  {
> -	struct flow_table *table =3D &dp->table;
> +	struct flow_table *table =3D ovsl_dereference(dp->table);
>  	int i;
>
>  	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
> @@ -1948,6 +2003,7 @@ static void __dp_destroy(struct datapath *dp)
>
>  	/* RCU destroy the ports, meters and flow tables. */
>  	call_rcu(&dp->rcu, destroy_dp_rcu);

In theory the table pointer cannot be NULL here, but would
it make sense to add a WARN_ON(!table) to catch any future
mistakes?

> +	call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
>  }
>

[...]

> diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.=
c
> index 67d5b8c0fe79..3b7518e3394d 100644
> --- a/net/openvswitch/flow_table.c
> +++ b/net/openvswitch/flow_table.c
> @@ -406,15 +406,19 @@ int ovs_flow_tbl_masks_cache_resize(struct flow_t=
able *table, u32 size)
>  	return 0;
>  }
>
> -int ovs_flow_tbl_init(struct flow_table *table)
> +struct flow_table *ovs_flow_tbl_alloc(void)
>  {
>  	struct table_instance *ti, *ufid_ti;
> +	struct flow_table *table;
>  	struct mask_cache *mc;
>  	struct mask_array *ma;
>
> +	table =3D kzalloc_obj(*table, GFP_KERNEL);
> +	if (!table)
> +		return ERR_PTR(-ENOMEM);

Add an extra blank line?

>  	mc =3D tbl_mask_cache_alloc(MC_DEFAULT_HASH_ENTRIES);
>  	if (!mc)
> -		return -ENOMEM;
> +		goto free_table;
>
>  	ma =3D tbl_mask_array_alloc(MASK_ARRAY_SIZE_MIN);
>  	if (!ma)
> @@ -435,7 +439,7 @@ int ovs_flow_tbl_init(struct flow_table *table)
>  	table->last_rehash =3D jiffies;
>  	table->count =3D 0;
>  	table->ufid_count =3D 0;
> -	return 0;
> +	return table;
>
>  free_ti:
>  	__table_instance_destroy(ti);
> @@ -443,7 +447,9 @@ int ovs_flow_tbl_init(struct flow_table *table)
>  	__mask_array_destroy(ma);
>  free_mask_cache:
>  	__mask_cache_destroy(mc);
> -	return -ENOMEM;
> +free_table:
> +	kfree(table);
> +	return ERR_PTR(-ENOMEM);
>  }

[...]


