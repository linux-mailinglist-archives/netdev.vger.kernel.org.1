Return-Path: <netdev+bounces-250396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3DD2A015
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B445B30FBEDA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF13385A0;
	Fri, 16 Jan 2026 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fjF8gSlA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F8337BB0
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529436; cv=none; b=SJVKsRLoUpxK+86ybgi6SZ7OCSkdhBH9hjMzLjjbB1GtxAQ6oYaSqwTDxAp4B6cY679sAsAZD070aOg+bFMfrpAXCygbAVkZVmZxq2VhPPZxNZl7KiWU4FyIbEemyP735vmrQrRQ0OWwNaVMtx4YHDOLcd0tFsxfG0SNEmvupIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529436; c=relaxed/simple;
	bh=d33WoMx5AG/SD4NZkWXjfXAEtn0Tav+vfwFXs7EZivI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFKQgP4DQZuq0uHhtF+XPWr0IH0vpQlz5fMauOdeillpedYzYSnUY9ba/f3Jrvy1Nsq/Vz0DVYfdZxSV/sy8uVa+NFgWXDNzFlYWQadBAe4KYnfTV+X6LRYAaQ8w0R5Fw+dGKS3N64oBa1+U6xYXuaQhVZzXV3XCZGsaMRZZ2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fjF8gSlA; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2170514eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 18:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768529434; x=1769134234;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Smsas5XP9kATJgrCPlJwH36X7CX19/Y/MUlq+6C6jCw=;
        b=GcLnFOb7d4O9vCLqtkTyfojKQZ9BXamhPA1OOaxPQ6LLUDL+H1CCjgbt5cfMusxaWO
         ZLHZiQU38R6dP9YoTwX/wMyP5Myd6rtsUkmvR7e309zB+x59GGnWzPnju2YSD2CIhhEd
         Bhmb121h03TZh5la1P/rpCgGnPt5J0np3dyVWz6cNLAwsRmvC7PgpZBnTxDpuD1EjZLC
         kT77AbI+WthCZFgR12YUJJ/GdWWfX9nO3/F5NftIEK7ax9ISPVfKVPmeJfZs029SgUSP
         jCqoCLsbIYFPU7+aLvEN4y/nI7odxXv8mBUyr2ScdJek/6qmNOaQwnbWqk9elZYZmduP
         Xufg==
X-Forwarded-Encrypted: i=1; AJvYcCVTBRccXIqXyx5jZxwRwl7+YhZMM3C0Am9oUb7YYiOG2rMSl0ZRNfXIZTzc5xSDk8nuaARlZlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywufj9L1K7XWmmBexzxpiBTlRxWw/CI2NEPJtMsPqMiJez5FWtC
	E6Q6eDUgHEANJmAzggVYTbbi4zkn9iMoLVaOT3z6tXkUyUXBkpDfe78sxD6FQT+ko7g7sZf7lpd
	Duvzlvt9jYEBSZevVkjyC7NDNQFvSvNHcz2EM9Jhj06j3F0jU/obD33zrU5wtOA2HDtHSJdpDpL
	FU8pX+PpXwcFJ6jnX/sMeOOZTJADywwGPYPk9YLpqRS/1ZJyPs9npSvgKUSsP8bKMJWFNqgZJz1
	Sk+2ZUsbb/AdAKk
X-Gm-Gg: AY/fxX67+slq2PamjzDgYEFJlf64i1gUVy0ZM654JS5BICV7ZUYiaBppsjrVGCDFE4o
	uLAIaUcf1E3uM6g+Pg9DBGbVIeHK7dIHfYejmkERJa44eBTbKeOx3CGJ7N4CbmtbEZDyN8poNsS
	7ba+YIkNvWTf/ahjTomvbo5NoIZheT5YswPUo9MnC0c781oS6An7uruEwEIPou9Nwb2RuY90JAp
	nulOvpV9VF1+fVifzH3FiTSLm0RL2n9XXiuBM9MoYdcWIOsQ9lATCJqLoCw0eGyIcx0dKowVKvx
	DYdxbZ9G24Imj9rqCFQYKTlW5em30fc86Yq6vaHXSQ33gjrAWQUMBhWEpy1nokV4OnD1LM5hYMo
	BP1KjpVZu472qDHu5wlVoi1/8aKz12bnQUDKfOLO5EvHCUjsY74pRuQ4T5gtX5KAB6Tr7ed6ZNp
	EIzEnn78MuI26QXI8+/7rDeUTsYRxZvMtv/9zQ0aHfoklkKnA=
X-Received: by 2002:a05:7300:5724:b0:2b0:4965:8829 with SMTP id 5a478bee46e88-2b6b40f05f9mr1209276eec.34.1768529434318;
        Thu, 15 Jan 2026 18:10:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b6b350049csm121568eec.1.2026.01.15.18.10.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 18:10:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-121b1cb8377so2985914c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 18:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768529433; x=1769134233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Smsas5XP9kATJgrCPlJwH36X7CX19/Y/MUlq+6C6jCw=;
        b=fjF8gSlAcOQ8lUHvzP2r/HG1St4blEhiykQXWkAeQwekKjnGufjuOP3H3pkaf4+IBk
         12mLna4zUEr5tH/+VHUOOP5vcILPfG99W6BhOOzARuoXO6chaiNvCxjnYYCjvInObkZt
         YbqyXUKXJPmPgW5QFGXpLqfXCH1BvnQ5h2sTU=
X-Forwarded-Encrypted: i=1; AJvYcCVhQy0ln4/iFwaSrrScMAIygnVgYYkbRoydpngbfwTHMOz46ZnozoLplSaiMj+muO6UXEQvSd4=@vger.kernel.org
X-Received: by 2002:a05:7022:a8a:b0:123:3500:b688 with SMTP id a92af1059eb24-1244a72e65fmr1689889c88.19.1768529432856;
        Thu, 15 Jan 2026 18:10:32 -0800 (PST)
X-Received: by 2002:a05:7022:a8a:b0:123:3500:b688 with SMTP id a92af1059eb24-1244a72e65fmr1689874c88.19.1768529432339;
        Thu, 15 Jan 2026 18:10:32 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad72063sm1309212c88.6.2026.01.15.18.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 18:10:31 -0800 (PST)
Message-ID: <84215494-ad8f-4bcd-8f76-cc2b9a5eb3f9@broadcom.com>
Date: Thu, 15 Jan 2026 18:10:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: bcmasp: clean up some legacy logic
To: justin.chen@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260116005037.540490-1-justin.chen@broadcom.com>
 <20260116005037.540490-3-justin.chen@broadcom.com>
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
In-Reply-To: <20260116005037.540490-3-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 1/15/2026 4:50 PM, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> Removed wol_irq check. This was needed for brcm,asp-v2.0, which was
> removed in previous commits.
> 
> Removed bcmasp_intf_ops. These function pointers were added to make
> it easier to implement pseudo channels. These channels were removed
> in newer versions of the hardware and were never implemented.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


