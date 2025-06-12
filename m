Return-Path: <netdev+bounces-196992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B41AD73E4
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98EF91899B90
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF9241686;
	Thu, 12 Jun 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="FQof/u5+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B71AA1FF
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738360; cv=none; b=mPt6HDQ831D17oUW6gUPjoMO2educVMRwzXdBjpe8jZuDOsvmI0UkI1rrOt/2gt+NGT+hgFO+InYBxKA4rreUhkXnc/FUCDzpOqkwe73Y4QdVJqZhECO1hzFjoqUQ0eI4F5ZByb+ZHVkXclx3LhBgVK4cPzBSs5cohz+60zG56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738360; c=relaxed/simple;
	bh=ApF8vBWEk/Mxf+COrA4pHzNgYDC969mE44V8IPsB400=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDXmQrK2I8ikr0h9pheuFc5IU3NQP+mjQmJIE5NScdkLM5nyrDKmRuTRB3LmE+QvLfa3Xic4YETlJaBT77VeHaR5JuPbVEPFvGn3Bw8G0RgthZHalZpdebNhW18g7fHTDvtj6x6DOxIDpsM+0ZsPcUBfggfk+UCye6xGScMlous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=FQof/u5+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4530921461aso9155265e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749738356; x=1750343156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dRuAS/zUdBPIbw/8bXhZ48yEMTP9V1WRvDJONrZWng=;
        b=FQof/u5+XPWjd6NV2IFJb/4KDZU3/J7pgIEP2R1sm03mDbWsQ4WHEWrtxOQVcl4Ibv
         rJnxh/tYt05LCn6V8Bm/IAag8/2NWnzyW1SlWlKnO75yTGINCuhKYdIQSD3Y/pngMnlq
         tENBY5RAfxQxA0ZqJYMWat/DKSerPorUM5Dg0iHsDjt2+3gD29BAR/YzWDxbx1W3ivWs
         OSUrDN540zZmnavTSsZKl8uBqycr4kinUPwXmBcMzMRYyqimR1C5pc2qBQrIDqofNwYT
         KKnNLaV2ADfYozEk2iJmlVQXKfLffXPvz3w43joLsl84iurtthyLPnP2PigSqumFD3E0
         aGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749738356; x=1750343156;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dRuAS/zUdBPIbw/8bXhZ48yEMTP9V1WRvDJONrZWng=;
        b=H9oiggeCDaAlPjAyM2QudXwfLVXJEevSUzMCDfJvE8C0U5DIVDnPQrr4p9xBfdcEdT
         WVFm90Nmx5teSdgqmIPiWkipxQDNcWDg/PyVt0APoUhzQ7LOI56CSEr0VQbNf80i7cCx
         fSPwbpECgtquRfxoxM8TsSh30O33TC1Jpsv6KhjBJJeZ4uW2B6tyJ9M1HAYVpXDAEyUk
         ugL3l9xJcqluiCOZ6zx/nhsD87lc64Hx+N0cCvAF1yK7lLDEXlvng1lIWDj7V1Fm/zfE
         SogMTPSf3QCeE0+3n55wlC3n92R5grj8gmc99pHUWEHgnDsYBP5QKNimiwLnFHkZvG05
         92kA==
X-Forwarded-Encrypted: i=1; AJvYcCXLD0z9R36gEC6wW61rfyJsRLLlsm6eJetATVWVAAZiECnB2dar4Ba6iAVcEOgj4a27fFbTTjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThstJebrOzZpcgAIzrNyv/4eUQ/BA587EK+qHlIA4gdTYq/Rj
	54OtClb1nla0MvYR25OHW6uDmlWg39DO2d6GcE2WV6l8JHs0N2fn8aS9l4DlYYRq1UQ=
X-Gm-Gg: ASbGncsamb6Yg3I0kjZAjQ+oWu2cdwB2YYXduMf4+0ymOnf/nMVAffpYYcDRmWD5w9L
	ujI5ZhmUiqvw7VMrMf40NwEcDIMgDjBRFrQCKej+2Vr5w/L0HRiVsoUudkuU7wZqaWqoIlNf+Hd
	r7qL8yEOITXca1Zqk17wC6u016pcRj10LirO1fKRrvfRgm5Gnz4YqAW8kLIlx/S4Tp8riaL1B3n
	fdGSoF2i/qSY3Giplo/1egcQHz0S7VQYZn7ZhSAqORwCozTw2hkdPk0SNgi85Z06UAyTecah4wB
	JbyxrVN+gx9AyLXCjWoA95Y3Np4wSDlZU4idX7dGj36dnedOJuTdYhsdAQ4hCyfFvZlsXE++
X-Google-Smtp-Source: AGHT+IFvlefm01oYPM1h9ExnmLfkUHYFh6gyuhvhlTFDJV5yDSLIyUvQ0kWkWHYwVMpiGkMEole17Q==
X-Received: by 2002:a05:6000:1887:b0:3a4:e672:deef with SMTP id ffacd0b85a97d-3a5586dc42dmr6618337f8f.36.1749738355672;
        Thu, 12 Jun 2025 07:25:55 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a56199a930sm2174154f8f.35.2025.06.12.07.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 07:25:55 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:25:52 +0300
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] netdevsim: collect statistics at RX side
Message-ID: <aErjcH3NPbdP7Usx@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
References: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
 <20250611-netdevsim_stat-v1-2-c11b657d96bf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-netdevsim_stat-v1-2-c11b657d96bf@debian.org>

On Wed, Jun 11, 2025 at 08:06:20AM -0700, Breno Leitao wrote:
> When the RX side of netdevsim was added, the RX statistics were missing,
> making the driver unusable for GenerateTraffic() test framework.
> 
> This patch adds proper statistics tracking on RX side, complementing the
> TX path.
> 
> Signed-off-by: Breno Leitao <Leitao@debian.org>
> ---
>  drivers/net/netdevsim/netdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 67871d31252fe..590cb5bb0d20b 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -39,12 +39,16 @@ MODULE_IMPORT_NS("NETDEV_INTERNAL");
>  
>  static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
>  {
> +	struct net_device *dev = rq->napi.dev;
> +
>  	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
>  		dev_kfree_skb_any(skb);
> +		dev_dstats_rx_dropped(dev);
>  		return NET_RX_DROP;
>  	}
>  
>  	skb_queue_tail(&rq->skb_queue, skb);
> +	dev_dstats_rx_add(dev, skb->len);
>  	return NET_RX_SUCCESS;
>  }

Hm, I was wondering: is it maybe better to add the stats code to nsim_poll or
nsim_rcv instead?

It "feels" like other drivers would be bumping RX stats in their NAPI poll
function (which is nsim_poll, the naming of the functions is a bit confusing
here), so it seems like netdevsim maybe should too?

