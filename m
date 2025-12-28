Return-Path: <netdev+bounces-246194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E73CE56A8
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 20:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63F26300A352
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCAD278753;
	Sun, 28 Dec 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxyPoxs2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDGank/z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C4277CA5
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766951093; cv=none; b=YuyflUGH1yBSsfkmkR5oA9T8VxzrxScVEplFqSbLXKAp11hRXIGb3VsfiRz2e79jm0s6nSHqNX8kasrIGZAX+3An+ZJYH7i0eubK2kdzO2BWdqHEbetVKZcB9sDSOFlBtncIJk/8RgEZG+IZto+lt/6djfHUKH8kt/pyIg1oLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766951093; c=relaxed/simple;
	bh=blwVMnJaHbgcb2jHZU3UUYPK3eW/i3KbhdtTBPdCTI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/NpnojxV3KbDZ6Tf6pvmamupND5S1+82PdYW3ttYZ1oQuLJOkn8LLnaBl145tDUz+IGLodfpNxh1pNVb5fLnilxujIFAkE+qP8dIfwJrVhRpxLMrdqBc62E8IsYp6Y5k7Z/EC3HyO0ccIUuZBXgOi1KduMv432XOtxXSdtdrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxyPoxs2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDGank/z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766951089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHsrmxgkdvXfz64zvqevNeUhUbHKKa3CCMwcJMI2OXc=;
	b=WxyPoxs2tyzUHckVwZV+uua577iHQpKdWnAYjl1fVnllHk8UnTiBtctS1DMQn4h6dGM2MS
	dDpdlhzGpctmolbXSgWf0DJnA11qaxpifPhqMZxTcPiVVsmrj/p7aZT9LI78XbhD6sEwNL
	cDAaN/JZl4WXyD4lnI+vXaZJr6ijYo8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-IW-uP8EaOg6m8Kx8hlo3lQ-1; Sun, 28 Dec 2025 14:44:48 -0500
X-MC-Unique: IW-uP8EaOg6m8Kx8hlo3lQ-1
X-Mimecast-MFC-AGG-ID: IW-uP8EaOg6m8Kx8hlo3lQ_1766951087
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432586f2c82so4044396f8f.0
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 11:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766951087; x=1767555887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHsrmxgkdvXfz64zvqevNeUhUbHKKa3CCMwcJMI2OXc=;
        b=SDGank/zExqzxwizn66sPdNAxPw7TshKuuzKry87YfWcNOrSVq2aSq56zCn0C8KX/U
         2C3yM/Wm2SOJrlHqLVIgEC12bpAc1gEwmGx0xVwlh1gBHzHpU7dMXV/6BsgO7jYqgBV1
         J0ORL8aRxkn5mZZIM+tVrDWg45VJ9l74raJYC4l1Ah3Mt9hBoysRloL3zYLvri+EbwI9
         /bPCVLl9QN2q5oL9oHii2RMPbW+WsXXOv6DQRVmdSWDAx3iruZ+IlqCIWFBnp+Ddu1ob
         eDfMNBNq9lArqZ8Osy7E+wiuZrYOL/EN3+7w+dMaozPcLtN/p1FC/1Gt0WKykRijrv74
         MWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766951087; x=1767555887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHsrmxgkdvXfz64zvqevNeUhUbHKKa3CCMwcJMI2OXc=;
        b=IJ6pE/R1Jrql75oZGPQ3vXF1kNHObFx+UobqzOa78zj7dXBL8KXHPPJd5iicq6+jsB
         uSquK+Bwl7ZvnQ98+Su4VcV6I7rByUzmg/45oc7uhlAuOqpAPaISAXlsqE9I/gcG33+Y
         5FoefYwJF2LjAhjVqNPm3BW0t9x3az9eYDUJnue6idkrCQ2F+qX8Tpz6LKqyRpVg/amJ
         3ndmONEnevozEDYq45OxN9k88GAEt7dRgMI8qUzBnbigdPQ8oGc/QGNfIkrYcyPNkie6
         dr3iWqehqzxTzcFW2qD3WM+rK7tyI30qou8PGsnrcp7kEpvhrV1cncxGcFZb90eLrVHz
         G9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPey/emYPUP7TaCGADTPGrcVE+0zetvTA7tzntOqq0I9Sec+gNKS9FIIySSXJmqB77iWjkRcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uUV0GJHnlPFfi9j8y2zR/YAkwae3RblLwCh4ktYc28+jWYYA
	hIEPSdCdjF09uKna+RpesCSpSZpEvausrXRTd698rPO3Fwrxcu5gJbCMlnp5rDoFrFYPVXaR0Vq
	SC19WKBC3uTATFFEvo7aZo39apke8PYJhbivHfWTMXSv5lrZpPTZtzV/iHw==
X-Gm-Gg: AY/fxX7jLZCvR8OZengF/VtwOXW08PNCFLkpfUJjF0uIMjfOeduY3HcCenYtfJsWuOF
	8TTSVpdr1mCZySoNmlB4ld1WaqtRC5xlC8aIAh07tONAkuEQh49XD0mjT9jys/vbTJDMG3pJVG6
	M1LK1MVvKTpzt9AUplR2g/cI+NIR0e7YrLW8hwggiaGrLzJHlzrKGIrC/g1pqHfKTIBDtyWHySm
	NfnfczmhwL1pq61Q8T+8JG0al5mwdariHXRUJewcAsC7iKkvxXTNkFJ7m1YUe0EvghSlp9eRqym
	K1XOzh2q1kU/v+79DxklPJljfOLNrwGLzwYsGUlFDwlzCW6RQkVO035ey9mR72++VtfNSY/3t6v
	PsfmuzBcAH3skDWvGiVp3
X-Received: by 2002:adf:fcd0:0:b0:432:86de:f396 with SMTP id ffacd0b85a97d-43286def40emr6030100f8f.26.1766951087202;
        Sun, 28 Dec 2025 11:44:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJHsOScrFDpuFJ7zgwI9WOpAUYpy9EQp+yZlv92scUUdzEcD5wYEeDDQ2Cr10hpHegUM7ktQ==
X-Received: by 2002:adf:fcd0:0:b0:432:86de:f396 with SMTP id ffacd0b85a97d-43286def40emr6030086f8f.26.1766951086826;
        Sun, 28 Dec 2025 11:44:46 -0800 (PST)
Received: from [192.168.68.125] ([216.128.14.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af20sm55081905f8f.2.2025.12.28.11.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 11:44:45 -0800 (PST)
Message-ID: <ba98c377-395c-456f-afb4-c0cb50f504cf@redhat.com>
Date: Sun, 28 Dec 2025 21:44:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] i40e: drop
 udp_tunnel_get_rx_info() call from i40e_open()
To: Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com, davem@davemloft.net, aduyck@mirantis.com,
 kuba@kernel.org, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251218121322.154014-1-mheib@redhat.com>
 <e8aa1cf8-f42e-4329-8bd8-0f2c3fedde55@redhat.com>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <e8aa1cf8-f42e-4329-8bd8-0f2c3fedde55@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

HI Paolo,
Thank you for the review.

On 12/28/25 11:29 AM, Paolo Abeni wrote:
> On 12/18/25 1:13 PM, mheib@redhat.com wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> The i40e driver calls udp_tunnel_get_rx_info() during i40e_open().
>> This is redundant because UDP tunnel RX offload state is preserved
>> across device down/up cycles. The udp_tunnel core handles
>> synchronization automatically when required.
>>
>> Furthermore, recent changes in the udp_tunnel infrastructure require
>> querying RX info while holding the udp_tunnel lock. Calling it
>> directly from the ndo_open path violates this requirement,
>> triggering the following lockdep warning:
>>
>>    Call Trace:
>>     <TASK>
>>     ? __udp_tunnel_nic_assert_locked+0x39/0x40 [udp_tunnel]
>>     i40e_open+0x135/0x14f [i40e]
>>     __dev_open+0x121/0x2e0
>>     __dev_change_flags+0x227/0x270
>>     dev_change_flags+0x3d/0xb0
>>     devinet_ioctl+0x56f/0x860
>>     sock_do_ioctl+0x7b/0x130
>>     __x64_sys_ioctl+0x91/0xd0
>>     do_syscall_64+0x90/0x170
>>     ...
>>     </TASK>
>>
>> Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
>> i40e_open() resolve the locking violation.
>>
>> Fixes: 06a5f7f167c5 ("i40e: Move all UDP port notifiers to single function")
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> @Tony: I assume you prefer to take this series into your tree first.
> 
> @Mohammad: I think we don't need to packport this path in old kernels; I
> guess a better fixes tag should point to the recent udp_tunnel
> infrastructure changes.

indeed we don't need this change in the old versions.
I updated the fixes tag to:
   - Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency").
This better reflects the change that exposed the problem, even though 
the fix itself is in the driver.


> 
> Thanks,
> 
> Paolo
> 
Thanks,


