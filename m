Return-Path: <netdev+bounces-251612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PRNDtTtb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:04:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F235A4BEDC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AECF7EBAD8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB83AEF55;
	Tue, 20 Jan 2026 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WHZ5dCxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038483AA1B9
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939880; cv=none; b=jxQmgm5u2D+GMf/cULV+9rCwNmpm1O9yRttXqvo+L3rCaHc6/dgh8+4AjspWpBPzUahguFTuDD0LvQkucLWK9D6lXJWXwoeXMY5KtEoTeSR9QYbVF5A4l2Cd6Ke6xLDw8M9yyJAU/IOUGHOQvZHxeeW8+ALBQUgHFASIsY8D8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939880; c=relaxed/simple;
	bh=mP8mKkEXkTbuS2BpXfXwPbjEgSPaeYK1D/cOSFxybkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joALUW+hsCDnBQA3Qm5LNh2/38nRLOXADwNlzyNIfgf5MXJeoZwTg3s43GkG0QJNQ7SWg7qmGLGObykb11SioexYVgqFhHV5nJKCf+bblFdVRwu76uShS/Bo3ZjssOGT9IMtbxgey9pz6wNzjfbzrkiB+aNiLHpnaK8tXdG74Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WHZ5dCxv; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c56188aef06so2324988a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939875; x=1769544675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qr10o9QlgtRi2OyxGc39IzaoVgHHciU4nH4WEDPZHx0=;
        b=svNWJ9ezoBAFcIvYfBANvibRmPP5etZ0A0cE9n6CJokiS0miSEHYqA7UJlRu3LinXB
         Do4dAT1K8uF7tvYUjSU9+EXJk10IpHleF/zixD5bOdPMWMWjcECBrCVTT8C47gLK+wys
         P174FyqChxnXutpAifPKYmFvhft01r1chge9TMy7O4jnVt7cRYhegymFoLRKBAUH9SXX
         +QNWWW7bLLhFrojOHnNcAzPO7NXqIcQgxXVFTKKL901JG1q7mt7tbxUHMlKr13eFRPR9
         DWftH2ArjicEdhL8i2nRJfvh3ViHIUKQVoKwZY1OWqNffCCaEDySZzUwPX5wzVxE7sXD
         JmjA==
X-Forwarded-Encrypted: i=1; AJvYcCXCpcSnWc9oJVevmBtYcuvhDIffrnU/pedxxFCFQgRCkZvTo4eVZObF5YecCjkDS6qxq0z5N4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6w5bzoX43o6xp4TyUuiYqSFRhTTjRiHq5ca4GMQH38FqAAOi
	3C0f5wBPvdTl0KiUj5OXFApVws/qmEUNlgGDqE9OIx3YoFhmYIRNEvOh4BBklhw3UlTnJWzxVoO
	jot0++4W1TU3ZiFiK0b1sboBlShiumFpCoR94YVYSJr2/Ges+tJ6egfWLqRVp2PROmFG1eTi4XD
	m8fS3OoA2jBini2XYNXIABr61t/TbZXOg+pmt9JH8TpVyaYGyATSwUPc/E3p4d/yg/hPCnYyDF9
	4YVT5BqPOr4SzoJ
X-Gm-Gg: AY/fxX6xCoyiIsUkqYvGnee+vpbpcdRto3DnaBnxRe5YUq5aZPXl9Ov50+4pgeVxUnn
	8dpdcHqWnAPhclHhHyfbwumcwwLj3z262NcG7mhvPGxFsH3NB9lTtCc33b3kXlTBu8HiYeJrHrI
	pc+Ll9WDCi1VIPXl6Jp/PYNfJ9aAFseZlx28aoLBta+jnXXNWdTMuhOEkLWgAhmJ7xw7wKyi9kp
	5y2CyDNPoAHw5N7MKkAhNG+yhf9thhCeG9kTK0NjcBGhVsvOdkbpxQj98s1gHjUfscRnpu3QKGp
	DONAG7D6NUfiZrOdV2TmPwMKW/gpI2RyBhWPioZc7IJRg254qJFvwgXt4Xq9NevKelHJnbOqs/d
	sSKeBMWZNtUzpjpOUGr1WJJO20TdgirVwP/r6NQuFjQnJNyhuHlzSXDwChX0IHlgprqN+Ejm/xm
	69AVsXpPlhbCjAGKLsNhOimrtbDDM2WQlISd0xCGZ3Mrrn8scMOw==
X-Received: by 2002:a05:6a20:4322:b0:376:2a3e:e758 with SMTP id adf61e73a8af0-38dfe60629dmr16647049637.28.1768939874822;
        Tue, 20 Jan 2026 12:11:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190a3360sm20842595ad.4.2026.01.20.12.11.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 12:11:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a2f8e7d8dso170850736d6.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768939874; x=1769544674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr10o9QlgtRi2OyxGc39IzaoVgHHciU4nH4WEDPZHx0=;
        b=WHZ5dCxvkAb5Qzg29Fg/M+QBMCwVvu+Jj46TP19AMBh2AWnCXTbd+Rtk5BPWLAw/3K
         eMwdAwcXIq1V6w4qFgP8bfXnybkj4v7ZgMiBeZ+YwuadTPg16FUT+5xTK4iE3U9oV6yn
         3NejwGEwl0Y/PNSWxPn6L/Erx2vRrPmhhKmu8=
X-Forwarded-Encrypted: i=1; AJvYcCVq+q821kyrNloDiqv5Anandxpq2j9UNRhQdw95GfTy1pAm/+PmlT8Ih9cWlMyGkCV5zMhDay8=@vger.kernel.org
X-Received: by 2002:a05:6214:1c4c:b0:890:2a3a:1bd2 with SMTP id 6a1803df08f44-8942dd06b3dmr218125756d6.4.1768939873637;
        Tue, 20 Jan 2026 12:11:13 -0800 (PST)
X-Received: by 2002:a05:6214:1c4c:b0:890:2a3a:1bd2 with SMTP id 6a1803df08f44-8942dd06b3dmr218125246d6.4.1768939873012;
        Tue, 20 Jan 2026 12:11:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71c14a9sm1105925185a.22.2026.01.20.12.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 12:11:12 -0800 (PST)
Message-ID: <23a697e2-bfe9-4a09-94a7-2c420eefb06e@broadcom.com>
Date: Tue, 20 Jan 2026 12:11:10 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bcmasp: Fix network filter wake for asp-3.0
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com
References: <20260120192339.2031648-1-justin.chen@broadcom.com>
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
In-Reply-To: <20260120192339.2031648-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	DKIM_TRACE(0.00)[broadcom.com:+];
	URIBL_MULTI_FAIL(0.00)[ams.mirrors.kernel.org:server fail,broadcom.com:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251612-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F235A4BEDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 11:23, Justin Chen wrote:
> We need to apply the tx_chan_offset to the netfilter cfg channel or the
> output channel will be incorrect for asp-3.0 and newer.
> 
> Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

