Return-Path: <netdev+bounces-212101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D084B1DE85
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 22:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68D83A4CCD
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3AD22D4F1;
	Thu,  7 Aug 2025 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNW+zJeG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D316226CFF
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600105; cv=none; b=tUVCg0uCCJnvrq7lUmkU0KRv7v5d7EmjYZTHswnH5SkMpsWMJj+xmnAs0o0lzlzHrEMMFXnit98J5NRro0JbxKlhYg0kmiga5JyaSxjJYVioi0ZSPVsOxWjyrHjCYe3M4xWfeVFIvE4qlfoKg2X7LqZEwc5fwuZNj86CS4z0NbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600105; c=relaxed/simple;
	bh=wRnD3a8zBfBErG2eXUCvN/NzdiUk29eaW6mBwvK82jY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IyVvJQoGQbCMf5F93TmiBvETied/Vq9X3V68SeQg6l1vczbnsfS6NmvvlsKnyfl1VimqU82XprgFrgRYhRecnbA898s7RS8awaGI9/q+hMarzDXm8NhT8SoOUQQimGYrmJ6tDHFcHK41Go6KlHbWKckXxtLLyl7Zv61VHsHxz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNW+zJeG; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5006f7e71aeso579272137.1
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754600102; x=1755204902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULjqYWS6a/zXEQbTg6QuyTKb9aeEindjjUXqWaKkbQI=;
        b=WNW+zJeGUhw1wf7K6HOTzqRzbU9ca3XB7ipchQmx8fH68kO51aHOpNTQvONcP2vuoF
         u5ReNtJtPg1rfxorhr0ttKu/+gWxeANd7EmEO5wFBxCTza4+lvCWw1Ua7yQlJWjrm6Fs
         d994NFJuXMPZcmH4GIoGZ2H5fpLx6OsXEKBIMMtla8+aj0XP+qvPnHJ1QcCjuaxW//Sj
         bNgGM1+ooWgKGMSgpyVQFksfg2f38wk0NAZhiWg/AKv+XKCWim7xrwezWTL1aTlNmIYw
         nc7WxoS+ePpRBwOWNjQRISKANpRrxAPAdMiQUwA6dxqUb9qXDKMFitwSzAYOPqNBxg0w
         K0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754600102; x=1755204902;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULjqYWS6a/zXEQbTg6QuyTKb9aeEindjjUXqWaKkbQI=;
        b=et+Na6plzT0frGrc4s9/dPumYMIrngG0nb9/QKD8NDbXzWhFWmAn4BisoKz+iMY/fM
         EhjRrHX6TET2P2O0ZYiZErAz2PE6rYWTuuGJ+Rly/QZEV/hI1trW4lpiuFJPjV7YiaQ3
         MKWKCKe1svIeIQHTjwBKVb7bFzcxDPktEAGHwdJ8dRXrVDhSEvIuI9v5rAMM/eGeS2RJ
         YQUwLtzmagWPG2oCHFXYLCx0zalzNKR1VEl2Hic1ShEra81K41/bYmMl7IAhNFl6kGEj
         3+96NBPELPjF7kgqWTFGMRCGYRi/iUQdJ4FyIc+1FpS1EnjYal29o6Hsma7/OY7y61pZ
         xGBw==
X-Forwarded-Encrypted: i=1; AJvYcCUXef9UcYNF+C8UkiMBbXf/CqQchG+KIjvlvYjSUZLEZTc+TDW3SO+ZOraCoJGNOacCjA5xDwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3h/U1rLQGFFzbgMohNairdJfgfDIAiV97m4WlVvdJqSPX8VR
	8DAAqBgz6eegxffuPeTMWQp7d2VkOx6rlT9MTfK+1zuO3O0/8hSbvtW/
X-Gm-Gg: ASbGncvMxxJRQY8kCkhEqhKKhZTGPLm1iljFcEKK1X1UAYWXdVL3/k//ueqwNBrV57e
	bBTO0VZGooKCmkl/O5HEMjYaPCSbVHNBGRkqp6KmqngVasQ+f+H6uTbgfxmNQ4V7uv3x2OzVLti
	gPQVfuCTu34rXHZwmrHQ76lLa1EJ+d6jyXNrg0vayDwhhLvIMi1Y6gCO+b2Aai3L3f8/b2orB89
	qiiVqChuS1Rvb1fdGDZGhlooSfcfzrHj+cRgD6HbMx2Vsr8xHmyVsuzgzIUMc2Qnb5hlhoTVBUS
	tEjnv0oimsHxT5Q6gJU1NS8cFGfF7+RjS5V2w27luz89mhNKXJM/aKh8KtM2qKrDFEmwxQzkHoj
	uDUmY/hFE4Ve3g/wqxsEBauMsQgUbhRRFPNrRHy/XLyMPXugZmpau07Gl74OGQVJxSXfmkg==
X-Google-Smtp-Source: AGHT+IH4bLwsd53Z6kS9HSPKemleu2KgxDpUQ82/Zy7VKZ9/mqFJloE6zOFryDSzyKIlCe4kjedlPg==
X-Received: by 2002:a05:6102:1625:b0:4e9:91b2:c74c with SMTP id ada2fe7eead31-5060ebdccbemr215153137.14.1754600102259;
        Thu, 07 Aug 2025 13:55:02 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5062c0477b2sm30185137.19.2025.08.07.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 13:55:01 -0700 (PDT)
Date: Thu, 07 Aug 2025 16:55:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Ramaseuski <jramaseu@redhat.com>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 horms@kernel.org, 
 pabeni@redhat.com, 
 Jakub Ramaseuski <jramaseu@redhat.com>, 
 Tianhao Zhao <tizhao@redhat.com>, 
 Michal Schmidt <mschmidt@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <689512a45dabb_217ac1294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250807134150.497553-1-jramaseu@redhat.com>
References: <20250807134150.497553-1-jramaseu@redhat.com>
Subject: Re: [PATCH net v2] net: mask NETIF_F_IPV6_CSUM flag on irregular
 packet header size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Ramaseuski wrote:
> On any driver that advertises NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM but
> not the superseding NETIF_F_HW_CSUM (e.g., ice/bnxt_en), the kernel

Minor point (repeated), the two are generally not combined. See also
the following in netdev_fix_features:

        /* Fix illegal checksum combinations */
        if ((features & NETIF_F_HW_CSUM) &&
            (features & (NETIF_F_IP_CSUM|NETIF_F_IPV6_CSUM))) {
                netdev_warn(dev, "mixed HW and IP checksum settings.\n");
                features &= ~(NETIF_F_IP_CSUM|NETIF_F_IPV6_CSUM);
        }

> incorrectly attempts GSO on IPv6 packets with extension headers.

This is not entirely correct. Hardware TSO/USO cannot be relied to
handle these packets, so GSO is correctly used.

But the GSO stack must not program checksum offload. Instead, compute
the checksum in software during segmentation.

This is tested from skb_segment with can_checksum_protocol. Which
could be amended for this IPv6 with extension header case directly.
But removing NETIF_F_IPV6_CSUM in gso_check_features will have the
same effect.

> Because the NETIF_F_IPV6_CSUM feature is incompatible with these
> headers, the failure results in a `skb_warn_bad_offload` warning and
> a collapse of throughput, as observed with GREoIPv6 traffic.
>
> Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
> in gso_features_check if the IPv6 header contains extension headers.
> 
> The exception is a BIG TCP extension, which, as stated in commit
> 68e068cabd2c6c53 (net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets):
> "The feature is only enabled on devices that support BIG TCP TSO.
> The header is only present for PF_PACKET taps like tcpdump,
> and not transmitted by physical devices."
> 
> kernel log output (truncated):
> WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload+0x81/0x140
> ...
> Call Trace:
>  <TASK>
>  skb_checksum_help+0x12a/0x1f0
>  ? netif_skb_features+0xc1/0x2e0
>  validate_xmit_skb+0x1a3/0x2d0
>  validate_xmit_skb_list+0x4f/0x80
>  sch_direct_xmit+0x1a2/0x380
>  __dev_xmit_skb+0x242/0x670
>  __dev_queue_xmit+0x3fc/0x7f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? ip6_rt_copy_init+0xf0/0x290
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? selinux_ip_postroute+0x1c5/0x420
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ip6_finish_output2+0x25e/0x5d0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? nf_hook_slow+0x47/0xf0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ip6_finish_output+0x1fc/0x3f0
>  ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
>  dev_hard_start_xmit+0x63/0x1c0
>  __dev_queue_xmit+0x6d0/0x7f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? chacha_block_generic+0x72/0xd0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? selinux_ip_postroute+0x1c5/0x420
>  ip6_finish_output2+0x214/0x5d0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? nf_hook_slow+0x47/0xf0
>  ip6_finish_output+0x1fc/0x3f0
>  ip6_xmit+0x2ca/0x6f0
>  ? __pfx_dst_output+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? nf_hook_slow+0x47/0xf0
>  ip6_finish_output+0x1fc/0x3f0
>  ip6_xmit+0x2ca/0x6f0
>  ? __pfx_dst_output+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __sk_dst_check+0x41/0xc0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? inet6_csk_route_socket+0x12e/0x200
>  inet6_csk_xmit+0xeb/0x150
>  __tcp_transmit_skb+0x555/0xa80
>  tcp_write_xmit+0x32a/0xe90
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? skb_do_copy_data_nocache+0xc9/0x150
>  tcp_sendmsg_locked+0x437/0x1110
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  tcp_sendmsg+0x2f/0x50
> ...
> skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd 60 0e
> skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00 00 00
> skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00 00 00
> skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00 00 00
> skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00 00 00
> skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00 00 00
> skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51 13 f9
> skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00 01 01
> skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
> 
> Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")

As said, I don't think this introduced the bug.

If you go to 04c20a9356f283da~1, does this traffic work?

> Reported-by: Tianhao Zhao <tizhao@redhat.com>
> Suggested-by: Michal Schmidt <mschmidt@redhat.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> ---
> ---
>  net/core/dev.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b28ce68830b2b..1d8a4d1da911e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3778,6 +3778,18 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  		if (!(iph->frag_off & htons(IP_DF)))
>  			features &= ~NETIF_F_TSO_MANGLEID;
>  	}
> +		
> +	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
> +	 * so neither does TSO that depends on it.
> +	 */
> +	if (features & NETIF_F_IPV6_CSUM &&
> +		(skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> +		(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> +		vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
> +		skb_transport_header_was_set(skb) &&
> +		skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
> +		!ipv6_has_hopopt_jumbo(skb))
> +			features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
>  
>  	return features;
>  }
> -- 
> 2.50.1
> 



