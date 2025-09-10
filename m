Return-Path: <netdev+bounces-221604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B94B5123C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9533BB601
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716742571BD;
	Wed, 10 Sep 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EKkE1gUL"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED627453
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495748; cv=none; b=ImM+ASV7lATLnFxVZUs6c+AdIqLc3qEtY7J09qJz3EdwKs2Ayg6lDq/gONaHqdg0SJUM+ez6KK6nOgnT4Aj5qrASGJshyqEMjwYGYivMd31BfHI07jU0VZV8sLzinvDT9Zn3Goxyv+8eQWO0BXsBhPl1I9Suf5zQlh5nqcQfQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495748; c=relaxed/simple;
	bh=FgUmNcKkTadLnkgxquHJqKdkFvyESZK0/ysiYkDaymw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQa0lTdSDAAgCbcl9lS2Qh5bTGFJmsuJYB+1qml8sU/4tNL8NhS1fnPV14hv7xDrbcL/7MIaQhAVvQlCnYX2wDLTZfI742BHGC4q3RC+S63gChffm9KFzhQy99CB3bzhqpQ/EoqOIdKi1jlhyOx63edumkfX3EQhqL330WJLu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EKkE1gUL; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757495746; x=1789031746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cxwgbzB+J6Da8bnPc7iRAfrv9EegcpSX9fIqrctUExo=;
  b=EKkE1gULGRgaqD1ohhjGYHjTrPdmOY+5iBV/8h0wR3Dk70wsiyV+Q3xe
   G4C/BrkMU08DKSQusNimRSno5Ejvi6dips9BSh6xgBJxKQivC45OrwNFQ
   wSbd+eXoajZZFgKr0eXWsou80e6LUtdzBdZcQBDwO/hqNIyNkrvsyM3i4
   Ga2ZBo9E20iYUuBWxhC+hINuxrVGLenm9WU3pNIsKSQ/JYoRFVOf1VJSA
   HiFj152+xXp7m632SsAlkGUboXq6Utdye2PSGx7oNUuXZ1V0wEm0URCz5
   ECDmVEgScESzVw/HsLH+QEOmfu0InpErrTr1YvVC9CcgxCV3AftV/8M0g
   Q==;
X-CSE-ConnectionGUID: pzWfVioZRL+hiEPa1AikyQ==
X-CSE-MsgGUID: Ccsl+rumQKe/qGtw97kiNA==
X-IronPort-AV: E=Sophos;i="6.18,253,1751241600"; 
   d="scan'208";a="2752247"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 09:15:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:54368]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.90:2525] with esmtp (Farcaster)
 id 3b4f621e-84c4-486a-a0fa-91d03b04897d; Wed, 10 Sep 2025 09:15:42 +0000 (UTC)
X-Farcaster-Flow-ID: 3b4f621e-84c4-486a-a0fa-91d03b04897d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 09:15:42 +0000
Received: from b0be8375a521.amazon.com (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 09:15:39 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <kurt@linutronix.de>
CC: <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<enjuk@amazon.com>, <intel-wired-lan@lists.osuosl.org>,
	<kohei.enju@gmail.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<vitaly.lifshits@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igc: unregister netdev when igc_led_setup() fails in igc_probe()
Date: Wed, 10 Sep 2025 18:15:21 +0900
Message-ID: <20250910091532.27951-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <87cy7yk7ma.fsf@jax.kurt.home>
References: <87cy7yk7ma.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 10 Sep 2025 10:57:17 +0200, Kurt Kanzenbach wrote:

>On Wed Sep 10 2025, Kohei Enju wrote:
>> + Aleksandr
>>
>> On Wed, 10 Sep 2025 10:28:17 +0300, Lifshits, Vitaly wrote:
>>
>>>On 9/8/2025 9:26 AM, Kurt Kanzenbach wrote:
>>>> On Sat Sep 06 2025, Kohei Enju wrote:
>>>>> Currently igc_probe() doesn't unregister netdev when igc_led_setup()
>>>>> fails, causing BUG_ON() in free_netdev() and then kernel panics. [1]
>>>>>
>>>>> This behavior can be tested using fault-injection framework. I used the
>>>>> failslab feature to test the issue. [2]
>>>>>
>>>>> Call unregister_netdev() when igc_led_setup() fails to avoid the kernel
>>>>> panic.
>>>>>
>>>>> [1]
>>>>>   kernel BUG at net/core/dev.c:12047!
>>>>>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>>>>   CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
>>>>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>>>>   RIP: 0010:free_netdev+0x278/0x2b0
>>>>>   [...]
>>>>>   Call Trace:
>>>>>    <TASK>
>>>>>    igc_probe+0x370/0x910
>>>>>    local_pci_probe+0x3a/0x80
>>>>>    pci_device_probe+0xd1/0x200
>>>>>   [...]
>>>>>
>>>>> [2]
>>>>>   #!/bin/bash -ex
>>>>>
>>>>>   FAILSLAB_PATH=/sys/kernel/debug/failslab/
>>>>>   DEVICE=0000:00:05.0
>>>>>   START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
>>>>>           | awk '{printf("0x%s", $1)}')
>>>>>   END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))
>>>>>
>>>>>   echo $START_ADDR > $FAILSLAB_PATH/require-start
>>>>>   echo $END_ADDR > $FAILSLAB_PATH/require-end
>>>>>   echo 1 > $FAILSLAB_PATH/times
>>>>>   echo 100 > $FAILSLAB_PATH/probability
>>>>>   echo N > $FAILSLAB_PATH/ignore-gfp-wait
>>>>>
>>>>>   echo $DEVICE > /sys/bus/pci/drivers/igc/bind
>>>>>
>>>>> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
>>>>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
>>>> 
>>>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>>>
>>>Thank you for the patch and for identifying this issue!
>>>
>>>I was wondering whether we could avoid failing the probe in cases where 
>>>igc_led_setup fails. It seems to me that a failure in the LED class 
>>>functionality shouldn't prevent the device's core functionality from 
>>>working properly.
>>
>> Indeed, that also makes sense.
>>
>> The behavior that igc_probe() succeeds even if igc_led_setup() fails
>> also seems good to me, as long as notifying users that igc's led
>> functionality is not available.
>
>SGTM. The LED code is nice to have, but not mandatory at all. The device
>has sane LED defaults.

Thank you for clarification.
I'll do like that in v2.

>
>>
>>>
>>> From what I understand, errors in this function are not due to hardware 
>>>malfunctions. Therefore, I suggest we remove the error propagation.
>>>
>>>Alternatively, if feasible, we could consider reordering the function 
>>>calls so that the LED class setup occurs before the netdev registration.
>>>
>>
>> I don't disagree with you, but I would like to hear Kurt and Aleksandr's
>> opinion. Do you have any preference or suggestions?
>
>See above.

Got it :)

>
>Thanks,
>Kurt

