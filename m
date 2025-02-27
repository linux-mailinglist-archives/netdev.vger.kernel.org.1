Return-Path: <netdev+bounces-170376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637CFA485E8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB4D3A3244
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949BC1C8FB4;
	Thu, 27 Feb 2025 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZX0VBkz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27351C6FEA
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675516; cv=none; b=BPDiCOtYsGhjPXJR7VC+thxMs8vVMOIwxPy8706kB6CGvFF6Y3eYn/lyJfPYfeKmdNffSZlM/QUJQFixZlSKbYpGBT43ybjUGYvjBLMXgE7bKlclY+YQzUOqQIz58hOGBTaVoV+wvnLYqkrI42uRl1ZZdRnw68EttKIVNP4cd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675516; c=relaxed/simple;
	bh=41rDwiSGaBy1/8VZopkMIs0m9/h7iOPDyau4j9mtlPc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Tc7dSiXkjPxJkhUg5lScdMzdhc5ztQxNIQjfs+RMiziFkrzePE8NBjkCFa+Deu9IGQgOnFH/08pbWiNy/nqcU4Uld2ljerZ4AKFmTmQCgPb3BULc0D4ljWPEqBFEG3hsvi7Od05NyUpdagOnYhf2h353d7rKXPho5XEVWf2IcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZX0VBkz; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e889e77249so10516806d6.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740675514; x=1741280314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHc9aRklwp3hGkHd1mWbbDLrE68LhqRmv/Kkw6ocq38=;
        b=eZX0VBkzJfVYU4ftjwes295Pa+GjN51FIpNh9GVRsKGBxIbgJ0GnopDVl3JoQb/olL
         w9icOw8MbjixF6BgBViAaomous7qb91uXuBr7LqSOP5LLmfldo0tlMIftWDw7l1Ait1q
         c9eLB4pGAF6AvApNYXke3KQpkCJKODUB7ESO9XMojiS97CFrYjy/EpucwjVqwtYW5mYY
         0Fi24dlvGQCEb1yameOEJE4e0Y8dZ3YoCppyDhPIjJZNllhyhnCmpxhxAdeP7Spy+yxv
         MSCfeYMeWbqKkaLUtqW9Ou/tmtgapGDNedM6djCX/z2dDI+Ywm1mHuUbX5rjwxpwjd5g
         MAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675514; x=1741280314;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VHc9aRklwp3hGkHd1mWbbDLrE68LhqRmv/Kkw6ocq38=;
        b=poNyvgt15dRzMdiW5+UJ6fUm5get2ap+5G/yWMlSjpHQL+DEjOBKtx+4C1GGc82FEM
         Cluw4d+wBWJOlnMu30G/pGUTInGbSoQznqHkZudCH/mMzoi60I+a+9pdSYlwoXun1FAI
         nx2VADSScxCgpm/OekjH4zBT5jbwnut02RVeguVcuNvUN6DVRuC+2GcLhQbVrADQoDTZ
         /3Venl+CqvxBBVXUdxQBH2NnTgJ3mF667ban/CTMpW34xpZ1k87RMXdS3dTlkurkEblX
         WOLgAmmRGThvy3mPfAT1EUuJCLiunlU+uHCZLWa1Aa2zoTcp0UxbNCbHOEAcoamcWXvG
         pvWA==
X-Forwarded-Encrypted: i=1; AJvYcCUn4kxKtsiHJpvyilhbRYLVORSeYZZw5Q/SPmazJwmh1MaRPHeBr6dxRhQuKPLcaBOiwczcPOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkRGagVpFADs7r7901lZQligADOIYHVWottH1RyPVQxaAwRVC
	d8F+y4ErEbm54yeKuTnIQ+CKjlvCclN6p3BVN4QrH0Zq+1xdIRS6
X-Gm-Gg: ASbGncuTvaV5+gXyfBrC/+Z8UwLjQYJdICjtuwtuID5AnTkEvjINRZ186Pwibu70mIo
	zyF8r863DgdErSUsHuVl1AQGDvCLRsM1VM2wnlUav5pPmCpgFmVEzPa1NwqBapDCbExbmVgxjNK
	3nA1v+ov+4uvZ0TOy5uRTQkX1oGuvtZI8tEO4r+EweIzUcAwlsxnWvapZDniEX+KdXM7jRLgn41
	yksQMrlPpevBNvpKOnaWISKOGl/p4/+ehpb7jtCY/5a0iIpXBVi+rQiHGyXKpQgb2jyyR5tGnYi
	nLtNiQWlvTd1BMciRS5DdTzazbyhD5YTcCp34j02XxJzgPzibCS4d7dUMrn8TEjwQKZx1PDKoUB
	fZqU=
X-Google-Smtp-Source: AGHT+IGA5nwlI3UB/Rvt0HEfmddOTwAg99YpDhtyEKWcg80TgctnvPkbh7yIk5RDsNHSPb5FeWYJsA==
X-Received: by 2002:a05:6214:1d28:b0:6e8:9dd7:dfd0 with SMTP id 6a1803df08f44-6e8a0da678amr1589826d6.44.1740675513862;
        Thu, 27 Feb 2025 08:58:33 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47472409aaasm12822771cf.57.2025.02.27.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:58:33 -0800 (PST)
Date: Thu, 27 Feb 2025 11:58:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 pshelar@ovn.org
Message-ID: <67c099b8e7293_37f92929454@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250226171352.258045-1-atenart@kernel.org>
References: <20250226171352.258045-1-atenart@kernel.org>
Subject: Re: [PATCH net] net: gso: fix ownership in __udp_gso_segment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> In __udp_gso_segment the skb destructor is removed before segmenting the
> skb but the socket reference is kept as-is. This is an issue if the
> original skb is later orphaned as we can hit the following bug:
> 
>   kernel BUG at ./include/linux/skbuff.h:3312!  (skb_orphan)
>   RIP: 0010:ip_rcv_core+0x8b2/0xca0
>   Call Trace:
>    ip_rcv+0xab/0x6e0
>    __netif_receive_skb_one_core+0x168/0x1b0
>    process_backlog+0x384/0x1100
>    __napi_poll.constprop.0+0xa1/0x370
>    net_rx_action+0x925/0xe50
> 
> The above can happen following a sequence of events when using
> OpenVSwitch, when an OVS_ACTION_ATTR_USERSPACE action precedes an
> OVS_ACTION_ATTR_OUTPUT action:
> 
> 1. OVS_ACTION_ATTR_USERSPACE is handled (in do_execute_actions): the skb
>    goes through queue_gso_packets and then __udp_gso_segment, where its
>    destructor is removed.
> 2. The segments' data are copied and sent to userspace.
> 3. OVS_ACTION_ATTR_OUTPUT is handled (in do_execute_actions) and the
>    same original skb is sent to its path.
> 4. If it later hits skb_orphan, we hit the bug.
> 
> Fix this by also removing the reference to the socket in
> __udp_gso_segment.
> 
> Fixes: ad405857b174 ("udp: better wmem accounting on gso")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  net/ipv4/udp_offload.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index a5be6e4ed326..ecfca59f31f1 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -321,13 +321,17 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  
>  	/* clear destructor to avoid skb_segment assigning it to tail */
>  	copy_dtor = gso_skb->destructor == sock_wfree;
> -	if (copy_dtor)
> +	if (copy_dtor) {
>  		gso_skb->destructor = NULL;
> +		gso_skb->sk = NULL;
> +	}
>  
>  	segs = skb_segment(gso_skb, features);
>  	if (IS_ERR_OR_NULL(segs)) {
> -		if (copy_dtor)
> +		if (copy_dtor) {
>  			gso_skb->destructor = sock_wfree;
> +			gso_skb->sk = sk;
> +		}
>  		return segs;
>  	}
>  
> -- 
> 2.48.1
> 

I'm not very familiar with the details of the OVS datapath. And how
the gso_skb can be accessed in this state, which is intended to be
temporary and local to this function.

But in light of the skb_orphan sanity check (below), this patch looks
fine to me.

static inline void skb_orphan(struct sk_buff *skb)
{
	if (skb->destructor) {
		skb->destructor(skb);
		skb->destructor = NULL;
		skb->sk         = NULL;
	} else {
		BUG_ON(skb->sk);
	}
}

commit 376c7311bdb6efea3322310333576a04d73fbe4c
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Aug 1 11:43:08 2013 -0700

    net: add a temporary sanity check in skb_orphan()
    
    David suggested to add a BUG_ON() to catch if some layer
    sets skb->sk pointer without a corresponding destructor.
    
    As skb can sit in a queue, it's mandatory to make sure the
    socket cannot disappear, and it's usually done by taking a
    reference on the socket, then releasing it from the skb
    destructor.
    
    This patch is a follow-up to commit c34a761231b5
    ("net: skb_orphan() changes") and will be reverted after
    catching all possible offenders if any.

