Return-Path: <netdev+bounces-213557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F24B25A0F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 05:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F565C1002
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 03:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDE27472;
	Thu, 14 Aug 2025 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYfFWPb5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34286341AA
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143120; cv=none; b=aDHuwSmUHp3XlwbOux9gDot2f7vPzV8nJZy7QmggmBgGKwyFzedM4B4X53Rvlr1wH7Sncyt7Fn+1vyBQfbd8JCrH7qqg9caNAaJMtcCXCOzeGOHSl2tM/4i5+mAGgRybvAJgqqq7y0DtCLVshjZdTE4EvWs6peuZiBMZ39xVRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143120; c=relaxed/simple;
	bh=HEFxZCdmPNUTtFK9GLyl4nh27t1IANja+kEPJSSZWSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvdWFgK1roCIBz7PyHB/J1VUuMc3qGm3SbEotOtx1h/TCvweVs6YZIFIQTZ3ZopGc4wHs46cFlJCfRnAXUsWBb/jaoMbbZHrz9tM2L7CX3iRjr84mWmodBYx6BK4pWZ7NWt4NKkJGGXJ0hm3l6f8oOmMN8CRqSCX1iKuFkBgUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYfFWPb5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755143117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEFxZCdmPNUTtFK9GLyl4nh27t1IANja+kEPJSSZWSo=;
	b=JYfFWPb5AF9nc5BBHv3+FRqo20gJPrcYTDTQDGePiNXwBISXynItz91gHLmIEyMxT4KS+G
	kbJzbdW+w+doBB8OORoYhMqmMzcC8GVi5/C57I1BkJ5KzlclwLVzHq8gEBsUCs0UZqVlRT
	ElQbmE0yajcbLKrWxf9Y2SaKr0B6gKg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-ao1YCpAmOZeqF3fu0JbREQ-1; Wed, 13 Aug 2025 23:45:15 -0400
X-MC-Unique: ao1YCpAmOZeqF3fu0JbREQ-1
X-Mimecast-MFC-AGG-ID: ao1YCpAmOZeqF3fu0JbREQ_1755143115
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-323266c83f6so578383a91.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 20:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143115; x=1755747915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEFxZCdmPNUTtFK9GLyl4nh27t1IANja+kEPJSSZWSo=;
        b=cLUQxHfUks7WslejSze32pMXqeeaKhwC/YVcdoPSgRTu4N/spsbdIcNiarEbMe/bG6
         +4wzJUHEpbG9Uf8pli+OnudJNJe6attsXbaq+4b1jVpP7LiryHW9jcPDe2YkxtOvhXss
         c8/T86gWFg68MNTffIziSPfMOz3Q2IGKDZSnbwXc+7p5P69kaPxN7gQYerKliX/A3LBw
         8LcoC0cISJQ6V+K6CLxFixAW6tRFTKAM+R+lltNlOiWp4BJtZq7zZbCWa7RRDBNhgBjf
         XQzK6RFrOYxAvRyf4kZfcuD360gMQXr6lu2lfqu1NpY8DCEpUyumO50j9jkS5Cnd7rtS
         rAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXibWm3mA5a04WrMKha55ZdHKmJEGpbXATpbshCdQqz6Ho2EL1Pg0K7N+GnlfVmlO+8ibZOIxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2PIohWCzpxkYBZfbQHyd5a45llEQdVpmGMTwfv7clTc7hxES
	3k8zZrEMg8s4DVEfCpNsr/uCK/aAnDVE3tPmxOaHoa5uIz/XuG8S77eTGz0yh3GSwbX79k12C1h
	z1cVjynY0BLOkgO3gZvaxTCm7xXSk1sJYnQQwVWHMe78a6X2QUm899vHIg494Yh7vgG8smXJLWA
	kdq+w6D7C8RYALoecV91cw0mMQOdFKEBw5
X-Gm-Gg: ASbGncsV/We5MbBCbuyPCsOcMeleVCusH/vlIKeHMjY/XjsZrLBMpqWvXgq7N5yXxwE
	bY0VcR/OKhGPunQsJBrRf4wTG4pDWxRV3MTVMhxpUAtCgmLMEc+EsyNvxK/QyjQaJwJZivnHDxW
	ZiJ0KbKkLb+xmi6Q57hVlyWA==
X-Received: by 2002:a17:90b:28c7:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-32329a93c47mr1698780a91.8.1755143114526;
        Wed, 13 Aug 2025 20:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHMwt839N3z6leC/l1YzMWGrwQTGofoHM0NhKS6XdAKNfDOijgt2m/36OWbFhBvWmDfOOtBuLc3dGPCcmvE8E=
X-Received: by 2002:a17:90b:28c7:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-32329a93c47mr1698731a91.8.1755143113855; Wed, 13 Aug 2025
 20:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
 <20250813080128.5c024489@hermes.local> <4fca87fe-f56a-419d-84ba-6897ee9f48f5@tu-dortmund.de>
In-Reply-To: <4fca87fe-f56a-419d-84ba-6897ee9f48f5@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 11:45:02 +0800
X-Gm-Features: Ac12FXxwzYuMWGY2PNwM-4hrjDiitx1WQVz6IkwY8Ovb-WwtEEuCFnm4hgULEVs
Message-ID: <CACGkMEss33CcmYvBRa7kyfWEYwnm6xn6_tBo81y9X20yyrPKoQ@mail.gmail.com>
Subject: Re: [PATCH net v2] TUN/TAP: Improving throughput and latency by
 avoiding SKB drops
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, willemdebruijn.kernel@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:34=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Stephen Hemminger wrote:
> > On Tue, 12 Aug 2025 00:03:48 +0200
> > Simon Schippers <simon.schippers@tu-dortmund.de> wrote:
> >
> >> This patch is the result of our paper with the title "The NODROP Patch=
:
> >> Hardening Secure Networking for Real-time Teleoperation by Preventing
> >> Packet Drops in the Linux TUN Driver" [1].
> >> It deals with the tun_net_xmit function which drops SKB's with the rea=
son
> >> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
> >> resulting in reduced TCP performance and packet loss for bursty video
> >> streams when used over VPN's.
> >>
> >> The abstract reads as follows:
> >> "Throughput-critical teleoperation requires robust and low-latency
> >> communication to ensure safety and performance. Often, these kinds of
> >> applications are implemented in Linux-based operating systems and tran=
smit
> >> over virtual private networks, which ensure encryption and ease of use=
 by
> >> providing a dedicated tunneling interface (TUN) to user space
> >> applications. In this work, we identified a specific behavior in the L=
inux
> >> TUN driver, which results in significant performance degradation due t=
o
> >> the sender stack silently dropping packets. This design issue drastica=
lly
> >> impacts real-time video streaming, inducing up to 29 % packet loss wit=
h
> >> noticeable video artifacts when the internal queue of the TUN driver i=
s
> >> reduced to 25 packets to minimize latency. Furthermore, a small queue
> >> length also drastically reduces the throughput of TCP traffic due to m=
any
> >> retransmissions. Instead, with our open-source NODROP Patch, we propos=
e
> >> generating backpressure in case of burst traffic or network congestion=
.
> >> The patch effectively addresses the packet-dropping behavior, hardenin=
g
> >> real-time video streaming and improving TCP throughput by 36 % in high
> >> latency scenarios."
> >>
> >> In addition to the mentioned performance and latency improvements for =
VPN
> >> applications, this patch also allows the proper usage of qdisc's. For
> >> example a fq_codel can not control the queuing delay when packets are
> >> already dropped in the TUN driver. This issue is also described in [2]=
.
> >>
> >> The performance evaluation of the paper (see Fig. 4) showed a 4%
> >> performance hit for a single queue TUN with the default TUN queue size=
 of
> >> 500 packets. However it is important to notice that with the proposed
> >> patch no packet drop ever occurred even with a TUN queue size of 1 pac=
ket.
> >> The utilized validation pipeline is available under [3].
> >>
> >> As the reduction of the TUN queue to a size of down to 5 packets showe=
d no
> >> further performance hit in the paper, a reduction of the default TUN q=
ueue
> >> size might be desirable accompanying this patch. A reduction would
> >> obviously reduce buffer bloat and memory requirements.
> >>
> >> Implementation details:
> >> - The netdev queue start/stop flow control is utilized.
> >> - Compatible with multi-queue by only stopping/waking the specific
> >> netdevice subqueue.
> >> - No additional locking is used.
> >>
> >> In the tun_net_xmit function:
> >> - Stopping the subqueue is done when the tx_ring gets full after inser=
ting
> >> the SKB into the tx_ring.
> >> - In the unlikely case when the insertion with ptr_ring_produce fails,=
 the
> >> old dropping behavior is used for this SKB.
> >>
> >> In the tun_ring_recv function:
> >> - Waking the subqueue is done after consuming a SKB from the tx_ring w=
hen
> >> the tx_ring is empty. Waking the subqueue when the tx_ring has any
> >> available space, so when it is not full, showed crashes in our testing=
. We
> >> are open to suggestions.
> >> - When the tx_ring is configured to be small (for example to hold 1 SK=
B),
> >> queuing might be stopped in the tun_net_xmit function while at the sam=
e
> >> time, ptr_ring_consume is not able to grab a SKB. This prevents
> >> tun_net_xmit from being called again and causes tun_ring_recv to wait
> >> indefinitely for a SKB in the blocking wait queue. Therefore, the netd=
ev
> >> queue is woken in the wait queue if it has stopped.
> >> - Because the tun_struct is required to get the tx_queue into the new =
txq
> >> pointer, the tun_struct is passed in tun_do_read aswell. This is likel=
y
> >> faster then trying to get it via the tun_file tfile because it utilize=
s a
> >> rcu lock.
> >>
> >> We are open to suggestions regarding the implementation :)
> >> Thank you for your work!
> >>
> >> [1] Link:
> >> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publicati=
ons/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> >> [2] Link:
> >> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffe=
ctive-on-tun-device
> >> [3] Link: https://github.com/tudo-cni/nodrop
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >
> > I wonder if it would be possible to implement BQL in TUN/TAP?
> >
> > https://lwn.net/Articles/454390/
> >
> > BQL provides a feedback mechanism to application when queue fills.
>
> Thank you very much for your reply,
> I also thought about BQL before and like the idea!
>
> However I see the following challenges in the implementation:
> - netdev_tx_sent_queue is no problem, it would just be called in
> tun_net_xmit function.
> - netdev_tx_completed_queue is challenging, because there is no completio=
n
> routine like in a "normal" network driver. tun_ring_recv reads one SKB at
> a time and therefore I am not sure when and with what parameters to call
> the function.

Right, this is similar to virtio_net without TX NAPI. It would be
tricky to implement BQL on top (and TUN also did skb_orphan during
xmit).

Thanks

> - What to do with the existing TUN queue packet limit (500 packets
> default)? Use it as an upper limit?
>
> Wichtiger Hinweis: Die Information in dieser E-Mail ist vertraulich. Sie =
ist ausschlie=C3=9Flich f=C3=BCr den Adressaten bestimmt. Sollten Sie nicht=
 der f=C3=BCr diese E-Mail bestimmte Adressat sein, unterrichten Sie bitte =
den Absender und vernichten Sie diese Mail. Vielen Dank.
> Unbeschadet der Korrespondenz per E-Mail, sind unsere Erkl=C3=A4rungen au=
sschlie=C3=9Flich final rechtsverbindlich, wenn sie in herk=C3=B6mmlicher S=
chriftform (mit eigenh=C3=A4ndiger Unterschrift) oder durch =C3=9Cbermittlu=
ng eines solchen Schriftst=C3=BCcks per Telefax erfolgen.
>
> Important note: The information included in this e-mail is confidential. =
It is solely intended for the recipient. If you are not the intended recipi=
ent of this e-mail please contact the sender and delete this message. Thank=
 you. Without prejudice of e-mail correspondence, our statements are only l=
egally binding when they are made in the conventional written form (with pe=
rsonal signature) or when such documents are sent by fax.
>


