Return-Path: <netdev+bounces-305800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ebb0JU5GTmoaKAIAu9opvQ
	(envelope-from <netdev+bounces-305800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:45:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 080097266B3
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=I5crTAl8;
	dkim=pass header.d=redhat.com header.s=google header.b=a9RhNBsv;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305800-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305800-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E1DF3038AA5
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738144E05C;
	Wed,  8 Jul 2026 12:44:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6044212E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:44:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514677; cv=none; b=EuTeng1cKgZ/dmi2Vs+5raqv3ZCy4uz/WsCQYHj0rQDOyeHlZer0y5iMR2Wt8xADaL3d5rQQJZv1nyEeRAmwsBS9yZOITnmlhLg2eNoE09GooX3oXwE4TSwPc8ZwgB/VUx1Tp4Y+K06hnyNBpo4s2jtHb6DKn+sQy7NSlXpFW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514677; c=relaxed/simple;
	bh=q/XMIrGu0wp2TV0x1FOZZLXciYmVpsmgTxl3aFAqRag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zi8pOxfz40uBRQsG2htrLhRVVpQBgMdAeBJJdHpwXJhV8T7pMVooN2smb6pdZ8zZ+kARDF7SJlsL2G/Npl4co8vCNfSvTT5593C5QgkziIQcWv/TowtCgje12sMlZYTeqZYQy5z+ZFr7ewN7ReHI9fkDgM0ya/QP+QWwzObdGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5crTAl8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9RhNBsv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783514675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLXhKgIz8goXRBXFEhTCWUffU7CDX96wcves2MoLAu4=;
	b=I5crTAl8CYkHt6Q3eGTozkyRfLH+bSO5y8Sq4p+jL9Bh07ssis01ZEvf0kNg9LzQyN+Dd0
	A1oUhCXhhjefqJ7K7Cp92tgabN8nbErkavM+frXyo7+UlODdty+nTyesBgyZT5/FD0jMlI
	N/8PUl8QIMFkNE8gaPc66Rgbiiqjewk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-flTG6d_wP8KQq1doqjH7lw-1; Wed, 08 Jul 2026 08:44:33 -0400
X-MC-Unique: flTG6d_wP8KQq1doqjH7lw-1
X-Mimecast-MFC-AGG-ID: flTG6d_wP8KQq1doqjH7lw_1783514672
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4784d0fb9cfso584947f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783514672; x=1784119472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLXhKgIz8goXRBXFEhTCWUffU7CDX96wcves2MoLAu4=;
        b=a9RhNBsvRDLOhs2nJi1+JTmwufy58PVIwQ/Ecajw3rABGOMR5vYCl3cKBefpmqDzXv
         LSCd8p9vxrpEsv2ct2CbFg2UrW7ne5u7uS0/HLDM+Vy3qnI3F68DWTvG4fKmAiWHEAtL
         T8kLdyxdejh9oTRJI8HwMMsYyAYl9bLsO8ThVmDqscCsJyL/NcakFqLClvSlR1taRqye
         xbB+NaGjMql9GWffq3FX1M6teu5efvp9YbJhNiV+KeojwNT+xeeOi3khzOkvKmCF8f4b
         GcUSVrgxxs2HaNWfnLssC/2mwakByQM3Qgte8HT8/DGaBVawfZFh3u8IPbJ67RxzJvvH
         9zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783514672; x=1784119472;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLXhKgIz8goXRBXFEhTCWUffU7CDX96wcves2MoLAu4=;
        b=TkciPZ9Vf+hX4tnMa84sfrxQxSrytnpm0Fx3WE48RKnYXXnT7b6cHy72xhjQo7oyfO
         K1pTmc5tbnXl3dTvBAHnTxkuCirVcjVu90QVB9opnUJ3dvQSBK//PIHPTJ3O+J6U+5Ft
         TX8mrHxBVPvgC99DFM/K6HKMyfYNp3RQOcFEs4WejuG2W0UIRXMJwK/SnZ1JZCWjUWrk
         YZ/MV9Umk9CFBsAO9VoXtI4mB22Pw2hA7CY7xJfMP7DaB3daNCQfJnxSteeP0GuvsNP3
         mntN82zNKoovL+WWYo2uA+Ltyig/oo0Hu/FoZJQGHu3zWFT0pugidMb5r7Ss6WLk7Yqn
         BrfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEREfb8G1SaumiElrVnb+vmMfigKzcmnHpJDZORF+tAAazyl78g9nBRJJy3DsqJzDIr+XJfEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzgF0y8row30pYW30xfdecr+ELLo0di18D8JE9kb5UxwaOwxM
	xO8SHcO+konPNacE8ZPFQ//HdZ5ksPCoLQw7cZdWM2//SykgFg+Rd5LVaS5hF8MHaGl0dwjhSnN
	SLUKxZctMrpTdIq5aWNvhqmT4XXyzJsm+KIJSmK5DaVy02TP8Xzz/bVV95w==
X-Gm-Gg: AfdE7cmhgAAyfFqu4caXGyccK2Oa4Ppr1wOnjR0s1Ql+ZZchdjHiDPZT4SZ4TbHj3VD
	oD1PLgz0X3jPWZw9bRd+3U5YAusP6TnMVyeFKyDLOgQ3EdnhcXElg2T9kPD5OgQoyu678njjKQi
	JYg0xv08uoQijMU9DXOLN216KxHnCQGwjoicfrMDuaqoxOYe93ZltN7wEapBg+Db8XtFWnGkOVL
	1mB9s8AgXa+zSFaqOs41R//GTRCVyU9nvyyGW7sXEhehZbW7T/KSZXfNqQpUpZhHFtKbTrQOVmv
	sRukDFeoUJGp+oNaX/oJAzxjAWvXuFLAo6mZ61qR4TTWGCe1grrITBE2dOtyzDHH4vAh+EYSkdR
	VJzz+kdSqkg==
X-Received: by 2002:a5d:5847:0:b0:473:1ccc:15bf with SMTP id ffacd0b85a97d-47df07fc15cmr2503562f8f.42.1783514672384;
        Wed, 08 Jul 2026 05:44:32 -0700 (PDT)
X-Received: by 2002:a5d:5847:0:b0:473:1ccc:15bf with SMTP id ffacd0b85a97d-47df07fc15cmr2503529f8f.42.1783514671909;
        Wed, 08 Jul 2026 05:44:31 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm43229189f8f.3.2026.07.08.05.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 05:44:31 -0700 (PDT)
Message-ID: <8b49c7dc-34f6-45e5-acb0-708e4e283ecd@redhat.com>
Date: Wed, 8 Jul 2026 14:44:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 1/2] ice: skip per-VLAN
 promisc rules when default VSI Rx rule is set
To: Marcin Szycik <marcin.szycik@linux.intel.com>, netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Alice Michael
 <alice.michael@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20260701133601.2118382-1-poros@redhat.com>
 <20260701133601.2118382-2-poros@redhat.com>
 <f03d0930-9f51-45ad-9ed4-e9df335b8fa7@linux.intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <f03d0930-9f51-45ad-9ed4-e9df335b8fa7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305800-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcin.szycik@linux.intel.com,m:netdev@vger.kernel.org,m:ivecera@redhat.com,m:alice.michael@intel.com,m:przemyslaw.kitszel@intel.com,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:martyna.szapar-mudlaw@linux.intel.com,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 080097266B3


On 7/3/26 18:34, Marcin Szycik wrote:
>
> On 01.07.2026 15:36, Petr Oros wrote:
>> When an ice port in a vlan-filtering bridge goes promiscuous (typical for
>> bond slaves), the driver installs a per-VLAN ICE_SW_LKUP_PROMISC_VLAN rule
>> for every VID on top of the broad ICE_SW_LKUP_DFLT VSI Rx rule. Each rule
>> consumes one of the ~32K Flow Lookup Unit (FLU) entries the device shares
>> across PFs, so a wide trunk (vid 2-4094) over several PFs overruns the
>> pool: firmware rejects further Add Switch Rules with ENOSPC (AQ 0x10) and
>> the DFLT Rx rule itself fails to install:
>>
>>    ice 0000:5c:00.1: Failed to set VSI 14 as the default forwarding
>>                      VSI, error -5
>>    ice 0000:5c:00.1 ens1f1: Error -5 setting default VSI 14 Rx rule
>>
>> Once a switch context is overrun the retries can also come back as ENOENT
>> (AQ 0x2), which has misled triage toward a perceived recipe binding defect
>> rather than a capacity issue.
>>
>> The DFLT rule already catches every packet on the port regardless of VLAN
>> tag, so the per-VLAN promisc expansion is redundant while it is installed.
>> Skip it at the two sites that drive it, ice_set_promisc() and
>> ice_vlan_rx_add_vid(), keyed on ice_is_vsi_dflt_vsi() rather than the
>> netdev IFF_PROMISC flag so a failed or LAG-suppressed DFLT install still
>> falls back to the per-VLAN rules.
>>
>> IFF_ALLMULTI and IFF_PROMISC can reach ice_vsi_sync_fltr() in separate
>> passes (a bridge join sets them through separate calls), so the allmulti
>> pass may expand the per-VID rules before the DFLT rule exists. Drop those
>> now-redundant rules right after ice_set_dflt_vsi() installs the DFLT rule;
>> ice_vsi_exit_dflt_promisc() reinstates them when promisc is cleared.
>>
>> ice_vsi_sync_fltr() subscribed multicast promiscuity only inside the
>> "default VSI not yet in use" branch, so a promiscuous VSI that finds the
>> default VSI rule already present (owned by another VSI, or preserved
>> across a switchdev session) ended up in unicast promisc with no multicast
>> subscription. Issue ice_set_promisc(ICE_MCAST_PROMISC_BITS) whenever the
>> netdev is promiscuous; it is idempotent and returns 0 if the rule is
>> already present.
>>
>> Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>> v3:
>> - Dropped the two vid=0 ICE_SW_LKUP_PROMISC <-> ICE_SW_LKUP_PROMISC_VLAN
>>    recipe-swap guards in ice_vlan_rx_add_vid() and ice_vlan_rx_kill_vid();
>>    each swap is net-zero and guarding the demote stranded the vid=0 rule
>>    in ICE_SW_LKUP_PROMISC_VLAN when the last VLAN was removed under the
>>    DFLT rule. Reported by review.
>> - Drop the now-redundant per-VID multicast promisc rules right after
>>    ice_set_dflt_vsi(). A bridge join raises IFF_ALLMULTI and IFF_PROMISC
>>    in separate sync passes, so the allmulti pass expands the per-VID rules
>>    before the DFLT rule exists; the cleanup keeps them from lingering and
>>    exhausting the FLU pool. ice_vsi_exit_dflt_promisc() reinstates them on
>>    promisc off. Reported by review.
>> - Issue ice_set_promisc(ICE_MCAST_PROMISC_BITS) whenever the netdev is
>>    promiscuous, not only when this VSI installs the default VSI rule, so
>>    multicast promisc is not lost when the rule is already in use (owned by
>>    another VSI, or preserved across a switchdev session). Reported by
>>    review.
>> - Hoisted the combined VLAN promisc mask in ice_clear_promisc() into a
>>    local for alignment. Dropped Aleksandr's Reviewed-by since the code
>>    changed.
>>
>> v2: https://lore.kernel.org/all/20260622113428.2565255-2-poros@redhat.com/
>> v1: https://lore.kernel.org/all/89efbea9831175e6f57e9fe8557f7a0e48e050b7.1781786935.git.poros@redhat.com/
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 111 ++++++++++++++++++----
>>   1 file changed, 90 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index b43d420ece99ca..a84de6cf6eb078 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -274,7 +274,8 @@ static int ice_set_promisc(struct ice_vsi *vsi, u8 promisc_m)
>>   	if (vsi->type != ICE_VSI_PF)
>>   		return 0;
>>   
>> -	if (ice_vsi_has_non_zero_vlans(vsi)) {
>> +	/* skip per-VID expansion; the DFLT Rx rule already covers every VID */
>> +	if (ice_vsi_has_non_zero_vlans(vsi) && !ice_is_vsi_dflt_vsi(vsi)) {
>>   		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
>>   		status = ice_fltr_set_vlan_vsi_promisc(&vsi->back->hw, vsi,
>>   						       promisc_m);
>> @@ -304,9 +305,20 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
>>   		return 0;
>>   
>>   	if (ice_vsi_has_non_zero_vlans(vsi)) {
>> -		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
>> +		u8 vlan_promisc_m = promisc_m | ICE_PROMISC_VLAN_RX |
>> +				    ICE_PROMISC_VLAN_TX;
>> +		int vid0_status;
>> +
>> +		/* set time used either recipe (per-VID PROMISC_VLAN, or vid=0
> I find this sentence hard to understand - did you mean "ice_set_promisc() used
> either recipe..."?
>
>> +		 * PROMISC via the ice_set_promisc() else branch), so clear
>> +		 * both; clearing an absent rule succeeds
> What do you mean by this? Both will return -EEXIST if rule is absent. There can
> also be other errors.
>
>> +		 */
>>   		status = ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
>> -							 promisc_m);
>> +							 vlan_promisc_m);
>> +		vid0_status = ice_fltr_clear_vsi_promisc(&vsi->back->hw,
>> +							 vsi->idx, promisc_m, 0);
>> +		if (status == 0)
>> +			status = vid0_status;
>>   	} else {
>>   		status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
>>   						    promisc_m, 0);
>> @@ -317,6 +329,59 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
>>   	return status;
>>   }
>>   
>> +/**
>> + * ice_vsi_exit_dflt_promisc - drop the default VSI Rx rule on promisc off
>> + * @vsi: the VSI leaving promiscuous mode
>> + *
>> + * For an IFF_ALLMULTI VSI with VLANs the per-VID multicast rules are
>> + * reinstated before the default rule is cleared so coverage never lapses;
>> + * the then redundant vid=0 rule is dropped best-effort. The callees log
>> + * their own failures, so error returns are not re-logged here.
>> + *
>> + * Return: 0 on success, negative on error with the default rule left in place.
>> + */
>> +static int ice_vsi_exit_dflt_promisc(struct ice_vsi *vsi)
>> +{
>> +	struct ice_vsi_vlan_ops *vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
>> +	struct net_device *netdev = vsi->netdev;
>> +	struct ice_hw *hw = &vsi->back->hw;
>> +	bool restore_mc;
>> +	int err;
>> +
>> +	restore_mc = (vsi->current_netdev_flags & IFF_ALLMULTI) &&
>> +		     ice_vsi_has_non_zero_vlans(vsi);
>> +
>> +	if (restore_mc) {
>> +		err = ice_fltr_set_vlan_vsi_promisc(hw, vsi,
>> +						    ICE_MCAST_VLAN_PROMISC_BITS);
>> +		if (err && err != -EEXIST)
>> +			return err;
>> +	}
>> +
>> +	err = ice_clear_dflt_vsi(vsi);
>> +	if (err)
>> +		return err;
>> +
>> +	if (netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
>> +		vlan_ops->ena_rx_filtering(vsi);
>> +
>> +	if (restore_mc)
>> +		ice_fltr_clear_vsi_promisc(hw, vsi->idx, ICE_MCAST_PROMISC_BITS,
>> +					   0);
>> +
>> +	return 0;
>> +}
>> +
>> +/* Drop the per-VID multicast promisc rules, redundant once the default
>> + * VSI Rx rule covers every VID. A no-op when the VSI has no VLANs.
>> + */
>> +static void ice_vsi_clear_vlan_mc_promisc(struct ice_vsi *vsi)
>> +{
>> +	if (ice_vsi_has_non_zero_vlans(vsi))
> Nit: could flip condition to decrease indent level.
>
>> +		ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
>> +						ICE_MCAST_VLAN_PROMISC_BITS);
> Error code ignored, not sure if intentionally.
The ignored error code is intentional: it only drops rules made redundant
by the default VSI rule, and a leftover is harmless while that rule is
installed.

I will address all the comment/style points in v4.

Many thanks,

Petr

>
>> +}
>> +
>>   /**
>>    * ice_vsi_sync_fltr - Update the VSI filter list to the HW
>>    * @vsi: ptr to the VSI
>> @@ -429,30 +494,35 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>>   				err = 0;
>>   				vlan_ops->dis_rx_filtering(vsi);
>>   
>> -				/* promiscuous mode implies allmulticast so
>> -				 * that VSIs that are in promiscuous mode are
>> -				 * subscribed to multicast packets coming to
>> -				 * the port
>> +				/* DFLT now covers every VID; drop the per-VID
>> +				 * multicast promisc rules a prior IFF_ALLMULTI
>> +				 * pass may have installed (separate passes on a
>> +				 * bridge join) so they do not linger and exhaust
>> +				 * the FLU pool. exit_dflt_promisc() reinstates
> Please use the full function name.
>
>> +				 * them on promisc off.
>>   				 */
>> -				err = ice_set_promisc(vsi,
>> -						      ICE_MCAST_PROMISC_BITS);
>> -				if (err)
>> -					goto out_promisc;
>> +				ice_vsi_clear_vlan_mc_promisc(vsi);
>>   			}
>> +
>> +			/* Promiscuous mode implies allmulticast. Subscribe
>> +			 * the VSI to all multicast even when the default VSI
>> +			 * rule is already in use and the block above is
>> +			 * skipped (it may be owned by another VSI, or
>> +			 * preserved across a switchdev session); the unicast
>> +			 * catch-all does not cover the multicast subscription.
>> +			 */
>> +			err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
>> +			if (err)
>> +				goto out_promisc;
>>   		} else {
>>   			/* Clear Rx filter to remove traffic from wire */
>>   			if (ice_is_vsi_dflt_vsi(vsi)) {
>> -				err = ice_clear_dflt_vsi(vsi);
>> +				err = ice_vsi_exit_dflt_promisc(vsi);
>>   				if (err) {
>> -					netdev_err(netdev, "Error %d clearing default VSI %i Rx rule\n",
>> -						   err, vsi->vsi_num);
>>   					vsi->current_netdev_flags |=
>>   						IFF_PROMISC;
>>   					goto out_promisc;
>>   				}
>> -				if (vsi->netdev->features &
>> -				    NETIF_F_HW_VLAN_CTAG_FILTER)
>> -					vlan_ops->ena_rx_filtering(vsi);
>>   			}
>>   
>>   			/* disable allmulti here, but only if allmulti is not
>> @@ -3676,10 +3746,9 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
>>   	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
>>   		usleep_range(1000, 2000);
>>   
>> -	/* Add multicast promisc rule for the VLAN ID to be added if
>> -	 * all-multicast is currently enabled.
>> -	 */
>> -	if (vsi->current_netdev_flags & IFF_ALLMULTI) {
>> +	/* skip the per-VID rule when the DFLT Rx rule already covers this VID */
>> +	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
>> +	    !ice_is_vsi_dflt_vsi(vsi)) {
>>   		ret = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
>>   					       ICE_MCAST_VLAN_PROMISC_BITS,
>>   					       vid);
> Thanks,
> Marcin
>


