Return-Path: <netdev+bounces-221448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B98B50846
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82235633A7
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE125A323;
	Tue,  9 Sep 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PkmszKdI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DA257843
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453811; cv=none; b=J9bRKP9uMoPKQa6X8N8J2OYhsNoLdQjBONN5dM59XWIQ4sEDpeQ/qgxRo7k6facRh/JEyLVBYeRP/iQrK8Pnz6EPrOIJkQIWmp9dv632vvdkCipxyNWhj/RQj1N7/qRhjZQ5lqb01KbJ1b8cFbQeMOOQx3SV/JJz1uuokoM0nek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453811; c=relaxed/simple;
	bh=CZNhlT52Alzx0Js21jOkkJfApwjjx3fxDjTZoI6b7/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eAFe6posvR3CQrN3r/mV3bkXFBQILJEvYZzZ28fJOU10YZ0YhcysTZVncznVGY9qQ3kgm6SaT2jI7lzfdmdEJPEJ43koNE7suQDYD2Swt3yPsuyNZxTDWziikfhbSbfyavuI9C5ICC8kBGCnRxZGWanGmcqtZY0vG+7nJxFj5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PkmszKdI; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e931c858dbbso4491418276.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 14:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453809; x=1758058609;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zR/DYeoSBnco4wnNVcRf2KymAUJXNjwzJbVzGxmCiQw=;
        b=tE1QM0Rj6Mq0hP+4ygrXQLeq+OyJp2pWR1Or0RjWpkTSkOgMwYodPKRu0zdqgbfHww
         OECL1koU5ZrL+9VYgNGMauEy/hLm0rNjytC7A44Pq8J7CgNYw4qA3yrDLbv9Wo/PoyOm
         RJH7b/8BGbEv7WE1XpmukUyUlOKfmadb+J8irKrWtQj//mi2WidYZRTLeGReznHiKUbP
         kx1FD719Sn6IiiRcacQ6FOkbkJ7fOLJe0d53OLonm5h68AqNp9V7suX5iUO+sg1Ew7ke
         sf/pQLuX687lhx7CJjmN2RIGNRSQkph761aH1dIFbdoN90toHCSKCvZd+qmkySxuH6yc
         lt5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrNkOIb1buv3SqxHpNHX2U6tCR/lc8Fp07V3dyYNreg+4rN/QCgRvBcKk1rWvmFkfqam5iE1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrjx2o3yXxZB7ChKg1OW1S2bO1hiKLBXL7gk89fa9u9LL+5gXu
	ILG5rWHBtAznCvKqChcnJ5Ke4OmKZ/+9fc/XZsxQqorSdAeTtkToDgVG2NIYJXcJoVey1AE0pRP
	iTtnHvxZ7LVPTyxvm0H7FJT3iukP41vcOUduHXlx3iZW1y7+DwjkKY/m3I8CpTBxAL2Q1woUKXk
	G9MJRug4jbzlBes381m+Wl9+FCwK3BDFjmGC3aJIiiYDZBt+UhIqpoXzs366XGbKmTaFuJh8Eex
	gvqBWNsI3e64pYs
X-Gm-Gg: ASbGnct3L8+8AWXPc81Qr0aM12ytvR1O9sgb/oekiN7cPFCbJ3B3pJdfRd2DhXqZjtH
	ckfSAm9fhGI/sDSRlc2xMnaoqMNsnnvnkY+hQWHr6IIAl5+FkfSvBobDjRdVxwuGjeyrB2tpw8F
	1U1/ciQM8XTPvTML1wVMxVzvKq1zxfk0kTFotl0h2t3GWIg5AIAqCkexUi4rlt7/0VEzmcDAU3T
	oa+I7CUiqnkNjkLpC0ca8kYEztVcWD3xH688nW2wznIUYnx62AQrx91WJZxvo9C8a21LUzGJngw
	CQm3qQiIaxK2VZ4ebtOFc/5p4wxWnuyYWOsBJvBTJ4I4sanx26ZrirUyFgyBB3W0sxL3kzsf7OB
	SUpJrgY2fMN3rEYgX3KoUSEFky02QdeEej5xoMZ9ANk3hmO9fOb/bOcX4fipS6H6DrMBIapVJqs
	i3o/UW
X-Google-Smtp-Source: AGHT+IGoMsKxbu6ynCMITt6t0ZNpFxD6kJkr7fv//NwnlqymzAhKeagyJIA9wrTy+gVipfAre1uomf+PZo8s
X-Received: by 2002:a05:690c:620d:b0:721:6b2e:a08a with SMTP id 00721157ae682-727f6b20f31mr126282847b3.37.1757453808950;
        Tue, 09 Sep 2025 14:36:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-724ccab8df5sm12803357b3.5.2025.09.09.14.36.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:36:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-72048b6e864so62647226d6.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757453808; x=1758058608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zR/DYeoSBnco4wnNVcRf2KymAUJXNjwzJbVzGxmCiQw=;
        b=PkmszKdIPDEs1Cm9quKIR2iDi0u8Ax2vRH/Y47ycjZiISx4hSakn40kZiPaks8PGLt
         vUSsiGjpyVwDAwKGdHwA1D/HJZw5VPaHz4+ah+5+D51ZpDhWdn0M/ADyT/dh5sJDXKWS
         Tp83B0vbaQwgh9R6/S79BfRSlnOi6+ycnPT0o=
X-Forwarded-Encrypted: i=1; AJvYcCVmAukZpmX3h2WR7U48JDgt+J08eJAzANjXyAMyEQU5ZFXHPN5ycBpdaghuClxICdPQVY/RtvI=@vger.kernel.org
X-Received: by 2002:a05:6214:2408:b0:728:8b2:1e34 with SMTP id 6a1803df08f44-73932311130mr150355856d6.27.1757453808383;
        Tue, 09 Sep 2025 14:36:48 -0700 (PDT)
X-Received: by 2002:a05:6214:2408:b0:728:8b2:1e34 with SMTP id 6a1803df08f44-73932311130mr150355676d6.27.1757453807984;
        Tue, 09 Sep 2025 14:36:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b57c3240sm144718516d6.50.2025.09.09.14.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:36:47 -0700 (PDT)
Message-ID: <b6e764b8-e8c8-42a3-81aa-87b3b1dd49f9@broadcom.com>
Date: Tue, 9 Sep 2025 14:36:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [net-next PATCH 3/3] net: phy: broadcom: Convert to
 PHY_ID_MATCH_MODEL macro
To: Christian Marangi <ansuelsmth@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
 <20250909202818.26479-3-ansuelsmth@gmail.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20250909202818.26479-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/9/25 13:28, Christian Marangi wrote:
> Convert the pattern phy_id phy_id_mask to the generic PHY_ID_MATCH_MODEL
> macro to drop hardcoding magic mask.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

