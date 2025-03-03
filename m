Return-Path: <netdev+bounces-171191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B52A4BD2E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C78C164062
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE31F30CC;
	Mon,  3 Mar 2025 10:56:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E21F0E28
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999408; cv=none; b=Fp+0/V2h/tFZIs0sD0Lf1uJw/BqGI1usOro8fIkS8zilPBLntULnOZsMOCI+MrGdeRgCVg6JtB1zqsx0mv3WQxFZaljPlLQgy/v+bzDQBkdYWyYW25k5g9Q02OpNhh34z6yZquBriI/I2Z1mmukbZ4PL0VvoZgloCBvq8q+466c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999408; c=relaxed/simple;
	bh=45MyM2ZxY9ZfPsDOJi4qfPV0jbp35IPfwAlCC/x6dUU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EPjTAOJ+vwHEgs9goPenNWVm6qg2B78xKgfJAXB2VNLs88958YgIYX+Emn6XdnYZV9CIWnbumo2SCsnm6XqoYFjFeMTJwdizfp1U9IjDbzEXGPf7mAkj32gCY2l+v69dnLsH94EJpyvN/Wv25i15yNXtTYnkisrOxcbaW1rkDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-abec8b750ebso749337766b.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 02:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999405; x=1741604205;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MW7nT9UkjTxJFQMPePuHhDv4EOiZxhswp1T01clzayk=;
        b=RcLC870MQ8HmnU6i9RL/k1vXCByhQpHMVYPcOA3uigccQxtCaeZM4kw/FCW0u7j90p
         hWob+ULfJkGdplX+2Z3gD6Q56Bmpw5UPW7EAo+I7q45Pk8PIQjO7W6c2vx32wKT5o2Im
         yRnoWshQfFr/HAPJm+haMBkHfETG5gyX++f9hWVN1EYN1k54BY+4BGCtqR6eAflgqUlh
         V0ZFU+MBiIWOvGAKNB9sz/lzHn9DZzX80WEaKQ4MsjqUowb3F7L+bCx1YZF8or1mvjfY
         tq/g5WxPcR0lm9Aw6iXEnkDUlXN25Z9IlB5QDHA5XykaQRZUiTQtAyeVhWiCQpsxujBN
         RVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+U+JVXseDSr8lf+6B6QNyWh1qNGB9zN7m3OxfvESfLS58rXP4nRYumqf8aAe9sFJ1+6bGHpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5/nbDu73JrwWTeX4hq8G3LjAJcK1Y/9DfLCZhjZiLvOnkNin
	t6a1Qe52zexSbgljyGZXEHH8CFQl0xpf6C/E/uCGWCpY+N8k2FmQ
X-Gm-Gg: ASbGncvKJ2vIsjMCq3/SXUUMr3NgkRfpARXGtUUiipNowBmeMCOIfXSl8PXUYKixZs/
	dK2WzCpvql2OkAW6R0dZlYXuO/iuAU6b5glQERg4lGfRXgCyIP+e6gDEV1y/xjowiw1Yh8fWmqP
	HEOxbJJ3VySzYj+NkVE1fPFnH100ev0jv3eb7v6rBdxZgF60q6Q5tkJMMuzggf8dWg8zXgatKXP
	23woJPb/J37sZQDdQ0H8b2Wov76/gbxY5UBgrpZucuyTgacLeHcaDqe0sBgvfrhdZBXTxaCYp3C
	+ax2/lJDFOiHt85NBrg3f66L3YiPBu/4dNJzMpCEu0CyQ3X+qUnvg+Dx5xv4oh3Gg7ayl6STVkd
	9
X-Google-Smtp-Source: AGHT+IFpRCm8TdmaDqOQMLXzM1dXPp9k8zhn2vuaEmKdQrQzGF9NXUTuTWwAFM7jpsqMHAQR2mQSNw==
X-Received: by 2002:a17:907:2d8c:b0:abf:4c5f:7546 with SMTP id a640c23a62f3a-abf4c5f7590mr797245266b.38.1740999404409;
        Mon, 03 Mar 2025 02:56:44 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf77b97114sm187758266b.78.2025.03.03.02.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:56:44 -0800 (PST)
Message-ID: <2400a58c-5f1d-4fe1-a2db-4c7207613b39@ovn.org>
Date: Mon, 3 Mar 2025 11:56:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, network dev <netdev@vger.kernel.org>,
 dev@openvswitch.org, ovs-dev@openvswitch.org, davem@davemloft.net,
 kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
 Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Xin Long <lucien.xin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
 <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com>
 <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
 <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com>
 <CADvbK_draP9X9OWXEYTKrP0_ekjgNu9PYPp6GUkvu-3L24SRYg@mail.gmail.com>
 <CADvbK_cungrr_D5VAiL8C+FSJEoLFYtMxV5foU0XA9E4zrcegA@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CADvbK_cungrr_D5VAiL8C+FSJEoLFYtMxV5foU0XA9E4zrcegA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/2/25 19:22, Xin Long wrote:
> On Tue, Feb 25, 2025 at 9:57 AM Xin Long <lucien.xin@gmail.com> wrote:
>>
>> On Mon, Feb 24, 2025 at 8:38 PM Jianbo Liu <jianbol@nvidia.com> wrote:
>>>
>>>
>>>
>>> On 2/25/2025 3:55 AM, Xin Long wrote:
>>>> On Mon, Feb 24, 2025 at 4:01 AM Jianbo Liu <jianbol@nvidia.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/13/2024 1:17 AM, Xin Long wrote:
>>>>>> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
>>>>>> label counting"), we should also switch to per-action label counting
>>>>>> in openvswitch conntrack, as Florian suggested.
>>>>>>
>>>>>> The difference is that nf_connlabels_get() is called unconditionally
>>>>>> when creating an ct action in ovs_ct_copy_action(). As with these
>>>>>> flows:
>>>>>>
>>>>>>     table=0,ip,actions=ct(commit,table=1)
>>>>>>     table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)
>>>>>>
>>>>>> it needs to make sure the label ext is created in the 1st flow before
>>>>>> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
>>>>>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
>>>>>> be triggered:
>>>>>>
>>>>>>      WARN_ON(nf_ct_is_confirmed(ct));
>>>>>>
>>>>>
>>>>> Hi Xin Long,
>>>>>
>>>>> The ct can be committed before openvswitch handles packets with CT
>>>>> actions. And we can trigger the warning by creating VF and running ping
>>>>> over it with the following configurations:
>>>>>
>>>>> ovs-vsctl add-br br
>>>>> ovs-vsctl add-port br eth2
>>>>> ovs-vsctl add-port br eth4
>>>>> ovs-ofctl add-flow br "table=0, in_port=eth4,ip,ct_state=-trk
>>>>> actions=ct(table=1)"
>>>>> ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_state=+trk+new
>>>>> actions=ct(exec(set_field:0xef7d->ct_label), commit), output:eth2"
>>>>> ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_label=0xef7d,
>>>>> ct_state=+trk+est actions=output:eth2"
>>>>>
>>>>> The eth2 is PF, and eth4 is VF's representor.
>>>>> Would you like to fix it?
>>>> Hi, Jianbo,
>>>>
>>>> Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() for
>>>> this case, and even delete the one created before ovs_ct.
>>>>
>>>> Can you check if this works on your env?
>>>
>>> Yes, it works.
>>> Could you please submit the formal patch? Thanks!
>> Great, I will post after running some of my local tests.
>>
> Hi Jianbo,
> 
> I recently ran some tests and observed that the current approach cannot
> completely avoid the warning. If an skb enters __ovs_ct_lookup() without
> an attached connection tracking (ct) entry, it may still acquire an
> existing ct created outside of OVS (possibly by netfilter) through
> nf_conntrack_in(). This will trigger the warning in ovs_ct_set_labels().
> 
> Deleting a ct created outside OVS and creating a new one within
> __ovs_ct_lookup() doesn't seem reasonable and would be difficult to
> implement. However, since OVS is not supposed to use ct entries created
> externally,

I'm not fully following this conversation, but this statement doesn't
seem right.  OVS should be able to use ct entries created externally.
i.e. if the packet already has some ct entry attached while entering
OVS datapth, OVS should be able to match on the content of that entry.

> I believe ct zones can be used to prevent this issue.
> In your case, the following flows should work:
> 
> ovs-ofctl add-flow br "table=0, in_port=eth4,ip,ct_state=-trk
> actions=ct(table=1,zone=1)"
> ovs-ofctl add-flow br "table=1,
> in_port=eth4,ip,ct_state=+trk+new,ct_zone=1
> actions=ct(exec(set_field:0xef7d->ct_label),commit,zone=1),
> output:eth2"
> ovs-ofctl add-flow br "table=1,
> in_port=eth4,ip,ct_label=0xef7d,ct_state=+trk+est,ct_zone=1
> actions=output:eth2"
> 
> Regarding the warning triggered by externally created ct entries, I plan
> to remove the ovs_ct_get_conn_labels() call from ovs_ct_set_labels() and
> I'll let nf_connlabels_replace() return an error in such cases, similar
> to how tcf_ct_act_set_labels() handles this scenario in tc act_ct.
> 
> Thanks.
>>>
>>>>
>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>>> index 3bb4810234aa..c599ee013dfe 100644
>>>> --- a/net/openvswitch/conntrack.c
>>>> +++ b/net/openvswitch/conntrack.c
>>>> @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
>>>>               rcu_dereference(timeout_ext->timeout))
>>>>               return false;
>>>>       }
>>>> +    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_find(ct)) {
>>>> +        if (nf_ct_is_confirmed(ct))
>>>> +            nf_ct_delete(ct, 0, 0);
>>>> +        return false;
>>>> +    }
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> Thanks!
>>>>> Jianbo
>>>>>
>>>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>>>>>> ---
>>>>>> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
>>>>>> ---
>>>>>>    net/openvswitch/conntrack.c | 30 ++++++++++++------------------
>>>>>>    net/openvswitch/datapath.h  |  3 ---
>>>>>>    2 files changed, 12 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>>>>> index 8eb1d644b741..a3da5ee34f92 100644
>>>>>> --- a/net/openvswitch/conntrack.c
>>>>>> +++ b/net/openvswitch/conntrack.c
>>>>>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_attr attr)
>>>>>>            attr == OVS_KEY_ATTR_CT_MARK)
>>>>>>                return true;
>>>>>>        if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
>>>>>> -         attr == OVS_KEY_ATTR_CT_LABELS) {
>>>>>> -             struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>> -
>>>>>> -             return ovs_net->xt_label;
>>>>>> -     }
>>>>>> +         attr == OVS_KEY_ATTR_CT_LABELS)
>>>>>> +             return true;
>>>>>>
>>>>>>        return false;
>>>>>>    }
>>>>>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>>>>>                       const struct sw_flow_key *key,
>>>>>>                       struct sw_flow_actions **sfa,  bool log)
>>>>>>    {
>>>>>> +     unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>>>>>        struct ovs_conntrack_info ct_info;
>>>>>>        const char *helper = NULL;
>>>>>>        u16 family;
>>>>>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>>>>>                return -ENOMEM;
>>>>>>        }
>>>>>>
>>>>>> +     if (nf_connlabels_get(net, n_bits - 1)) {
>>>>>> +             nf_ct_tmpl_free(ct_info.ct);
>>>>>> +             OVS_NLERR(log, "Failed to set connlabel length");
>>>>>> +             return -EOPNOTSUPP;
>>>>>> +     }
>>>>>> +
>>>>>>        if (ct_info.timeout[0]) {
>>>>>>                if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
>>>>>>                                      ct_info.timeout))
>>>>>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
>>>>>>        if (ct_info->ct) {
>>>>>>                if (ct_info->timeout[0])
>>>>>>                        nf_ct_destroy_timeout(ct_info->ct);
>>>>>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
>>>>>>                nf_ct_tmpl_free(ct_info->ct);
>>>>>>        }
>>>>>>    }
>>>>>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family __ro_after_init = {
>>>>>>
>>>>>>    int ovs_ct_init(struct net *net)
>>>>>>    {
>>>>>> -     unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>        struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>>
>>>>>> -     if (nf_connlabels_get(net, n_bits - 1)) {
>>>>>> -             ovs_net->xt_label = false;
>>>>>> -             OVS_NLERR(true, "Failed to set connlabel length");
>>>>>> -     } else {
>>>>>> -             ovs_net->xt_label = true;
>>>>>> -     }
>>>>>> -
>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>        return ovs_ct_limit_init(net, ovs_net);
>>>>>>    #else
>>>>>>        return 0;
>>>>>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
>>>>>>
>>>>>>    void ovs_ct_exit(struct net *net)
>>>>>>    {
>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>        struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>>
>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>        ovs_ct_limit_exit(net, ovs_net);
>>>>>>    #endif
>>>>>> -
>>>>>> -     if (ovs_net->xt_label)
>>>>>> -             nf_connlabels_put(net);
>>>>>>    }
>>>>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>>>>>> index 9ca6231ea647..365b9bb7f546 100644
>>>>>> --- a/net/openvswitch/datapath.h
>>>>>> +++ b/net/openvswitch/datapath.h
>>>>>> @@ -160,9 +160,6 @@ struct ovs_net {
>>>>>>    #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>        struct ovs_ct_limit_info *ct_limit_info;
>>>>>>    #endif
>>>>>> -
>>>>>> -     /* Module reference for configuring conntrack. */
>>>>>> -     bool xt_label;
>>>>>>    };
>>>>>>
>>>>>>    /**
>>>>>
>>>


