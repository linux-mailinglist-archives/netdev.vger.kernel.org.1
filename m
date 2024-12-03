Return-Path: <netdev+bounces-148449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF5A9E1D28
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE74B2B7A1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C91E3799;
	Tue,  3 Dec 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ca4rR8Og"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3D1E47A8
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225165; cv=none; b=UJ7mWRAILForO7qR//MQwUs65Flo2T13v4pNGrnXgNNq50bOUJ2l/ccA47tQdRrZxM1oCNZTbh28rFDoLbmVJxkNdraRjuJgtuKBrlHGG5uQdvZ15qwheqtU4M0Z5zuIWWGKk5sAMWU7GQu3xUXehxFgsE+quqUrR25GLYekDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225165; c=relaxed/simple;
	bh=xOHhJS2e7BRBffjVgA/oI7/rkkIN9hsNagUIadI5S4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQxB/NCxAPGY93Q3KW3jMUXv8vQYKO9/RiSYMXpKXCUYjwb5Ks7FlYSVIiX5xtXKqvEsDCVFsvNJRT94kj7lakJebY9ELBQKRimB1eNL1XHU5TJVyim1f4eqpUy3JwF7t7mRQcS9ytX1UauDMu99VLOdAt9dL+utI3kQbaCB3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ca4rR8Og; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-382610c7116so3565659f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733225159; x=1733829959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQKk0snMB1vmn3SCZ7cY178GX753db7hlE0FmDcIMDw=;
        b=ca4rR8Og5EcLGOUnuZ9dTNJvXRTv9AN08eJBMIzn9NVKiBWzJL9Y5x5XuoOe44WFDr
         mSCMX8MLeokeCyDpoLAD58GyXntnSoZNqh89qCUgSmPC5kwIzO2yvLPm0ZWumsDVLQqw
         vu6oEsI/lmMeD9j7eJgOqBIqrzkQ+i1lVY5lzaZbZQlbpTkE2OQKefiF+hagsVqVwOks
         xE3yhmV/miruC0Tqw0rcq11pnR/jBUxuh+9mVwhuygf6lbeM+HxAjobj/c3lCn640q53
         ISPNSHfCV7Y6GGrlD1gLIsIpO3dSYR56wwKHUZgzoNvyQA15HnkiZKcioVC0OBO16265
         QGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225159; x=1733829959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQKk0snMB1vmn3SCZ7cY178GX753db7hlE0FmDcIMDw=;
        b=d/JrbJikGOAAjSatE/3RBydscDw85T3a27wNy8wPQQLeJ3KOE3rz56OQsFOZSki0Zc
         0YVL8bkaCiAOtWoncFdHwW5L4dTl8foOscY8n4TP2hj+B5W1wjT8VcqpsDR74XXRUUky
         iZdtqCmMFPq8ge2kkikT0XmyEJiM6IrFpWkCfSfPCrC/8OxVW/0lEhs0IJufL4O7k2ls
         lS1/32uvjqGgiq5kYa1gJo0vQ9B4WL4wDN9QY84/6cQFHMn36/zPebUL/Wx6FZylfyAc
         mKrJOtAh4lsXhuOHL16US1YyVieHv2exn31VC+zON+wwsgvQxQs6a8+FXNKKeoGzTi3D
         DWmg==
X-Forwarded-Encrypted: i=1; AJvYcCW3FVYZWrF2E3M2uKSGxtPOlbAe1ZfIFtn2fF+dYJ/NDP80v7cCN8I15pnCqQGWHZjGdNnA8pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCqitjznCU6aaa1UIjDnSzDumZ9fv3SOAxoTWCDjwtyKn6Bgc
	Lv5wGbIxqBIRDts3d3ovqkB5o2cUlNL8IPYLpW/7hNoNFRtIuxAv9NkduuMTGbY=
X-Gm-Gg: ASbGncvPSnADo5kW2VQkvjqfj+CHHOH6/8jkwINEeZZ0/yBwJ7MvwU868xnnLWJKEqf
	exD0AZpN7j3MbPed5egDdL18OQXdF39D0f+qEpr01t83s/POzuANR4+Iy6V0xVxNKUU4odogGB4
	Oj9OdTxoHRYd5n9GglmwbWMZBiG94ntu29DmDNqfEqqEdA844IOZZ9kPu7I/mSenNFyXiDeqOeC
	2x1assBqz7eMbWnpSjPwkPu49oQpX9ABro+USxNH0Pz5YInBBaC
X-Google-Smtp-Source: AGHT+IH3FlHetTjK4CzZkif2fE0r9/KIALDBxHfHCk9zvdHQilSiS+hU1hVlXIzPFyEvWRyjrEjC1A==
X-Received: by 2002:a05:6000:1fa5:b0:385:f560:7911 with SMTP id ffacd0b85a97d-385fd3ce08dmr1925269f8f.10.1733225159151;
        Tue, 03 Dec 2024 03:25:59 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e4a54b71sm9594496f8f.79.2024.12.03.03.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:25:58 -0800 (PST)
Message-ID: <12a687d5-cc87-4993-aec2-07ea799ce334@blackwall.org>
Date: Tue, 3 Dec 2024 13:25:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, entwicklung@pengutronix.de, roopa@nvidia.com,
 bridge@lists.linux-foundation.org, stephen@networkplumber.org
References: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/11/2024 13:50, Fabian Pfitzner wrote:
> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
> 
> ip -d link show [dev]
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pfitzner@pengutronix.de/
> v2->v3
> 	- use print_color_string for addresses
> 	- link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.pfitzner@pengutronix.de/
> 
>  ip/iplink_bridge.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Sorry for the delayed review, I missed the new version.
I have one small nit if there's another version: drop the extra new line between
the definition of bqtb and other_time, other than that looks good to me.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



