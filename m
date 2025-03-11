Return-Path: <netdev+bounces-173890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417BBA5C204
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C9A1640C9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66E70821;
	Tue, 11 Mar 2025 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WugEFPdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FB282F5
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698617; cv=none; b=Tv6+jaW1SLzlPYR+e1mCBtRh4+xc/TCKoAunllpuj5r4tMcyIvjm9F9LvF3y9oXYAVitn/ZTrb8dkFeMTcgf+GEpmbQK6FcfS/ZnKrlhKGh0sHMi+1qIuu5xVaiYzZF8D051K10ILDV8LNeEaUn+wgExckVysFjOXjF7ANviIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698617; c=relaxed/simple;
	bh=cBypelooWt3DxW+8iQc4VSf3Tq0YTlUIA5lo+ULmG2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhwbASpk5sndGgBz89WVgUSaJPyz7HUjH+9rw/xyZPU3LS1SrVldCN3iXd4o3AoqURAT6Dww2a/CS1626yMZ7g8Wxj+EGjB1eCKp89NUY7g2IJg0R/c0TFAtzfDUL44I5MPND5v8ABiKWHAOmA3waXPJpGTS11EXY1h0nnVm14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WugEFPdT; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72b0626c785so2044380a34.2
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741698615; x=1742303415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7MHGu3UjtN42xO+MCdlpXJyEMmhBMsXNXopzl9fFRuk=;
        b=WugEFPdTFx+tNOpG0xqsuMeLBETepswoBI0JH8Iqc2Zj6HLfqym2zMuML5whcuc5M1
         FwmsPjhnOq86jKNucpYsEFGjeB8FqRUVmZCI5IkUi12qUodA2MWYdgJdp6L+b1Qw71wG
         yvIVmAyg4Qydozuc9NAXO3yRCU3Qu1sR0XXC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741698615; x=1742303415;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MHGu3UjtN42xO+MCdlpXJyEMmhBMsXNXopzl9fFRuk=;
        b=aQbeDJPzjQLN1mx6gANgAQxh/wooK+HUn5rQi2vNa9D1XsFL4xV26ZFBt07ZZdF3+o
         CJYs/z3PAcPkc9tg5dps5TGNwkXTt4uqboE2kJcxf679SH5/JA6xS4okaJa/y0AuGAd5
         cMpqBFsxl9pVjmeedjDBAmV/8+VwAnXqDoVKJ3NkWty7H1GxTnDvYLrcVQ3ldUEoGc2R
         0RHIK3PixWGCVFRShU9MIBabx55X0fWK3cONMeu6zpGe85qB5Q9RobkAsYOJc8jvxxPx
         jhPhkE7UUH50OMKZX1xiPTCauJBi1rLI0Q4sfyghLaPUOM0/4JMg0cFkDyvUoN7FEQBr
         3ilA==
X-Forwarded-Encrypted: i=1; AJvYcCWVzKK0IrE1vVSMCIQu4J/GeBrZ9eUy5n4cy+af3+yniaaovelooA3fhyUy4+WMXbVXFucDKBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpZnCo9CVmHos5PNp/YN69xONqSOTD05bGf4x+Iw5bT3aa/1v
	C0YC571yjZ/q72WE6eI1NUAMFfGgNMN18s+qfllTYX2Ik4VD3fLJFiuM4oszkw==
X-Gm-Gg: ASbGncvllVLQmtyOOQgetKMuRds6OtgBt6E83Ov6sKRiZAGvic0VSFbBFhTfdX/J0ZS
	fjKIMNzVYvZpaw7EUDziIFEYjC5y7vc+yy5VGf52iarb5wWi8zGj2+CYXsm0A/BTHG8NPd4Osnk
	1TPJzGoZbCYVn+n4mBX1Ah/ZNcCFAcL4Fqy/uW0nXIclW63fQBKXGHvj8RYa1Zcz9XeINL2ULJQ
	cazB/oQqAwLaKBiS5zHpwhUu317ZY7jklra/Hfu7lLE4Fy4IeNuvNzxTyBkn+S2+FkJdrXENvg2
	nWU3qH2v//eirb7gnXkrdQXRhZYCSmgeT0BVxcNk0c9k/mUoxm/XYvBDd1K31T2qLbSrIZ7Hd1K
	kfzd8Zj0xXP0Ufj25t+A=
X-Google-Smtp-Source: AGHT+IGhnt35TpwyBTuH55hx39y/+CURc7NwIYS3Sxlt85Y6I2OBZD3I216rBRtSCRLr4hSjxE+xQQ==
X-Received: by 2002:a05:6830:924:b0:72b:8aec:fbd5 with SMTP id 46e09a7af769-72b8aed18ffmr4326686a34.1.1741698614914;
        Tue, 11 Mar 2025 06:10:14 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72b93a07185sm538075a34.41.2025.03.11.06.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:10:13 -0700 (PDT)
Message-ID: <a99a33c6-d539-4be3-8a8a-3be1753eefb8@broadcom.com>
Date: Tue, 11 Mar 2025 06:10:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bcmgenet: use genphy_c45_eee_is_active
 directly, instead of phy_init_eee
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <e463bc66-c684-4847-b865-1f59dbadee7e@gmail.com>
 <01fdd095-d46f-4cf4-a493-e2193985ca55@lunn.ch>
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
In-Reply-To: <01fdd095-d46f-4cf4-a493-e2193985ca55@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/2025 5:58 AM, Andrew Lunn wrote:
> On Tue, Mar 11, 2025 at 07:43:10AM +0100, Heiner Kallweit wrote:
>> Use genphy_c45_eee_is_active directly instead of phy_init_eee,
>> this prepares for removing phy_init_eee. With the second
>> argument being Null, phy_init_eee doesn't initialize anything.
> 
> bcmgenet_set_eee() is an example where EEE is done wrong. EEE is
> negotiated, so you cannot configure the MAC until autoneg has
> completed. So phy_init_eee() should only be called from the adjust
> link callback. In this driver, it is only being called in the ethtool
> .set_ee op, which is wrong. So all this patch does is replace one
 > broken things with another broken thing.
> 
> Please consider my old patch:
> 
> https://github.com/lunn/linux/commit/c226f4dbe9aa9c51c1308561aba64c722dab04fb
> 
> It will need updating, but this is how i think this should be solved.

Your old patch was tested and had regressions, and I did not see a 
follow up to it. The Raspberry Pi 4 systems use this Ethernet controller 
and the PHY does have EEE available, so it should not be too hard to get 
  a platform to test on.
-- 
Florian


