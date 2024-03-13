Return-Path: <netdev+bounces-79617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353A87A417
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406A12830C8
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2041946B;
	Wed, 13 Mar 2024 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JacM4Qge"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D81175BF
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318524; cv=none; b=esHB3QtXFRktPZGpAw7SV6sMTgfhyR3xuUW943w07J9bqZDjxAf5H99mrMUmBNMEv5ewIaEcI7BLV+D3UecfRW++UQbiT91cUgcI5bKgKLmg4frIIIRneTnPx7B23CuInyOyay1PvcPcynbcZDXgn6C8CQTwkjp03NQT1UxVNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318524; c=relaxed/simple;
	bh=ZMFKD2INknWG4x0CbznToeEL5lemorh/3OmDNPmum70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/PoXhIeY/6CUnXDvjDfCSsLeKPtEm5COIUzHmeBXGkQH/G8Zt9p9qndl7sapdB6fV+vSbSP8OxfFvUjxaaGSWj12PnAuK+LPcrauEt7C/sB4BWYKbys60+Miti3kasfotbeP2HQD2YWIbK/jyWhQGZ6aG63GCjTZ7Bj8eXNeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JacM4Qge; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710318521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFyIOa8QBl71xNZp+TQ+7M2A/iuI11Bl9oDdkxOVF3k=;
	b=JacM4Qge02u8NNSdke17qxUqJO4wIMkoSu6HxHbVyfghPcWVF56ordBukfyCiyUYv3L2nC
	RA1uKd7qRVkL5awCk+YjDuMV2tprPe4T3wuwqZZjq3lywyTDt+br3Tm3xYRXQyVejgdVkX
	bcKgNqU0O3QPxnZmW5ql0CKmMDhHXbA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-H7A-sW4AOx6fHzdQTtNc2w-1; Wed, 13 Mar 2024 04:28:39 -0400
X-MC-Unique: H7A-sW4AOx6fHzdQTtNc2w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412d1f1ee7cso3536355e9.3
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 01:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710318518; x=1710923318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFyIOa8QBl71xNZp+TQ+7M2A/iuI11Bl9oDdkxOVF3k=;
        b=bkrqseoa+1OX1wxVOUYxk5rQiPu8kFrDnOH+HeUzq1+4l/TO3WRxIJ3KBlGAutWUf6
         KMO7LDqIAHlCBM7E+xOnkh7X6UCo+fvli5eMBGrrfmwJC1rM5R74VrpTU1dREvtipZCr
         2qw1B4u+CHw1EiLs6/Cy/1Ws4uoR1kzEKclwRYFzi+TD1tLj4G3LYgwMiSPaAcpwTGLN
         IlHpsZ6Q4UpKCFrYLyVdOCHLZ9SOY99XWBIsa/QGY0H26ZDUwWArc0ZwA5KzoLYOuQsG
         6yq2pzrpspwlk0Dm5zqMA004Z+vxkTr5ka5uLjx2KFuFD8nBkCUC904dRAdEuzKmlgke
         FG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxGcirAMF6zF7lBflL+4KMDLk6s8LQJ2I/TtWKmifR5dr4Ia68X/vz2K5QDV5zRLWO7KYTtNJozaqPn/b+B9fuLD6szMeG
X-Gm-Message-State: AOJu0Yz2+soDmIo98uqviCLfapYT6hVXuMDk0q7dYH4pRt1yg+La0tMj
	jBQzeAsCnRnBKaLNFPYevK0OZTs3nxpz5ZUSAbPOIJQnU+SpCo0oxzMffHg8KP1p7xxFWHMGJTa
	Tou0welzT3dzjOltPS7lMxqaW483mJzEpxeHFw9mwNh10lrE0iR+hHw==
X-Received: by 2002:a05:600c:3583:b0:412:dc89:20bf with SMTP id p3-20020a05600c358300b00412dc8920bfmr1663587wmq.31.1710318518527;
        Wed, 13 Mar 2024 01:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8l6oQh3yEqUePyp/syuwci7BzNf/i8yVkuZoQAf3jobFm4tncnlrH1XuNeFPmDvaLn3YQVA==
X-Received: by 2002:a05:600c:3583:b0:412:dc89:20bf with SMTP id p3-20020a05600c358300b00412dc8920bfmr1663570wmq.31.1710318518046;
        Wed, 13 Mar 2024 01:28:38 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.210.103])
        by smtp.gmail.com with ESMTPSA id fl21-20020a05600c0b9500b00413320f795fsm1573133wmb.35.2024.03.13.01.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 01:28:37 -0700 (PDT)
Message-ID: <54667115-0286-4d01-9bd9-8ccde3ddefa7@redhat.com>
Date: Wed, 13 Mar 2024 09:28:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] net: openvswitch: Add sample multicasting.
Content-Language: en-US
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 dev@openvswitch.org
Cc: cmi@nvidia.com, yotam.gi@gmail.com, aconole@redhat.com,
 echaudro@redhat.com, horms@kernel.org, Dumitru Ceara <dceara@redhat.com>
References: <20240307151849.394962-1-amorenoz@redhat.com>
 <4dcf82da-c6ad-47c1-8308-3f87820aeb1b@ovn.org>
 <6d4da824-a33f-42ae-88ef-be094f563684@redhat.com>
 <5f522987-994b-4a46-a489-cde796a4a960@ovn.org>
 <83f8aae1-c701-43a6-b91a-2e387e9a865c@ovn.org>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <83f8aae1-c701-43a6-b91a-2e387e9a865c@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/8/24 15:24, Ilya Maximets wrote:
> On 3/7/24 22:29, Ilya Maximets wrote:
>> On 3/7/24 21:59, Adrian Moreno wrote:
>>>
>>>
>>> On 3/7/24 17:54, Ilya Maximets wrote:
>>>> On 3/7/24 16:18, Adrian Moreno wrote:
>>>>> ** Background ** Currently, OVS supports several packet
>>>>> sampling mechanisms (sFlow, per-bridge IPFIX, per-flow IPFIX).
>>>>> These end up being translated into a userspace action that
>>>>> needs to be handled by ovs-vswitchd's handler threads only to
>>>>> be forwarded to some third party application that will somehow
>>>>> process the sample and provide observability on the datapath.
>>>>>
>>>>> The fact that sampled traffic share netlink sockets and
>>>>> handler thread time with upcalls, apart from being a
>>>>> performance bottleneck in the sample extraction itself, can
>>>>> severely compromise the datapath, yielding this solution unfit
>>>>> for highly loaded production systems.
>>>>>
>>>>> Users are left with little options other than guessing what
>>>>> sampling rate will be OK for their traffic pattern and system
>>>>> load and dealing with the lost accuracy.
>>>>>
>>>>> ** Proposal ** In this RFC, I'd like to request feedback on an
>>>>> attempt to fix this situation by adding a flag to the userspace
>>>>> action to indicate the upcall should be sent to a netlink
>>>>> multicast group instead of unicasted to ovs-vswitchd.
>>>>>
>>>>> This would allow for other processes to read samples directly,
>>>>> freeing the netlink sockets and handler threads to process
>>>>> packet upcalls.
>>>>>
>>>>> ** Notes on tc-offloading ** I am aware of the efforts being
>>>>> made to offload the sample action with the help of psample. I
>>>>> did consider using psample to multicast the samples. However, I
>>>>> found a limitation that I'd like to discuss: I would like to
>>>>> support OVN-driven per-flow (IPFIX) sampling because it allows
>>>>> OVN to insert two 32-bit values (obs_domain_id and
>>>>> ovs_point_id) that can be used to enrich the sample with "high
>>>>> level" controller metadata (see debug_drop_domain_id NBDB
>>>>> option in ovn-nb(5)).
>>>>>
>>>>> The existing fields in psample_metadata are not enough to
>>>>> carry this information. Would it be possible to extend this
>>>>> struct to make room for some extra "application-specific"
>>>>> metadata?
>>>>>
>>>>> ** Alternatives ** An alternative approach that I'm
>>>>> considering (apart from using psample as explained above) is to
>>>>> use a brand-new action. This lead to a cleaner separation of
>>>>> concerns with existing userspace action (used for slow paths
>>>>> and OFP_CONTROLLER actions) and cleaner statistics. Also,
>>>>> ovs-vswitchd could more easily make the layout of this new
>>>>> userdata part of the public API, allowing third party sample
>>>>> collectors to decode it.
>>>>>
>>>>> I am currently exploring this alternative but wanted to send
>>>>> the RFC to get some early feedback, guidance or ideas.
>>>>
>>>>
>>>> Hi, Adrian.  Thanks for the patches!
>>>>
>>>
>>> Thanks for the quick feedback. Also adding Dumitru who I missed to
>>> include in the original CC list.
>>>
>>>> Though I'm not sure if broadcasting is generally the best
>>>> approach. These messages contain opaque information that is not
>>>> actually parsable by any other entity than a process that
>>>> created the action. And I don't think the structure of these
>>>> opaque fields should become part of uAPI in neither kernel nor
>>>> OVS in userspace.
>>>>
>>>
>>> I understand this can be cumbersome, specially given the opaque
>>> field is currently also used for some purely-internal OVS actions
>>> (e.g: CONTROLLER).
>>>
>>> However, for features such as OVN-driven per-flow sampling, where
>>> OVN-generated identifiers are placed in obs_domain_id and
>>> obs_point_id, it would be _really_ useful if this opaque value
>>> could be somehow decoded by external programs.
>>>
>>> Two ideas come to mind to try to alleviate the potential
>>> maintainability issues: - As I suggested, using a new action maybe
>>> makes things easier. By splitting the current "user_action_cookie"
>>> in two, one for internal actions and one for "observability"
>>> actions, we could expose the latter in the OVS userspace API
>>> without having to expose the former. - Exposing functions in OVS
>>> that decode the opaque value. Third party applications could link
>>> against, say, libopenvswitch.so and use it to extract
>>> obs_{domain,point}_ids.
>>
>> Linking with OVS libraries is practically the same as just exposing
>> the internal structure, because once the external application is
>> running it either must have the same library version as the process
>> that installs the action, or it may not be able to parse the
>> message.
>>
>> Any form of exposing to an external application will freeze the
>> opaque arguments and effectively make them a form of uAPI.
>>
>> The separate action with a defined uAPI solves this problem by just
>> creating a new uAPI, but I'm not sure why it is needed.
>>
>>>
>>> What do you think?
>>>
>>>> The userspace() action already has a OVS_USERSPACE_ATTR_PID
>>>> argument. And it is not actually used when
>>>> OVS_DP_F_DISPATCH_UPCALL_PER_CPU is enabled.  All known users of
>>>> OVS_DP_F_DISPATCH_UPCALL_PER_CPU are setting the
>>>> OVS_USERSPACE_ATTR_PID to UINT32_MAX, which is not a pid that
>>>> kernel could generate.
>>>>
>>>> So, with a minimal and pretty much backward compatible change in
>>>>   output_userspace() function, we can honor
>>>> OVS_USERSPACE_ATTR_PID if it's not U32_MAX.  This way userspace
>>>> process can open a separate socket and configure sampling to
>>>> redirect all packets there while normal MISS upcalls would still
>>>> arrive to per-cpu sockets.  This should cover the performance
>>>> concern.
>>>>
>>>
>>> Do you mean creating a new thread to process samples or using
>>> handlers? The latter would still have performance impact and the
>>> former would likely fail to process all samples in a timely manner
>>> if there are many.
>>>
>>> Besides, the current userspace tc-offloading series uses netlink
>>> broadcast with psample, can't we do the same for non-offloaded
>>> actions? It enable building external observability applications
>>> without overloading OVS.
>>
>> Creating a separate thread solves the performance issue.  But you can
>> also write a separate application that would communicate its PID to
>> the running OVS daemon.  Let's say the same application that
>> configures sampling in the OVS database can also write a PID there.
>>
>> The thing is that existence of external application immediately
>> breaks opacity of the arguments and forces us to define uAPI.
>> However, if there is an explicit communication between that
>> application and OVS userpsace daemon, then we can establish a
>> contract (structure of opaque values) between these two userspace
>> applications without defining that contract in the kernel uAPI.  But
>> if we're going with multicast, that anyone can subscribe to, then we
>> have to define that contract in the kernel uAPI.
>>
>> Also, in order for this observability to work with userspace datapath
>> we'll have to implement userspace-to-userspace netlink multicast
>> (does that even exist?).  Running the sample collection within OVS as
>> a thread will be much less painful.
>>
>> One other thing worth mentioning is that the PID approach I suggested
>> is just a minor tweak of what is already supported in the kernel.  It
>> doesn't prohibit introduction of a new action or a multicast group in
>> the future.  While premature uAPI definition may end up with another
>> action that nobody uses.  It can be added later if end up being
>> actually necessary.
> 
> Thinking more about this problem, it seems to make some sense to have
> a way to ask OVS for sampling that multiple observers can subscribe to.
> Unicast socket will not allow such functionality.  However, I still don't
> think creation of a new multicast group for that purpose is justified.
> Kernel already has a generic sampling mechanism (psample) with a multicast
> group created specifically for a very similar purpose.  So, instead of
> re-inventing it, we can add a small modification to the OVS'es sampling
> action allowing it to sample to psample instead of OVS'es own unicast
> sockets.  This can be achieved by adding a new OVS_SAMPLE_ATTR that
> would tell to direct packets to psample instead of executing actions.
> Or adding a new OVS_USERSPACE_ATTR that would do the same thing but from
> a userspace() action instead, i.e. direct packets to psample instead of
> OVS'es own sockets copying OVS_PACKET_ATTR_USERDATA into the
> PSAMPLE_ATTR_SAMPLE_GROUP.  Might be cleaner this way, not sure.
> 
> Form a perspective of an OVS userspace daemon, this functionality can
> be clearly exposed as a separate sampling mechanism alongside IPFIX,
> sFlow and NetFlow.
> 
> I see you eluded to this approach in the original cover letter above.
> So, I'd vote for it instead.  Hopefully the psample API can be extended
> to be more flexible and allow larger userdata to be passed in.  Maybe have
> SAMPLE_SUBGROUP in addition to the existing PSAMPLE_ATTR_SAMPLE_GROUP ?
> OTOH, it is not really IPFIX, it's a different interface, so it might have
> different requirements.  In any case OVS may check that userdata fits
> into psample arguments and reject flows that are not compatible.
> 
Thanks for your feedback Ilya.

I'll send an RFC_v2 with the proposed alternative.

>>
>> Best regards, Ilya Maximets.
>>
>>>
>>>
>>>> For the case without per-cpu dispatch, the feature comes for free
>>>> if userspace application wants to use it.  However, there is no
>>>> currently supported version of OVS that doesn't use per-cpu
>>>> dispatch when available.
>>>>> What do you think? Best regards, Ilya Maximets.
>>>>
>>>
>>
> 

-- 
Adrián Moreno


