Return-Path: <netdev+bounces-255843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IvQLSuKgGnO9wIAu9opvQ
	(envelope-from <netdev+bounces-255843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:27:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5A2CB9D4
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB0FE3006173
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A6D35CBD1;
	Mon,  2 Feb 2026 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cGnK7O3C"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1841B808
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031652; cv=none; b=XjE7y/ouFAq6zDqpV+EXK3BFANuoUXSNF4wRIKxFA4kUUahs0KaktGlM+zIbvgGLS71+/FSTH0P/2X2G/MX1nuuyH+14P5b6egJW9+x45TIM2j80VkZNhgZ/neIFD4RV1yIu5iGrrimj2Ft/UwyUvMWT28eqYhSUswZ6cjOiNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031652; c=relaxed/simple;
	bh=4ZqK8Ht+8XyeisDRpDtsx60wvU3iI9Mv2T9AfyLAaws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jn5IPcZma1BT0yODfL14NtyW6hSo29//V4UCRQ7DMG2+YPrL7N48M1axdY/dW92LRKqBt1Z2qMVYqVxB2X+IjEwhpzstkI+q74Q75umKZ9ZCCMx4a9daD2mnHd5fFHXyWVWh9UKm2fw/6FKByq30nrtDMxicXABKLF07SSoxsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cGnK7O3C; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OpoDYS0aAooI2y3y6C+WG3Rtu3IYS+8O2ncrNtl7MsQ=;
	b=cGnK7O3CK2ryj46/rVObOh//K0OHerXFpgnVvI8XQLKeyrS3tGt1r0rcVo+xGmlJFo9iQgxLX
	k8NuxQ9ZVBCPHOTch+6Ns7Q79kHt6TNtIg9+56gu+mBaPajztB87KFoQffMTpqFeALxllVOWl0g
	fHqrdBZTmcC0x5nrZGisYZ8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f4PNx31y4z1K97c;
	Mon,  2 Feb 2026 19:22:57 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 148774048B;
	Mon,  2 Feb 2026 19:27:28 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 19:27:27 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 19:27:27 +0800
Message-ID: <ad09709f-a37a-40c2-9af8-a7294bdc40c8@huawei.com>
Date: Mon, 2 Feb 2026 19:27:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<fengwei_yin@linux.alibaba.com>, <zhangchangzhong@huawei.com>
References: <20260131212934.2547995-1-edumazet@google.com>
 <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
 <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com>
 <c63047b5-3059-4176-8d9d-5465d557e605@huawei.com>
 <CANn89iK95qb_=KWrcsvqEB9Bn0PXi3JkY5h09NiWuVWARABOww@mail.gmail.com>
 <CANn89iJRmEPJiz5-L_yJorU+xH5kBwraFy2_-=TwgkHzzfjKEg@mail.gmail.com>
 <CANn89iJd_jCkYsoey5Zf0zc8ASwt4+sg6bOjgyesQefWkBVE5w@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CANn89iJd_jCkYsoey5Zf0zc8ASwt4+sg6bOjgyesQefWkBVE5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255843-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5D5A2CB9D4
X-Rspamd-Action: no action


> On Mon, Feb 2, 2026 at 10:14 AM Eric Dumazet <edumazet@google.com> wrote:
>> On Mon, Feb 2, 2026 at 9:47 AM Eric Dumazet <edumazet@google.com> wrote:
>>> On Mon, Feb 2, 2026 at 9:21 AM dongchenchen (A)
>>> <dongchenchen2@huawei.com> wrote:
>>>>
>>>> }
>>>>
>>>> [2] add delay to pype_seq_next
>>>> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
>>>> index 160dd729178f..73f5a20ef57c 100644
>>>> --- a/net/core/net-procfs.c
>>>> +++ b/net/core/net-procfs.c
>>>> @@ -230,11 +230,14 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>>>
>>>>           pt = v;
>>>>           nxt = pt->list.next;
>>>> +       if (pt->dev)
>>>> +               mdelay(5000);
>>> Waiting 5 seconds while holding RCU is going to fire the soft lockup
>>> detection after ~two calls to ptype_seq_next()
>>>
>>> What is the actual trace you got, and what happens if you reduce to
>>> mdelay(1000) ?
>> OK, I took a look, and ptype_get_idx() needs to return information
>> about what list the returned pt is in.
>>
>> I will send a V2 ,thanks.
> Here is what I will squash, the diff against V1 is :
>
> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> index 160dd729178fd37a6340148d9e35f95bd92aecdb..ad63556c9e0abd15cbfac7777c31894d2eef037b
> 100644
> --- a/net/core/net-procfs.c
> +++ b/net/core/net-procfs.c
> @@ -170,8 +170,15 @@ static const struct seq_operations softnet_seq_ops = {
>          .show  = softnet_seq_show,
>   };
>
> +
> +struct ptype_iter_state {
> +       struct seq_net_private  p;
> +       struct net_device       *dev;
> +};
> +
>   static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
>   {
> +       struct ptype_iter_state *iter = seq->private;
>          struct list_head *ptype_list = NULL;
>          struct packet_type *pt = NULL;
>          struct net_device *dev;
> @@ -181,12 +188,16 @@ static void *ptype_get_idx(struct seq_file *seq,
> loff_t pos)
>          for_each_netdev_rcu(seq_file_net(seq), dev) {
>                  ptype_list = &dev->ptype_all;
>                  list_for_each_entry_rcu(pt, ptype_list, list) {
> -                       if (i == pos)
> +                       if (i == pos) {
> +                               iter->dev = dev;
>                                  return pt;
> +                       }
>                          ++i;
>                  }
>          }
>
> +       iter->dev = NULL;
> +
>          list_for_each_entry_rcu(pt, &seq_file_net(seq)->ptype_all, list) {
>                  if (i == pos)
>                          return pt;
> @@ -218,6 +229,7 @@ static void *ptype_seq_start(struct seq_file *seq,
> loff_t *pos)
>
>   static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   {
> +       struct ptype_iter_state *iter = seq->private;
>          struct net *net = seq_file_net(seq);
>          struct net_device *dev;
>          struct packet_type *pt;
> @@ -229,19 +241,21 @@ static void *ptype_seq_next(struct seq_file
> *seq, void *v, loff_t *pos)
>                  return ptype_get_idx(seq, 0);
>
>          pt = v;
> -       nxt = pt->list.next;
> -       dev = rcu_dereference(pt->dev);
> +       nxt = READ_ONCE(pt->list.next);
> +       dev = iter->dev;
>          if (dev) {
>                  if (nxt != &dev->ptype_all)
>                          goto found;
>
>                  for_each_netdev_continue_rcu(seq_file_net(seq), dev) {
> -                       if (!list_empty(&dev->ptype_all)) {
> -                               nxt = dev->ptype_all.next;
> +                       nxt = READ_ONCE(dev->ptype_all.next);
> +                       if (nxt != &dev->ptype_all) {
> +                               iter->dev = NULL;
>                                  goto found;
>                          }
>                  }
> -               nxt = net->ptype_all.next;
> +               iter->dev = NULL;
> +               nxt = READ_ONCE(net->ptype_all.next);
>                  goto net_ptype_all;
>          }
>
> @@ -252,20 +266,20 @@ static void *ptype_seq_next(struct seq_file
> *seq, void *v, loff_t *pos)
>
>                  if (nxt == &net->ptype_all) {
>                          /* continue with ->ptype_specific if it's not empty */
> -                       nxt = net->ptype_specific.next;
> +                       nxt = READ_ONCE(net->ptype_specific.next);
>                          if (nxt != &net->ptype_specific)
>                                  goto found;
>                  }
>
>                  hash = 0;
> -               nxt = ptype_base[0].next;
> +               nxt = READ_ONCE(ptype_base[0].next);
>          } else
>                  hash = ntohs(pt->type) & PTYPE_HASH_MASK;
>
>          while (nxt == &ptype_base[hash]) {
>                  if (++hash >= PTYPE_HASH_SIZE)
>                          return NULL;
> -               nxt = ptype_base[hash].next;
> +               nxt = READ_ONCE(ptype_base[hash].next);
>          }
>   found:
>          return list_entry(nxt, struct packet_type, list);
> @@ -279,6 +293,7 @@ static void ptype_seq_stop(struct seq_file *seq, void *v)
>
>   static int ptype_seq_show(struct seq_file *seq, void *v)
>   {
> +       struct ptype_iter_state *iter = seq->private;
>          struct packet_type *pt = v;
>          struct net_device *dev;
>
> @@ -286,7 +301,7 @@ static int ptype_seq_show(struct seq_file *seq, void *v)
>                  seq_puts(seq, "Type Device      Function\n");
>                  return 0;
>          }
> -       dev = rcu_dereference(pt->dev);
> +       dev = iter->dev;
>          if ((!pt->af_packet_net || net_eq(pt->af_packet_net,
> seq_file_net(seq))) &&
>                   (!dev || net_eq(dev_net(dev), seq_file_net(seq)))) {
>                  if (pt->type == htons(ETH_P_ALL))
> @@ -319,7 +334,7 @@ static int __net_init dev_proc_net_init(struct net *net)
>                           &softnet_seq_ops))
>                  goto out_dev;
>          if (!proc_create_net("ptype", 0444, net->proc_net, &ptype_seq_ops,
> -                       sizeof(struct seq_net_private)))
> +                       sizeof(struct ptype_iter_state)))
>                  goto out_softnet;
>
>          if (wext_proc_init(net))

I verified that this issue can be fixed with this patch.

Thanks a lot!

-----

Best Regards,
Dong Chenchen


