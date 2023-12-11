Return-Path: <netdev+bounces-55943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54B80CECE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64155280E09
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D54A984;
	Mon, 11 Dec 2023 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf/EzOQk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E75D1
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702306840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj2Hb5RgkNgGJGhAYgsKKuf9w/lw3IuQdz5F/3+z1O8=;
	b=Rf/EzOQkzeq3t3agbXLfiBVdGvxgKgI2N+owEeMGk0FpzUbmmaXaC0wZzcBWh/w39KU09X
	+68mmGNfycOSus5fWEAaQFAp/fh7D6Kz+F8JkQsJUPXIHxkuTOatGMNtmNExgsrHSoHRA3
	+O2AfvCKCJk2lcxYTeNc+z7POhvzyzo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-sxM45pfENu-SnPEQza41Zg-1; Mon, 11 Dec 2023 10:00:06 -0500
X-MC-Unique: sxM45pfENu-SnPEQza41Zg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1e88d2d7faso244460966b.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306805; x=1702911605;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj2Hb5RgkNgGJGhAYgsKKuf9w/lw3IuQdz5F/3+z1O8=;
        b=YoTbsTdDqhB1OuRlFVyTZRS5Pe5QnF6GSy7p6XtQYCzqqzhtK4Cs77dtmRAnAEuzRs
         zndvV1WorpnV1sjW9cNQXYk3a/GnrCglRvP2h0R5yC/tL8f3OMF35tV8QOT07nFW+yrY
         6nBnkf8qVpMHHcJQMI7OxxxTzABwuEWVWFoR728HfrVueOJeWsa5P9GrsC+LucuDr9E3
         NztVffVIZCSkFBKtYeVL955unmCtRewMgW7WBGyA5WEK7WHKRL0bG6DDBYHy45TQWf0p
         9Ry1Rs75reLlU+Kp+AJfzjlOe271XJdABiBzy5FZkJeatjcRmE2TsAYscuHYXrfohc/4
         R/oA==
X-Gm-Message-State: AOJu0YxD+C56A59NVhdlLSV+i4w0iCn5/rK3MAUM6Y686xgqUa8UE7tv
	w0B6lvarsPCJ7pimXnigitBH6z/r+gCJlPiSUSbaurLfBH8R1BqCdn6W39al0lHIQMmmXwGcSn3
	n5NTa8bCW1z4lvCxA
X-Received: by 2002:a17:906:491b:b0:9fd:8cd9:7842 with SMTP id b27-20020a170906491b00b009fd8cd97842mr2236323ejq.44.1702306805100;
        Mon, 11 Dec 2023 07:00:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4yiDiIkux5IHFUI4jYHybyJllFVaw16QvCvm8uMobyF2BQE1z4ML85w+lSdSzjbKYNVIR1A==
X-Received: by 2002:a17:906:491b:b0:9fd:8cd9:7842 with SMTP id b27-20020a170906491b00b009fd8cd97842mr2236312ejq.44.1702306804734;
        Mon, 11 Dec 2023 07:00:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cu3-20020a170906ba8300b00a1d818ebcadsm5004652ejd.19.2023.12.11.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:00:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D2E34FE660C; Mon, 11 Dec 2023 16:00:03 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
 khalidm@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net-next v9 14/15] p4tc: add set of P4TC table kfuncs
In-Reply-To: <335fbd65-585d-47b8-a98f-c0898aff7d7f@linux.dev>
References: <20231201182904.532825-1-jhs@mojatatu.com>
 <20231201182904.532825-15-jhs@mojatatu.com>
 <8faf1308-2f9f-4923-804e-8d9b11ba74e0@linux.dev> <87lea5j8ys.fsf@toke.dk>
 <335fbd65-585d-47b8-a98f-c0898aff7d7f@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Dec 2023 16:00:03 +0100
Message-ID: <87plzc239o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 12/8/23 2:15 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Martin KaFai Lau <martin.lau@linux.dev> writes:
>>=20
>>> On 12/1/23 10:29 AM, Jamal Hadi Salim wrote:
>>>> We add an initial set of kfuncs to allow interactions from eBPF progra=
ms
>>>> to the P4TC domain.
>>>>
>>>> - bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
>>>> program installed in TC. To find the table entry we take in an skb, the
>>>> pipeline ID, the table ID, a key and a key size.
>>>> We use the skb to get the network namespace structure where all the
>>>> pipelines are stored. After that we use the pipeline ID and the table
>>>> ID, to find the table. We then use the key to search for the entry.
>>>> We return an entry on success and NULL on failure.
>>>>
>>>> - xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
>>>> program installed in XDP. To find the table entry we take in an xdp_md,
>>>> the pipeline ID, the table ID, a key and a key size.
>>>> We use struct xdp_md to get the network namespace structure where all
>>>> the pipelines are stored. After that we use the pipeline ID and the ta=
ble
>>>> ID, to find the table. We then use the key to search for the entry.
>>>> We return an entry on success and NULL on failure.
>>>>
>>>> - bpf_p4tc_entry_create: Used to create a table entry from a BPF
>>>> program installed in TC. To create the table entry we take an skb, the
>>>> pipeline ID, the table ID, a key and its size, and an action which will
>>>> be associated with the new entry.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - xdp_p4tc_entry_create: Used to create a table entry from a BPF
>>>> program installed in XDP. To create the table entry we take an xdp_md,=
 the
>>>> pipeline ID, the table ID, a key and its size, and an action which will
>>>> be associated with the new entry.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
>>>> First does a lookup using the passed key and upon a miss will add the =
entry
>>>> to the table.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
>>>> First does a lookup using the passed key and upon a miss will add the =
entry
>>>> to the table.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - bpf_p4tc_entry_update: Used to update a table entry from a BPF
>>>> program installed in TC. To update the table entry we take an skb, the
>>>> pipeline ID, the table ID, a key and its size, and an action which will
>>>> be associated with the new entry.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - xdp_p4tc_entry_update: Used to update a table entry from a BPF
>>>> program installed in XDP. To update the table entry we take an xdp_md,=
 the
>>>> pipeline ID, the table ID, a key and its size, and an action which will
>>>> be associated with the new entry.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
>>>> program installed in TC. To delete the table entry we take an skb, the
>>>> pipeline ID, the table ID, a key and a key size.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
>>>> program installed in XDP. To delete the table entry we take an xdp_md,=
 the
>>>> pipeline ID, the table ID, a key and a key size.
>>>> We return 0 on success and a negative errno on failure
>>>
>>> [ ... ]
>>>
>>>> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
>>>> +BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
>>>
>>> These create/read/update/delete kfuncs are like defining a new hidden b=
pf map
>>> type in the kernel. bpf prog can now create its own link-list and rbtre=
e.
>>> sched_ext has already been using it. This is the way the bpf prog shoul=
d use
>>> instead of creating a new map type.
>>=20
>> I don't really think this is an accurate assessment, given Jamal's use
>> case. These kfuncs are more akin to the FIB lookup helper, or the
>> netfilter kfuncs: they provide lookup into a kernel-internal data
>> structure, so that BPF can access that data structure while staying in
>> sync with the rest of the kernel.
>>=20
>> If this was a BPF-only implementation you'd be right, but given the
>> constraint of having the P4 objects represented in the kernel[0], I
>> think this is a perfectly reasonable use of kfuncs, even though they
>> happen to look like the map API.
>>=20
>> -Toke
>>=20
>> [0] Whether having those objects represented at all is reasonable is a
>> separate discussion, which I believe John et al are having with Jamal in
>> a separate subthread. I don't personally have any strong objections to
>> doing that.
>
> I might not be clear. It was my question on why it has to be in the kerne=
l=20
> instead of in the bpf map, so the earlier bpf link-list and rbtree exampl=
e just=20
> in case this recent bpf capability has not been considered.

A bit tangential, but it came to mind while thinking about this: how
would one go about updating a bpf rbtree-based data structure from
userspace? Is there a way to get bpf_map_update()-semantics that inserts
things into the rbtree somehow?

> If it is an existing kernel infra-structure, kfunc is a reasonable use.
>
> The P4 objects are newly added to this set with bpf program as its user. =
It can=20
> be represented in the bpf map as well instead of in the kernel.
>
> or is it fair to say that bpf prog is not the primary consumer of the P4=
=20
> objects. Instead kernel is the primary user of the p4 objects such that p=
4tc can=20
> work independently without the bpf piece to begin with and bpf could be=20
> considered as an extension later?

That's a good question, actually. I think that conceptually, if viewed
purely as a control plane, it could be merged separately and the BPF
support added later. But with this series, that would make it a control
plane that doesn't really control anything; so there would need to be a
second consumer (hardware offload?) added for that to make sense, I
suppose.

Or to put it another way, the way this series is designed, there is an
implicit "these are kernel objects that we want to use for other things"
assumption in there; it's just that those "other things" are not part
of this series (because hardware offload doesn't exist yet - I think?
I'll let Jamal answer that). I can see the point of asking for that
second user, though, as that would make it clear why the control plane
needs to be in the kernel.

-Toke


