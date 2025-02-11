Return-Path: <netdev+bounces-165041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6FAA30275
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 05:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C326188A1CE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 04:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2E1D63F6;
	Tue, 11 Feb 2025 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b2Pwc+jJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF88615A
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739246889; cv=none; b=WzTa+v5wYgZibwEt69QLWRdRlYFmeBI6PshFfKJYfD5e5aDidzTGyk5CGsLSWhzLcbosdnu+RioN3T+Jvs5tYLnI8ASfVeZbT9fh64tdDnFKMZepmSwX8HP6oPxgoYavwJPYt27M328cVvYsM8eg8vc8b90Tz/FRCUmZQRmyMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739246889; c=relaxed/simple;
	bh=b6XY/v5c1IShWi7Mnzp3g3rBRfTPLqoqs/fcWxDfeEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvQWDW/vWOn/2UeA+DYW59AjimBRKrg1L6J7tVQm7/ihupTJaaTWZsxF+U/xwcUGmCLzr3C8VFrJNsxvSMRYXefF/PhGyWc7g9juN/LWceI91HlTfBUeZxttmN5N8rgCOOBC/gmiFMlAjO+oZpqq0vg+GdYMPhWfYosiYvXXc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b2Pwc+jJ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-724f4d99ba0so2432218a34.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 20:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739246886; x=1739851686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t8eYWsGO5bR6d/A4TPLNpDeU5HcoQR1tHKfNDbSFT88=;
        b=b2Pwc+jJ4jVFOaDwaDWWBD4g1f3mOtu5WE0oXVLvwulvsu6BXTJz7LRn88fibO6Y0C
         KN3MT79GAbDfPYUZvDzwgZ4o6/Kk2+h8eyut371dXb3KZ6BUjFxTbKNFW1PjmiDPE6OJ
         AHRhN5hTLmCbFU1TBDemGknqhnsfF4VliHBto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739246886; x=1739851686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8eYWsGO5bR6d/A4TPLNpDeU5HcoQR1tHKfNDbSFT88=;
        b=mbe3bICo2vE+gewtjV6Q3BOVpNFH9mh4UyQYfwXANxA6BUXXqKhTXtUDwNO7lljnOn
         9ORCa7mKmEYIg4R+ao+7uXwJcmFS7rB/DOIBBdYSwgYxOSHIyjkhfC8sni5chAykxmYe
         aHkwNIIJbHlLAYik2R6+nvRjF10Jr0nz/YAFipjLnx30kJuaEi86VcNxPEJ5UiI+pJK5
         oIEBPp1fiWIeh5HrVPvOrdiUW7fB0DJY4l+ubasmKUVid50N7UWcooKCsh5gjjq/CM3b
         YInQ9YIRiZsV0kKZeSaFAWwMmAHOS04+iLkyN+PC6BT+10DiY0w/NNrLcF0WNYMyfVa0
         7P0w==
X-Forwarded-Encrypted: i=1; AJvYcCWcu00b0H9Wc88J9nqxIWRcxVby1X3AHfX8fY8Pv56x494xBrN4+sF7/DAAUppEAXaZ7jO5x60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6/N2MSchfcUtASo7gl+0ICCcgSHw3mJ9AB01yb/LMwP3BwRA
	W6b4M+8Gg5sTbdRcdNQm1qJ7v4BOZgdSQn+g5GA0l1ojA6WmlzlnsaVU8fhXtA==
X-Gm-Gg: ASbGnctqM4f44SWUcXT8Byv5O6kAdyJy9NPbpFFNSxeaZ42xETGqvHT+e9+KvyKZZJ6
	iysH+YD2YGvP4QVERkeZp4JJvyW1yysoGRptcrDRlyDDDN3L9vFD9xAXdZJa8CShwDISgpSqAwK
	tFULHiWKbiyOxpJ4xjiSWiGYqicFDq+gt8WoAU/CHYrpKcYLOTIgqJor9rRIOg59bIMh1Vin9+4
	zItSTTPyCWLM8Ai8nFB33lpmNIts3rennfHpjldId1ZEqvLpapkA5mTYPCAbfuUo4Vv/6P4PV+b
	KgjDrOFbtz1bzkHLr4HlJsec68yPjkgGACUw4gM+MxWrMinbocrgsW/VF6NehXje9A==
X-Google-Smtp-Source: AGHT+IFapi4wMv31NrAKWbcvGGOIg6pfCWW86OI3QXYEtKOl36IiOEMw2fKlDSL1dacmx7ZY5EhBlg==
X-Received: by 2002:a05:6830:6d11:b0:726:ea48:5993 with SMTP id 46e09a7af769-726ea485bb5mr589459a34.2.1739246885929;
        Mon, 10 Feb 2025 20:08:05 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726e93d873csm380757a34.47.2025.02.10.20.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 20:08:04 -0800 (PST)
Message-ID: <d6f3bedd-11b9-4eaf-a8a2-a6da460fc7b3@broadcom.com>
Date: Mon, 10 Feb 2025 20:08:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: bcm: rpi: Fix potential NULL pointer dereference
To: Chenyuan Yang <chenyuan0y@gmail.com>, mturquette@baylibre.com,
 sboyd@kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
 dave.stevenson@raspberrypi.com, popcornmix@gmail.com, mripard@kernel.org,
 u.kleine-koenig@baylibre.com, nathan@kernel.org, linux-clk@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, zzjas98@gmail.com
References: <20250211000917.1739835-1-chenyuan0y@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250211000917.1739835-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/10/2025 4:09 PM, Chenyuan Yang wrote:
> The `init.name` could be NULL. Add missing check in the
> raspberrypi_clk_register().
> This is similar to commit 3027e7b15b02
> ("ice: Fix some null pointer dereference issues in ice_ptp.c").
> Besides, bcm2835_register_pll_divider() under the same directory also
> has a very similar check.
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


