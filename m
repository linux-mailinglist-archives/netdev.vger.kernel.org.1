Return-Path: <netdev+bounces-190364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A195AB67CD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE044623CA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77622A7FC;
	Wed, 14 May 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="LSBrnNkm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216DB1F875A
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215556; cv=none; b=V8ZcvkJJCxTZF7r6KLCABC/yyDN+Rimop2nrCCwbJGTe9uWkuK/mUDKSLo/5RoT4CsbDJmcsbiEzneaiKU0dUbNKCh5tURQPbASU1YwUtjbGpS6ZqE0qYbIaug6cwtovToNWEW/96qaY602U+tqlAuKlSyD5dnmNT0Ht6EJUoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215556; c=relaxed/simple;
	bh=Dcbrt5HbujdgErAXWC22weFlHTLUlNarAbMqOYDWTG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMLNUHGbw2EC2/J8kjb6xb8/M3odA4zTQGN2HO9VFddlAGuEwXfy2epX16UdzE/s8s14fm8XbHDZZUuDJB+uQhSJQC603qGAjAxcJ5zWJy2RWWn1h3yz4v/dxEtUcbAr70vl7LJgUGAufTXDAKwUIpOO9Gk87gEok1hi45wUwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=LSBrnNkm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso49923335e9.3
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747215553; x=1747820353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0fcvxOpULotimtsfELjkB7Tse02g/5NAAFNtnM3iUo=;
        b=LSBrnNkm+nRbCwupedrrfvno2A9GN0oKNHy372WIdO7Vd62JRNz6h7Wd4IiHFWLO01
         geXVDUSSIJTH2884gTRzskas1U7iTeDDGkjnvc/fsj3Dh1wDSelFabFe8Ggceb7HKQe5
         cK712hI/NZKpB9B1M/XPizb3hQFklgD+1v78jjZElH0q2oGyNCZkVIShkCU9qEs1dwJ3
         8ZWeGwF+BN1kC3gBS0W8pIUkx9LkmMt0sN2PbH+DBivF+tpDINP4sCzrE8tVGu65BzTz
         dXx5LUA07L0rrbJAhI6ojeaC6PL/rjUnBfkDdb77u2lejKVP5J4q1LbeTInNatZe486s
         Q//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747215553; x=1747820353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0fcvxOpULotimtsfELjkB7Tse02g/5NAAFNtnM3iUo=;
        b=gimKOtLPPrs5yblPZEzyW5FfmrqyD8VdUrfgVAiiNS9b6oE5zXHYE1azlMzk++VUNq
         +WcJk6htbVXqrOlDQhfmrVkZLKCvQ1yWhH9iQH5uU1ZWN06p8bB4h3ebcryydZggtOPX
         BHXYjSaW6/fTEVpbOB/a6EaVjV0CggXKlVmsT1tKC+XYB6PuDUskGm//3YgXIyzj9j8R
         5vDHVbW3UOeH1WoubU6398baAMxtVIfvnnIzJHry5lCqHV0ElMY42tTJP+Us2zugkvcw
         iwg0M1lJSD+CVtn4Gyzrny7StuR95qDnmmZ2caEJqQvT2SIq861kGF2G1HzFX9Vknhvd
         wxUA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Z6vs3/I38s+UNRN08gPSwBG/bU22vB893VybEax/nAXO+4fk6IDBJfzv9GZsGiuDODZFpKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytbGx4dTZd1wPHHshTAz9R/8kEmGSwHEY8W59RmPjExjX7YAly
	u8wAtPbTCzKVXIE+QdAHK7dHHO5kgNbZ5wfhbCXpBw7iPBAEYpzAWW5Mgo45Bx8=
X-Gm-Gg: ASbGncukN2dcZUuEGVUafidwmanDQa7GL8tFRjZmeSXuyok5SU9pCf0bQejF1Trv9Vj
	NJS+bTAZNIOYkAqapGoQl/ElqQ5tAkNLGXv/ONd02/5gg82Ay1kGPyppr4xC5Ab99WSbhi//Jw9
	IiF19bSPujNaXn1F5jHc+1ph01BfxZTNUe+8KXiucy9T0iQ2qYf2IEPxe2+UeyDrZpPoBGS9Ml/
	u5SuwYcPQpgqU7D8F0DJtjRYE9xOAA/OVYQMBNzyd2icA198BAcw7uXphOj1rZ9y7iAKpu6WY/I
	TQNYWi4No/pkm41winBFQpHXZ70ju/dCEgQ8gEYxnHGuuwmet65Jnkvhzmthi/W58/UzmOpBUY4
	psyhHy1A=
X-Google-Smtp-Source: AGHT+IHOGZM/7OSwm7VX/VQXE00qpSKClnmBjtw7AkcAhWefT0uX4zlGW1NDJ4Mw1rCuKwUtTqE8hQ==
X-Received: by 2002:a05:6000:401e:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-3a3496a41edmr2449978f8f.14.1747215553347;
        Wed, 14 May 2025 02:39:13 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf38sm18983659f8f.77.2025.05.14.02.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 02:39:12 -0700 (PDT)
Message-ID: <a57a148c-eda4-46b8-b580-a9e7eb52e74d@blackwall.org>
Date: Wed, 14 May 2025 12:39:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/4] net: bonding: send peer notify when
 failure recovery
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250514092534.27472-1-tonghao@bamaicloud.com>
 <FC4C7403A5BC95AD+20250514092534.27472-4-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <FC4C7403A5BC95AD+20250514092534.27472-4-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 12:25, Tonghao Zhang wrote:
> After LACP protocol recovery, the port can transmit packets.
> However, if the bond port doesn't send gratuitous ARP/ND
> packets to the switch, the switch won't return packets through
> the current interface. This causes traffic imbalance. To resolve
> this issue, when LACP protocol recovers, send ARP/ND packets.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---
>  Documentation/networking/bonding.rst |  5 +++--
>  drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
>  drivers/net/bonding/bond_main.c      | 21 ++++++++++++++++-----
>  3 files changed, 32 insertions(+), 7 deletions(-)
> 

rtnl is a bit heavy for updating a single variable, IMO
you should've refactored the code to protect it in a different way
(e.g. mode_lock or some other lighter type of sync primitive).

Anyway the patch does look good,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


