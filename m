Return-Path: <netdev+bounces-205763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03851B000AB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D685954143A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B30246763;
	Thu, 10 Jul 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqyiOfG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88599242D83;
	Thu, 10 Jul 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147503; cv=none; b=AqhYoVE6FC3KkkoYJyyKiWFdkzxwf3kXACKxigaWktQvfPfHG5NphVFf0qqjALlodAs7Si7efv9G2tASSskEJcJG7GzNdkIm3VxJ8OS6UFvRZvPUo34HZaDidW+D8so118dBh02yb62Ebt/XPmLrjqUM9LEre+768QyUQBTeyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147503; c=relaxed/simple;
	bh=4eTmfHT1Y/c7D1lzNvMnDcIz+LGy3csSxNvFpjFeaVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWPTFZ0cwWYl9po1+BoeY3apAEcTgaOn68iZBNLtP8gLCTP4iu9eL72lO8YGRT3brcSFgWyXBkczK4ZKJJL7KdXLzyL7BIlNK7hIkiuEbYZYsfpxJ9xBT6VkDBuXg9QzS10b1niGXdb62rpM9xRUXCEZ7YLPLZLLRRqSBw49aCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqyiOfG7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a53359dea5so522129f8f.0;
        Thu, 10 Jul 2025 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752147500; x=1752752300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87Ku6/NI0CKR1kwsY5In44nVhCCotoFUI8bUiBdls6M=;
        b=nqyiOfG7aNXkomzKDMqudrIZGFbir+uhTIbCwONSBykX6vDS+yb1OPWgGYQCtTVOCF
         3nbpQOeG7ze1xl2qJvHSpaZHrCjzCY+HImTpclxcnc/ld/2/5WuiG6595JMMFXDG4Suu
         MK2/jODq0lR9WSKMLvqKE8I15Nx8tfu7+jwuDj5xv4Tc5QLFlnpMj386QOI4ljNeEohg
         jP/VStyeJ+g+Ivbs0AOKoB5ME18AvX+VxkeC7gg0J+EU7iR6Zylf1NLXBylqrLuVEXSB
         S4zPhZsAEC+7mL5wv0icf3LOWrmHE0aVJcwT3yGvcSud0XYNBlmwDsjrPSMqPIswSGvv
         DXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752147500; x=1752752300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=87Ku6/NI0CKR1kwsY5In44nVhCCotoFUI8bUiBdls6M=;
        b=jst9m3cO3TFfpG56D6Pw1LIlKVkrRiVsgw1Q2ZAMla+CTaJgUjDW2KQ23PDBVf5G+M
         XfqKLrA1ZM4U6lOivEshWuBwup5ZLVc98YhlF37QMs7jTiZDdazNjNW7s0lkjtH5Bb7T
         Ko/Z2iihthOY6iPvYnt131/rfFqZE+VAzfAYZE/qI8C7nTMnOww7SYplqKfYyT7Oh/di
         5s8LTD0wlgxpACy7NL3f89UGU2bguIANj2TqvLm5V0izwTMiKA9KIBTRexbHNikN3XiN
         UChbaA30SBnU9le9LjVhQ8opInea6CkcrN6QyW0/KC+3Jes9iMPsPaczu0Bok+oOUJzO
         DL8A==
X-Forwarded-Encrypted: i=1; AJvYcCUcrCH1Whz2n6jknoc+TsfNIUORK3P993+5g4fCoJB4FHcNrsmjfMZNtBEmGebbv2oqVN9Wl6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8rCHvXm1PW3RmojNfVqwdb8x0zSVBOqIzdpmOGwOFt5I62pW
	DtcJlCUkRuvq7BOnmve8cZj7zg8fZbm8LzMnVuGAHRlS+NNynMC9scEE
X-Gm-Gg: ASbGncucw0yWyoac7JRzxDQuIaZMDuoCU35yVgeOWa0AKqBnXJ6wApBol38U3/jDoyA
	+/SEohPbFk19ukiMtpouCZnnN7xNdS2wefmrhXmE8T+Y85Oq3zcl9vh2vKh/rYcHKoERTZ8HwZT
	p6PHsC2Bo63pC0BYkeQWogkA9avLIVLZc4++NKnBdoERY7lYZvbkXX8h68RRUiO+2avLQIbe3N3
	g03YwYDnhlhgVdWyz8tivUmc99TqVoJYMJY4xt8o4Dv7aJFoBozsXF/82UkBH66up6UIOziTh4Z
	ajGVK9W14R6U8pWEZXmzEDdU
X-Google-Smtp-Source: AGHT+IH9FWpRNmwBnYK2H8C21+oP9DfLC9w0v8B5WIVIk/TsW4VnBty/UsYjrko0u8i0P/eY3kD/Rw==
X-Received: by 2002:a05:6000:2c09:b0:3a5:2b1d:7889 with SMTP id ffacd0b85a97d-3b5e86c6306mr2104663f8f.43.1752147499601;
        Thu, 10 Jul 2025 04:38:19 -0700 (PDT)
Received: from debian ([45.84.137.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd541e9fsm17237185e9.34.2025.07.10.04.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 04:38:19 -0700 (PDT)
Message-ID: <615bc4d6-3b10-bd7d-dbfe-2b79072af44e@gmail.com>
Date: Thu, 10 Jul 2025 13:37:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org
References: <20250705150622.10699-1-nbd@nbd.name>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250705150622.10699-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> Since "net: gro: use cb instead of skb->network_header", the skb network
> header is no longer set in the GRO path.
> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
> to check for address/port changes.
> Fix this regression by selectively setting the network header for merged
> segment skbs.
> 
> Fixes: 186b1ea73ad8 ("net: gro: use cb instead of skb->network_header")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c | 1 +
>  net/ipv4/udp_offload.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index d293087b426d..be5c2294610e 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -359,6 +359,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  		flush |= skb->ip_summed != p->ip_summed;
>  		flush |= skb->csum_level != p->csum_level;
>  		flush |= NAPI_GRO_CB(p)->count >= 64;
> +		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
>  
>  		if (flush || skb_gro_receive_list(p, skb))
>  			mss = 1;
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 85b5aa82d7d7..e0a6bfa95118 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -767,6 +767,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>  					NAPI_GRO_CB(skb)->flush = 1;
>  					return NULL;
>  				}
> +				skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
>  				ret = skb_gro_receive_list(p, skb);
>  			} else {
>  				skb_gro_postpull_rcsum(skb, uh,

Were you able to reproduce this regression? If so, can you share how?

