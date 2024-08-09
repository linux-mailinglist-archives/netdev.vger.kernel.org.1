Return-Path: <netdev+bounces-117228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D1194D2BA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6601C20A45
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DD1917F7;
	Fri,  9 Aug 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsytI1Hw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709119882B;
	Fri,  9 Aug 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215352; cv=none; b=V6PnVcvfhKdCPxQFQnLZB4ePW4k66LfMj1A5sPhMpc3WJ/smQ7yceggPVb7G1hNKHMfC6bfic6iFK4H5Rm1M+JAXlLmk02Go8aJuCdwC8ZvlLjnu6rkEvM4UKxeiCq/abJiu+HFdKqthTMM0bmhkLQlSjd3i2v5E2U305vbIzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215352; c=relaxed/simple;
	bh=tPUO0gSbPtXJ0sAM1pkwK/+HTJWy39EXKkCz2GP5d5w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RIspRMaqP410oSV5YMukRPiVI60AvgONUvtS8BYVUiEwOlX02xBJPBaTnxa7WlXQ7GPJdQA0tmppOPOypG4h+A5tLtV1uWqoXIn6zQhV4ObbrUxpNb9bMZW6S6xgFJQz5vvbu/syF+BzPiFn1jqUsLonTCjI/P9LMgkTWoHvrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsytI1Hw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d0ad7113so139501485a.2;
        Fri, 09 Aug 2024 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723215350; x=1723820150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QH7z92pUkHt0mpAhh54mBWb79iy9O2bhMxGC+WnZYTw=;
        b=VsytI1HwYAHHO0cpbZa1BEh2CQJaiU5lpNHKXYL4JFRy1yfPW9CLBg4Fh4rE42z8DH
         F3DiIFjX9A3AabxNCrmVusPNQdUiaOf44gXZr3sVe64JrlZ+YsLLRjZSygUtjdrloTAK
         WawE5wleg7S1xxUtZSe75hgRGZd3HAtfaUC+Lrhj3FPBwL68i36gKOb7hzovpCD2aHyz
         b0Rm/L0/GgPhPEvgmcT+8/Jz3B029tv7FhO4e1ziVmxcHMIGYGnqqSfLK0GlcmEkrOxB
         5Vtyt9bG0bvl6ySziN9ugbSt/C1deen+z5gAQdctcigS+QQoSjLfRUj/mq7aAykWbwmm
         kFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723215350; x=1723820150;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QH7z92pUkHt0mpAhh54mBWb79iy9O2bhMxGC+WnZYTw=;
        b=b/g6tkUDd5yeTCuh4hqyaMAfbeoc4bRvozVrHNSpAXwIm1QCM3rKS+AytoYiOc0eyL
         Syvbp/vszN8wfpgDfONakNZnZhswgTpOkGRvYq8OeDKWzNXjHvZgZMut5Atmnixq4zo6
         qeG4SgoBnA0io/S54nSy0ojqx1xX3X0UWdEHjy+xSCW92iohuJwIK47n0fwxxr+Nehxo
         k58nIZpskvbOG1c9MqA7ECix6Ueygq6f2dB8hqXZ9xRzwNHGBIQYMGkE/Kw1+fdL29LB
         gC1LDcc7TInH1ooLUFkgEyw5EzHtcL41een81hSzzoLbeMVgbIUjEmnAcCphZP47Q3Wo
         XQkw==
X-Forwarded-Encrypted: i=1; AJvYcCXBKWExgl+4gQM2tW6bM34G8HgVNGHD1fXfSZ4DZlJyUnzYy1LV+UB0zwrLeilj+C22G6EOGa/ZntbtITIObso8sZz/Xxlv37ZdtgAcPuKlbJgqESBVcX+Co2Rz7S/QmbRpwuJ4
X-Gm-Message-State: AOJu0YwNWNQCk4BOulyIL2jct2jEjKCYSTWWF0U+xpzxDGZFJd5Eg7iH
	meXOINf/N9NPOMNqEHZ3e4pMEc/wrpoYb6l8B9/j7aTfyVOVoBhq
X-Google-Smtp-Source: AGHT+IHiwVa4/MTMbZQ2SkbfT0687tkmrRhpv64fhPdLfxq/2mAKh7NyMMWFAREcdg3Svmb4p/xe3Q==
X-Received: by 2002:a05:620a:29c4:b0:7a2:c2a:c9f8 with SMTP id af79cd13be357-7a4c17e18e3mr193266085a.1.1723215349522;
        Fri, 09 Aug 2024 07:55:49 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786fec1esm265780785a.134.2024.08.09.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:55:48 -0700 (PDT)
Date: Fri, 09 Aug 2024 10:55:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: ayaka <ayaka@soulik.info>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org
Message-ID: <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
In-Reply-To: <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info>
References: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
 <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info>
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

ayaka wrote:
> =

> Sent from my iPad

Try to avoid ^^^
 =

> > On Aug 9, 2024, at 2:49=E2=80=AFAM, Willem de Bruijn <willemdebruijn.=
kernel@gmail.com> wrote:
> > =

> > =EF=BB=BF
> >> =

> >>> So I guess an application that owns all the queues could keep track=
 of
> >>> the queue-id to FD mapping. But it is not trivial, nor defined ABI
> >>> behavior.
> >>> =

> >>> Querying the queue_id as in the proposed patch might not solve the
> >>> challenge, though. Since an FD's queue-id may change simply because=

> >> Yes, when I asked about those eBPF thing, I thought I don=E2=80=99t =
need the queue id in those ebpf. It turns out a misunderstanding.
> >> Do we all agree that no matter which filter or steering method we us=
ed here, we need a method to query queue index assigned with a fd?
> > =

> > That depends how you intend to use it. And in particular how to work
> > around the issue of IDs not being stable. Without solving that, it
> > seems like an impractical and even dangerous -because easy to misuse-=

> > interface.
> > =

> First of all, I need to figure out when the steering action happens.
> When I use multiq qdisc with skbedit, does it happens after the net_dev=
ice_ops->ndo_select_queue() ?
> If it did, that will still generate unused rxhash and txhash and flow t=
racking. It sounds a big overhead.
> Is it the same path for tc-bpf solution ?

TC egress is called early in __dev_queue_xmit, the main entry point for
transmission, in sch_handle_egress.

A few lines below netdev_core_pick_tx selects the txq by setting
skb->queue_mapping. Either through netdev_pick_tx or through a device
specific callback ndo_select_queue if it exists.

For tun, tun_select_queue implements that callback. If
TUNSETSTEERINGEBPF is configured, then the BPF program is called. Else
it uses its own rx_hash based approach in tun_automq_select_queue.

There is a special case in between. If TC egress ran skbedit, then
this sets current->net_xmit.skip_txqueue. Which will read the txq
from the skb->queue_mapping set by skbedit, and skip netdev_pick_tx.

That seems more roundabout than I had expected. I thought the code
would just check whether skb->queue_mapping is set and if so skip
netdev_pick_tx.

I wonder if this now means that setting queue_mapping with any other
TC action than skbedit now gets ignored. Importantly, cls_bpf or
act_bpf.

> I would reply with my concern about violating IDs in your last question=
.
> >>> another queue was detached. So this would have to be queried on eac=
h
> >>> detach.
> >>> =

> >> Thank you Jason. That is why I mentioned I may need to submit anothe=
r patch to bind the queue index with a flow.
> >> =

> >> I think here is a good chance to discuss about this.
> >> I think from the design, the number of queue was a fixed number in t=
hose hardware devices? Also for those remote processor type wireless devi=
ce(I think those are the modem devices).
> >> The way invoked with hash in every packet could consume lots of CPU =
times. And it is not necessary to track every packet.
> > =

> > rxhash based steering is common. There needs to be a strong(er) reaso=
n
> > to implement an alternative.
> > =

> I have a few questions about this hash steering, which didn=E2=80=99t r=
equest any future filter invoked:
> 1. If a flow happens before wrote to the tun, how to filter it?

What do you mean?

> 2. Does such a hash operation happen to every packet passing through?

For packets with a local socket, the computation is cached in the
socket.

For these tunnel packets, see tun_automq_select_queue. Specifically,
the call to __skb_get_hash_symmetric.

I'm actually not entirely sure why tun has this, rather than defer
to netdev_pick_tx, which call skb_tx_hash.

> 3. Is rxhash based on the flow tracking record in the tun driver?
> Those CPU overhead may demolish the benefit of the multiple queues and =
filters in the kernel solution.

Keyword is "may". Avoid premature optimization in favor of data.

> Also the flow tracking has a limited to 4096 or 1024, for a IPv4 /24 su=
bnet, if everyone opened 16 websites, are we run out of memory before som=
e entries expired?
> =

> I want to  seek there is a modern way to implement VPN in Linux after s=
o many features has been introduced to Linux. So far, I don=E2=80=99t fin=
d a proper way to make any advantage here than other platforms.
> >> Could I add another property in struct tun_file and steering program=
 return wanted value. Then it is application=E2=80=99s work to keep this =
new property unique.
> > =

> > I don't entirely follow this suggestion?
> > =

> >>> I suppose one underlying question is how important is the mapping o=
f
> >>> flows to specific queue-id's? Is it a problem if the destination qu=
eue
> >>> for a flow changes mid-stream?
> >> Yes, it matters. Or why I want to use this feature. From all the ope=
n source VPN I know, neither enabled this multiqueu feature nor create mo=
re than one queue for it.
> >> And virtual machine would use the tap at the most time(they want to =
emulate a real nic).
> >> So basically this multiple queue feature was kind of useless for the=
 VPN usage.
> >> If the filter can=E2=80=99t work atomically here, which would lead t=
o unwanted packets transmitted to the wrong thread.
> > =

> > What exactly is the issue if a flow migrates from one queue to
> > another? There may be some OOO arrival. But these configuration
> > changes are rare events.
> I don=E2=80=99t know what the OOO means here.

Out of order.

> If a flow would migrate from its supposed queue to another, that was ag=
ainst the pretension to use the multiple queues here.
> A queue presents a VPN node here. It means it would leak one=E2=80=99s =
data to the other.
> Also those data could be just garbage fragments costs bandwidth sending=
 to a peer that can=E2=80=99t handle it.

MultiQ is normally just a scalability optimization. It does not matter
for correctness, bar the possibility of brief packet reordering when a
flow switches queues.

I now get that what you are trying to do is set up a 1:1 relationship
between VPN connections and multi queue tun FDs. What would be reading
these FDs? If a single process, then it can definitely handle flow
migration.


