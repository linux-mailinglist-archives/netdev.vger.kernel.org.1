Return-Path: <netdev+bounces-241991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50849C8B6DE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BC764E5532
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355FF312821;
	Wed, 26 Nov 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NFHnO6Ng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB1312829
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181425; cv=none; b=kFZOQkNUBBWy91EQFIkSTgBPL5LoQNHONcKi0Yn9sIA2mYO2/grAfl3A+PSIncGsk7dS726aVQwUCzA0r2j7fPrW2J+6GTadyFKyB5+E7VghS/Cm3UzhKSy+vvkgzx9++iuJBH9Lmyou+W+Mgv9jH8AFsh5F2OYEkmBpsBwvqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181425; c=relaxed/simple;
	bh=F93IFhD31Rd3wUhbOzhvuTYKafkiu87C72nbIsMn1z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSDcDsPP3U2jNyIYEmjFvRCPGzKw4J3dFe7yYdMwo/vZdlKKti+p0YjD1kHTts70xutlz8EfrybE/0oTGuZhDLJ9RPH5MYf1oOr826Gcwp52HspfVbbVMJXEYKzyOA0RUaBSdFNfuSFSs5pWRwRBpU9c2/989Z5xsQVKTIYzA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NFHnO6Ng; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3ec41466a30so79087fac.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764181419; x=1764786219;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qk4r9Y2WKLv7ixeZmUGHkrxZCeGQ75/sFpuZSejIVUM=;
        b=Bffl+lr0jf5u9jkCNNa75nxVe4jklHBkPD3PpEIe2hLOpuT02KjrbG7Aiyxw/4nR1m
         00nwWUMK/cf3mmfeNQWTMPfuOPBGcyy1QhXKz/UMQZ5X1zZXTz6MHJT+DTDqKLQ2rG+n
         BRI9aRv/lS4PzGhC+0K3EJrUMJ/59+7ZYmSigKE1m67jp8s12Zan3T8F+EHKQ3w6FuuV
         ubq0wQo7CysauM9JQYgUI3tnArY3ndCCpl/E04jPlmlxNIixzEAJyG0dTvZEPDD+3ycC
         wKoc9I7ZYFEe2WyVbyfMXWhTMQFOqzsPy5tekE0aqG7bWFmHwCdyuih35ZuRwFbGswrS
         DqNw==
X-Forwarded-Encrypted: i=1; AJvYcCXImlYRavmvLPd+P+JquG3C3exGfr1qWmnC3s2bw0sSUcVrWuwTplUti3w9rNxW3kbCpxUvvvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTw+CL1jiFOK06IN/IuYY97tNgJRtRIW3y3X8qyT2c6cmEq5z
	THBqgnxoEmfbmBtfZy3bTV/uxl6TxSagDstwLsyL2v1xPbjAd7O/gru/D2ud6VaRXrTOVhX9h+r
	fNlFlnsQ7l0Pe/uyD3UmIodw9bkjXSn71/6KMzwy5/1pfKQOya3LoSBJfV4m99HUh31atiD7s1H
	lbHLr+qFrlC9BBbN69/R/hDz68FyB7Oaay6OMvQgz7BWgf8MvoYIo+rP5Ty0fZ1YKb3vhLoXSBw
	bmfM4MYn8CFmfza
X-Gm-Gg: ASbGncsa4sf2jFLcuiZ8bLb4TidMagzHrCYLMvFMV/iz1vLOrLwEREDxUUIvAjEAY38
	zxsDjYlLKRfO5RcyygfdWIp64osqs8JF9kzhk5WLa45KpkPCxQc2w35iP87BJBXrdC+ZbNizuje
	GhGi1VhCSt2J8NYuYlbUmKVPiXvHpLlhw9fLiXLn2taGEUPMatZ2X/AE+UmMeA94D5WY7Mv6TWZ
	utLs4l4iapQGJqgwkIFcD/Rd9yGhMz6+5F2Gr0b7U+1mQQUzE5pskfP5FLDq/CgAX/e2BWuXEnZ
	ArSGFtEPgJfaFSGbPyRrMRgsSY5LUNU1pantwKE0Vtok6KBQ4JCmr8udO5YKza9eFpIdFG2shSm
	5T7XJx2Jj3mGYOIbyhpCG0/AUO5InvAeZ4HMoUMow0pu5W+Yb5Lf8GBppLanj3eqjVJcsYzeNDF
	cvJa7DdyuVQblcyc4ro+7lpqRO8tznBQR5kQJ2Yp+oLniljUX6cAES
X-Google-Smtp-Source: AGHT+IEGykJKWPYuoFNSFWsoLU+NWjrQfiVDBMEjQuyTt5RPeYbi3TOSXIkrbThEWobOwHkGzw3WDa8wYTGC
X-Received: by 2002:a05:6870:6490:b0:3e8:9ed2:8846 with SMTP id 586e51a60fabf-3eca17c8a9emr12591518fac.14.1764181419148;
        Wed, 26 Nov 2025 10:23:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ec9dc787besm1817917fac.16.2025.11.26.10.23.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:23:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-11bd7a827fdso1534554c88.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764181417; x=1764786217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk4r9Y2WKLv7ixeZmUGHkrxZCeGQ75/sFpuZSejIVUM=;
        b=NFHnO6NgGXUfqXPAzEmI92bGt+k+39IuPhcomcYR/Wphw0q2ruqd+ZICxOAMp1da/s
         /b1j0E6vXbrbGA9yGA1VVLsh4yR05+5nQRBNtqtMvGAxFwOIOgt7dcVFi/BO+xE6NOno
         IkOjH1F39B4oPtL4npPOWam3I/CfDNSnqA3KQ=
X-Forwarded-Encrypted: i=1; AJvYcCX6PR31mlXbEBRKPSTsIpAzVnaUcTtEs8XtIbm1khrDvNSmNLtzvZyZLGBQXW0ANA87I/YzF0I=@vger.kernel.org
X-Received: by 2002:a05:7022:6b87:b0:11c:9c9:224a with SMTP id a92af1059eb24-11c9c936600mr12564827c88.1.1764181417301;
        Wed, 26 Nov 2025 10:23:37 -0800 (PST)
X-Received: by 2002:a05:7022:6b87:b0:11c:9c9:224a with SMTP id a92af1059eb24-11c9c936600mr12564791c88.1.1764181416759;
        Wed, 26 Nov 2025 10:23:36 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e3e784sm72760162c88.5.2025.11.26.10.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:23:36 -0800 (PST)
Message-ID: <249b892c-010e-4906-94b6-0f2226a58ba0@broadcom.com>
Date: Wed, 26 Nov 2025 10:23:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] net: dsa: b53: use same ARL search result
 offset for BCM5325/65
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-4-jonas.gorski@gmail.com>
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
In-Reply-To: <20251125075150.13879-4-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/24/2025 11:51 PM, Jonas Gorski wrote:
> BCM5365's search result is at the same offset as BCM5325's search
> result, and they (mostly) share the same format, so switch BCM5365 to
> BCM5325's arl ops.
> 
> Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


