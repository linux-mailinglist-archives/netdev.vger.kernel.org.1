Return-Path: <netdev+bounces-172547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C055CA55617
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F2F1732FC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF14A20F075;
	Thu,  6 Mar 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORkFIF5M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861813B791
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287698; cv=none; b=jwsawEEYfPtlER74k94ZprrdvA/ZK4P7opZvGuFVVAh42CzWhbYl1E4bf6vpLxY9sgMjwHgZPKi8JL/6yh3lL2kgq87iU3wTbEdLR35mBvfCPbBNvMGxNpAa4M20YGBAWB9zD6587PSE+ywPzamOR+n9yL7a01XMlr6iWxFgjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287698; c=relaxed/simple;
	bh=eFN6cg9qkFu0DhvXVnDXcArGX3LkkFPnfgSZAnMUxe0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=euAw83oIGK6b8c/dV85riU7YL2u+O4MiW7K54t+k95Au/BJV5BjzpvvwnkyT0CcVw5nfamYWfZ5/YAnmI+SvBsuRWUHLnBQLvzq0NLa1sXsd5SfUPth1kXxUSTT0KmBKpq/ZYNMCc8GfQiezIXBaEISx3J3swypcJXZA+47ZZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORkFIF5M; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c24ae82de4so117548885a.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741287696; x=1741892496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNNQiHffo7qOD0irRgrCwJnJy5Bt5wlaZyEC6yUxri8=;
        b=ORkFIF5MKWtf1E7lmcM+Dd80T7mWKWCRgd6JNTIzO2yPBacSgYr51r+kb4Xyml4l+8
         wcc5CZUmBhDoLHSQqCt+1cPEOIQjT3u6wH6bMbseZn5KZiXnyfewu1NHL7/cFqSVnIe4
         62w4Kg7A3Zqxls32DhW276b46u/oeGXK9P5DDN1vuIxptqJ2z/4rdgYQwQRpJCzLy/Cs
         NohmKZUp5SbjeIcSl0pVmDxktUEp7k9vgprUsQD72jTTEMKFOj31erQtP1lSQz2xSWOu
         zXJ91vL0rfcS6BljkONU8hz2FKIudfydB2q4XxNmGA60DqO/e5z2shuUDmCYE8gRyPK/
         wDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741287696; x=1741892496;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uNNQiHffo7qOD0irRgrCwJnJy5Bt5wlaZyEC6yUxri8=;
        b=Cnb7gDYf7DryT0B5aT8sTVlTPKQf+P+a2D/3ffADm4lMq71/hIm48EHmCVyAsVth9t
         IUr3APsoBvVMX8a+9UPL4zRCJJeimV3TMQYHKv4o0vu9ujRfnmiSIKHN+jQpa3qYl+XM
         Q0z+gUjKYfWYvSfPqosBEF/D4i9gjxqyTnfxcAkmwAFSFjNgiR1mNlmDf7/K6A5qL2z4
         egKUk67F0RsUrmf9NEKKofEWeyHdDFudER3vTfFD6NUaLkOFV03nUGuZI3V0ItUl8W9O
         reZgZOwoR1XkpR9RSk88FZE8Hbka3j1Qxel+rUsaYaDjOL+Wp493d9N2lUGPagVH30sT
         WQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1SBRYNsx9yMU0vY3dJ8x5Bt/cxUQBxCyrI6MsqFKzzwoobxZyex21RiYfgWddUN0bDvj7v/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfE0YzMyfunrh21DiQjmxMP47Wx9nJdbWOeJCpHX+YB/fOZXWa
	Oq57WcFzw8ir+p2Put4t6CrNlxJmRJQOItQDclEmQaNIrYcDiljS
X-Gm-Gg: ASbGnctDDm5UZzK/gD69tCopT5KzA5lv/yQz3+fc6qXWUTPmnfMeppbysmOLG6MdOEB
	0rcNe3aw/qEOOxq0sPJvbUTzKifVzT6DuCmjOnAFD6JXLB0dX5Xb7lUj+XEQosu5PH2F/J/oI/4
	wdI0LatlHK3jiT9qyYsgQLqsn8V7JBYRVKv6Rrb4hDLIKfR3izgS4HUcrNIyVwz47z0BwKR7LUc
	xVlb35YKS/oVWS8HHi5L+ogprDbo2yr/J25uTzgBhF1971uE1r/+u4Csa4mOJ9HSRnDF3iDZRbZ
	kmayczQOzh6IB83lehLRWHoU2zVPK3pwgDVVmjc0pnuPjZN5jOvf4ykxZEf5c+twA7lPk+rHZ5a
	rxQxQe2VHhx8quDjzMX9H0Q==
X-Google-Smtp-Source: AGHT+IEa56GSdS3OtAxbbb6x83KNKFDzPFlxL3Pp8IEDJKPrSsTfjneqcLMyL6YUgN6+TaukKLoAuA==
X-Received: by 2002:a05:620a:262a:b0:7c0:b4f4:1633 with SMTP id af79cd13be357-7c4e3da6af2mr45492785a.15.1741287695803;
        Thu, 06 Mar 2025 11:01:35 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e550fd36sm122880585a.102.2025.03.06.11.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:01:34 -0800 (PST)
Date: Thu, 06 Mar 2025 14:01:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67c9f10e7f7e8_1580029446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250306183101.817063-1-edumazet@google.com>
References: <20250306183101.817063-1-edumazet@google.com>
Subject: Re: [PATCH net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Use SKB_DROP_REASON_UDP_CSUM in __first_packet_length()
> and udp_read_skb() when dropping a packet because of
> a wrong UDP checksum.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 17c7736d8349433ad2d4cbcc9414b2f8112610af..39c3adf333b5f02ca53f768c918c75f2fc7f93ac 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1848,7 +1848,7 @@ static struct sk_buff *__first_packet_length(struct sock *sk,
>  			atomic_inc(&sk->sk_drops);
>  			__skb_unlink(skb, rcvq);
>  			*total += skb->truesize;
> -			kfree_skb(skb);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
>  		} else {
>  			udp_skb_csum_unnecessary_set(skb);
>  			break;
> @@ -2002,7 +2002,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  		__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);
>  		__UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
>  		atomic_inc(&sk->sk_drops);
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
>  		goto try_again;
>  	}

From a quick search for UDP_MIB_CSUMERRORS, one more case with regular
kfree_skb:

csum_copy_err:
        if (!__sk_queue_drop_skb(sk, &udp_sk(sk)->reader_queue, skb, flags,
                                 udp_skb_destructor)) {
                UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
                UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
        }
        kfree_skb(skb);

And the same in net/ipv6/udp.c


