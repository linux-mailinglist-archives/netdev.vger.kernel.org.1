Return-Path: <netdev+bounces-291270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CQnKAMTFGoLJgcAu9opvQ
	(envelope-from <netdev+bounces-291270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EA95C866F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09E9A3002F97
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475C3E5ED6;
	Mon, 25 May 2026 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID/rHZ4Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1pWFqNj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920673E0259
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700478; cv=pass; b=SBRoEqc6JJqiX+LNg6ECqk20PoRAQszVnog22rvbI/26rQm46mSTgrPg3LPuQVYjuNctrNXM++4vXgG7rpMBP04beaDDSteAP0m6ye9ixpAdXFbqfisRPJfa0/Trcx/0qaWOVDTIwDf619kNTcWtas60YYBrmtaxadKbFv7wpqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700478; c=relaxed/simple;
	bh=bz6HId41xY9V16r3H/1IHSbtq+kVTBX+AzuUuy8We88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxnkehjV1tZt7u59AGJtn42NzxOn8ejkxt8IzjdHZ9erFCVRn1HYpsFJzchhY/Tk6bJjHS88ey1fzgOUD+hSxq9rqgXJ6dNc0+mhpmnkqhImi4m9hev3OhNjm812ExX5lY9yH3Lms442TGsubIpySW9uzo89ouoZcASeuiy4t1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ID/rHZ4Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1pWFqNj; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779700473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCa6LzOtgQIffaGGFzBaXF3Q8bJnjAULK2FkHdc8+UE=;
	b=ID/rHZ4YXC9qwtn2HME1FgQSNjSjft1XaNKa8H/PJoInOonSh0KCEXujyywrs8Dc0FG6Mt
	k/tGd8vTT7R+jjFX/XED+dBtpsORQodO7IoU/cOIC140XTsa8jU0ZHHAvOeL0Y+tFDHg27
	OvkVfl5RLI8s8TO4FA7MM0kFpmlWmj0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-6WsUo9DDO6a5sBF9P59OSg-1; Mon, 25 May 2026 05:14:31 -0400
X-MC-Unique: 6WsUo9DDO6a5sBF9P59OSg-1
X-Mimecast-MFC-AGG-ID: 6WsUo9DDO6a5sBF9P59OSg_1779700471
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-368edd5fec4so10410732a91.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 02:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779700471; cv=none;
        d=google.com; s=arc-20240605;
        b=NY/rT94wTjIYW87SeO2cUcHOtnW1HUmg1PLyjEmrF+33tZ/CxpArisdhr6qp2+i7LI
         7xPQ2ZlfNYhKGB1GKbza9sxp0SnDPerlUTvW+YQ90+5LS+/cwMbebH4+W4idpIcB62hZ
         sUGczJqwWOyC/toZcE3P920JKK/y1PmCyRHFvxb8/whfkL+m7ZMHdmlSavAD78vNHZpO
         9FdlFdGGHZIHaap4EC7NLjHAiqK8nAyvk7owNhYILKoT7cI3e+MI3z/Ib/BmKadEq+XM
         nmsfZ4eGFRO3JRf9VCu3LyCfMvwZOeVCdOk/zKrQ2Viosg0m4xsZQJxwnssr+X3x0nMn
         itow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XCa6LzOtgQIffaGGFzBaXF3Q8bJnjAULK2FkHdc8+UE=;
        fh=vjOOakh9m1yXR5MgP9/KaM0RSr0wO0CHxSmU703b6uM=;
        b=c4BOf848ptzrpcm0fS8AECfCZjDaw8P11qVCMW16b2BXvw/jElKoe+MQIsOuoBYNSJ
         tA2YSdxl4wDLi36ABi6lIUSDCgYv7wbn8h+w62/TFDDO+dsstPPKvkPz4Sk/3I6mQ/Xw
         ZH+2igVT10Veau/YuuJvFG//17llSfFwakH3ZKPfh1WalMGc0nVoj9LyVXMCJX1DTqVv
         hjRKuU5TjOuM0eNFwMy6jOK0rHsC29mWw5V5oroao8Hb0s+JqXK2PbJHVCOLxpGeKDFV
         Dxm8VWAtPXdR+USE/ZZ3vCfBt5zQEPdj1hcszqEGYiPtYqgD/SliODeD72g5SuC2iN2R
         JoCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779700471; x=1780305271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCa6LzOtgQIffaGGFzBaXF3Q8bJnjAULK2FkHdc8+UE=;
        b=W1pWFqNjbdpz0WVa/DcqzedHYAl6QlZz8LJF/KzK6cLehOtP9bTAgeVVRViVEi4+wa
         Y6Z2RJSSdBpRTTHM/U5rsEmbuXgZA3aSFXhhIecWRrR1LH8fxy8Wtd0bKo8EnenA8WT8
         afS5BQsUG3JETcnc8WPQG1JwDxq3IAEQoe1gtrX2Vkk7EpijdtaW1KK1TP1pRcdv0EWe
         XGFU//z1FMZt8APtcZdBIvscdJ6numCPeYVdZB5YZqh9lHzZKJiLLVVhUS/RY8FSdkf1
         uJbVtEBxSTvlfukAjC4CnaKHOgIGNsPyUvGEMECCQYM0ffbI9pPgDAblqzAAaZD0+lG1
         U8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700471; x=1780305271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCa6LzOtgQIffaGGFzBaXF3Q8bJnjAULK2FkHdc8+UE=;
        b=ZyOwVLq47VHYqZ3jH+BeChAaLZzOl7VWi2F8T+fnchj75Wy9OIGEI0s9fagIgXHD/x
         yFq6YSXSESEq+KPkQUmJVffYjC9a27Oqqgmck1g1OQRjofejgYv8r0jliRWQ0sNECWaC
         kZhYl2rGm3r2L9jKBD5TG17cAH7PYiWm7qoLfdfpRZGKiR1racpenhBWg3qxNBRJ3jxW
         pfsZTxy8uvD6BWgSjon/nz2yS/DGklNPGhZsm/Ol9Y7Vk55CY4ixE+PKgSdBAKXzU+sz
         ziUADCwAAACnoZbIgB4wZC/aY0WO3w9TXfo2JrjYfwOIkapyChXtNKWaHKT0741JPofo
         7Cyg==
X-Forwarded-Encrypted: i=1; AFNElJ8j6V5mBbO1WNPDuM++BWdh9IN/L1q5t8h+jgxL89Q0+UxxCvTPGe3tnTqu8PCPCB8kB0QJVT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqzXOkO1wcFp2SEZzNmDBpe/lcyrznK/IG8lDZHY/5lBpqWeN
	g4COOWER3dCBOsqDP/Q2YT+1HvveJZ/AL0QlZ+NZBgOWp65FvM5diFZOoDP1EwHXpQ7/HbLO/Pv
	JX8jkRddDL3v2S6O56f2X1M/nuYykHMQelY0aA17RdglKvl7kWli4XFSqtqIUsf6ART61NecpN8
	1dMkgdgCLJEwoXG+ytP2H/78h3vwMoHxjL
X-Gm-Gg: Acq92OFJ4G+p4BpKCkYKFsrRmsE7q3Ww9w6xDcIwtCxJ5mA3nvdvZq5rnDcAGY/ejrf
	UaClK67jkeU9agog32LpydacXLt1+Bq+i/eQF1UsVnIwhBPA9EvZfjOmVMKa4iezjiMEFx8Y4Vy
	s/wi+t/+VvoEuWvaVL3Z5ARK++2LmW6wJMvi4+y6gWxb/o6uSXoj7lyYYB61PIHvltVUSei6HGN
	ENf
X-Received: by 2002:a17:90b:2585:b0:366:3ac:f730 with SMTP id 98e67ed59e1d1-36a6788e0abmr12403282a91.25.1779700470414;
        Mon, 25 May 2026 02:14:30 -0700 (PDT)
X-Received: by 2002:a17:90b:2585:b0:366:3ac:f730 with SMTP id
 98e67ed59e1d1-36a6788e0abmr12403244a91.25.1779700469810; Mon, 25 May 2026
 02:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afn0ZdvZWswBuDMm@sgarzare-redhat> <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat> <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat> <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat> <20260507163710-mutt-send-email-mst@kernel.org>
 <af2sXvVCBT05XF0D@sgarzare-redhat> <20260508055343-mutt-send-email-mst@kernel.org>
 <af21ZGlANY6UUCKx@sgarzare-redhat> <baf184f6-fefd-45ca-a437-1505533e3c81@gmail.com>
 <96977898-81a0-4c79-a95f-0b288e0572a6@gmail.com>
In-Reply-To: <96977898-81a0-4c79-a95f-0b288e0572a6@gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 25 May 2026 11:14:17 +0200
X-Gm-Features: AVHnY4Lhts8wIDTXHhuzia8dvW2K6_DuNl7PB_LxKTgmjoNxj80dGuhGdtyu2k0
Message-ID: <CAGxU2F5yG1VJ6eeawAtxcgE-uEQugsG00ZrTBmqz6=AF3JyksA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	"virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>, Manuel Stoeckl <code@mstoeckl.com>, 
	Alyssa Ross <hi@alyssa.is>, Spectrum Development <devel@spectrum-os.org>, 
	systemd development <systemd-devel@lists.freedesktop.org>, 
	Val Packett <val@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,salutedevices.com,meta.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev,mstoeckl.com,alyssa.is,spectrum-os.org,lists.freedesktop.org,invisiblethingslab.com];
	TAGGED_FROM(0.00)[bounces-291270-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F2EA95C866F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 at 04:37, Demi Marie Obenour <demiobenour@gmail.com> wrote:
>
> On 5/23/26 17:00, Demi Marie Obenour wrote:
> > On 5/8/26 06:11, Stefano Garzarella wrote:
> >> On Fri, May 08, 2026 at 05:58:06AM -0400, Michael S. Tsirkin wrote:
> >>> On Fri, May 08, 2026 at 11:41:21AM +0200, Stefano Garzarella wrote:
> >>>> On Thu, May 07, 2026 at 06:48:47PM -0400, Michael S. Tsirkin wrote:
> >>>>> On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
> >>>>>> On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
> >>>>>>> On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>>>> For now, we're already doing something:
> >>>>>>>> merging the skuffs if they don't have EOM set.
> >>>>>>>
> >>>>>>>
> >>>>>>> Right that's good. You could go further and merge with EOM too
> >>>>>>> if you stick the info about message boundaries somewhere else.
> >>>>>>
> >>>>>> This adds a lot of complexity IMO, but we can try.
> >>>>>>
> >>>>>> Do you have something in mind?
> >>>>>
> >>>>> BER is clearly overkill but here's a POC that claude made for me,
> >>>>> just to give u an idea. It's clearly has a ton of issues,
> >>>>> for example I dislike how GFP_ATOMIC is handled.
> >>>>
> >>>> Okay, I somewhat understand, but clearly this isn't net material
> >>>
> >>> I doubt we have many other options given reverting the regression was
> >>> ruled out.
> >>
> >> As Eric pointed out, we can't revert it.
> >
> > Could there be an option to disable the mitigation in guests, for the
> > situation where the host is trusted?  There are VMMs that implement
> > AF_VSOCK in userspace with a backing AF_UNIX socket.

Here the main problem was an attack to the host from the guest.

Can the application set the max (IIRC 4G) of SO_VM_SOCKETS_BUFFER_SIZE ?

> >
> >>>> so for now
> >>>> I think the best thing to do is to merge the fixup I sent (or something
> >>>> similar):
> >>>> https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
> >>>
> >>> I reviewed that one, problem is it's a spec violation/change that we'll
> >>> have to support forever.
> >>
> >> I have a few points to make on this, but let's discuss them there.
> >>
> >>>
> >>>> This is a major change that should be merged with more caution.
> >>>> Could this have too much of an impact on performance?
> >>>>
> >>>> Thanks,
> >>>> Stefano
> >>>
> >>> It's really a POC, real patch is left as an excersise for the reader
> >>> :).
> >>
> >> eheh, I see, but honestly, this overcomplication scares me. I'll try to
> >> think it over.
> >>
> >>> The correct approach IMHO is to only start using this
> >>> when we wasted a lot of memory on small packets.
> >>>
> >>> For example, if sum(truesize) >= buf size.
> >>>
> >>> then we'll not see a perf impact unless it's already pathological.
> >>
> >> Agree on this, which is similar to what I'm doing in that patch.
> >> Reducing the advertised buf_alloc only in pathological cases (e.g.
> >> overhead > buf_alloc).
> >
> > This isn't enough to prevent data loss due to race conditions.

Yep, we didn't go in that direction.

> >
> > I'm CCing the virtio-comment list and a few others.
> >
> > Right now, any application that needs to send massive amount of
> > data over a vsock is simply broken.  This isn't just theoretical.
> > It's causing real-world problems for users of Waypipe.
> > Waypipe forwards Wayland protocol messages over AF_VSOCK,
> > so it can send a large amount of traffic over the socket.
> > See https://gitlab.freedesktop.org/mstoceckl/waypipe/work_items/165.
> >
> > If one is willing to mutate the ring buffer in-place, or to maintain
> > an auxiliary counter, it's possible to store all messages with bounded
> > (in practice) overhead.  Specifically:
> >
> > - If the first byte of a block of data is nonzero, it's a
> >   variable-length length.  1 byte for messages less than 128 bytes.
> >
> > - If the first byte of a block of data is zero, the subsequent bytes
> >   are a variable-length counter that stores the number of consecutive
> >   zero-byte messages.
> >
> > That adds a lot of complexity, which is very unfortunate for something
> > that needs to be backported to stable kernels.  I also suspect it
> > requires all access to the ring buffer to take a lock rather than
> > being lock-free.  But it's the only approach that I can think of that
> > can work with the current spec.

Yep, we were discussing something like that in this thread, but we are
still working on that.
That said, any help on preparing patches for this would be more than welcome.

> >
> > Could there at least be a normative note stating that drivers and
> > devices should treat each message as consuming 1024 bytes + the size
> > of the message itself, and warning that anything that doesn't is
> > going to be broken in practice?

We would like to fix the issue. This is a transitive situation.

> >
> > I'm CCing Val Packet (of Invisible Things Lab) and Alyssa Ross
> > (of Spectrum) because both of them are working on systems that rely
> > critically on vsock.
>
> Update: I see that patches have been upstreamed (with CC: stable) that
> reset the connection instead of data loss.

Yep, hope that helps the situation. But again, can setting the max
SO_VM_SOCKETS_BUFFER_SIZE helps those applications?

Thanks,
Stefano


