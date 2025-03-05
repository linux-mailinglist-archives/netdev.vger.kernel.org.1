Return-Path: <netdev+bounces-172101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73842A5038D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A6D18866A8
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47C24EA82;
	Wed,  5 Mar 2025 15:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5624C090
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188937; cv=none; b=UNEiR0OQIc2MQhfBMPUOk80yN5TrKU4/x98zJuZvfIhgllFvS6rURH1wCItMl4A6hqbWzTwWHdmvOjqSBoBFQcU7cgT/WgwUybZvurIxjF1EWP4USDghUzSpyNGFrhPhNpc8IC4i96jo9vV9WdLRmJ5/X6HLLjDqTOHgl6xQ5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188937; c=relaxed/simple;
	bh=dD6R3MXjNEDOsSMGWMeMIntBIhaPDZnJz+28l83n4q0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QSE5Axo/3u+2wCKsW/fMyM5iMqjuJPxiLlC7WpveFCR1oqIB//h91tQEFKESo24ZXlnsoKzJ/52Opwr8wj6kYDN9ZCPGsDlwZYgUjmO5aDO7HhVFy5SfY9RyZ+osRz1jzui4Q8MOg+ndyirWGo6Whej3bqNiQH3EpOg+CIMOif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-abf628d653eso625639066b.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 07:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188934; x=1741793734;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZGUJETYWa2heSrwlSfvDQOeH9SnfnhJM3RUvcpZg4I=;
        b=od2xab6aBGLqjmpLbfIU7wrSAJbi0wrXpNu+q+hJHnmvtqSj/2I8FLbVoL9VhSN0uD
         rPBE/1OusuEsYCjCTQr2gLQI3gE1ER+UUy00BsL5nXsE7l6CK1vI6XUFInrV1gmVR8km
         C75KmMD4jvjYhl3uRYBUtcmRPy0TpoXQdW4yW2qfOfBIByszmQX9G5zhEVEWGr2cx71t
         qUU3SEq88BCLbbeRF9rk1a40lrQieGnluhNgN9VyBAqV41YQXZlUmjlNxLXyJQiMYl2B
         Q3lqLCA4x2+dl83jKNZmzye7NGcV2iVO1KhtkO9m/F4ERaOvG3cGsjcwJl7MLXNfIySy
         3Ibw==
X-Forwarded-Encrypted: i=1; AJvYcCXMj2wvaCiFSCgUQa3AZvxlbtHGIzf6bq+OW47d/lyFAsHZpzb2nIPKkNV2u22soT/8EUo2p28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwzLelfbpqgPOWj3h3FDvgUYCcAzmo7x3m6HCSwXo8qbli2YWS
	4/T453IqT8RsMzYbsGGroEG4Z8Lz9SUwoOLBv2IR6g2CVOtdPT5x
X-Gm-Gg: ASbGnct6L4mC9AW1YAONuGXw3+TtDemRaLrfOaY+d7GXZo9WUDKeAnPkQKhQa/rYpTW
	jWUsxIHTDJH0fMckTvAxNmJDUsF/A20/JcxzlNcgpwxmDGM7qPK2XYnYK4T1idx2m72mgarWv3l
	wHkxY9yGJTH+dr8oFWGk2LNe1FLcdQLlshoAyKQT9TYGOZ6TyQAvTKbi0PAC7wmW75ViwVUBBVm
	ZPrFCCWSu0t4Ri7xRL396f5XoPR1O7BKIFAtf217wu1lWuI560RCTDMjvOwUkGnidO1gy2xz/Tc
	FmgthsahOARiWqe9TwjKfZPKxa4xGd50Vt11A40x6xxatPncV8u4pS0saSf+Srtv9IxwInnoVSK
	Q
X-Google-Smtp-Source: AGHT+IGB0pgPriK9iUfgxWoR28Et8R7tG3A1mw6ug59D0w4ETmkGDe/hGd+QcJe7Prm5FNWEsnzgbA==
X-Received: by 2002:a17:907:3f25:b0:ac1:fcda:78c1 with SMTP id a640c23a62f3a-ac20d97e6b7mr386658966b.34.1741188933449;
        Wed, 05 Mar 2025 07:35:33 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e09a9fbesm427382366b.19.2025.03.05.07.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:35:33 -0800 (PST)
Message-ID: <c7a9b481-190d-4b4b-a5ff-6f244c8c1abe@ovn.org>
Date: Wed, 5 Mar 2025 16:35:32 +0100
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
 Aaron Conole <aconole@redhat.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] openvswitch: avoid allocating labels_ext in
 ovs_ct_set_labels
To: Xin Long <lucien.xin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>
References: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
 <295e2902-9036-46c9-a110-bf5bf27ed473@nvidia.com>
 <CADvbK_cD7gVbrOH3Ps6SXhbwyxka_BaMH+NvRY6rKBgwvORiRw@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CADvbK_cD7gVbrOH3Ps6SXhbwyxka_BaMH+NvRY6rKBgwvORiRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/25 15:59, Xin Long wrote:
> On Tue, Mar 4, 2025 at 8:31 PM Jianbo Liu <jianbol@nvidia.com> wrote:
>>
>>
>>
>> On 3/5/2025 1:15 AM, Xin Long wrote:
>>> Currently, ovs_ct_set_labels() is only called for *confirmed* conntrack
>>> entries (ct) within ovs_ct_commit(). However, if the conntrack entry
>>> does not have the labels_ext extension, attempting to allocate it in
>>> ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
>>> nf_ct_ext_add():
>>>
>>>    WARN_ON(nf_ct_is_confirmed(ct));
>>>
>>> This happens when the conntrack entry is created externally before OVS
>>> increases net->ct.labels_used. The issue has become more likely since
>>> commit fcb1aa5163b1 ("openvswitch: switch to per-action label counting
>>> in conntrack"), which switched to per-action label counting.
>>>
>>> To prevent this warning, this patch modifies ovs_ct_set_labels() to
>>> call nf_ct_labels_find() instead of ovs_ct_get_conn_labels() where
>>> it allocates the labels_ext if it does not exist, aligning its
>>> behavior with tcf_ct_act_set_labels().
>>>
>>> Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label counting in conntrack")
>>> Reported-by: Jianbo Liu <jianbol@nvidia.com>
>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>>> ---
>>>   net/openvswitch/conntrack.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>> index 3bb4810234aa..f13fbab4c942 100644
>>> --- a/net/openvswitch/conntrack.c
>>> +++ b/net/openvswitch/conntrack.c
>>> @@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct, struct sw_flow_key *key,
>>>       struct nf_conn_labels *cl;
>>>       int err;
>>>
>>> -     cl = ovs_ct_get_conn_labels(ct);
>>> +     cl = nf_ct_labels_find(ct);
>>
>> I don't think it's correct fix. The label is not added and packets can't
>> pass the next rule to match ct_label.
>>
> That's expected, external ct may not work in the flow with extensions.
> Again, "openvswitch: switch to per-action label counting in conntrack"
> only makes it easier to be triggered.
> 
>> I tested it and used the configuration posted before, ping can't work.
> I've provided the 'workaround' with the ct zone for this in the other email.

I think, the test provided in the other thread is reasonable and logically
correct.   The link for the test:
  https://lore.kernel.org/all/2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com/

We should be able to match on the label committed in the original direction.
The workaround doesn't really cover the use case, because the labels cover
a much larger scope that zones and it may be not possible to use zones instead
of labels.  Also, the ct entry obtained in the test is not from outside, AFAICT,
it is created inside the OVS pipeline and labels are also created inside the
OVS datapath, so it should work.

On a side note, the fact that it's allowed to modify labels for committed
connections, but it's not allowed to set one when there is none, seems like
an inconsistent behavior.  Maybe that should be fixed and the warning removed?

Best regards, Ilya Maximets.

> 
> I would also like to see the maintainer's option about this.
> 
> Thanks.


