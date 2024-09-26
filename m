Return-Path: <netdev+bounces-129913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9124986FB2
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FA91F23A22
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EC31AAE2A;
	Thu, 26 Sep 2024 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DctoVAt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D21A7ADF
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341999; cv=none; b=N1Hy/uKfB63oWHT83IQEGokUZuUfO5Wb1ddbLnF83C7XMNYTlaE24gks2Wc/lYQ+B47uWTCLC+AdZUfOQj7Ydw0+dqYbE8GXd5R3BfVg3UsYXlni8nEZnJsUtqMpgmC9xtqsE9iWxvQwCs4zNo2hy8yI6FgFJU+L4pj5V1wTxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341999; c=relaxed/simple;
	bh=WkhCUHPyJ9RQNo5zDusO/KtKItZbO1OUKdSodd05rwA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=noHFjVteZEYFAm5ozQtrn/E1oMuQ54OLrlaJlLSnjlJz+jOwDZZ4Mt6Rvt89wWFzcAMXK9MpjcSievauO7hggw2D9kjCWiRA5jQBYolEfIIjWdv9rQyKewRMdSolpi+PUe9PjlDWsX6ie1oGvpcezrgFEbqiGrh6a+VtnQkCSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DctoVAt/; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ae0e116cso74931685a.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727341996; x=1727946796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv8SoQiPmq2be8kj0JWq7o37OdbruRaBVLz6hTdwWqA=;
        b=DctoVAt/idsPR2xPVcakJgG73xQDbu5zJKXggxkXbxQZ6CZGV1FqNHBoLkZz/5xZwG
         g3A/DeURR41u8WWoeRjQ2k9Rco0jsXD24YwGTAQo6XQA12cR/esRT3jDPEgPatl35xu7
         JI5tHvppPt0IOeF78oKvodtFJiichTxebWns+2r3VJ8VCXLtqMEya+TA/P4a3c6Gcvt3
         L192ac6N6i9kw2zhKg4qRhOR+GM3JeFIJQ9DV4FmGYyjLJS/JFs8HobpUC77pIGU1zAl
         hX+y6mndEBkcXHxQXv3tPLPyYhMb8nVhtSNr0vQRLOP18T9rux4EBqDs/vOUx1LN8+Hu
         NxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341996; x=1727946796;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uv8SoQiPmq2be8kj0JWq7o37OdbruRaBVLz6hTdwWqA=;
        b=Ld+X3PrH0Nb8z/V7+1uyqhg6Tk9krjlPMfhG5DH7EB326Gjagn42F5FIjMuyKb756G
         Nf71iJsjJzbz6VHtrVZKtYiPcykZvrWkU8lioJKvUDk5WbzDab5VfXcX5Yojit0xREvp
         eC3MX7T1Ys7JdfupnLmSJjtz2pPpfbl8xb4tgu/RCQhXnQ7lhoL7sfTtFfG2nFCI5uPD
         HBy7FjBiwDl4WWa5X32KgERs6S16nTLod7aqLdxHaNTDAnZVY+2HMRjFhXCZAXnzteBh
         +TckSGEW8XXJmqkHdJnWIzFP9jNOpY7HSLkBFoIIlYrc8YYlUOiGOd4fW/uOJpDL/W8F
         bRVw==
X-Forwarded-Encrypted: i=1; AJvYcCWIwtFxzzyFxy7Kk/UYR5vcKHIFTJs+OHdD8c/sr8ZU1IpxdZCUubIXVYwCxlMSWMmmdjPuUiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOpEyf3EOKqwQjiLKJVrCXLMtRM5siMvUaxqFhCeeHN7XbqoA
	zjKi2M3/7zjCcnAcsYgi9snRuSwb4XhSJGkj2hWva2RCJtRAQaid
X-Google-Smtp-Source: AGHT+IFt/2+ZCo9QiqACdD3U0ajflg56n8bLfOIK9psZGCxOvBXfIS0MoGDb12I7Szz/WN0b4kvF2A==
X-Received: by 2002:a05:620a:28c3:b0:7a9:b021:ee4 with SMTP id af79cd13be357-7ace74651e2mr795264585a.64.1727341996150;
        Thu, 26 Sep 2024 02:13:16 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5cd3fdsm261487785a.85.2024.09.26.02.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:13:15 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:13:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Jonathan Davies <jonathan.davies@nutanix.com>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66f525aab17bb_8456129490@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240924150257.1059524-3-edumazet@google.com>
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-3-edumazet@google.com>
Subject: Re: [PATCH net 2/2] net: add more sanity checks to
 qdisc_pkt_len_init()
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
> One path takes care of SKB_GSO_DODGY, assuming
> skb->len is bigger than hdr_len.
> 
> virtio_net_hdr_to_skb() does not fully dissect TCP headers,
> it only make sure it is at least 20 bytes.
> 
> It is possible for an user to provide a malicious 'GSO' packet,
> total length of 80 bytes.
> 
> - 20 bytes of IPv4 header
> - 60 bytes TCP header
> - a small gso_size like 8
> 
> virtio_net_hdr_to_skb() would declare this packet as a normal
> GSO packet, because it would see 40 bytes of payload,
> bigger than gso_size.
> 
> We need to make detect this case to not underflow
> qdisc_skb_cb(skb)->pkt_len.
> 
> Fixes: 1def9238d4aa ("net_sched: more precise pkt_len computation")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/dev.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f2c47da79f17d5ebe6b334b63d66c84c84c519fc..35b8bcfb209bd274c81380eaf6e445641306b018 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3766,10 +3766,14 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
>  				hdr_len += sizeof(struct udphdr);
>  		}
>  
> -		if (shinfo->gso_type & SKB_GSO_DODGY)
> -			gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
> -						shinfo->gso_size);
> +		if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
> +			int payload = skb->len - hdr_len;
>  
> +			/* Malicious packet. */
> +			if (payload <= 0)
> +				return;
> +			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
> +		}

Especially for a malicious packet, should gso_segs be reinitialized to
a sane value? As sane as feasible when other fields cannot be fully
trusted..

>  		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
>  	}
>  }
> -- 
> 2.46.0.792.g87dc391469-goog
> 



