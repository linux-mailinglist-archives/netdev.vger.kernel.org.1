Return-Path: <netdev+bounces-125488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5A096D589
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615071F292F7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BB199389;
	Thu,  5 Sep 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYrl0NrH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E419922A
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531053; cv=none; b=Nqs6oh2BjfMhTLdU6WCMElPqHVb6svxzUhOX5E8m9jyiSyGq4t45FdC+Q9+jqu21pATg4v6q9Vghfytt0rkop8YMYw48CSGg0dl4pmMP4iyhp+tMmKduIt9tTeqkupQVIkhPYb1pju8uC+6adfofUkaqWiK0NV2TLS5E+AblYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531053; c=relaxed/simple;
	bh=cBe8sSpkzIPUNbYdTQ9Y4CF5l4pTJfe4EnCGYPSCLxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2jxBrX+vTNTQALUPkJGJ5+0sliKu5EZllOzoGaM89jeDU5kcPnrRUBdiBTb/yONdXOFfGV3vTJxL0RJmDIA6W1D3/IJdirr3TH8mBw/aSlLGlYZPhNEfpSlOqit/OIdrMt6Hgwq+E9TgWyQfr/e876ADGs2aoxjkQSgyiaWcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYrl0NrH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725531050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0teAkyIxaQF3tqPPR/0rHNjidomC+KXZ12snZ/y5XOg=;
	b=JYrl0NrHSv7NHyVLkG1G6cYmqxhRpPeWFRz3Uj4I8BFgmsYCW+HgUV/fNTi5PiRIVMKg0T
	YFmnmUwxnZHU7Qy6H9mhO7suFd69ye4P5ijukKEYO6N+EC5LhhCqOWJ5z4WNQkmC4cIKl2
	ewInUfTyjjz3YOgixyL73L8IGIKSnsU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-4_ytDBJVO6SMyGmq9BxP-Q-1; Thu, 05 Sep 2024 06:10:49 -0400
X-MC-Unique: 4_ytDBJVO6SMyGmq9BxP-Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c90d24e3so461053f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 03:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531048; x=1726135848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0teAkyIxaQF3tqPPR/0rHNjidomC+KXZ12snZ/y5XOg=;
        b=ewWjMkhQ9DGuNQlRZ9FO3SQsKflcW3nx07qqBxKJyHaDTeYcPuYU3XZ3RgX2snpqBJ
         V7L811vblXLfoqxyoLeoVHgdy3Vwf42Ztr7ZBqtRCzw7/PvhfbO7qtfn9YidSzDebpAA
         GQiqBgxJtjLeouc01sBPBXUpIRyifM+o1I9hAjZnFjOrqmaQaBOScDtTlcUZw0K2poam
         QdIxOUALGoedeRleSWlmEkWfj2qGNlPkzBfiwy6rr9Td8cbesXsrLgal3iuF5OoAKKtd
         PWfsLzgK90CjsN0ETUvd0xkS9wzbGMkAHg/bqG3kSTWVBduiKFNzpXsrfWtwrkJwokE8
         DTqA==
X-Forwarded-Encrypted: i=1; AJvYcCWbncI5iHJAKhSwimHQqbiSpTuVOrcyiixCAp05ESfWXOTuXADEtKJVJZKJS4xPjEJzVW1/i6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCEHThYOoQo5vYvS1jIfBItuQbX+4uLZrwyibFTH+V7hLSrtb
	J1BmtehpkRnAgjBQcrC8x1o8aIiDd+rBY2nT3jClqQiLfvCvYhJSsaHBbOFZj5PAlCV+6vRzaUV
	Zix8cqpHAF154taRwuLvhGdk8hiNvAMHomJTcq47vWBduJ4+nCV/u/g==
X-Received: by 2002:a5d:6d05:0:b0:374:c231:a5ea with SMTP id ffacd0b85a97d-374c231ab35mr14568279f8f.5.1725531047895;
        Thu, 05 Sep 2024 03:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFowkwDiPwaM9wpYpfNUi84o0mhCVB4P3QbkABbz603ypTH6pars552aw4N0k7UTIUaCxxNOw==
X-Received: by 2002:a5d:6d05:0:b0:374:c231:a5ea with SMTP id ffacd0b85a97d-374c231ab35mr14568233f8f.5.1725531047372;
        Thu, 05 Sep 2024 03:10:47 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4d391sm19083130f8f.3.2024.09.05.03.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:10:46 -0700 (PDT)
Message-ID: <b5da52e7-6715-4f94-ba95-5453972d9f8d@redhat.com>
Date: Thu, 5 Sep 2024 12:10:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 6/8] net: ibm: emac: use netdev's phydev
 directly
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com
References: <20240903194312.12718-1-rosenp@gmail.com>
 <20240903194312.12718-7-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240903194312.12718-7-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/3/24 21:42, Rosen Penev wrote:
> @@ -2622,26 +2618,28 @@ static int emac_dt_mdio_probe(struct emac_instance *dev)
>   static int emac_dt_phy_connect(struct emac_instance *dev,
>   			       struct device_node *phy_handle)
>   {
> +	struct phy_device *phy_dev = dev->ndev->phydev;

The above assignment looks confusing/not needed, as 'phy_dev' will be 
initialized a few line later and not used in between.

Cheers,

Paolo


