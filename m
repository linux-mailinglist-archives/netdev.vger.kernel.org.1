Return-Path: <netdev+bounces-198730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36307ADD599
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FC8406982
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6432E8E0D;
	Tue, 17 Jun 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UgeuiXBB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C242E8E08
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176636; cv=none; b=cMF2KEv1nFeKZvnVgThKWaoHrQETVszBqYPLYNfuM8FfuspMsx2DSDMkixj9WYqFjzWnGcrZP3eICnggZH/ooSrrHApK9tA8xScOkf9E8cceT7ibGUCl9SQ3KYRdcVu6FvohbCpKLXpwL7BJsJzrz3aahQYONulmp/tASIG6tzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176636; c=relaxed/simple;
	bh=tBo4ywU0OeJsibq63aEmYDCzZbrL2828l4bBcYjCiMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ev/Aq9Qz+JKPYKWS5xX6goNRNJj85z4hrJd/um5xqQNJt7at/FnQYY0WNDtGjRJMGxlDKj5L5iM623oNtMw2X3eM49Jpn4PHVhLcUr3/Ir8776HSc3jW70iR9skP0YkuC4DG28JoN9UTBzpJxFUPlArHz6BTTOlY7/T4B7r9U7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UgeuiXBB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so6768995a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750176634; x=1750781434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yd/jWdfSg3MxdO4uPk44ED0h4wpGPNghciN9vuMvyrU=;
        b=UgeuiXBBNr7kUn3YNTTyfUz6dWhD6J9P06rD9ekMWPCo/+AOZ9eUJKgfUX6U1cSHUA
         Stig9v1g8tSFJM/mJF1kM7c9Rs0YfhS5Xq/OaB1xE38LacaBHqJexulQo+je06ydb7DY
         qpUWsmIADXLSUOMnQxNSimUxw/1PWhrseXPeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176634; x=1750781434;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yd/jWdfSg3MxdO4uPk44ED0h4wpGPNghciN9vuMvyrU=;
        b=pTclLnz4MDbnPNFGyg17csIKjK1Qp1RqYtG0QijkSRpvcE+KbbPYQTYcn0D7NmE9Nk
         tphAYjG3aheUhmVp6ncCCqbx1esrVHJUV1nGBmTTnwvctor+cVVntU2VpJh4C1dBiBH5
         dSN/+GQlFpFwOQAZWuecpsePvJPXrdiXe2BGQa7bADfQkdQ0TQmpeYaDtLc3263Vf+sf
         AoZ9SMfRQr+PcyEDYOtqpne/EJx7MCA8KSlfiHHuSPW3G+Kd6Ks/gpUVLvH/7Htw/1oY
         6kN5MqqWpAavwkJWvqdEUrhdVZaLzlD5KhYedjVuq31Y8wyWZEI3G7BIs0Dbrfc47TZ9
         x8gA==
X-Forwarded-Encrypted: i=1; AJvYcCV+sUabNyd79/27d+Z+iYBl4sGi2cLr3V9OloO0Shdwwx3A5WSC8kv136n1dOBQg7bPqvh6Ftc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFda6Pq5grAQMwEybmhDrXuPLdZOAmrNO8X3j0XLF+wqQN2K7
	ZyQib59UjSeml3nnKuAwfP5S1wpYislU+PDkxNhhmI9KRGkBbrbdrmX9yhlcpN9RPw==
X-Gm-Gg: ASbGncvglZKnt8wf2+esS8fc1Up5l6oXcdVv9Z+QkICuroq+8RiRNCse46Y7pIDzY6J
	dgDMlBmEI7J9sDyzZpXpeC1u028TVkv5T9CNdqjD+RAyWnLx0B/9nRllfabCvfGE841XU26Ijcl
	0euddjdEqEETEJ+a1WMKXhwgyIwHSnKLKkqqi36H+WmaRuvdbvJ17RezKZNT7kcJI/J9ItG8PQb
	T9elj8g6FnNOH8ts2ydx8JuxtRFVMa/9P4VoXYMtChf/QEKq6AV+68WQxxghSKUjCIuhf07NlqM
	s8kYBxY0y//i34Hupy34zl3/qsqovXnUglfYObq8yx/gS8Ae4/OFGi3fkpOO2EHyqiJwKtrJ5yw
	Z3YjuD8OuuBuRQ81raxn6SxdS5A==
X-Google-Smtp-Source: AGHT+IHukUAlEy++mwjkI2LRzcTO//8yF1IW3sgEUYtwQCsxXpmuJTHtFubCrg9nclXWdFGi4s6lrg==
X-Received: by 2002:a17:90b:2f4e:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-313f1ca786dmr19325137a91.3.1750176634159;
        Tue, 17 Jun 2025 09:10:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b57f92sm12216520a91.33.2025.06.17.09.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:10:33 -0700 (PDT)
Message-ID: <f249d888-0b1b-450b-99e7-2dd3108195c2@broadcom.com>
Date: Tue, 17 Jun 2025 09:10:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/14] net: dsa: b53: prevent FAST_AGE access
 on BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250614080000.1884236-1-noltari@gmail.com>
 <20250614080000.1884236-7-noltari@gmail.com>
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
In-Reply-To: <20250614080000.1884236-7-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/14/25 00:59, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement FAST_AGE registers so we should avoid reading or
> writing them.
> 
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

