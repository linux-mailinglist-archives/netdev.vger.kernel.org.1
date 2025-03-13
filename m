Return-Path: <netdev+bounces-174566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECCEA5F4B4
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723AF17D116
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536CA267392;
	Thu, 13 Mar 2025 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3ZISd7E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C578F59
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869643; cv=none; b=DQ8PuPkQ54i8Z2lAR73y/gDqI33Uy8OZ/ihTef6IqMeuv7p2o0CaNJd7qY+bhggPPIf4ix0areUfvxZ9U2rldlv0LK+AbLSSgOudk3NaGJXLDOQW3RoxGLEoPwvYK4LjOdtPyPBrhVsudb6GwNehgt3fp+heZD1zmlpHPM1tQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869643; c=relaxed/simple;
	bh=s+Cw5nXNJDi+pX3xaNzSSCKCfNULZvrKJC8sDjgqWiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6vhi2jGNIYMYeqZOcSUC4vLLJUzSqIYJpmdUKouyhcuIdOP3ivvPOqchpaLK1GJC9ybO+jOw6vIjokcBbDXFFKuYIu1tCl8OSqir0FXlYl75dpPcL/y5DwPJ8lswY4q1oLcTKP+ckK9Msxo6/byTWVVNeArrUlit8ndT7l3J7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3ZISd7E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741869640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWimYmhU+ZOERIkdOJawry94KfRSs/3sYWmM+r81DxU=;
	b=e3ZISd7ESdNrOGYF5aq3/mw62tg1Z4qr1fZr7S3STvDZdgCiNpWRFNm/mMkkrB0QYexqKJ
	tA8T5xihp/OBVMRbOXx/+x9QqBZTu3dz0iytzHq8zTNFF4dJYM/vxT0bz03rhizbolVwx1
	6VVSDMBXmTmMn9M5EdtamZDBVLxCFZ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-BpHbYRNHNBirEiEpoNg8kg-1; Thu, 13 Mar 2025 08:40:39 -0400
X-MC-Unique: BpHbYRNHNBirEiEpoNg8kg-1
X-Mimecast-MFC-AGG-ID: BpHbYRNHNBirEiEpoNg8kg_1741869638
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so4626755e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 05:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741869638; x=1742474438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWimYmhU+ZOERIkdOJawry94KfRSs/3sYWmM+r81DxU=;
        b=YkmJ8YR+D3d/Y9r8q4MjbGLFqc31DNwR2p6FPp3heAC7pncb6PBTH1iXlxMpaxeRFe
         Mf3rdhk6JDOtvVQCPIR4TKNYm+c5AcHGb4ZGuhVvqKHcVKwKZFNN3/1i7RZK/6GttTWf
         Igby7XVtFxcKAxbo+ex3IZnaFRAMMwZh6WUHmvkFUxtHN6RtsZt2YbRMQcjaMatsKiWv
         1Wlnijwe765BGawKlRt3lWk2xSiCz25jKNDgT6Qa8uFZxDFSttIhGdWpIqq7x14+ct8j
         kxhg8V/b9CXC9Z7UgzAeETeewo1Q/fRo5NfVX/bAMi9qSO5pZtLInODLyJuMag7HHerB
         gDAw==
X-Forwarded-Encrypted: i=1; AJvYcCV2PojWM5EZ33l3zG3I3mYhUhyb+FVwR0iS3ohS6Ph+XRpTg/BEKvKnq88zsXun6APL6wI37IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdTLCZg3fq3W4fKXuVVGpMJLvwyJum9nVDKLMgfTSwrYh15xh4
	aNuzODormBTaNp2jzhvYyoQu2JPKzSxOrjuobHdvTk4ZxhBBWgMaRB4iddTzvWQJLnvzeJ3moW+
	4cwgvMbP2+181wYGVJUTwkgZAXayN1VTEA46a5Mh9kzoXXj9rDHhDpw==
X-Gm-Gg: ASbGncu1cLtCphG3UOnIsx2OpjEX/smeGQatMhEBnUX6jyLCCMwn5Sa8zr7jYVGh0qg
	5FRRGf0ImbLff090K9I+FZSBGBrDeqnv8F8DA8rSRISvjgCC6iOTTZeRCXWwZGD1h+RP/HFzVXg
	6U0Ym4rXNppDvfaFtVSZSS1bn4JZ/pMtCb4kJdKfId+LZeqfln9M1FzXQb6dkkH/mGLA8xuXtBh
	LtPsYx/2qBo4ZPyymqGuQmYnYMhZNOigSirG8/DFMdE+DNZ16qkVMy5R8ts7IgNUB0k9tU5epxz
	EJv8bHqM1rhrYNi8XdQbgaKAQPXbsgDoPt78c5Wf
X-Received: by 2002:a05:600c:1c81:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-43cfffc7af8mr110773465e9.19.1741869638006;
        Thu, 13 Mar 2025 05:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7x/+wOrWptmB4eB0SpjX0Q1OctZCuYJ3sMlrYaN8S0IyZH4cyml1O5BG3gMhpPBJqP1Hn7w==
X-Received: by 2002:a05:600c:1c81:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-43cfffc7af8mr110773105e9.19.1741869637542;
        Thu, 13 Mar 2025 05:40:37 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188afff0sm19493635e9.6.2025.03.13.05.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:40:36 -0700 (PDT)
Message-ID: <183561ba-a6e1-4036-9555-d773c14d14bb@redhat.com>
Date: Thu, 13 Mar 2025 13:40:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/7] net: ipv6: seg6_local: fix lwtunnel_input() loop
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, David Lebrun <dlebrun@google.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
 Mathieu Xhonneux <m.xhonneux@gmail.com>, Ido Schimmel <idosch@nvidia.com>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
 <20250311141238.19862-5-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311141238.19862-5-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 3:12 PM, Justin Iurman wrote:
> ---
>  net/ipv6/seg6_local.c | 85 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index ac1dbd492c22..15485010cdfb 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -378,8 +378,16 @@ static void seg6_next_csid_advance_arg(struct in6_addr *addr,
>  static int input_action_end_finish(struct sk_buff *skb,
>  				   struct seg6_local_lwt *slwt)
>  {
> +	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
> +
>  	seg6_lookup_nexthop(skb, NULL, 0);
>  
> +	/* avoid lwtunnel_input() reentry loop when destination is the same
> +	 * after transformation
> +	 */
> +	if (lwtst == skb_dst(skb)->lwtstate)
> +		return lwtst->orig_input(skb);
> +
>  	return dst_input(skb);

The above few lines are repeted a lot of times below. Please factor them
out in an helper and re-use it.

Thanks,

Paolo


