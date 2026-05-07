Return-Path: <netdev+bounces-285200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHvYA+ta/GndOQAAu9opvQ
	(envelope-from <netdev+bounces-285200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:27:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1784E5DCB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB430305433D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89AD3AC0F4;
	Thu,  7 May 2026 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muZWP+WJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8983B8D75;
	Thu,  7 May 2026 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144623; cv=none; b=V9bDxKHUeX6UEoboASVi3X9gcOW14SO37y8RFEwMp017BpOCaRT9hOxquuYpVcuCm0SDU827NLlLipECZhFp/NhSybxJJutCRPvcRu4jRRa7Asya3nr4yRnqKhbEezNR1EjQnmCrsPDhgP1y/xb9SLoEjdDIHBRmgnbNGTd7xPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144623; c=relaxed/simple;
	bh=aurcqTPVlJK1XP/Fw5vujWYHj35MrZbEoEPPhpC6Ris=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op1XO1wrCmMdBs003SAyFyfr6Wo3Xw762Nvj4suq6dysZ4fl0JmH6JEqoHqNs71rw3EMIL0Xzd8V/hcLd9diXycKEImlw0bf5OHdDtsfw4+FnJLo64mtgPT/l8loBF0G1F1wRaW89uSXGF7f9UBml7RdAa79RaE6enJtk7wbxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muZWP+WJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778144615; x=1809680615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aurcqTPVlJK1XP/Fw5vujWYHj35MrZbEoEPPhpC6Ris=;
  b=muZWP+WJ6Ky4sKD1adYuz8UWPUqX91IvIQgjL+4O4vhElJ8DysJpN+hq
   yUFDNeX2kbv1N+EvemYKzuvW3iy+4F8Kn5a09wSSj/7ZIk6wIqwKt6Dq+
   N25SJhGkq+HnYQ8JWxCKjDlBNU/R7ZOJtTNhojP7iYPV3203ls8PyWYtq
   eWykQCVLm6WELVR0eH+EK4n9Ue/4Dmc/ab5XZgMXFRdmRTN5QkcdD7icr
   mVqG8GkqXSaRS8+C9xEFUM7WbgcHztJO9jIyJcyUBuooE/ETEjdCt5cng
   NKzqooS1DDVuvSYLIGijMWFygruK4dG5hNv2B+4F1NC6KpPeiSGIycz2o
   w==;
X-CSE-ConnectionGUID: bWvFJB/ARxe1o5Iicg4Q0g==
X-CSE-MsgGUID: FfhV/X6eQFCltCfFNhOUCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="96657452"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="96657452"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:03:30 -0700
X-CSE-ConnectionGUID: mE++FukbQSS5ES7bUwLzzA==
X-CSE-MsgGUID: iJ+FQYjdSGCb5bJMsnXbJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="232042918"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.83.206]) ([10.247.83.206])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:03:27 -0700
Message-ID: <78e48cc4-759f-46e1-83c7-1c9442308ae3@linux.intel.com>
Date: Thu, 7 May 2026 17:03:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 0/3] igc: add support for forcing link speed
 without autonegotiation
To: David Laight <david.laight.linux@gmail.com>
Cc: KhaiWenTan <khai.wen.tan@linux.intel.com>, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@intel.com, hector.blanco.alcaine@intel.com
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260430154105.505739ac@pumpkin>
 <63b186e0-046d-496e-8ae4-d68cd5eb5817@linux.intel.com>
 <20260506104053.7a4f5bf5@pumpkin>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20260506104053.7a4f5bf5@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5B1784E5DCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285200-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faizal.abdul.rahim@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

+ Hector

On 6/5/2026 5:40 pm, David Laight wrote:
> On Wed, 6 May 2026 14:21:59 +0800
> "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com> wrote:
> 
>> On 30/4/2026 10:41 pm, David Laight wrote:
>>> On Tue, 28 Apr 2026 14:00:06 +0800
>>> KhaiWenTan <khai.wen.tan@linux.intel.com> wrote:
>>>   
>>>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>>>
>>>> This series adds support for forcing 10/100 Mb/s link speed via ethtool
>>>> when autonegotiation is disabled on the igc driver.  
>>>
>>> I'll ask 'why' ?
>>>
>>> In particular forcing half/full duplex has always been a very good way
>>> of 'breaking' a network connection.
>>>
>>> It really is much better to restrict the advertised link modes and let
>>> the autodetect/autonegotiation logic in the phy/mac do its job.
>>>
>>> About the only think I can think of is to force 10M HDX when connected
>>> to a remote system that supports 10M/100M HDX.
>>> In that case you need to send out single link test pulses, not the
>>> burst used to identify 100M HDX, or the pattern encoded on the burst
>>> used by autonegotiation.
>>> But you need to got back to the mid 1990s to find such systems.
>>> Anything that supports FDX will do autonegotiation.
>>>
>>> 	David
>>>   
>>
>> There's a use case requested:
>>
>> Profinet Certification tool reports that forcing a link speed without
>> auto-negotiation is not working.
>> Forcing the link speed is a critical feature for the industrial automation
>> "fast-start" use case. When there is a connection lost, the system must
>> come back up as fast as possible. In PROFINET, that means to force the
>> speed and rejoin the controller loops. Without supporting forcing the speed
>> to 100M in Foxville, the certification tool would not be able to certify
>> the availability of this feature.
>>
>> I'm hoping this context is enough to justify the need?
> 
> Is auto-negotiation of the 'low' speed actually that slow?
> IIRC detecting 10G and above requires a lot of signal processing.
> But 10/100 and hdx/fdx just uses the ANAR register value sent in the
> link test pulses.
> (IIRC 1G uses the ANAR pattern, but requires extra signal processing as well.
> The higher speeds didn't exist when I was writing ethernet drivers.)
> 
> I've been on the 'wrong end' of hdx/fdx mismatches - you really don't
> want to let people get there, it is terribly confusing.
> 

Thanks for the information.

I agree that for normal Ethernet use, auto-negotiation on both link
partners is safer and avoids the issues you mentioned.

The reason for this patch is the more specific PROFINET Fast Start Up
(FSU) use case. For FSU, the requirement is different from normal Ethernet
use. It is intended for deterministic startup, for example in industrial
robot/tool-change applications.

One of the startup optimizations is to use "fixed transmission parameters"
instead of automatic detection in the profinet specification:
  https://us.profinet.com/profinet_tech/fast-start-up/

I understand your point that 10/100 auto-negotiation is faster than
higher-speed link training. I don't have a detailed timing breakdown for
the FSU case comparing 10/100 startup with auto-negotiation enabled versus
disabled, or enough visibility into the certification criteria to comment
on additional determinism requirements.

But keeping AutoNeg enabled, even with only specific speed advertised,
would not cover the same requirement.

This is only meant as an explicit link configuration for controlled
industrial deployments where both link partners are configured
consistently. It's not intended as a recommended default for general
networking.

Also, ethtool already allows users to request speed/duplex configuration
with auto-negotiation disabled, and some drivers already support this, for
example igb. This patch just reuses that existing interface and enables igc
to support the forced modes supported by this hardware.

> There actually ought to be a way of setting the auto-negotiation
> registers to 100M (HDX and/or FDX) and then transmitting as (say) 100M HDX
> even before negotiation completes.
> Then correcting hdx/fdx based on the received ANAR register.
> Or, at least, sending out an ANAR that only contains what you are using.
> 
> The problem I always had was that the actual operating mode of the phy
> wasn't in one of the standard registers.
> So if you connected to a system that didn't do auto-negotiation the
> phy would be using (say) 10M HDX, but the received ANAR register would
> still contain a value from an earlier connection.
> If the driver read that register from the phy it used the wrong duplex mode.
> (The speed for 10/100 doesn't matter, the phy clocks the interface to the
> mac at the right speed and the mac doesn't care.)
> 
> 	David
> 
> 
> 
> 
> 


