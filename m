Return-Path: <netdev+bounces-134401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C599934B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35601C212E7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A401D0BA3;
	Thu, 10 Oct 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rmg20+EL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164E1CFEA0
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590552; cv=none; b=rhFY+NoZaU7yzDoxABIwgQUF9/TGgi/N4KUglc8xzs6RnMu0JdKcvdwO16s7EilBQ5p4gFAdnXA+JdJVJNdSssjW/Ok3pGkHXnCtRWt+rcihXTP7vrRh5DVp1ekvg5UR2AhWoedp5mUkamW2ihV5ROJ/HtZH4R3vVQYWZZGlxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590552; c=relaxed/simple;
	bh=Ufq4Rv9QkWwA0R4+C4jJuCBL5lj03dyp/eJyqA12F7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzPVM/aEV+err938e//k9tLCkOXwT53oQBvw9Pz9H9rO76basITZ7LTF9gh3HQpXhL5yX70GSJM3n7eFf2vx/yp5wbG7mnV53fifLgL7SNPTVrcbh31H47MjJBpyBQGVkJqMtu+v3+wxcQNaBz99WiJ6w/QAflYMMcHrTNBImU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rmg20+EL; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-717d2b8c08aso417701a34.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728590550; x=1729195350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=THpwMhu/eHO/78nRRmMM5iJs132pKlZiyFjAiDnKR3c=;
        b=Rmg20+EL8dJWvKufD92ezz4QKnViMH8/2z8aEebPc7TVDNUwtRoAZVBam9+Ixn5b2a
         NcUeHjKPIzp5FR/ZH/SX2xZ3U2N9W4+/XvewR2sVxMgBr9p9lsi4B9j66WoqD/1xCkwI
         KDnjuwm+o4d5GO7XWz5O6cV1GXkRvQQCas1aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728590550; x=1729195350;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THpwMhu/eHO/78nRRmMM5iJs132pKlZiyFjAiDnKR3c=;
        b=jCAIqlBV5b3fTI0t9GWZLPPR/HfgEd4tDAM39e3SYoLTrZMsiVJle3CNDPL0v72qK4
         JLoV9P1hI+NnkKTwCeap5pDES0DUlfeHoxGsgJb7OxFOU2qmxkqnOvVsitfK0f9DWc5U
         kxtUzXijxsWURh/UkuMswdj/JyJqrEyXb05nWojal2oV1TrGhVYK9KKI2muQlOkdWyzC
         +gUsXMngKNNZ0DoduxBmq3wSAWK3XBhXFFDUOGZsd5wi1+8nKxrB0hx+9/ODz7rnXYY2
         nQEfq6EB0q6etavJ/Tftiv22p6PpbFVAjzZylzeQWIiv9YIUKk948HmFrk7mpLbnOmq/
         Av6g==
X-Forwarded-Encrypted: i=1; AJvYcCVKOatMFVxGxzBbeXAgQUJpNjqmiRjx3W8NMjRv4k6PPTUh2v446Aw+j+tJvBgigkq6Zaeio7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBx6kARtQc+vXWz7VNwg3X0Lk22t9YvDSYKu6q6Sy1VnwwKjUm
	JBEyHWbrl4yM4A81bvU+D1rZc8yxZBkEBh4EGvg0LAIZvO3E9d1TTD/lhaBGjtbJt96pZJOPbIw
	=
X-Google-Smtp-Source: AGHT+IEZ/Bc/CinBvfrLNeiAe3TCEEadIJS543gwE1faUks/hMrtvwB7xxEYxmMroK5+u3OxFw2y/Q==
X-Received: by 2002:a05:6358:5286:b0:1b5:fa68:4208 with SMTP id e5c5f4694b2df-1c32bc8ca67mr30817555d.28.1728590550300;
        Thu, 10 Oct 2024 13:02:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148d69fesm73075585a.41.2024.10.10.13.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 13:02:29 -0700 (PDT)
Message-ID: <76756326-d14d-4c70-a897-b01dd44066e3@broadcom.com>
Date: Thu, 10 Oct 2024 13:02:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: broadcom: remove select MII from brcmstb
 Ethernet drivers
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, bcm-kernel-feedback-list@broadcom.com
References: <20241010191332.1074642-1-justin.chen@broadcom.com>
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
In-Reply-To: <20241010191332.1074642-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 12:13, Justin Chen wrote:
> The MII driver isn't used by brcmstb Ethernet drivers. Remove it
> from the BCMASP, GENET, and SYSTEMPORT drivers.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

