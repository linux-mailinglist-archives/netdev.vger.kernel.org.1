Return-Path: <netdev+bounces-164162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72EAA2CCF2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3603ACC57
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF61B86EF;
	Fri,  7 Feb 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SODA4jv9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02D1B6547
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957318; cv=none; b=qLhTka87g8cKFElMvIcMIqFYmLvNrBcbEiKfcM5qfPC3o0o1bRZdzZIS0xcFfzV+w7W2uBcOoyLzM7Th7M+7bfq2oxYIVeLmuJhTd9OTyA0GTkZC+2aH3v8U8VeSeMn92J6BxO2VExl6GefpaClb+FkTybTT1ev5w7OyNb50byY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957318; c=relaxed/simple;
	bh=SMwBd6ZFz1RNRp5vpuFG0544mDPvmygMzDy31Hy2VdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMWeNMMY+QQZ3sBO/VtfrlbPqLg8N7w2eej1f0of39w5z7cO0agJAlHCgSk7TyPPcXYXlaJAoAPs8tVGNYEQedWy7yTSZODsD5fF7yjJZtDwCvwoG4Z4q4uCSRhiNhCj+k6CFf+fdSSrpdP302SuxQG5YFhYxt1A5ZsE5shXcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SODA4jv9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f2f386cbeso44544515ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 11:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738957315; x=1739562115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STZUdNDBAr6eEE3n280mLE1PmnG8AcLyCV0yym0DKhk=;
        b=SODA4jv9b7vvcpXoDmv002n9dH1uA7H0bz3Xtd0v+mRUjQsknSWeKbIP0zIbwz6mBk
         pgn/7isUsDyH9S42//hm9ohgWOlcwoNBwTuFWvkwLbbhaR/YS6H3FlveVEl+I8Hc7mKg
         TuyNTVkDQvFIbgR2DT/y6to2t5i5WMMDHdIh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957315; x=1739562115;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STZUdNDBAr6eEE3n280mLE1PmnG8AcLyCV0yym0DKhk=;
        b=HvSS+7wnjPQyywG3e09ZCyV8NdCeTJZwleVsjnSkk8gW9vcTjoC/rDgdJXh51dlz6P
         sgfMWp/7lEPgzgJwpfsimtrRS1mAOjNZrVU0OZrZyltkRGZU/DXPR9b4EyPySt/+i5a1
         zfgaW6ZWkvXCjtsoUB2tZ9G+I2nsRfqShLqBPHkwzySmnnawZ5pKnjpZf5dM2xFZedX9
         iUN6UeXgq98S0bLQNs+bgr7TjF4DmwpfG/8xPZNZQvaH0ksGd8G0hzwHGztEBrL1lzpn
         0OV3NVOvZFJ6+0A4Td/rxBpRtoe6nawl1ad5CbblcHxxvgiva1iNYjqEY0OHP6I9jApV
         IrDw==
X-Forwarded-Encrypted: i=1; AJvYcCXOQ8QUEKibCl24Sgaen3XlcCTYqXXtW5IeAuUm/Rx8YV3YsmwX8H1/mWnqu7YKzAjOHhxA5n4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxip/VcFFAmRn/2CdouptA3JzQ6/FAfRNXfgDfDXkt7kOH6ad1R
	0t7wIK9BPsUHIBhdEwJApz3dyDKoY/uAUUUnDo4a+woIsqlprPtcL03jE27iOcns6qre0ryhqQu
	e
X-Gm-Gg: ASbGnctlehty6vU5YHgRWIgIdJd6wQO3H06KZtDgWY4RXdPokUWs6mvTvhUwtQxFi/Q
	TECdCXD2gozqNeRCA/i21fcwE/s0N9DHTFniZIsckg15CLXFRzch1Ow8q1q+STGLNtC+gxGGm8T
	gp5B8V1HWLybBxyXAUe2Fyp+xO+fr88Q9Jmj7SLZ50nExUW6AyzxqTum0koX3oHdiOT8MFzOANS
	ny0rmSZWHvoIywacbY+ktdbHKs4xojurQUrGrYxlCNIHZmJNRtL47in1BqmybZODjxH2J31uUFm
	tEZCi8S2jKEGqCYkauaS5hYv7tHAM3rIc+cgaunHQqtuxD+iEp0W3j8Aqg==
X-Google-Smtp-Source: AGHT+IE1w81vZQ+PCOzSFV8jBjQPCgDtQlZH1Y7MzYjqGA+fhvhfTdYXFwEqbQcHZegPtP72fGUaWQ==
X-Received: by 2002:a17:902:e946:b0:216:5af7:5a6a with SMTP id d9443c01a7336-21f4e75e66bmr81790405ad.32.1738957315440;
        Fri, 07 Feb 2025 11:41:55 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d6e5sm34469065ad.141.2025.02.07.11.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:41:55 -0800 (PST)
Date: Fri, 7 Feb 2025 11:41:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Daniel Zahka <daniel.zahka@gmail.com>
Subject: Re: [PATCH net-next 3/7] eth: fbnic: support an additional RSS
 context
Message-ID: <Z6ZiADvMTAYN0tw0@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	Daniel Zahka <daniel.zahka@gmail.com>
References: <20250206235334.1425329-1-kuba@kernel.org>
 <20250206235334.1425329-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206235334.1425329-4-kuba@kernel.org>

On Thu, Feb 06, 2025 at 03:53:30PM -0800, Jakub Kicinski wrote:
> From: Daniel Zahka <daniel.zahka@gmail.com>
> 
> Add support for an extra RSS context. The device has a primary
> and a secondary context.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 20cd9f5f89e2..4d73b405c8b9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -374,6 +374,61 @@ fbnic_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>  	return 0;
>  }
>  
> +static int
> +fbnic_modify_rxfh_context(struct net_device *netdev,
> +			  struct ethtool_rxfh_context *ctx,
> +			  const struct ethtool_rxfh_param *rxfh,
> +			  struct netlink_ext_ack *extack)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	const u32 *indir = rxfh->indir;
> +	unsigned int changes;
> +
> +	if (!indir)
> +		indir = ethtool_rxfh_context_indir(ctx);

Was slightly confused by this, but I assume that there's an
indirection table in core and its possible that modify_rxfh_context
is called without a call to create... maybe in the case of the
default RSS context or something?

At any rate after browsing the fbnic code a bit: LGTM.

Reviewed-by: Joe Damato <jdamato@fastly.com>

