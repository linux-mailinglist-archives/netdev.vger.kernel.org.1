Return-Path: <netdev+bounces-193000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E07AC21AB
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95EA67B7C49
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C53122C35C;
	Fri, 23 May 2025 11:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1F22ACEF
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998006; cv=none; b=D3TCi1Dm/q1ViR4nbiltWt/QfFVV8ZIbAniBloFBnr5dJbujc/99zGpp4+TcGQyK4LqiKAcSGQlrFrbC83UXTgQ5rWb5tBWrGoHwIX4kftR+apx+sl7aOrcG8m9y7r/oiiM6OC/8ASZe3DMtgOMgoC8zVRl8Q7fyCdGDKI+Exok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998006; c=relaxed/simple;
	bh=pmK1bmxJtadoMNw6apwvpQTPKDbBVLC8vshfE1LEzgA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d6J+xrim8ilsOJxKyKCaF7RSEMgd9d/6aZy4FztIgrHK0aXC9ot0aDocOFSqtSoyYFKSZ+rwtNKjdCtQn8O9k1KAZKTbdSRGH0xmVpD1yl9ioUL3rg5B3QSLO0szzVojjlCcYEHB993TgUgq5Sy7aMyyDqxiMsMXwiQQQzlSe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac34257295dso1498539366b.2
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 04:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747998003; x=1748602803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIEnaSDXMYmeqHQt1gnUuEv53KDx6iQxIHA8SM2zO8w=;
        b=OPmTrXoatJbf2mTIGAkU+htyCep+y09nw9LpEeqnf1wCSHRP47CPWU2aTzza8JJwK6
         8xnvVC0s7hnfXWqRsbf21SaKm4dcVGHg7mmqBlTCo7sGal6Mp/xP/zwcOcPt8k77Hs+P
         e+ukwhdPG2gq/rBY3dNtVa2nXhH6v3TaZAUt9KeQD2e7b/2+2zpLeIn6+F0yI0SoHXui
         nEhjagqBUTGbI5fM3pzgUI1mWKNL1QY3ULmWTnhmZWbef0lg5Kl6IEr+Ghfbh7d5SQ80
         g2bLNNPzB3cMLC3FiShZJH0ki2bDPkokSYJGAtJ5d6DrfxHoO6pmC2FFHuyXFb9TGMP1
         ppQw==
X-Forwarded-Encrypted: i=1; AJvYcCX4hIcxqOyPCJEipPmF3KBoFtLBgCLdLipPtFZ4xYGi5IRrzKYbtWenCexloFuqarvEsYZPNqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0WBQ88k3biYQTRnv1Pvq/vFoJuAr67QFv9VanpYp94PTrSDf
	wU5ggfDdjC1GXUmE6QBqvA6x49ysP7E4wOFUREpYvzR3OcSXkO9CTg+aC3mkSCU3
X-Gm-Gg: ASbGncuOyc4xndX92j4hYvC7wLyUv7uTz7cRHyVM2tzeylpgZsr5Pf4CjeGScEkhan3
	CLz1HkRB9Su13WZ/dToKlH0SB3dAiZS/7Vhd0g2n4h1lb0qnA5uqvK3xKXjSkHIRzbVJPdKTOie
	ar68WH0G9tE9zfZJHsoUiG82cZrb4X1Pkk4s3dlpDLkH8O7dBarQFo/tJFoY3rb6HI3wBIw7a+D
	t0B+7YLayDinAhuSPhIJjm87YNLoO+0Zl0LtXGm6tqZcdxfmZw2Hxl2KSAbIeqUt4N+FBF/bs3L
	+CQPAyiLPsf5DYOu7Re3+q4F7b77hhb+1jNysNSjpRx5X42FS6G2s13oImjDjGx6jra3G8Vnd3X
	JMFe/J0UqihbY8mgty5vnNp8=
X-Google-Smtp-Source: AGHT+IFpWeGYfHsoQS8jbES0LPfhS2KCzTMukvqY8CifRQuILzwT/rnTiMlrQUOLtUlTCNpg2HsLRw==
X-Received: by 2002:a17:906:7314:b0:ad2:238e:4a1b with SMTP id a640c23a62f3a-ad7083b9614mr232331166b.15.1747998002566;
        Fri, 23 May 2025 04:00:02 -0700 (PDT)
Received: from [192.168.88.252] (78-80-121-182.customers.tmcz.cz. [78.80.121.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4395d0sm1202154066b.114.2025.05.23.04.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 04:00:01 -0700 (PDT)
Message-ID: <f83525bc-c47f-4e80-a323-e9c2e1d4656f@ovn.org>
Date: Fri, 23 May 2025 13:00:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "dev@openvswitch.org" <dev@openvswitch.org>,
 "aconole@redhat.com" <aconole@redhat.com>,
 "echaudro@redhat.com" <echaudro@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "martin.varghese@nokia.com" <martin.varghese@nokia.com>
Subject: Re: [PATCH net v4] net: openvswitch: Fix the dead loop of MPLS parse
To: Faicker Mo <faicker.mo@zenlayer.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <259D3404-575D-4A6D-B263-1DF59A67CF89@zenlayer.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <259D3404-575D-4A6D-B263-1DF59A67CF89@zenlayer.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 5:41 AM, Faicker Mo wrote:
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
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 8a848ce72e29..b80bd3a90773 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -788,7 +788,7 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
>  			memset(&key->ipv4, 0, sizeof(key->ipv4));
>  		}
>  	} else if (eth_p_mpls(key->eth.type)) {
> -		u8 label_count = 1;
> +		size_t label_count = 1;
>  
>  		memset(&key->mpls, 0, sizeof(key->mpls));
>  		skb_set_inner_network_header(skb, skb->mac_len);

For the future, see the checkpatch warning about using the full path
to the source file in the commit message instead of the relative one.

But the change looks good to me.  I tested it and it solves the issue
with the CPU soft lockup.

Acked-by: Ilya Maximets <i.maximets@ovn.org>

