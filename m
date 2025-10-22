Return-Path: <netdev+bounces-231638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF977BFBD62
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AC61A031D5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F63342CBF;
	Wed, 22 Oct 2025 12:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EC32E142
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135951; cv=none; b=l3nuJufvBYIlBdmCPBAJOV1HnhbfrGaIGumStCfvuj0TCKwmuleKCrtUTSsLrrtHfUCmyrYTvTH3IhQVIYRXyEGGDPlLaHOm/yRTBNAW6+6uMycUuPsZEtDviaclh6p2uNO6cekH6LOxreXJeMC3fP4FGE60x8aSqfcdSXm71sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135951; c=relaxed/simple;
	bh=jLyg9N+A5uKrj1SJy5T9rDF7hoz761qWAi3Nlg4joC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX4+48A/Oh295VDOFGMwY/HcceeEwW9bdgU7FDB5FC1tIKiBCjUjTOrnOQyeNrfm6onkn7GKH+2tsVaYIOeTkSmA17GT+VzmUs/V8doF8Wl69dqszLW2RXhYpMv3YvtrpLH6+vsc6mMNyPa1baxGLT/GMKCE5uqJ755M6iukfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [134.104.50.123] (unknown [134.104.50.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CCD6E6028F34B;
	Wed, 22 Oct 2025 14:25:06 +0200 (CEST)
Message-ID: <5578e792-2dd6-42db-8ad6-b12cd05c2617@molgen.mpg.de>
Date: Wed, 22 Oct 2025 14:24:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] i40e: avoid redundant VF link state
 updates
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Robert Malz <robert.malz@canonical.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jamie Bainbridge <jamie.bainbridge@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Dennis Chen <dechen@redhat.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
References: <20251021154439.180838-1-robert.malz@canonical.com>
 <0c62b505-abe7-474e-9859-a301f4104eeb@molgen.mpg.de>
 <IA3PR11MB89860CA0245498E6FF720E48E5F3A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <IA3PR11MB89860CA0245498E6FF720E48E5F3A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alex,


Thank you for your input.

Am 22.10.25 um 14:06 schrieb Loktionov, Aleksandr:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Wednesday, October 22, 2025 1:49 PM

>> Am 21.10.25 um 17:44 schrieb Robert Malz:
>>> From: Jay Vosburgh <jay.vosburgh@canonical.com>
>>>
>>> Multiple sources can request VF link state changes with identical
>>> parameters. For example, Neutron may request to set the VF link state
>>> to
>>
>> What is Neutron?
>>
>>> IFLA_VF_LINK_STATE_AUTO during every initialization or user can issue:
>>> `ip link set <ifname> vf 0 state auto` multiple times. Currently, the
>>> i40e driver processes each of these requests, even if the requested
>>> state is the same as the current one. This leads to unnecessary VF
>>> resets and can cause performance degradation or instability in the VF
>>> driver - particularly in DPDK environment.
>>
>> What is DPDK?
>>
> I think Robert needs:
> - to expand acronyms in the commit message (Neutron → OpenStack Neutron, DPDK → Data Plane Development Kit).
> - to fix the comment style as per coding guidelines.
> - add a short note in the commit message about how to reproduce the issue.
> @Paul Menzel right?

Correct.

Maybe also mention how to force it, as there seems to be such an option 
judging from the diff.

>>> With this patch i40e will skip VF link state change requests when the
>>> desired link state matches the current configuration. This prevents
>>> unnecessary VF resets and reduces PF-VF communication overhead.
>>
>> Add a test (with `ip link …`) case to show, that it works now.
>>
>>> Co-developed-by: Robert Malz <robert.malz@canonical.com>
>>> Signed-off-by: Robert Malz <robert.malz@canonical.com>
>>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>> ---
>>>    drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>>> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>>> index 081a4526a2f0..0fe0d52c796b 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>>> @@ -4788,6 +4788,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
>>>    	unsigned long q_map;
>>>    	struct i40e_vf *vf;
>>>    	int abs_vf_id;
>>> +	int old_link;
>>>    	int ret = 0;
>>>    	int tmp;
>>>
>>> @@ -4806,6 +4807,17 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
>>>    	vf = &pf->vf[vf_id];
>>>    	abs_vf_id = vf->vf_id + hw->func_caps.vf_base_id;
>>>
>>> +	/* skip VF link state change if requested state is already set */
>>> +	if (!vf->link_forced)
>>> +		old_link = IFLA_VF_LINK_STATE_AUTO;
>>> +	else if (vf->link_up)
>>> +		old_link = IFLA_VF_LINK_STATE_ENABLE;
>>> +	else
>>> +		old_link = IFLA_VF_LINK_STATE_DISABLE;
>>> +
>>> +	if (link == old_link)
>>> +		goto error_out;
>>
>> Should a debug message be added?
> 
> I think adding one would be redundant since skipping identical state
> changes is expected behavior.

My thinking was, if something does not work as expected for a user, like 
issuing the command to force a reset, that it might be useful to see 
something in the logs.

>>> +
>>>    	pfe.event = VIRTCHNL_EVENT_LINK_CHANGE;
>>>    	pfe.severity = PF_EVENT_SEVERITY_INFO;

Kind regards,

Paul

