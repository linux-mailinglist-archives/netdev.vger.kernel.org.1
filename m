Return-Path: <netdev+bounces-240377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B47C73FC1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EBFAA2ABB1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67F1B4138;
	Thu, 20 Nov 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RO3tEBDr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPDM/QsV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD130E843
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642041; cv=none; b=eU6mirRMaYw6Q7wObLXvcU954qZt9nxKsHk+NpD6cAyXirpDHjirjLtr+5p6m5wDVd0e7Pq/c5OEkTA4r+HP0OMWg7sELyX+dnX/hewMCEmVu/1OapjDr07bkcUgJ8v0Nt04E1YrZj3nRyo4jBGr486P6e2Sic6IPamDZ2UsmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642041; c=relaxed/simple;
	bh=gdPSr3t4MDhEa/v02eIMp73csS0CV/y/UflCUevS2H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGH86IZaVP3ZJSUybjcGv7sSX+yXebG7aPZLc7B0+YeiDNuEBxube6s8D5oBMgP/R8WCU7gITXJpWga4gBou0ymXU9rgFfQyAqkZ33s0FPlp0sAfXKBrWl5q7IDREBt1Qqywg4dgpdnciJk2emH3ZOipH/o9i3NSbG1qcNX4x80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RO3tEBDr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPDM/QsV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763642038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeyrU02qV7KSBEb+cs90Si/v9DX4zURUEHdNh0V2oU0=;
	b=RO3tEBDr/hyLgZqpuDK2H/nevPPuE34dYcCNZuLrhb0CJ3DDtCUb9bG24h9le1/+G2HDHf
	nytvpMcTq8qgfoZ48/6jJticdlHUE5pilIHAIiKf2+6Ra4qmGFEZVCqr4AlLFmYTGkb4Lz
	FrD9GRtomfREoBbYn75F1nqZbuBT7u4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-0M8BD3zzPV-XOVpVReQ-8Q-1; Thu, 20 Nov 2025 07:33:57 -0500
X-MC-Unique: 0M8BD3zzPV-XOVpVReQ-8Q-1
X-Mimecast-MFC-AGG-ID: 0M8BD3zzPV-XOVpVReQ-8Q_1763642036
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso12651785e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763642036; x=1764246836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeyrU02qV7KSBEb+cs90Si/v9DX4zURUEHdNh0V2oU0=;
        b=XPDM/QsViP33yh0AK912LYiRI3EqzTSaehsRIMFHefxRsabG6BEL0OYyj0nylMH+5K
         oJuVSh7MzwRk2ybWavdY2xjUTqKl7m/+LWbZCId/s4pigIZp3jWP49avy94kTsuJtRxI
         Wrp5aqXBip38Y/A5qx+qMk3HqjLPxqgHur72Q+3iFvj3/zEYMr8dCuYedFGqN3cFBjoJ
         TTx3g7JGWV/aDFl/2S8b0UQaA4HVbEjDJuK6U8Q6mSh8GAk4MCuZygkesHgSe/go6XHO
         oK/H29+0fAI0boGkKwrtML413u2QtjbTiRz+x9r7Q/hOl4E6Rg4DQ/U0Nsr+5yLYAjQo
         DLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763642036; x=1764246836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeyrU02qV7KSBEb+cs90Si/v9DX4zURUEHdNh0V2oU0=;
        b=SMklZZ5ves3zgArL25QhtIv5aI7LsASinADcrQ0Y4QpEaB6oUzPwvled7xg4s1dTn+
         oF/zGVCf6fhy7RYyeD9DFyUCsmr5dhh1+sc7gHyLuGDgoE0nAiHSjNb3lmvuj/kZJ5ne
         ktR5KYsAIdL7pKhWQIoGVoP7Hzizx1TEZablaVUB9bChzq5P14SYMhmFS+Fi+nUsClM5
         3tINmpguVhjYpCpyytN0N1mi8CLeeDcyJkjpk05pzCxHztYnQRbvh7/j+VLgSNvvzArn
         9f9zI/7qQcdwr/v+LaNOdXd4G3t3HbgC507hEECvw+jW8QznNnANzOp7rnHT1OaPFvsD
         snjw==
X-Forwarded-Encrypted: i=1; AJvYcCWci43kSfLcAETvlIg/WDgqmYMfnxmz5AjUFDkA6yC11KBt7DORHcFnWzN3h2YhW7XUpdLo58I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/b4xTLze0XE7Gb/hR6ayrBT4sWwCKEjq5iSgMBcKX8cskYTu
	b5nSkzZxgVQMDrAyH7QlnPUeEQGYlG/czrtZYiF7GN8npLnFBiXatRIzV8VXN+lZdkV5P+VrJbW
	T0OIG5IFyUwTRUwFQvjNPnhUCNEQbrSmpgZszmNQi3DZx5v6w0muCAGU9dQ==
X-Gm-Gg: ASbGnctXrWILOCtu7NrdAO4/Uov02YPzBkby9q0Z6/WiT/2hZWBWjwmCEld1wEzJkkH
	KiPL8mr3W1OzkpXjiQsgN6MAQ5DDe4u1y+IknXZXehEKstnKXicwNueDRFB6JwIQL7/6TfD2wJH
	bP4e+EjvYk4dK4ACG/4lU+WYc78QOw2+1BgBumig78ZDqlWDqL4cA9BNv8KSHq2dzyqskfwgn1H
	BeNY5ZkOkbDZY5jnZvBTH4zwbscafWosjSr/tXbU8aJ0Jfmn82bsbP6xdtysFZxuuchuXaNOp5H
	NSxwLxZn8e5tXR6kVBZU4u65Xogi0EtfXeYS8YuXBbjGTQ+vbkHNYchaqHd5P8p0L30NqATqspg
	9hihs8UM2GTrA
X-Received: by 2002:a05:600c:2e4c:b0:477:9890:4528 with SMTP id 5b1f17b1804b1-477b9ea31e9mr16247845e9.2.1763642036413;
        Thu, 20 Nov 2025 04:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8UVIDSYeG1lq4fkerFuvgf0McyWNL456IVktdYfpWZGMazlIbqhsYjXkvDzzfwMNpCh7hcA==
X-Received: by 2002:a05:600c:2e4c:b0:477:9890:4528 with SMTP id 5b1f17b1804b1-477b9ea31e9mr16247615e9.2.1763642036042;
        Thu, 20 Nov 2025 04:33:56 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a97213b8sm63208895e9.1.2025.11.20.04.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 04:33:55 -0800 (PST)
Message-ID: <9eb3b5bd-5866-49fb-b4fc-5491cb3d426c@redhat.com>
Date: Thu, 20 Nov 2025 13:33:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: bonding: use workqueue to make sure peer
 notify updated in lacp mode
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>
References: <20251118090305.35558-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251118090305.35558-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 10:03 AM, Tonghao Zhang wrote:
> +static void bond_peer_notify_handler(struct work_struct *work)
> +{
> +	struct bonding *bond = container_of(work, struct bonding,
> +					    peer_notify_work.work);
> +
> +	if (!rtnl_trylock())
> +		goto rearm;

Why trylock() here? This is process context, you could just call

	rtnl_lock();

and no re-schedule.

/P


