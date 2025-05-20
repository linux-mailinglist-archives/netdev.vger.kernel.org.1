Return-Path: <netdev+bounces-191736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36386ABD016
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E41B633AF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369B25C829;
	Tue, 20 May 2025 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6c83bFW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FFEEC8
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747724976; cv=none; b=ajVoueYubSJlxJhdHDq9M5qFUJNXvWsdeQtPzQFKqFRHURpWo1WFWmCyZt3J4yk0m5OEanELkH79/KUuqS78NR7+pziRsp7eI68sEWSrxEAySmqU/BEjGeOiMMCVSwHWlhvYXkxK12H5IqptwCj9WOwj3UF5d6fgx/+xZUO7yn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747724976; c=relaxed/simple;
	bh=3Jr9N6ml4oWa18eiywR4fE3F63DyBTroaWxscDqwQiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkJxxA5F8j/HIkzLx7skxFu3omDi9JOZsPhD7CTBgxxR0QoawvmtrtHfql/pcZXHa6nCgw2TX1q9shDM2uq8CUWe9gxRaG5GoaR12E+a4i7hffdp98N0aw/R+wDIVCuyUmAdD0+9M7t6rgDRdtWetjiYULZU3TOHw441IqmbmiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6c83bFW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747724973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPiUSjLHF4gLesmtJHJcro9L18Me5fMnFwXUCoovFpI=;
	b=Q6c83bFW88SyGs6knfjH3Pp9SGv8OT28rNtiiTAnvP565JOvwW9dy3bOyjLutNjPigy0E9
	cwcwX5VBCQh9sZpndH0ew2RWM3+tdggiyngOfnVhw7SmCcHri5ahC+JVKGza9siiDJvRZD
	QQpE7jlY7TDsMFTMWJFfD+XhkaZutZQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-SQuZnXb5Of-OxEbSMo_dZQ-1; Tue, 20 May 2025 03:09:31 -0400
X-MC-Unique: SQuZnXb5Of-OxEbSMo_dZQ-1
X-Mimecast-MFC-AGG-ID: SQuZnXb5Of-OxEbSMo_dZQ_1747724971
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad5385781d8so189167566b.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 00:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747724970; x=1748329770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPiUSjLHF4gLesmtJHJcro9L18Me5fMnFwXUCoovFpI=;
        b=h/Y5aQy+ZBQGSJgXO0CbEozR5U//6tTIeWKl1fMj6ZBr87aYroGKCy4uYRGqsQrPCL
         zpkN3bb6Thfm9XriXVdHppG598s+Y336V0ktjJzciWguaKjLGkWKIjz/9JTc/PHTze7d
         q+2tYO8EjeKxUL5W7VgaKGINwbEeN+jMZEWmYlk4eWdlFexbH33+ngyA+QT26+zLDvKg
         6LbRDFDxGcwpMFvxDRI7sjO+HUc95707Hem2n3c29TwQaErV5k30tKZTPt4Z8ZJEfTIi
         HF55b8t85YiQoercWPpQs2cDx0ToRQ8o6ALi4VqARIGxOh27z5UhguW3RIwOlieALsID
         q7YA==
X-Gm-Message-State: AOJu0YxXuFOsc38LpIMiChXJTlpWXe2Fcokx6nWl9me7XpiUqIlUjqw1
	cMBq8PW7TyZv1u0KQdQBkz5dNLTRF3mhMpDViEimklTSrpO25HwimBOlRUmTOwZNvZZ9bNQuYue
	L4U1NyhbIJL4DCSmqv1cqATjhSYCSsZQaX18j8CLPlvZaDyAnfwm3fbJd8w==
X-Gm-Gg: ASbGnctfG7FmwW1QwM6N45ni5lNDDCNuRbMMV4xOz9WGJw7afrfq8UJZt9F7y4M9vWj
	wyuuZS3ZOlWkSTX601Ha39YLbtaW+/Xff0uakb1YgsT3xdhf1o0G5f6GbfHilHaBN8xqR8GwBtt
	797loabcfl2ys1YoHvMvMLPkHydwn6bi2adh2nysj6F+VV5kwAw2i4HtCHKt6qf/hM0v/jPl73F
	DadOlq9GZNz9YcYGV3gj60pKp6aL5ub2AVvB4JBMVlov5+FpmdKoe0qqSUPzzZnB6gfhzo5fpA/
	nnKyhG+UBt0dY2xj+poTiX+xrj5hgCEIeZ8XJbJNNakOiARHaRNE1v+bpyuO
X-Received: by 2002:a17:907:1b0d:b0:acb:88ac:e30f with SMTP id a640c23a62f3a-ad52d48d9d3mr1435406166b.20.1747724970613;
        Tue, 20 May 2025 00:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHingV5qboFtsC1ibat0oMgCtpdeyeKGmJN6kIOJ5q97vPKOK4rqpkRhlkTwxzKBLEfD8brsw==
X-Received: by 2002:a17:907:1b0d:b0:acb:88ac:e30f with SMTP id a640c23a62f3a-ad52d48d9d3mr1435403566b.20.1747724970191;
        Tue, 20 May 2025 00:09:30 -0700 (PDT)
Received: from [172.16.2.38] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4f8c20sm680236266b.181.2025.05.20.00.09.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2025 00:09:29 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Faicker Mo <faicker.mo@zenlayer.com>
Cc: netdev@vger.kernel.org, ovs-dev@openvswitch.org, aconole@redhat.com,
 Ilya Maximets <i.maximets@ovn.org>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH] net: openvswitch: Fix the dead loop of MPLS parse
Date: Tue, 20 May 2025 09:09:27 +0200
X-Mailer: MailMate (2.0r6256)
Message-ID: <CBE61C0A-20CB-4AD7-8C38-4C6084A1686E@redhat.com>
In-Reply-To: <SJ0PR20MB60791551365A54151B195E44FA9FA@SJ0PR20MB6079.namprd20.prod.outlook.com>
References: <20250520032654.2453312-1-heapbin2@gmail.com>
 <SJ0PR20MB60791551365A54151B195E44FA9FA@SJ0PR20MB6079.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 20 May 2025, at 6:13, Faicker Mo wrote:

> The unexpected MPLS packet may not end with the bottom label stack.
> When there are many stacks, The label count value has wrapped around.
> A dead loop occurs, soft lockup/CPU stuck finally.
>
> stack backtrace:
> UBSAN: array-index-out-of-bounds in /build/linux-0Pa0xK/linux-5.15.0/ne=
t/openvswitch/flow.c:662:26
> index -1 is out of range for type '__be32 [3]'
> CPU: 34 PID: 0 Comm: swapper/34 Kdump: loaded Tainted: G           OE  =
 5.15.0-121-generic #131-Ubuntu
> Hardware name: Dell Inc. PowerEdge C6420/0JP9TF, BIOS 2.12.2 07/14/2021=

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
> Signed-off-by: Faicker Mo <faicker.mo@zenlayer.com>
> ---
>  net/openvswitch/flow.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 8a848ce72e29..834b1b9110ac 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -805,6 +805,8 @@ static int key_extract_l3l4(struct sk_buff *skb, st=
ruct sw_flow_key *key)
>                         if (label_count <=3D MPLS_LABEL_DEPTH)
>                                 memcpy(&key->mpls.lse[label_count - 1],=
 &lse,
>                                        MPLS_HLEN);
> +                       else if (unlikely(label_count =3D=3D 255))
> +                               return 0;

Thanks for finding and solving this issue, Faicker. I think that if we hi=
t 255 stack labels, it's safe to say the packet is invalid, and we should=
 probably return -EINVAL. This also makes sense because the inner_network=
_header is not correct based on the terminated decode.

>
>                         skb_set_inner_network_header(skb, skb->mac_len =
+
>                                                      label_count * MPLS=
_HLEN);
> --
> 2.34.1


