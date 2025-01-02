Return-Path: <netdev+bounces-154785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F008B9FFCBB
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB0B3A2B46
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96418787F;
	Thu,  2 Jan 2025 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MY/V77Nb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090104D5AB
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839011; cv=none; b=oOIsNuI8NyB6H96cDcLKHTqse89XiBBUxvZbdMMq1puuUBbYNoM3yt5dW+KPRfcxeWAMiNj0eUSTPw2HavILtDumaKlu02iwqFuqC50diaQgEjT+5SD5BTI8w10g1Gmc3Mgpird3BL46aK4mqVr1PnintlMqiivNBgBJkNmlzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839011; c=relaxed/simple;
	bh=8Kk7GOSkPrPKgNii7L1d4PmZHlCtZviKtEnzyEuMiMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HNeA9B4xQfYSMO32e7tG57cmcJyesovIOuyqslQtG1p2bxSSPF7z5SYj2zZ+GQjJsi39lF9KHJuB9T+Wyx4sSbW7N/O2oiGQxwAHQIb3kJneHUneUMp0vtCsL9TLrjo8BVJ8QTjCA6v1EHN46Jd8M4kbFdioe3wK55LCpbUSMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MY/V77Nb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735839007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TF/q1lydKCxtj0HCWn8Jgrh/jkO6xBpGH3h2IRX+HOs=;
	b=MY/V77NbmlPtIr4wAS665xbqngNFLJzpXsPyAhlztXtHotu+yDcdmFv+QbtJ3VfayXCvaO
	9jYtm3FI3vH3fzR85RCfO0vDR7RbMMw7jkJUofIcgvxL4tB0IqsA2YQBBmsD5ShonpTFQC
	7/JFrFKxVFT++jHv+H6T+xFgguqrS20=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-jj-GuX0GPV6z7JOVWlq7IA-1; Thu, 02 Jan 2025 12:30:04 -0500
X-MC-Unique: jj-GuX0GPV6z7JOVWlq7IA-1
X-Mimecast-MFC-AGG-ID: jj-GuX0GPV6z7JOVWlq7IA
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30244e95199so41292651fa.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 09:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735839003; x=1736443803;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF/q1lydKCxtj0HCWn8Jgrh/jkO6xBpGH3h2IRX+HOs=;
        b=WSoigi0Twbji9lDofosjqhw8dqX3wXho9TuiBwdkv/UKahhx5Wh8bbMeNOvdGYP8k+
         woCBsjGQspM9b5VzpmQOe4Wt5K5VJORE6yYVJJzcop5fafaRlmz4uLi2Q768qiabzKpb
         W6Gdx5WWKXis1qfFE16dqXGAfVzfBuejV+Xygrd6Rgbi0ZZ/VpsIjpLF17i3ygwdQug0
         /rl/RUEUHikU/hn0FPcgVGsV91iB5QiB4hIu7DjavzRtFs+nzUP+YEFuxd3D3oswgsIZ
         X00S2gJysDBplVMbr4qkwqp+lWz8P15XZTfXemSMyezmsTwmv9PXqpwyXaxkNiO1mgzR
         YYzA==
X-Forwarded-Encrypted: i=1; AJvYcCXrvt5yr9VFIzRCcrbOe4Z/bnlMGlGNdkhzM2SWwncrFWz1laQHIODMpeVge9TxSBJDW+1I/lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUD7FXE9SyEexQLY9msthxtBkB+eOTL9vyf3nPI6dbTzRWbS0
	e8KYiA34WO8emOpGqw2daL6+WAiNM67NJGtuXM2pnoGmk2GkLXlOl6wG1FvxTJtzWuv7TTS5hik
	9i95/rwvJ31kTQhoqZ8GPGlImP7CHeruMEMpkt5xt++/pvR1tF8E4tQ==
X-Gm-Gg: ASbGncvxuFNfxdnsHlddrz5zdqnvdUAVtjr2RUZE0/sZ2gwwk1rkt7DwMIewTH50wjU
	mOp6JziGMGSXgtpEI2hOJZgPuVxsWkeShZlMRYo0lc5nmv2QLgB+H/noQooQ60qC2SKWPZVmzil
	6XlIyzme4HBloq6Tjh5IKHWSASOBGvW3bPIzg7OuBf4dcb3m1/ehvzk4hqYw9vLW7RDocDtbude
	1TSE+RnXs6TUCdX0YJWuA0uptY8fLRXmDeVRIk5vQjhNr1W/ygIew==
X-Received: by 2002:a05:651c:60d:b0:302:4115:acc with SMTP id 38308e7fff4ca-30468609a8bmr122376121fa.26.1735839002754;
        Thu, 02 Jan 2025 09:30:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq6WTs29dVX+Tc687FHw2WskAzVNvZbLuCxEb5RkRgNHTQ+JdkFHd7PoArSLLGQ+24RDTr/g==
X-Received: by 2002:a05:651c:60d:b0:302:4115:acc with SMTP id 38308e7fff4ca-30468609a8bmr122375981fa.26.1735839002307;
        Thu, 02 Jan 2025 09:30:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6cae6sm43916441fa.23.2025.01.02.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 09:30:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DCA51177D8E2; Thu, 02 Jan 2025 18:29:57 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, ameryhung@gmail.com,
 amery.hung@bytedance.com
Subject: Re: [PATCH bpf-next v2 00/14] bpf qdisc
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 02 Jan 2025 18:29:57 +0100
Message-ID: <874j2h86p6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amery Hung <ameryhung@gmail.com> writes:

> Hi all,
>
> This patchset aims to support implementing qdisc using bpf struct_ops.
> This version takes a step back and only implements the minimum support
> for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
> directly and 2) classful qdisc are deferred to future patchsets.
>
> * Overview *
>
> This series supports implementing qdisc using bpf struct_ops. bpf qdisc
> aims to be a flexible and easy-to-use infrastructure that allows users to
> quickly experiment with different scheduling algorithms/policies. It only
> requires users to implement core qdisc logic using bpf and implements the
> mundane part for them. In addition, the ability to easily communicate
> between qdisc and other components will also bring new opportunities for
> new applications and optimizations.

This is very cool, and I'm thrilled to see this work getting closer to
being merged! :)

> * struct_ops changes *
>
> To make struct_ops works better with bpf qdisc, two new changes are
> introduced to bpf specifically for struct_ops programs. Frist, we
> introduce "__ref" postfix for arguments in stub functions in patch 1-2.
> It allows Qdisc_ops->enqueue to acquire an unique referenced kptr to the
> skb argument. Through the reference object tracking mechanism in
> the verifier, we can make sure that the acquired skb will be either
> enqueued or dropped. Besides, no duplicate references can be acquired.
> Then, we allow a referenced kptr to be returned from struct_ops programs
> so that we can return an skb naturally. This is done and tested in patch 3
> and 4.
>
> * Performance of bpf qdisc *
>
> We tested several bpf qdiscs included in the selftests and their in-tree
> counterparts to give you a sense of the performance of qdisc implemented
> in bpf.
>
> The implementation of bpf_fq is fairly complex and slightly different from
> fq so later we only compare the two fifo qdiscs. bpf_fq implements the
> same fair queueing algorithm in fq, but without flow hash collision
> avoidance and garbage collection of inactive flows. bpf_fifo uses a single
> bpf_list as a queue instead of three queues for different priorities in
> pfifo_fast. The time complexity of fifo however should be similar since t=
he
> queue selection time is negligible.
>
> Test setup:
>
>     client -> qdisc ------------->  server
>     ~~~~~~~~~~~~~~~                 ~~~~~~
>     nested VM1 @ DC1               VM2 @ DC2
>
> Throghput: iperf3 -t 600, 5 times
>
>       Qdisc        Average (GBits/sec)
>     ----------     -------------------
>     pfifo_fast       12.52 =C2=B1 0.26
>     bpf_fifo         11.72 =C2=B1 0.32=20
>     fq               10.24 =C2=B1 0.13
>     bpf_fq           11.92 =C2=B1 0.64=20
>
> Latency: sockperf pp --tcp -t 600, 5 times
>
>       Qdisc        Average (usec)
>     ----------     --------------
>     pfifo_fast      244.58 =C2=B1 7.93
>     bpf_fifo        244.92 =C2=B1 15.22
>     fq              234.30 =C2=B1 19.25
>     bpf_fq          221.34 =C2=B1 10.76
>
> Looking at the two fifo qdiscs, the 6.4% drop in throughput in the bpf
> implementatioin is consistent with previous observation (v8 throughput
> test on a loopback device). This should be able to be mitigated by
> supporting adding skb to bpf_list or bpf_rbtree directly in the future.

This looks pretty decent!

> * Clean up skb in bpf qdisc during reset *
>
> The current implementation relies on bpf qdisc implementors to correctly
> release skbs in queues (bpf graphs or maps) in .reset, which might not be
> a safe thing to do. The solution as Martin has suggested would be
> supporting private data in struct_ops. This can also help simplifying
> implementation of qdisc that works with mq. For examples, qdiscs in the
> selftest mostly use global data. Therefore, even if user add multiple
> qdisc instances under mq, they would still share the same queue.

So is the plan to fix this before merging this series? Seems like a bit
of a footgun, otherwise?

-Toke


