Return-Path: <netdev+bounces-221447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3560B50840
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED241C65CE3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28038257826;
	Tue,  9 Sep 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I6jFz48t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4480253F05
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453754; cv=none; b=A5kawRnzEWr+Rx1Kx0ILy7ztqytgT72hP28gZKE2VQI/Ywx0bKl9Wxbht9VD1ke7mWhakTc+Xd4/6i83kfhMSg6h+AXGCEzZ5p6Qmb6CHdKiJTtrjJOUo1v5iz+Rp5ZlPZlUk2xd0Lev/YSY6HtHM0VeWDKWGe2HUlF85P15U2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453754; c=relaxed/simple;
	bh=XqWoUIdMiIm885HIEscBkxW2tj9oYIjdVhaxfY6ZD9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uGtHGiLD/KomssGruaZYBMh4dGmHGU0lIQzct2Xi4X7WRgXPQIGmqZbYkSWXQnDUq7UwcRLYTG2M5DmNQTmGlKdSswboPBySvnmj++T9eh/rNdJ9hOMyPNJecONL/NPELhuiPe08L83G7ALgJph0vptgpMEUALAIWWKNzrdG148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I6jFz48t; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3f66ad3fcf4so62270715ab.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 14:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453751; x=1758058551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ld7nUHfU9YQItz92qtqFL7qCvEqQVtcbqTEusRH/IbA=;
        b=URIAh+QgU/sKtfk8ouggTIkCLZuVyEzW4GDyFIgwVWiHOePRP1MI9/AO5fFxwOQlhL
         FIZzQHyFo//lMSHyLGHRxSUZ6gD3Jz+RMyl4luRdUNvq10TTxdRL5vCo+qFyXBWvb2uj
         zSerLpP0W7czc6Axa4A1M22BF02iX9FfveU0IptOVwv+OP7L3GJOUuqzHS5ICVRCQNq2
         xBPpsT0cMuH451L2WDR75QybtJOnwWKtPpmVLIPrEdKwKnN/BF8cH0+gPYy8OqIDtYem
         u3XK3BPMCPXsHt57m1Bze6BDpslh1rxBRS9GVHUY8U+wvQIlxUef2anH8UNaF5GmyLwR
         C2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVboBPWxWX1z6RhIhUkuV2gtd/sLUZh5wXEw+R0m7Bnucxbb7DHrn1oV4CoIF8HDqm60r/D5kU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3U9ziagCHcFYXmJg//foiuhCPVhiRiAxvyCwkhjyvVfpX3lQ
	+suODOCr+ipwEclZgzeNEiMoDZf3X134lTB9ICydKxVJXryIa+7w9zmbgp475jiTYaU9iNGMaLF
	SGa2HL7b3TWzGPeACYUPzlaujT6VWV2nqmKimDEFJatZeeeKuxYyrPJEHiSl15dlzfTjPOteF+a
	eZJZui+Xu00rdhGw1dZtyPtPisnm/3KOTTGHpdvjp4qouJEbS3TF6UCJuTeO12Ds64DTHsrpQ4W
	J7aOt/MKLMxIUD5
X-Gm-Gg: ASbGnctUkd425D6ly14tNe7XJ5FHe4VYL9QiGxbN9rjXWnWXRcMwpSoUJrpsEuAhZeE
	+v7d6Yi5Ro2u18PUbO4jMsFCrLJhPWmiQjBRwadnoBJqaJUIDNenMcuL6BN/4qvF7qlqaafC1sH
	Cb2cCaJcWn33eYQaW9TBH6gFCkit5xAzkRx0LX5uTNjM+cYNjNGkmgAjcIpzb2Zet7mslyNKa8u
	bGH3ZFOraZ+mNxCSGQ0uy8WBT1ZSgIygB6fpoXjXy6yixA5LPvW1oDZwF9GeGzr8mcjfatxiwFi
	Z5x5waOT9tPkZpZIHu7l58Ri8xE1QxOX3zhtbsmeKELP4wnqdD6bNZMDUrQh8BGao6viEktvpAk
	CKeP0RzvkjOgggxLzAAi4sWXS/Mjy
X-Google-Smtp-Source: AGHT+IF11zOnSTooY8E1ukpzVgeN6NLjN+omElqdVRed5vCHuQzrCi7KNf1YNtkMB+L1rnV/G3j8LKsm9Vsr
X-Received: by 2002:a05:6e02:152c:b0:3eb:87a2:aead with SMTP id e9e14a558f8ab-3fd88114fe1mr176862445ab.18.1757453750477;
        Tue, 09 Sep 2025 14:35:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d8f2deb9dsm1536551173.41.2025.09.09.14.35.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:35:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-81312a26ea3so1092578985a.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757453750; x=1758058550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ld7nUHfU9YQItz92qtqFL7qCvEqQVtcbqTEusRH/IbA=;
        b=I6jFz48tzWV3ltasGROMTRoP6RqpNbjppOWUg2N4dYP2iCjEPhsYCcJdVvgj4thJxR
         DIItaMS3j886YC9t8PixzZNdBRnfoaq6hOOd1W2gZ3EOC4hrHg5pH9LkLQiftcC68HR9
         L4i4006VINi0Lokmi2IKMxNYQ8+Yg+9gWRgEw=
X-Forwarded-Encrypted: i=1; AJvYcCUU3ajgqJlAsfdvNSObBmdunl7++IyUgv7WiVhyDUo7YZaKa95JmUz9bEAMr0FjKbMSAC7jrjM=@vger.kernel.org
X-Received: by 2002:a05:620a:2946:b0:815:e54d:84b3 with SMTP id af79cd13be357-815e54d87fbmr1119816685a.49.1757453749565;
        Tue, 09 Sep 2025 14:35:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2946:b0:815:e54d:84b3 with SMTP id af79cd13be357-815e54d87fbmr1119814985a.49.1757453749136;
        Tue, 09 Sep 2025 14:35:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58d49574sm179534885a.14.2025.09.09.14.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:35:48 -0700 (PDT)
Message-ID: <7e4790a1-2703-46d5-adc0-7f792969e797@broadcom.com>
Date: Tue, 9 Sep 2025 14:35:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [net-next PATCH 2/3] net: phy: broadcom: Convert to
 phy_id_compare_model()
To: Christian Marangi <ansuelsmth@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
 <20250909202818.26479-2-ansuelsmth@gmail.com>
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
In-Reply-To: <20250909202818.26479-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/9/25 13:28, Christian Marangi wrote:
> Convert driver to phy_id_compare_model() helper instead of the custom
> BRCM_PHY_MODEL macro.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

