Return-Path: <netdev+bounces-307642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ME/bOKb3VmrXDgEAu9opvQ
	(envelope-from <netdev+bounces-307642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF475A2A3
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:59:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Fa4VIWrw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307642-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307642-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA5F301454D
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280213AC0C8;
	Wed, 15 Jul 2026 02:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA193A9638
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 02:59:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084379; cv=none; b=RqYivkZWkx7nsLlJWKYsUZkSkXI1HDsXyPYDeAh1IO8dn3xhSyyXBBFGoQI+8xKskCeN0QS35jZf8Tdl1k0GRp4Ya8YZQEu6XQYnSMx/kOT2kEqydKVcjmzQR3sb9muueTi0LqZluMRZsRdjwszBuUNeyCmWagxchL6CIAymrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084379; c=relaxed/simple;
	bh=pz5x7Uful+e4tpdXxod5EqSQ03Jk4ZCGvC9DnrUEPWU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SUfVlPHkt3m9z+zhzFh+V+4BD53r6uQqy8+5+5/Otr4pnn+CwxalAm1OUHF8JKLUFe8HS8lyMGduIkeQ6LS9G9T4PfsIs8TxWIlZ7GVgveOe8Vhm16+kOyMBMea+MAMs0oCpnUNwMKmtvG8JO9cypgyyhgegJW8Bjj6lNgOFGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fa4VIWrw; arc=none smtp.client-ip=91.218.175.181
Message-ID: <2a1e5d38-1035-4f09-b4af-5a63ec04f1d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784084365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xtif7wKWcaLEOyxIVo71CFUEZSMX5hpVYfkaAXiiXA=;
	b=Fa4VIWrwA70DjAtWZ6OLqi+x7I0FG2AAc4HkAt2Ya5VS11rRMFOUSxztd/U6TqXh40wKC3
	W3aJ3vLjjPPeywQZ6wUcxbDQtgpRROjdXaSBkI8LppJ0qCd3j9bNR+6gJfhUEqDtoCq9Ay
	MfIFCyr0D0BNc90gzhb3BTn2R2U+ANI=
Date: Wed, 15 Jul 2026 10:58:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, sridhar.samudrala@intel.com,
 wojciech.drewek@intel.com, piotr.raczynski@intel.com,
 michal.swiatkowski@linux.intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
 <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
In-Reply-To: <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307642-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marcin.szycik@linux.intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:sridhar.samudrala@intel.com,m:wojciech.drewek@intel.com,m:piotr.raczynski@intel.com,m:michal.swiatkowski@linux.intel.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,vger.kernel.org:from_smtp,intel.com:email,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62BF475A2A3


在 2026/7/14 22:14, Marcin Szycik 写道:
> On 14.07.2026 08:39,xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>>
>> ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
>> port from pf->dyn_ports. However, it frees the VSI before reading the
>> index for the erase, resulting in a use-after-free.
>>
>> Follow the reverse of the allocation order in ice_alloc_dynamic_port()
>> by erasing the xarray entry before freeing the VSI.
>>
>> Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
> Reviewed-by: Marcin Szycik<marcin.szycik@linux.intel.com>
>
> Thank you!
> I wonder how such a glaring issue survived in the codebase for so long.
> Perhaps ice_vsi_free() exited early for some reason.

Thanks for the review!

Hard to say—maybe the window is quite small and the freed slab still
holds the old idx most of the time, so nothing obvious shows up.

>> ---
>>   drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
>> index 2a2e56777f9f7..3ede246490027 100644
>> --- a/drivers/net/ethernet/intel/ice/devlink/port.c
>> +++ b/drivers/net/ethernet/intel/ice/devlink/port.c
>> @@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
>>   
>>   	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>>   	ice_eswitch_detach_sf(pf, dyn_port);
>> -	ice_vsi_free(dyn_port->vsi);
>>   	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
>> +	ice_vsi_free(dyn_port->vsi);
>>   	kfree(dyn_port);
>>   }
>>   

