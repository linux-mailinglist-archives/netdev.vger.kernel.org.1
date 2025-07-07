Return-Path: <netdev+bounces-204589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A53DAFB46E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82888179BF3
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87603289803;
	Mon,  7 Jul 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtjH+USe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E728934D
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894610; cv=none; b=soU61yqLwu+In2mECItZ7RmIEBlsXgwF7a6uZjaI94LTWD0gpvD+VaQ+m6/vk4BLkEa40kFhvIfsclB51cOlbqyyPvOnBj+WH979HqvnaH8rDC5nE9+vTer8DMtUWwOJ50wJPQgWwmy6FQ1qqTi4SY0itfGW8xo8UrM02VqE+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894610; c=relaxed/simple;
	bh=H0FeNN+P6Fwz9Kj2TemKg9xFvCUgymIvY3fuJdKM4sA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K4adfN3DqK5O2MkEcICFBcKaNSDfARh32atWfJVxKmx6Q/XSYKqKgHJy0iMZU4Knp2zUUl5FtQK4rYc5+JeUftKWz9auIkfkFmiBBl2qWxz8LtQxHxFI4Dud0lkpDjS/WxTUgkaMpGzKKwTRbI/egh00OjFyNOrJQoxNG7zUfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtjH+USe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751894607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHuO5AsaFT5+p2FY+QJGOYcUuUvgKM52ns+6Pc/fS2s=;
	b=OtjH+USeookGIQD3/NUOZqKSZOT+/BAyS6r4lLf6W5wXRYNWUTwzAhfEhQxrmmxzWVd2GJ
	W5wDLvapKtXxS+pk9nuohYC16sLCQI0P9ViHAiShWE8rmQQe8TPxjLNrrVsyc7FT3NFjl7
	kFqgBEo1Llt+H1Fz8Zr8XG173DvtVG0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-m2JorT6FMPm9joGRjbf9sA-1; Mon,
 07 Jul 2025 09:23:26 -0400
X-MC-Unique: m2JorT6FMPm9joGRjbf9sA-1
X-Mimecast-MFC-AGG-ID: m2JorT6FMPm9joGRjbf9sA_1751894605
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46956195FCC6;
	Mon,  7 Jul 2025 13:23:25 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7212C195608F;
	Mon,  7 Jul 2025 13:23:23 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org,  Eric Dumazet <edumazet@google.com>,  Simon
 Horman <horms@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v2] net: openvswitch: allow providing
 upcall pid for the 'execute' command
In-Reply-To: <20250702155043.2331772-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Wed, 2 Jul 2025 17:50:34 +0200")
References: <20250702155043.2331772-1-i.maximets@ovn.org>
Date: Mon, 07 Jul 2025 09:23:21 -0400
Message-ID: <f7ttt3oqgmu.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ilya Maximets <i.maximets@ovn.org> writes:

> When a packet enters OVS datapath and there is no flow to handle it,
> packet goes to userspace through a MISS upcall.  With per-CPU upcall
> dispatch mechanism, we're using the current CPU id to select the
> Netlink PID on which to send this packet.  This allows us to send
> packets from the same traffic flow through the same handler.
>
> The handler will process the packet, install required flow into the
> kernel and re-inject the original packet via OVS_PACKET_CMD_EXECUTE.
>
> While handling OVS_PACKET_CMD_EXECUTE, however, we may hit a
> recirculation action that will pass the (likely modified) packet
> through the flow lookup again.  And if the flow is not found, the
> packet will be sent to userspace again through another MISS upcall.
>
> However, the handler thread in userspace is likely running on a
> different CPU core, and the OVS_PACKET_CMD_EXECUTE request is handled
> in the syscall context of that thread.  So, when the time comes to
> send the packet through another upcall, the per-CPU dispatch will
> choose a different Netlink PID, and this packet will end up processed
> by a different handler thread on a different CPU.
>
> The process continues as long as there are new recirculations, each
> time the packet goes to a different handler thread before it is sent
> out of the OVS datapath to the destination port.  In real setups the
> number of recirculations can go up to 4 or 5, sometimes more.
>
> There is always a chance to re-order packets while processing upcalls,
> because userspace will first install the flow and then re-inject the
> original packet.  So, there is a race window when the flow is already
> installed and the second packet can match it and be forwarded to the
> destination before the first packet is re-injected.  But the fact that
> packets are going through multiple upcalls handled by different
> userspace threads makes the reordering noticeably more likely, because
> we not only have a race between the kernel and a userspace handler
> (which is hard to avoid), but also between multiple userspace handlers.
>
> For example, let's assume that 10 packets got enqueued through a MISS
> upcall for handler-1, it will start processing them, will install the
> flow into the kernel and start re-injecting packets back, from where
> they will go through another MISS to handler-2.  Handler-2 will install
> the flow into the kernel and start re-injecting the packets, while
> handler-1 continues to re-inject the last of the 10 packets, they will
> hit the flow installed by handler-2 and be forwarded without going to
> the handler-2, while handler-2 still re-injects the first of these 10
> packets.  Given multiple recirculations and misses, these 10 packets
> may end up completely mixed up on the output from the datapath.
>
> Let's allow userspace to specify on which Netlink PID the packets
> should be upcalled while processing OVS_PACKET_CMD_EXECUTE.
> This makes it possible to ensure that all the packets are processed
> by the same handler thread in the userspace even with them being
> upcalled multiple times in the process.  Packets will remain in order
> since they will be enqueued to the same socket and re-injected in the
> same order.  This doesn't eliminate re-ordering as stated above, since
> we still have a race between kernel and the userspace thread, but it
> allows to eliminate races between multiple userspace threads.
>
> Userspace knows the PID of the socket on which the original upcall is
> received, so there is no need to send it up from the kernel.
>
> Solution requires storing the value somewhere for the duration of the
> packet processing.  There are two potential places for this: our skb
> extension or the per-CPU storage.  It's not clear which is better,
> so just following currently used scheme of storing this kind of things
> along the skb.  We still have a decent amount of space in the cb.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>

Thanks Ilya - explanation is very clear.

Acked-by: Aaron Conole <aconole@redhat.com>


