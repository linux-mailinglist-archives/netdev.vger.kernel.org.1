Return-Path: <netdev+bounces-197336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627BCAD8295
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC3A3AB7C3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8541EB5E5;
	Fri, 13 Jun 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="uLQwQN+E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA402AD04
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792983; cv=none; b=atcSAf59IClhuWN39WpS7L7PFnWVr9BQK/utDsDR10QLYbFrtHLcZM7U9b6MJp6WZG5XZEiJh1Jm0WLO+GOjLdrt60UyQrv8iH+lvFQYnpy7n9sOJc1/1iUZs3nbFjX/FoUD08l8K8/hOUN+kWMnCwuGF0Vb4a4fh4Yd374M7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792983; c=relaxed/simple;
	bh=Sreh95GnWPx5S1O+Ccf9rLfdKxeQnMz2/J4KaGm2UDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMmdx1bf1PD/FbJVM2ThHR9LaLBanjpPOndo7PT0JHaH/uIGppFLeQgHT8j2Ch43MuMWh2uHjzKohbHk/B7S9P0PENyefqS93d4KZLPuThisiOYh7iURESQXzYoQIP9atcuLHIJr/BkJ1wIzRhbXxKCcYaIt27QfglG5eKlzBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=uLQwQN+E; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so1374237f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749792980; x=1750397780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8OWkMSHVpf4NY1pa+MskWGO8xitHM0Bo5Pv0/xdrb4=;
        b=uLQwQN+EI48pUNctXWqSuSY6/6VuOepzSQ7SN0SXIHtTgS9VFc+dmSEJJ+2nurU4kI
         NpM8mAake69fzByeeGtrfyL5ov0+XPFqQqgGdl9EANKha2Posd1BNMB7tEL7SJ7mVQTu
         bpvnhluBs6ZPAJkoaSv0xn+3HrLNTKnC9uozJUSt2QR7ps2oQYeBM6SqrGJMzWxQjVUN
         Qbc1AgniE9hqavyqHZ5qLeBatV/EGD7tBeXRnD90hup/8553H7wR/Gm7kKazt+lNFLq1
         o3P51M7TY464RxboPt8a60Q8ZPewtAQMCFc34bv5Lbr5zbl/tzRIpnlGWhrrojFtzu0m
         dGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749792980; x=1750397780;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8OWkMSHVpf4NY1pa+MskWGO8xitHM0Bo5Pv0/xdrb4=;
        b=RH2vF6EGI584YzNkU7HJ9OP6QyXARE39ZdOupCfFaZaPzO1rdsdIVgwEKBifx7tCAJ
         PgY5jcumJosMIMtmX5HMyPKNNOP+ez5g8d1CIb6wYagu4QgPCS0uMqESiQCzWyVGIAI0
         44MmHWLsfTy2pEvXqDATgsghSvR2AML02nqMEsCXsCxHWMBHvHleNGCm6EwhK0Z96UW6
         zqkmqEBAHgqROBBuGC58VtIpu7bI42OYOApOQCi0RIjUXUik6wk3SB4Bnu1ar6kz9hse
         Re9wflUvuKO4ngQRsTV4otPX5uRSOFAmPMdRc0wSpg1iVqnGqifcjCPSinTQaR635Bqr
         AXpg==
X-Forwarded-Encrypted: i=1; AJvYcCWfvC4apfUCvXT9iOvzOHZGXROfBOUZA6TxZ8XF2s1zjQJfT/hzst4Ez+Zpo6X0b/pxz1NPRow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUqm4Iuqa8m6pLiAz6kzEjsmcq02IfLDQCCaIwmJA8iXE6odB
	SJF1D8lLOnjA9lOjJuXgknNl+Cm6WKC//6Jfg+IuMV4CmCes1MxrE4pYt8mgbDWEFsA=
X-Gm-Gg: ASbGnctv2zReYVZmDcadxIum93LVz8eZWXL31uuJBNVcgAzJ/uo2lis5IGSbqfuPvid
	ew3JYQ/QpBTTl2w5U7/o0oVeesWpv1Wz8U0RU2EdOMZV5RIc8cvqH7oUTi8XrS1+RYIrzYDl7QK
	pyUjPStfIPjit6RnO09iTvHsKrf0zqnSWKhgujpu7y6L0UYF2F80c2KlFvcVMvbY+ipf9bt6qfg
	9LEp/JR8uXftmPC8JgErwFUKnxI+rnh8oqvVcBSCkE8RlYRivi0yg+RRxmAGwxyfSD2RkahVkNR
	U6cj5gF4Cb+Noq5Waaeg3ndiuhP7q5JrDP98Q58ECuuiyCr/brjdmu4UnvSI9pXyq4A=
X-Google-Smtp-Source: AGHT+IELB9+pNcDTkVOHPL/gOGh/dFD5vIeXRtZ4EcHs9SW1wTIVbahz2V1SNST0dxBLQTNMDjnyYw==
X-Received: by 2002:a05:6000:2308:b0:3a4:d3ff:cef2 with SMTP id ffacd0b85a97d-3a56876b2f9mr1366057f8f.27.1749792979547;
        Thu, 12 Jun 2025 22:36:19 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b79f45sm1207245f8f.101.2025.06.12.22.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:36:19 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:36:15 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ecree.xilinx@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next 4/9] net: ethtool: add dedicated callbacks for
 getting and setting rxfh fields
Message-ID: <aEu4zx_dsc2FCdpu@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, ecree.xilinx@gmail.com,
	andrew@lunn.ch
References: <20250611145949.2674086-1-kuba@kernel.org>
 <20250611145949.2674086-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611145949.2674086-5-kuba@kernel.org>

On Wed, Jun 11, 2025 at 07:59:44AM -0700, Jakub Kicinski wrote:
> We mux multiple calls to the drivers via the .get_nfc and .set_nfc
> callbacks. This is slightly inconvenient to the drivers as they
> have to de-mux them back. It will also be awkward for netlink code
> to construct struct ethtool_rxnfc when it wants to get info about
> RX Flow Hash, from the RSS module.
> 
> Add dedicated driver callbacks. Create struct ethtool_rxfh_fields
> which contains only data relevant to RXFH. Maintain the names of
> the fields to avoid having to heavily modify the drivers.
> 
> For now support both callbacks, once all drivers are converted
> ethtool_*et_rxfh_fields() will stop using the rxnfc callbacks.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: ecree.xilinx@gmail.com
> ---

[...]

> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index bd9fd95bb82f..f4d4d60275f8 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c

[...]

> @@ -1492,7 +1527,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	u8 *rss_config;
>  	int ret;
>  
> -	if (!ops->get_rxnfc || !ops->set_rxfh)
> +	if ((!ops->get_rxnfc && !ops->get_rxfh_fields) || !ops->set_rxfh)
>  		return -EOPNOTSUPP;

I realize I am late to the thread, but is this part above correct? It seems
like ethtool_set_rxfh calls ops->get_rxnfc but not ops->get_rxfh_fields,
unless I missed something in an earlier patch?

