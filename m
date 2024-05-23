Return-Path: <netdev+bounces-97812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F63B8CD585
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752641C20BD4
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23A8062B;
	Thu, 23 May 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NWsdlZrU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8097433C4
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473905; cv=none; b=XqJdfSBhT4Ik4Vb/SRDNJ4W6NGL/rjHLuznpWYtl+SFJJLYF7LvSVVhfN7N88vdWE05D4mhBWXlmrtnWYNjmFLmLKSstE3ZFOdCgNyuhwPQHX9PI0ccHGzZHTlqau+bvytyPLTzu3+/LhF6SkHeIQ0RtaL3rhS8aKnGlZvZt1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473905; c=relaxed/simple;
	bh=5M6+SBxCn4yCDG2dS8iHnZ19j9+1zeIrkD10i2rcCZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feN2ZbedK9dDzHxQjPOBF01x0VP8gRLcuuLxK56tQMoMPNEUi6OD3CsCoTGOs0TuXIb/weHxVPuZ4sLdEXHLBa1Nbi/1H7oxqHny+iXhPicxa5LV5UKLgacWjmfcsTEu7JMDpQo14NSqs4QHEGkEgkRc5NTEQSvlapwD+0jb0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NWsdlZrU; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 053E741202
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716473892;
	bh=10aYP23kiwgc7loRFD6OVg9blw9zt+4aFABqf8TF5K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=NWsdlZrUyXkFREr2REBl3pimEQQApZAynqFVMe2+FQJxGmq9gndMMokISmg9AAAHc
	 znMeOgHa4K686ydFpGYtzjmCbB3cw2xwaia1y9Fad2KrlOmemsUUVhwM9iX34Xi5Lu
	 9ZM5RZFwliWeomZCcU8KoZU93etERVMqiUej+w9mFkru3Myd1SgGnXwA4G34riLc7j
	 pdFRwCZFO/FZFUc5Ir649HO/nP27x/ZlhWyQ89hesJGEogqRVJg/8Np1LqR94/X+w9
	 z3Zgd7wq0FF1rvuoVl/llJHax8HL2rkEQkZRA3COsKj2VF+3B8W6lMa7+b6DQ3ORvh
	 Oyh2x2ZeOAiSg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5a1b50d45cso110802766b.2
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716473891; x=1717078691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10aYP23kiwgc7loRFD6OVg9blw9zt+4aFABqf8TF5K4=;
        b=wqzkjlnEJOS8OFcqq2ABo7Raik6FQU2PFi4bW72CVWV+G4RufMpIssn82mdWZqM1Mx
         4baQz6misRCciBIPIvm9R1EV15bNvO1uOi31d7jBsF9zy2VgA4duDJl6GLbyX+H82eH1
         mxd3s1A3FD3THhSvCw35NFyZRaz/U913lnR5ArgQi/IPavNFendqDFqhtPdhXL44UAmU
         /nSLJKeRI+HciBNDpBarwP2hsXrNijT28Qn5L/AD6QjIgV9NXg7Awiq4UOmBzjufVDqY
         QpLSobrOTVamXzAste5HEfk6iPP4VI9Ysc74lXnOOIppAqgstBqxg7aaIgi6HYaUsYJg
         /CnA==
X-Forwarded-Encrypted: i=1; AJvYcCVvESUbJKKmQ+9zGbzM636qBPPp3tqDtipxa8hfF0xgMiP/6jR4LlyaSL62RazxJPTsQLMUF36/vfAZx5OH6NvHQ+NCJo+D
X-Gm-Message-State: AOJu0YyWWWrIudHlidkb7odBlZEAHgvrjIiY4dCbHIXP90IJ/kKWkfhL
	2K5j490jHbde284IKJ0CIFzRzhMdqPHQbgGEJpNPKGurTiyoSx5YROcaOKFI0Q6ec+uMjx4c4YX
	YomalzBmxalJtjIbARE1fbagQQUCVrTGFpFO53WPKpMvzUWRlXEM2Uhxtv/BvgWv3Lpye0gMsQ7
	daKCpaO8Fn1E0t64R5brzSn5BO7g5kM3eRmbCaOf0ZW7Dr
X-Received: by 2002:a17:906:f1d9:b0:a62:129e:e693 with SMTP id a640c23a62f3a-a6228142908mr338371666b.52.1716473891524;
        Thu, 23 May 2024 07:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESbqT58hOzCJpH86plo5ua+t/ksCwcdn4ENTylZWzGrsAcrZ86na1c7tTnTahu78w3VHZqDnzI1yapG50CIvU=
X-Received: by 2002:a17:906:f1d9:b0:a62:129e:e693 with SMTP id
 a640c23a62f3a-a6228142908mr338369266b.52.1716473890964; Thu, 23 May 2024
 07:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
 <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
 <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com>
 <664ca1651b66_14f7a8294cb@willemb.c.googlers.com.notmuch> <CAPza5qfZ8JPkt4Ez1My=gfpT7VfHo75N01fLQdFaojBv2whi8w@mail.gmail.com>
 <664e3be092d6a_184f2f29441@willemb.c.googlers.com.notmuch> <92edf27b-a2b9-4072-b8a4-0d7fde303151@orange.com>
In-Reply-To: <92edf27b-a2b9-4072-b8a4-0d7fde303151@orange.com>
From: Chengen Du <chengen.du@canonical.com>
Date: Thu, 23 May 2024 22:17:59 +0800
Message-ID: <CAPza5qfam1DBffBJWjOrMsSW8J+6ans7apeX=64YVCixBWX-tQ@mail.gmail.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, alexandre.ferrieux@orange.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem, all,

Thank you for highlighting the QinQ and L2.5 issues.
These are areas I am not very familiar with, and I appreciate your guidance=
.

To address the QinQ and L2.5 issues, the third approach seems like a
promising solution.
If I understand correctly, in the QinQ scenario, we need to preserve
the link layer header because it includes two VLAN tags.
For the L2.5 issue, we can adjust by pulling mac_len instead of
skb_network_offset.
In summary, we may need to retain the link layer header to enable
receivers to parse different protocol scenarios.

Although this approach can resolve all issues, it requires the
receiver's cooperation to implement the parsing logic of the link
layer header.
I am concerned that this implementation may take time and adding it
directly into the kernel could place time pressure on existing users.

I would like to propose some ideas and welcome your thoughts on them.
Firstly, I suggest we address the VLAN issue using the second
approach, as it appears to be a bug and can be resolved without
affecting current users.
Secondly, we could introduce the link layer header preservation via a
new packet socket flag.
Receivers could implement and test this by enabling the socket flag.
This way, we avoid disrupting existing receiver behavior while
providing the capability to parse more complex protocols.

This is a rough idea and may require further discussion.
Please share your opinions if you have any concerns.
Your suggestions and assistance are crucial to resolving this issue,
and I greatly appreciate your input.

Best regards,
Chengen Du

On Thu, May 23, 2024 at 3:54=E2=80=AFAM <alexandre.ferrieux@orange.com> wro=
te:
>
> Hi Willem, all.
>
> On 22/05/2024 20:39, Willem de Bruijn wrote:
> > Chengen Du wrote:
> > >
> > > [1] https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > [2] https://marc.info/?l=3Dlinux-netdev&m=3D165074467517201&w=3D4
> First, a huge thanks to you guys for digging this out, and for taking it =
on for
> good.
> > This is all super helpful context and will have to make it into the
> > commit message.
> >
> > So if I understand correctly the issue is inconsistency about whether
> > VLAN tags are L2 or L3, and information getting lost along the way.
> Exactly. As you put it, L2.5 is the hot potato nobody wants to handle; ea=
ch side
> assumes the other will take care of it :)
> > SOCK_DGRAM mode removes everything up to skb_network_offset, which
> > also removes the VLAN tags. But it does not update skb->protocol.
> >
> > msg_name includes sockaddr_ll.sll_protocol which is set to
> > skb->protocol.
> >
> > So the process gets a packet with purported protocol ETH_P_8021Q
> > starting beginning at an IP or IPv6 header.
> >
> > A few alternatives to address this:
> >
> > 1. insert the VLAN tag back into the packet, with an skb_push.
> > 2. prepare the data as if it is a VLAN offloaded packet:
> >     pass the VLAN information through PACKET_AUXDATA.
> > 3. pull not up to skb_network_offset, but pull mac_len.
> >
> > Your patch does the second.
> >
> > I think the approach is largely sound, with a few issues to consider:
> > - QinQ. The current solution just passes the protocol in the outer tag
> > - Other L2.5, like MPLS. This solution does not work for those.
> >    (if they need a fix, and the same network_offset issue applies.)
> >
> > 3 would solve all these cases, I think. But is a larger diversion from
> > established behavior.
> I had somehow formed the same analysis and list of available options (wit=
h the
> difference that, being a kernel newbie, I was 10% sure).
> A few extra things you might consider before making the decision:
>
> (a) If the absolute highest priority goes to backwards compatibility, the=
n
> Chengen's approach (your 2.) is the clear winner.
>
> (b) However, from my standpoint as a protocol-agnostic packet-cruncher
> (capturing all sorts of encapsulations at midpoint in promiscuous mode - =
none of
> the packets is really meant for the local stack), the very idea of "speci=
al
> casing" *one* level of VLAN and burying it inside an obscure, lossy pseud=
o-L2
> (SLL), is completely alien. So, any setting (be it not the default) that =
would
> allow to wipe this wart, would be a huge bonus. So I'd happily go with (1=
.) or
> (3.) which both do that. I'll defer to your appreciation of which is the =
least
> disruptive.
>
> (c) Speaking of backwards compatibility, I would respectfully like to poi=
nt out
> that a behavior that has been utterly broken for so many years, might qua=
lify
> for a rather decisive correction. You won't break much anyway :)
>
> TL;DR: all three options are enormously better than the statu quo =3D> by=
 all
> means, fix it either way :)
>
> Best regards,
>
> -Alex
>
>
> _________________________________________________________________________=
___________________________________
> Ce message et ses pieces jointes peuvent contenir des informations confid=
entielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez re=
cu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messages =
electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme o=
u falsifie. Merci.
>
> This message and its attachments may contain confidential or privileged i=
nformation that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and de=
lete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have bee=
n modified, changed or falsified.
> Thank you.

