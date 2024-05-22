Return-Path: <netdev+bounces-97618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C38CC66F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D160FB21044
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303C145FF0;
	Wed, 22 May 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5ZRqznk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B9145FE4;
	Wed, 22 May 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403171; cv=none; b=ldzYusBqtyR/wMuf40svIe2Y2dBeYsSHimIRZu5vDiT265xiqIMBO8bQCWqXkjpIdw/gUPQ/0Rim17jrtcbRjfC3pFme0d+TW71z0so0DsBp83snxOISWa9kYedxofC/vDOCv8Pou529LdzN+INx1LXZhE2KoiELbsThfB89Esk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403171; c=relaxed/simple;
	bh=S9l5v3KZf0QNF6xsXNUPid3YSFPvJ5dX6CaHgGPpHAs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K8X+G+VEeXtggLbZz020izimDHDDbCrOVU0lcy0/AAJfi9tvUMaghF+sBm4IkhhvU5DGmfTv4yblwLLFhsUYO2Urddrsb4JGu3v4Dyvm802g2nL+uhNcb2P8bXRat9L4h0vCmB6c+DgLOaerochs4gP52jmfKfI9BVabGJKhTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5ZRqznk; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9cc681e4fso2675287b6e.0;
        Wed, 22 May 2024 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716403169; x=1717007969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMQOMsUvJoKTJuwjZqFeLcXEOOFPxcU27IS0vsncKk4=;
        b=G5ZRqznk0ERbXVhGoCGJog8r4sSzfmiUMwXoFY9I+22k2nX9kuJGKZCDGBSOmvbOdt
         PjqQ6SqQ8jQocI35MRvMJsXE8m5ZoAMCRBQzGnyf3BJZbiFIXOfL3e4U9M3GeAAzUiWS
         BwIg2If4s6g+0x14l5l/YtuveupVJelR/BM/Ojb7oek+1Ls4nCVwsQdk4yxUE7cC4hBm
         ZLALmq0pd3eNSZ1gaJyr6NI54DbgVI9EFn1BkClOGrDzqmnyWHfbVQ0oYI31XDu2Qlqv
         oyb0INOwtWi22mTUpcC0Mdv9XIxT4uCTtSvnSN4wYil9r6PynNYuTevkFkvtoNi04rND
         be6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716403169; x=1717007969;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IMQOMsUvJoKTJuwjZqFeLcXEOOFPxcU27IS0vsncKk4=;
        b=mmXcbFAS1o3+N3tnRFbpdQ9L2DNuuo5dH6RWVPlbPpVF99MKG55pPxFWzTYpvHHMaG
         Aynd9guk3VbFHWkHjDCCIdVzaOd/wgF3AyF7KmZMG6lnlOI213Ixx54iU/4KOGlD48kb
         kQYqbuGJ5rFlrvFFgTLUE+PBuEWnnc9jkNMJLqIDkhI2T0EZW85tg6dIJjQjj/BvxGJB
         pfGQnkMsM5io/msE3rP+SFBEv17dVbkiCpwJ8I/P7ayVug8/T4kC64ZWAPaMegZPHLoj
         mIhXRMsuAb3rJQeDdRAwEeg5L+C/jfOrK9wvzDITon6If69HZwUGPZ2/eTKXErGnQnxM
         2cqg==
X-Forwarded-Encrypted: i=1; AJvYcCXP7/T5a/Bn7ss3gv29ON5aOyc+x07qC3KGT4d8pfPXjcCtq3chTqv78zhrwq5N6R2NyD6aaiyphi+FH+nAGW1QjGB4CPwrspgTipmv6RjO5T17qqAKlBczUJTOBw8yBSOfAHMP
X-Gm-Message-State: AOJu0Yz+DPSXyYPF7XFT7Yw0FvxYdilsGUV7zPs7E4bl9jv3Vbfw8CwZ
	8syt57akh5GXjHNXyxAJ/RdPzimyBjwgZWnt2gAeJot8jhpPy5gX
X-Google-Smtp-Source: AGHT+IExmyD0PBTyUzdJ3U6VoqRAzkhELP89U8CERAJNzdfVN4KWvETkrs+Ft7k1qJLZzlFpx1yyPA==
X-Received: by 2002:a05:6808:183:b0:3c8:2c1c:a39b with SMTP id 5614622812f47-3cdb64c6f81mr3738323b6e.32.1716403169288;
        Wed, 22 May 2024 11:39:29 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-793017facabsm732376785a.88.2024.05.22.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:39:28 -0700 (PDT)
Date: Wed, 22 May 2024 14:39:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <664e3be092d6a_184f2f29441@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qfZ8JPkt4Ez1My=gfpT7VfHo75N01fLQdFaojBv2whi8w@mail.gmail.com>
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
 <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
 <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com>
 <664ca1651b66_14f7a8294cb@willemb.c.googlers.com.notmuch>
 <CAPza5qfZ8JPkt4Ez1My=gfpT7VfHo75N01fLQdFaojBv2whi8w@mail.gmail.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chengen Du wrote:
> Hi Paolo,
> =

> Thank you for your useful suggestions and information.
> =

> Hi Willem,
> =

> The issue initially stems from libpcap [1].
> Upon their further investigation, another issue was discovered,
> leading to a kernel request [2] that describes the problem in detail.
> =

> In essence, the kernel does not provide VLAN information if hardware
> VLAN offloading is unavailable in cooked mode.
> The TCI-TPID is missing because the prb_fill_vlan_info() function in
> af_packet.c does not modify the tp_vlan_tci/tp_vlan_tpid values since
> the information is in the payload and not in the sk_buff struct.
> In cooked mode, the L2 header is stripped, preventing the receiver
> from determining the correct TCI-TPID value.
> Additionally, the protocol in SLL is incorrect, which means the
> receiver cannot parse the L3 header correctly.
> =

> To reproduce the issue, please follow these steps:
> 1. ip link add link ens18 ens18.24 type vlan id 24
> 2. ifconfig ens18.24 1.0.24.1/24
> 3. ping -n 1.0.24.3 > /dev/null 2>&1 &
> 4. tcpdump -nn -i any -Q out not tcp and not udp
> =

> The attached experiment results show that the protocol is incorrectly
> parsed as IPv4, which leads to inaccurate outcomes.
> =

> Thanks to Paolo's suggestion, I propose that we add a new bit in the
> status to indicate the presence of VLAN information in the payload and
> modify the header's entry (i.e., tp_vlan_tci/tp_vlan_tpid)
> accordingly.
> For the sll_protocol part, we can introduce a new member in the
> sockaddr_ll struct to represent the VLAN-encapsulated protocol, if
> applicable.
> =

> In my humble opinion, this approach will not affect current users who
> rely on the status to handle VLAN parsing, and the sll_protocol will
> remain unchanged.
> Please kindly provide your feedback on this proposal, as there may be
> important points I have overlooked.
> If this approach seems feasible, I will submit a new version next week.=

> Your assistance and opinions on this issue are important to me, and I
> truly appreciate them.
> =

> Best regards,
> Chengen Du
> =

> [1] https://github.com/the-tcpdump-group/libpcap/issues/1105
> [2] https://marc.info/?l=3Dlinux-netdev&m=3D165074467517201&w=3D4

This is all super helpful context and will have to make it into the
commit message.

So if I understand correctly the issue is inconsistency about whether
VLAN tags are L2 or L3, and information getting lost along the way.

SOCK_DGRAM mode removes everything up to skb_network_offset, which
also removes the VLAN tags. But it does not update skb->protocol.

msg_name includes sockaddr_ll.sll_protocol which is set to
skb->protocol.

So the process gets a packet with purported protocol ETH_P_8021Q
starting beginning at an IP or IPv6 header.

A few alternatives to address this:

1. insert the VLAN tag back into the packet, with an skb_push.
2. prepare the data as if it is a VLAN offloaded packet:
   pass the VLAN information through PACKET_AUXDATA.
3. pull not up to skb_network_offset, but pull mac_len.

Your patch does the second.

I think the approach is largely sound, with a few issues to consider:
- QinQ. The current solution just passes the protocol in the outer tag
- Other L2.5, like MPLS. This solution does not work for those.
  (if they need a fix, and the same network_offset issue applies.)

3 would solve all these cases, I think. But is a larger diversion from
established behavior.

> On Tue, May 21, 2024 at 9:28=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Paolo Abeni wrote:
> > > On Tue, 2024-05-21 at 11:31 +0800, Chengen Du wrote:
> > > > I would appreciate any suggestions you could offer, as I am not a=
s
> > > > familiar with this area as you are.
> > > >
> > > > I encountered an issue while capturing packets using tcpdump, whi=
ch
> > > > leverages the libpcap library for sniffing functionalities.
> > > > Specifically, when I use "tcpdump -i any" to capture packets and
> > > > hardware VLAN offloading is unavailable, some bogus packets appea=
r.
> >
> > Bogus how exactly?
> >
> > > > In this scenario, Linux uses cooked-mode capture (SLL) for the "a=
ny"
> > > > device, reading from a PF_PACKET/SOCK_DGRAM socket instead of the=

> > > > usual PF_PACKET/SOCK_RAW socket.
> >
> > Trying to extract L2 or VLAN information from the any device may be
> > the real issue here.
> >
> > > >
> > > > Using SOCK_DGRAM instead of SOCK_RAW means that the Linux socket =
code
> > > > does not supply the packet's link-layer header.
> > > > Based on the code in af_packet.c, SOCK_DGRAM strips L2 headers fr=
om
> > > > the original packets and provides SLL for some L2 information.
> > >
> > > > From the receiver's perspective, the VLAN information can only be=

> > > > parsed from SLL, which causes issues if the kernel stores VLAN
> > > > information in the payload.
> >
> > ETH_HLEN is pulled, but the VLAN tag is still present, right?
> >
> > > >
> > > > As you mentioned, this modification affects existing PF_PACKET re=
ceivers.
> > > > For example, libpcap needs to change how it parses VLAN packets w=
ith
> > > > the PF_PACKET/SOCK_RAW socket.
> > > > The lack of VLAN information in SLL may prevent the receiver from=

> > > > properly decoding the L3 frame in cooked mode.
> > > >
> > > > I am new to this area and would appreciate it if you could kindly=

> > > > correct any misunderstandings I might have about the mechanism.
> > > > I would also be grateful for any insights you could share on this=
 issue.
> > > > Additionally, I am passionate about contributing to resolving thi=
s
> > > > issue and am willing to work on patches based on your suggestions=
.
> > >
> > > One possible way to address the above in a less invasive manner, co=
uld
> > > be allocating a new TP_STATUS_VLAN_HEADER_IS_PRESENT bit, set it fo=
r
> > > SLL when the vlan is not stripped by H/W and patch tcpdump to inter=
pret
> > > such info.
> >
> > Any change must indeed not break existing users. It's not sufficient
> > to change pcap/tcpdump. There are lots of other PF_PACKET users out
> > there. Related, it is helpful to verify that tcpdump agrees to a patc=
h
> > before we change the ABI for it.



