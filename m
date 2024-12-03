Return-Path: <netdev+bounces-148527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F09E279A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36930B67607
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA01F6678;
	Tue,  3 Dec 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AboyqhrQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C61F6673
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236485; cv=none; b=Eenr3kySGTw9zC3WXYYBh81CCgmA/wjC/1tVdzs1CzpavIbmWeXS16OscoyFcF8952KGp0Y0AH++MH3+5fkdxjfCZmCB87fj9U8aEjwcizhYln7od0VSCLjIUY8YC/POROb1MDbQ/qrt+9Akll9EN5yCfKxRHBaTOYYsF5oqYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236485; c=relaxed/simple;
	bh=gU5uGWIiPYomCEI0yBgy+uwiwvPmTlkKp/76+gyNy/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ2VAaDyzXOlwS5kW6ItCjV15V/AHOLNlErQbQBXn7aW4VjpqG6ZBYEpNZbbOvBgOH1VNTEZGvyjBJEvSp1CAj901yTW8p+J115SfKSTIk18dxeEcdV29wMe7/1vbVAaHGoZpK2doGRwuUstdEJBoFYg4XxFoCcxzQlY2vURYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AboyqhrQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733236482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZAKk8offspn+CrsLMVAdR0q4qmaIQ+sB/EB4y+6k2o=;
	b=AboyqhrQWBXR8vII+HFqmivS/kjGuZvP2cmYoTD85OzMarCe6tV1sqoFE1kKOU3DxM+xGN
	679DyLbfpVg03I42UXFPoljPKJ/S5WOqP7bF2JrxfOptenuAJ2Cpj3Cnltq3cgmi0nB3yw
	41W7pAJFbe4BqWhdSZ/CTPN6j6s7w+A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-OZqyq0KEPpiNuifcSmigHQ-1; Tue, 03 Dec 2024 09:34:41 -0500
X-MC-Unique: OZqyq0KEPpiNuifcSmigHQ-1
X-Mimecast-MFC-AGG-ID: OZqyq0KEPpiNuifcSmigHQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d886eb8e6dso66179426d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 06:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236481; x=1733841281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZAKk8offspn+CrsLMVAdR0q4qmaIQ+sB/EB4y+6k2o=;
        b=BA3XQOaK6JRrbarKsbGau/Q6sVfzzbE+jCIl4rkfnGzPTMfObKKzSI/z807Z/s3t1V
         y+6EpNGNTquBTRTMISdOFLX9Gs2N40ELrEkT+XYwRbhsppJeKbIyHouqivtNff+G6/Ig
         jZnWmdKkLeWQWOekR+FDj3LuH/3ahJDSYS7GTZosCE7JI6lzroOSR2t8q4As2aTbaUic
         CIKEDkZ1wK5dS0SVff/vDa27li+z9NQdSDB38RAjsXSP3dMZrEMlCz2ijzFFwMDtTP1S
         hkboh9fmuh6BpQulR8A+dA9y3HE0AXWJbRLzqWCsam9TtUxdTlYQvkmxzMJNseE27j8m
         vinQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXNrDkZLp3/pypmwErZVajKjO2ecnWcbfk30PWdf7ZGfqcgeD1j+De4U++6fNZG1QqYOu5Uoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz368/LVvVVY7s6egmwNPoticLJ2WijNC9luODFz6wBUwEFzLaO
	YBpHRK/NeU4VNXnQ48uDtpl4IWRapyklOIauTWL7rtP4kyCWOdRpiUdE42yR/3VUyyiKvnTEe1h
	jI0Ty+NYLx17GI2Dk2w0g+IoDRofNklbnGMA3ZWij5QOSip0tANgiDw==
X-Gm-Gg: ASbGncviDxP/DFjxQzdUMjirY5Rw35c1V6vsLqYhNqS1iJ78Q7Ey9M2RJWQVtxtgJ3c
	sJb5ZfUMCSnB+y5tHajlkVCOA7nDI9H6971Rqc+v5RLyxjLJ+JD1AWFqbdH/Lit0Di3cVGW2mXg
	+06Upmf7ad4QdafAzxVDKFxfM+wY1OZyxsGnd3iknj9FmEse+JLDdQXIKgsAX0Hb3nxrjZip7kv
	PL9QzyhMsNs7pY3ih1zsRRPY8Kq16hKtb3ovRyrGRIBGYc/svF1gVvolRyscb+6a1lRB47/Wz3k
X-Received: by 2002:a05:6214:21ce:b0:6d8:919a:ac43 with SMTP id 6a1803df08f44-6d8b7404d2amr40441366d6.36.1733236480918;
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhgK4e/6IUinGGlgMgRZ5guoSHMdFsmcfdl9enfUkbfdJVlNSUwmvuv0H4sImi572qlr1nLw==
X-Received: by 2002:a05:6214:21ce:b0:6d8:919a:ac43 with SMTP id 6a1803df08f44-6d8b7404d2amr40441096d6.36.1733236480538;
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d898045dcasm37681596d6.102.2024.12.03.06.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
Message-ID: <c49582ff-5fe6-4d0a-8d03-7b3297cadd6b@redhat.com>
Date: Tue, 3 Dec 2024 15:34:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/22] ovpn: implement basic RX path (UDP)
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-8-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-b4-ovpn-v12-8-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 16:07, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 2a3dbc723813a14070159318097755cc7ea3f216..1bbbaae8639477b67626731c3bd14810a65dfdcd 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -9,15 +9,78 @@
>  
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
> +#include <net/gro_cells.h>
>  #include <net/gso.h>
>  
> -#include "io.h"
>  #include "ovpnstruct.h"
>  #include "peer.h"
> +#include "io.h"
> +#include "netlink.h"
> +#include "proto.h"
>  #include "udp.h"
>  #include "skb.h"
>  #include "socket.h"
>  
> +/* Called after decrypt to write the IP packet to the device.
> + * This method is expected to manage/free the skb.
> + */
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	unsigned int pkt_len;
> +	int ret;
> +
> +	/* we can't guarantee the packet wasn't corrupted before entering the
> +	 * VPN, therefore we give other layers a chance to check that
> +	 */
> +	skb->ip_summed = CHECKSUM_NONE;
> +
> +	/* skb hash for transport packet no longer valid after decapsulation */
> +	skb_clear_hash(skb);
> +
> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
> +	 * interface, based on __skb_tunnel_rx() in dst.h
> +	 */
> +	skb->dev = peer->ovpn->dev;
> +	skb_set_queue_mapping(skb, 0);
> +	skb_scrub_packet(skb, true);
> +
> +	skb_reset_network_header(skb);
> +	skb_reset_transport_header(skb);
> +	skb_probe_transport_header(skb);

This is a no-op after the previous call. You should drop it.

Thanks,

Paolo


