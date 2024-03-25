Return-Path: <netdev+bounces-81537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF8488A1A9
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704B91C31F18
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9415539D;
	Mon, 25 Mar 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5cZI1NR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B08179970
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356265; cv=none; b=oPKJhhCDQpVwID1KOwC0OnOZzUFWSY+of1E9fto8Egq+0B8228Cv0KBr96B9mMe0sSDpGScdKTGQFrnmyDE1e1j797NJM/MUpQhXAO/I0L9JMQyL87oEup/2kKmIOBLDKLMBc/Z/HYy0h0ZS4kJO5V2t3FaaOP2UKfqR1+yHc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356265; c=relaxed/simple;
	bh=cdQBhEPIFiLVjBcaNV1Bn89SfFgexIJqtcggmv1x39M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0ziIjUXtQuVHxbtqDXJHcBAjEYp8YXVi1scwhOVvEKCgdhE1BO1P3aIL5paoy/G8vztqTmuGRelPvz+Ex0AkQAD7mA1QosJBR/17SsblCvK1UoWQ8XhD4r+8b1cpnoTwS5hpIuJGcchZM0UcIk7hoc4f0Tf0dU6VyPbZTCGspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5cZI1NR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711356262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cAw1vIzqpoWS5Z80GAOYQKaIMJGQe1l/kUnXEkorTI=;
	b=L5cZI1NRqloLxioXFH8O/E8WBQz/uGQaLuzGgzlE9fFeCX32SrdOmNHZGcWawqw8ijvVDq
	OMYyQP5f+IGckCPdgPCIR7bAUBNrgy1EmlXRI5U5LCZMetpYFv1r/n1e8m1I5ZOIze3M78
	+Etv+gLRoChgLRJwrm9rgjAsJOfuH4c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-F84R4VWsNuejSZAVqY4juA-1; Mon, 25 Mar 2024 04:44:20 -0400
X-MC-Unique: F84R4VWsNuejSZAVqY4juA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-568b1075d18so2241102a12.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 01:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711356257; x=1711961057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cAw1vIzqpoWS5Z80GAOYQKaIMJGQe1l/kUnXEkorTI=;
        b=EdHJLExQXiDaloKmmPMHldPPPDwCFan7S/2/7La5fidOl/GQD4vVvKWuUoWbh9/WtO
         StrGIBGwXcMLkBzIu2yKAd3qiUCNQHk2qf4AW8O+AVdmC2dKnX5yyYK4XC/dux7UzCX0
         76JFfj4IqMt7jkcyXWDC7IO6WvAgtdzxk8HDl0vvqWZqpKRKbZvuh06xMwh0mDgLtvnJ
         tuwrcibeyKt21dwfQk7FRV8nnVAfqTsnMqtP3t8uIrg4wWV2fzcAHpFuTUMEZvYTXcoZ
         ChhCAur0/QPRRlAUDsF6/ExQ1kmMyokw0RKMzcmKIL9Vk/tUSgxzQrqQITlxa/wSsmnA
         M78g==
X-Gm-Message-State: AOJu0YyB//M6uJsrv1avd4lKU+OGhywqmGL4oGhVAHvhGjlcDkts9Soi
	99sA+pz+0837ILAB1Uh1kIkJF6kTTD4qBDK7iw1i5oK6B5Tr4osvnDjlPl4GkvLPrtnRIX+tdsD
	fcPXkE44OCQIRTaDpUuTackS7TnRpFFm4j82GylMt8YOPQz/48q7/k887aRb+Uw==
X-Received: by 2002:a50:8d05:0:b0:566:fbf5:a279 with SMTP id s5-20020a508d05000000b00566fbf5a279mr4066301eds.20.1711356257723;
        Mon, 25 Mar 2024 01:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvUShEMrfi9tKxt+iYxeHTBBPxyZUeP8a62WImbipp6rM+N/Z56tOcX171CRPJlIQKv3wriQ==
X-Received: by 2002:a50:8d05:0:b0:566:fbf5:a279 with SMTP id s5-20020a508d05000000b00566fbf5a279mr4066292eds.20.1711356257368;
        Mon, 25 Mar 2024 01:44:17 -0700 (PDT)
Received: from [172.16.1.27] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402521300b00568d5e737b0sm2701431edd.57.2024.03.25.01.44.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 01:44:16 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Numan Siddique <nusiddiq@redhat.com>
Subject: Re: [PATCH net] openvswitch: Set the skbuff pkt_type for proper pmtud
 support.
Date: Mon, 25 Mar 2024 09:44:16 +0100
X-Mailer: MailMate (1.14r6028)
Message-ID: <7AFF5D6D-568C-449B-83CF-9436DE97CA91@redhat.com>
In-Reply-To: <20240322190603.251831-1-aconole@redhat.com>
References: <20240322190603.251831-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 22 Mar 2024, at 20:06, Aaron Conole wrote:

> Open vSwitch is originally intended to switch at layer 2, only dealing =
with
> Ethernet frames.  With the introduction of l3 tunnels support, it cross=
ed
> into the realm of needing to care a bit about some routing details when=

> making forwarding decisions.  If an oversized packet would need to be
> fragmented during this forwarding decision, there is a chance for pmtu
> to get involved and generate a routing exception.  This is gated by the=

> skbuff->pkt_type field.
>
> When a flow is already loaded into the openvswitch module this field is=

> set up and transitioned properly as a packet moves from one port to
> another.  In the case that a packet execute is invoked after a flow is
> newly installed this field is not properly initialized.  This causes th=
e
> pmtud mechanism to omit sending the required exception messages across
> the tunnel boundary and a second attempt needs to be made to make sure
> that the routing exception is properly setup.  To fix this, we set the
> outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get
> to the openvswitch module via a port device or packet command.

Is this not a problem when the packet comes from the bridge port in the k=
ernel?

> This issue is periodically encountered in complex setups, such as large=

> openshift deployments, where multiple sets of tunnel traversal occurs.
> A way to recreate this is with the ovn-heater project that can setup
> a networking environment which mimics such large deployments.  In that
> environment, without this patch, we can see:
>
>   ./ovn_cluster.sh start
>   podman exec ovn-chassis-1 ip r a 170.168.0.5/32 dev eth1 mtu 1200
>   podman exec ovn-chassis-1 ip netns exec sw01p1  ip r flush cache
>   podman exec ovn-chassis-1 ip netns exec sw01p1 ping 21.0.0.3 -M do -s=
 1300 -c2
>   PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
>   From 21.0.0.3 icmp_seq=3D2 Frag needed and DF set (mtu =3D 1142)
>
>   --- 21.0.0.3 ping statistics ---
>   2 packets transmitted, 0 received, +1 errors, 100% packet loss, time =
1017ms
>
> Using tcpdump, we can also see the expected ICMP FRAG_NEEDED message is=
 not
> sent into the server.
>
> With this patch, setting the pkt_type, we see the following:
>
>   podman exec ovn-chassis-1 ip netns exec sw01p1 ping 21.0.0.3 -M do -s=
 1300 -c2
>   PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
>   From 21.0.0.3 icmp_seq=3D1 Frag needed and DF set (mtu =3D 1222)
>   ping: local error: message too long, mtu=3D1222
>
>   --- 21.0.0.3 ping statistics ---
>   2 packets transmitted, 0 received, +2 errors, 100% packet loss, time =
1061ms
>
> In this case, the first ping request receives the FRAG_NEEDED message a=
nd
> a local routing exception is created.
>
> Reported-at: https://issues.redhat.com/browse/FDP-164
> Fixes: 58264848a5a7 ("openvswitch: Add vxlan tunneling support.")
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
> NOTE: An alternate approach would be to add a netlink attribute to pres=
erve
>       pkt_type across the kernel->user boundary, but that does require =
some
>       userspace cooperation.

I prefer the method in this patch, as it requires no userspace change, i.=
e. it will work even with older versions of OVS without the need for back=
ports.

>  net/openvswitch/actions.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 6fcd7e2ca81fe..952c6292100d0 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -936,6 +936,8 @@ static void do_output(struct datapath *dp, struct s=
k_buff *skb, int out_port,
>  				pskb_trim(skb, ovs_mac_header_len(key));
>  		}
>
> +		skb->pkt_type =3D PACKET_OUTGOING;
> +

Maybe add a comment based on the large explanation above?

>  		if (likely(!mru ||
>  		           (skb->len <=3D mru + vport->dev->hard_header_len))) {
>  			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
> -- =

> 2.41.0


