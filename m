Return-Path: <netdev+bounces-146805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5C9D5F7A
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 14:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E78281A98
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC1187321;
	Fri, 22 Nov 2024 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4HNrih2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C71EB39
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280688; cv=none; b=pXiuDYjFY7L8dAKW0rWKpvaF9OErEz/ZHOIHIF7KRiwykDWDTbnE0kCjsLWAHdkV7XLo5pHtOlVjOqt4MQNzjV5Nuba9j620XeNy0lTXLDKH0tmJDghoAcA4cGYGh0rv64CsBGWEd0eSQJTlu35WqqG50zzmFJle7x0V7bQDoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280688; c=relaxed/simple;
	bh=OU641Mwt3lc5DHk4EQnF1DL6zGFJ33VlJP27E9PxpXE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uZ6SPEqqqSOuJb9E2H1alB51xs8XFe+EbI5dZQKVYzm2eCMUN04NwFKnUHgvNP6VIh1VFUWCwVknkcxMBcDTsYuJty8AoGO3kpA/Yjf8+zqbLoXUiQl8dTMypy9kt6YcMgjkXaWEyU2RhYpxtJnmi9Gk18RkHCwt6DzCAZRHmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4HNrih2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732280685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KucHI7FM8gNMbSzw2YobyJJ1PoBnTscXsG3HKd+uYY=;
	b=R4HNrih2QWRRi1uYSq2XIfjB6kNM3ftuxe1TwvJ10EcjeMH/AQshQBP7A89O0mVoKtj/4v
	DltzVj/4o12djFYCYiNMH9k8ADnt5C7sPvpc9KZMwJ/LTuEmIT8IUCTTgjx+zzOxIfsi16
	IPIjt7g+wvCvgfKkheD1bacfDv6f1cE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-2nKlgRpiP6aKMN0gMHHM2w-1; Fri, 22 Nov 2024 08:04:44 -0500
X-MC-Unique: 2nKlgRpiP6aKMN0gMHHM2w-1
X-Mimecast-MFC-AGG-ID: 2nKlgRpiP6aKMN0gMHHM2w
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-382412f3e62so1021707f8f.3
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 05:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280682; x=1732885482;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KucHI7FM8gNMbSzw2YobyJJ1PoBnTscXsG3HKd+uYY=;
        b=koEdeJLcKVn+TqdstRTqic6ZWcF5WrhdPGpJUBkC23rdyHgQjTABNoY6wLSxXir1NC
         iuKMGRMsRKO4+p+jRJXe+CFAYELEOn9Pup4BOWoXdr/S4E1rGi/51EMufBWdWe0WtwiO
         ggLfQyGFuoem2a4JCx1gTPiu5SjjjatXXV1OR2biAWLIkhr+SgdbxGETU0O9jD4+M00K
         F6xjTb0q7MevX8UiXu3NA9v05/SZAkgf0PTFv8kBI/N7BxxubIMPQB9u+px7Bc10GltC
         AQ1w1sXJoIwMzQURgHxo9KlUZ3Z6bzPY0SsNvwGG0BaQaVdNn26jpIcOv36esJE6eY1+
         MXRw==
X-Gm-Message-State: AOJu0YxzrM/KfuGpGeOma0Qbwh5BJy8BwpyV6IJmIue+QK7BRAiMd2om
	YJkegodv6CiCOAPgrXY8ya+nmOLbQiL1iiovkT7yev7tFcaME/nMAUtXytTEEXiquqLgMUrWSXW
	xVz8rNQzFx18WYZgQipbvl/7FQ2c8p4iUxj+xvsYuDZFon0lIOkb9I71l92pQp7rS6sWPCQSQcB
	R+JMJGRP/AOM8e5NTfAi5x0yqp61+3cwqRk3Y=
X-Gm-Gg: ASbGncvCpi4zlTCEy0zrtyi+ImBNOcwELtSHfFTqcEKIyygd/RdkXrUrI64bU8AEl2z
	FXGMqI20vMdKTcW2O1X7tqAa9eZAbjgSXwYEoZzWvrx7/R4tbudLkLnNGcxvtlyL3w/60irzoZu
	05zNXJASi71m+MA5etC/XwkIG+nKAQfAd83ahUwAuOI2wrJ1/SXUQaOlZkn8Di1ldZ1SpxhRDkE
	Pg/XurMsh9CNNCQRzNEWBNE6MsmwJ3w9XlAUm6+/k2uj7/stAgKj4oOza+ptJ4riAL8fVLyCAog
	d1Q=
X-Received: by 2002:a05:6000:a07:b0:382:4f5e:70c4 with SMTP id ffacd0b85a97d-38260bd07f5mr2815767f8f.38.1732280682365;
        Fri, 22 Nov 2024 05:04:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH48bUCyD4PQyu6V8K4patokFNR1k2Meb9WK7KuhOKskyoNLWw4gIQbFrajtXQI6m/ykZ5VLQ==
X-Received: by 2002:a05:6000:a07:b0:382:4f5e:70c4 with SMTP id ffacd0b85a97d-38260bd07f5mr2815363f8f.38.1732280677346;
        Fri, 22 Nov 2024 05:04:37 -0800 (PST)
Received: from [192.168.88.24] (146-241-43-107.dyn.eolo.it. [146.241.43.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432f643b299sm79686655e9.0.2024.11.22.05.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 05:04:36 -0800 (PST)
Message-ID: <05cb7a72-5954-4c0a-ad4c-250d18a12ba9@redhat.com>
Date: Fri, 22 Nov 2024 14:04:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] ipmr: add debug check for mr table cleanup
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, stefan.wiehler@nokia.com
References: <cover.1732270911.git.pabeni@redhat.com>
 <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/24 12:02, Paolo Abeni wrote:
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index c58dd78509a2..c6ad01dc8310 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -358,6 +358,11 @@ bool ipmr_rule_default(const struct fib_rule *rule)
>  EXPORT_SYMBOL(ipmr_rule_default);
>  #endif
>  
> +static bool ipmr_can_free_table(struct net *net)
> +{
> +	return !check_net(net) || !net->ipv4.mr_rules_ops;

Not so good. mr_rules_ops exists only for
CONFIG_IP_MROUTE_MULTIPLE_TABLES builds.

/P


