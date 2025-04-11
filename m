Return-Path: <netdev+bounces-181841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4DA8690B
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930A946783C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464272BD5A4;
	Fri, 11 Apr 2025 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="hAJKhcMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DA2BD5A2
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413264; cv=none; b=UPfGFlgWnc+gWCvJE9lxiFnn/s77YfCLFHHamXnHpA1LQz2/ockw/iOc348VryKbHqFIhcdt7BM0Yz3enZffxi7TkN2nm/X1UM6K+TcIhrxdXr6XE07IQzOpmojgGJtQTQhqF08CXIITm47PmbQNq3qnOI0Rm9Q0s/rc384zNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413264; c=relaxed/simple;
	bh=5+IYzvxdGiVJBQrU6OvpI8zkSDj8uS4VrXAb+7K70s4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gSgouo4+1ZoWxjDWdNiNA+gB0fKJ8ZziKqwAzIT53Jwf9719tBdHiQTf8kM/bmzYeYGfr4qiRTfxAyfUjn+GOGD3wr20p6DVo/nMMxl0EVN+leoOUwP80cEhqURAGhm8y2bRMjvWcnL9FvNYf5g4iMRPL859C6YrABd5L1a6xiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=hAJKhcMS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so431338266b.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1744413259; x=1745018059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L7gZ2a4kNRAu7jwQR+r8fyDCj7+uKKM15SUMg3PT2KM=;
        b=hAJKhcMSpno0bnTzg0oOR85rz8Lo1KK1HWvajM20l00m+olMNBlOVchTVMEmTEcdEv
         w4lD022cZurW4RBK9m0E33cg8lf9UE/qZDq9zObzs1HciU2qXzuD0Vw5M+YuALbhJ3Ec
         H/Im/ArWpMlck5FPZ+BSddiLr7wN6PradrEBmYrK9wDZAkIhfEdOQ+CRy69NIMXj2ugA
         YL4AVMtvTxwbWw24nDVv/ng+6Vucu5/HF33lhtUztkErXxtBRoqXsJkFQXqZJzJOQssR
         906bOOfKMjrUB2uRWvCHCqbpjtMAg/hC4j1Ayn1o6FZtx4JQNxy0UzCzxuEKbYxQQepp
         vrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413259; x=1745018059;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7gZ2a4kNRAu7jwQR+r8fyDCj7+uKKM15SUMg3PT2KM=;
        b=kyopUBXxZBzw7QfkPL5YDjlCPC8AYcwwIAcuApOIW7+XXs5W8WGnc1HkOOErMMxfB4
         p44ooBessmQLhOh1tUCDCXcRXJS9z65shICb1QxqQvd0eO5rzlagxdh8Nxn5Wl5Sn1dF
         5OxQB0LFWPCNeirqJ161c8ebDvNsuJv6VL+9FtxIroOtvU82XQTidD9BjOr08i7lZgm/
         KtZsKAyAtqSU8RLBMZej31BNo6txAkAuICNz46KTWdLpR5pcipK8PdhXJBjJ97IGZwG6
         JqcjAlIL2245I1xiE0sN9wN1+LI/zzAnscvpSxMPwe2WCgNuQfkUdNOjUTjlxxjT6dYU
         R+ww==
X-Forwarded-Encrypted: i=1; AJvYcCWM1OTsFxMmm750VKiSLvouXgJofviH7HCG4W1rJ4kSBA0NSKSvSyxz/93gx5N3R3S5ZTv65Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJ4KxIl9hLQgAHA8eDKHMn1XKkB6VptgjfHy3BtRm3s7G80so
	fSpQrc+m7/C3evGio6VTTtwP+KrAWSEhQ+lHs1qI+IOKVX0iAzlWxwl4txbVjA==
X-Gm-Gg: ASbGncub4NXMHG50cBTcNEFc3OxQt3jq81AFSihyomxeLA1UL4IenoSgK+FySd1GNXh
	Mo+NQsKLegtty6bnyCYYW2AstwRGQpNfgwDzaBDqSl6adY9gG1xPvPkFGBG+yeps9P84lbk07c+
	Wb1GYHdc3tkW0vj52kRFWCRvMjUQWBoxKgZiTS1uoKNE9/zZJaGXZV8c1UnCQ2XSYSY2IHyZHsW
	mPzA6qm5EZNDvg88n0n96xc+ryY+xcBAn+l3vkKXuNtr5PpvXU7mAb4wEILwIw/b5G4HSZYxlVq
	a9fi1Agjr3IpnRCztnn0JheIFoxsboqMGWuIpBMB/innkon2VQ==
X-Google-Smtp-Source: AGHT+IEvy6kgULlZZh+g/Jo9ZEWmTjrbZlUGLIqKPnfHXoHdBf0RzSc9G7gT62xhdLc+tXmoYTQ/WQ==
X-Received: by 2002:a17:906:f58d:b0:aca:a1de:5e62 with SMTP id a640c23a62f3a-acad359505amr320916466b.42.1744413259061;
        Fri, 11 Apr 2025 16:14:19 -0700 (PDT)
Received: from [10.2.1.132] ([194.53.194.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4104sm513940666b.99.2025.04.11.16.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 16:14:18 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <1c4b00b6-f6e3-4b04-a129-24452df60903@jacekk.info>
Date: Sat, 12 Apr 2025 01:14:17 +0200
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
 <a6d71bdc-3c40-49a1-94e5-369029693d06@jacekk.info>
 <ca5e7925-1d75-5168-2c54-1f4fa9ef523e@intel.com>
Content-Language: en-US
In-Reply-To: <ca5e7925-1d75-5168-2c54-1f4fa9ef523e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I'll experiment a little more and get back to you.>> Specifically I'll try to dump the NVM contents before
>> and after running e1000e_update_nvm_checksum and after
>> a reboot.

I finally had a moment to take a look at the issue again.

This change also makes everything work on my system:


diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 364378133526..4538059091e6 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4266,7 +4266,7 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
         if (!(data & valid_csum_mask)) {
                 e_dbg("NVM Checksum valid bit not set\n");
  
-               if (hw->mac.type < e1000_pch_tgp) {
+               if (hw->mac.type <= e1000_pch_tgp) {
                         data |= valid_csum_mask;
                         ret_val = e1000_write_nvm(hw, word, 1, &data);
                         if (ret_val)


(the modification is not persisted - it is lost even after rmmod/insmod).

The diff between "before" and "after" NVM rewrite looks like this
(MAC address masked):

< 0x0000:               XX XX XX XX XX XX 00 08 ff ff 84 00 01 00 70 00
---
> 0x0000:               XX XX XX XX XX XX 01 08 ff ff 84 00 01 00 70 00 
10c10
< 0x0070:               ff ff ff ff ff ff ff ff ff ff 00 02 ff ff fe 36
---
> 0x0070:               ff ff ff ff ff ff ff ff ff ff 00 02 ff ff fd 34



Reading https://bugzilla.kernel.org/show_bug.cgi?id=213667 the issue
started with yet another Dell system, Precision 7760, locking itself
up with such modification.

The "fix" (4051f68318: e1000e: Do not take care about recovery NVM checksum)
fixed some problems (i.e. Precision 7760) and "broke" some configurations
(i.e. mine Latitude 5420).

The condition itself was changed once already (ffd24fa2fc: e1000e: Correct
NVM checksum verification flow).


> If this approach is acceptable to you, I will prepare a patch with
> the proposed fix and send it to you next week for testing on your system.

What solution do you have in mind?

The only one I can think of is to ignore the checksum completely if the
valid_csum_mask condition is not met on e1000_pch_tgp.

-- 
Best regards,
   Jacek Kowalski

