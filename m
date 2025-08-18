Return-Path: <netdev+bounces-214481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C896B29D1D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B914F17770E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD74030DEBB;
	Mon, 18 Aug 2025 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TfIjNGHz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC930DEB6
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507900; cv=none; b=Kaz0fgNjULOZ/qVluXfy1JEQR1C5+bcd7YPh6gH1zALkeJiglNZv8rF/iX4Rdi2vmTTlki7o2UiGyGsqbdKgomZ3dbpWRZK6Io9b1bcuVVu0KC++CGhduHQlcET63LxrmojiB8e9LrslHTDVhgGJytMny0YElRujCHemVpFHpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507900; c=relaxed/simple;
	bh=va8sFiqZgyorC646JnNnwfGYSxGL3VGuAC6L/LkmHLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKdFSoUtTB/RHY0wWwVxQ5OAi9WIVpNNGMHZ7nr/Ays3/4uCWH5pNm0MKSGFy03Hijz84qGtLC37BzfstkvpX6mwzCZKjYgG4eUm/LPCrdH4kPADnmkFP34Zuz8jpq3iMJf4fwG7vyAsob2Y5S2257U6szoUJtqprA84Joujol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TfIjNGHz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78c66dcso544664466b.1
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755507897; x=1756112697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Lw+LCxHSIFKIsmxIOr/OVqLwUPRzceVLg90y/kN8Gk=;
        b=TfIjNGHzDdP0AtFVHVUW/HnFyVKbUGkkIpvADfMSCEI6vXz7rqp1F561VjLzZNECwd
         bvJi//S1N381g8PXt5RBKm7B/55Nnv31YfEO5xyTpa7jwURTJLBl3yALgs5EKsroufaJ
         imuG0L0vVYVzWI7M+V4/17Vewl2ZjyTWKu/nss5WwWp8THBMDasJIbf7r3koOPgtNFL5
         aNgP/eu3qPruHrpU+2PZ+/UGh6C1rSp9SqMTuu7zzjexnPARbfuFE6PqsN7F3Y+/2QxO
         KvfukXJVfnvDoL2ipJ0Vy9jJtL71UKrEhesbbdWLrv4EbmEH/cNqHcaGE8mkBBCfgjrK
         E2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507897; x=1756112697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lw+LCxHSIFKIsmxIOr/OVqLwUPRzceVLg90y/kN8Gk=;
        b=FQiZZnItJuFGwsj/x1sQ4DlnFTuLdFBjTVZV8Py1b7HSLra42TK5zQzdm4jOhBEsA5
         L6yWA1f/eJWI7QxJ0HedwWnyxUy9/bRAHJUYSzyr0iCz9QR8ulcEsoYfwV78CegBAB0V
         mNq3XeQERT5n5dAkXZtcx0lYq6N33L5COADPUi84W5vf8M2kuqfqNNyGIBg6STqWh2Wp
         23pi5feWdz+j5+ebPm66eIa7j6ILzn423M42n0TuSCS8Zu0p/nkIajqatYm8ktyjJwkc
         nhL1MZusubmxDXOSIUsbtlMXWwLYUaydicyboBoMoZxAxoUGSTnaC67MAkfLnHXdekM3
         sSOQ==
X-Gm-Message-State: AOJu0YxLLEy3sd0CHj75HbNkaLsJi3/HegsJcmGBMe+Vis6Z36vmEtLp
	7REmd6eOjyQ9FuDLztGzadMWik2S97OJmIe4OVWeo/p8tEHIEzse4nqTZJHuuwp8jPY=
X-Gm-Gg: ASbGncvqdW8dShrrVNi5P9+ZflJYJNt+5m0sOlOL/RoFEkVNYKa/J1x47BmJSGo1iDG
	5bR/gVVcjsW7SLVQxn/NhImrzRg0rSC8nRaGm/SWBF5sjmrO+/hXDPqDQjNiYbLDMBj67C4oAIH
	D0CS53eFsdIuTRtIBrw/fAND18q84aH4g1I66QKQUTthX9r9Y2bS4T1uMUlQAX85MYouQj0Gh7v
	RHW7sORhH8y5gAPL8d5vjlQgnw0jZ0FRfXq/imkh3g2ISmC/bVZEeWbpCJseejFdZx9sqPOcva9
	nDDg9k3l/NZQqVTUSo8TUz4oLWfOTDN+1FvfYlusciQ2gT5xjSLGQqTR3R0Y8wcT8N9ApGZU81B
	LKDHgfmnZgtC7WoPzVrhNBT5VoL/sqmCF+4LVG0Y7/F5Ig0QnKH3gNPNCd48tgRNZ5s4=
X-Google-Smtp-Source: AGHT+IFN2U0ifcOYrsiMP+SqBYw/LYY7lYQDL305dHhYuuI+QSSyvw76/BjR0E/2+wN/duSXPuQBIg==
X-Received: by 2002:a17:907:3c88:b0:ae3:5185:541a with SMTP id a640c23a62f3a-afceae9fd2fmr810880066b.54.1755507896815;
        Mon, 18 Aug 2025 02:04:56 -0700 (PDT)
Received: from ?IPV6:2001:a61:134f:2b01:3c68:f773:4c52:94ed? ([2001:a61:134f:2b01:3c68:f773:4c52:94ed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53c1bsm764036566b.13.2025.08.18.02.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:04:56 -0700 (PDT)
Message-ID: <663e2978-8e89-4af4-bc1f-ebbcb2c57b1c@suse.com>
Date: Mon, 18 Aug 2025 11:04:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usbnet: skip info->stop() callback if suspend_count
 is not 0
To: Xu Yang <xu.yang_2@nxp.com>, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <20250818075722.2575543-1-xu.yang_2@nxp.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250818075722.2575543-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 09:57, Xu Yang wrote:

> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
>   	pm = usb_autopm_get_interface(dev->intf);

This needs to fail ...

>   	/* allow minidriver to stop correctly (wireless devices to turn off
>   	 * radio etc) */
> -	if (info->stop) {
> +	if (info->stop && !dev->suspend_count) {

... for !dev->suspend_count to be false

>   		retval = info->stop(dev);
>   		if (retval < 0)
>   			netif_info(dev, ifdown, dev->net,

In other words, this means that the driver has insufficient
error handling in this method. This needs to be fixed and it
needs to be fixed explicitly. We do not hide error handling.

Please use a literal "if (pm < 0)" to skip the parts we need to skip
if the resumption fails.

	Regards
		Oliver

NACKED-BY: Oliver Neukum <oneukum@suse.com>

