Return-Path: <netdev+bounces-250099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D9ED24038
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7601300ACDB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E07F36CDE9;
	Thu, 15 Jan 2026 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iycW9zKo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rgpKrlCb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF83644D7
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474009; cv=none; b=uS8mbjX1USQifEwA3PizFXw9CyP7eKD1v6sOP5UJYuU4yA9Kc9scYVyG62yj5ukmAjiKgjIbiAIb+Lfk7I+S+cA+GTbh5qXdL0P8zy301+AYOFiWvdtvgWNh7MiKfwnxZDkm40wQraE8rVlH8cRre502RXBwLlSTrLDSi1xRDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474009; c=relaxed/simple;
	bh=dZ2nTyjj18HR2cssXy6a5IcC1dvB7fw00uUv9Xm3ADE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux4yIgM4MvTapC2VSHKQkbZqHFPyGTuhD+OrhxTtvNplB0+bS9qe41Dsm3ilj4HSAiES7MYYEV/45l3CBkjwNnUQiIKNi+Kp2jQ7U/y2xKzGhdctSQWrQxdwy0QsruLw1EfwfswbltVVAnBsXYDAE8VAsHH4JJ+2X/Z+PhBn+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iycW9zKo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rgpKrlCb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768474006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKksFyGM8lgvVYizWKYldzLgar+5BtQXya1EmOTk8kY=;
	b=iycW9zKoVEz10idvenzXXIp/fHe5yw0aA8yoYyAGkWVfEmQ4hZKDk7u43EuHJxFriUcvc1
	BRgM8+4Hx9fybMk5/a8Aobhh+W6HVPT+wVSKkd51oDQZpOM/XllsHUUXKteuXdqjZkyAea
	XlF1viVyglGp90aIQlb9RlDLmHRCAg8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-QaIPCQ-1O9irvd2K5JIEIg-1; Thu, 15 Jan 2026 05:46:45 -0500
X-MC-Unique: QaIPCQ-1O9irvd2K5JIEIg-1
X-Mimecast-MFC-AGG-ID: QaIPCQ-1O9irvd2K5JIEIg_1768474004
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fc83f58dso508107f8f.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768474004; x=1769078804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKksFyGM8lgvVYizWKYldzLgar+5BtQXya1EmOTk8kY=;
        b=rgpKrlCbYHu132+dobz0YuDmFIYbWAQF78zoNAKMp0pPjCV/mfjW7a/zf0vaqR4qof
         QRALPQVn2i/TqogbUx/gQYJK4zmJvUJZyycured72gVbdGQ43rJ4NGa9nfAyTt9kUz4h
         iGDI68Qi/NbqNWXbevGeUtXamZ6ARGezimfjGHz9VynmoEXVBfYGu6S3antgbFbpraeR
         e1ZNANbq8NPUbHHerRyEoJpJGk3R5YFvyfjUCSS7F4FS82oMcmaD0vquj+uoavrvgOjX
         8KorqsOSozL3i6pIwUsAAIuUTSQyrMZKPtz3ffJaumUsrN0OZ3FaQipkLg5k4nmefQz8
         ptgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768474004; x=1769078804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKksFyGM8lgvVYizWKYldzLgar+5BtQXya1EmOTk8kY=;
        b=PPM0NgaX3Il+Tch5gFohYLtpos1fTedi6Wz7AK7ioOY4kyrGWkUHHy8N7CUhy479X/
         TyhJFC4jBkb0xSZDD44ROLQRY3/Ue2r0b4Rnd/FkeWuVS7BDdTkB/01Y4yB1xONQFkvj
         62JPQdJn9K7+vc4Vh+Uy4WlIUbRPS9ffG9STZ1mRx73sff0FxiQXILGH90mKYMkDGhZr
         ErBoc5/IytbGCpfBilfQQq9W4UlwptoQSE0xqiFqWP3XoHsRbSVH86QzV/yq8we5kysK
         qMZZe94dixnXKYZtCdwxky83NeQp4crBHO8Cqj9O9qE9BAteDJU5kCDu4mCUFJGiRoVz
         b8aw==
X-Forwarded-Encrypted: i=1; AJvYcCXEekSsqONcfXYC1qfA4lGPk7SMSYYYAjdE4A+/LOXFGGdzRB+pMGfaPPn1a9MIDxZr4n1bWFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtZ6c/7mwRckJMasu7VCEFmgcMfgDpTKU87ttSL8bfbuFSN1s
	uGXg1WmS3eETKrVdrCo09CLXUBth1B6/wFfdITPiGvk6fzFFh6BRDYHHk5HSdRrphhC6vysuyNa
	tf3flSgovyh0Yx/PTQIq7V0I/9P8bSaX2Fs19hLxMjiaUxmgLmbi4cSPFDQ==
X-Gm-Gg: AY/fxX4ycQzWLRqNgHoUwdvtC1+Uvsw8W2d7Jvq1oVpklT6GUNZafhwMAUZr3RasUbE
	1jQEm9BZoXNgBs+LgYtXZhyl3+tey9s5f8D35c6yvlpr+MjChYjcaBHOWSYeBaiFcRLyC2Z3Lc/
	TC2ZNl0Ik7zAbojlZScb6jyeIcUctQkKXe2AOcHC836Hiert40oakKwctn4fh42aN23L35U4nSw
	uimffUslCht7srm4k4AsCCMRW54/sbjf2Xf6LBLG3gK+jUsMMsLmGm1Lruea4CpWATji+1pL9Y7
	2YkKr0TuiwdwaMXe8AUQTNIexACruYDqshRME4vgOjv1eXtjngKGNcT89XKmkJy1/4gbHZngL/f
	y4GF6PktO2vDldg==
X-Received: by 2002:a05:600c:64c8:b0:480:1a8a:a1ea with SMTP id 5b1f17b1804b1-4801a8aa2femr16533705e9.13.1768474004192;
        Thu, 15 Jan 2026 02:46:44 -0800 (PST)
X-Received: by 2002:a05:600c:64c8:b0:480:1a8a:a1ea with SMTP id 5b1f17b1804b1-4801a8aa2femr16533535e9.13.1768474003840;
        Thu, 15 Jan 2026 02:46:43 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee6f59cf4sm29431125e9.12.2026.01.15.02.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 02:46:43 -0800 (PST)
Message-ID: <d3624dc9-848a-4c59-84d2-8663f0827937@redhat.com>
Date: Thu, 15 Jan 2026 11:46:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v4 1/4] net: bonding: use workqueue to
 make sure peer notify updated in lacp mode
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu
 <liuhangbin@gmail.com>, Jason Xing <kerneljasonxing@gmail.com>
References: <cover.1768184929.git.tonghao@bamaicloud.com>
 <895aa5609ef5be99150b4f3579ac0aa96ed083a7.1768184929.git.tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <895aa5609ef5be99150b4f3579ac0aa96ed083a7.1768184929.git.tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 3:40 AM, Tonghao Zhang wrote:
> +static void bond_peer_notify_handler(struct work_struct *work)
> +{
> +	struct bonding *bond = container_of(work, struct bonding,
> +					    peer_notify_work.work);
> +
> +	if (!rtnl_trylock()) {
> +		bond_peer_notify_work_rearm(bond, 1);
> +		return;
> +	}
> +
> +	bond_peer_notify_reset(bond);
> +
> +	rtnl_unlock();
> +	return;

I'm sorry for nit picking, but this is a bit ugly: please remove the
`return;` statement above.

> @@ -1279,19 +1306,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  				bond_do_fail_over_mac(bond, new_active,
>  						      old_active);
>  
> +			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
> +
>  			if (netif_running(bond->dev)) {
> -				bond->send_peer_notif =
> -					bond->params.num_peer_notif *
> -					max(1, bond->params.peer_notif_delay);
> -				should_notify_peers =
> -					bond_should_notify_peers(bond);
> -			}
> +				bond_peer_notify_reset(bond);
>  
> -			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
> -			if (should_notify_peers) {
> -				bond->send_peer_notif--;
> -				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> -							 bond->dev);
> +				if (bond_should_notify_peers(bond)) {
> +					bond->send_peer_notif--;
> +					call_netdevice_notifiers(
> +							NETDEV_NOTIFY_PEERS,
> +							bond->dev);

Since a repost is needed, plase move this if block to a separate helper
to reduce indentation and avoid bad formatting.

Thanks,

Paolo


