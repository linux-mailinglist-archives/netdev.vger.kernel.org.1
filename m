Return-Path: <netdev+bounces-114893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E3944943
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0161F230F1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9C170A34;
	Thu,  1 Aug 2024 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYyTNlaB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F3446A1
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507949; cv=none; b=Senu93BABlGEjedYMY/2SdX3scDKAtUVpkCyORZVTp+DxNrtJ4gIXBlFU/gwLy+OIjfVYNuU6zNsvA4C3w8HvGVla713j6j2hOQyJI89gugGS/YBidZogEyEqNXt3i4mQ3RF1fR0aJO86v//HJgg+wbRDrMXQ8MAgLqxWchnA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507949; c=relaxed/simple;
	bh=iZClEU3Bl4WzVHBFC518QWMQW5wfXlFiHdPhgAH8iQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DF19VEXiH8lXZqZgLQHPxyWt0BO+pO074Wz79Q65seJNfyZl8c2BLh57Jo/tLbxY0aO27B4urFpCxOawOizWX9lImbU84ctYRXhSX/+wUKm4eOht2I991hdxVIn1FrsSk31Mr35LzrstumFRdo/GDlxPsNIrAn/I0OGg9dACC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYyTNlaB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722507944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQkkrAPQwecwOQ18uDWPmVdaGmQ67evbO7cOUB5GUDo=;
	b=aYyTNlaBfjBcOb2+qxHZnQVtgq5luk/s9H9Ey9Y5U2DZ0p+TQSzoYmFLRI5IBQihedaWCg
	ctIYplTpnxvHC6+derJZ5OA1rH/tW9fzZuWqSzkebOZeq6K0L5x0TrHT/ositUecC4Eer9
	1r5WxBKbQoeEOgXgJ6kROSffwh4lKZg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-vVvw_QkRM5-0rcaY0tQ6Pw-1; Thu, 01 Aug 2024 06:25:43 -0400
X-MC-Unique: vVvw_QkRM5-0rcaY0tQ6Pw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4210e98f8d7so8997035e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 03:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507942; x=1723112742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQkkrAPQwecwOQ18uDWPmVdaGmQ67evbO7cOUB5GUDo=;
        b=LoeRQyDlGfeL1UAcSDq1fQQHVeg4bP9sUFgm3h7cMtJR8jZbd4W2VvVZ+AthBWM2yI
         5V+qBO2lruCY8GS9lsfdho/eqYOLnRa1IHWXEpUmMf7nQU8zxIfci6Kum75SLEK3Ecq3
         IJHjGq+MlZUfFP6Ok/kZ4zqhatmNlZePOwG6dt7I0OpL7qQETSHyTgtFW6QucY+iVcZq
         WlyCtgpNzuBcG5fCzkboq4+gu1xoxSVypZY+vhlRrsfcDrtYHuFlEr4w9xmo3Wkl+FLd
         b8LmRlsNXtHUKNc1+jtVo1uYZI3wWEiEg0fGYwd5nMCYqy00d01N/4zFNWLv8vVA4a0Y
         E7cQ==
X-Gm-Message-State: AOJu0YyDXJNPz8yJqYkyLviO8f72FZAxcbt1DmzPlZZ6EKbLl/26wE4M
	MeuDGHn+wyoVwFFr56nZzayhUrzBfy1k4/nJIriEuVt7TTd9CILCqJj+0wf2VWIfh0tVBoYvAxM
	WQyi3rGuKbB6z3++jv4rADEuZVGhhhR6VOvun0zWppLl5Q2s0WOtVsA==
X-Received: by 2002:a5d:6d83:0:b0:368:4c5:af3 with SMTP id ffacd0b85a97d-36baaf9f521mr883922f8f.8.1722507942111;
        Thu, 01 Aug 2024 03:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEtSclpr/Y80G4Oip8Taqi5hTXWiVLwJRu1yc7hHV2l4citaf760Mm1ZYZVZ0C78iEsrUtYg==
X-Received: by 2002:a5d:6d83:0:b0:368:4c5:af3 with SMTP id ffacd0b85a97d-36baaf9f521mr883909f8f.8.1722507941562;
        Thu, 01 Aug 2024 03:25:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc6adsm18995045f8f.51.2024.08.01.03.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 03:25:41 -0700 (PDT)
Message-ID: <f150dec8-7187-417a-a700-4ea7ce44f721@redhat.com>
Date: Thu, 1 Aug 2024 12:25:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 3/3] bonding: change ipsec_lock from spin lock to
 mutex
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>
References: <20240801094914.1928768-1-tariqt@nvidia.com>
 <20240801094914.1928768-4-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240801094914.1928768-4-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 11:49, Tariq Toukan wrote:
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e6514ef7ad89..0f8d1b29dc7f 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -436,41 +436,34 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
>   	if (!bond_dev)
>   		return -EINVAL;
>   
> -	rcu_read_lock();
>   	bond = netdev_priv(bond_dev);
>   	slave = rcu_dereference(bond->curr_active_slave);
> -	if (!slave) {
> -		rcu_read_unlock();

I'm sorry, I probably was not clear with my question on the previous 
revision.

I asked if this code is under RTNL lock already, if so we could replace 
rcu_dereference with rtnl_dereference() and drop the rcu lock.

You stated this block is not under the RTNL lock, so we still need the 
rcu lock around rcu_dereference().

Same thing in bond_ipsec_del_sa().

Please have a run with CONFIG_PROVE_RCU, it should splat on such 
dereference.

Thanks,

Paolo


