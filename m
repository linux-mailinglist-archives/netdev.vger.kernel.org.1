Return-Path: <netdev+bounces-192758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63045AC10FA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F5DA41445
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61AC239E7B;
	Thu, 22 May 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fo9uMXKD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A4C45C14
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931242; cv=none; b=NPgEVDoG+h2VAyWcxaNeMld+o9YplPhPoRFmTmLGq8YOo15KqVCguQlfqk+eGd4lZbzIYkkHYqNhivsiJNbhgjRh6koV9uERVAIUlq/9IVSClHBu+x8pF+QM8O2jbaxf+rR3lXEFO7bc7EB468Z09qexvxw6G4F6oh8iabXkev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931242; c=relaxed/simple;
	bh=k5tZ6EAqyKtpxOECK0+bdTC9lwPvNiBRD3mfo2wJY5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oXRlOHNHErX0TKC/4oHEnM0In/kchCW4LhEZSZ0IVHwGMQKplwFMRF/d+ARUa7gb7j/MGXu16SMivIiS5iS8CE0k5RX+6l3/Auro+ErLvVbLfzmwSQXXnvXZc36hVXsGdXGT+O79hdmt7mAjMJP5NAa8xqq4H5DN8ItHX9JLBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fo9uMXKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747931239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I51PbxXuXP01mfBHDXWV3sPVN6sURhiRYf9mPTsKTPQ=;
	b=fo9uMXKDot2jVQYDM82UHR/mBuCAuHSas/UCwbFttek6aFft6LOKWuHaNrmwyx48JHEuya
	p05yCBUVA/5V726tm1b7bgJ17eSeCAV6fbrS7VtJuIL9+rhzkfFhBLEq6oYDGHbuO++5uR
	sEj6WDLjeFV6kmus7mRsOlAVOmUJu/g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468--WDdorttObOv16TllSTjUQ-1; Thu,
 22 May 2025 12:27:15 -0400
X-MC-Unique: -WDdorttObOv16TllSTjUQ-1
X-Mimecast-MFC-AGG-ID: -WDdorttObOv16TllSTjUQ_1747931234
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8354419560B5;
	Thu, 22 May 2025 16:27:13 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF54F19560AB;
	Thu, 22 May 2025 16:27:10 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3] net: openvswitch: Fix the dead loop of MPLS
 parse
In-Reply-To: <21855B7D-A3D5-4031-A618-CCA8FD75B6FD@zenlayer.com> (Faicker Mo's
	message of "Thu, 22 May 2025 07:49:08 +0000")
References: <21855B7D-A3D5-4031-A618-CCA8FD75B6FD@zenlayer.com>
Date: Thu, 22 May 2025 12:27:08 -0400
Message-ID: <f7ty0uod31f.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Faicker,

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
> <IRQ>
> show_stack+0x52/0x5c
> dump_stack_lvl+0x4a/0x63
> dump_stack+0x10/0x16
> ubsan_epilogue+0x9/0x36
> __ubsan_handle_out_of_bounds.cold+0x44/0x49
> key_extract_l3l4+0x82a/0x840 [openvswitch]
> ? kfree_skbmem+0x52/0xa0
> key_extract+0x9c/0x2b0 [openvswitch]
> ovs_flow_key_extract+0x124/0x350 [openvswitch]
> ovs_vport_receive+0x61/0xd0 [openvswitch]
> ? kernel_init_free_pages.part.0+0x4a/0x70
> ? get_page_from_freelist+0x353/0x540
> netdev_port_receive+0xc4/0x180 [openvswitch]
> ? netdev_port_receive+0x180/0x180 [openvswitch]
> netdev_frame_hook+0x1f/0x40 [openvswitch]
> __netif_receive_skb_core.constprop.0+0x23a/0xf00
> __netif_receive_skb_list_core+0xfa/0x240
> netif_receive_skb_list_internal+0x18e/0x2a0
> napi_complete_done+0x7a/0x1c0
> bnxt_poll+0x155/0x1c0 [bnxt_en]
> __napi_poll+0x30/0x180
> net_rx_action+0x126/0x280
> ? bnxt_msix+0x67/0x80 [bnxt_en]
> handle_softirqs+0xda/0x2d0
> irq_exit_rcu+0x96/0xc0
> common_interrupt+0x8e/0xa0
> </IRQ>
>
> Fixes: fbdcdd78da7c ("Change in Openvswitch to support MPLS label depth of 3 in ingress direction")

This tells me it should go to 'net' rather than 'net-next', so your
subject should look like:

  [PATCH net v4] net: openvswitch: Fix the dead loop of MPLS parse

> Signed-off-by: Faicker Mo <faicker.mo@zenlayer.com>
> ---
> v2
> - Changed return value based on Eelco's feedback.
> - Added Fixes.
> v3
> - Revert "Changed return value based on Eelco's feedback".
> - Changed the label_count variable type based on Ilya's feedback.


Somehow, this patch is still getting corrupted.  For example, it is
missing the leading ' ' character in the diffs.  This is one reason
the patch fails to apply.

> ---
> net/openvswitch/flow.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 8a848ce72e29..b80bd3a90773 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -788,7 +788,7 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
> 			memset(&key->ipv4, 0, sizeof(key->ipv4));
> 		}
> 	} else if (eth_p_mpls(key->eth.type)) {
> -		u8 label_count = 1;
> +		size_t label_count = 1;

This change looks good to me.

>
> 		memset(&key->mpls, 0, sizeof(key->mpls));
> 		skb_set_inner_network_header(skb, skb->mac_len);
> --
> 2.34.1


