Return-Path: <netdev+bounces-108315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D20E91ECF7
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 04:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C7D1C2168A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435AED52A;
	Tue,  2 Jul 2024 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2Li7dud"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD5B674;
	Tue,  2 Jul 2024 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719887342; cv=none; b=La9muTq0yofjujU5fagdnuACX4GfWWDuwNgWMt+CsdIF4PBAkbfx4nmhMch2RH1a/Dmg8nJ8nuUZ/lNtZi7XTWskd2CDRcPFVY5RTIMUraRLMLsCjoj7dvoQw4ZirZ5ZXW/A0OTCP5kyYxdphPS6ScsGtQYJQRwPXvvL/EIFREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719887342; c=relaxed/simple;
	bh=j8d61EAjQsOLrMk5eu64iDHSBTUZUUS3SPJgXhshpLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUu9VrF1EJlO32MlG0j9z+JHrpQaLZCd0qEq2dpSeMODi/wvpSgGXhw/XcCrGzAt8Qibuq/kuiF7u/DaAcZ1vgcUkpAgy/qVJFC01WQnwRbHIf2nF37SAi26jKM6cjsAPJUnIcmp+ni3HL8s7iJBsczs+9gJPfRsWHD3Ot52hXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2Li7dud; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719887340; x=1751423340;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j8d61EAjQsOLrMk5eu64iDHSBTUZUUS3SPJgXhshpLI=;
  b=W2Li7dud5EApdCzB4pDNcqLJxQUrMaokJGZBgeFkGL7CkX9A2G4zMf5C
   +m8hTwxrfkgnk7CYSp/DzYp71ERgt/bMlgWC70sRbl0cwtxEAk6TDjePd
   g3k3gu1kWlv7YqQTUBnUox+IGJvt8sPMFB+PwZ1NqXodeN3IJyekfNtDA
   oRgQSQoVFzXZGQWCrrhEojRc/w8BKsmoCAylRMU67Zf6W7Rq38DevqFYl
   o4AW75s9ktpaBL5czU1+XKfvQT8dmJ9A+BNzRJXSKUlwAI+D/bsoHF/3G
   OXHrtdzzN+My6MERGCkKcsIqDnobfNUnTKPZGgIwrwdL/K8vx1llQ5L7c
   A==;
X-CSE-ConnectionGUID: evICt6qjQYOME1ck7GWacg==
X-CSE-MsgGUID: vnR+8lW+Tumy3cFpur7OGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16882760"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16882760"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 19:28:59 -0700
X-CSE-ConnectionGUID: ttmgwcqDTPyxr2a52EQCRw==
X-CSE-MsgGUID: /5JFrGbGTzOTE/cOJp2txg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="68946742"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.38.161]) ([10.247.38.161])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 19:28:58 -0700
Message-ID: <26d42742-d9bd-4817-8a08-94b12598fe4c@linux.intel.com>
Date: Tue, 2 Jul 2024 10:28:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Fix packet still tx
 after gate close by reducing i226 MAC retry buffer
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20240701100058.3301229-1-faizal.abdul.rahim@linux.intel.com>
 <e981261e-77be-407b-b601-f7214a4f57dd@molgen.mpg.de>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <e981261e-77be-407b-b601-f7214a4f57dd@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/7/2024 8:42 pm, Paul Menzel wrote:
> Dear Faizal,
> 
> 
> Thank you for your patch.
> 
>> This follows guidelines from:
>>
>> a) Ethernet Controller I225/I22 Spec Update Rev 2.1 Errata Item 9:
>>     TSN: Packet Transmission Might Cross Qbv Window
>> b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
>>
>> Test Steps:
>> 1. Send taprio cmd to board A
>> tc qdisc replace dev enp1s0 parent root handle 100 taprio \
>> num_tc 4 \
>> map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
>> queues 1@0 1@1 1@2 1@3 \
>> base-time 0 \
>> sched-entry S 0x07 500000 \
>> sched-entry S 0x0f 500000 \
>> flags 0x2 \
>> txtime-delay 0
>>
>> - Note that for TC3, gate opens for 500us and close for another 500us
>>
>> 3. Take tcpdump log on Board B
>>
>> 4. Send udp packets via UDP tai app from Board A to Board B
>>
>> 5. Analyze tcpdump log via wireshark log on Board B
>> - Observed that the total time from the first to the last packet
>> received during one cycle for TC3 does not exceed 500us
> 
> Indent the list item by four spaces? (Also above?)


Hi Paul,

Would like to confirm, the indent suggestion from you is referring to which 
style ?

(a)
1.  Send taprio ...
     tc qdisc  ..
     map 3 4 ..
     queue 1@0 ....

(b)
1. Send taprio ...
     tc qdisc  ..
     map 3 4 ..
     queue 1@0 ....

(c)
     1. Send taprio ...
        tc qdisc  ..
        map 3 4 ..
        queue 1@0 ....

I think it's (a), but afraid if misunderstood the suggestion.
Thank you !

Regards,
Faizal

