Return-Path: <netdev+bounces-104968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7BA90F514
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3C52817D7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A81DA24;
	Wed, 19 Jun 2024 17:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167C2139D1
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818222; cv=none; b=pv/51PHFeEk/gEWkr9ZuDuEPiJO/vRAPyXwXP6iC5kir2jY+onXGBy4nspWEqoO6bw2apL+ddy1ugYrLDxR98BtP+JqQ5p63QumkYbsJlvvhlgCFJyyxD60tFUV0/MkivS78nT9OHo0oyeSVsRq5G+WOjK5qEFgAsZxg6XnXnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818222; c=relaxed/simple;
	bh=H/ODKRblaJNJP7czSwTWCpGQnqV5n73rUZNfi6NTdLE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=apHQQi0k2VzlIGpdf9okkscDGkCoykKczNCeKeg+lHvTOMx6UaRl9X7wYO8VWiEHIoqumYGlSWlEH1IxwzqnDos6fLBtCnE8I5bNzEl2CPNeAcj+X4FzG0kc+r2dOLheMV0hXC7d0G10kjQIJwVmSm7AL3knnzkwJN7yq+C0tOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B43931BF204;
	Wed, 19 Jun 2024 17:30:08 +0000 (UTC)
Message-ID: <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org>
Date: Wed, 19 Jun 2024 19:30:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, network dev <netdev@vger.kernel.org>,
 dev@openvswitch.org, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Davide Caratti <dcaratti@redhat.com>,
 Florian Westphal <fw@strlen.de>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 Pablo Neira Ayuso <pablo@netfilter.org>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next 3/3] openvswitch: set IPS_CONFIRMED in tmpl
 status only when commit is set in conntrack
To: Xin Long <lucien.xin@gmail.com>
References: <cover.1689541664.git.lucien.xin@gmail.com>
 <cf477f4a26579e752465a5951c1d28ba109346e3.1689541664.git.lucien.xin@gmail.com>
 <d35d01d9-83de-4862-85a7-574a6c4dc8f5@ovn.org>
 <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
 <CADvbK_f9=smg+C7M3dWWj9nvv7Z7_jCLn=6m0OLhmF_V0AEFsg@mail.gmail.com>
 <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org>
 <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org

On 6/19/24 16:07, Xin Long wrote:
> On Wed, Jun 19, 2024 at 8:58 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> On 6/18/24 17:50, Ilya Maximets wrote:
>>> On 6/18/24 16:58, Xin Long wrote:
>>>> On Tue, Jun 18, 2024 at 7:34 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>
>>>>> On 6/17/24 22:10, Ilya Maximets wrote:
>>>>>> On 7/16/23 23:09, Xin Long wrote:
>>>>>>> By not setting IPS_CONFIRMED in tmpl that allows the exp not to be removed
>>>>>>> from the hashtable when lookup, we can simplify the exp processing code a
>>>>>>> lot in openvswitch conntrack.
>>>>>>>
>>>>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>>>>>>> ---
>>>>>>>  net/openvswitch/conntrack.c | 78 +++++--------------------------------
>>>>>>>  1 file changed, 10 insertions(+), 68 deletions(-)
>>>>>>>
>>>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>>>>>> index 331730fd3580..fa955e892210 100644
>>>>>>> --- a/net/openvswitch/conntrack.c
>>>>>>> +++ b/net/openvswitch/conntrack.c
>>>>>>> @@ -455,45 +455,6 @@ static int ovs_ct_handle_fragments(struct net *net, struct sw_flow_key *key,
>>>>>>>      return 0;
>>>>>>>  }
>>>>>>>
>>>>>>> -static struct nf_conntrack_expect *
>>>>>>> -ovs_ct_expect_find(struct net *net, const struct nf_conntrack_zone *zone,
>>>>>>> -               u16 proto, const struct sk_buff *skb)
>>>>>>> -{
>>>>>>> -    struct nf_conntrack_tuple tuple;
>>>>>>> -    struct nf_conntrack_expect *exp;
>>>>>>> -
>>>>>>> -    if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb), proto, net, &tuple))
>>>>>>> -            return NULL;
>>>>>>> -
>>>>>>> -    exp = __nf_ct_expect_find(net, zone, &tuple);
>>>>>>> -    if (exp) {
>>>>>>> -            struct nf_conntrack_tuple_hash *h;
>>>>>>> -
>>>>>>> -            /* Delete existing conntrack entry, if it clashes with the
>>>>>>> -             * expectation.  This can happen since conntrack ALGs do not
>>>>>>> -             * check for clashes between (new) expectations and existing
>>>>>>> -             * conntrack entries.  nf_conntrack_in() will check the
>>>>>>> -             * expectations only if a conntrack entry can not be found,
>>>>>>> -             * which can lead to OVS finding the expectation (here) in the
>>>>>>> -             * init direction, but which will not be removed by the
>>>>>>> -             * nf_conntrack_in() call, if a matching conntrack entry is
>>>>>>> -             * found instead.  In this case all init direction packets
>>>>>>> -             * would be reported as new related packets, while reply
>>>>>>> -             * direction packets would be reported as un-related
>>>>>>> -             * established packets.
>>>>>>> -             */
>>>>>>> -            h = nf_conntrack_find_get(net, zone, &tuple);
>>>>>>> -            if (h) {
>>>>>>> -                    struct nf_conn *ct = nf_ct_tuplehash_to_ctrack(h);
>>>>>>> -
>>>>>>> -                    nf_ct_delete(ct, 0, 0);
>>>>>>> -                    nf_ct_put(ct);
>>>>>>> -            }
>>>>>>> -    }
>>>>>>> -
>>>>>>> -    return exp;
>>>>>>> -}
>>>>>>> -
>>>>>>>  /* This replicates logic from nf_conntrack_core.c that is not exported. */
>>>>>>>  static enum ip_conntrack_info
>>>>>>>  ovs_ct_get_info(const struct nf_conntrack_tuple_hash *h)
>>>>>>> @@ -852,36 +813,16 @@ static int ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
>>>>>>>                       const struct ovs_conntrack_info *info,
>>>>>>>                       struct sk_buff *skb)
>>>>>>>  {
>>>>>>> -    struct nf_conntrack_expect *exp;
>>>>>>> -
>>>>>>> -    /* If we pass an expected packet through nf_conntrack_in() the
>>>>>>> -     * expectation is typically removed, but the packet could still be
>>>>>>> -     * lost in upcall processing.  To prevent this from happening we
>>>>>>> -     * perform an explicit expectation lookup.  Expected connections are
>>>>>>> -     * always new, and will be passed through conntrack only when they are
>>>>>>> -     * committed, as it is OK to remove the expectation at that time.
>>>>>>> -     */
>>>>>>> -    exp = ovs_ct_expect_find(net, &info->zone, info->family, skb);
>>>>>>> -    if (exp) {
>>>>>>> -            u8 state;
>>>>>>> -
>>>>>>> -            /* NOTE: New connections are NATted and Helped only when
>>>>>>> -             * committed, so we are not calling into NAT here.
>>>>>>> -             */
>>>>>>> -            state = OVS_CS_F_TRACKED | OVS_CS_F_NEW | OVS_CS_F_RELATED;
>>>>>>> -            __ovs_ct_update_key(key, state, &info->zone, exp->master);
>>>>>>
>>>>>> Hi, Xin, others.
>>>>>>
>>>>>> Unfortunately, it seems like removal of this code broke the expected behavior.
>>>>>> OVS in userspace expects that SYN packet of a new related FTP connection will
>>>>>> get +new+rel+trk flags, but after this patch we're only getting +rel+trk and not
>>>>>> new.  This is a problem because we need to commit this connection with the label
>>>>>> and we do that for +new packets.  If we can't get +new packet we'll have to commit
>>>>>> every single +rel+trk packet, which doesn't make a lot of sense.  And it's a
>>>>>> significant behavior change regardless.
>>>>>
>>>>> Interestingly enough I see +new+rel+trk packets in cases without SNAT,
>>>>> but we can only get +rel+trk in cases with SNAT.  So, this may be just
>>>>> a generic conntrack bug somewhere.  At least the behavior seems fairly
>>>>> inconsistent.
>>>>>
>>>> In nf_conntrack, IP_CT_RELATED and IP_CT_NEW do not exist at the same
>>>> time. With this patch, we expect OVS_CS_F_RELATED and OVS_CS_F_NEW
>>>> are set at the same time by ovs_ct_update_key() when this related ct
>>>> is not confirmed.
>>>>
>>>> The check-kernel test of "FTP SNAT orig tuple" skiped on my env somehow:
>>>>
>>>> # make check-kernel
>>>> 144: conntrack - FTP SNAT orig tuple   skipped (system-traffic.at:7295)
>>>>
>>>> Any idea why? or do you know any other testcase that expects +new+rel+trk
>>>> but returns +rel+trk only?
>>>
>>> You need to install lftp and pyftpdlib.  The pyftpdlib may only be available
>>> via pip on some systems.
>>>
>>>>
>>>> Thanks.
>>>>>>
>>>>>> Could you, please, take a look?
>>>>>>
>>>>>> The issue can be reproduced by running check-kernel tests in OVS repo.
>>>>>> 'FTP SNAT orig tuple' tests fail 100% of the time.
>>>>>>
>>>>>> Best regards, Ilya Maximets.
>>>>>
>>>
>>
>> Hmm.  After further investigation, it seems that the issue is not about ct state,
>> but the ct label.  Before this commit we had information about both the original
>> tuple of the parent connection and the mark/label of the parent connection:
>>
> Make senses. Now I can see the difference after this commit.
> We will need a fix in __ovs_ct_update_key() to copy mark & label from
> ct->master for exp ct.
> 
> @@ -196,8 +196,8 @@ static void __ovs_ct_update_key(struct sw_flow_key
> *key, u8 state,
>  {
>         key->ct_state = state;
>         key->ct_zone = zone->id;
> -       key->ct.mark = ovs_ct_get_mark(ct);
> -       ovs_ct_get_labels(ct, &key->ct.labels);
> +       key->ct.mark = 0;
> +       memset(&key->ct.labels, 0, OVS_CT_LABELS_LEN);
> 
>         if (ct) {
>                 const struct nf_conntrack_tuple *orig;
> @@ -205,6 +205,8 @@ static void __ovs_ct_update_key(struct sw_flow_key
> *key, u8 state,
>                 /* Use the master if we have one. */
>                 if (ct->master)
>                         ct = ct->master;
> +               key->ct.mark = ovs_ct_get_mark(ct);
> +               ovs_ct_get_labels(ct, &key->ct.labels);
>                 orig = &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
> 
>                 /* IP version must match with the master connection. */
> 
> We may need to run some regression tests for such a change.

Thank, Xin!  This seems like a change in the right direction and it fixes
this particular test.  But, I guess, we should get mark/labels from the
master connection only if it is not yet confirmed.  Users may commit different
labels for the related connection.  This should be more in line with the
previous behavior.

What do you think?

Best regards, Ilya Maximets.

> 
> Thanks.
> 
>> system@ovs-system: miss upcall:
>> recirc_id(0x2),dp_hash(0),skb_priority(0),in_port(3),skb_mark(0),ct_state(0x25),
>> ct_zone(0x1),ct_mark(0),ct_label(0x4d2000000000000000000000001),
>> ct_tuple4(src=10.1.1.1,dst=10.1.1.2,proto=6,tp_src=50648,tp_dst=21),
>> eth(src=de:d9:f3:c8:5a:3a,dst=80:88:88:88:88:88),eth_type(0x0800),
>> ipv4(src=10.1.1.2,dst=10.1.1.9,proto=6,tos=0,ttl=64,frag=no),
>> tcp(src=57027,dst=38153),tcp_flags(syn)
>>
>> But after this change, we still have the original tuple of the parent connection,
>> but the label is no longer in the flow key:
>>
>> system@ovs-system: miss upcall:
>> recirc_id(0x2),dp_hash(0),skb_priority(0),in_port(3),skb_mark(0),ct_state(0x25),
>> ct_zone(0x1),ct_mark(0),ct_label(0),
>> ct_tuple4(src=10.1.1.1,dst=10.1.1.2,proto=6,tp_src=34668,tp_dst=21),
>> eth(src=66:eb:74:c6:79:24,dst=80:88:88:88:88:88),eth_type(0x0800),
>> ipv4(src=10.1.1.2,dst=10.1.1.9,proto=6,tos=0,ttl=64,frag=no),
>> tcp(src=49529,dst=35459),tcp_flags(syn)
>>
>> ct_state(0x25) == +new+rel+trk
>>
>> Best regards, Ilya Maximets.


