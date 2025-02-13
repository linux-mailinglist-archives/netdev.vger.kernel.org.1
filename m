Return-Path: <netdev+bounces-166056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC526A3423F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C185116B000
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A085281379;
	Thu, 13 Feb 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElWwlcj/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76150206F05
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457215; cv=none; b=aKs541FyASSphC68g0XUUO/puXOCBFLj5+mpjGmfbU0yYkQWjkusrd6ItuMcVXAB0BTkCfeDxTGmLqqQXe6/etIpu3xluR9U56/a1EtPVEk+tOTCsqIutU14+IpEXDascQ+bipGWYDJ1Pn7NCHUBsTDJxEkc8TXsH8DSen7DKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457215; c=relaxed/simple;
	bh=kwoVWZNi+GDuiNhJ5L3qawnH3KVa9BjLbCv4NdTbB7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mK04bn/3CX90SsNlN03cdEj0nqsyVVtLHlpMGDqzCGp6ZEcM2qyJd0BMEAAg1V5ukwcCYJiMTkpZYGL8PgFUs19ZpPl6gOJmZOWkkMlSe6ZAtOzovLsyzckaKEJ5nLDGSOMUYg0nvqeOR2uyS2rl7phvbhzsCIeCI1UP2N+uvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElWwlcj/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739457212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMFyK23NBITvCpOXbxfq6pQKgiT9x/6S9BU4JzuYsYo=;
	b=ElWwlcj/ANHTDticeIUdkvWGG2UbDs8ti7qIQ84PvGdrSo0cpopUpberJrWVBfqGDnmjL3
	nfkW1LoP6EDOQ1R1qHPmmwgmsTzUAZV8PS9DKGl0GAQNlMrbTVuGMPL+DltgE+BQZ0kBaj
	Pak9ajMpiw8HqkZPEduI0x21/6LPSTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-BP1-nMxYMA-Ccj0GgKVpVA-1; Thu, 13 Feb 2025 09:33:26 -0500
X-MC-Unique: BP1-nMxYMA-Ccj0GgKVpVA-1
X-Mimecast-MFC-AGG-ID: BP1-nMxYMA-Ccj0GgKVpVA_1739457203
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394040fea1so5600055e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457203; x=1740062003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMFyK23NBITvCpOXbxfq6pQKgiT9x/6S9BU4JzuYsYo=;
        b=M5udlSC/BT1OdypPWa0PBIq9x1mLa9df3YJvcpSKTK45bd2qcR6Iwi6XCkxK1fJrjc
         4ej+K6NYsAwEvoSsay52Bn+0nSxhXcB4R36BdERM7tLHY6BB12GAPPSjo6JesMynRtg9
         cU/KE5FbyIXYBqFknexb8YsmWpl+p2hHMpEqynHDNiFmYabPssDbMYO3Gdghgt5FE6Bg
         o9lpn/9rOiFcQBgjsuSJqLCFwuKC2oaNhxxpH/58IeYn3CkBODclLYR9O3i5s3nz93ZS
         nmr9VSF8GZbc6f9RNHfDvkjA3tZLrquH2N+d/kFy1i69ugNE3qw24bB5sd6UI8Ye/VPw
         GUUA==
X-Forwarded-Encrypted: i=1; AJvYcCXnobCFsGfS1PlPM7HoJTB/JmykPh+U2D+RY/5ZB2r4UUzv9Fdlnf5f2TvZH+oPxf9NletUdLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQEcuaoshYNmRcItsWRLg9c0nPZ/Fjp2EZdfZwx9RXEZzcUo6
	mV4xGcsBUWXi45sZPP1JCG8n5ua7zxqy/SVHNlSYz3bvhLzVVmwDKHI9bSFQ8Yr+wcFwEEQn0NR
	IQz5GuX8W5JidAh2ahNJA5Ky6UekYxd3Vv86yPPhVBhJGVVyj6tspYA==
X-Gm-Gg: ASbGncsy67RU9loGyc4UuY9p7s145556XErxxDLZ2K4Lh2+utOv3snjPOxuNBWlcH4R
	J8d+9bx2pbW4MafP38hZsjVJEmwiCGxSte+61Uy1DSFZ14k/FhyzOJGWOJVX54JHJIg/xEu+qhr
	/+iefoXJ8MhUY3aopT30bzK0zYsCjZ8NwPN7Gwipxyv7e1cRM9DI39NpVkOKxF2zGxJNIBkdBeq
	Uq80GtFgdn6o0wqMhYvKfURT8ObPVoMadJyI+n3HBjLOury0EYahK9R8c4ZA8MVlRwD82m28PS9
	7kk5hh8IvZS3EJsnz7JCwXGnyPS/rHagw+Q=
X-Received: by 2002:a05:600c:3b0d:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-43960e98d5cmr35178055e9.8.1739457203039;
        Thu, 13 Feb 2025 06:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6aQ9mSzQVIyH9jKgL7tj2qN2h9rT08fodpm81XRNUgD9PVpAqH2dmJzlf1rbI+Hc6SrFgWw==
X-Received: by 2002:a05:600c:3b0d:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-43960e98d5cmr35177545e9.8.1739457202607;
        Thu, 13 Feb 2025 06:33:22 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a9ab0sm19197915e9.35.2025.02.13.06.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 06:33:22 -0800 (PST)
Message-ID: <231856f0-deb8-4550-bdf3-b0ef065f7b7b@redhat.com>
Date: Thu, 13 Feb 2025 15:33:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net: ipv6: fix consecutive input and output
 transformation in lwtunnels
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-4-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250211221624.18435-4-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 11:16 PM, Justin Iurman wrote:
> Some lwtunnel users implement both lwt input and output handlers. If the
> post-transformation destination on input is the same, the output handler
> is also called and the same transformation is applied (again). Here are
> the users: ila, bpf, rpl, seg6. The first one (ila) does not need this
> fix, since it already implements a check to avoid such a duplicate. The
> second (bpf) may need this fix, but I'm not familiar with that code path
> and will keep it out of this patch. The two others (rpl and seg6) do
> need this patch.
> 
> Due to the ila implementation (as an example), we cannot fix the issue
> in lwtunnel_input() and lwtunnel_output() directly. Instead, we need to
> do it on a case-by-case basis. This patch fixes both rpl_iptunnel and
> seg6_iptunnel users. The fix re-uses skb->redirected in input handlers
> to notify corresponding output handlers that the transformation was
> already applied and to skip it. The "redirected" field seems safe to be
> used here.
> 
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>  net/ipv6/rpl_iptunnel.c  | 14 ++++++++++++--
>  net/ipv6/seg6_iptunnel.c | 16 +++++++++++++---
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index dc004e9aa649..2dc1f2297e39 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -208,6 +208,12 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	struct rpl_lwt *rlwt;
>  	int err;
>  
> +	/* Don't re-apply the transformation when rpl_input() already did it */
> +	if (skb_is_redirected(skb)) {

This check looks false-positive prone, i.e. if packet lands on an LWT
tunnel due to an tc redirect from another non lwt device.

On the flip side I don't see any good method to propagate the relevant
information. A skb ext would work, but I would not call that a good method.

/P


