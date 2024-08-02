Return-Path: <netdev+bounces-115366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0367945FF8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221311F22376
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F172139C6;
	Fri,  2 Aug 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au07IGP0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B241F61C;
	Fri,  2 Aug 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611408; cv=none; b=qR4kocww/lLT32oavcq7JFSpwKJVjOGK1cf7ZWS2+vsiRQpTh4c7Xtzcw6ohQvDhSMLoTFs7QRrkGraePfbyHE0RoCkKE15JWT5WIjgxbLUWfxcIqQBd20FadoI0XXYTq8CRLagRzJorOdZbm8I1aLSPZmElu9OwfD16w2RcY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611408; c=relaxed/simple;
	bh=IfNM+QO/+PjFZA84YhQinaelbJX1lTLsg9VSmGPn1zc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Gzb+D/6PIsnBLCgab8i44hanb7eG140mUEGq+ckNyagoS+xsLIMOK1g8IRDQB5AaSWOeLvbp1eMJbYEex0rM7OwBwkVnxClG8/aaCNt1MD8TURLHCJ788p+u2jnYue6LYqFmUtiSvIYHzf8c4Mn5b0XwnGGyBgF7RXStfkIqQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au07IGP0; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1dcba8142so264286385a.0;
        Fri, 02 Aug 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722611405; x=1723216205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itTIvKFFbaEZAKIq5fv6plZCT4LzD63fbNT0L7bv9dk=;
        b=au07IGP0a/HryQ6PYzLCf22yG7krqlGc1ug/IUeQgT3rgXw2EuwkPPrqpmfHRU1dWA
         Gqt+qGklqYvAtHlt3joYQ0WD80wsdd7eT9+MAobHKKWDgQxmTn52Yv/qDeTlLnf9ZgWy
         W8V6atnemV095o9T9IvvO7Zcj0hiwol3ND85P9Neo54hWvWAW/yIgKFhkcf52oRGmAFR
         oLKeX4YxBKEDKpLr5rnqdTehhru/VSiNnSlRFLPGO+JrvK8w68IiHnfjs4E7P8z0ovxp
         1KxQjommUVL92dd/8bzTJMv3uzNGbWvfb0KsnKfsFDstp4utB2hxp+vipDbckNIyvJWb
         ci2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611405; x=1723216205;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=itTIvKFFbaEZAKIq5fv6plZCT4LzD63fbNT0L7bv9dk=;
        b=p//IAIaBNdZg4DSuQdwThiP9NYigyfaYqfm9vwHgiCQXrceEETWUQTYAYMF/EEgwpW
         IMfsCgVrE5O8Ip4eMj6QC/HcJWg5llrK+ObRIeo7L1RwX0ojqrZ2Nuaw3kRI6T2X4x59
         X5QXZ3OtIaZVpWD2uhxDH8BZ4jFoxvmPHVHMOl4iZmhD9dkh2Hnq/RglpTW86KXAFaUR
         zVB74Q6wN3Z6Y2OGuWWnhrOsKH8FhRUkfd/gz9o3wgM7KxdvYHHumtQKbe3rAq/MCz+Q
         QqDwMDruwIeP9JwYW05wyZFemutmo4uiMnSTa2Hm+l07m6w1pu6KECS/ncwAjxJA1xCc
         PTAA==
X-Forwarded-Encrypted: i=1; AJvYcCV3+3FlZB0xV1GzngpLIPRHdZOv5sAKoEioMmkap+NmYIwH0c0geWhs8va1yuff0xPVeMnmvrJ0qolrwgxrtCHo53czdgRC6cNBHDKj
X-Gm-Message-State: AOJu0YwYx8FaRNmptPGPCF5jax8AmpojumnFH1+BJXHNMDYwbhOOl+Ke
	i4APTPnDdt1uyqREzK3zjYlWDk3h9tiUVnZYCgEJqc5Hvb+u/wY8
X-Google-Smtp-Source: AGHT+IGa61AmvCfVehqQ/w4HGLjWv3qX9t63JCR/CgUjZoGEOuwx2lscWRWlBnttZptMI8Kv0DxYaA==
X-Received: by 2002:a05:620a:2685:b0:79c:1178:dc9d with SMTP id af79cd13be357-7a34efde579mr630165185a.24.1722611405456;
        Fri, 02 Aug 2024 08:10:05 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6fb790sm92365485a.54.2024.08.02.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:10:04 -0700 (PDT)
Date: Fri, 02 Aug 2024 11:10:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Randy Li <ayaka@soulik.info>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org
Message-ID: <66acf6cc551a0_2751b6294bf@willemb.c.googlers.com.notmuch>
In-Reply-To: <328c71e7-17c7-40f4-83b3-f0b8b40f4730@soulik.info>
References: <20240731111940.8383-1-ayaka@soulik.info>
 <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
 <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info>
 <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
 <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info>
 <66ab87ca67229_2441da294a5@willemb.c.googlers.com.notmuch>
 <343bab39-65c5-4f02-934b-84b6ceed1c20@soulik.info>
 <66ab99162673_246b0d29496@willemb.c.googlers.com.notmuch>
 <328c71e7-17c7-40f4-83b3-f0b8b40f4730@soulik.info>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Li wrote:
> =

> On 2024/8/1 22:17, Willem de Bruijn wrote:
> > Randy Li wrote:
> >> On 2024/8/1 21:04, Willem de Bruijn wrote:
> >>> Randy Li wrote:
> >>>> On 2024/8/1 05:57, Willem de Bruijn wrote:
> >>>>> nits:
> >>>>>
> >>>>> - INDX->INDEX. It's correct in the code
> >>>>> - prefix networking patches with the target tree: PATCH net-next
> >>>> I see.
> >>>>> Randy Li wrote:
> >>>>>> On 2024/7/31 22:12, Willem de Bruijn wrote:
> >>>>>>> Randy Li wrote:
> >>>>>>>> We need the queue index in qdisc mapping rule. There is no way=
 to
> >>>>>>>> fetch that.
> >>>>>>> In which command exactly?
> >>>>>> That is for sch_multiq, here is an example
> >>>>>>
> >>>>>> tc qdisc add dev=C2=A0 tun0 root handle 1: multiq
> >>>>>>
> >>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip=
 dst
> >>>>>> 172.16.10.1 action skbedit queue_mapping 0
> >>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip=
 dst
> >>>>>> 172.16.10.20 action skbedit queue_mapping 1
> >>>>>>
> >>>>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip=
 dst
> >>>>>> 172.16.10.10 action skbedit queue_mapping 2
> >>>>> If using an IFF_MULTI_QUEUE tun device, packets are automatically=

> >>>>> load balanced across the multiple queues, in tun_select_queue.
> >>>>>
> >>>>> If you want more explicit queue selection than by rxhash, tun
> >>>>> supports TUNSETSTEERINGEBPF.
> >>>> I know this eBPF thing. But I am newbie to eBPF as well I didn't f=
igure
> >>>> out how to config eBPF dynamically.
> >>> Lack of experience with an existing interface is insufficient reaso=
n
> >>> to introduce another interface, of course.
> >> tc(8) was old interfaces but doesn't have the sufficient info here t=
o
> >> complete its work.
> > tc is maintained.
> >
> >> I think eBPF didn't work in all the platforms? JIT doesn't sound lik=
e a
> >> good solution for embeded platform.
> >>
> >> Some VPS providers doesn't offer new enough kernel supporting eBPF i=
s
> >> another problem here, it is far more easy that just patching an old
> >> kernel with this.
> > We don't add duplicative features because they are easier to
> > cherry-pick to old kernels.
> I was trying to say the tc(8) or netlink solution sound more suitable =

> for general deploying.
> >> Anyway, I would learn into it while I would still send out the v2 of=

> >> this patch. I would figure out whether eBPF could solve all the prob=
lem
> >> here.
> > Most importantly, why do you need a fixed mapping of IP address to
> > queue? Can you explain why relying on the standard rx_hash based
> > mapping is not sufficient for your workload?
> =

> Server
> =

>  =C2=A0 |
> =

>  =C2=A0 |------ tun subnet (e.x. 172.16.10.0/24) ------- peer A (172.16=
.10.1)
> =

> |------ peer B (172.16.10.3)
> =

> |------=C2=A0 peer C (172.16.10.20)
> =

> I am not even sure the rx_hash could work here, the server here acts as=
 =

> a router or gateway, I don't know how to filter the connection from the=
 =

> external interface based on rx_hash. Besides, VPN application didn't =

> operate on the socket() itself.
> =

> I think this question is about why I do the filter in the kernel not th=
e =

> userspace?
> =

> It would be much more easy to the dispatch work in kernel, I only need =

> to watch the established peer with the help of epoll(). Kernel could =

> drop all the unwanted packets. Besides, if I do the filter/dispatcher =

> work in the userspace, it would need to copy the packet's data to the =

> userspace first, even decide its fate by reading a few bytes from its =

> beginning offset. I think we can avoid such a cost.

A custom mapping function is exactly the purpose of TUNSETSTEERINGEBPF.

Please take a look at that. It's a lot more elegant than going through
userspace and then inserting individual tc skbedit filters.


