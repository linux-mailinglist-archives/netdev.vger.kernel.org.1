Return-Path: <netdev+bounces-123215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4114C96425F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6555A1C24A52
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4218F2F9;
	Thu, 29 Aug 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UNCwtkzn"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99FE18FDBA
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928876; cv=none; b=h4htB/VUzSI7RIghs2CI+3rhdct2EpMiV+X+mGfJ6PsBw/pwkmscXs3gQDhmhfDhklbMVlA5Os17EgBq7fl1NrE7AFy8Er99EDICo+UxSDk4D6IcFJI5u6r/XH7WubLGEPmGZebmWavJi0jMlwERCuCoPruZncTzftr/ezfSK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928876; c=relaxed/simple;
	bh=/3GvnIlKIL44+b8Eth7urDfHzwACMHF9Yfg82bBR46E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LZUCrEIgRPaTZ1OSMXIauzHH3X7nhiW5cWIQibRTPSy8THqbLnrE/kqufyzgiNwJFvyY0sr+v4e9G6gTJSP63HUHt4n50Dy0xVMz+YeLwWoT6i1+SgReBpi3M8ZPnbWZwyoMG/RM7yYy7mVUQ9rod7WLDvp7C77iGn7xp9xk5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UNCwtkzn; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f8a8ade6-505e-4849-be30-48b18051640a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724928870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0HVq9wGSQJZcApv3C9m1Tfxb6vqgR0cwGhRbtATvVY=;
	b=UNCwtkzn5vEAIaYuvwq10khnxeY34pLIxHbJLCzDx1UffDSAvYLH9mt9FORouZ1Ic5x0zO
	kfBMXZBmJu/Von9obPdT6uEM5coYYrR5cc1SEK41FZ+v8k+yXL0scG9aWSkYFTPuhxVz3I
	APcpf8+0BkO5OAYjT3npLStXV/p0jUU=
Date: Thu, 29 Aug 2024 11:54:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Mahesh Bandewar <maheshb@google.com>,
 Mahesh Bandewar <mahesh@bandewar.net>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
 Eric Dumazet <edumazet@google.com>, Netdev <netdev@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Sagi Maimon <maimon.sagi@gmail.com>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240502211047.2240237-1-maheshb@google.com>
 <e56a994e-e329-4cac-9fff-e57139408769@linux.dev>
Content-Language: en-US
In-Reply-To: <e56a994e-e329-4cac-9fff-e57139408769@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 22/08/2024 13:26, Vadim Fedorenko wrote:
> On 02/05/2024 22:10, Mahesh Bandewar wrote:
>> The ability to read the PHC (Physical Hardware Clock) alongside
>> multiple system clocks is currently dependent on the specific
>> hardware architecture. This limitation restricts the use of
>> PTP_SYS_OFFSET_PRECISE to certain hardware configurations.
>>
>> The generic soultion which would work across all architectures
>> is to read the PHC along with the latency to perform PHC-read as
>> offered by PTP_SYS_OFFSET_EXTENDED which provides pre and post
>> timestamps.  However, these timestamps are currently limited
>> to the CLOCK_REALTIME timebase. Since CLOCK_REALTIME is affected
>> by NTP (or similar time synchronization services), it can
>> experience significant jumps forward or backward. This hinders
>> the precise latency measurements that PTP_SYS_OFFSET_EXTENDED
>> is designed to provide.
>>
>> This problem could be addressed by supporting MONOTONIC_RAW
>> timestamps within PTP_SYS_OFFSET_EXTENDED. Unlike CLOCK_REALTIME
>> or CLOCK_MONOTONIC, the MONOTONIC_RAW timebase is unaffected
>> by NTP adjustments.
>>
>> This enhancement can be implemented by utilizing one of the three
>> reserved words within the PTP_SYS_OFFSET_EXTENDED struct to pass
>> the clock-id for timestamps.  The current behavior aligns with
>> clock-id for CLOCK_REALTIME timebase (value of 0), ensuring
>> backward compatibility of the UAPI.
>>
>> Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> 
> Hi Mahesh!
> 
> Any chance there will be v5 soon with the comments addressed?
> I don't see any strong objections to the patch, and it looks
> like we can benefit from having MONOTONIC_RAW clock for our
> project too.
> 
> Thanks,
> Vadim
> 

Hi Mahesh!

It's a gentle ping mail...
If you don't have cycles to work on this patch anymore I can jump in and
address the feedback to finally merge the feature.

Thanks,
Vadim



>> ---
>> v1 -> v2
>>     * Code-style fixes.
>> v2 -> v3
>>     * Reword commit log
>>     * Fix the compilation issue by using __kernel_clockid instead of 
>> clockid_t
>>       which has kernel only scope.
>> v3 -> v4
>>     * Typo/comment fixes.
>>
>>   drivers/ptp/ptp_chardev.c        |  7 +++++--
>>   include/linux/ptp_clock_kernel.h | 30 ++++++++++++++++++++++++++----
>>   include/uapi/linux/ptp_clock.h   | 27 +++++++++++++++++++++------
>>   3 files changed, 52 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
>> index 7513018c9f9a..c109109c9e8e 100644
>> --- a/drivers/ptp/ptp_chardev.c
>> +++ b/drivers/ptp/ptp_chardev.c
>> @@ -358,11 +358,14 @@ long ptp_ioctl(struct posix_clock_context 
>> *pccontext, unsigned int cmd,
>>               extoff = NULL;
>>               break;
>>           }
>> -        if (extoff->n_samples > PTP_MAX_SAMPLES
>> -            || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
>> +        if (extoff->n_samples > PTP_MAX_SAMPLES ||
>> +            extoff->rsv[0] || extoff->rsv[1] ||
>> +            (extoff->clockid != CLOCK_REALTIME &&
>> +             extoff->clockid != CLOCK_MONOTONIC_RAW)) {
>>               err = -EINVAL;
>>               break;
>>           }
>> +        sts.clockid = extoff->clockid;
>>           for (i = 0; i < extoff->n_samples; i++) {
>>               err = ptp->info->gettimex64(ptp->info, &ts, &sts);
>>               if (err)
>> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ 
>> ptp_clock_kernel.h
>> index 6e4b8206c7d0..74ded5f95d95 100644
>> --- a/include/linux/ptp_clock_kernel.h
>> +++ b/include/linux/ptp_clock_kernel.h
>> @@ -47,10 +47,12 @@ struct system_device_crosststamp;
>>    * struct ptp_system_timestamp - system time corresponding to a PHC 
>> timestamp
>>    * @pre_ts: system timestamp before capturing PHC
>>    * @post_ts: system timestamp after capturing PHC
>> + * @clockid: clock-base used for capturing the system timestamps
>>    */
>>   struct ptp_system_timestamp {
>>       struct timespec64 pre_ts;
>>       struct timespec64 post_ts;
>> +    clockid_t clockid;
>>   };
>>   /**
>> @@ -457,14 +459,34 @@ static inline ktime_t 
>> ptp_convert_timestamp(const ktime_t *hwtstamp,
>>   static inline void ptp_read_system_prets(struct ptp_system_timestamp 
>> *sts)
>>   {
>> -    if (sts)
>> -        ktime_get_real_ts64(&sts->pre_ts);
>> +    if (sts) {
>> +        switch (sts->clockid) {
>> +        case CLOCK_REALTIME:
>> +            ktime_get_real_ts64(&sts->pre_ts);
>> +            break;
>> +        case CLOCK_MONOTONIC_RAW:
>> +            ktime_get_raw_ts64(&sts->pre_ts);
>> +            break;
>> +        default:
>> +            break;
>> +        }
>> +    }
>>   }
>>   static inline void ptp_read_system_postts(struct 
>> ptp_system_timestamp *sts)
>>   {
>> -    if (sts)
>> -        ktime_get_real_ts64(&sts->post_ts);
>> +    if (sts) {
>> +        switch (sts->clockid) {
>> +        case CLOCK_REALTIME:
>> +            ktime_get_real_ts64(&sts->post_ts);
>> +            break;
>> +        case CLOCK_MONOTONIC_RAW:
>> +            ktime_get_raw_ts64(&sts->post_ts);
>> +            break;
>> +        default:
>> +            break;
>> +        }
>> +    }
>>   }
>>   #endif
>> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ 
>> ptp_clock.h
>> index 053b40d642de..5e3d70fbc499 100644
>> --- a/include/uapi/linux/ptp_clock.h
>> +++ b/include/uapi/linux/ptp_clock.h
>> @@ -155,13 +155,28 @@ struct ptp_sys_offset {
>>       struct ptp_clock_time ts[2 * PTP_MAX_SAMPLES + 1];
>>   };
>> +/*
>> + * ptp_sys_offset_extended - data structure for IOCTL operation
>> + *                 PTP_SYS_OFFSET_EXTENDED
>> + *
>> + * @n_samples:    Desired number of measurements.
>> + * @clockid:    clockid of a clock-base used for pre/post timestamps.
>> + * @rsv:    Reserved for future use.
>> + * @ts:        Array of samples in the form [pre-TS, PHC, post-TS]. The
>> + *        kernel provides @n_samples.
>> + *
>> + * History:
>> + * v1: Initial implementation.
>> + *
>> + * v2: Use the first word of the reserved-field for @clockid. That's
>> + *     backward compatible since v1 expects all three reserved words
>> + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
>> + *     CLOCK_REALTIME is '0'.
>> + */
>>   struct ptp_sys_offset_extended {
>> -    unsigned int n_samples; /* Desired number of measurements. */
>> -    unsigned int rsv[3];    /* Reserved for future use. */
>> -    /*
>> -     * Array of [system, phc, system] time stamps. The kernel will 
>> provide
>> -     * 3*n_samples time stamps.
>> -     */
>> +    unsigned int n_samples;
>> +    __kernel_clockid_t clockid;
>> +    unsigned int rsv[2];
>>       struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
>>   };
> 


