Return-Path: <netdev+bounces-278648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG/8Igoj32ngPAAAu9opvQ
	(envelope-from <netdev+bounces-278648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78F4007BE
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1946E3030EA0
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB52328B5E;
	Wed, 15 Apr 2026 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aw0HUpg7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KciChk31"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A8217704
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231175; cv=pass; b=osimvEJvqNGOgIWPKervJm3+/zzwOvph3WQdUtROvDBekL+P8SIO5OVizotVKpF7yxH3aYYgjgHeh3Ad5cBSSSFUjds+oe4iKt3gvCM82axHKKKv4qMjz+FClPQmjCFuK+5NlLVWZzuvZpJV9Al73PD5kuKNkAwEwLqaWD9TbPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231175; c=relaxed/simple;
	bh=dGYCd0+HnS7HvlQ6ksmp3kUxpWJ7Z3+wmaUgUiPSgmE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKFR9wSBvaRRfx0XUL4cZwg1LFUf7lpnZ/Rjns5gxz1GCiON2fuCaEN1hu44xy4YVCFij97RacZORusLCHEccCQjbngMbFBlEo5FooWi9vTpIHDM07xGXbg5NjL8Db8rkrRmsukbEGDQWn5WWjGuhcU4dJdBa/E/wjdfm5Wgtxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aw0HUpg7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KciChk31; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776231171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hKZ3c7q2c6Vyt/8ew/F7jQ7Ugo0I7rx3oU9WQosZN4=;
	b=Aw0HUpg79u/lHMdaJ3n5eWiW6+1xmYw0VUucpZJla3slL60765oVnF3aP2eh9Cvv99VvGV
	0NPlopoi1ZXCXdeUpLlgVE14eeEqnZUin2AEEw7ammWZJ8IB4mw7N2BTazK6tDk7G2Uu35
	I685DXBYqipdfMk9acMg+xA9HBey1Uo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-9RQLNjzTOY-uMQotDlkVAw-1; Wed, 15 Apr 2026 01:32:49 -0400
X-MC-Unique: 9RQLNjzTOY-uMQotDlkVAw-1
X-Mimecast-MFC-AGG-ID: 9RQLNjzTOY-uMQotDlkVAw_1776231168
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b934e96af9dso590037066b.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 22:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776231167; cv=none;
        d=google.com; s=arc-20240605;
        b=Gn70hBCpm9raPxxcVBfGXxUPj3lze6X6X+Z+3mqg4TjezXgkvMc7Q1+KHChqCm33O9
         yqBtS2BI6dlGwe6GrIe3glVofMC6cXf2KikzfE8uTVEdAjz7IPYAFq2AwT0ZJctO1ohM
         Ci/DA3b2aMF2kgxiKva/WYg+8QYH4lOmh/EA9OuG3NULmwtlVWg/S7PC4HDYCm6Gv25O
         X9zGVdO8ED03B9qAdsWD7Xe8kNzyOcHYYtukinXQfEJkmk2/4yf36OhrXk8iRq/eqvoB
         /WeFrL2g9bQXuY7gdNISrbDK+KKng83xkdS0WLHchjdFnOIa+iPZeCeGjxeWXXvAfgZj
         Lbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=1hKZ3c7q2c6Vyt/8ew/F7jQ7Ugo0I7rx3oU9WQosZN4=;
        fh=DQd0rNASIfcYkTivUoei3d6f1BahIKo/e15kHQLJSA8=;
        b=g/t1MoQvVzL5z48vrp1MwgNy+nyGcir7crv4lvFVmK9Wo4+T9OpJ6xvFihCAuNj1Se
         Rip4kOPEHNK8hTHtj7frZO0odEcOhy4y6Lk4uRfYFWarJaR2SAocfPwll8HbIStVfaRx
         u4fqMWyXdEZxwDPnQIsmtie+YLvVDfrB5eku0zvUP3EYtW02fQ8IkDgn3SQhvChxXwhF
         /2FR/KQ86KaBK+Bi2pzGwMu+n1kXU9gQ93b3FLwPTlCygTcfZwssqloJD0jgXDIdTh1G
         bxKs+NIQLZM2MR400HQhnQ2Ungheoib5yZMZ8Kk8QDw0Zr5kq9yw+aikt2OZ7gg3nWEe
         eMTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776231167; x=1776835967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hKZ3c7q2c6Vyt/8ew/F7jQ7Ugo0I7rx3oU9WQosZN4=;
        b=KciChk31jrjyyOal+3kDvInn6MUkyn1puaeA/eKPzU0iVEYMdLWfrh0bjeLnjcOmbT
         RNYdZrFTFj4/40wP/y4EBXhKkDEfdAxR8MFSFqW8CAt3tj50Mi2LFYJwZsZ11yxKdDos
         g6NdB4dl81GP+1RTkEgZMfIZy6LTXg9zv0k2qAXTw4kLJhpstAdVoezE6gNsgBs2nVsl
         rnQFoidCjTInbDhIkw3JrkeiPOLAgnWbxVYdnKdUzgsqlv7rI1bw9qiLqt3d3vJjQ2Ad
         DTXN34SLJi67ANFbhM2Wg/RdJfYVeb1ObZB3yxRxEorpY7n6SMjC3iUUjuMEnfRiANFQ
         CsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776231167; x=1776835967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hKZ3c7q2c6Vyt/8ew/F7jQ7Ugo0I7rx3oU9WQosZN4=;
        b=LGPG76cCp/ni9OuUo3a4YUKzUF8e8lHnTTZfivFmwQt9rx3I4TBbaNZUc/AiqBMl7c
         +64idmoyD6Stj71aHKEJvMcCFCD0Zj245waHRHAecXkjBW81i1HcKtJ1rjfOOyTjXTFI
         ScHJJ5BSlhCoMrOOCxH8LdHWKQLO6OO9TFBv6wA+VGiXy15EnyPxdZjjeKSX0KxeOVWI
         WWpBSzHiUw+D5LOpBCSn8vgiInQ0YbkU3YXocspOvodFDLt1OhV4pUrWXolx/4KkuXaq
         JwZRZeKxSFTHOVyVihy9MTij5nSeOHCx7aTbDARXgecrBAS+CuHVZBvHQNadz5pXkHjC
         OdgA==
X-Forwarded-Encrypted: i=1; AFNElJ/aQ4UrAKklexK2UIWb0JziSLsXDyFZAjqhTGV64Albo/VZNluFW5EdiUI+/FGB4IZMg7Rro3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcU+H7F0/v4CDjY6bDJuq6ZLCkd7XHwYfN5HqQJFUHGxJWf6E
	rWdyGyPpweVFZmvdGJdvpKiGvEbs5Q899S/PvSJwVNJ0sLBF8YTU6QkpzmJXxSGqUZ3QEckAg3v
	XRAowN/VYbMMRiVnaOJjCm1dLrFjxTUOb1ye8U9KlEmHHDEQzjBCmvRb14beZmtSqa1uHIFn2Wq
	IJIsJ8PJ82iIOiSCQBm+2G4RIP0FBGW13WRPEt5S84
X-Gm-Gg: AeBDietsfYE7OOeWs8STqUenWgT01jxjxXmQLwceYWSuMlvtoHzSzA16f0+2i6a9IaY
	uQKdrWr7pitmP720BJPSN+5Qo4rA6y7Pwh1KnyC+C7+VtZm4OMt5Bn/foWtJXqoqMEQi3o/TKOS
	6x5mRM7DkDPEz4h+QEFBtfX8cEgUtE/tl3eOaLKL7Y6XF7WeXyfIsQMqT7K0zJisVmQ9XfvaFbB
	n/crb/q
X-Received: by 2002:a17:907:848:b0:b9d:64af:d966 with SMTP id a640c23a62f3a-b9d7248a91amr1022547266b.13.1776231166563;
        Tue, 14 Apr 2026 22:32:46 -0700 (PDT)
X-Received: by 2002:a17:907:848:b0:b9d:64af:d966 with SMTP id
 a640c23a62f3a-b9d7248a91amr1022544966b.13.1776231165530; Tue, 14 Apr 2026
 22:32:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 22:32:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 22:32:43 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260407120418.356718-1-amorenoz@redhat.com> <f7twlyeabra.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7twlyeabra.fsf@redhat.com>
Date: Tue, 14 Apr 2026 22:32:43 -0700
X-Gm-Features: AQROBzDURwMSldSLeK6wygVwswqnspY0qpy4-cFE0kxf5m-VEZltXc_1gh0G5MM
Message-ID: <CAG=2xmNX4tmCO4aXfWk9Lup8FZUn+1aRDM0QdEd_fWUk-V7hsw@mail.gmail.com>
Subject: Re: [ovs-dev] [PATCH net-next v2] net: openvswitch: decouple
 flow_table from ovs_mutex
To: Aaron Conole <aconole@redhat.com>
Cc: Adrian Moreno via dev <ovs-dev@openvswitch.org>, netdev@vger.kernel.org, 
	"open list:OPENVSWITCH" <dev@openvswitch.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, Ilya Maximets <i.maximets@ovn.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278648-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,openvswitch.org:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AB78F4007BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:52:41PM -0400, Aaron Conole wrote:
> Hi Adrian,
>
> Thanks for the patch.  A few questions inline.
>
> Adrian Moreno via dev <ovs-dev@openvswitch.org> writes:
>
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
>
> I guess it's possible now to have flow operations succeed on
> 'removed-but-not-yet-freed' tables.  That's probably worth documenting
> somewhere, since it is a slight behavior change.  More below
>

You are right. That corner case is kind of weird as we could be adding a
flow to a table that has been deteched from the datapath and will be
freed inmediately after. I can add a comment in __dp_destroy about this.


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
> >
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
> >  	int i;
> >
> >  	memset(mega_stats, 0, sizeof(*mega_stats));
> >
> > -	stats->n_flows =3D ovs_flow_tbl_count(&dp->table);
> > -	mega_stats->n_masks =3D ovs_flow_tbl_num_masks(&dp->table);
> > +	if (table) {
> > +		stats->n_flows =3D ovs_flow_tbl_count(table);
>
> Previously, when calling this we'd be under the ovs_mutex and the read
> on table->count would be somewhat coherent (for some definition of
> coherent).  BUT we are now doing a bare read.  I'm not sure if we should
> take the lock here, or at least give some kind of barrier (READ_ONCE and
> update the count setting sites with WRITE_ONCEs)?  WDYT?
>

I think you are right, this call can now happen in parallel with
statistic updates on the flow table side.

IIUC, datapath operations such as this still hold the ovs_mutex,
"ovsl_dereference()" above should splat if that's not true. And
"table->lock" would force us to also hold it while updating the
stats which undermines the purpose of this patch. So
READ_ONCE/WRITE_ONCE seems like a good solution here.

> > +		mega_stats->n_masks =3D ovs_flow_tbl_num_masks(table);
> > +	}
> > +
> >
> >  	stats->n_hit =3D stats->n_missed =3D stats->n_lost =3D 0;
> >
> > @@ -829,15 +844,16 @@ static size_t ovs_flow_cmd_msg_size(const struct =
sw_flow_actions *acts,
> >  		+ nla_total_size_64bit(8); /* OVS_FLOW_ATTR_USED */
> >  }
> >
> > -/* Called with ovs_mutex or RCU read lock. */
> > +/* Called with table->lock or RCU read lock. */
> >  static int ovs_flow_cmd_fill_stats(const struct sw_flow *flow,
> > +				   const struct flow_table *table,
> >  				   struct sk_buff *skb)
> >  {
> >  	struct ovs_flow_stats stats;
> >  	__be16 tcp_flags;
> >  	unsigned long used;
> >
> > -	ovs_flow_stats_get(flow, &stats, &used, &tcp_flags);
> > +	ovs_flow_stats_get(flow, table, &stats, &used, &tcp_flags);
> >
> >  	if (used &&
> >  	    nla_put_u64_64bit(skb, OVS_FLOW_ATTR_USED, ovs_flow_used_time(use=
d),
> > @@ -857,8 +873,9 @@ static int ovs_flow_cmd_fill_stats(const struct sw_=
flow *flow,
> >  	return 0;
> >  }
> >
> > -/* Called with ovs_mutex or RCU read lock. */
> > +/* Called with RCU read lock or table->lock held. */
> >  static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
> > +				     const struct flow_table *table,
> >  				     struct sk_buff *skb, int skb_orig_len)
> >  {
> >  	struct nlattr *start;
> > @@ -878,7 +895,7 @@ static int ovs_flow_cmd_fill_actions(const struct s=
w_flow *flow,
> >  	if (start) {
> >  		const struct sw_flow_actions *sf_acts;
> >
> > -		sf_acts =3D rcu_dereference_ovsl(flow->sf_acts);
> > +		sf_acts =3D rcu_dereference_ovs_tbl(flow->sf_acts, table);
> >  		err =3D ovs_nla_put_actions(sf_acts->actions,
> >  					  sf_acts->actions_len, skb);
> >
> > @@ -897,8 +914,10 @@ static int ovs_flow_cmd_fill_actions(const struct =
sw_flow *flow,
> >  	return 0;
> >  }
> >
> > -/* Called with ovs_mutex or RCU read lock. */
> > -static int ovs_flow_cmd_fill_info(const struct sw_flow *flow, int dp_i=
findex,
> > +/* Called with table->lock or RCU read lock. */
> > +static int ovs_flow_cmd_fill_info(const struct sw_flow *flow,
> > +				  const struct flow_table *table,
> > +				  int dp_ifindex,
> >  				  struct sk_buff *skb, u32 portid,
> >  				  u32 seq, u32 flags, u8 cmd, u32 ufid_flags)
> >  {
> > @@ -929,12 +948,12 @@ static int ovs_flow_cmd_fill_info(const struct sw=
_flow *flow, int dp_ifindex,
> >  			goto error;
> >  	}
> >
> > -	err =3D ovs_flow_cmd_fill_stats(flow, skb);
> > +	err =3D ovs_flow_cmd_fill_stats(flow, table, skb);
> >  	if (err)
> >  		goto error;
> >
> >  	if (should_fill_actions(ufid_flags)) {
> > -		err =3D ovs_flow_cmd_fill_actions(flow, skb, skb_orig_len);
> > +		err =3D ovs_flow_cmd_fill_actions(flow, table, skb, skb_orig_len);
> >  		if (err)
> >  			goto error;
> >  	}
> > @@ -968,8 +987,9 @@ static struct sk_buff *ovs_flow_cmd_alloc_info(cons=
t struct sw_flow_actions *act
> >  	return skb;
> >  }
> >
> > -/* Called with ovs_mutex. */
> > +/* Called with table->lock. */
> >  static struct sk_buff *ovs_flow_cmd_build_info(const struct sw_flow *f=
low,
> > +					       const struct flow_table *table,
> >  					       int dp_ifindex,
> >  					       struct genl_info *info, u8 cmd,
> >  					       bool always, u32 ufid_flags)
> > @@ -977,12 +997,12 @@ static struct sk_buff *ovs_flow_cmd_build_info(co=
nst struct sw_flow *flow,
> >  	struct sk_buff *skb;
> >  	int retval;
> >
> > -	skb =3D ovs_flow_cmd_alloc_info(ovsl_dereference(flow->sf_acts),
> > +	skb =3D ovs_flow_cmd_alloc_info(ovs_tbl_dereference(flow->sf_acts, ta=
ble),
> >  				      &flow->id, info, always, ufid_flags);
> >  	if (IS_ERR_OR_NULL(skb))
> >  		return skb;
> >
> > -	retval =3D ovs_flow_cmd_fill_info(flow, dp_ifindex, skb,
> > +	retval =3D ovs_flow_cmd_fill_info(flow, table, dp_ifindex, skb,
> >  					info->snd_portid, info->snd_seq, 0,
> >  					cmd, ufid_flags);
> >  	if (WARN_ON_ONCE(retval < 0)) {
> > @@ -998,6 +1018,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, s=
truct genl_info *info)
> >  	struct nlattr **a =3D info->attrs;
> >  	struct ovs_header *ovs_header =3D genl_info_userhdr(info);
> >  	struct sw_flow *flow =3D NULL, *new_flow;
> > +	struct flow_table *table;
> >  	struct sw_flow_mask mask;
> >  	struct sk_buff *reply;
> >  	struct datapath *dp;
> > @@ -1064,30 +1085,43 @@ static int ovs_flow_cmd_new(struct sk_buff *skb=
, struct genl_info *info)
> >  		goto err_kfree_acts;
> >  	}
> >
>
> I think this can lead to a weird(?) behavior:
>
> thread A (dp_destroy):                   thread b (ovs_flow_cmd_new):
> rcu_assign_pointer(dp->table, NULL)
>                                          rcu_read_lock();
>                                          table =3D
>                                          rcu_dereference(dp->table);
>                                            [old table]
>                                          ovs_flow_tbl_get(table)
>                                              //refcnt change
>                                          rcu_read_unlock()
> ovs_flow_tbl_put(table) // refcnt chg
>                                          mutex_lock(table->lock)
>                                          ovs_flow_table_insert(...)
>                                          [success reply]
>                                          mutex_unlock(table->lock)
>                                          ovs_flow_tbl_put(table)
>                                          // table flow flush, etc.
>
> I guess it isn't a huge deal (installing flow while deleting table would
> be weird from a userspace perspective), and I think it is safe, but it
> is worth mentioning that we can have such scenario now.
>

I completely agree, this was not documented (it will in the next version
of the patch) but it's the inevitable side effect of this design.

> > -	ovs_lock();
> > +	rcu_read_lock();
> >  	dp =3D get_dp(net, ovs_header->dp_ifindex);
> >  	if (unlikely(!dp)) {
> >  		error =3D -ENODEV;
> > -		goto err_unlock_ovs;
> > +		rcu_read_unlock();
> > +		goto err_kfree_reply;
> >  	}
> > +	table =3D rcu_dereference(dp->table);
> > +	if (!table || !ovs_flow_tbl_get(table)) {
> > +		error =3D -ENODEV;
> > +		rcu_read_unlock();
> > +		goto err_kfree_reply;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	/* It is safe to dereference "table" after leaving rcu read-protected
> > +	 * region because it's pinned by refcount.
> > +	 */
> > +	mutex_lock(&table->lock);
> >
> >  	/* Check if this is a duplicate flow */
> >  	if (ovs_identifier_is_ufid(&new_flow->id))
> > -		flow =3D ovs_flow_tbl_lookup_ufid(&dp->table, &new_flow->id);
> > +		flow =3D ovs_flow_tbl_lookup_ufid(table, &new_flow->id);
> >  	if (!flow)
> > -		flow =3D ovs_flow_tbl_lookup(&dp->table, key);
> > +		flow =3D ovs_flow_tbl_lookup(table, key);
> >  	if (likely(!flow)) {
> >  		rcu_assign_pointer(new_flow->sf_acts, acts);
> >
> >  		/* Put flow in bucket. */
> > -		error =3D ovs_flow_tbl_insert(&dp->table, new_flow, &mask);
> > +		error =3D ovs_flow_tbl_insert(table, new_flow, &mask);
> >  		if (unlikely(error)) {
> >  			acts =3D NULL;
> > -			goto err_unlock_ovs;
> > +			goto err_unlock_tbl;
> >  		}
> >
> >  		if (unlikely(reply)) {
> > -			error =3D ovs_flow_cmd_fill_info(new_flow,
> > +			error =3D ovs_flow_cmd_fill_info(new_flow, table,
> >  						       ovs_header->dp_ifindex,
> >  						       reply, info->snd_portid,
> >  						       info->snd_seq, 0,
> > @@ -1095,7 +1129,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, =
struct genl_info *info)
> >  						       ufid_flags);
> >  			BUG_ON(error < 0);
> >  		}
> > -		ovs_unlock();
> > +		mutex_unlock(&table->lock);
> > +		ovs_flow_tbl_put(table);
> >  	} else {
> >  		struct sw_flow_actions *old_acts;
> >
> > @@ -1108,28 +1143,28 @@ static int ovs_flow_cmd_new(struct sk_buff *skb=
, struct genl_info *info)
> >  		if (unlikely(info->nlhdr->nlmsg_flags & (NLM_F_CREATE
> >  							 | NLM_F_EXCL))) {
> >  			error =3D -EEXIST;
> > -			goto err_unlock_ovs;
> > +			goto err_unlock_tbl;
> >  		}
> >  		/* The flow identifier has to be the same for flow updates.
> >  		 * Look for any overlapping flow.
> >  		 */
> >  		if (unlikely(!ovs_flow_cmp(flow, &match))) {
> >  			if (ovs_identifier_is_key(&flow->id))
> > -				flow =3D ovs_flow_tbl_lookup_exact(&dp->table,
> > +				flow =3D ovs_flow_tbl_lookup_exact(table,
> >  								 &match);
> >  			else /* UFID matches but key is different */
> >  				flow =3D NULL;
> >  			if (!flow) {
> >  				error =3D -ENOENT;
> > -				goto err_unlock_ovs;
> > +				goto err_unlock_tbl;
> >  			}
> >  		}
> >  		/* Update actions. */
> > -		old_acts =3D ovsl_dereference(flow->sf_acts);
> > +		old_acts =3D ovs_tbl_dereference(flow->sf_acts, table);
> >  		rcu_assign_pointer(flow->sf_acts, acts);
> >
> >  		if (unlikely(reply)) {
> > -			error =3D ovs_flow_cmd_fill_info(flow,
> > +			error =3D ovs_flow_cmd_fill_info(flow, table,
> >  						       ovs_header->dp_ifindex,
> >  						       reply, info->snd_portid,
> >  						       info->snd_seq, 0,
> > @@ -1137,7 +1172,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, =
struct genl_info *info)
> >  						       ufid_flags);
> >  			BUG_ON(error < 0);
> >  		}
> > -		ovs_unlock();
> > +		mutex_unlock(&table->lock);
> > +		ovs_flow_tbl_put(table);
> >
> >  		ovs_nla_free_flow_actions_rcu(old_acts);
> >  		ovs_flow_free(new_flow, false);
> > @@ -1149,8 +1185,10 @@ static int ovs_flow_cmd_new(struct sk_buff *skb,=
 struct genl_info *info)
> >  	kfree(key);
> >  	return 0;
> >
> > -err_unlock_ovs:
> > -	ovs_unlock();
> > +err_unlock_tbl:
> > +	mutex_unlock(&table->lock);
> > +	ovs_flow_tbl_put(table);
> > +err_kfree_reply:
> >  	kfree_skb(reply);
> >  err_kfree_acts:
> >  	ovs_nla_free_flow_actions(acts);
> > @@ -1244,6 +1282,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, =
struct genl_info *info)
> >  	struct net *net =3D sock_net(skb->sk);
> >  	struct nlattr **a =3D info->attrs;
> >  	struct ovs_header *ovs_header =3D genl_info_userhdr(info);
> > +	struct flow_table *table;
> >  	struct sw_flow_key key;
> >  	struct sw_flow *flow;
> >  	struct sk_buff *reply =3D NULL;
> > @@ -1278,29 +1317,43 @@ static int ovs_flow_cmd_set(struct sk_buff *skb=
, struct genl_info *info)
> >  		}
> >  	}
> >
> > -	ovs_lock();
> > +	rcu_read_lock();
> >  	dp =3D get_dp(net, ovs_header->dp_ifindex);
> >  	if (unlikely(!dp)) {
> >  		error =3D -ENODEV;
> > -		goto err_unlock_ovs;
> > +		rcu_read_unlock();
> > +		goto err_free_reply;
> >  	}
> > +	table =3D rcu_dereference(dp->table);
> > +	if (!table || !ovs_flow_tbl_get(table)) {
> > +		rcu_read_unlock();
> > +		error =3D -ENODEV;
> > +		goto err_free_reply;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	/* It is safe to dereference "table" after leaving rcu read-protected
> > +	 * region because it's pinned by refcount.
> > +	 */
> > +	mutex_lock(&table->lock);
> > +
> >  	/* Check that the flow exists. */
> >  	if (ufid_present)
> > -		flow =3D ovs_flow_tbl_lookup_ufid(&dp->table, &sfid);
> > +		flow =3D ovs_flow_tbl_lookup_ufid(table, &sfid);
> >  	else
> > -		flow =3D ovs_flow_tbl_lookup_exact(&dp->table, &match);
> > +		flow =3D ovs_flow_tbl_lookup_exact(table, &match);
> >  	if (unlikely(!flow)) {
> >  		error =3D -ENOENT;
> > -		goto err_unlock_ovs;
> > +		goto err_unlock_tbl;
> >  	}
> >
> >  	/* Update actions, if present. */
> >  	if (likely(acts)) {
> > -		old_acts =3D ovsl_dereference(flow->sf_acts);
> > +		old_acts =3D ovs_tbl_dereference(flow->sf_acts, table);
> >  		rcu_assign_pointer(flow->sf_acts, acts);
> >
> >  		if (unlikely(reply)) {
> > -			error =3D ovs_flow_cmd_fill_info(flow,
> > +			error =3D ovs_flow_cmd_fill_info(flow, table,
> >  						       ovs_header->dp_ifindex,
> >  						       reply, info->snd_portid,
> >  						       info->snd_seq, 0,
> > @@ -1310,20 +1363,22 @@ static int ovs_flow_cmd_set(struct sk_buff *skb=
, struct genl_info *info)
> >  		}
> >  	} else {
> >  		/* Could not alloc without acts before locking. */
> > -		reply =3D ovs_flow_cmd_build_info(flow, ovs_header->dp_ifindex,
> > +		reply =3D ovs_flow_cmd_build_info(flow, table,
> > +						ovs_header->dp_ifindex,
> >  						info, OVS_FLOW_CMD_SET, false,
> >  						ufid_flags);
> >
> >  		if (IS_ERR(reply)) {
> >  			error =3D PTR_ERR(reply);
> > -			goto err_unlock_ovs;
> > +			goto err_unlock_tbl;
> >  		}
> >  	}
> >
> >  	/* Clear stats. */
> >  	if (a[OVS_FLOW_ATTR_CLEAR])
> > -		ovs_flow_stats_clear(flow);
> > -	ovs_unlock();
> > +		ovs_flow_stats_clear(flow, table);
> > +	mutex_unlock(&table->lock);
> > +	ovs_flow_tbl_put(table);
> >
> >  	if (reply)
> >  		ovs_notify(&dp_flow_genl_family, reply, info);
> > @@ -1332,8 +1387,10 @@ static int ovs_flow_cmd_set(struct sk_buff *skb,=
 struct genl_info *info)
> >
> >  	return 0;
> >
> > -err_unlock_ovs:
> > -	ovs_unlock();
> > +err_unlock_tbl:
> > +	mutex_unlock(&table->lock);
> > +	ovs_flow_tbl_put(table);
> > +err_free_reply:
> >  	kfree_skb(reply);
> >  err_kfree_acts:
> >  	ovs_nla_free_flow_actions(acts);
> > @@ -1346,6 +1403,7 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, =
struct genl_info *info)
> >  	struct nlattr **a =3D info->attrs;
> >  	struct ovs_header *ovs_header =3D genl_info_userhdr(info);
> >  	struct net *net =3D sock_net(skb->sk);
> > +	struct flow_table *table;
> >  	struct sw_flow_key key;
> >  	struct sk_buff *reply;
> >  	struct sw_flow *flow;
> > @@ -1370,33 +1428,48 @@ static int ovs_flow_cmd_get(struct sk_buff *skb=
, struct genl_info *info)
> >  	if (err)
> >  		return err;
> >
> > -	ovs_lock();
> > +	rcu_read_lock();
> >  	dp =3D get_dp(sock_net(skb->sk), ovs_header->dp_ifindex);
> >  	if (!dp) {
> > -		err =3D -ENODEV;
> > -		goto unlock;
> > +		rcu_read_unlock();
> > +		return -ENODEV;
> >  	}
> > +	table =3D rcu_dereference(dp->table);
> > +	if (!table || !ovs_flow_tbl_get(table)) {
> > +		rcu_read_unlock();
> > +		return -ENODEV;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	/* It is safe to dereference "table" after leaving rcu read-protected
> > +	 * region because it's pinned by refcount.
> > +	 */
> > +	mutex_lock(&table->lock);
> > +
> >
> >  	if (ufid_present)
> > -		flow =3D ovs_flow_tbl_lookup_ufid(&dp->table, &ufid);
> > +		flow =3D ovs_flow_tbl_lookup_ufid(table, &ufid);
> >  	else
> > -		flow =3D ovs_flow_tbl_lookup_exact(&dp->table, &match);
> > +		flow =3D ovs_flow_tbl_lookup_exact(table, &match);
> >  	if (!flow) {
> >  		err =3D -ENOENT;
> >  		goto unlock;
> >  	}
> >
> > -	reply =3D ovs_flow_cmd_build_info(flow, ovs_header->dp_ifindex, info,
> > -					OVS_FLOW_CMD_GET, true, ufid_flags);
> > +	reply =3D ovs_flow_cmd_build_info(flow, table, ovs_header->dp_ifindex=
,
> > +					info, OVS_FLOW_CMD_GET, true,
> > +					ufid_flags);
> >  	if (IS_ERR(reply)) {
> >  		err =3D PTR_ERR(reply);
> >  		goto unlock;
> >  	}
> >
> > -	ovs_unlock();
> > +	mutex_unlock(&table->lock);
> > +	ovs_flow_tbl_put(table);
> >  	return genlmsg_reply(reply, info);
> >  unlock:
> > -	ovs_unlock();
> > +	mutex_unlock(&table->lock);
> > +	ovs_flow_tbl_put(table);
> >  	return err;
> >  }
> >
> > @@ -1405,6 +1478,7 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, =
struct genl_info *info)
> >  	struct nlattr **a =3D info->attrs;
> >  	struct ovs_header *ovs_header =3D genl_info_userhdr(info);
> >  	struct net *net =3D sock_net(skb->sk);
> > +	struct flow_table *table;
> >  	struct sw_flow_key key;
> >  	struct sk_buff *reply;
> >  	struct sw_flow *flow =3D NULL;
> > @@ -1425,36 +1499,49 @@ static int ovs_flow_cmd_del(struct sk_buff *skb=
, struct genl_info *info)
> >  			return err;
> >  	}
> >
> > -	ovs_lock();
> > +	rcu_read_lock();
> >  	dp =3D get_dp(sock_net(skb->sk), ovs_header->dp_ifindex);
> >  	if (unlikely(!dp)) {
> > -		err =3D -ENODEV;
> > -		goto unlock;
> > +		rcu_read_unlock();
> > +		return -ENODEV;
> >  	}
> > +	table =3D rcu_dereference(dp->table);
> > +	if (!table || !ovs_flow_tbl_get(table)) {
> > +		rcu_read_unlock();
> > +		return -ENODEV;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	/* It is safe to dereference "table" after leaving rcu read-protected
> > +	 * region because it's pinned by refcount.
> > +	 */
> > +	mutex_lock(&table->lock);
> > +
> >
> >  	if (unlikely(!a[OVS_FLOW_ATTR_KEY] && !ufid_present)) {
> > -		err =3D ovs_flow_tbl_flush(&dp->table);
> > +		err =3D ovs_flow_tbl_flush(table);
> >  		goto unlock;
> >  	}
> >
> >  	if (ufid_present)
> > -		flow =3D ovs_flow_tbl_lookup_ufid(&dp->table, &ufid);
> > +		flow =3D ovs_flow_tbl_lookup_ufid(table, &ufid);
> >  	else
> > -		flow =3D ovs_flow_tbl_lookup_exact(&dp->table, &match);
> > +		flow =3D ovs_flow_tbl_lookup_exact(table, &match);
> >  	if (unlikely(!flow)) {
> >  		err =3D -ENOENT;
> >  		goto unlock;
> >  	}
> >
> > -	ovs_flow_tbl_remove(&dp->table, flow);
> > -	ovs_unlock();
> > +	ovs_flow_tbl_remove(table, flow);
> > +	mutex_unlock(&table->lock);
> >
> >  	reply =3D ovs_flow_cmd_alloc_info((const struct sw_flow_actions __for=
ce *) flow->sf_acts,
> >  					&flow->id, info, false, ufid_flags);
> >  	if (likely(reply)) {
> >  		if (!IS_ERR(reply)) {
> >  			rcu_read_lock();	/*To keep RCU checker happy. */
> > -			err =3D ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex,
> > +			err =3D ovs_flow_cmd_fill_info(flow, table,
> > +						     ovs_header->dp_ifindex,
> >  						     reply, info->snd_portid,
> >  						     info->snd_seq, 0,
> >  						     OVS_FLOW_CMD_DEL,
> > @@ -1473,10 +1560,12 @@ static int ovs_flow_cmd_del(struct sk_buff *skb=
, struct genl_info *info)
> >  	}
> >
> >  out_free:
> > +	ovs_flow_tbl_put(table);
> >  	ovs_flow_free(flow, true);
> >  	return 0;
> >  unlock:
> > -	ovs_unlock();
> > +	mutex_unlock(&table->lock);
> > +	ovs_flow_tbl_put(table);
> >  	return err;
> >  }
> >
> > @@ -1485,6 +1574,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb,=
 struct netlink_callback *cb)
> >  	struct nlattr *a[__OVS_FLOW_ATTR_MAX];
> >  	struct ovs_header *ovs_header =3D genlmsg_data(nlmsg_data(cb->nlh));
> >  	struct table_instance *ti;
> > +	struct flow_table *table;
> >  	struct datapath *dp;
> >  	u32 ufid_flags;
> >  	int err;
> > @@ -1501,8 +1591,13 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb=
, struct netlink_callback *cb)
> >  		rcu_read_unlock();
> >  		return -ENODEV;
> >  	}
> > +	table =3D rcu_dereference(dp->table);
> > +	if (!table) {
> > +		rcu_read_unlock();
> > +		return -ENODEV;
> > +	}
> >
> > -	ti =3D rcu_dereference(dp->table.ti);
> > +	ti =3D rcu_dereference(table->ti);
> >  	for (;;) {
> >  		struct sw_flow *flow;
> >  		u32 bucket, obj;
> > @@ -1513,8 +1608,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb,=
 struct netlink_callback *cb)
> >  		if (!flow)
> >  			break;
> >
> > -		if (ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex, skb,
> > -					   NETLINK_CB(cb->skb).portid,
> > +		if (ovs_flow_cmd_fill_info(flow, table, ovs_header->dp_ifindex,
> > +					   skb, NETLINK_CB(cb->skb).portid,
> >  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
> >  					   OVS_FLOW_CMD_GET, ufid_flags) < 0)
> >  			break;
> > @@ -1598,8 +1693,13 @@ static int ovs_dp_cmd_fill_info(struct datapath =
*dp, struct sk_buff *skb,
> >  	struct ovs_dp_stats dp_stats;
> >  	struct ovs_dp_megaflow_stats dp_megaflow_stats;
> >  	struct dp_nlsk_pids *pids =3D ovsl_dereference(dp->upcall_portids);
> > +	struct flow_table *table;
> >  	int err, pids_len;
> >
> > +	table =3D ovsl_dereference(dp->table);
> > +	if (!table)
> > +		return -ENODEV;
> > +
> >  	ovs_header =3D genlmsg_put(skb, portid, seq, &dp_datapath_genl_family=
,
> >  				 flags, cmd);
> >  	if (!ovs_header)
> > @@ -1625,7 +1725,7 @@ static int ovs_dp_cmd_fill_info(struct datapath *=
dp, struct sk_buff *skb,
> >  		goto nla_put_failure;
> >
> >  	if (nla_put_u32(skb, OVS_DP_ATTR_MASKS_CACHE_SIZE,
> > -			ovs_flow_tbl_masks_cache_size(&dp->table)))
> > +			ovs_flow_tbl_masks_cache_size(table)))
> >  		goto nla_put_failure;
> >
> >  	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU && pids) {
> > @@ -1736,6 +1836,7 @@ u32 ovs_dp_get_upcall_portid(const struct datapat=
h *dp, uint32_t cpu_id)
> >  static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
> >  {
> >  	u32 user_features =3D 0, old_features =3D dp->user_features;
> > +	struct flow_table *table;
> >  	int err;
> >
> >  	if (a[OVS_DP_ATTR_USER_FEATURES]) {
> > @@ -1757,8 +1858,12 @@ static int ovs_dp_change(struct datapath *dp, st=
ruct nlattr *a[])
> >  		int err;
> >  		u32 cache_size;
> >
> > +		table =3D ovsl_dereference(dp->table);
> > +		if (!table)
> > +			return -ENODEV;
> > +
> >  		cache_size =3D nla_get_u32(a[OVS_DP_ATTR_MASKS_CACHE_SIZE]);
> > -		err =3D ovs_flow_tbl_masks_cache_resize(&dp->table, cache_size);
> > +		err =3D ovs_flow_tbl_masks_cache_resize(table, cache_size);
> >  		if (err)
> >  			return err;
> >  	}
> > @@ -1810,6 +1915,7 @@ static int ovs_dp_vport_init(struct datapath *dp)
> >  static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
> >  {
> >  	struct nlattr **a =3D info->attrs;
> > +	struct flow_table *table;
> >  	struct vport_parms parms;
> >  	struct sk_buff *reply;
> >  	struct datapath *dp;
> > @@ -1833,9 +1939,12 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, s=
truct genl_info *info)
> >  	ovs_dp_set_net(dp, sock_net(skb->sk));
> >
> >  	/* Allocate table. */
> > -	err =3D ovs_flow_tbl_init(&dp->table);
> > -	if (err)
> > +	table =3D ovs_flow_tbl_alloc();
> > +	if (IS_ERR(table)) {
> > +		err =3D PTR_ERR(table);
> >  		goto err_destroy_dp;
> > +	}
> > +	rcu_assign_pointer(dp->table, table);
> >
> >  	err =3D ovs_dp_stats_init(dp);
> >  	if (err)
> > @@ -1905,7 +2014,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, st=
ruct genl_info *info)
> >  err_destroy_stats:
> >  	free_percpu(dp->stats_percpu);
> >  err_destroy_table:
> > -	ovs_flow_tbl_destroy(&dp->table);
> > +	ovs_flow_tbl_put(table);
> >  err_destroy_dp:
> >  	kfree(dp);
> >  err_destroy_reply:
> > @@ -1917,7 +2026,8 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, st=
ruct genl_info *info)
> >  /* Called with ovs_mutex. */
> >  static void __dp_destroy(struct datapath *dp)
> >  {
> > -	struct flow_table *table =3D &dp->table;
> > +	struct flow_table *table =3D rcu_dereference_protected(dp->table,
> > +					lockdep_ovsl_is_held());
> >  	int i;
> >
> >  	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
> > @@ -1939,14 +2049,10 @@ static void __dp_destroy(struct datapath *dp)
> >  	 */
> >  	ovs_dp_detach_port(ovs_vport_ovsl(dp, OVSP_LOCAL));
> >
> > -	/* Flush sw_flow in the tables. RCU cb only releases resource
> > -	 * such as dp, ports and tables. That may avoid some issues
> > -	 * such as RCU usage warning.
> > -	 */
> > -	table_instance_flow_flush(table, ovsl_dereference(table->ti),
> > -				  ovsl_dereference(table->ufid_ti));
> > +	rcu_assign_pointer(dp->table, NULL);
> > +	ovs_flow_tbl_put(table);
> >
> > -	/* RCU destroy the ports, meters and flow tables. */
> > +	/* RCU destroy the ports and meters. */
> >  	call_rcu(&dp->rcu, destroy_dp_rcu);
> >  }
> >
> > @@ -2554,13 +2660,18 @@ static void ovs_dp_masks_rebalance(struct work_=
struct *work)
> >  {
> >  	struct ovs_net *ovs_net =3D container_of(work, struct ovs_net,
> >  					       masks_rebalance.work);
> > +	struct flow_table *table;
> >  	struct datapath *dp;
> >
> >  	ovs_lock();
> > -
> > -	list_for_each_entry(dp, &ovs_net->dps, list_node)
> > -		ovs_flow_masks_rebalance(&dp->table);
> > -
> > +	list_for_each_entry(dp, &ovs_net->dps, list_node) {
> > +		table =3D ovsl_dereference(dp->table);
> > +		if (!table)
> > +			continue;
>
> Should we take a reference for table here?  I guess it's kindof safe
> because of the ovs_lock() above, but if that gets removed it's possible
> someone misses that there isn't a refcnt pin here (but everywhere else
> has a ovs_flow_tbl_get before it).
>

Good point. As you say, it is safe but still we should probably do it.
I'll change this.

Just for reference:
I actually contemplated the possibility of removing the lock here, or at
least removing its scope. We still need it to serialize access to
"&ovs_net->dps" but we could then increase a reference to the table and
release the lock. The code would then look bad because we'd be releasing
the lock in the middle of the loop. After some thought, all this
complexity didn't feel necessary for something that happens every 4s and
that is not affected by RTNL contention.

Thanks.
Adri=C3=A1n

> > +		mutex_lock(&table->lock);
> > +		ovs_flow_masks_rebalance(table);
> > +		mutex_unlock(&table->lock);
> > +	}
> >  	ovs_unlock();
> >
> >  	schedule_delayed_work(&ovs_net->masks_rebalance,
> > diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> > index db0c3e69d66c..44773bf9f645 100644
> > --- a/net/openvswitch/datapath.h
> > +++ b/net/openvswitch/datapath.h
> > @@ -90,7 +90,7 @@ struct datapath {
> >  	struct list_head list_node;
> >
> >  	/* Flow table. */
> > -	struct flow_table table;
> > +	struct flow_table __rcu *table;
> >
> >  	/* Switch ports. */
> >  	struct hlist_head *ports;
> > diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> > index 66366982f604..0a748cf20f53 100644
> > --- a/net/openvswitch/flow.c
> > +++ b/net/openvswitch/flow.c
> > @@ -124,8 +124,9 @@ void ovs_flow_stats_update(struct sw_flow *flow, __=
be16 tcp_flags,
> >  	spin_unlock(&stats->lock);
> >  }
> >
> > -/* Must be called with rcu_read_lock or ovs_mutex. */
> > +/* Must be called with rcu_read_lock or table->lock held. */
> >  void ovs_flow_stats_get(const struct sw_flow *flow,
> > +			const struct flow_table *table,
> >  			struct ovs_flow_stats *ovs_stats,
> >  			unsigned long *used, __be16 *tcp_flags)
> >  {
> > @@ -136,7 +137,8 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
> >  	memset(ovs_stats, 0, sizeof(*ovs_stats));
> >
> >  	for_each_cpu(cpu, flow->cpu_used_mask) {
> > -		struct sw_flow_stats *stats =3D rcu_dereference_ovsl(flow->stats[cpu=
]);
> > +		struct sw_flow_stats *stats =3D
> > +			rcu_dereference_ovs_tbl(flow->stats[cpu], table);
> >
> >  		if (stats) {
> >  			/* Local CPU may write on non-local stats, so we must
> > @@ -153,13 +155,14 @@ void ovs_flow_stats_get(const struct sw_flow *flo=
w,
> >  	}
> >  }
> >
> > -/* Called with ovs_mutex. */
> > -void ovs_flow_stats_clear(struct sw_flow *flow)
> > +/* Called with table->lock held. */
> > +void ovs_flow_stats_clear(struct sw_flow *flow, struct flow_table *tab=
le)
> >  {
> >  	unsigned int cpu;
> >
> >  	for_each_cpu(cpu, flow->cpu_used_mask) {
> > -		struct sw_flow_stats *stats =3D ovsl_dereference(flow->stats[cpu]);
> > +		struct sw_flow_stats *stats =3D
> > +			ovs_tbl_dereference(flow->stats[cpu], table);
> >
> >  		if (stats) {
> >  			spin_lock_bh(&stats->lock);
> > diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
> > index b5711aff6e76..e05ed6796e4e 100644
> > --- a/net/openvswitch/flow.h
> > +++ b/net/openvswitch/flow.h
> > @@ -23,6 +23,7 @@
> >  #include <net/dst_metadata.h>
> >  #include <net/nsh.h>
> >
> > +struct flow_table;
> >  struct sk_buff;
> >
> >  enum sw_flow_mac_proto {
> > @@ -280,9 +281,11 @@ static inline bool ovs_identifier_is_key(const str=
uct sw_flow_id *sfid)
> >
> >  void ovs_flow_stats_update(struct sw_flow *, __be16 tcp_flags,
> >  			   const struct sk_buff *);
> > -void ovs_flow_stats_get(const struct sw_flow *, struct ovs_flow_stats =
*,
> > -			unsigned long *used, __be16 *tcp_flags);
> > -void ovs_flow_stats_clear(struct sw_flow *);
> > +void ovs_flow_stats_get(const struct sw_flow *flow,
> > +			const struct flow_table *table,
> > +			struct ovs_flow_stats *stats, unsigned long *used,
> > +			__be16 *tcp_flags);
> > +void ovs_flow_stats_clear(struct sw_flow *flow, struct flow_table *tab=
le);
> >  u64 ovs_flow_used_time(unsigned long flow_jiffies);
> >
> >  int ovs_flow_key_update(struct sk_buff *skb, struct sw_flow_key *key);
> > diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.=
c
> > index 61c6a5f77c2e..d9dbe4b4807c 100644
> > --- a/net/openvswitch/flow_table.c
> > +++ b/net/openvswitch/flow_table.c
> > @@ -45,6 +45,16 @@
> >  static struct kmem_cache *flow_cache;
> >  struct kmem_cache *flow_stats_cache __read_mostly;
> >
> > +#ifdef CONFIG_LOCKDEP
> > +int lockdep_ovs_tbl_is_held(const struct flow_table *table)
> > +{
> > +	if (debug_locks)
> > +		return lockdep_is_held(&table->lock);
> > +	else
> > +		return 1;
> > +}
> > +#endif
> > +
> >  static u16 range_n_bytes(const struct sw_flow_key_range *range)
> >  {
> >  	return range->end - range->start;
> > @@ -249,12 +259,12 @@ static int tbl_mask_array_realloc(struct flow_tab=
le *tbl, int size)
> >  	if (!new)
> >  		return -ENOMEM;
> >
> > -	old =3D ovsl_dereference(tbl->mask_array);
> > +	old =3D ovs_tbl_dereference(tbl->mask_array, tbl);
> >  	if (old) {
> >  		int i;
> >
> >  		for (i =3D 0; i < old->max; i++) {
> > -			if (ovsl_dereference(old->masks[i]))
> > +			if (ovs_tbl_dereference(old->masks[i], tbl))
> >  				new->masks[new->count++] =3D old->masks[i];
> >  		}
> >  		call_rcu(&old->rcu, mask_array_rcu_cb);
> > @@ -268,7 +278,7 @@ static int tbl_mask_array_realloc(struct flow_table=
 *tbl, int size)
> >  static int tbl_mask_array_add_mask(struct flow_table *tbl,
> >  				   struct sw_flow_mask *new)
> >  {
> > -	struct mask_array *ma =3D ovsl_dereference(tbl->mask_array);
> > +	struct mask_array *ma =3D ovs_tbl_dereference(tbl->mask_array, tbl);
> >  	int err, ma_count =3D READ_ONCE(ma->count);
> >
> >  	if (ma_count >=3D ma->max) {
> > @@ -277,7 +287,7 @@ static int tbl_mask_array_add_mask(struct flow_tabl=
e *tbl,
> >  		if (err)
> >  			return err;
> >
> > -		ma =3D ovsl_dereference(tbl->mask_array);
> > +		ma =3D ovs_tbl_dereference(tbl->mask_array, tbl);
> >  	} else {
> >  		/* On every add or delete we need to reset the counters so
> >  		 * every new mask gets a fair chance of being prioritized.
> > @@ -285,7 +295,7 @@ static int tbl_mask_array_add_mask(struct flow_tabl=
e *tbl,
> >  		tbl_mask_array_reset_counters(ma);
> >  	}
> >
> > -	BUG_ON(ovsl_dereference(ma->masks[ma_count]));
> > +	WARN_ON_ONCE(ovs_tbl_dereference(ma->masks[ma_count], tbl));
> >
> >  	rcu_assign_pointer(ma->masks[ma_count], new);
> >  	WRITE_ONCE(ma->count, ma_count + 1);
> > @@ -296,12 +306,12 @@ static int tbl_mask_array_add_mask(struct flow_ta=
ble *tbl,
> >  static void tbl_mask_array_del_mask(struct flow_table *tbl,
> >  				    struct sw_flow_mask *mask)
> >  {
> > -	struct mask_array *ma =3D ovsl_dereference(tbl->mask_array);
> > +	struct mask_array *ma =3D ovs_tbl_dereference(tbl->mask_array, tbl);
> >  	int i, ma_count =3D READ_ONCE(ma->count);
> >
> >  	/* Remove the deleted mask pointers from the array */
> >  	for (i =3D 0; i < ma_count; i++) {
> > -		if (mask =3D=3D ovsl_dereference(ma->masks[i]))
> > +		if (mask =3D=3D ovs_tbl_dereference(ma->masks[i], tbl))
> >  			goto found;
> >  	}
> >
> > @@ -329,10 +339,10 @@ static void tbl_mask_array_del_mask(struct flow_t=
able *tbl,
> >  static void flow_mask_remove(struct flow_table *tbl, struct sw_flow_ma=
sk *mask)
> >  {
> >  	if (mask) {
> > -		/* ovs-lock is required to protect mask-refcount and
> > +		/* table lock is required to protect mask-refcount and
> >  		 * mask list.
> >  		 */
> > -		ASSERT_OVSL();
> > +		ASSERT_OVS_TBL(tbl);
> >  		BUG_ON(!mask->ref_count);
> >  		mask->ref_count--;
> >
> > @@ -386,7 +396,8 @@ static struct mask_cache *tbl_mask_cache_alloc(u32 =
size)
> >  }
> >  int ovs_flow_tbl_masks_cache_resize(struct flow_table *table, u32 size=
)
> >  {
> > -	struct mask_cache *mc =3D rcu_dereference_ovsl(table->mask_cache);
> > +	struct mask_cache *mc =3D rcu_dereference_ovs_tbl(table->mask_cache,
> > +							table);
> >  	struct mask_cache *new;
> >
> >  	if (size =3D=3D mc->cache_size)
> > @@ -406,15 +417,23 @@ int ovs_flow_tbl_masks_cache_resize(struct flow_t=
able *table, u32 size)
> >  	return 0;
> >  }
> >
> > -int ovs_flow_tbl_init(struct flow_table *table)
> > +struct flow_table *ovs_flow_tbl_alloc(void)
> >  {
> >  	struct table_instance *ti, *ufid_ti;
> > +	struct flow_table *table;
> >  	struct mask_cache *mc;
> >  	struct mask_array *ma;
> >
> > +	table =3D kzalloc_obj(*table, GFP_KERNEL);
> > +	if (!table)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	mutex_init(&table->lock);
> > +	refcount_set(&table->refcnt, 1);
> > +
> >  	mc =3D tbl_mask_cache_alloc(MC_DEFAULT_HASH_ENTRIES);
> >  	if (!mc)
> > -		return -ENOMEM;
> > +		goto free_table;
> >
> >  	ma =3D tbl_mask_array_alloc(MASK_ARRAY_SIZE_MIN);
> >  	if (!ma)
> > @@ -435,7 +454,7 @@ int ovs_flow_tbl_init(struct flow_table *table)
> >  	table->last_rehash =3D jiffies;
> >  	table->count =3D 0;
> >  	table->ufid_count =3D 0;
> > -	return 0;
> > +	return table;
> >
> >  free_ti:
> >  	__table_instance_destroy(ti);
> > @@ -443,7 +462,10 @@ int ovs_flow_tbl_init(struct flow_table *table)
> >  	__mask_array_destroy(ma);
> >  free_mask_cache:
> >  	__mask_cache_destroy(mc);
> > -	return -ENOMEM;
> > +free_table:
> > +	mutex_destroy(&table->lock);
> > +	kfree(table);
> > +	return ERR_PTR(-ENOMEM);
> >  }
> >
> >  static void flow_tbl_destroy_rcu_cb(struct rcu_head *rcu)
> > @@ -470,7 +492,7 @@ static void table_instance_flow_free(struct flow_ta=
ble *table,
> >  	flow_mask_remove(table, flow->mask);
> >  }
> >
> > -/* Must be called with OVS mutex held. */
> > +/* Must be called with table mutex held. */
> >  void table_instance_flow_flush(struct flow_table *table,
> >  			       struct table_instance *ti,
> >  			       struct table_instance *ufid_ti)
> > @@ -505,11 +527,11 @@ static void table_instance_destroy(struct table_i=
nstance *ti,
> >  	call_rcu(&ufid_ti->rcu, flow_tbl_destroy_rcu_cb);
> >  }
> >
> > -/* No need for locking this function is called from RCU callback or
> > - * error path.
> > - */
> > -void ovs_flow_tbl_destroy(struct flow_table *table)
> > +/* No need for locking this function is called from RCU callback. */
> > +static void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
> >  {
> > +	struct flow_table *table =3D container_of(rcu, struct flow_table, rcu=
);
> > +
> >  	struct table_instance *ti =3D rcu_dereference_raw(table->ti);
> >  	struct table_instance *ufid_ti =3D rcu_dereference_raw(table->ufid_ti=
);
> >  	struct mask_cache *mc =3D rcu_dereference_raw(table->mask_cache);
> > @@ -518,6 +540,20 @@ void ovs_flow_tbl_destroy(struct flow_table *table=
)
> >  	call_rcu(&mc->rcu, mask_cache_rcu_cb);
> >  	call_rcu(&ma->rcu, mask_array_rcu_cb);
> >  	table_instance_destroy(ti, ufid_ti);
> > +	mutex_destroy(&table->lock);
> > +	kfree(table);
> > +}
> > +
> > +void ovs_flow_tbl_put(struct flow_table *table)
> > +{
> > +	if (refcount_dec_and_test(&table->refcnt)) {
> > +		mutex_lock(&table->lock);
> > +		table_instance_flow_flush(table,
> > +					  ovs_tbl_dereference(table->ti, table),
> > +					  ovs_tbl_dereference(table->ufid_ti, table));
> > +		mutex_unlock(&table->lock);
> > +		call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
> > +	}
> >  }
> >
> >  struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
> > @@ -571,7 +607,8 @@ static void ufid_table_instance_insert(struct table=
_instance *ti,
> >  	hlist_add_head_rcu(&flow->ufid_table.node[ti->node_ver], head);
> >  }
> >
> > -static void flow_table_copy_flows(struct table_instance *old,
> > +static void flow_table_copy_flows(struct flow_table *table,
> > +				  struct table_instance *old,
> >  				  struct table_instance *new, bool ufid)
> >  {
> >  	int old_ver;
> > @@ -588,17 +625,18 @@ static void flow_table_copy_flows(struct table_in=
stance *old,
> >  		if (ufid)
> >  			hlist_for_each_entry_rcu(flow, head,
> >  						 ufid_table.node[old_ver],
> > -						 lockdep_ovsl_is_held())
> > +						 lockdep_ovs_tbl_is_held(table))
> >  				ufid_table_instance_insert(new, flow);
> >  		else
> >  			hlist_for_each_entry_rcu(flow, head,
> >  						 flow_table.node[old_ver],
> > -						 lockdep_ovsl_is_held())
> > +						 lockdep_ovs_tbl_is_held(table))
> >  				table_instance_insert(new, flow);
> >  	}
> >  }
> >
> > -static struct table_instance *table_instance_rehash(struct table_insta=
nce *ti,
> > +static struct table_instance *table_instance_rehash(struct flow_table =
*table,
> > +						    struct table_instance *ti,
> >  						    int n_buckets, bool ufid)
> >  {
> >  	struct table_instance *new_ti;
> > @@ -607,16 +645,19 @@ static struct table_instance *table_instance_reha=
sh(struct table_instance *ti,
> >  	if (!new_ti)
> >  		return NULL;
> >
> > -	flow_table_copy_flows(ti, new_ti, ufid);
> > +	flow_table_copy_flows(table, ti, new_ti, ufid);
> >
> >  	return new_ti;
> >  }
> >
> > +/* Must be called with flow_table->lock held. */
> >  int ovs_flow_tbl_flush(struct flow_table *flow_table)
> >  {
> >  	struct table_instance *old_ti, *new_ti;
> >  	struct table_instance *old_ufid_ti, *new_ufid_ti;
> >
> > +	ASSERT_OVS_TBL(flow_table);
> > +
> >  	new_ti =3D table_instance_alloc(TBL_MIN_BUCKETS);
> >  	if (!new_ti)
> >  		return -ENOMEM;
> > @@ -624,8 +665,8 @@ int ovs_flow_tbl_flush(struct flow_table *flow_tabl=
e)
> >  	if (!new_ufid_ti)
> >  		goto err_free_ti;
> >
> > -	old_ti =3D ovsl_dereference(flow_table->ti);
> > -	old_ufid_ti =3D ovsl_dereference(flow_table->ufid_ti);
> > +	old_ti =3D ovs_tbl_dereference(flow_table->ti, flow_table);
> > +	old_ufid_ti =3D ovs_tbl_dereference(flow_table->ufid_ti, flow_table);
> >
> >  	rcu_assign_pointer(flow_table->ti, new_ti);
> >  	rcu_assign_pointer(flow_table->ufid_ti, new_ufid_ti);
> > @@ -693,7 +734,8 @@ static bool ovs_flow_cmp_unmasked_key(const struct =
sw_flow *flow,
> >  	return cmp_key(flow->id.unmasked_key, key, key_start, key_end);
> >  }
> >
> > -static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
> > +static struct sw_flow *masked_flow_lookup(struct flow_table *tbl,
> > +					  struct table_instance *ti,
> >  					  const struct sw_flow_key *unmasked,
> >  					  const struct sw_flow_mask *mask,
> >  					  u32 *n_mask_hit)
> > @@ -709,7 +751,7 @@ static struct sw_flow *masked_flow_lookup(struct ta=
ble_instance *ti,
> >  	(*n_mask_hit)++;
> >
> >  	hlist_for_each_entry_rcu(flow, head, flow_table.node[ti->node_ver],
> > -				 lockdep_ovsl_is_held()) {
> > +				 lockdep_ovs_tbl_is_held(tbl)) {
> >  		if (flow->mask =3D=3D mask && flow->flow_table.hash =3D=3D hash &&
> >  		    flow_cmp_masked_key(flow, &masked_key, &mask->range))
> >  			return flow;
> > @@ -736,9 +778,9 @@ static struct sw_flow *flow_lookup(struct flow_tabl=
e *tbl,
> >  	int i;
> >
> >  	if (likely(*index < ma->max)) {
> > -		mask =3D rcu_dereference_ovsl(ma->masks[*index]);
> > +		mask =3D rcu_dereference_ovs_tbl(ma->masks[*index], tbl);
> >  		if (mask) {
> > -			flow =3D masked_flow_lookup(ti, key, mask, n_mask_hit);
> > +			flow =3D masked_flow_lookup(tbl, ti, key, mask, n_mask_hit);
> >  			if (flow) {
> >  				u64_stats_update_begin(&stats->syncp);
> >  				stats->usage_cntrs[*index]++;
> > @@ -754,11 +796,11 @@ static struct sw_flow *flow_lookup(struct flow_ta=
ble *tbl,
> >  		if (i =3D=3D *index)
> >  			continue;
> >
> > -		mask =3D rcu_dereference_ovsl(ma->masks[i]);
> > +		mask =3D rcu_dereference_ovs_tbl(ma->masks[i], tbl);
> >  		if (unlikely(!mask))
> >  			break;
> >
> > -		flow =3D masked_flow_lookup(ti, key, mask, n_mask_hit);
> > +		flow =3D masked_flow_lookup(tbl, ti, key, mask, n_mask_hit);
> >  		if (flow) { /* Found */
> >  			*index =3D i;
> >  			u64_stats_update_begin(&stats->syncp);
> > @@ -845,8 +887,8 @@ struct sw_flow *ovs_flow_tbl_lookup_stats(struct fl=
ow_table *tbl,
> >  struct sw_flow *ovs_flow_tbl_lookup(struct flow_table *tbl,
> >  				    const struct sw_flow_key *key)
> >  {
> > -	struct table_instance *ti =3D rcu_dereference_ovsl(tbl->ti);
> > -	struct mask_array *ma =3D rcu_dereference_ovsl(tbl->mask_array);
> > +	struct table_instance *ti =3D rcu_dereference_ovs_tbl(tbl->ti, tbl);
> > +	struct mask_array *ma =3D rcu_dereference_ovs_tbl(tbl->mask_array, tb=
l);
> >  	u32 __always_unused n_mask_hit;
> >  	u32 __always_unused n_cache_hit;
> >  	struct sw_flow *flow;
> > @@ -865,21 +907,22 @@ struct sw_flow *ovs_flow_tbl_lookup(struct flow_t=
able *tbl,
> >  struct sw_flow *ovs_flow_tbl_lookup_exact(struct flow_table *tbl,
> >  					  const struct sw_flow_match *match)
> >  {
> > -	struct mask_array *ma =3D ovsl_dereference(tbl->mask_array);
> > +	struct mask_array *ma =3D ovs_tbl_dereference(tbl->mask_array, tbl);
> >  	int i;
> >
> > -	/* Always called under ovs-mutex. */
> > +	/* Always called under tbl->lock. */
> >  	for (i =3D 0; i < ma->max; i++) {
> > -		struct table_instance *ti =3D rcu_dereference_ovsl(tbl->ti);
> > +		struct table_instance *ti =3D
> > +				rcu_dereference_ovs_tbl(tbl->ti, tbl);
> >  		u32 __always_unused n_mask_hit;
> >  		struct sw_flow_mask *mask;
> >  		struct sw_flow *flow;
> >
> > -		mask =3D ovsl_dereference(ma->masks[i]);
> > +		mask =3D ovs_tbl_dereference(ma->masks[i], tbl);
> >  		if (!mask)
> >  			continue;
> >
> > -		flow =3D masked_flow_lookup(ti, match->key, mask, &n_mask_hit);
> > +		flow =3D masked_flow_lookup(tbl, ti, match->key, mask, &n_mask_hit);
> >  		if (flow && ovs_identifier_is_key(&flow->id) &&
> >  		    ovs_flow_cmp_unmasked_key(flow, match)) {
> >  			return flow;
> > @@ -915,7 +958,7 @@ bool ovs_flow_cmp(const struct sw_flow *flow,
> >  struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
> >  					 const struct sw_flow_id *ufid)
> >  {
> > -	struct table_instance *ti =3D rcu_dereference_ovsl(tbl->ufid_ti);
> > +	struct table_instance *ti =3D rcu_dereference_ovs_tbl(tbl->ufid_ti, t=
bl);
> >  	struct sw_flow *flow;
> >  	struct hlist_head *head;
> >  	u32 hash;
> > @@ -923,7 +966,7 @@ struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flo=
w_table *tbl,
> >  	hash =3D ufid_hash(ufid);
> >  	head =3D find_bucket(ti, hash);
> >  	hlist_for_each_entry_rcu(flow, head, ufid_table.node[ti->node_ver],
> > -				 lockdep_ovsl_is_held()) {
> > +				 lockdep_ovs_tbl_is_held(tbl)) {
> >  		if (flow->ufid_table.hash =3D=3D hash &&
> >  		    ovs_flow_cmp_ufid(flow, ufid))
> >  			return flow;
> > @@ -933,28 +976,33 @@ struct sw_flow *ovs_flow_tbl_lookup_ufid(struct f=
low_table *tbl,
> >
> >  int ovs_flow_tbl_num_masks(const struct flow_table *table)
> >  {
> > -	struct mask_array *ma =3D rcu_dereference_ovsl(table->mask_array);
> > +	struct mask_array *ma =3D rcu_dereference_ovs_tbl(table->mask_array,
> > +							table);
> >  	return READ_ONCE(ma->count);
> >  }
> >
> >  u32 ovs_flow_tbl_masks_cache_size(const struct flow_table *table)
> >  {
> > -	struct mask_cache *mc =3D rcu_dereference_ovsl(table->mask_cache);
> > +	struct mask_cache *mc =3D rcu_dereference_ovs_tbl(table->mask_cache,
> > +							table);
> >
> >  	return READ_ONCE(mc->cache_size);
> >  }
> >
> > -static struct table_instance *table_instance_expand(struct table_insta=
nce *ti,
> > +static struct table_instance *table_instance_expand(struct flow_table =
*table,
> > +						    struct table_instance *ti,
> >  						    bool ufid)
> >  {
> > -	return table_instance_rehash(ti, ti->n_buckets * 2, ufid);
> > +	return table_instance_rehash(table, ti, ti->n_buckets * 2, ufid);
> >  }
> >
> > -/* Must be called with OVS mutex held. */
> > +/* Must be called with table mutex held. */
> >  void ovs_flow_tbl_remove(struct flow_table *table, struct sw_flow *flo=
w)
> >  {
> > -	struct table_instance *ti =3D ovsl_dereference(table->ti);
> > -	struct table_instance *ufid_ti =3D ovsl_dereference(table->ufid_ti);
> > +	struct table_instance *ti =3D ovs_tbl_dereference(table->ti,
> > +							table);
> > +	struct table_instance *ufid_ti =3D ovs_tbl_dereference(table->ufid_ti=
,
> > +							     table);
> >
> >  	BUG_ON(table->count =3D=3D 0);
> >  	table_instance_flow_free(table, ti, ufid_ti, flow);
> > @@ -988,10 +1036,10 @@ static struct sw_flow_mask *flow_mask_find(const=
 struct flow_table *tbl,
> >  	struct mask_array *ma;
> >  	int i;
> >
> > -	ma =3D ovsl_dereference(tbl->mask_array);
> > +	ma =3D ovs_tbl_dereference(tbl->mask_array, tbl);
> >  	for (i =3D 0; i < ma->max; i++) {
> >  		struct sw_flow_mask *t;
> > -		t =3D ovsl_dereference(ma->masks[i]);
> > +		t =3D ovs_tbl_dereference(ma->masks[i], tbl);
> >
> >  		if (t && mask_equal(mask, t))
> >  			return t;
> > @@ -1029,22 +1077,25 @@ static int flow_mask_insert(struct flow_table *=
tbl, struct sw_flow *flow,
> >  	return 0;
> >  }
> >
> > -/* Must be called with OVS mutex held. */
> > +/* Must be called with table mutex held. */
> >  static void flow_key_insert(struct flow_table *table, struct sw_flow *=
flow)
> >  {
> >  	struct table_instance *new_ti =3D NULL;
> >  	struct table_instance *ti;
> >
> > +	ASSERT_OVS_TBL(table);
> > +
> >  	flow->flow_table.hash =3D flow_hash(&flow->key, &flow->mask->range);
> > -	ti =3D ovsl_dereference(table->ti);
> > +	ti =3D ovs_tbl_dereference(table->ti, table);
> >  	table_instance_insert(ti, flow);
> >  	table->count++;
> >
> >  	/* Expand table, if necessary, to make room. */
> >  	if (table->count > ti->n_buckets)
> > -		new_ti =3D table_instance_expand(ti, false);
> > +		new_ti =3D table_instance_expand(table, ti, false);
> >  	else if (time_after(jiffies, table->last_rehash + REHASH_INTERVAL))
> > -		new_ti =3D table_instance_rehash(ti, ti->n_buckets, false);
> > +		new_ti =3D table_instance_rehash(table, ti, ti->n_buckets,
> > +					       false);
> >
> >  	if (new_ti) {
> >  		rcu_assign_pointer(table->ti, new_ti);
> > @@ -1053,13 +1104,15 @@ static void flow_key_insert(struct flow_table *=
table, struct sw_flow *flow)
> >  	}
> >  }
> >
> > -/* Must be called with OVS mutex held. */
> > +/* Must be called with table mutex held. */
> >  static void flow_ufid_insert(struct flow_table *table, struct sw_flow =
*flow)
> >  {
> >  	struct table_instance *ti;
> >
> > +	ASSERT_OVS_TBL(table);
> > +
> >  	flow->ufid_table.hash =3D ufid_hash(&flow->id);
> > -	ti =3D ovsl_dereference(table->ufid_ti);
> > +	ti =3D ovs_tbl_dereference(table->ufid_ti, table);
> >  	ufid_table_instance_insert(ti, flow);
> >  	table->ufid_count++;
> >
> > @@ -1067,7 +1120,7 @@ static void flow_ufid_insert(struct flow_table *t=
able, struct sw_flow *flow)
> >  	if (table->ufid_count > ti->n_buckets) {
> >  		struct table_instance *new_ti;
> >
> > -		new_ti =3D table_instance_expand(ti, true);
> > +		new_ti =3D table_instance_expand(table, ti, true);
> >  		if (new_ti) {
> >  			rcu_assign_pointer(table->ufid_ti, new_ti);
> >  			call_rcu(&ti->rcu, flow_tbl_destroy_rcu_cb);
> > @@ -1075,12 +1128,14 @@ static void flow_ufid_insert(struct flow_table =
*table, struct sw_flow *flow)
> >  	}
> >  }
> >
> > -/* Must be called with OVS mutex held. */
> > +/* Must be called with table mutex held. */
> >  int ovs_flow_tbl_insert(struct flow_table *table, struct sw_flow *flow=
,
> >  			const struct sw_flow_mask *mask)
> >  {
> >  	int err;
> >
> > +	ASSERT_OVS_TBL(table);
> > +
> >  	err =3D flow_mask_insert(table, flow, mask);
> >  	if (err)
> >  		return err;
> > @@ -1099,10 +1154,11 @@ static int compare_mask_and_count(const void *a=
, const void *b)
> >  	return (s64)mc_b->counter - (s64)mc_a->counter;
> >  }
> >
> > -/* Must be called with OVS mutex held. */
> > +/* Must be called with table->lock held. */
> >  void ovs_flow_masks_rebalance(struct flow_table *table)
> >  {
> > -	struct mask_array *ma =3D rcu_dereference_ovsl(table->mask_array);
> > +	struct mask_array *ma =3D rcu_dereference_ovs_tbl(table->mask_array,
> > +							table);
> >  	struct mask_count *masks_and_count;
> >  	struct mask_array *new;
> >  	int masks_entries =3D 0;
> > @@ -1117,7 +1173,7 @@ void ovs_flow_masks_rebalance(struct flow_table *=
table)
> >  		struct sw_flow_mask *mask;
> >  		int cpu;
> >
> > -		mask =3D rcu_dereference_ovsl(ma->masks[i]);
> > +		mask =3D rcu_dereference_ovs_tbl(ma->masks[i], table);
> >  		if (unlikely(!mask))
> >  			break;
> >
> > @@ -1171,7 +1227,7 @@ void ovs_flow_masks_rebalance(struct flow_table *=
table)
> >  	for (i =3D 0; i < masks_entries; i++) {
> >  		int index =3D masks_and_count[i].index;
> >
> > -		if (ovsl_dereference(ma->masks[index]))
> > +		if (ovs_tbl_dereference(ma->masks[index], table))
> >  			new->masks[new->count++] =3D ma->masks[index];
> >  	}
> >
> > diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.=
h
> > index f524dc3e4862..cffd412c9045 100644
> > --- a/net/openvswitch/flow_table.h
> > +++ b/net/openvswitch/flow_table.h
> > @@ -59,7 +59,29 @@ struct table_instance {
> >  	u32 hash_seed;
> >  };
> >
> > +/* Locking:
> > + *
> > + * flow_table is _not_ protected by ovs_lock (see comment above ovs_mu=
tex
> > + * in datapath.c).
> > + *
> > + * All writes to flow_table are protected by the embedded "lock".
> > + * In order to ensure datapath destruction does not trigger the destru=
ction
> > + * of the flow_table, "refcnt" is used. Therefore, writers must:
> > + * 1 - Enter rcu read-protected section
> > + * 2 - Increase "table->refcnt"
> > + * 3 - Leave rcu read-protected section (to avoid using mutexes inside=
 rcu)
> > + * 4 - Lock "table->lock"
> > + * 5 - Perform modifications
> > + * 6 - Release "table->lock"
> > + * 7 - Decrease "table->refcnt"
> > + *
> > + * Reads are protected by RCU.
> > + */
> >  struct flow_table {
> > +	/* Locks flow table writes. */
> > +	struct mutex lock;
> > +	refcount_t refcnt;
> > +	struct rcu_head rcu;
> >  	struct table_instance __rcu *ti;
> >  	struct table_instance __rcu *ufid_ti;
> >  	struct mask_cache __rcu *mask_cache;
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
> > +#define rcu_dereference_ovs_tbl(p, tbl) \
> > +	rcu_dereference_check(p,		\
> > +		lockdep_ovs_tbl_is_held(tbl) || lockdep_ovsl_is_held())
> > +
> >  int ovs_flow_init(void);
> >  void ovs_flow_exit(void);
> >
> >  struct sw_flow *ovs_flow_alloc(void);
> >  void ovs_flow_free(struct sw_flow *, bool deferred);
> >
> > -int ovs_flow_tbl_init(struct flow_table *);
> > +struct flow_table *ovs_flow_tbl_alloc(void);
> > +void ovs_flow_tbl_put(struct flow_table *table);
> > +static inline bool ovs_flow_tbl_get(struct flow_table *table)
> > +{
> > +	return refcount_inc_not_zero(&table->refcnt);
> > +}
> >  int ovs_flow_tbl_count(const struct flow_table *table);
> > -void ovs_flow_tbl_destroy(struct flow_table *table);
> >  int ovs_flow_tbl_flush(struct flow_table *flow_table);
> >
> >  int ovs_flow_tbl_insert(struct flow_table *table, struct sw_flow *flow=
,
>


