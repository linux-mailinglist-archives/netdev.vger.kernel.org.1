Return-Path: <netdev+bounces-275652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDN1OGXl02n/ngcAu9opvQ
	(envelope-from <netdev+bounces-275652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:55:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA73A5764
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D195330107CC
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7DB38759D;
	Mon,  6 Apr 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qts7GrSD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A32E719B
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494498; cv=none; b=fWcky3Om2tcqFP1OTBmxPMYbq8MzOoENvmRUrbX9Xdm3lCXZp7K2H8r/D5NNI60Y5wkrYc2Kr8g5nrk3uHy1eZrmKQ3b90R71FaI/BcU0SfNv0PKsjTRDgSinuLDm7TfbQTOHCmVii6bvPCX3KWOu6icEItIKzc3Jv9m6LLmx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494498; c=relaxed/simple;
	bh=v/b2WBth7J5QrfhAJh04M6vjWYEsAwpuNU0wLdVXvqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtMYoh1krtG5UIx5EktyZWukhj2r0ZzPjbDCSZLmtWRUwmxmjM9IDHu1H/btcMo53Y6Jpa5+vnThvIFo4gQItoF5/BLbBC6I9axV5XGIu1Vju4wZc4JQ1rBZhA2HhhGv3e7zRQJ51xVgnlJhLteYC09EDkcoEuyfubOqB9pHijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qts7GrSD; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-604fc147b7cso1136906137.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 09:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775494496; x=1776099296;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XeAJaTCuf1MQECUc7xybp1l/CCu7OmRH6GvNpwXH6XE=;
        b=q8N0W4NX3hbIw6ntqSY2I+hHh0C+Scx1tD5uv6V8Mx4s6VeCfS87Cd+sAtjdaJdyx/
         O77fYk+Zzx0sZKcf1Dv9I8gX7uwJ2qmq5XQbW9yeZ4OGHHnpBwyMXhoe5i4Nq43MJdHj
         AgIdBzrSXwrpjiz2xhOmQm8xbeCNctDZxxBONZ/mC6aYh03Vd22JzlOx+MMmGyOmDQC7
         CvXU44gaChLgsIHZkQDcD2MKgCS6zT8MQu5WCBL0ONE0A0h+nWtUYS162iPAWTb3BasA
         fHFKf2XbPvMCvORy/rgFwspHraexLITe8/hk09HGfntihd+K2KgOjMb245YNVhC/11BY
         DnlA==
X-Gm-Message-State: AOJu0YyEYeWtGZ49shVBiS5YKGw6Sby0LhrgQcsp+itQfq88DfHVExhI
	X8/ZFlYc6qb3SZBSzCn6YKs3qKbLoiv4GYq+UW1FW5aaUdig1Gt3fq6cFSR7ev3PuEr/tgjRpeU
	oCpL0vWpRt2p+uptHt92mAvNbrSMg5M0AKOR4o/r3Ghdz3SotkRRpgb0wSKxc7nSYa9AgOON45m
	+KiW9Qg/lPYUxrc9yVTaHW0oQhnjSAiYl2c8v1Qn1JyeZ3stwcPWCpmBduXTr2raz2/zFyA5QGy
	HjVUuXg/eetnxMp
X-Gm-Gg: AeBDieunpsZUvKvNoVzpEpspKTwGqGZkLoovTtLIqYCTVbQrLHaxnM3BBkzhoD3O/wm
	LOyG2OC9/Ize4jGKhwBx+NmQsXNYso7zYKZZk/1ZXoZLHaps2M/P+A4sRwv9V8VfDz+oU0C769j
	y8wccGvzNWWiZ3DEh7KBzzKs9TuOTgiUNs+0VDU2GYluW5YFZYPOu1s8u74+wqeVMhUHtzk0wdU
	aYiR/ukiBRWK4e9AGF0ZMQ1t6bpnXl87pAGRSNNX84Eafvm6D2mmIZsgPyCGKjqqb7D9SyuePRb
	XRs1gqmjY3dCFUSH7KoeZrdTlT3t4cx9OmUMmU0Ti4OW1cyi7nlxw99ib4jHnd3ArXl43xGS+IG
	Gg2ybIYK2+Q3k9pOOPxUHjuBUGqmBFx7EQLtJVwC6Nj1m3gmAIJCajUcdLkhS5nkVD6jLJLLLCd
	l6aZCJiWpDmaeLWQmVTkYz9Paq+ZIGfo5a0gS+bKo7AYmAKiAlQ3TXOq0DgN14uQ==
X-Received: by 2002:a05:6102:c02:b0:5ff:fbe4:8a4 with SMTP id ada2fe7eead31-605a509796dmr4311893137.21.1775494496396;
        Mon, 06 Apr 2026 09:54:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-60582e11f3asm1131084137.7.2026.04.06.09.54.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 09:54:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cfc1634e43so413255885a.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775494496; x=1776099296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XeAJaTCuf1MQECUc7xybp1l/CCu7OmRH6GvNpwXH6XE=;
        b=Qts7GrSD43noqITbRzoyaUZr+hhQzcHTMV+MEWWcHhLqwlwdSrmKgEi0U5LNy4XRoa
         oY+02ekTX5oHefTsSDv64jHQtaJGXze5XSwnvjAWbzltJKLnPM8V9EbRIMj5G6fJ3mSa
         xe+lEdDrJQwzJ1kvoUw6wk1Tz1XmTgfZCEYqA=
X-Received: by 2002:a05:620a:2590:b0:8ca:105a:298e with SMTP id af79cd13be357-8d41bbdbbc0mr1882281085a.63.1775494495630;
        Mon, 06 Apr 2026 09:54:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2590:b0:8ca:105a:298e with SMTP id af79cd13be357-8d41bbdbbc0mr1882275285a.63.1775494494948;
        Mon, 06 Apr 2026 09:54:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aa70136e87sm36100646d6.22.2026.04.06.09.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 09:54:53 -0700 (PDT)
Message-ID: <d6f4cd10-8023-4113-b8e4-214084038369@broadcom.com>
Date: Mon, 6 Apr 2026 09:54:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: phy: broadcom: implement
 .disable_autonomous_eee for BCM54xx
To: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
 <20260406-devel-autonomous-eee-v1-2-b335e7143711@tipi-net.de>
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
In-Reply-To: <20260406-devel-autonomous-eee-v1-2-b335e7143711@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275652-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tipi-net.de:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 62DA73A5764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 00:13, Nicolai Buchwitz wrote:
> Implement the .disable_autonomous_eee callback for the BCM54210E.
> 
> In AutogrEEEn mode the PHY manages EEE autonomously. Clearing the
> AutogrEEEn enable bit in MII_BUF_CNTL_0 switches the PHY to Native
> EEE mode.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


