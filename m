Return-Path: <netdev+bounces-301149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zFLkHFlWOWozqwcAu9opvQ
	(envelope-from <netdev+bounces-301149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:35:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B16B0C7F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:35:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=jCQ2EFzm;
	dkim=pass header.d=redhat.com header.s=google header.b=H3iWbVwP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301149-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301149-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E55730053FB
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5DA2FBE1F;
	Mon, 22 Jun 2026 15:30:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E81F151C
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:30:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142248; cv=none; b=IFBnqCXrk0IS+AnzOe7UgOim7PMnA6YbtPZIK2xYHxv5lymQOd8uFR04ok85/0UQqiwS1+ixOawH4DrCDRA94z1Zzd2MnbonmhDMpH7qkZFWP8+w8i/srMLSecOBjrTuyPz7R/6xLsMABH2zUrxoZywoMeH0nMl+OvZRfEFVX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142248; c=relaxed/simple;
	bh=KZReCBBbLPwYuR8X8Oxf6kb/nsr8OJG1g9lSh2phYz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbbpO6RBd1Bh92/LDGiuQHfo6CkOJEJLk/rjwiME4qUwcfKLYMZVMF08VJkAeQ8tCTw9wkU+1mcvMsLral9MxcgcDmm0QJTBKgVw+ZON5x2s2A7HgxFiHpHjnQvm5LA3Tjm/Ax6G92d31zLNZyFJNLsz0CeLXcn1j79TnpaYqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCQ2EFzm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3iWbVwP; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782142245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BSJeeMyYcuKSEwdVpAPNISat771zywrHCdgKCUDl20=;
	b=jCQ2EFzmkTSxTxgVYo0ZCcM0whFhhSqve2wOU8S+Mw0wSFZGjOXGoBjU9MVRHg/LNdJ8BK
	PSHi87wDJODwZoFLEotCBik8SqZgHuLcKnHaKT+LGt0PSS5KZx6IrGn7t1urDNzIpMeGHY
	c/z2szlR2WCF+b+No73stpIvXS713Rg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-z-PS_4fRPjmcpXV87ZScnQ-1; Mon, 22 Jun 2026 11:30:44 -0400
X-MC-Unique: z-PS_4fRPjmcpXV87ZScnQ-1
X-Mimecast-MFC-AGG-ID: z-PS_4fRPjmcpXV87ZScnQ_1782142242
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-469675e37e8so582496f8f.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782142242; x=1782747042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BSJeeMyYcuKSEwdVpAPNISat771zywrHCdgKCUDl20=;
        b=H3iWbVwP8NhD6QKyalB3SqU0kqhzzOB5aD/M1xTdfCAOBJ/5yTSSVnNeLPDj31cU0Q
         /9JLbA5ByTQagNA9yst0dp4MqPWjJxaquNUPE6JfLt3+9grwS2LJ5JZ29duUgvMydmBM
         332+hvSnn+jX1sd3p0tGdBsC+M2ND+/0k/wT4q7xnecLmEo25mLf29wkvVASAN4s1rOu
         ocRyy0KmJYJdj5HD6rxS2jpl9ij7MF85PGHGqKXP1Dx/T2zzKfPZ7fIxu+Oh2TTVrMJZ
         s7BM40SRnmi91J1LsPeVbIMrt1SmLiIN7myy+auoIayTC4mb+piW/Zva5IUgSaZZthPv
         Il4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142242; x=1782747042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BSJeeMyYcuKSEwdVpAPNISat771zywrHCdgKCUDl20=;
        b=Xi0FFaFYbMlTJQ0P+OOQOPpe2D/ItNjuuoZ+SMTB7PEEYwIUmGvuD3vQlhGmqVBxIx
         nrk7FXqNBcUBwOI5u29nV/bflgJeWClW3I/SqoInejP6dI41Oxpp+T4dSJ/BJffKQ04s
         Q8QqLIrMdF672MYW7cvPm7YsorNbDWRk+v/YLUJRro4taeuDhk1SkxKvymT9pzPvgX1Z
         RTPlvJLYx0w5vO79rhnwPLIKeb1sTXVxzA965O3DG5oAIc/Stna3t00er+sP3LGZ/HEH
         /vgycyXWC1Xsp4RbRRH4i2+84i0dTjF+Z26fOsGeXKO2ORjtjgJnC3R4S26vIo3Mjujd
         mSPw==
X-Forwarded-Encrypted: i=1; AHgh+Rpod/30hnmNiW3VgCcpCBTOiXUbykupQObk8WXyByGDqPJQh5+h76rRWg+ggNS6vrBnyjTWjw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6UbGS3Z2Bk8tio/CXeIzZVqQezMvHSZlYnCbJSRqMb/8mlQY
	eax0dpNZJTltEyNHL+HV6KC4z8WKd0/hZb3IOtbKSlEAXQydmrv+Vn+o0WhmZVI0wX34R/eKn/Q
	fr0B7hC96psCfOvNjFYRZdvTVk/niXYPafqae8BMMtP1zRq1brvqk4Y5Aow==
X-Gm-Gg: AfdE7cnx++cGV89Ui/Pr7VQrEg4xxTiPJsEvpMi9zjJuAy8OPfi2m3S+wBBqawSN8rg
	d6f586nEcoZgleWIVcJ5FTA6+dOsVx1IcWjDXkJrQ+XrMZMHB/I5UMpgQ08/U8ld9WVrMe2P20o
	3UOAZCKLemHuxMD3U8bkLVAJ8zajToCV1ElN3zILjNlcFuWHIhA/3WB09vEsLs/jWIt00LObZwx
	hfD9ItjkaE31FtFWzuSU6sn0tGiEQgQ+gJpNjiV4Rj75dg5F4yLoe3bLT+muERIyXr5rQCV3VFH
	oXhSqm3B1RD41lfji1S6wF50uBce19gyAoakaAmG65k6TImYOviyuRnF3Osc7fODsHGwgHgkKF6
	BUYIOcEXDaQ==
X-Received: by 2002:a05:6000:4918:b0:469:763f:942d with SMTP id ffacd0b85a97d-469763f96e8mr5560537f8f.5.1782142241996;
        Mon, 22 Jun 2026 08:30:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4918:b0:469:763f:942d with SMTP id ffacd0b85a97d-469763f96e8mr5560420f8f.5.1782142241255;
        Mon, 22 Jun 2026 08:30:41 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm27778756f8f.29.2026.06.22.08.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 08:30:40 -0700 (PDT)
Message-ID: <e85d04b5-9108-4a5a-85e7-81178b6ef679@redhat.com>
Date: Mon, 22 Jun 2026 17:30:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: clear the default
 forwarding VSI rule when releasing a VSI
To: Marcin Szycik <marcin.szycik@linux.intel.com>, netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org
References: <20260622081030.2312129-1-poros@redhat.com>
 <4dc1eb2d-e69f-4f13-ab08-ed0077305098@linux.intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <4dc1eb2d-e69f-4f13-ab08-ed0077305098@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301149-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:marcin.szycik@linux.intel.com,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:michal.swiatkowski@linux.intel.com,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:intel-wired-lan@lists.osuosl.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C76B16B0C7F


On 6/22/26 15:52, Marcin Szycik wrote:
>
> On 22/06/2026 10:10, Petr Oros wrote:
>> When a VSI is configured as the switch's default forwarding VSI
>> (ICE_SW_LKUP_DFLT) and is then torn down, the rule is left behind in
>> the switch. ice_vsi_release() no longer removes it, and the SR-IOV VF
>> free path (ice_free_vfs() -> ice_free_vf_res() -> ice_vf_vsi_release()
>> -> ice_vsi_release()) does not disable promiscuous mode either, which
>> only happens on VF reset in ice_vf_clear_all_promisc_modes().
>>
>> A trusted VF that enters unicast promiscuous mode becomes the default
>> forwarding VSI (this is the default mode, when the PF does not have VF
>> true-promiscuous mode enabled). If the VFs are then destroyed without
>> the VF first leaving promiscuous mode, the ICE_SW_LKUP_DFLT rule for
>> the now-freed VSI is leaked. When VFs are recreated, a VSI reuses the
>> freed hw_vsi_id. If it is assigned a different VSI handle than the
>> leaked rule holds, ice_set_dflt_vsi() does not recognize it as
>> already-default, and ice_add_update_vsi_list() folds the dangling
>> (freed) handle into a VSI list, which the firmware rejects. The VSI
>> handle assigned on re-creation varies, so the failure is intermittent
>> rather than every cycle.
>>
>> Reproduce by repeatedly running the cycle below on the two ports of the
>> same card, where $VF0 and $VF1 are the netdevs of vf 15 once they
>> appear. The VF must be brought up so iavf actually pushes the unicast
>> promiscuous request, and the rule must settle before the VFs are torn
>> down again:
>>
>>    echo 16 > /sys/class/net/$PF0/device/sriov_numvfs
>>    echo 16 > /sys/class/net/$PF1/device/sriov_numvfs
>>    ip link set $PF0 vf 15 trust on
>>    ip link set $PF1 vf 15 trust on
>>    ip link set $VF0 up
>>    ip link set $VF1 up
>>    ip link set $VF0 promisc on
>>    ip link set $VF1 promisc on
>>    sleep 1
>>    echo 0 > /sys/class/net/$PF0/device/sriov_numvfs
>>    echo 0 > /sys/class/net/$PF1/device/sriov_numvfs
>>
>> Within a few cycles the ice PF and iavf VF log:
>>
>>    Failed to set VSI 25 as the default forwarding VSI, error -22
>>    Turning on/off promiscuous mode for VF 63 failed, error: -22
>>    PF returned error -53 (IAVF_ERR_ADMIN_QUEUE_ERROR) to our request 14
>>
>> This cleanup used to live in ice_vsi_release() but was dropped by the
>> referenced refactor. Restore it. Clear the default forwarding VSI rule
>> in ice_vsi_release() when this VSI owns it, which covers every teardown
>> path.
>>
>> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>> index 2717cc31bff8fe..408464434506ef 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -2872,6 +2872,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
>>   		return -ENODEV;
>>   	pf = vsi->back;
>>   
>> +	if (ice_is_vsi_dflt_vsi(vsi))
>> +		ice_clear_dflt_vsi(vsi);
> In the referenced commit, the chunk of code that contained these missing 2 lines
> was moved to ice_vsi_decfg(). It also sounds like a good place for them and will
> be called from ice_vsi_release(). Are you sure we should place them directly in
> ice_vsi_release() instead?
No, ice_vsi_decfg() is not a good place for them because it is not
release only. It also runs on the rebuild and reconfig paths
(ice_vsi_rebuild(), ice_vf_reconfig_vsi(), the ice_vsi_cfg() error
path), where the VSI is reconfigured in place and stays alive, so it
can still be the default VSI afterwards.

Before the refactor the release-path clear lived only in
ice_vsi_release() and the old ice_vsi_rebuild() never cleared it.
Putting it in ice_vsi_decfg() would also clear the default VSI whenever
the default VSI itself is reset or reconfigured, which the original
code never did. ice_vsi_release() keeps it to the case where the owning
VSI is actually torn down, and the ice_is_vsi_dflt_vsi() guard makes it
a no-op everywhere else.

So I would prefer to keep it in ice_vsi_release().

Regards,

Petr

> Thanks,
> Marcin
>
>> +
>>   	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
>>   		ice_rss_clean(vsi);
>>   
>


