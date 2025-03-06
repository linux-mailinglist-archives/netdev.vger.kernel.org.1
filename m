Return-Path: <netdev+bounces-172575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40487A556F9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654913AED86
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F526E16F;
	Thu,  6 Mar 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f7DcMbpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9D1A83EE
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290087; cv=none; b=FZOAdHIw6uKH1H6im3HFtcAFHvMliLM9mRIl+0ZL2DzBdrvWF558JEk76jAqOXJLnvDSXaJuMd1HVuv7Q3JgWmas8tqhYikgR5M4euIu6hGq4qupbvxo3oKttdzSbPW71SEZhs/EBQBPH6eohkMhiQlbX16iigNrmN9ZHprHGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290087; c=relaxed/simple;
	bh=B7M5Trnk14AuSe+4z3SWl9tY8FGhnR4sefivDUe8SLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZDtj7vHXoxgI9Qy/1VpM65s2w6XSPw5AxA0KwKm5K5WMnGUN99g0LB4+txqjplqMZ/1+MuEnYgvurmfcK5vNUM64m4nnljIaDf7xnGgN1Gs0AVKAIla5MWMfPEBiqDKFRTrs0LUmM5HuPYHNEtW6MLJwLDY/K27k+Jq6QHQs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f7DcMbpF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff64550991so1809088a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741290085; x=1741894885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ytMpF1g84VYDVJdBT15GiZFsraXViFBKP2z7ZF0+k0=;
        b=f7DcMbpFjojU9FGcMMWLEwWwurEHK2t+RuZDrWYOJaR3T6n6r/xEIN5NDE1xeB5qxA
         nzMZwBHtMaw1n8FykMtEjuWi4ADl2GcA421SuAGIanqviHEwgkK7mGARuNBrtZEyM8dW
         CwLdFeydhM4wq/jTlPRG6xA9ESO5oRTeG+TlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290085; x=1741894885;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ytMpF1g84VYDVJdBT15GiZFsraXViFBKP2z7ZF0+k0=;
        b=wLnofvknOmCaCFcdSmqOgX33/Rebv2bqchguYSjbgiyJFtOzL3ecPL7//wWd5d4HMX
         +Vix5BecxTrjvGTGGEKChP8UeOhPebniORrFbsOtDrkKTkp2gB7p4ZF4ixUMGXMO/OtT
         OaJ8BQ2MJOcI25GaPsLVsQsCNIE8Eukpe6ZrIaxhTk60/5v2Km3g/gPysfUU590Gyu4k
         bDtjFWrWh5uH0PwnYYwW7vE88oiLUESGSWYUXp3UkZdiVSPgFOyb8OqcFHMNLEKqGiAc
         C4OPn1Ua2+Fs3UPHKb2WBmtNAHC7hcWQNRxVYieSqL2o7jLRMTG2MYhQm02OqMfMlEUB
         Pq+w==
X-Forwarded-Encrypted: i=1; AJvYcCUAMI6MIQ/4qZJWLrHavOcNzgWkTU4y4rTr5wFZwZV+lIukC5lKy0lmQgG9TfiTdy2MycfZJx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7Kw3gxHBDYSRAixd6XMTHAbUnvk3hl1U0EvG4jiVq+Cmmaqj
	qBjOVYXer6IlO0k9DPZBPEcGHvkmO+1z05yZzKWG1d2DiU7IuzYsL/QB6u+nxJMlsV8S0O1CjUV
	aWA==
X-Gm-Gg: ASbGncsnNwMNuMczX5po9RIZHl+W0JoHMWi7MzctbiAkFTl8QdaSsq6KKAwi/cYE7yW
	2tsLt18XXrZwSK6qau7MQAtDRAwACDFSiL7cmGUGFPh+fZIRDnCr6GsfNsnwO897AmyKJ91LCyd
	MFv8HsJOdwJcgt8PUWTijgg7IIRw00AGU7UohGQsMPENT6QZMVjoWn36luaxqLcprWmQ66mOnVv
	wWchoLDyYVI8nMGOufI6bZx451J7us8zgUEhFXnkHPyRapGVwDLiJnHh3ZZ0zSYRWKqL9rbNr5H
	jzEwUnzEbTAtdAZGufDcJa6f29slqIdPvRSe4HRgUjMhsYS8fBsQLr/eM3gIcMGxCcbxMnyJqM1
	81Kk1gtC7
X-Google-Smtp-Source: AGHT+IEDCCrgBCXSvc5E7/QVvxP7ohxscfjFQieZw1zu943pL+/bLI+uTRuUsM204deT3mWCmNudxA==
X-Received: by 2002:a17:90b:3c49:b0:2ee:e317:69ab with SMTP id 98e67ed59e1d1-2ff7cd62f6dmr982519a91.0.1741290084964;
        Thu, 06 Mar 2025 11:41:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693746b9sm1643765a91.27.2025.03.06.11.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:41:24 -0800 (PST)
Message-ID: <e5a68f2c-5d6c-413c-87d0-5dbb12f032cf@broadcom.com>
Date: Thu, 6 Mar 2025 11:41:21 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/14] net: bcmgenet: add bcmgenet_has_* helpers
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-3-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-3-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> Introduce helper functions to indicate whether the driver should
> make use of a particular feature that it supports. These helpers
> abstract the implementation of how the feature availability is
> encoded.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

