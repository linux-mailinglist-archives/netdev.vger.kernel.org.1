Return-Path: <netdev+bounces-193110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A355AC28AE
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B4E1763A5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5EA19BBC;
	Fri, 23 May 2025 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdS32ODm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68BF367
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021455; cv=none; b=EV2Ap+/2QcoS79U1MPUJOvR9dUKrfxLVyOejNVtql+tOwNXzXY0jhdQ6rL/9nmXveI5IUsXM4j3nP9Kv+BDfnEmD2Sj0dhWPevqdh3H3E2GeyiMnsXYnnNuDJGR7pAmPSAH96RvyqrHExYIx4hgRc1agB82exnq7eGTCOcwhacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021455; c=relaxed/simple;
	bh=Qi/IN+h4XsFhYXgBftNT+PEc1k98O7aTToh+ONJLye4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nvwk5489EwnT0IwSKTqp6AixHens/qrzpxs/tGlh3Umd1eEqouaaw8JmgvQ/1VvvDriKSwCGNgp7mUAqzLBqiwy2930cvlRbb/bXQa1g6WTmExhQUAiCaWvzXu92zWXP3LdSo8iNs32a1GsmOqiTie/xi+bd/TJKsYKad5ILaUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdS32ODm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748021451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FD6jx9uozyc++phMPufHLP0bWbwFdC6+glLx/9QQr2Y=;
	b=XdS32ODmt4WJSp5pgMeqkfyB21jQ0kjHOkKiZRhYcvp8rh0bNzz6xbhQdt89SHZVm+mWIU
	qTRb6FJ2ssr1qplTLqnOhC/8lgEi7S0/ApLORnyA+qx+nAceUS+ofUMUCpSuu7OVV6WE2Q
	cNrSWmojO20tYRtFJt2pAPa6PlFhC8A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-5QYqqiVQNOmMLLbLxQaO4g-1; Fri,
 23 May 2025 13:30:47 -0400
X-MC-Unique: 5QYqqiVQNOmMLLbLxQaO4g-1
X-Mimecast-MFC-AGG-ID: 5QYqqiVQNOmMLLbLxQaO4g_1748021445
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7027618004AD;
	Fri, 23 May 2025 17:30:45 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 912A430001A1;
	Fri, 23 May 2025 17:30:42 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Faicker Mo <faicker.mo@zenlayer.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
  "dev@openvswitch.org" <dev@openvswitch.org>,  "echaudro@redhat.com"
 <echaudro@redhat.com>,  "i.maximets@ovn.org" <i.maximets@ovn.org>,
  "davem@davemloft.net" <davem@davemloft.net>,  "edumazet@google.com"
 <edumazet@google.com>,  "kuba@kernel.org" <kuba@kernel.org>,
  "pabeni@redhat.com" <pabeni@redhat.com>,  "horms@kernel.org"
 <horms@kernel.org>,  "martin.varghese@nokia.com"
 <martin.varghese@nokia.com>,  "pshelar@ovn.org" <pshelar@ovn.org>
Subject: Re: [PATCH net v4] net: openvswitch: Fix the dead loop of MPLS parse
In-Reply-To: <259D3404-575D-4A6D-B263-1DF59A67CF89@zenlayer.com> (Faicker Mo's
	message of "Fri, 23 May 2025 03:41:43 +0000")
References: <259D3404-575D-4A6D-B263-1DF59A67CF89@zenlayer.com>
Date: Fri, 23 May 2025 13:30:40 -0400
Message-ID: <f7tfrgv9qv3.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Faicker Mo <faicker.mo@zenlayer.com> writes:

> The unexpected MPLS packet may not end with the bottom label stack.
> When there are many stacks, The label count value has wrapped around.
> A dead loop occurs, soft lockup/CPU stuck finally.
>
> stack backtrace:
> UBSAN: array-index-out-of-bounds in /build/linux-0Pa0xK/linux-5.15.0/net/openvswitch/flow.c:662:26
> index -1 is out of range for type '__be32 [3]'
> CPU: 34 PID: 0 Comm: swapper/34 Kdump: loaded Tainted: G           OE   5.15.0-121-generic #131-Ubuntu
> Hardware name: Dell Inc. PowerEdge C6420/0JP9TF, BIOS 2.12.2 07/14/2021
> Call Trace:
>  <IRQ>
>  show_stack+0x52/0x5c
>  dump_stack_lvl+0x4a/0x63
>  dump_stack+0x10/0x16
>  ubsan_epilogue+0x9/0x36
>  __ubsan_handle_out_of_bounds.cold+0x44/0x49
>  key_extract_l3l4+0x82a/0x840 [openvswitch]
>  ? kfree_skbmem+0x52/0xa0
>  key_extract+0x9c/0x2b0 [openvswitch]
>  ovs_flow_key_extract+0x124/0x350 [openvswitch]
>  ovs_vport_receive+0x61/0xd0 [openvswitch]
>  ? kernel_init_free_pages.part.0+0x4a/0x70
>  ? get_page_from_freelist+0x353/0x540
>  netdev_port_receive+0xc4/0x180 [openvswitch]
>  ? netdev_port_receive+0x180/0x180 [openvswitch]
>  netdev_frame_hook+0x1f/0x40 [openvswitch]
>  __netif_receive_skb_core.constprop.0+0x23a/0xf00
>  __netif_receive_skb_list_core+0xfa/0x240
>  netif_receive_skb_list_internal+0x18e/0x2a0
>  napi_complete_done+0x7a/0x1c0
>  bnxt_poll+0x155/0x1c0 [bnxt_en]
>  __napi_poll+0x30/0x180
>  net_rx_action+0x126/0x280
>  ? bnxt_msix+0x67/0x80 [bnxt_en]
>  handle_softirqs+0xda/0x2d0
>  irq_exit_rcu+0x96/0xc0
>  common_interrupt+0x8e/0xa0
>  </IRQ>
>
> Fixes: fbdcdd78da7c ("Change in Openvswitch to support MPLS label depth of 3 in ingress direction")
> Signed-off-by: Faicker Mo <faicker.mo@zenlayer.com>
> ---
> v2
> - Changed return value based on Eelco's feedback.
> - Added Fixes.
> v3
> - Revert "Changed return value based on Eelco's feedback".
> - Changed the label_count variable type based on Ilya's feedback.
> v4
> - Changed the subject based on Aaron's feedback.
> - changed the format.
> ---
>  net/openvswitch/flow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Aaron Conole <aconole@redhat.com>


