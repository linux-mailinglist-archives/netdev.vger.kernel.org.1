Return-Path: <netdev+bounces-300404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3HVL/jNM2pAGgYAu9opvQ
	(envelope-from <netdev+bounces-300404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:52:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64969F83F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:52:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=MND135qF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300404-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300404-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84AC33022073
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46239364927;
	Thu, 18 Jun 2026 10:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5729C33F
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:50:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779859; cv=none; b=M+zYgr0JEPYQldAzlCdd4M+bg2hO9z6f+XQ9QBCSjYHmFIfToO+fQ4Y9TVaTkCyeH/TieXyg6RnA4kLBA1sTPWbFPiKwyjluVy5nEVclry89A9UzPEhRUnVrxSbW3dSILJ2dBcq/scAFRgy3wvVD3HifQi0VlrJYF2usCeE1ORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779859; c=relaxed/simple;
	bh=Se/6XPcHI20qi48T8ngqwuf/Si0p2Lfd7eX5POwmwXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZPShzowoSAYn9DR+wtE2AUCIqvMOq6Er6fR8BRRB6rkJb6mHpP7MrnWhIMDcZKlpiORItWlvUnspTWbszwDNtknDTohoz82GyYxIsZgQ48F+ICQPos3zakaQS5F2Ri5ofxtI6lxGd+dtr5plCI53RqKOgLTVSaTIA4Dt8FIWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MND135qF; arc=none smtp.client-ip=209.85.222.228
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-91562bf6c12so101676985a.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779857; x=1782384657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sxUTxt+JD/yjMQrssAU8jOl5mCgW9xPgpAUPTA83Kks=;
        b=G7XoXEtA9s0clE4O9KqX6U7ULr8oFtirxCUsIN4ykS1qEaZiTkSb+FFF8dtFdIZcLz
         seHiaBdVVKc4jywRCDXs1uUWhJCeDGi5Cnb+fqq14O7c9w+j/JpXVLHui+27k7iO/Dzs
         6q9TvE0n4fG5aKnbW3tlGe/E6WfXQwbin2y2/3fxJfk6/VBqFYiFzDqrM/gtX0uk1z8u
         x4/MIA5k5DXTBV0Q7W+mQ+dDUUO1VkNw9de72ka+/93ZDImhBEQPrO2f+oEPEzDjgDNW
         KicINQUZqoMZtqC3gt3A7FyVOJd7GeX4Bu9hHTFgc0Slzr4SWwFo/egKf7W93iulYCz+
         PpIw==
X-Forwarded-Encrypted: i=1; AFNElJ82OsxWXLcQGFLdYS8vuhSQvqHT6svvklDwjJpj4VmsrTT2YkyRRVp7C1O5sQL1xNpUtRl+Xus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWhiDzRjxoEIi3c1HAbaIMNq1T050DFRo/DzpybUFIQcEJu6b
	5mfwEkaLSQcQyQIdB6WvPJtazCz27MijzayG9L7Rbs0UdEocvaJhqfymBPzf6IBE4oGM43LCLQy
	hwZgXqXuWmkA5CTJqY1wjt1fpr4QmOZBLUfvgrSPlpT3XCbNYWeVyAL0YDbeon3VidUgUbNTxlH
	aeD6helatPI0XM2W4J8tnKkmgaw9T0f+8pcxQmuHfiRNeCgBF2AtWwN7tGljdhl9oscDKuzNuRi
	7BWfLXeTjaiZHLENc8=
X-Gm-Gg: Acq92OFmQ5TazjDM+Bo7MArjrWIM9LiOEpkwii6cNWdscZPZ7B2GFcv9//C1HiWSfwF
	Lns22avwVlqrwH6YjIKp9suxNZFVKFCFtilLgiX2nGFbfg05VMXZeNRUtZivCvGdreGCAOEey3m
	f9HNxyqdhbLN7L1hz09nEqkgAUYxxI5BbTElQIJhRHfQsoswqpBVcxWHDiIBDubP2f9TJKVwE7U
	N4mv/xmVhGfQyZ+irLykiQimy1Q9MlcZj2ZJCPnmopiw2pDGHzTVMoV9PEYatfSFb+gwvnOUtS9
	9eYaax7SGjh+gHlmyPCijgzbIDPvulJW2a/tFl2CeyD5rERdMAkVk/8Fw0tX1qEIJH+taoRXqsO
	piTdPm7rmLgpK9HeS08Tfcpqmt9rTDzBgt63nlblPHvjQPyoEcGeTkDhxbk7KxjGZNZ0M9IZYes
	yuhMZ0CvS+wOWdL0dQS56666MLrZAXDoQw0llKtyiXRnCIHsoyYlU=
X-Received: by 2002:a05:620a:1a06:b0:914:e3dd:17e8 with SMTP id af79cd13be357-91db948c9f8mr1177292985a.8.1781779856788;
        Thu, 18 Jun 2026 03:50:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-91619f80af1sm65345085a.4.2026.06.18.03.50.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:50:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef4931de5so1263120f8f.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781779854; x=1782384654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sxUTxt+JD/yjMQrssAU8jOl5mCgW9xPgpAUPTA83Kks=;
        b=MND135qFEHyOOOmqD1EEsnZDkBUwQulohsVMNeOW1mY0LALqsUoZxhg/KhP8sgrKr4
         z/I5priW5avA3X76YypiEUDc4jlbwtzcICQu/dKGZFjhFYqqbAQb37xZI1m2AVL3qUht
         wEQdt98iBXIfCGIhCc4wUP6XYx7ZJDbOkTgMg=
X-Forwarded-Encrypted: i=1; AFNElJ+J+v9WaJZ+wDuzGFCDO+AmHFC4gegzQph6Rm8VcqSZpRyDpWOMbVKv2hIEGDV/mUWSxnbFVS4=@vger.kernel.org
X-Received: by 2002:a5d:5651:0:b0:461:a15a:4160 with SMTP id ffacd0b85a97d-463978b2374mr4215902f8f.13.1781779854474;
        Thu, 18 Jun 2026 03:50:54 -0700 (PDT)
X-Received: by 2002:a5d:5651:0:b0:461:a15a:4160 with SMTP id ffacd0b85a97d-463978b2374mr4215865f8f.13.1781779854022;
        Thu, 18 Jun 2026 03:50:54 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619fb12edbsm25700899f8f.17.2026.06.18.03.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:50:53 -0700 (PDT)
Message-ID: <0e7f3186-718d-4ce6-9527-447f37b97ef5@broadcom.com>
Date: Thu, 18 Jun 2026 11:50:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: bcmgenet: allocate a single-queue
 netdev
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612205915.3156127-1-nb@tipi-net.de>
 <20260612205915.3156127-4-nb@tipi-net.de>
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
In-Reply-To: <20260612205915.3156127-4-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300404-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,tipi-net.de:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A64969F83F



On 6/12/2026 1:59 PM, Nicolai Buchwitz wrote:
> The driver only uses TX ring 0 and RX ring 0, so allocating a netdev
> with GENET_MAX_MQ_CNT + 1 = 5 TX and 5 RX slots leaves four of each
> unused. Switch to alloc_etherdev() which allocates exactly one queue
> of each kind.
> 
> No functional change: netif_set_real_num_{tx,rx}_queues() already
> clamps the visible queue count to 1.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


