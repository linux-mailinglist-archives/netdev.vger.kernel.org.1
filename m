Return-Path: <netdev+bounces-186960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C80AA44D7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAD24E321D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D54A2139B5;
	Wed, 30 Apr 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bYxocgHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57407FBA2
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000432; cv=none; b=Yv/BSjN3+rh8kHsTWCmdOzZQdtQJ1wKjoKCwO1BrIzgvnphkZUhh+Jp+1bmuWyRKFeuI7K89lCnzKkunA7Xkb5t+/HJ3TmMnuGQVu804F/efv6PP671gz3w7i9Li3GBu0VWAxyjHn9QQZxStbeIb6k43/qgTQ/2L6Ba0RMe83HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000432; c=relaxed/simple;
	bh=kj8MnihaZ7l+xSJ0ul1JcIed7CGN/pkbiVSMjR9ZINM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaR4lXC1AFlVnkw46C47HeKZEsi+V39jgxw62YY4XkK+z7pF/YH7jZXnXdCucUeXYvce2MaeYPfB+oPYXT60mVpzDAoD6tVS1HwBwZY3MThJ8YcpFJxv5CtL08V2v/vB2UjzemVDSW2/jXVEe4Lm/mzH6Zr9Itr2q0pReW4PC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bYxocgHi; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b074d908e56so5163812a12.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746000429; x=1746605229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tNCjzmDAsZlbXnWegieKePzLMYEar9QJf6Kl2b6MKpI=;
        b=bYxocgHi7iwWFGN1FemM/GkE0w2W5/3zgeXfPwFgMkRqgodMfZ8hV3YOH0J4m8Wdkh
         GaBzX0MYtHyA1zei0aLbss/xx/RtKIEaFFcMwXgha1KXmUVnOcQfHy+AeqG7O9PhbBD/
         geOytb2btX+B8gVp/1Mg5kFQsIxYOv7dMxcnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000429; x=1746605229;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNCjzmDAsZlbXnWegieKePzLMYEar9QJf6Kl2b6MKpI=;
        b=gaoc5+LKWIMNh9KaFlGc7cxGqFo8Dmd/bOdeZqsy+i5ZmtRA99hZQ7CrNUPoyh0/05
         PN0I5Vio5uj+JZpnh6tzSDfVYnG421jDlfGrYjB0qOp/VBKRWu2Okup5XD5srC0cJXK0
         uOuUQ+xzZyk9srwuBrpB4+I2h6sKreky5oxmv3P7C40RFbZNvkpFfnUKZZFF93OnPfso
         ab8mUWK2yZCBvMh0iPGCR0q4zeEcSKRLSNaNpU0LBbh4el1UVaveDWAZTDOfUkEDP5bL
         tgU6YCXUSfkR32Q+OJtCmQ1NG76nNW3/b/Hc1qnFqL8z951JyskPjSbnsd10+Rh9fHdq
         MsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnfwzGcOCZVea3l3qrIHaubujfMVat8DQjkJNDY4WR20o/H+ffzo8ORREesZT8WSVyOhiL6Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNsHuDA6522ZG3tuysjnY6XExkuToLBp9lvdfaTdzgZfwjgpK
	NHoOpxeVY2IX7us04WlCecXRqaEoHAqTXpUP6KD6WCmrN9QEwcaFdXKd/9OobQ==
X-Gm-Gg: ASbGncthdJ90xwAXJ72c5Et12HwQVHCzB5g6y17D9Utk3QyDYuRxAG5ORIHzolNzZRy
	M7Mt1HfJtflHGdzFAUc54JpKoZLymG8O/M4fNg5AaQadJGcezPqrbEBxxfDJjIlHWyhC55lcLlg
	icymPPgOX3aBF0Z7qOb/u2e6f58WhNaQrEuMxFfvQk1P1r8S6SdxIXYk/M6oIVqXppXt/HmWPxH
	QcmmQSxeTUQpLSuWJ7jCTDiMeM9ClR8dAK+JPWNc0qL2HPz0cgYRM6RP3p1IVqiVnNZxds8LNs6
	t9nzns7z8v+ndkWRh7s4teToIVdsmTycB3C/L1Mz8Augr/YeAdkBJUazqWBScfukDYLbUwSRhqB
	fzJI=
X-Google-Smtp-Source: AGHT+IE2Wf34OP5aP/4XXzvwXOVRoJ+64fMYoNjsOKD9q02NrP0D4aZ0MPYwkfLQYNofq42CWf2ofw==
X-Received: by 2002:a17:90b:2e10:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-30a3446bb6cmr2919932a91.33.1746000428963;
        Wed, 30 Apr 2025 01:07:08 -0700 (PDT)
Received: from [192.168.0.24] (home.mimichou.net. [82.67.5.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a615a1sm947031a91.49.2025.04.30.01.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 01:07:07 -0700 (PDT)
Message-ID: <52f4039a-0b7e-4486-ad99-0a65fac3ae70@broadcom.com>
Date: Wed, 30 Apr 2025 10:07:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 00/11] net: dsa: b53: accumulated fixes
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/2025 10:16 PM, Jonas Gorski wrote:
> This patchset aims at fixing most issues observed while running the
> vlan_unaware_bridge, vlan_aware_bridge and local_termination selftests.
> 
> Most tests succeed with these patches on BCM53115, connected to a
> BCM6368.
> 
> It took me a while to figure out that a lot of tests will fail if all
> ports have the same MAC address, as the switches drop any frames with
> DA == SA. Luckily BCM63XX boards often have enough MACs allocated for
> all ports, so I just needed to assign them.
> 
> The still failing tests are:
> 
> FDB learning, both vlan aware aware and unaware:
> 
> This is expected, as b53 currently does not implement changing the
> ageing time, and both the bridge code and DSA ignore that, so the
> learned entries don't age out as expected.
> 
> ping and ping6 in vlan unaware:
> 
> These fail because of the now fixed learning, the switch trying to
> forward packet ingressing on one of the standalone ports to the learned
> port of the mac address when the packets ingressed on the bridged port.

Sorry not quite getting that part, can you expand a bit more?

> 
> The port VLAN masks only prevent forwarding to other ports, but the ARL
> lookup will still happen, and the packet gets dropped because the port
> isn't allowed to forward there.

OK.

> 
> I have a fix/workaround for that, but as it is a bit more controversial
> and makes use of an unrelated feature, I decided to hold off from that
> and post it later.

Can you expand on the fix/workaround you have?

> 
> This wasn't noticed so far, because learning was never working in VLAN
> unaware mode, so the traffic was always broadcast (which sidesteps the
> issue).
> 
> Finally some of the multicast tests from local_termination fail, where
> the reception worked except it shouldn't. This doesn't seem to me as a
> super serious issue, so I didn't attempt to debug/fix these yet.
> 
> I'm not super confident I didn't break sf2 along the way, but I did
> compile test and tried to find ways it cause issues (I failed to find
> any). I hope Florian will tell me.

I am currently out of the office but intend to test your patch series at 
some point in the next few days. Let's gather some review feedback in 
the meantime, thanks for submitting those fixes!
-- 
Florian


