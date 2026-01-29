Return-Path: <netdev+bounces-254938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMekL7Dge2lyJAIAu9opvQ
	(envelope-from <netdev+bounces-254938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:35:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EF0B5669
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 531BE303466D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A977C366571;
	Thu, 29 Jan 2026 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+TL5o0a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4/+eD8Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678C35DD19
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725858; cv=none; b=jPHIT1NQS/Cf0MYsDBCh3atXhXxt2JFMLYIeMQtFjv/nZIHuQ6Ysm8WqNUWnMrIvzEJWGdFuN/DPJp058Bg5dBfq8AXU3iEMU5njK0RosbxX1FI3ZtjKbav9wCRulFG/j00Oz0wqvO+9Em7Mq0h5dxCLGHwwJr9T0e/50vH1rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725858; c=relaxed/simple;
	bh=fvSTzBiE8NLPO9EJ2v3UadUTQjAub1kStG5sbI5j4FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMy3sZoy0O6oEal/IRt4LAbR7wDxm65ca64iHJj200a9g/Hge8y1Ub0/pE+qoo3+vfiu1v5+msEasnagrXwclIGcdDDKitYehRI2ZPTgrwQAq2qlO57u1uTUtQEHriOGTHp+5ksIr+la2JYVf+6n7hAUyEIaaJo2FppZdgZuEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+TL5o0a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4/+eD8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769725855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HISVrISF5RMSZoDqWrQf2bDEMP3jBXDbMHTqhsJe8fY=;
	b=f+TL5o0a46mgc4ylCflgFG61OSDF4hOf+HLOseND7//G+e1ITZj4I/qBzgTGLI0i+XPgXD
	//9CgMrLsALG2EbE/nTisxltWl/d2Cqf2WXm1jVTwUlFbiVo+KmNWMGgok5DM4XzCHUU0b
	/StqVun7Y+0wufJpTd1u50Cm9Lu1IC4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-0ZF_JmmsMPaX03ArWyhY8g-1; Thu, 29 Jan 2026 17:30:54 -0500
X-MC-Unique: 0ZF_JmmsMPaX03ArWyhY8g-1
X-Mimecast-MFC-AGG-ID: 0ZF_JmmsMPaX03ArWyhY8g_1769725853
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4802bb29400so21054295e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 14:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769725853; x=1770330653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HISVrISF5RMSZoDqWrQf2bDEMP3jBXDbMHTqhsJe8fY=;
        b=b4/+eD8QppESym2gF99/xM5hPogZ2C+l6tFdieHUVvf+B+8E1aqrfmdY0p8WG/jfGG
         I45ZGcbwPm2NexgQy4WpDxApmiLt59T+FYafVGJtw441nb2Q2AXVGwhYIRAWHa7VTH2f
         dSLbpROrqUY61Mib9kYrdRiVijeRnsFlOgr4U84f5vQMXnOhk7UeuBky1ffcZLi8Kalm
         ba6WNDo2G9ls12c0lt6gTIEz9swR3dIXjEGCW6jrMBycS+8ehl0Z35ahqqeKiIV+5euO
         FEya9J02WLfW5uVcEUdhZ5r2ODTOXMjfDAaVe5kql05w+0k4909/AFfQVpLbGJBtIaFJ
         +uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769725853; x=1770330653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HISVrISF5RMSZoDqWrQf2bDEMP3jBXDbMHTqhsJe8fY=;
        b=pfVfKa8pJ7KxktTVvz8RsarHPJpEKjB+xDyo6G9t4jZzpy/ndCXD13x+Qzt0nk6W+s
         GdzzzowxKlgcc3UL91lPGhP1Qas3ujDhOGWitQpM8ujY0R1FRJN7xp/OxnDqXYZvik0v
         a6Kk8SBE8jI4rzQ948oDzFw5c1GunzmufHqL7iHTyQ+WdfT/a7xv21LiBN6g8yvEuEww
         7awkNjLh8jtjd3qq0tnh+mcDCKqAP91uMZhjRJ/0be0Auye9JuV7gg2BRcYmg74hQW8Y
         8jwYVcZSHiQ4Yfk3PbtOlrZ7ZIYsxt/QDLP70EBSJBHkME5TO2d1+tG1fC90eMaQ8OUn
         S6Kw==
X-Gm-Message-State: AOJu0YwtpQrL9ONSNdYEjXYrtcL0eMcU6X6qIgcfWqhwsUMp9nY8wKQs
	p5E6vIyKzs0k6dymBFSlMiTW2R8Cj/zeBpWAbq9CYkgGKf1CQ3QNfQVvgg4IDsnfMSDGOKndmr4
	1HYHobx/nt3Cy7aYgRn+pd9rirAdDlsJEKirg4S3kAoKhdCoE3ysV87zfLw==
X-Gm-Gg: AZuq6aLr86HeoMzUQcv+r8rAj9o3qhTeARm6lsdYNvqnZ9hLkf++uzHX8suLPSUe//2
	J/rpV2CDX6bIXRYLYWX6Du4z2pzb4nL2rRamkOorZiPtNLf8a5ZMZa25z6Mju/3DpgIwBIGPQA+
	mNPyZHeb5y09L3sz8udW6lenJFr+bdadlT2Un72SHazzi7YqChcoHY/MNSftaXc4yaXn40CnwHH
	jXNagVcPwUZNAykHVRq0EBzTpPGdOMvAxbV8U7wNX/nx12KMWlTTkuUJ60oTF2Yna/luP1YRxUu
	t05eb2EcytUjoq/LEbhg2yVTZp9SKoI8vXy6XjPorUbq205GEdhlfq4kUWMYU5wONZ/6mRr+JWS
	+GPHa4a5q
X-Received: by 2002:a05:600c:8b42:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-482db49728bmr6339955e9.32.1769725852812;
        Thu, 29 Jan 2026 14:30:52 -0800 (PST)
X-Received: by 2002:a05:600c:8b42:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-482db49728bmr6339665e9.32.1769725852329;
        Thu, 29 Jan 2026 14:30:52 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm196670045e9.5.2026.01.29.14.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 14:30:51 -0800 (PST)
Message-ID: <5db7d6b4-5aa4-409d-a21b-51ed8c56ccb7@redhat.com>
Date: Thu, 29 Jan 2026 23:30:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: fix PTP use-after-free during
 reset
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, ivecera@redhat.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org
References: <20260129095723.7269-1-poros@redhat.com>
 <f5759be2-f48b-4a0e-afdf-38a201fa29be@molgen.mpg.de>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <f5759be2-f48b-4a0e-afdf-38a201fa29be@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,intel.com,gmail.com,google.com,lunn.ch,kernel.org,davemloft.net,lists.osuosl.org];
	TAGGED_FROM(0.00)[bounces-254938-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email]
X-Rspamd-Queue-Id: 24EF0B5669
X-Rspamd-Action: no action


On 1/29/26 22:48, Paul Menzel wrote:
> Dear Petr,
>
>
> Thank you for the patch.
>
> Am 29.01.26 um 10:57 schrieb Petr Oros:
>> Commit 7c01dbfc8a1c5f ("iavf: periodically cache PHC time") introduced a
>> worker to cache PHC time, but failed to stop it during reset or disable.
>>
>> This creates a race condition where `iavf_reset_task()` or
>> `iavf_disable_vf()` free adapter resources (AQ) while the worker is 
>> still
>> running. If the worker triggers `iavf_queue_ptp_cmd()` during 
>> teardown, it
>> accesses freed memory/locks, leading to a crash.
>
> Do you have a stacktrace, and could you add an excerpt, so people 
> hitting this, can more easily find the commit?

I have some stack traces. The problem is that the race window is so wide 
that it sometimes crashes in the PTP subsystem, looking like:

[ 5611.939379] Call Trace:
[ 5611.941831]  <TASK>
[ 5611.943937]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 5611.948295]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 5611.952656]  ? ptp_aux_kworker+0x1d/0x40
[ 5611.956584]  ? __die_body.cold+0x8/0x12
[ 5611.960422]  ? page_fault_oops+0x148/0x160
[ 5611.964520]  ? exc_page_fault+0x73/0x160
[ 5611.968445]  ? asm_exc_page_fault+0x26/0x30
[ 5611.972634]  ? __pfx_ptp_aux_kworker+0x10/0x10
[ 5611.977082]  ? __pfx_ptp_aux_kworker+0x10/0x10
[ 5611.981525]  ptp_aux_kworker+0x1d/0x40
[ 5611.985278]  kthread_worker_fn+0xa0/0x260
[ 5611.989291]  ? __pfx_kthread_worker_fn+0x10/0x10
[ 5611.993911]  kthread+0xfd/0x240
[ 5611.997056]  ? __pfx_kthread+0x10/0x10
[ 5612.000809]  ret_from_fork+0x34/0x50
[ 5612.004386]  ? __pfx_kthread+0x10/0x10
[ 5612.008140]  ret_from_fork_asm+0x1a/0x30
[ 5612.012069]  </TASK>

  and other times in iavf, looking like:

3476.640150] Call Trace:
[ 3476.642597]  <TASK>
[ 3476.644702]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 3476.649062]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 3476.653420]  ? mod_delayed_work_on+0x9f/0xb0
[ 3476.657691]  ? __die_body.cold+0x8/0x12
[ 3476.661530]  ? page_fault_oops+0x148/0x160
[ 3476.665629]  ? exc_page_fault+0x7f/0x150
[ 3476.669556]  ? asm_exc_page_fault+0x26/0x30
[ 3476.673743]  ? __queue_work.part.0+0x44/0x320
[ 3476.678100]  ? __pfx_ptp_aux_kworker+0x10/0x10
[ 3476.682547]  mod_delayed_work_on+0x9f/0xb0
[ 3476.686647]  iavf_send_phc_read+0xb0/0xd0 [iavf]
[ 3476.691283]  iavf_ptp_do_aux_work+0x39/0x50 [iavf]
[ 3476.696083]  ptp_aux_kworker+0x1d/0x40
[ 3476.699835]  kthread_worker_fn+0xa3/0x260
[ 3476.703848]  ? __pfx_kthread_worker_fn+0x10/0x10
[ 3476.708465]  kthread+0xfa/0x240
[ 3476.711613]  ? __pfx_kthread+0x10/0x10
[ 3476.715365]  ret_from_fork+0x34/0x50
[ 3476.718943]  ? __pfx_kthread+0x10/0x10
[ 3476.722695]  ret_from_fork_asm+0x1a/0x30
[ 3476.726622]  </TASK>

, etc.

>
>> Fix this by calling `iavf_ptp_release()` before tearing down the 
>> adapter.
>> This ensures `ptp_clock_unregister()` synchronously cancels the 
>> worker and
>> cleans up the chardev before the backing resources are destroyed.
>>
>> Fixes: 7c01dbfc8a1c5f ("iavf: periodically cache PHC time")
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c 
>> b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> index 4b0fc8f354bc90..0dd58ce5a53ab1 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> @@ -3025,6 +3025,8 @@ static void iavf_disable_vf(struct iavf_adapter 
>> *adapter)
>>         adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
>>   +    iavf_ptp_release(adapter);
>> +
>>       /* We don't use netif_running() because it may be true prior to
>>        * ndo_open() returning, so we can't assume it means all our open
>>        * tasks have finished, since we're not holding the rtnl_lock 
>> here.
>> @@ -3200,6 +3202,8 @@ static void iavf_reset_task(struct work_struct 
>> *work)
>>       iavf_change_state(adapter, __IAVF_RESETTING);
>>       adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
>>   +    iavf_ptp_release(adapter);
>> +
>>       /* free the Tx/Rx rings and descriptors, might be better to just
>>        * re-use them sometime in the future
>>        */
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
>


