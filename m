Return-Path: <netdev+bounces-189995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3DEAB4D12
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC797A9FD2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1051E7C06;
	Tue, 13 May 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7XlQTa+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6011B87E1
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122322; cv=none; b=UKm+lcv75Y24cZ5olDNK5WlS0EFYIfh77CbfNZpg8ewPU8lFbL+1gtJrg7dZsAoJN+tXMy6YltYR3/BjYFufQblTDMRZUOKGObSeaR3zr2YEgImBv0nJS0ha13KKd14p3gq49aUs0sPkWmglgGDdz+8LnMiQa2ZO6jOcZkFds7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122322; c=relaxed/simple;
	bh=3DUr8c//wp5p2wrvKJsRzZdJdjw7EPlxWEtAFMpWLbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWwkELjVPluiTJokAzFX2lUXR7kTWsiWNj/yK6csL4qyXZtV9Af6FKavvnzb0LNIJ5wA+MQz/sxvQ3R8kEUEe5DgUXDJYtZbVuiaUq2Yte2LyvG5zrDnsuOWqn2YeXfk5Qpk91Mikcfn6oMykdETuEUZjkdNIgOIqWo4G7JqMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7XlQTa+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747122318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhNG6XGSjMchJ5+6UbM118OlrWve3IfgW0BdIeDzQLw=;
	b=g7XlQTa+Bnqv2GapBPNUU3O3lLVdEAXqkwGMl81lH4bcSV9va6QhR0vu+DNL0fFKZZGcs5
	uptlaguqcI0SqNHRyGis1kJ972QgZLLBbYKwrMOaKbEtW864a8A14LaK5UeSRD6J1RA53i
	dELLLNmHgYBMCGs3iULX6vWOirw3PSk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-it_vXRjUP82YqKRIieDt5w-1; Tue, 13 May 2025 03:45:16 -0400
X-MC-Unique: it_vXRjUP82YqKRIieDt5w-1
X-Mimecast-MFC-AGG-ID: it_vXRjUP82YqKRIieDt5w_1747122315
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so23679165e9.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122315; x=1747727115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhNG6XGSjMchJ5+6UbM118OlrWve3IfgW0BdIeDzQLw=;
        b=hQx0bc0UZPUBL9LuZnthThhX45EuwF4Ix555QKAgrCEvwORtvjpY9J+xHlgCIooCa+
         wwq4iDx3TEiaLGmu61BqqxBx1FaECOebM8DVEHSP2TXIIaZtyrNJej/Zal9ZyE6Ygeh8
         AamAMfUYBy8cEkmmKJpR3ZIsroiPfLBbenocLTzDNJjBvROMd0bmAxuPjTlQ4eKbuwd9
         DBI1JSySr7N6mfTh6rCX9IfRb+pnyDPlAyfDJJlDYKkWBBgalrPP/6N2npLqCuhT1xdh
         oD7dQ8cJxycOaBeGCg+Zb4bMpXAzUrmZuLEb3pndQI14aVit5d1qSSRtlNFwumI31Izu
         443g==
X-Forwarded-Encrypted: i=1; AJvYcCVg9RXSj4e+/2UR479nCwhzhrQwgu05GXpUzO04+thKB/+i4yGedwshg7M37ztjGc9spB4lq20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyMUca+tCqmZwktkIFCYYKzIGxetlhrrJqkiGbh/gkdR4gYGCp
	/fQmQZn6DYaP7tE6vPZJDYFKuow1Ur1jqqBeWO8Vx8IWAYhkmHPgga0mE3e+sBzpoQk5q143FiR
	9Y2aue14s3LYEoKXET7gnxKROChTxUSkYx1v4sl6x2l9MJ/5GLU4Nug==
X-Gm-Gg: ASbGncv2RXNA/pEudmuqU6QlD3UV11GZgp3WZkyy1j7S4tjnWzqKZQxqth0LXcmbeFJ
	BeDLSiH1OUpnoOwjU9c2m6R8p0dtoZVBitZ2akvfU8NoJY/9HZiv4q9XCshbrFGXprF+aAp4Npx
	lsJSzq+VChkV07moF2k0b1t4W2Ah8P24mo0fDI+CWFaV7wnW9D3Okk7HRs+H3LwXBAk4RaQhdtd
	fCynLvefoCYvcyoQ/rV6WpTppEWG3WZHMLpNW9GsZ0+VnSsvahjsmRIhl9g+DuQBR7MeFaa0gus
	XSI2ELBD5D0nMmbiIFM=
X-Received: by 2002:a05:600c:34d5:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-442d6dd21bfmr118070715e9.23.1747122315263;
        Tue, 13 May 2025 00:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+DLMnqm7Bj+Q8RnNPwFgWOddlXvmcOZAOEawAFEAu11HQxpi3nSOWtNYi87nfAjGVliljpQ==
X-Received: by 2002:a05:600c:34d5:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-442d6dd21bfmr118070465e9.23.1747122314875;
        Tue, 13 May 2025 00:45:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aeb26sm201239565e9.29.2025.05.13.00.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 00:45:14 -0700 (PDT)
Message-ID: <3a173ede-e2db-463e-a135-7dc9c7976cd7@redhat.com>
Date: Tue, 13 May 2025 09:45:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] ovpn: don't drop skb's dst when xmitting
 packet
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-5-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509142630.6947-5-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 4:26 PM, Antonio Quartulli wrote:
> When routing a packet to a LAN behind a peer, ovpn needs to
> inspect the route entry that brought the packet there in the
> first place.
> 
> If this packet is truly routable, the route entry provides the
> GW to be used when looking up the VPN peer to send the packet to.
> 
> However, the route entry is currently dropped before entering
> the ovpn xmit function, because the IFF_XMIT_DST_RELEASE priv_flag
> is enabled by default.
> 
> Clear the IFF_XMIT_DST_RELEASE flag during interface setup to allow
> the route entry (skb's dst) to survive and thus be inspected
> by the ovpn routing logic.
> 
> Fixes: a3aaef8cd173 ("ovpn: implement peer lookup logic")
> Reported-by: Gert Doering <gert@greenie.muc.de>
> Tested-by: Gert Doering <gert@greenie.muc.de>
> Acked-by: Gert Doering <gert@greenie.muc.de> # as a primary user
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/io.c   | 2 ++
>  drivers/net/ovpn/main.c | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index dd8a8055d967..7e4b89484c9d 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -398,6 +398,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  				    netdev_name(ovpn->dev));
>  		goto drop;
>  	}
> +	/* dst was needed for peer selection - it can now be dropped */
> +	skb_dst_drop(skb);
>  
>  	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
>  	ovpn_send(ovpn, skb_list.next, peer);
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 0acb0934c1be..dcc094bf3ade 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -157,6 +157,11 @@ static void ovpn_setup(struct net_device *dev)
>  	dev->type = ARPHRD_NONE;
>  	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
>  	dev->priv_flags |= IFF_NO_QUEUE;
> +	/* when routing packets to a LAN behind a client, we rely on the
> +	 * route entry that originally brought the packet into ovpn, so
> +	 * don't release it
> +	 */
> +	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;

See commit 0287587884b15041203b3a362d485e1ab1f24445; the above should be

	netif_keep_dst(dev);

and no need to additional comment, as the helper nails it.

Thanks,

Paolo


