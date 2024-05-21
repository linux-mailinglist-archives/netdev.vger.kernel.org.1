Return-Path: <netdev+bounces-97313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859FF8CAB86
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92F61C21D38
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2E6BFBC;
	Tue, 21 May 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpBEC2Ma"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5296AF88
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286189; cv=none; b=pTYukUqFYw1oN6Nbc7WiZHp2sWfnKg5TjyMqou4TOn1MEckgsWWcZz8gjlG4Tk3CrkB74KSfnDS6CdMJcpoHsjLimxlRPM/r3IopWbJH6hzSHeqB8S8224LZ78yhkYEW1l1IXazUVhTMjShPPBdkA8lZmZnYXBrCt3YtAftY2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286189; c=relaxed/simple;
	bh=LY84E1RWWk3jAofPEJLObQHNu/Ia/tP48sDzh7KJUqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gf00qY175woYewizIDRx9iz/7dxnRqkO80gkNRwIipElqgyWn6Xfw6Fqas7wfS+Khz7gl+6x3QEPsXje1xMSPCBoIFY7UbfFwq74JzQ0p5knNhU3699PCv0eRHuGj3zhktbb9GcTsoxGTvNnonh7s2jCm53CtJq8nAdGDBoNFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpBEC2Ma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716286186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nIc2pXGjQ+me7ZvTYeZx+G3dW7IZswOqXUWkt6vgNEc=;
	b=BpBEC2Ma06GbyQff1CKWmCuUk0zv4FxvEBHwQdOL4SknuTwwVMNafgm2itklsvbDV4Wvmo
	oCn/PKT6zf8Lloi/a07CDzc1kPLtxzu7f0q1PF80p0dFlzo2IV4V63xpV1eDTZy0YlCB09
	SyLp/HKC9LPKqmAHi4szfoDh4/i7A/E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-tjwYKGvVMWqfNfMzTYYbbA-1; Tue, 21 May 2024 06:09:43 -0400
X-MC-Unique: tjwYKGvVMWqfNfMzTYYbbA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a59fbf2bacaso866726466b.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 03:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286183; x=1716890983;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIc2pXGjQ+me7ZvTYeZx+G3dW7IZswOqXUWkt6vgNEc=;
        b=IO+cmPSjF1pfEgDhQxgv4ZC+KYqXinXsb+8l3Fnm1TC5yoaG2RuENI+LVf+8GRnbzt
         CSXOjkrEdyaGWtD1zHfDQ6jCYn5wMM8JLzhCJAlzrgrU5Di/kN2xWp2PghVJrjI3ZITl
         x4f34ejgW0UFG51MwZ/BIlHk62geXTmosiF/wsjO8QbPh6I8KXQyYAKEQDBZmmLd6tI2
         bdTJLul4zJuRl3BMfnI0l5NFJhTY8hEbyTojQXDaaOADTGKBtxb4AH/sh82l7TcV2tV9
         xGP+MOZ9CmyTVrVf5aogCvgkTt2Gf85Gi8ItWHEVyrt1iq4dXHQJbTHrfrN1lAP83+fp
         o8Cg==
X-Gm-Message-State: AOJu0YxEP+7UqU/6I8jcNhCFB637Yff9gNXyVMjXWQzN32xPXKo/xmOj
	ZNsblou8n9lEIigsN5SRQTksmBppJ0oOn6fBoyWaWrb3d6n492yJ41fKcHuXr9rx4JklIaLKQxr
	S9HhpjxSyJfeSuEDisLz3zMlYUBjHRCnVF22bAqf/Yq16h3gtg7Nd/w==
X-Received: by 2002:a17:906:fe07:b0:a5a:81b0:a6a9 with SMTP id a640c23a62f3a-a5a81b0a73cmr2446484566b.53.1716286182717;
        Tue, 21 May 2024 03:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRdhoc2N3wtE730xVnMpA89nBQtXnC9LJWRX7m/mx+FTIPUDLCEt36je34xFicbR7eTgGF6A==
X-Received: by 2002:a17:906:fe07:b0:a5a:81b0:a6a9 with SMTP id a640c23a62f3a-a5a81b0a73cmr2446481266b.53.1716286182230;
        Tue, 21 May 2024 03:09:42 -0700 (PDT)
Received: from [172.16.2.75] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01dfcsm1589898066b.187.2024.05.21.03.09.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2024 03:09:40 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Pravin B Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesse Gross <jesse@nicira.com>,
 Ilya Maximets <i.maximets@ovn.org>, Simon Horman <horms@ovn.org>,
 Jaime Caamano <jcaamano@redhat.com>
Subject: Re: [PATCH v2 net] openvswitch: Set the skbuff pkt_type for proper
 pmtud support.
Date: Tue, 21 May 2024 12:09:39 +0200
X-Mailer: MailMate (1.14r6030)
Message-ID: <701FCF52-7D25-4094-9B0E-8F7AE8A68107@redhat.com>
In-Reply-To: <20240516200941.16152-1-aconole@redhat.com>
References: <20240516200941.16152-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 16 May 2024, at 22:09, Aaron Conole wrote:

> Open vSwitch is originally intended to switch at layer 2, only dealing with
> Ethernet frames.  With the introduction of l3 tunnels support, it crossed
> into the realm of needing to care a bit about some routing details when
> making forwarding decisions.  If an oversized packet would need to be
> fragmented during this forwarding decision, there is a chance for pmtu
> to get involved and generate a routing exception.  This is gated by the
> skbuff->pkt_type field.
>
> When a flow is already loaded into the openvswitch module this field is
> set up and transitioned properly as a packet moves from one port to
> another.  In the case that a packet execute is invoked after a flow is
> newly installed this field is not properly initialized.  This causes the
> pmtud mechanism to omit sending the required exception messages across
> the tunnel boundary and a second attempt needs to be made to make sure
> that the routing exception is properly setup.  To fix this, we set the
> outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get
> to the openvswitch module via a port device or packet command.
>
> Even for bridge ports as users, the pkt_type needs to be reset when
> doing the transmit as the packet is truly outgoing and routing needs
> to get involved post packet transformations, in the case of
> VXLAN/GENEVE/udp-tunnel packets.  In general, the pkt_type on output
> gets ignored, since we go straight to the driver, but in the case of
> tunnel ports they go through IP routing layer.
>
> This issue is periodically encountered in complex setups, such as large
> openshift deployments, where multiple sets of tunnel traversal occurs.
> A way to recreate this is with the ovn-heater project that can setup
> a networking environment which mimics such large deployments.  We need
> larger environments for this because we need to ensure that flow
> misses occur.  In these environment, without this patch, we can see:
>
>   ./ovn_cluster.sh start
>   podman exec ovn-chassis-1 ip r a 170.168.0.5/32 dev eth1 mtu 1200
>   podman exec ovn-chassis-1 ip netns exec sw01p1 ip r flush cache
>   podman exec ovn-chassis-1 ip netns exec sw01p1 \
>          ping 21.0.0.3 -M do -s 1300 -c2
>   PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
>   From 21.0.0.3 icmp_seq=2 Frag needed and DF set (mtu = 1142)
>
>   --- 21.0.0.3 ping statistics ---
>   ...
>
> Using tcpdump, we can also see the expected ICMP FRAG_NEEDED message is not
> sent into the server.
>
> With this patch, setting the pkt_type, we see the following:
>
>   podman exec ovn-chassis-1 ip netns exec sw01p1 \
>          ping 21.0.0.3 -M do -s 1300 -c2
>   PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
>   From 21.0.0.3 icmp_seq=1 Frag needed and DF set (mtu = 1222)
>   ping: local error: message too long, mtu=1222
>
>   --- 21.0.0.3 ping statistics ---
>   ...
>
> In this case, the first ping request receives the FRAG_NEEDED message and
> a local routing exception is created.
>
> Tested-by: Jaime Caamano <jcaamano@redhat.com>
> Reported-at: https://issues.redhat.com/browse/FDP-164
> Fixes: 58264848a5a7 ("openvswitch: Add vxlan tunneling support.")
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Thanks for the additional comments and detailed commit message. The change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


