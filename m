Return-Path: <netdev+bounces-289348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPlOBrcqDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:17:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C157B12B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D1E4303A835
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B63EFFC2;
	Tue, 19 May 2026 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwb7CSx8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kzS8TZ9P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D33EF66A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182031; cv=none; b=iDPJ47odHQv0GvvD2a6BJFPUbvLiDXWAwK4cEqystWTLDQ+HWOKpu9mF3bmpI4jikB7093RWwdb8xasQ3nAST4HNIvoEhk+/CVDUNmzIpcp5zLlvRMn+neNjcpNwv9vMeOkpY4o4rcskK9k8wzqzMkGsOGQC3kO0XbQymX5otJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182031; c=relaxed/simple;
	bh=Yr1naL0WjdE/A41/zRFmRBexEGZFRcqrl24tfALYhsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEXO+sexmaioyLSN++gAIKdflSQF+GUuipFevliOeHGRmuEzQ3c39DRIMNwqWT7yEMYWcoYGlQdb0A5ZHkbOrqkFxaduMlHQxjH0b/TsKYtuVyEi4IcywsWYPco74aFANGkl2g7F/AHcstzhlY6TakQNKBYXvTfZwIU7WfwBdgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwb7CSx8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kzS8TZ9P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ay6gidP+I0vDJI41cdYOxuCXaLwaNuaZ5No08B1GxG8=;
	b=cwb7CSx8/fOnfoAz6qMIze2MArmMiKCEKp21TU5EdHWRmex92J7l8d0DJD8J8qpLswK4cn
	54gLbYs6zyg3fK2Jl4OAzq/z1QrEtJxUjufwNHWbpo+UqOnWAKykE6ecAhJrIHuv79isVg
	m685JXH8m91GUvYs5OmSAAUsk7VCZeY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-6ucNR1NvNmSyCuQPJmxS8Q-1; Tue, 19 May 2026 05:13:47 -0400
X-MC-Unique: 6ucNR1NvNmSyCuQPJmxS8Q-1
X-Mimecast-MFC-AGG-ID: 6ucNR1NvNmSyCuQPJmxS8Q_1779182026
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a36715dso2079116f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779182026; x=1779786826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay6gidP+I0vDJI41cdYOxuCXaLwaNuaZ5No08B1GxG8=;
        b=kzS8TZ9PwmvjiUtfteHUSRJQXMamRtUNezZie+71KLNVxleIJdZXqNtys/tI7nuUMB
         ftGq+H/WNYCV9wtKNapLA4Rns/q8Mrf+BuFOlNtukCyfgPw5e+xebopmWAmFdsHJTi0a
         ptrBv1eMqjLsznhxwxk5o29EJBMQUs1ImeaWQP4HpyOSWGOSGu/IJTqr8A5xPF+mM0cp
         OrZzxS92VSZSLiipmFDDBFxIu/yGJrsctC1JL3R6ZKZZtUJS5ogIaXS6F566e5ubIH5T
         UqRSTmfGFwSREVcoatJ1i9t/fzT4HY4+Gbop2J+lQ6Au2K7fAbo/UYKd9rbAfC2zM6/E
         VIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182026; x=1779786826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ay6gidP+I0vDJI41cdYOxuCXaLwaNuaZ5No08B1GxG8=;
        b=nzm1q0atLWgV6nSzJaz99Lf0HGAizZEoKv9q8AntOimBHaiU0d+1VNVMIJT6f3Z5im
         OvidyvPy5oTSATTk9JCE9AgH1oRM5OA/GA5T1GaLiMWDQNzsoap+9hl23H+7bWr+U4J9
         URq/mY6LypHzyTL3zVf5IxiO/T9nBFaehZYEkoPBHfGa69t9OFQVgi97ASCd+OSRfJQU
         iyg4UaM6T4Rvh//IcWXJyODLyEmL1VGrX09RQwHHEp+2H+8w0HEMy5l1fji2NMD+1pVQ
         UaiWmv+5rbM7+2QwrrCb/ATcmeNeaOaJSlzXKftH9ourB87xpU4p+uMy/2rqujHdyjev
         B1Eg==
X-Forwarded-Encrypted: i=1; AFNElJ/Nc4QaHuqWSYfQOPuuV2j3OexIN8wgvBM11BohoI7ahmzVPY6kmIPHLZP9Xw2J/NSvP9BOaz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuhhiR0wNW0TKFvda/GUQhyYjhB83Kq2DEYc+HopFol8Z4ILHe
	E0muGQ7rxucmj1M9ib35LBM4op0FzQVM94W2xfBGo0AN/krR5HX7Nfha6MxcR3f5eIDO7jkUSW3
	EElWYIjyLMNUy2VG869rM0TWkXB/Lvu+iWhLGH4DVmEHtHybSJe3yMnXOcA==
X-Gm-Gg: Acq92OF1mWizrALBURUNx4DQwHUuxqjjmzt9BV4S6baF+e5JmGkWhaCO9b9iaoNSKsh
	kPkk8Q1o69o7FhdVBeOapntOcjo7EqvkCMusuOLYGV3bTN5bRYploT0N+hEIns8IU7IkKtNDyS5
	Rwf83nE39eKK1XfQgaPnqaMaakiBN9+c5eq5G7kvfzyR8LEHAm3PBntiGmMIU4RfFQw58zdxr9/
	uV4dylVE8Wl+bGbOA5onnwG6mXIE369WP7xEJS4fl9rm4bU96MiLE64xgc77B0nE2wIRfNGQips
	9P1SVb6kx46kQA0lPCr3IsTuPiVtuZmt4NCyhSbL/Uh2x7hoZ3hm2+oNfaSUsfLI8/t1veEOhJm
	ei6Xq0dfDQUiDta/tYXhoWeKI99zko7Dw/yN0nlTfzGrVvwwLTccKfUbRg6eDxA4t/A==
X-Received: by 2002:a5d:64e4:0:b0:43e:b0f8:66f1 with SMTP id ffacd0b85a97d-45e5c5aebdcmr30874761f8f.43.1779182026476;
        Tue, 19 May 2026 02:13:46 -0700 (PDT)
X-Received: by 2002:a5d:64e4:0:b0:43e:b0f8:66f1 with SMTP id ffacd0b85a97d-45e5c5aebdcmr30874709f8f.43.1779182026043;
        Tue, 19 May 2026 02:13:46 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm46379303f8f.23.2026.05.19.02.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:13:45 -0700 (PDT)
Message-ID: <ef633a47-0ed0-4a10-8316-d88a7c0e7c54@redhat.com>
Date: Tue, 19 May 2026 11:13:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
To: Ratheesh Kannoth <rkannoth@marvell.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, oss-drivers@corigine.com
Cc: akiyano@amazon.com, andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, brett.creeley@amd.com, darinzon@amazon.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, ivecera@redhat.com, jiri@resnulli.us,
 kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, petrm@nvidia.com,
 Prathosh.Satish@microchip.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, sgoutham@marvell.com, tariqt@nvidia.com,
 vadim.fedorenko@linux.dev
References: <20260514062537.3813802-1-rkannoth@marvell.com>
 <20260514062537.3813802-10-rkannoth@marvell.com>
 <agbLlpli-whxptBX@rkannoth-OptiPlex-7090>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <agbLlpli-whxptBX@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-289348-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Queue-Id: A80C157B12B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 9:30 AM, Ratheesh Kannoth wrote:
> On 2026-05-14 at 11:55:37, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
>> Replace the file-scope static npc_priv with a kcalloc'd struct filled
>> from hardware bank/subbank geometry at init (num_banks is no longer a
>> const compile-time constant; drop init_done and use a non-NULL
>> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
>> through the CN20K NPC code paths, extend teardown to kfree the root
>> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
>> setup to use the discovered subbank count.
>>
> 
>>>  #include "cn20k/reg.h"
>>>  #include "rvu_npc_fs.h"
>>>
>>> -static struct npc_priv_t npc_priv = {
>>> -	.num_banks = MAX_NUM_BANKS,
>>> -};
>>> +static struct npc_priv_t *npc_priv;
>> Since npc_priv and dstats are still declared as global file-scope variables,
>> won't probing multiple RVU devices cause these pointers to be overwritten?
>> If a second device is probed, the allocations for the first device would be
>> leaked and both devices would end up sharing the second device's state.
>> On device unbind, devres will automatically free dstats, leaving a dangling
>> global pointer. Additionally, npc_cn20k_deinit() explicitly frees npc_priv
>> and sets it to NULL.
>> If a userspace process reads a debugfs file after device unbind, could it
>> cause a NULL pointer dereference on npc_priv or a use-after-free when
>> accessing the dstats array?
> While a global file-scope pointer introduces a shared-state risk in
> drivers that support multiple instances, the structural design and
> physical topology of the OcteonTX2 platform eliminate this hazard.
> 
> First, the system architecture dictates that exactly one physical RVU
> Admin Function (AF) hardware block exists per SoC layout. Because the
> hardware platform cannot expose multiple active AF instances, there is
> no parallel or sequential device probing sequence to trigger a race
> condition, overwrite existing allocations, or cause memory leaks between distinct devices.

Since at least another revision of this series is needed (see my
previous email), and the code depends on the above H/W constraints,
please document it explicitly somewhere inside the code. A build time or
run time check would possibly be even better.

>> 	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
>> 		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
>>            ...
>> 			if (stats < dstats[0][bank][idx])
>> 				dstats[0][bank][idx] = 0;
>>    ...
>> }
>> Since dstats is still statically sized using MAX_NUM_BANKS and related
>> macros, will this result in out-of-bounds accesses if the hardware returns
>> larger values?
>> Similarly, the en_map bitmap is sized using these same static constants.
>> Could operations like set_bit(index, npc_priv->en_map) in
>> npc_cn20k_enable_mcam_entry() corrupt the npc_priv_t structure if the
>> hardware dimensions exceed the static bitmap size?
> 
> The static definitions for the tracking arrays and bitmaps are based
> strictly on the silicon's hard limits, preventing any possibility of
> out-of-bounds corruption.
> 
> The compile-time constants (MAX_NUM_BANKS, MAX_NUM_SUB_BANKS, and
> MAX_SUBBANK_DEPTH) do not represent arbitrary bounds; they define the
> absolute, physical maximum limits across all existing and planned SoC
> variants for the CN20K hardware profile. The hardware registers cannot
> expose configuration dimensions that exceed these maximum architectural limits
> because the underlying silicon layout lacks the physical lines or registers
> to support larger structures.
A similar remark here.

/P


