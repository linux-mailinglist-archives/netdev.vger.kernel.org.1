Return-Path: <netdev+bounces-162546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA5A27344
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBE13A8338
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F822135D8;
	Tue,  4 Feb 2025 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMX9WLjk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99955212F93
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675639; cv=none; b=XxAxj2ArjdkhbvGNJv2jfaKt+O87erdV86wMU/3MAKYGCmJMVh6qLX9r40chQKvNH9oVJsQvBFGnG1NspkQifxRdfaRIkURg2fpDHM77bw2WeeCFJilz8PHPSBimHJiyJQqUkHB1pgIhVfwBMR71AkDqpObcqenr/ifsr02Wtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675639; c=relaxed/simple;
	bh=9ToLNaKSllX+Y74Da4IT7Nt3stUV02XitV8wmY+aecM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0rRX5MRc5a+c+R0N2e6xwtPf+89kChbIGNWJ5+ISIEoXLIk1rT+GuyrC0+9IWqJ6nwX5uHi41SpAKI1B0a7HQcL2fIB8KGZXJFaGhRBDTYBOunO+gO19tw2eGYOfgPfCYIOTWj0SB4vWyQS8AzDcz4X5AIeCpO/uXdTwud+Flw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMX9WLjk; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eba0f09c3aso1350101b6e.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738675636; x=1739280436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hJFCe4r1JqWHpb6rowEUKjHUMhVfLrRQAaQaxlemYYM=;
        b=OMX9WLjkNJ8mLZilPNBR/3HnH+GMOwSUN0koON97aFJWyo+W7cVyAt6vX4yeq17S+c
         LtqjZe+emR8dxoRkscGW4KldA7pX86tOtQSkG1ESXKc2xWbYHKcnx/7qZCSrTk25S8vE
         Z+7YYgQ7BV5ClJVsPm9qb6YNRi9Jv4w8CJrgjYIz1GqDatVM2q4C0UkHSgWCdm4hPzvB
         mMPmLmO1H45qzqpx0r+krdQxGy9ahDq4gIcYgi1ENNUfSjJ03ZXmKSvGso+T69/phA5z
         w8+erVUPv4NoSEVdDUvyqLI42Oa8RHu4gbF1JeokJoCeaR1yge7WVxOgxkxAzjLh08ST
         JFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675636; x=1739280436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJFCe4r1JqWHpb6rowEUKjHUMhVfLrRQAaQaxlemYYM=;
        b=crbtRxVtm8jQVKhIaG9rgkHkq+aeK9NDjkWn9yTWGe2Ap53gkzq6c/DIgPIlRJTlLx
         gedIkpDm1h75Kb4xuyhPe21rUxu7/ExGBPdNIDJkLvPlfoVyGV6YIk1qoobcaYPrnyT1
         0xzKonfPQsuAcCuYQfIjU22g2BWzYPQCEnd5uHjTkEgptbqLBstMSd2kKGjMh24ffzOV
         lFPUqZtcG6JPUly2dh2O82T8yJr17rUw6xApdci37HBsx9LKCSO+jVg9cqBcguBclb1d
         pV/h6fYHummNvCoxzMexQSvTAg/PRczkcfHhuyzSnaypzgSuY1nnbl9OaAyL0MUDWCGx
         fl1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK48Q9CUKDViwEyqNwqnEEqndNXGvRqyHqhELqlzqQzdxmLZNTWGBrG2n4VnjyeJ59c6bK5vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXU9kKqtjGkqOskBBGTVuqc8rr0MGLB/TAz3ajY9zRgOAQ7wV
	r1n0/0y3rnm9KpUtVfzjZVhTQkyXQ4XUP82jvoPJ86hLtOWnJcQ=
X-Gm-Gg: ASbGncsu6xcbW9Zbw6zTyI6czjF4xyqI7BX76AcLBAgG3bcECL7LRSTTv2ZxS2MQteg
	/+Dhtu7nIC/8NK1bWz0L+JIp8WZ/iz/ra6WX+mmJ52WqyV5NRZySwy9dwPd2uSQ8QzuNQPApM9e
	uDr2fGrzOGYF7XPkkcE/UtDoWs/Pd+Ppydyth/Q6lVevdkwNlkkA93HxNQ0wY2SD5BLNCuXqFfr
	YYmD4fRSAuJmBEWwVKLJVNloab/X/bEA90DvY84Z2F6eQ/QkVrXngEzf2D5bvqdhS8itFu5VCKR
	oXMqHw+5rkNM
X-Google-Smtp-Source: AGHT+IE8E3TA+EDWaTEAOgPgZzNszp37yWiLnIaYxQQaZv8wx8UbU3GfiS9JnsSdIoSdniYOzcz/GA==
X-Received: by 2002:a05:6808:191a:b0:3ea:5ef1:c95 with SMTP id 5614622812f47-3f323b4d4b0mr18498764b6e.25.1738675636361;
        Tue, 04 Feb 2025 05:27:16 -0800 (PST)
Received: from t-dallas ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726618c8aefsm3293400a34.67.2025.02.04.05.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 05:27:15 -0800 (PST)
Date: Tue, 4 Feb 2025 21:27:13 +0800
From: Ted Chen <znscnchen@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/3] vxlan: Support of Hub Spoke Network to
 use the same VNI
Message-ID: <Z6IVsbKw0CF+jSq3@t-dallas>
References: <20250201113207.107798-1-znscnchen@gmail.com>
 <Z59109CGe8WmZVsJ@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z59109CGe8WmZVsJ@shredder>

On Sun, Feb 02, 2025 at 03:40:35PM +0200, Ido Schimmel wrote:
> On Sat, Feb 01, 2025 at 07:32:07PM +0800, Ted Chen wrote:
> > This RFC series proposes an implementation to enable the configuration of vxlan
> > devices in a Hub-Spoke Network, allowing multiple vxlan devices to share the
> > same VNI while being associated with different remote IPs under the same UDP
> > port.
> > 
> > == Use case ==
> > In a Hub-Spoke Network, there is a central VTEP acting as the gateway, along
> > with multiple outer VTEPs. Each outer VTEP communicates exclusively with the
> > central VTEP and has no direct connection to other outer VTEPs. As a result,
> > data exchanged between outer VTEPs must traverse the central VTEP. This design
> > enhances security and enables centralized auditing and monitoring at the
> > central VTEP.
> > 
> > == Existing methods ==
> > Currently, there are three methods to implement the use case.
> > 
> > Method 1:
> >          The central VTEP establishes a separate vxlan tunnel with each outer
> >          VTEP, creating a vxlan device with a different VNI for each tunnel.
> >          All vxlan devices are then added to the same Linux bridge to enable
> >          forwarding.
> > 
> >          Drawbacks: Complex configuration.
> >          Each tenant requires multiple VNIs.
> 
> This looks like the most straightforward option to me.
> 
> Why do you view it as complex? Why multiple VNIs per tenant are a
> problem when we have 16M of them?
Yes, the issue is not due to a lack of VNIs.
IMO, using a single VNI within a single Layer 2 network is clearer and more
intuitive.

> > 
> > Method 2:
> >         The central VTEP creates a single vxlan device using the same VNI,
> >         without configuring a remote IP. The IP addresses of all outer VTEPs
> >         are stored in the fdb. To enable forwarding, the vxlan device is added
> >         to a Linux bridge with hairpin mode enabled.
> > 
> >         Drawbacks: unnecessary overhead or network anomalies
> >         The hairpin mode may broadcast packets to all outer VTEPs, causing the
> >         source outer VTEP receiving packets it originally sent to the central
> >         VTEP. If the packet from the source outer VTEP is a broadcast packet,
> >         the broadcasting back of the packet can cause network anomalies.
> > 
> > Method 3:
> >         The central VTEP uses the same VNI but different UDP ports to create a
> >         vxlan device for each outer VTEP, each tunneling to its corresponding
> >         outer VTEP. All the vxlan devices in the central VTEP are then added to
> >         the same Linux bridge to enable forwarding.
> > 
> >         Drawbacks: complex configuration and potential security issues.
> >         Multiple UDP ports are required.
> > 
> > == Proposed implementation ==
> > In the central VTEP, each tenant only requires a single VNI, and all tenants
> > share the same UDP port. This can avoid the drawbacks of the above three
> > methods.
> 
> This method also has drawbacks. It breaks existing behavior (see my
> comment on patch #1) and it also bloats the VXLAN receive path.
> 
> I want to suggest an alternative which allows you to keep the existing
> topology (same VNI), but without kernel changes. The configuration of
> the outer VTEPs remains the same. The steps below are for the central
> VTEP.
> 
> First, create a VXLAN device in "external" mode. It will consume all the
> VNIs in a namespace, but you can limit it with the "vnifilter" keyword,
> if needed:
> 
> # ip -n ns_c link add name vx0 type vxlan dstport 4789 nolearning external
> # tc -n ns_c qdisc add dev vx0 clsact
> 
> Then, for each outer VTEP, create a dummy device and enslave it to the
> bridge. Taking outer VTEP1 as an example:
> 
> # ip -n ns_c link add name dummy_vtep1 up master br0
> # tc -n ns_c qdisc add dev dummy_vtep1 clsact
> 
> In order to demultiplex incoming VXLAN packets to the appropriate bridge
> member, use an ingress tc filter on the VXLAN device that matches on the
> encapsulating source IP (you can't do it w/o the "external" keyword) and
> redirects the traffic to the corresponding bridge member:
> 
> # tc -n ns_c filter add dev vx0 ingress pref 1 proto all \
> 	flower enc_key_id 42 enc_src_ip 10.0.0.1 \
> 	action mirred ingress redirect dev dummy_ns1
> 
> (add filters for other VTEPs with "pref 1" to avoid unnecessary
> lookups).
> 
> For Tx, on each bridge member, configure an egress tc filter that
> attaches tunnel metadata for the matching outer VTEP and redirects to
> the VXLAN device:
> 
> # tc -n ns_c filter add dev dummy_vtep1 egress pref 1 proto all \
> 	matchall \
> 	action tunnel_key set src_ip 10.0.0.3 dst_ip 10.0.0.1 id 42 dst_port 4789 \
> 	action mirred egress redirect dev vx0
> 
> The end result should be that the bridge forwards known unicast traffic
> to the appropriate outer VTEP and floods BUM traffic to all the outer
> VTEPs but the one from which the traffic was received.
Cool!
I wasn’t aware that TC could be used in this way. Will give it a try.

Thanks a lot!

> > 
> > As in below example,
> > - a tunnel is established between vxlan42.1 in the central VTEP and vxlan42 in
> >   the outer VTEP1:
> >   ip link add vxlan42.1 type vxlan id 42 \
> >           local 10.0.0.3 remote 10.0.0.1 dstport 4789
> > 
> > - a tunnel is established between vxlan42.2 in the central VTEP and vxlan42 in
> >   the outer VTEP2:
> >   ip link add vxlan42.2 type vxlan id 42 \
> >   		  local 10.0.0.3 remote 10.0.0.2 dstport 4789
> > 
> > 
> >     ┌────────────────────────────────────────────┐
> >     │       ┌─────────────────────────┐  central │
> >     │       │          br0            │    VTEP  │
> >     │       └─┬────────────────────┬──┘          │
> >     │   ┌─────┴───────┐      ┌─────┴───────┐     │          
> >     │   │ vxlan42.1   │      │  vxlan42.2  │     │
> >     │   └─────────────┘      └─────────────┘     │  
> >     └───────────────────┬─┬──────────────────────┘
> >                         │ │ eth0 10.0.0.3:4789
> >                         │ │            
> >                         │ │            
> >        ┌────────────────┘ └───────────────┐
> >        │eth0 10.0.0.1:4789                │eth0 10.0.0.2:4789
> >  ┌─────┴───────┐                    ┌─────┴───────┐
> >  │outer VTEP1  │                    │outer VTEP2  │
> >  │     vxlan42 │                    │     vxlan42 │
> >  └─────────────┘                    └─────────────┘
> > 
> > 
> > == Test scenario ==
> > ip netns add ns_1
> > ip link add veth1 type veth peer name veth1-peer
> > ip link set veth1 netns ns_1
> > ip netns exec ns_1 ip addr add 10.0.1.1/24 dev veth1
> > ip netns exec ns_1 ip link set veth1 up
> > ip netns exec ns_1 ip link add vxlan42 type vxlan id 42 \
> >                    remote 10.0.1.3 dstport 4789
> > ip netns exec ns_1 ip addr add 192.168.0.1/24 dev vxlan42
> > ip netns exec ns_1 ip link set up dev vxlan42
> > 
> > ip netns add ns_2
> > ip link add veth2 type veth peer name veth2-peer
> > ip link set veth2 netns ns_2
> > ip netns exec ns_2 ip addr add 10.0.1.2/24 dev veth2
> > ip netns exec ns_2 ip link set veth2 up
> > ip netns exec ns_2 ip link add vxlan42 type vxlan id 42 \
> >                    remote 10.0.1.3 dstport 4789
> > ip netns exec ns_2 ip addr add 192.168.0.2/24 dev vxlan42
> > ip netns exec ns_2 ip link set up dev vxlan42
> > 
> > ip netns add ns_c
> > ip link add veth3 type veth peer name veth3-peer
> > ip link set veth3 netns ns_c
> > ip netns exec ns_c ip addr add 10.0.1.3/24 dev veth3
> > ip netns exec ns_c ip link set veth3 up
> > ip netns exec ns_c ip link add vxlan42.1 type vxlan id 42 \
> >                    local 10.0.1.3 remote 10.0.1.1 dstport 4789
> > ip netns exec ns_c ip link add vxlan42.2 type vxlan id 42 \
> >                    local 10.0.1.3 remote 10.0.1.2 dstport 4789
> > ip netns exec ns_c ip link set up dev vxlan42.1
> > ip netns exec ns_c ip link set up dev vxlan42.2
> > ip netns exec ns_c ip link add name br0 type bridge
> > ip netns exec ns_c ip link set br0 up
> > ip netns exec ns_c ip link set vxlan42.1 master br0
> > ip netns exec ns_c ip link set vxlan42.2 master br0
> > 
> > ip link add name br1 type bridge
> > ip link set br1 up
> > ip link set veth1-peer up
> > ip link set veth2-peer up
> > ip link set veth3-peer up
> > ip link set veth1-peer master br1
> > ip link set veth2-peer master br1
> > ip link set veth3-peer master br1
> > 
> > ip netns exec ns_1 ping 192.168.0.2 -I 192.168.0.1
> > 
> > Ted Chen (3):
> >   vxlan: vxlan_vs_find_vni(): Find vxlan_dev according to vni and
> >     remote_ip
> >   vxlan: Do not treat vxlan dev as used when unicast remote_ip
> >     mismatches
> >   vxlan: vxlan_rcv(): Update comment to inlucde ipv6
> > 
> >  drivers/net/vxlan/vxlan_core.c | 38 +++++++++++++++++++++++++++-------
> >  1 file changed, 31 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.39.2
> > 
> > 

