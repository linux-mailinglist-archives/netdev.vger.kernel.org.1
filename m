Return-Path: <netdev+bounces-191807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDB9ABD588
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66ED4C0FBE
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7FB26C387;
	Tue, 20 May 2025 10:45:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66705212FB7;
	Tue, 20 May 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737900; cv=none; b=bKJxlASOJ+nEApOS/hiCFUbMp039unU8e55HUm1tuLKytyYzS1lin4Nksg1ec31DAG8E4XIxLVawaqVhD9yWQoMSOciv5tgcwzoo0LCXDPg827LhJeIi207pg1hnb/HLtuFN2AWb5uZyl6T+3dJ5xc9GDWFtdbofZbkB1xIZW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737900; c=relaxed/simple;
	bh=/jnJWOQW0Z8CRuLYgLz3e7OCCE/jAGLcscZ5tS9pnfY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VK2/gk+5+3yQgugRKmsxmwLIJdpQ/jllMUZHpPpj8hMMgd9GCjJoyg4DSYRsoksOnijmsbQB3kvqOfu36rtYOwZe1iLcz0dwyyHI+F6+xBteLtg3Xm5dqNX3V2Zgr0qmdLCivkP/vQCQlhyIe56Ozfv4taMbIK5rPH2J427Lh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-acb39c45b4eso763416966b.1;
        Tue, 20 May 2025 03:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747737897; x=1748342697;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSS+A4XWxc8V3PjnDxbHNqNLON3TEiDvz3uvzUo6hHI=;
        b=dMymjEYHOmVbCqrSvqhCrjppUl+IQw9+5A29vd6trQjHTrUay61fMnBt0316v6TSfH
         4B5jKud8S4t5Nmrp9JjPNxtn71g+8Tt+5Fo6F/qYeHqE0Qqity/aKmqWpoJFDhkcwSOt
         cAT0yXBBPZobezfeWsLT1TH3p21CEPmgabukBgJtNY3dmOLXEJCWexuEVtAcC9/RCXr2
         dtXIwjvNVlZsqmdrbwvB+C3YwpZ+bChpJwdkVL4ZfgpszcHAVAk43ePGSXdN2ny/OJLv
         TiOnOnzlfDHZjsGThIbwppNypgOtMSC9aPOOk5slu9pmkk5aaNFKVbN/VEsGV+7SWQo/
         w29Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRIRV7cE13lHQ63rnbpiUSmTL37wAZz1bunt5GMieKOFXALPNXEr4QQBjHT/UXy+QK2nM/gelD@vger.kernel.org, AJvYcCXGPTmV1P31US2ERTqrArDjKXeTm2YV0qks07xNkg6pNt4OQTFFKPobfdE8Efjv4KW+Iova/rhn/V8L9js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRRUzw5Lq6QOxLYkCGGO5gy2+ek4FSB+a8/Ij1I34w10jD8ZX
	aCwZ7p8yirlcTMhCA3fwkj62o7NHgx9n0AVhdL5fi7LJHbpICpGnV67SA816KZw1
X-Gm-Gg: ASbGnctJ+upU1TzEG/9SIoOxrnYl9ZMGNzPN++Tq+fxJ6UvkxLO+dSBTPJ2rFL5FefD
	YjHZvnERxN8A4W+sqxyL8Xzf4WJyINSQea5/OXpEd3qT8gASRyKt8tRUgM2O434jTfTqL8n8Ye8
	Fe2NgPxsP18w+GVHplcNEkSmOlSZ/2u385IgXcbZF+W5hbC3UsA2d9LZsiKWGoJE79/GmWxXLYk
	lDMr6vbw7VNZ8vrDQrJRU427p7Iqq6/2tmKDzoY+JYZVLU3b/4vV1JlnMCVAygXnIxsa5nD6Kuc
	9lMc62BG/Jqc2CYVIyll5ZV1T27g2Gzvco5xb80ZZc/UgfpcDt/E/Q9e8fsCUO40N0LtUe/vT1u
	cVYuMbSHyKRPiIlddgA9CgJbgehFt
X-Google-Smtp-Source: AGHT+IEO8kdyU5qTYEAuqOeTh9hvgmkCENnvyOmWYNfbuEqmslOYZbF0I/hL+9C86N3Tf8AaZA+MHg==
X-Received: by 2002:a17:906:68d5:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-ad53a979ccdmr960757666b.41.1747737896343;
        Tue, 20 May 2025 03:44:56 -0700 (PDT)
Received: from [192.168.88.252] (194-212-160-119.customers.tmcz.cz. [194.212.160.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278adcsm707309966b.84.2025.05.20.03.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:44:55 -0700 (PDT)
Message-ID: <e17665dd-7c09-4a67-a098-bf0f42d1729c@ovn.org>
Date: Tue, 20 May 2025 12:44:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "aconole@redhat.com" <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dev@openvswitch.org" <dev@openvswitch.org>
Subject: Re: [PATCH v2] net: openvswitch: Fix the dead loop of MPLS parse
To: Faicker Mo <faicker.mo@zenlayer.com>,
 "ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20250520094134.2856819-1-heapbin2@gmail.com>
 <SJ0PR20MB6079EA1B27E4C274AAFB9843FA9FA@SJ0PR20MB6079.namprd20.prod.outlook.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <SJ0PR20MB6079EA1B27E4C274AAFB9843FA9FA@SJ0PR20MB6079.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/25 12:03 PM, Faicker Mo wrote:
> The unexpected MPLS packet may not end with the bottom label stack.
> When there are many stacks, The label count value has wrapped around.
> A dead loop occurs, soft lockup/CPU stuck finally.
> 
> stack backtrace:
> UBSAN: array-index-out-of-bounds in /build/linux-0Pa0xK/linux-5.15.0/net/openvswitch/flow.c:662:26
> index -1 is out of range for type '__be32 [3]'
> CPU: 34 PID: 0 Comm: swapper/34 Kdump: loaded Tainted: G           OE   5.15.0-121-generic #131-Ubuntu
> Hardware name: Dell Inc. PowerEdge C6420/0JP9TF, BIOS 2.12.2 07/14/2021
> Call Trace:
>  <IRQ>
>  show_stack+0x52/0x5c
>  dump_stack_lvl+0x4a/0x63
>  dump_stack+0x10/0x16
>  ubsan_epilogue+0x9/0x36
>  __ubsan_handle_out_of_bounds.cold+0x44/0x49
>  key_extract_l3l4+0x82a/0x840 [openvswitch]
>  ? kfree_skbmem+0x52/0xa0
>  key_extract+0x9c/0x2b0 [openvswitch]
>  ovs_flow_key_extract+0x124/0x350 [openvswitch]
>  ovs_vport_receive+0x61/0xd0 [openvswitch]
>  ? kernel_init_free_pages.part.0+0x4a/0x70
>  ? get_page_from_freelist+0x353/0x540
>  netdev_port_receive+0xc4/0x180 [openvswitch]
>  ? netdev_port_receive+0x180/0x180 [openvswitch]
>  netdev_frame_hook+0x1f/0x40 [openvswitch]
>  __netif_receive_skb_core.constprop.0+0x23a/0xf00
>  __netif_receive_skb_list_core+0xfa/0x240
>  netif_receive_skb_list_internal+0x18e/0x2a0
>  napi_complete_done+0x7a/0x1c0
>  bnxt_poll+0x155/0x1c0 [bnxt_en]
>  __napi_poll+0x30/0x180
>  net_rx_action+0x126/0x280
>  ? bnxt_msix+0x67/0x80 [bnxt_en]
>  handle_softirqs+0xda/0x2d0
>  irq_exit_rcu+0x96/0xc0
>  common_interrupt+0x8e/0xa0
>  </IRQ>
> 
> Fixes: fbdcdd78da7c ("Change in Openvswitch to support MPLS label depth of 3 in ingress direction")
> Signed-off-by: Faicker Mo <faicker.mo@zenlayer.com>
> ---
> v2
> - Changed return value based on Eelco's feedback.
> - Added Fixes.
> ---

Hi, Faicker.  Please, wait for the conclusion of discussion on v1
before sending new versions.  In general, please, do not send more
than one version of the same patch within 24 hours.  See:
  https://kernel.org/doc/html/latest/process/maintainer-netdev.html#resending-after-review

Nit:  the subject prefix of this patch should be "PATCH net", not
just "PATCH".

Best regards, Ilya Maximets.

