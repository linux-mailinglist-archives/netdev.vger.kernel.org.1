Return-Path: <netdev+bounces-278673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL+zKmUt32nOPgAAu9opvQ
	(envelope-from <netdev+bounces-278673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:17:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CECDE400CA6
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F1D63024164
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13258387359;
	Wed, 15 Apr 2026 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpQ9l3a/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDOjvFGd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DE3859C7
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233827; cv=pass; b=lkCHtKViBKcF96hEl03jcx53u5t/7HyQVC0xPTkAt5JTNxU/4LjWbrmJjC3vDspp19IHe0X0yQ6c6ApwrqlQqOBw4RhJJYzyRjrnvuF+8XkH46Y/BTm6ntxiRxi3i0XHFuQ58SdBmdGJepVpd16cY0CegWFziMyDBkrmvOe8GxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233827; c=relaxed/simple;
	bh=fbrcFDpIcaMmdyaAevSs9B9dUlzxWObF1EZXXDVTng8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC0YOdlJB84VAnCTEIvaqBjVfLna6YAljHobtnrln3McibZdrQVajC3LruSE327ysnPEA+qA4+F4u65uEq1mJcl5hHkP0mcwgrpAw0u7Drzag+guUrd0ISPLk8y+eu4KcGMweDtiZauYKItz/j+71MCe3Z2HetgHPvgfYUIiox8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpQ9l3a/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDOjvFGd; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776233824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opmHXqrsxPdRoCy64tj4Lr9BaPyxTTYaJkinRCgCCHY=;
	b=DpQ9l3a/aTpATmD3wVFZMYnqrVgd9735yfVNLbTzp6LaYxDjPZMMa64DC+9dauDAv/P8mO
	/rJNpx+7SsaElA5EzKaI8/KUWnn9NthW+183wjH3vk5FN+oWBwzFPAl7W7ZTJB4PAWLPCj
	NzxgiyvG49pLnwvQJ5gKgCpMAr9nyWE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-EV3m_V6SPvOgnD75jVCbcg-1; Wed, 15 Apr 2026 02:17:03 -0400
X-MC-Unique: EV3m_V6SPvOgnD75jVCbcg-1
X-Mimecast-MFC-AGG-ID: EV3m_V6SPvOgnD75jVCbcg_1776233822
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9c603ec28eso681592266b.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776233821; cv=none;
        d=google.com; s=arc-20240605;
        b=Rp7nkWOzTqr57pescKgW3pe1YZJqrNfECTzs259juyUymRhgeyPoJRgHNx30yO0rI3
         rZUingCwMvd5qlDg2izrLhKVfj5sauolTcA24lCRSokUlSrDhiNnnISegy5AsXceWSQS
         Uw4FEL0VyFFB2YhXjd1WL4xzRx3CwsTBI7OY5ol5CmvfXlbWIV1l9n/Ud+Tjdt2//ee5
         hyp7etwm2X5arrx+JYidv4YSHj/53S78oul++DvRq964I5PkbihbU8PenuRJk7SSBylj
         eb4FKjpFnUlN3murdvlKbz1neV9hRR8L9d9+SC+aP+jmYfnZrtJmhImjmdTdCq6aQ5CN
         KwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=opmHXqrsxPdRoCy64tj4Lr9BaPyxTTYaJkinRCgCCHY=;
        fh=izX2hvL3q/lpWP8t1JBzb9QUXf7eO90jtaYEcxsVvAM=;
        b=hyh5j8haMLRmO9tDkajhFZdLabZbgwnRydKtaXgGQaAPFAXhqQ3TcBxZaBJT5qFCMi
         kFRekZcWGyRD0G2HdQdttEDoqMf3SQgyGfAMsAuF41iVlmFWUkeRsWRGcsMoFcyc7j4b
         vM1rT8rrXFHe1GDtscS+Uk/KLeh+VMTDPJ+wNmiCnOuO1vh11lZZgVbha9ifgLfV9xj+
         Zj0OSDWjDd9Cui/I7d/ucEbkaknDBAGN1wQO127+qNG8tUL+8Sj2ygudmesIQbt+yVoD
         vFLmfLvWRpfQGxMnQu7OhZxTFzO3sXOBFL9dMHtQEYFc4t98gj+590K+JOfenYoWBpCI
         UjOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776233821; x=1776838621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opmHXqrsxPdRoCy64tj4Lr9BaPyxTTYaJkinRCgCCHY=;
        b=EDOjvFGdJHU9JdcF4idl5OdCtG0kbjv2IB/A2N8mbNBVPaEn7WrTQ8NThvEAZT86J4
         yw0xUCa/17RDF3mqXPhGnssQKBvcc6zHDx+7WiSwTzBLym2L4OOvkypuj0IAIbNd4BPT
         oXE5sW4Y/yClRTf+W+5raWSVim5YZZ5R1kPK1Lx2Bx4dQAErb7fUNt30kMfiTuy7Z/fV
         VGFo1nqzNyx/V1QO9QfH78EkRQEsmaedzUat270ghrcoDhLJ6MwZ69P16nlj8OiiAMD5
         4HU8tvSbg8PAVkxs/q6IKGH4smA2Kxx0dpD4FkzSqelgXpUbGFIdZoSwP6JzuOaeVJr+
         SAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776233821; x=1776838621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opmHXqrsxPdRoCy64tj4Lr9BaPyxTTYaJkinRCgCCHY=;
        b=h6UYJ/w4OavmQmFfmYVD5zwv3FUZAii3xr1a8Aqdp3pkXsuNEIH95z52X2WIMevFFg
         Tz46S4i2MXRT4wGaShHC20G+XOjbq0yNRA2ZaT+hSaUedZiK8N7wSTBvLw2t8Qr9lOdX
         rtKc2NS8We3qKFQJhk6ANMYxtx9hYgHXV3lO3RnoVO2PmjVCa5SkkETHQLVOQS00IxDQ
         dkglVA0dW6kFS8I8sGcWqxYbTG6HYNNTGpgtsFuHJYexI08yHnq3pGosJCOSY4lL27lj
         rUT6iS1a35Hve7/rinGqRMAZxwN+yKTT3kpRjsEkeiMXc7d61ncNAPmH+bcrCjG5bDam
         c6Ag==
X-Gm-Message-State: AOJu0YwGAQQ03IxHfAHQMQ8fiSCJBSbWP5aW49kx71Fbo6BNUuh2soQh
	I6it5VsE/TFEEa1oWyEV+WeX7xpHI9JufQThUTip83NcXzBjaD/djcX8oCEtuGGe1p9l7pI0bTh
	qio5XAwS1memI9x4aL/XreFyVl4uifvNQMJ727dhn9P/HdawQqFMw6oyaIiIssUVQXBhxkjKCul
	57IDSPW7F02FJCxp6fQQkWoCfj2iU0j9NVZpTwyAh8
X-Gm-Gg: AeBDievXLWZxCfgm1SJGdMqtO/YGHhk/gs/Mx91P/gwKG1RUBmNYbqsvIfKQOHFhWRm
	Rux9V7n20oA1/yvne3YXsazUQNIEvrm5Tj1kJSoE2B7+EHwYt5Abhf9/hBidHwJ2811pApS9pPn
	AYZEBzvSzfSxgDCgwHiHDXDu4OmQGC5v5buI/azvPLT9bK3SoM/2VYnxBwOPQHjqrJHpnKCwMZ5
	ri++Cch
X-Received: by 2002:a17:906:c3a2:b0:b9c:451b:234e with SMTP id a640c23a62f3a-b9d7267a8ffmr929108766b.11.1776233821040;
        Tue, 14 Apr 2026 23:17:01 -0700 (PDT)
X-Received: by 2002:a17:906:c3a2:b0:b9c:451b:234e with SMTP id
 a640c23a62f3a-b9d7267a8ffmr929107766b.11.1776233820498; Tue, 14 Apr 2026
 23:17:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 23:16:58 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 23:16:58 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260407120418.356718-1-amorenoz@redhat.com> <b4534229-994a-42ac-a200-a9cb1b333e60@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b4534229-994a-42ac-a200-a9cb1b333e60@redhat.com>
Date: Tue, 14 Apr 2026 23:16:58 -0700
X-Gm-Features: AQROBzC8WfnLD8eHUER-4k5Y5BkWpGbwOkp3FX07oIzX-iLMj145bUvIFxsrB5k
Message-ID: <CAG=2xmPLRsVE4si-6P0Pe3C6fnszO4bBVhiri=7ZntEUExowWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: openvswitch: decouple flow_table from ovs_mutex
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"open list:OPENVSWITCH" <dev@openvswitch.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278673-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CECDE400CA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 10:39:37AM +0200, Paolo Abeni wrote:
> On 4/7/26 2:04 PM, Adrian Moreno wrote:
> > Currently the entire ovs module is write-protected using the global
> > ovs_mutex. While this simple approach works fine for control-plane
> > operations (such as vport configurations), requiring the global mutex
> > for flow modifications can be problematic.
> >
> > During periods of high control-plane operations, e.g: netdevs (vports)
> > coming and going, RTNL can suffer contention. This contention is easily
> > transferred to the ovs_mutex as RTNL nests inside ovs_mutex. Flow
> > modifications, however, are done as part of packet processing and havin=
g
> > them wait for RTNL pressure to go away can lead to packet drops.
> >
> > This patch decouples flow_table modifications from ovs_mutex by means o=
f
> > the following:
> >
> > 1 - Make flow_table an rcu-protected pointer inside the datapath.
> > This allows both objects to be protected independently while reducing t=
he
> > amount of changes required in "flow_table.c".
> >
> > 2 - Create a new mutex inside the flow_table that protects it from
> > concurrent modifications.
> > Putting the mutex inside flow_table makes it easier to consume for
> > functions inside flow_table.c that do not currently take pointers to th=
e
> > datapath.
> > Some function signatures need to be changed to accept flow_table so tha=
t
> > lockdep checks can be performed.
> >
> > 3 - Create a reference count to temporarily extend rcu protection from
> > the datapath to the flow_table.
> > In order to use the flow_table without locking ovs_mutex, the flow_tabl=
e
> > pointer must be first dereferenced within an rcu-protected region.
> > Next, the table->mutex needs to be locked to protect it from
> > concurrent writes but mutexes must not be locked inside an rcu-protecte=
d
> > region, so the rcu-protected region must be left at which point the
> > datapath can be concurrently freed.
> > To extend the protection beyond the rcu region, a reference count is us=
ed.
> > One reference is held by the datapath, the other is temporarily
> > increased during flow modifications. For example:
> >
> > Datapath deletion:
> >
> >   ovs_lock();
> >   table =3D rcu_dereference_protected(dp->table, ...);
> >   rcu_assign_pointer(dp->table, NULL);
> >   ovs_flow_tbl_put(table);
> >   ovs_unlock();
> >
> > Flow modification:
> >
> >   rcu_read_lock();
> >   dp =3D get_dp(...);
> >   table =3D rcu_dereference(dp->table);
> >   ovs_flow_tbl_get(table);
> >   rcu_read_unlock();
> >
> >   mutex_lock(&table->lock);
> >   /* Perform modifications on the flow_table */
> >   mutex_unlock(&table->lock);
> >   ovs_flow_tbl_put(table);
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> > v2: Fix argument in ovs_flow_tbl_put (sparse)
> >     Remove rcu checks in ovs_dp_masks_rebalance
> > ---
> >  net/openvswitch/datapath.c   | 285 ++++++++++++++++++++++++-----------
> >  net/openvswitch/datapath.h   |   2 +-
> >  net/openvswitch/flow.c       |  13 +-
> >  net/openvswitch/flow.h       |   9 +-
> >  net/openvswitch/flow_table.c | 180 ++++++++++++++--------
> >  net/openvswitch/flow_table.h |  51 ++++++-
> >  6 files changed, 380 insertions(+), 160 deletions(-)
>
> This is too big for a single patch. The changelog above already suggests
> a way of splitting the change. At least the RCU-ification addition
> should be straight forward in a separate patch, which in turn should be
> easily reviewable.

I agree. I'll try to split it in the next version.

>
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index e209099218b4..9c234993520c 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -88,13 +88,17 @@ static void ovs_notify(struct genl_family *family,
> >   * DOC: Locking:
> >   *
> >   * All writes e.g. Writes to device state (add/remove datapath, port, =
set
> > - * operations on vports, etc.), Writes to other state (flow table
> > - * modifications, set miscellaneous datapath parameters, etc.) are pro=
tected
> > - * by ovs_lock.
> > + * operations on vports, etc.) and writes to other datapath parameters
> > + * are protected by ovs_lock.
> > + *
> > + * Writes to the flow table are NOT protected by ovs_lock. Instead, a =
per-table
> > + * mutex and reference count are used (see comment above "struct flow_=
table"
> > + * definition). On some few occasions, the per-flow table mutex is nes=
ted
> > + * inside ovs_mutex.
> >   *
> >   * Reads are protected by RCU.
> >   *
> > - * There are a few special cases (mostly stats) that have their own
> > + * There are a few other special cases (mostly stats) that have their =
own
> >   * synchronization but they nest under all of above and don't interact=
 with
> >   * each other.
> >   *
> > @@ -166,7 +170,6 @@ static void destroy_dp_rcu(struct rcu_head *rcu)
> >  {
> >  	struct datapath *dp =3D container_of(rcu, struct datapath, rcu);
> >
> > -	ovs_flow_tbl_destroy(&dp->table);
> >  	free_percpu(dp->stats_percpu);
> >  	kfree(dp->ports);
> >  	ovs_meters_exit(dp);
> > @@ -247,6 +250,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, str=
uct sw_flow_key *key)
> >  	struct ovs_pcpu_storage *ovs_pcpu =3D this_cpu_ptr(ovs_pcpu_storage);
> >  	const struct vport *p =3D OVS_CB(skb)->input_vport;
> >  	struct datapath *dp =3D p->dp;
> > +	struct flow_table *table;
> >  	struct sw_flow *flow;
> >  	struct sw_flow_actions *sf_acts;
> >  	struct dp_stats_percpu *stats;
> > @@ -257,9 +261,16 @@ void ovs_dp_process_packet(struct sk_buff *skb, st=
ruct sw_flow_key *key)
> >  	int error;
> >
> >  	stats =3D this_cpu_ptr(dp->stats_percpu);
> > +	table =3D rcu_dereference(dp->table);
> > +	if (!table) {
> > +		net_dbg_ratelimited("ovs: no flow table on datapath %s\n",
> > +				    ovs_dp_name(dp));
> > +		kfree_skb(skb);
> > +		return;
> > +	}
> >
> >  	/* Look up flow. */
> > -	flow =3D ovs_flow_tbl_lookup_stats(&dp->table, key, skb_get_hash(skb)=
,
> > +	flow =3D ovs_flow_tbl_lookup_stats(table, key, skb_get_hash(skb),
> >  					 &n_mask_hit, &n_cache_hit);
> >  	if (unlikely(!flow)) {
> >  		struct dp_upcall_info upcall;
> > @@ -752,12 +763,16 @@ static struct genl_family dp_packet_genl_family _=
_ro_after_init =3D {
> >  static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stat=
s *stats,
> >  			 struct ovs_dp_megaflow_stats *mega_stats)
> >  {
> > +	struct flow_table *table =3D ovsl_dereference(dp->table);
>
> Should be rcu_dereference_ovs_tbl() ?
>

This function is only called with ovs_lock() (at least for now, we might
reconsider it based on your other comments below), so I kept the
stricter assertion.

> >  	int i;
> >
> >  	memset(mega_stats, 0, sizeof(*mega_stats));
> >
> > -	stats->n_flows =3D ovs_flow_tbl_count(&dp->table);
> > -	mega_stats->n_masks =3D ovs_flow_tbl_num_masks(&dp->table);
> > +	if (table) {
> > +		stats->n_flows =3D ovs_flow_tbl_count(table);
>
> As noted by Aaron, READ_ONCE() is now needed when accessing
> table->count. And WRITE_ONCE when writing it
>

Yep.

> > +		mega_stats->n_masks =3D ovs_flow_tbl_num_masks(table);
>
> Sashiko says:
>
> ---
> get_dp_stats() accesses table->mask_array via ovs_flow_tbl_num_masks()
> while holding only ovs_mutex. Since this patch decouples flow table updat=
es
> by moving them under table->lock, ovs_flow_cmd_new() can execute
> concurrently and trigger a reallocation of the mask array, freeing the ol=
d
> one via call_rcu().
> Because get_dp_stats() does not hold rcu_read_lock(), the thread can be
> preempted (as ovs_mutex is sleepable) and the RCU grace period might expi=
re
> before the count is read. Can this lead to a use-after-free?
> ---
>

I guess it is possible that all that happens between the dereference of
table->mask_array and the read of "ma->count".

Maybe we could rcu_read_lock() the call to "ofs_flow_tbl_num_masks" or
use RCU protection for the entire flow-table-related statistics?
I think this would allow us to demote "rcu_dereference_ovs_tbl" to only
consider table lock and RCU and use to dereference "dp->table".

> Note that it also spotted pre-existing issues, please have a look:
>
> https://sashiko.dev/#/patchset/20260407120418.356718-1-amorenoz%40redhat.=
com
>

Interesting. I'll look deeper into this, thanks!

> [...]
> > @@ -71,15 +93,40 @@ struct flow_table {
> >
> >  extern struct kmem_cache *flow_stats_cache;
> >
> > +#ifdef CONFIG_LOCKDEP
> > +int lockdep_ovs_tbl_is_held(const struct flow_table *table);
> > +#else
> > +static inline int lockdep_ovs_tbl_is_held(const struct flow_table *tab=
le)
> > +{
> > +	(void)table;
>
> You can use the __always_unused annotation.
>

Thanks, will do.

> > +	return 1;
> > +}
> > +#endif
> > +
> > +#define ASSERT_OVS_TBL(tbl)   WARN_ON(!lockdep_ovs_tbl_is_held(tbl))
> > +
> > +/* Lock-protected update-allowed dereferences.*/
> > +#define ovs_tbl_dereference(p, tbl)	\
> > +	rcu_dereference_protected(p, lockdep_ovs_tbl_is_held(tbl))
> > +
> > +/* Read dereferences can be protected by either RCU, table lock or ovs=
_mutex. */
>
> Is this access schema really safe? I understand tables can be
> written/deleted under the table lock only. If so this should ignore the
> OVS mutex status.
>

Even if it was safe (which it might not), it's confusing and makes it
difficult to understand the overall locking strategy.

I'll revisit all uses carefully but I think the only use-cases for only
holding the ovs_mutex are datapath statistics reading (such as
ovs_dp_stats we are discussing above). I will try to make use RCU in
those cases which might make them safer and everything more robust.

Thank you!
Adri=C3=A1n

> /P
>


