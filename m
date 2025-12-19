Return-Path: <netdev+bounces-245489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413CECCF0F1
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526313010CFD
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE432DA75B;
	Fri, 19 Dec 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9C3HDJo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkqYIwjC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A272E0910
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134583; cv=none; b=enxfb2U57mBMLkkX15g0zeY2xiIGFfLPYuDkqP2rNYqyIKKCi160QVm2nthYyXy2iEFnrEociL3TxVkaexUPP3SMAPK/r1mLSechT2vc9UA64PNz6LDAcdGTNXc1nqL3w1Sy4WDG2wRHVULDP+hS4oL1QGOgGNlNwyM8Lnku6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134583; c=relaxed/simple;
	bh=Eo3R8K9gss8aHXROU1Jlk39WBtUppS9+22tjosqU8CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+RXSfwyOtbd7oe9OetMapCHA/yiRl0i9Pbx/wbwlicRcAkpdpn4TF2dELpme3HsUsg/K7Eh4U66Z1phpku3gSMqLbXEfVzI6/5jCeRbQ93aQDPs4TLNqEJCgctt7GsjpvpMAQzwZDQmpDWSv7UPuMB2BTj7GHc6W/W5pF69Tyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9C3HDJo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkqYIwjC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766134580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+JMJ5VnFxbjB5KVqiESas8KT9IZBEfG1xzvLjV8WA4=;
	b=P9C3HDJoW1CFcGy/hZ1P7MedhZvJ02RwDUDmYhwzwXr6eSdXopE3NspAoYFYJw8ql9gT8D
	Zv7s8aZmvuHHbhNGo+GSh2zU8gJjetg04VEapz1cGWjoaS4nSBbEDXLfQaOb1UdTaaaM8Y
	rpZePWPK0ZoV/OA6Pp1XyDB/1CyXkAQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-6lcw-vnhNoG-ugSGuBZGlQ-1; Fri, 19 Dec 2025 03:56:18 -0500
X-MC-Unique: 6lcw-vnhNoG-ugSGuBZGlQ-1
X-Mimecast-MFC-AGG-ID: 6lcw-vnhNoG-ugSGuBZGlQ_1766134577
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47788165c97so8353215e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766134577; x=1766739377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+JMJ5VnFxbjB5KVqiESas8KT9IZBEfG1xzvLjV8WA4=;
        b=IkqYIwjCIAX1/rPs8PhNu4m5stIJwOZa2aICHje55Fpp5nZRqWnk74BPCgW6L1pBAP
         UVU10YtFx9pR30ASKU2l6OTa8UtyF5r4Kk7FSO3k4x8POvR7eCnuLJt3W8B4738AMolO
         NS7pgDJVFI4xGMnA5AeuUOZoJ3G2J31s19mLq0xmK/XCwNRYEs5OI/oq+2s/OwfmJkwB
         ozvpbdpdSyisGyaOdpKnDnwvvWB88qnmVW6FUWYy7jTArequpABFf8hlWKA3lIETkws1
         b5e4IGfHiXNamm+D7f3w58KAR2Hc4q6qcAEmOZ1OsCEysFC7zyrMZTCQaqkOIWYBNmGu
         Tgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134577; x=1766739377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+JMJ5VnFxbjB5KVqiESas8KT9IZBEfG1xzvLjV8WA4=;
        b=pwPdRUAStuOXtP2zyOYg1VOLF81+HiLcyEn58dFeqcXMvnZSNwHDm4eywBt77Ik/yE
         UDYTj0o6SiaIYSB1vvoJL6avYUNjWhHZVbHI4/ka5XT4mKOz38VPlG1cDGrCUr8PcqgU
         4CVZ3p3RNxlkXaKhdF8k1LXRZoEHUBKjNRbVxvuVuF1VAY/TWhqtTrUDRmEBj7JmaaLh
         Gsnusb/VMjZbz0HNLtoGtXLypvTP/BmIAwjy9pFc7tgNA2VmizBF3OeN3gTG/CxZs025
         txrWXsq6Mv+BgjlXmJCju9fj62vVnsgi+DB+GE4CHZgwA2wupxU5HczrEgEHGqUllk9Y
         fg8A==
X-Forwarded-Encrypted: i=1; AJvYcCURW6aKIfSPcQEo2Sjaz2+vN+vxUTr0JaymZZEvyhJX0OvnjtoWgo3ciSpkNYWAUK4P3b7RNHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4tGqyCIfpaF4BOHTOQX80zHaZ9VeQT0ld745ModiPXAG6NQ7
	CQKvNKB9IcsPcGchiozNFC5/9qX7VGDqW+64imw6jxvxt9jt7NJhn2EnGFpZsnAfRoKZew5BNGO
	qTYLK/0fMvTnniYA6hC6Ug0CtU4d1TSQzJsVofgGouQgyRFOV5t4f6RlCRg==
X-Gm-Gg: AY/fxX5CBBM8WqoowhrCb/xv9Yw/HHyhTcNeiwvhXJvuzJzjBgUYJtk/pA1g9X3H48z
	vfmB03ZVd/yufSaT04JSWJ8AjbFdPLoatExK2NjSQTaAbyYreUJj+rOliextvSPmSFC7LYMDM8i
	2sr/Dft4Z2vrUlKKmXhhlyKg0/67UzrTDxKraaW06XftdJ/Pbmrtyfje0NvoLIv99OChC6E3+b9
	vTsY8Dobfr4ZkC9YAvLbiUaVECccS8bMcZ3bD2tToLXE5rvvnS8F2krGBg64tfszBEyvzyeZtKl
	7AHUCg+zVNwtEvx7E8iLPkHF+a8hL+BrlRn0vqV/WnqIO/i3dd1eldibXXhe0G4SAgCbTpAzfCE
	9YFErA/7QnKlk
X-Received: by 2002:a05:600c:4506:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-47d1957da6cmr17214645e9.17.1766134577335;
        Fri, 19 Dec 2025 00:56:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2SopRIzfSkt9nakGLrDaY0xK/2S7FNdo1Fi24+qoNIbNZzNHch5Phee8ZaMOnmkm1HkCgow==
X-Received: by 2002:a05:600c:4506:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-47d1957da6cmr17214495e9.17.1766134576972;
        Fri, 19 Dec 2025 00:56:16 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a541d6sm29970625e9.8.2025.12.19.00.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 00:56:16 -0800 (PST)
Message-ID: <71df49eb-ec13-4f17-9ee1-a2adef72f4d5@redhat.com>
Date: Fri, 19 Dec 2025 09:56:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mdio: Make use of bus callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20251216070333.2452582-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216070333.2452582-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/25 8:03 AM, Uwe Kleine-König wrote:
> Introduce a bus specific probe, remove and shutdown function.
> 
> The objective is to get rid of users of struct device_driver callbacks
> .probe(), .remove() and .shutdown() to eventually remove these.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


