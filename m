Return-Path: <netdev+bounces-134425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF263999508
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD31B21698
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9D1BD4E5;
	Thu, 10 Oct 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gu/PyXvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774EA1BBBC4
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598827; cv=none; b=iVH1QaBxUk2V1q+SOz5/SyaGh47esen3m+ZSZFyP2LoZE5sV/16WLEX3WWZn4Ai8gPZ828NB6ZK5qgBYP3FnM5HjssiCxQFth19xIH86qkd7hLdWEESlEGyNeIgyv4WbFll0asHWApTbOCtpGZfZqWFBrWkE72TJzguFuEgEz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598827; c=relaxed/simple;
	bh=uqHm5ZPJ2QHhoeKcp2E/9RwaooHSDk4gW4YOwx40e0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skhlCS/l6Kuh95/LfTyI+/FotWKO2yji3CPXDEa+2z5ZJzDGk8q3uBVuCyekJekn3R4jcJ6weSluiEKp01DDCqj1mSAXHxL4Lqzl3t6YhMk/N0CAV9E1lDDPvdVxWuS765WqmvxVybXZpZc3YMd8BJsyRp4LL9M5GOpCAcscBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gu/PyXvl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e9fdad5af8so998641a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728598826; x=1729203626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cUHgiT8pdYZdSxizB+8TEQA5XK0CM+d6Yf1PPhYy7g8=;
        b=gu/PyXvl4/5fLQ7Uv1J1BMtEyau8z6tnhePOujPHZBzL1nVY1X37G7TjkPGTSHg3qA
         d2a89ToQNYge9wWmH/1qaUTpED2SXLTHh4k+aT09eo0OQC1TRFNmVepa+uZ26EAnPi9D
         SKuPXUscazXp+7Zqf5wtL8Db1AFvKpB22p/50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598826; x=1729203626;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUHgiT8pdYZdSxizB+8TEQA5XK0CM+d6Yf1PPhYy7g8=;
        b=I1iedAUnBmKgaxXAoRdhRDDOgjf4WgJNMT/mZERjbbefqP5FSPsBjHpEF1l9nHsACN
         1Q/TMrFDpvYLznOP0Pyy8h/ml4xzpkFmKn8XLmbu3YsCrGfM6VXg4/ndDF2DOq5dVAdR
         z/C5oYd1Eg03r/zBLpME5PHnr5NaoyozMEfB7PNSqq+xDbx1xXqjJyyldvsNLa+8+QGu
         9wndYGKi47d0gQ6bhbMB6TlNYVt0ybrSXn5vBPdxnzHac0DXgeIfRe3lGIiv8+40Sep5
         byF+QDT7GncEEt+lZrXAU9HBQ2gADqPCUoBNoFsrLUFIEHFCGHTZhOalN+pCFZyd9vPv
         6K8w==
X-Forwarded-Encrypted: i=1; AJvYcCU5e+97O15zYeEmy9KmB9ebFl3yPD3nqWqnZUmugKkf340495bHlFoiXqZWmtPrtwNO3fzYRfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Vs2Hl0Pyj5DtJLMvtory9jjFhgGGpBkbBkZ5bTtXKjMRbE5T
	Az1a/yF4nzojUqrSnN4dmazLXoQdCvMrAsXAFRg1n20wMfc5eIwn5AbfD+QECBy3s0IRdiJI/+o
	=
X-Google-Smtp-Source: AGHT+IGaYe2Ps5jhfzGbQ50kLCUzI+wx4UvAPt97snB/m4UFvpSYgFofi5DI5MjvEgvGrgdz+F8ecA==
X-Received: by 2002:a17:90a:1fcb:b0:2e2:d1a3:faf9 with SMTP id 98e67ed59e1d1-2e2f0d923f7mr710654a91.40.1728598825776;
        Thu, 10 Oct 2024 15:20:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55e0c48sm4246573a91.2.2024.10.10.15.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:20:25 -0700 (PDT)
Message-ID: <0ba2895e-0482-46cb-a945-97d4a72b1bd1@broadcom.com>
Date: Thu, 10 Oct 2024 15:20:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bcmasp: enable SW timestamping
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20241010221506.802730-1-justin.chen@broadcom.com>
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
In-Reply-To: <20241010221506.802730-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 15:15, Justin Chen wrote:
> Add skb_tx_timestamp() call and enable support for SW
> timestamping.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

