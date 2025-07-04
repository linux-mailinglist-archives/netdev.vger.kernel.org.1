Return-Path: <netdev+bounces-204128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF0AF9100
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AD23B5B4F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F58D2EF9DD;
	Fri,  4 Jul 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4Iryfxp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225562EF653
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626674; cv=none; b=OtCTwgU7MOehuzTYmk0RmUY9sVR1t77iIWXqrzV9jMuSI9oj+vwghA0YIFl7zmu9fNYk1tkJvOPj3cl2JlVwvhnNFwMmaxIW3pPGxrlCYVt1d8NOJ/SWFD7ABDZUtDO3I0LyGdOC7q3zKaO6EX8IAPRFnQnqmvc9lOiSRUFYBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626674; c=relaxed/simple;
	bh=1cxKkZFvCDOhTzY2nmvDiN/WHQTDMZaVAEL8yNSOdDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBRK+W0WnCI8v1AC+SvvxY3rzwygnRA+nfppKLcb2u6nyml+wqMpB0c5KyK7kJzg9bpRD6HCiAw3qBmZePQRLC7br1gyVzGqkQgzq+lOJMot0C5rULSlS23JE5MTTGF6qgBWeip7oE4P3pNidTP7rif0PCJJAvBsgsjNdp3+e98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4Iryfxp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751626671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrvE7HgkF0Duv49KG//QWMSmUEkIXLGid+oDz5Nnx5A=;
	b=e4Iryfxp2TAllzIX3PaEfyQsD+pCCfEvwr/pWz2lECeC0k2cgAOZn2RcwSUNFFuEOEuC4v
	4IdaN1I8h6rMTY9fbn4Fpoq7B8NrhElNAHRn7awYNufJNVLNuq60VqIcWoegQ1J+FJSuPY
	4LcbPlBf9b03dRRo1zUfu2MvKrrok44=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-55XnJ-WjOlKAAv85fMuvuQ-1; Fri, 04 Jul 2025 06:57:47 -0400
X-MC-Unique: 55XnJ-WjOlKAAv85fMuvuQ-1
X-Mimecast-MFC-AGG-ID: 55XnJ-WjOlKAAv85fMuvuQ_1751626667
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-607206f0d57so791050a12.2
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 03:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751626667; x=1752231467;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrvE7HgkF0Duv49KG//QWMSmUEkIXLGid+oDz5Nnx5A=;
        b=wyYO6v+lKWA3eSCJHElX/WaBjLaHyVNejeax0elYXLOm4z39XKERvaL5H+FhFXcWNb
         NUi2kVsw2K8Sn66ZUVmk7J97GmP0eGJ6f99n1U3FUP9PB1x2ORh6/v+rjpQxiRUiE6Wc
         2HVvueDClxFPa352ZcICDX5s0/UiAhfZAMehBrvBnYg10mmoBoOHYp3LRZDzobMf+Gl0
         RF5w+zlcUyWbC4lf0RuQ00s9T97iKaNzwj0VpepAeUzuOCPoIMtTRpL0LyFTV11Y9uj/
         XNfwDxMdYP5HR0LkVbZEP4Xvy8osOdGtecF6SIAJJX75t4i940h2udduqTCDPi3vgGeQ
         COdQ==
X-Gm-Message-State: AOJu0Yz4HtwvnuQ97YfNs1MDMpQV/GaSg8zBuNXEmYtDP5SKtfiGmnW6
	mwF5NDP5Ggv9OK1wLmvk1zRk8MMjbkerncNraBodV/nAtPFBmuxURjce2xHdX5nlAruQNb+6Vq4
	NyvTf/bhKSV6sDyc4U6zwQYDP2hKSiIArHNGOAUu/URPnpC6wHD9OQKzlIQ==
X-Gm-Gg: ASbGncvi/0FZydnCUu8sqHEcC81wiASZW7WNf7Gn6zSDwlCNFK0qzSiEJJd83uNkfAD
	eAie7lSLP69N+zPmVcsBNuyaKpOYV4RTkrZYhiPJq8zUMiQ4IqSernD+3ApzSeZ1d9awmzT8gGu
	XWRVkpRmK0E1isPh+Xj6/mU6A3Vhnm0hMCp19QuNa9vGz+fRh4+suLcJbywTbEQmcZwXzzFGp98
	KsCw+s3mQdlUAsVLvDCjU59wIWlOKr5hdT5WeIgDRiUQwnovLTBY6W6zPKkVB1flEfyf384C5Ww
	Mx4BMVn6JNb0pZsShZmkfAumMhv3bex707XrntV1CZVtL7HYiqXHvJdVTVH/dnL0EP7J
X-Received: by 2002:a05:6402:3591:b0:609:b5e0:598a with SMTP id 4fb4d7f45d1cf-60fd3491e75mr1660546a12.24.1751626666599;
        Fri, 04 Jul 2025 03:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcyEXrT1z/JTIyDwlwHTVjdjScy5iO7EyP/8wawH2bxWvrpwpkH9Px/UxRdIe8p7HXgydn3w==
X-Received: by 2002:a05:6402:3591:b0:609:b5e0:598a with SMTP id 4fb4d7f45d1cf-60fd3491e75mr1660526a12.24.1751626666058;
        Fri, 04 Jul 2025 03:57:46 -0700 (PDT)
Received: from [10.45.225.135] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6641fbsm1164917a12.3.2025.07.04.03.57.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:57:45 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next v2] net: openvswitch: allow providing upcall pid
 for the 'execute' command
Date: Fri, 04 Jul 2025 12:57:44 +0200
X-Mailer: MailMate (2.0r6272)
Message-ID: <0DF63EA6-305E-4F76-A88C-F2520198702B@redhat.com>
In-Reply-To: <20250702155043.2331772-1-i.maximets@ovn.org>
References: <20250702155043.2331772-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 2 Jul 2025, at 17:50, Ilya Maximets wrote:

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

Thanks for working on fixing this, and for the detailed explanation!

Acked-by: Eelco Chaudron <echaudro@redhat.com>


