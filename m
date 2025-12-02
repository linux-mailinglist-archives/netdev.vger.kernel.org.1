Return-Path: <netdev+bounces-243191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9183EC9B329
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 11:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF43466C2
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F53309EF4;
	Tue,  2 Dec 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="ECameLAC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756752F6184
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672087; cv=none; b=JOS/H14nuaaKLhuIlbir5D7anAz4GXdZFuA3HYMFw7kbGdmYnJB+NgCEpRd0oxbFdLE1v3Qg18/hCjKwyvfCBxCfxBU6KUlEmzWV6DkqHknK7Gvap6PHJg4skx2/y4IPgF7sxyiDzFtAdiMDxuEyj/Zj4u3pmPeDpZucXHcc2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672087; c=relaxed/simple;
	bh=AB/YV5FgeN7iiVMR16ByeM4aMGMDjBYkKLdys2MDF4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jlKH7Naxng/L2/hDzYUSdKOIwS9VoiHiP0Rnmz8fKg10Xxp80hx90eYtCiW/s/6MdH5E5P6RL10G6BxO1V58XLTdjlETh1NXL9/+qIl9trKU5XCaAgqDb6vX/E6zQOeqh15Vj1HW+zoirTawp93y5bB04OpR1SDSmdAbnKdtDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=ECameLAC; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764672082; bh=AB/YV5FgeN7iiVMR16ByeM4aMGMDjBYkKLdys2MDF4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ECameLACubzq7uw8LYTKmDrujVAzjZXphpHiQXk8+ht8wMQCSjwj+CoL6lrcWvm/4
	 4GgRsHvbt94d03UCDIQwc3fSBgj7PFJYHazD7jmESSEeoVz4PhaXhH+CBfVHUxbPNP
	 wcTGcfs2UO5uakbFYOV8aa7cpsvBGBUsw6uOyoBfXIexVHrXLuSruXe7riOkhy2yOX
	 9uS31u6hEIl6AcbUIt5vvq8DD9xdr0vIsDyL5ipC+WggmpKe2EL0jXjp1UbzUE0vc0
	 BJz0zblUqq6CCt4j4qgbID5ly91PjRZceZRabn+jVU8kPQQBied1ShMcV9ixDa0OAr
	 CRYibzFUMkQIw==
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/5] net/sched: Export mq functions for reuse
In-Reply-To: <willemdebruijn.kernel.1b99d2d13dcba@gmail.com>
References: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
 <20251130-mq-cake-sub-qdisc-v3-1-5f66c548ecdc@redhat.com>
 <willemdebruijn.kernel.1b99d2d13dcba@gmail.com>
Date: Tue, 02 Dec 2025 11:41:20 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87345t9ne7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> To enable the cake_mq qdisc to reuse code from the mq qdisc, export a
>> bunch of functions from sch_mq. Split common functionality out from some
>> functions so it can be composed with other code, and export other
>> functions wholesale.
>>=20
>> No functional change intended.
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  include/net/sch_generic.h | 19 +++++++++++++
>>  net/sched/sch_mq.c        | 69 ++++++++++++++++++++++++++++++++--------=
-------
>>  2 files changed, 67 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> index c3a7268b567e..f2281914d962 100644
>> --- a/include/net/sch_generic.h
>> +++ b/include/net/sch_generic.h
>
> We probably want to avoid random users. This may be better suited to a
> local header, similar to net/core/devmem.h.

Hmm, right; I just put them in sch_generic.h because that's where the
existing mq_change_real_num_tx() was. I can move them, though, don't
feel strongly about it either way :)

> I don't mean to derail this feature if these are the only concerns.
> This can be revised later in -rcX too.

Sure, let's see if our benevolent maintainers decide to merge this
before or after the merge window; I'll follow up as appropriate.

>> @@ -1419,7 +1419,26 @@ void mini_qdisc_pair_init(struct mini_Qdisc_pair =
*miniqp, struct Qdisc *qdisc,
>>  void mini_qdisc_pair_block_init(struct mini_Qdisc_pair *miniqp,
>>  				struct tcf_block *block);
>>=20=20
>> +struct mq_sched {
>> +	struct Qdisc		**qdiscs;
>> +};
>> +
>> +int mq_init_common(struct Qdisc *sch, struct nlattr *opt,
>> +		   struct netlink_ext_ack *extack,
>> +		   const struct Qdisc_ops *qdisc_ops);
>> +void mq_destroy_common(struct Qdisc *sch);
>> +void mq_attach(struct Qdisc *sch);
>>  void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx);
>> +void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb);
>> +struct netdev_queue *mq_select_queue(struct Qdisc *sch,
>> +				     struct tcmsg *tcm);
>> +struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl);
>> +unsigned long mq_find(struct Qdisc *sch, u32 classid);
>> +int mq_dump_class(struct Qdisc *sch, unsigned long cl,
>> +		  struct sk_buff *skb, struct tcmsg *tcm);
>> +int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
>> +			struct gnet_dump *d);
>> +void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg);
>>=20=20
>>  int sch_frag_xmit_hook(struct sk_buff *skb, int (*xmit)(struct sk_buff =
*skb));
>>=20=20
>> diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
>> index c860119a8f09..0bcabdcd1f44 100644
>> --- a/net/sched/sch_mq.c
>> +++ b/net/sched/sch_mq.c
>> @@ -17,10 +17,6 @@
>>  #include <net/pkt_sched.h>
>>  #include <net/sch_generic.h>
>>=20=20
>> -struct mq_sched {
>> -	struct Qdisc		**qdiscs;
>> -};
>> -
>>  static int mq_offload(struct Qdisc *sch, enum tc_mq_command cmd)
>>  {
>>  	struct net_device *dev =3D qdisc_dev(sch);
>> @@ -49,23 +45,29 @@ static int mq_offload_stats(struct Qdisc *sch)
>>  	return qdisc_offload_dump_helper(sch, TC_SETUP_QDISC_MQ, &opt);
>>  }
>>=20=20
>> -static void mq_destroy(struct Qdisc *sch)
>> +void mq_destroy_common(struct Qdisc *sch)
>>  {
>>  	struct net_device *dev =3D qdisc_dev(sch);
>>  	struct mq_sched *priv =3D qdisc_priv(sch);
>>  	unsigned int ntx;
>>=20=20
>> -	mq_offload(sch, TC_MQ_DESTROY);
>> -
>>  	if (!priv->qdiscs)
>>  		return;
>>  	for (ntx =3D 0; ntx < dev->num_tx_queues && priv->qdiscs[ntx]; ntx++)
>>  		qdisc_put(priv->qdiscs[ntx]);
>>  	kfree(priv->qdiscs);
>>  }
>> +EXPORT_SYMBOL(mq_destroy_common);
>
> On a similar note, this would be a good use of EXPORT_SYMBOL_NS_GPL.
>
> Maybe not even NETDEV_INTERNAL but a dedicated NET_SCHED_MQ.

Huh, didn't know about namespaced exports, neat. Can do that too :)

-Toke

