Return-Path: <netdev+bounces-178287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0369A76655
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3813A8670
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734E21018F;
	Mon, 31 Mar 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7VWA6y6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5D1E32B9
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425420; cv=none; b=RHqkX7s2zun9oeq0jmNM/f2DFBN8oH4Jh8CMqMw3l6ok7RwEdiYbfvM+5S+kS1a/UWtJ9V+qEWMntitB/stEYxMYZwS/rpSBsz+QdWo0lusNtwQxskgcyZMNmVA+AW6nH/avDv9dqFL6k/FO+u3axoFjtEaMdJw6wT4aeOr0ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425420; c=relaxed/simple;
	bh=SW3ONDZMYya4KBy0oEZkmBYKj2pWTuwXv08rG2NsZo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PX52DQRiQeaV9u3eRuTHiH08pCUOkCU3rZ0GtxUHDSDJhA7v6vImqfoI1OuDiosv4YJ3cPyCjRfwVFiZ9SumsIPMmnZUbBUjmfqzpEGCtW+tF+ASa6urdK9cnNc9VB4LCRIaauvJ+6uv+EliqvDI2WUFsgYDSJsowpo/9zmkD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7VWA6y6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743425415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SW3ONDZMYya4KBy0oEZkmBYKj2pWTuwXv08rG2NsZo0=;
	b=R7VWA6y6fm2mVykhDyYaaNhUcrmiVZOQeNlJnxRrInJUYR71iNLHOua7UPgYh9269ZLEfh
	lO/yi3pe/WdQi3Vl0jNzHn+ubjyodwsM5XMcROpOpWdkfI+Adj9+w8QePpFsLlnMK4zNgt
	KPdM/plNLfRhHEDM7hR8PxbJY8N3ddI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-ZRrQJD0COBWsF_znMV3BhQ-1; Mon,
 31 Mar 2025 08:50:11 -0400
X-MC-Unique: ZRrQJD0COBWsF_znMV3BhQ-1
X-Mimecast-MFC-AGG-ID: ZRrQJD0COBWsF_znMV3BhQ_1743425410
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7158B19560A2;
	Mon, 31 Mar 2025 12:50:10 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.89.226])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C6B8180B489;
	Mon, 31 Mar 2025 12:50:07 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Eric Dumazet <edumazet@google.com>,
  netdev@vger.kernel.org,  Simon Horman <horms@kernel.org>,  David Ahern
 <dsahern@kernel.org>,  Pravin B Shelar <pshelar@ovn.org>,  Eelco Chaudron
 <echaudro@redhat.com>,  Stefano Brivio <sbrivio@redhat.com>,
  dev@openvswitch.org
Subject: Re: [PATCH net] tunnels: Accept PACKET_HOST in
 skb_tunnel_check_pmtu().
In-Reply-To: <eac941652b86fddf8909df9b3bf0d97bc9444793.1743208264.git.gnault@redhat.com>
	(Guillaume Nault's message of "Sat, 29 Mar 2025 01:33:44 +0100")
References: <eac941652b86fddf8909df9b3bf0d97bc9444793.1743208264.git.gnault@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 31 Mar 2025 08:50:05 -0400
Message-ID: <f7tr02dnz42.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Guillaume Nault <gnault@redhat.com> writes:

> Because skb_tunnel_check_pmtu() doesn't handle PACKET_HOST packets,
> commit 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper
> pmtud support.") forced skb->pkt_type to PACKET_OUTGOING for
> openvswitch packets that are sent using the OVS_ACTION_ATTR_OUTPUT
> action. This allowed such packets to invoke the
> iptunnel_pmtud_check_icmp() or iptunnel_pmtud_check_icmpv6() helpers
> and thus trigger PMTU update on the input device.
>
> However, this also broke other parts of PMTU discovery. Since these
> packets don't have the PACKET_HOST type anymore, they won't trigger the
> sending of ICMP Fragmentation Needed or Packet Too Big messages to
> remote hosts when oversized (see the skb_in->pkt_type condition in
> __icmp_send() for example).
>
> These two skb->pkt_type checks are therefore incompatible as one
> requires skb->pkt_type to be PACKET_HOST, while the other requires it
> to be anything but PACKET_HOST.
>
> It makes sense to not trigger ICMP messages for non-PACKET_HOST packets
> as these messages should be generated only for incoming l2-unicast
> packets. However there doesn't seem to be any reason for
> skb_tunnel_check_pmtu() to ignore PACKET_HOST packets.
>
> Allow both cases to work by allowing skb_tunnel_check_pmtu() to work on
> PACKET_HOST packets and not overriding skb->pkt_type in openvswitch
> anymore.
>
> Fixes: 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper pmtud support.")
> Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---

Thanks, Guillaume.

Reviewed-by: Aaron Conole <aconole@redhat.com>

I did manage to test this with two hosts over the weekend, and it
appears to work for at least one forwarding case that I encountered.

Tested-by: Aaron Conole <aconole@redhat.com>


