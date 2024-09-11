Return-Path: <netdev+bounces-127264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77485974CAA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F91C21978
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD913AD37;
	Wed, 11 Sep 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="luJz6jY3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17D2AD05
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043435; cv=none; b=H4+D3KYz4PvB5iXoC8QlKnaZLT+dALfQhNVFxxygGIU3wtCSvJ0DS8J5f/yoGIoFvoElLc3KNiEIUsJ+qhvKRw3GFQPYXk7FJ2W9EqozvR2GE6mU6DVLu0H7yXMuh8G+P2v8Gb29UXxcHfh3bCsz5dw50int7AB9ofE69dJYuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043435; c=relaxed/simple;
	bh=tahiOgFjH0tUonkNPxo7wd0KPO4O5Vxxt/uhidXqysA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgPHPvAKG2SkGuZLfWMhkkKWYFzGCA7P+DFwwM3Mg8YrT6n4+evR3yYgaI7SvVq6rs5jKynwMvsEKKjThPyZgxI3+Lym2cGEfk7r94jgln51TtFenBShz22+UXbBFgyIZCMRWtqCAz4aLEw5ysalu8Mt7zGJyG0VsTem7mUjSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=luJz6jY3; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6CDC03F5E4
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726043430;
	bh=G6HqNSpHqfIqMVHGZjHveVmpWeLuu6EUB8Ng07r8NBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=luJz6jY3YBLe83tB6GTTBn+kkZhVwMtWi92/7z6TQf19v8a/bPd/ytVUQ3KgbH4Is
	 I/Q9g77iAkF2VLsQ6W1Wd1S3alsHtD1Fzn8soDe5NLUXNIzunWEQFNwJDaFQDRY0B5
	 CkfPCkfyXLke1YnEMTXzKcFNMASxuvDvAJGW6/NIs3o1JQ+w1L7fHXdB9sgkg7dtxE
	 Ng7mzfgOjqjYPaG5wXJaN4s0z75c3ualsqcYiMYCJ98a9rEkJXQIKLdopo8W+A5sxG
	 QRoZAZgxTNQ5z7yEdNaxKGHSjNAHU6vE75bB0+jQeUo7fO5zEKk387ZUUunlm1NqWN
	 2koqOY37eMkKQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2db6527b84aso2008704a91.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 01:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726043429; x=1726648229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6HqNSpHqfIqMVHGZjHveVmpWeLuu6EUB8Ng07r8NBw=;
        b=a1LdWfMgbPwcF0/l+RB7aH4CMHpRjiIRLzYZY/ltcJQ/b+uuf2LjPx7odHlxiMhdfP
         jDAYMzQaclktGDdGH7wN0pelwL1k4PPkCN62ZvRPNF3wFWt0R2EwY+5KeFeaoyqQ0YcO
         QhkYid1EYp+oUEAfUlnYx0BwSvh0B/eIwSlGnLETFOpUUu6g9GOAeW/fbKrCccmSZz58
         t5V0J+W5v5jeCnQZDREq35CtMp6sxRFmbi28oruMAzuSRK+SMJeTOEJ3SsQBdggqTQfd
         DdmLfYgEw/Gt2VL3slByPHN8UZybPd6I0SJj375LsFt8Y9tPIkG7cEx/COQzcBe/xj3L
         xXTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjx9A9nn5XSguBHoPpzYmvLBBUTKwsRsAQ3lqkwei68XIZE9whhVU2MOV0bzA0qmCx+UK6S/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTLZzTbMiCuXEX29OZHwSZm4D1t52q0g1NCiKZ7uBXjWswVjO
	olPuACJnCsigMvkFVau5/S9Pjy/z8fV/5dzBbwaEJina6XJ1++ZOLLXIr6z5FCYt8BGXU7JDMQV
	d7nV+30cbpBTgNpFQ8NK/EEfakFbeQPvXAs+JlSDHG8Y6+kZ2WnzmDNlBvD/HjiVvh6F7iA==
X-Received: by 2002:a17:90b:380b:b0:2d8:94d6:3499 with SMTP id 98e67ed59e1d1-2daffe28fefmr17133590a91.37.1726043428794;
        Wed, 11 Sep 2024 01:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt7GbqFy24wG2YGjn2PUO4lw+03MfDDE71qVnRC4j7Ur18MOjXsynkYXwGwt7KAXnmuVxe0w==
X-Received: by 2002:a17:90b:380b:b0:2d8:94d6:3499 with SMTP id 98e67ed59e1d1-2daffe28fefmr17133577a91.37.1726043428444;
        Wed, 11 Sep 2024 01:30:28 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2db6c1cbe42sm1642221a91.0.2024.09.11.01.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 01:30:28 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: edumazet@google.com
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stephen@networkplumber.org
Subject: Re: [PATCH net v1] dev_ioctl: fix the type of ifr_flags
Date: Wed, 11 Sep 2024 16:30:12 +0800
Message-ID: <20240911083013.61017-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iL6wo_OYw0E4uSsydJNVsfWvj5LytrWrQbbhmrN3k5kbA@mail.gmail.com>
References: <CANn89iL6wo_OYw0E4uSsydJNVsfWvj5LytrWrQbbhmrN3k5kbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Wed, Sep 11, 2024 at 3:21 PM
> Eric Dumazet <edumazet@google.com> wrote:
> 
> Note that rtnetlink gets the 32bit flags already, this has been the
> case for 20 years or more.
> 
> include/uapi/linux/rtnetlink.h:566:     unsigned        ifi_flags;
>          /* IFF_* flags  */
> 
> net/core/rtnetlink.c  : rtnl_fill_ifinfo(...)
> 
> ifm->ifi_flags = dev_get_flags(dev);
> 
> iproute2 also displays more than 16 bits in print_link_flags()

Thank you Eric, I am switching to the netlink API for my use case.

