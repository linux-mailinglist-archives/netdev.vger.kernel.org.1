Return-Path: <netdev+bounces-178415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EECDA76F6A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D865D1640CA
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB6217654;
	Mon, 31 Mar 2025 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="EOOLVEuB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142551D5174
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453368; cv=none; b=jDTLYa+6fTrmdt+BYgxKhwCEuIPkuwqXUR6B/m26wXv6b19+blO4nEYiVtNInXLnSa9pEDvHE2egHKbnEukbqrHJT+cqshqTrsR188mZivD7OpgpD/7UP8pcPdihtbcUdqzkp0EsiMxgnNjTsQRqmXeiVwftL4UFgh7l/w993Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453368; c=relaxed/simple;
	bh=BXhMA2bVkkZjm52HzykHmpwFoPUimU5nv5H7zKIddTA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZEXqRM92khLzOCZtSxzOtymjP0q+m5teBPuHilnWi2pHw4DTekSb32KVlqan2SkzkQcLyMVvZfTQ8wwmsmlTCZXty3fNxVlcKYQI+Y8KyWhBuXhODWnvJdnphJGTcr5f3EGAA31gwVzKN9IelLDAomFXkkrvvOkl3YYKFe0nwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=EOOLVEuB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so8117281a12.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1743453364; x=1744058164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MGYjw1uuKWmPyN4cu8oPBTHS2gSLPVA6sF7e2mS6NN8=;
        b=EOOLVEuBe5jrhPt03ieGH15EP9R1zZ3gCxu4afFpZHHqqKtEH5UVgX9xDgvtHlNgvh
         +VMseR8dAAqpljymg9RUg2utwJWI1E5GRB30l624pLXtVhihWRyaGr1eGdNQUkm8GdVA
         NHvCdwoQkwxoQnDyXO1UxFK0Vw+6taTkxXQIjd+lvLfAvhm+DLP6qOpEeD0ubmVJBPCE
         OI1vjxIXY8CIk860M/9SuMynogRoR6HHZdKGNKwaROBktyBkG5xSvChb80q2KULr7uZD
         Q8OlZ+R1h8BO+9XieAUxfNtfwC++gcZFd6p18/a2OGU61l3BmnkBH7Bf5N6gqebR2mSk
         64Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453364; x=1744058164;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGYjw1uuKWmPyN4cu8oPBTHS2gSLPVA6sF7e2mS6NN8=;
        b=rCvkTSZ+O5riSta8Z2q9Y80X9o9oHlaWm/y+0EunG9OsnOhMDxRB4dR8S0kcFrc3Jm
         yibOCceAB4AhDtLeKQ5Wj3Z7qWC2LneYWZZ1+f2vePKRypYXz9seyGZP0zLzTp/rleWY
         ldeqHe75CGpMB1xD00TG01UR3+RYK0Uyu6WkP2CkZgTfFQWDhpdAr2C+q5Oh5i9rC3/1
         qKqyNY+omAZRjWuS+k+op+kCKrRj6YVboTscU5CwgMzeJM14iuSl6KdyOeqqXZlYdKHn
         hfL80kbBe+rWI5d48Buf4HTRlS7corC5apcyhYt6dKfaREkZEuv8FSV4ecg2hjalGZAb
         w7SA==
X-Forwarded-Encrypted: i=1; AJvYcCV8xMZNfW104xcQ2GW9VwL/sqOs9+wfziy4Pgmxsc/nPOmTihMeXEUQSVURwyuQ4X7nXx1Px4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVinqis9nAqanaKn7DHjDug9U71kZFgH7dDyradqVvvuG1q4DC
	AKxxomaNmTdaDO3KHuZ6RM+CP3zx8OC5OB+HTR7/sk18fMzy1F2mT6z22HTYcQ==
X-Gm-Gg: ASbGncu7o2X1XapUeI39pA7dEXPpiSkeuSQmZjyLqWe2C6JgubnhRnG8n1bbftXsECP
	AADcjSh6D/I24FHy7tQKIFJcSBwQet+2YDVpLojILUvTt0goiTQ+vlU10S0lWXXDuBVJkB0zBpI
	ZZKX7vtrwsUuw5Xil4MVS9cTjiGLpR6u8BsQqPZefmXGOjs1hfxHevDsQkVhz/WJx86yDLwGo/d
	Slqkc/4SrpzsRDbHSw8TmfbMt606DefFXq1avTw3GZZPYlLdFgy0UfGhlAnDTY9o6wfevcTakp4
	DJsLqGUe8SgeWuH8D/zruzLo62QQWYgiKSc7M/lwth1C01aNLKzi24qLkvp3XpAD9DqFJ6mvZoy
	BYkvd1g==
X-Google-Smtp-Source: AGHT+IGmOQ0dYuUZqV0ho9bWhCeI93hp1eGUhMitjDKWzyprEMoZZbsgh4LqP8uUT7lEUGTHh5DBTQ==
X-Received: by 2002:a17:906:f85b:b0:ac7:3912:5ea5 with SMTP id a640c23a62f3a-ac739125f39mr828851266b.58.1743453364249;
        Mon, 31 Mar 2025 13:36:04 -0700 (PDT)
Received: from ?IPV6:2a0a:2300:1:1fe:e2e5:1eb0:886e:bbbf? ([2a0a:2300:1:1fe:e2e5:1eb0:886e:bbbf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967fc5fsm677464866b.141.2025.03.31.13.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 13:36:03 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <a6d71bdc-3c40-49a1-94e5-369029693d06@jacekk.info>
Date: Mon, 31 Mar 2025 22:36:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: add option not to verify NVM
 checksum
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c0435964-44ad-4b03-b246-6db909e419df@jacekk.info>
 <9ad46cc5-0d49-8f51-52ff-05eb7691ef61@intel.com>
Content-Language: en-US, pl
In-Reply-To: <9ad46cc5-0d49-8f51-52ff-05eb7691ef61@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> Are you certain that the UEFI FW corrupts the checksum each time, or is 
> it just that the system left the factory with incorrect checksum?

I'm quite far from that device at the moment, but from what I remember:

- when I forced the NVM update path in the driver, the device would work,
- after the reboot the checksum was invalid again.

I'll experiment a little more and get back to you. Specifically I'll try 
to dump the NVM contents before and after running 
e1000e_update_nvm_checksum and after a reboot.

Maybe the "shadow RAM" was correctly updated, but the change was 
(silently?) not persisted due to the security change you mention:

> From what we know, the Latitude E5420 is 11th Gen Intel CPU (Tiger Lake).
> Starting from this generation, a security change makes it impossible for 
> software to write to the I219 NVM.


> From a technical perspective, your patch looks correct. However, if the 
> checksum validation is skipped, there is no way to distinguish between 
> the simple checksum error described above, and actual NVM corruption, 
> which may result in loss of functionality and undefined behavior.

The distinction between checksum error and corruption will be performed 
by sufficiently privileged user, who must set the properly marked flag 
in the driver in order to do so. Is it more "insecure" than disabling 
NVM write protection (flag above)?

Note that I am not the only one with this issue...

Precision 7560 (also 11th gen):
https://www.dell.com/community/en/conversations/precision-mobile-workstations/precision-7560-e1000e-module-error-the-nvm-checksum-is-not-valid/647f9784f4ccf8a8dea83444

Latitude 5420 (same as mine):
https://forums.linuxmint.com/viewtopic.php?t=412046
https://bbs.archlinux.org/viewtopic.php?id=269606
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2102113
https://community.tanium.com/s/question/0D5RO00000Chk2S0AR/tanium-provision-dell-latitude-5420-onboard-nic

EVGA Z590 mainboard:
https://www.linux.org/threads/getting-intel-i219-v-to-work-in-debian-12.45761/

I am quite sure that Dell nor other manufacturers won't do anything with 
it...

I'm also interested in how the Windows driver works around such an issue.


 > This means, that if there is any functional issue with the network
 > adapter on a given system, while checksum validation was suspended by
 > the user, we will not be able to offer support

Is completely non functional adapter (as mine) covered by this support 
promise?


Wrapping up: if nothing else works, what would you see as a possible way 
forward?

1. This flag.

2. Option to override the checksum value (compare with a given value 
rather than ignoring it completely).

3. Option to force NVM update (provided that my tests will show that it 
works - even if only until a reboot).

-- 
Best regards,
   Jacek Kowalski


