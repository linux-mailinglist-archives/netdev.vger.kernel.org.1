Return-Path: <netdev+bounces-81596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D437C88A6AE
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495291F3FCA4
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF281ADF;
	Mon, 25 Mar 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1ceUppD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E454770
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371450; cv=none; b=AbyA4dsDDTW49Om26Im+ziEsYewyYkbT4G5CXJO4IlrSk42ee6OznWeaPOps0M4PYryCSdCOR3pu9Lk3GIAvEe5iIcUURW2/ChCXrIk457tW3o3yf+sl70jUsa67/ZQ0LJXT3qfaatwR0jIwMswG24WPgvs2lB41vbTuaAj3ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371450; c=relaxed/simple;
	bh=cah+a4qLGLpMGGgjTvKbYvIZditx+ymKr2hdOv9rFwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGqsSnvBLWH9+PFu/vgr9RUa0nS6mIyylZ0go+oRK3BoVP5dE1g4lGHKdKlW+tNj0IUTBR6TVW7v37/LMTfoD5J9sEEMxBOdQM2+RW00mUtuTCs3yswSkPsAGTbL3RjK38G6xPi9N0+HhjDM3fwvDKp8kF8FbTGDYmk+1DWUx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1ceUppD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711371447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eE5QNBSfrIetcHUg2xpk8XRpM1T1cbP2Uq+oi8Q+TKc=;
	b=H1ceUppDNm1CQx6ei8ut8+TuSxd1QxVrxP2VCCNmwJzq3ZjTpxGSvEw6gCO8ElOswoKBnY
	Yu7wVz8ugs0X4AlHW1RvFCI0px7HlnoROQFjr43VC16JQgszC6LRFGOppeFZOzmQxpTygA
	cJxhEVRjQ0iNSyE4xTCEinvHwsUZKRA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-Vbalo7iTO9GQiq2HZZJJQA-1; Mon, 25 Mar 2024 08:57:25 -0400
X-MC-Unique: Vbalo7iTO9GQiq2HZZJJQA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d47e55dfd1so41363781fa.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 05:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711371444; x=1711976244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE5QNBSfrIetcHUg2xpk8XRpM1T1cbP2Uq+oi8Q+TKc=;
        b=VHkKMdx3IEpGHnuByF4UJSwqx2izjCpRW+PTyCYxKkWFsWH1FQmOprYigzck+sL5DU
         Htc8U/F9wq9TJBi5TlaIeimiY4Xwa0EF12vEWxWrfBfloLcbpOWhKMDKC5nRWEX+65dy
         ZoTgAHysysioSomXjn4yJGVLNgvesAPJo1zdo3dT3tuCGFRbi6BcKg+CFaK9hCdnMuIM
         KppTeGTmNIJrmBjfyagPrwh/BmSyHEAY5rwtf/PVSeblxOPSZKbw0PhVidaZLre3Yb1y
         FCiFvmUV46sH3qYIxCNwvksh7BaZrwkWoFqiBTfqug2lZcg28J1fjscY5V3n+321Inyo
         10sw==
X-Forwarded-Encrypted: i=1; AJvYcCXLw+d2IfdfcbsgPX1dCGoluTG96K7+0En6FZssvnxcaryEpui4OQA24LpyAvi9g31wqGvsY/XTiNZvx2CRvtX1DeJJdKnj
X-Gm-Message-State: AOJu0Yxy11ORBkO5rrKfoZR+gdIPupOYtX5KR0sfOoGwT3E5IQ5yZQam
	lcqv8OhC9BDX7KVGawTIOyPmFWNMNpTViJaM7n0/V9VDblYUp4SFktldrNUOZmU1MuP6f+ZvUdu
	MRqVeoKV3K4CBTlH4NrcU5Dj3SJLH8932wGYlgxl16bcqLNJH3Wyt+g==
X-Received: by 2002:a19:3808:0:b0:513:a05d:7e9a with SMTP id f8-20020a193808000000b00513a05d7e9amr3757492lfa.45.1711371444334;
        Mon, 25 Mar 2024 05:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgfn3Wqnnz98mip1IWNXWbVYKgDKaSOQVd36lu4WQH1Ag3gA+oqgkR8H4zcAFW02hxnCkT9A==
X-Received: by 2002:a19:3808:0:b0:513:a05d:7e9a with SMTP id f8-20020a193808000000b00513a05d7e9amr3757474lfa.45.1711371443756;
        Mon, 25 Mar 2024 05:57:23 -0700 (PDT)
Received: from [10.39.194.69] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709066bc400b00a46f95f5849sm3024197ejs.106.2024.03.25.05.57.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 05:57:23 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Aaron Conole <aconole@redhat.com>, dev@openvswitch.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] openvswitch: Set the skbuff pkt_type for
 proper pmtud support.
Date: Mon, 25 Mar 2024 13:57:22 +0100
X-Mailer: MailMate (1.14r6028)
Message-ID: <4C04D4FF-0ADF-45DC-B253-2CD5C997DA1B@redhat.com>
In-Reply-To: <4066cc6a-24a8-4d05-b180-99222fe792fa@ovn.org>
References: <20240322190603.251831-1-aconole@redhat.com>
 <7AFF5D6D-568C-449B-83CF-9436DE97CA91@redhat.com>
 <f7t5xxawlen.fsf@redhat.com> <4066cc6a-24a8-4d05-b180-99222fe792fa@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 25 Mar 2024, at 13:37, Ilya Maximets wrote:

> On 3/25/24 13:22, Aaron Conole wrote:
>> Eelco Chaudron <echaudro@redhat.com> writes:
>>
>>> On 22 Mar 2024, at 20:06, Aaron Conole wrote:
>>>
>>>> Open vSwitch is originally intended to switch at layer 2, only deali=
ng with
>>>> Ethernet frames.  With the introduction of l3 tunnels support, it cr=
ossed
>>>> into the realm of needing to care a bit about some routing details w=
hen
>>>> making forwarding decisions.  If an oversized packet would need to b=
e
>>>> fragmented during this forwarding decision, there is a chance for pm=
tu
>>>> to get involved and generate a routing exception.  This is gated by =
the
>>>> skbuff->pkt_type field.
>>>>
>>>> When a flow is already loaded into the openvswitch module this field=
 is
>>>> set up and transitioned properly as a packet moves from one port to
>>>> another.  In the case that a packet execute is invoked after a flow =
is
>>>> newly installed this field is not properly initialized.  This causes=
 the
>>>> pmtud mechanism to omit sending the required exception messages acro=
ss
>>>> the tunnel boundary and a second attempt needs to be made to make su=
re
>>>> that the routing exception is properly setup.  To fix this, we set t=
he
>>>> outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get=

>>>> to the openvswitch module via a port device or packet command.
>>>
>>> Is this not a problem when the packet comes from the bridge port in t=
he kernel?
>>
>> It very well may be an issue there as well, but the recommendation is =
to
>> operate with the bridge port down as far as I know, so I don't know if=

>> this issue has been observed happening from the bridge port.
>
> FWIW, bridge ports are typically used as an entry point for tunneled
> traffic so it can egress from a physical port attached to OVS.  It mean=
s
> they are pretty much always UP in most common setups like OpenStack or
> ovn-kubernetes and handle a decent amount of traffic.  They are also us=
ed
> to direct some other types of traffic to the host kernel.

+1 here, I=E2=80=99m talking about the same port. I think we only advise =
having this down for userspace bridges, but not in the case the bridge is=
 the tunnel endpoint.

> Unless I misunderstood which ports we're talking about here.
>
> Best regards, Ilya Maximets.


