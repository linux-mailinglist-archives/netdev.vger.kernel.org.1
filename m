Return-Path: <netdev+bounces-192308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84851ABF6E8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CEC16DEDB
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D7B1494A3;
	Wed, 21 May 2025 14:01:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FA2A1BF;
	Wed, 21 May 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836086; cv=none; b=o/0ZcW9IahCgbImuU8X21LWPydSkKj26+RLHlnUfxftr1KbdfzxK+/frca2z/wcwLhSAqC8LUdZU4Q4Jjn3Xj5t2TWEUxTbDdJzDcinjkY3b2lVYpz9Gh3iWUbXYEyp0iIRoDD/p5fgNyqB9isWLrnYnqNPEgIwOnrKECjH29ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836086; c=relaxed/simple;
	bh=rHiSEnPQVxe41kOxSNdhkkzgEtOJynN2Wt0zY8D+RV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RSW6zQh2llhwMuecQfwh3P2rJ4RjiqiZv9Rffm2Id9V3/p7W4sDJpdbr7gdZbJgnLpv6PgvXbd/J/U++sSO4uA90dDwKm8UFmfzLjry0JnVeRQezy0AJIReACpBay3ENqwI3GaX8GOMKpEHCtGtFoj8B9wDX9WcCyH+vEkzzbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 21 May
 2025 17:01:15 +0300
Received: from [192.168.211.132] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 May
 2025 17:01:15 +0300
Message-ID: <4b007a74-3399-41ba-8953-d7767fcad4f9@fintech.ru>
Date: Wed, 21 May 2025 17:01:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: usb: aqc111: fix error handling of usbnet
 read calls
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com>,
	<lvc-project@linuxtesting.org>
References: <20250520113240.2369438-1-n.zhandarovich@fintech.ru>
 <39e2951b-6e57-4003-b1c7-c68947f579be@lunn.ch>
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Content-Language: en-US
In-Reply-To: <39e2951b-6e57-4003-b1c7-c68947f579be@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hello,

On 5/21/25 15:34, Andrew Lunn wrote:
> On Tue, May 20, 2025 at 02:32:39PM +0300, Nikita Zhandarovich wrote:
>> Syzkaller, courtesy of syzbot, identified an error (see report [1]) in
>> aqc111 driver, caused by incomplete sanitation of usb read calls'
>> results. This problem is quite similar to the one fixed in commit
>> 920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
>>
>> For instance, usbnet_read_cmd() may read fewer than 'size' bytes,
>> even if the caller expected the full amount, and aqc111_read_cmd()
>> will not check its result properly. As [1] shows, this may lead
>> to MAC address in aqc111_bind() being only partly initialized,
>> triggering KMSAN warnings.
> 
> It looks like __ax88179_read_cmd() has the same issue? Please could
> you have a look around and see if more of the same problem exists.
> 

Yes, you are correct, similar issue with ax88179. There was once an
attempt to enable similar sanity checks there, see
https://lore.kernel.org/all/20220514133234.33796-1-k.kahurani@gmail.com/,
but for some reason it did not pan out.

As for other places with the same issue, after a quick glance I see these:

__ax88179_read_cmd - drivers/net/usb/ax88179_178a.c
cdc_ncm_init - drivers/net/usb/cdc_ncm.c
nc_vendor_read - drivers/net/usb/net1080.c
pla_read_word - drivers/net/usb/r8153_ecm.c
pla_write_word - drivers/net/usb/r8153_ecm.c
sierra_net_get_fw_attr - drivers/net/usb/sierra_net.c

This covers all instances usbnet_read_cmd[_nopm] that do not check for
full 'size' reads, only for straightforward errors. Roughly half of all
usbnet_read_cmd() calls kernel-wide.

> Are there any use cases where usbnet_read_cmd() can actually return
> less than size and it not being an error? Maybe this check for ret !=
> size can be moved inside usbnet_read_cmd()?

I can't reliably state how normal it is when usbnet_read_cmd() ends up
reading less than size. Both aqc111 and syzkaller with its repros (and
ax88179/asix as well) tell us it does happen when it shouldn't.

Personally, while I see logic of moving this fix into
usbnet_read_cmd(), I am wary for the very reason you stated in your
question - sometimes it may be expected. Also, more often than not
functions that envelop usbnet_read_cmd() (like ax88179_read_cmd()) seem
to be deliberately ignoring return values, but even an early warning
may be helpful in such cases.

In other words, I'd rather leave the decision up to the maintainers. I
don't mind doing either option.

Regards,
Nikita

> 
> 	Andrew


