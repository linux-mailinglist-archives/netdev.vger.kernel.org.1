Return-Path: <netdev+bounces-270429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C6OEnL+wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:48:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C202EE751
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53FDD30058F3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959D377000;
	Mon, 23 Mar 2026 08:48:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8756304BDC;
	Mon, 23 Mar 2026 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255728; cv=none; b=gTFH3HntbBGiUf57wkh7cx4jQb9BYIoX5EA/F9g6uLsVB6d6zEmMO0JMs+DY2N1sRhpO5YC9cA05i8zJ20L4Z4uyYMKlZBzYZQ8uXAlLezwIB3gOyTT/oP839hrsDBVhiY2ZMKFW1JaFmd24BuHHnw8gmjALJO+H3yQPH5er0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255728; c=relaxed/simple;
	bh=2RVnTAdhMNGwEM3cnADlBG6E7R0JYRW15qgSlL3uOAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upnQaZcDlJnEea39WcUbAKFcDQoRQyDC4oizaaFgpc3h4WU02/9uQIajqngqnBaK8fw0VLE+gO/PmUOfeNtaKktmZTd2ISLOM2PEPzu1835dvg2E/DSG0w2jriXdc5cL2R/SkccWbHPXdRMFpkIGCYV+uthSjnFA7uFE4OdtfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p57bd9b5e.dip0.t-ipconnect.de [87.189.155.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E40664C442FFED;
	Mon, 23 Mar 2026 09:47:49 +0100 (CET)
Message-ID: <cdcedd24-0f26-4366-a6d8-73025d05ce1e@molgen.mpg.de>
Date: Mon, 23 Mar 2026 09:47:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] iavf: fix wrong VLAN mask for
 legacy Rx descriptors L2TAG2
To: Petr Oros <poros@redhat.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20260320135326.1171433-1-poros@redhat.com>
 <310379eb-9b99-444d-bf02-2bde3bd79374@molgen.mpg.de>
 <c2fa7a08-b75d-49a9-8725-fc98217c2dbe@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <c2fa7a08-b75d-49a9-8725-fc98217c2dbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270429-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mpg.de:email]
X-Rspamd-Queue-Id: 08C202EE751
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Petr,


Thank you for your quick and detailed reply.


Am 23.03.26 um 09:37 schrieb Petr Oros:
> 
> On 3/20/26 15:29, Paul Menzel wrote:

>> Am 20.03.26 um 14:53 schrieb Petr Oros:
>>> The IAVF_RXD_LEGACY_L2TAG2_M mask was incorrectly defined as
>>> GENMASK_ULL(63, 32), extracting 32 bits from qw2 instead of the
>>> 16-bit VLAN tag. In the legacy Rx descriptor layout, the 2nd L2TAG2
>>> (VLAN tag) occupies bits 63:48 of qw2, not 63:32.
>>>
>>> The oversized mask causes FIELD_GET to return a 32-bit value where the
>>> actual VLAN tag sits in bits 31:16. When this value is passed to
>>> iavf_receive_skb() as a u16 parameter, it gets truncated to the lower
>>> 16 bits (which contain the 1st L2TAG2, typically zero). As a result,
>>> __vlan_hwaccel_put_tag() is never called and software VLAN interfaces
>>> on VFs receive no traffic.
>>>
>>> This affects VFs behind ice PF (VIRTCHNL VLAN v2) when the PF
>>> advertises VLAN stripping into L2TAG2_2 and legacy descriptors are
>>> used.
>>>
>>> The flex descriptor path already uses the correct mask
>>> (IAVF_RXD_FLEX_L2TAG2_2_M = GENMASK_ULL(63, 48)).
>>
>> Do you have a reproducer to verify the fix?
> 
> Yes, i have
> 
>   1. Create 2 VFs on ice PF (echo 2 > sriov_numvfs)
>   2. Disable spoofchk on both VFs
>   3. Move each VF into a separate network namespace
>   4. On each VF: create VLAN interface (e.g. vlan 198), assign IP, bring up
>   5. Set rx-vlan-offload OFF on both VFs
>   6. Ping between VLAN interfaces → expect PASS
>       (VLAN tag stays in packet data, kernel matches in-band)
>   7. Set rx-vlan-offload ON on both VFs
>   8. Ping between VLAN interfaces → expect FAIL if bug present
>       (HW strips VLAN tag into descriptor L2TAG2 field,
>        wrong mask extracts bits 47:32 instead of 63:48,
>        truncated to u16 → zero, __vlan_hwaccel_put_tag() never called,
>        packet delivered to parent interface, not VLAN interface)
> 
>>> Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support 
>>> legacy and flex descriptors")
>>
>> (That first entered Linux v6.15-rc1, and Linux 6.12 and 6.18 are LTS 
>> series.)
>
> The reproducer works but requires legacy Rx descriptors to be in use.
> On modern ice + iavf with full PTP support, flex descriptors are always
> negotiated and the buggy legacy path is never reached.
> 
> Flex descriptors require all of the following:
>    - CONFIG_PTP_1588_CLOCK enabled in kernel config
>    - VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC granted by PF
>    - PTP capabilities negotiated (VIRTCHNL_VF_CAP_PTP)
>    - VIRTCHNL_1588_PTP_CAP_RX_TSTAMP supported
>    - VIRTCHNL_RXDID_2_FLEX_SQ_NIC present in DDP profile
> 
> If any of these conditions is not met, iavf_select_rx_desc_format()
> falls back to legacy descriptors (RXDID=1) and the wrong L2TAG2 mask is 
> hit.
> 
> In our kernel we ended up in a state where the iavf Rx path refactor was
> backported but the full PTP support chain was not. Without PTP,
> iavf_ptp_cap_supported() returns false and flex descriptors
> are never selected, exposing the bug.

Personally, I’d like to have this helpful information (reproducer and 
requisites) in the commit message, and it’d be great if you resend with 
the extended commit message.


Kind regards,

Paul


>>> Signed-off-by: Petr Oros <poros@redhat.com>
>>> ---
>>>   drivers/net/ethernet/intel/iavf/iavf_type.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
>>> index 1d8cf29cb65ac5..5bb1de1cfd33b1 100644
>>> --- a/drivers/net/ethernet/intel/iavf/iavf_type.h
>>> +++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
>>> @@ -277,7 +277,7 @@ struct iavf_rx_desc {
>>>   /* L2 Tag 2 Presence */
>>>   #define IAVF_RXD_LEGACY_L2TAG2P_M        BIT(0)
>>>   /* Stripped S-TAG VLAN from the receive packet */
>>> -#define IAVF_RXD_LEGACY_L2TAG2_M        GENMASK_ULL(63, 32)
>>> +#define IAVF_RXD_LEGACY_L2TAG2_M        GENMASK_ULL(63, 48)
>>>   /* Stripped S-TAG VLAN from the receive packet */
>>>   #define IAVF_RXD_FLEX_L2TAG2_2_M        GENMASK_ULL(63, 48)
>>>   /* The packet is a UDP tunneled packet */
>>
>> Nice find.
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>>
>> Kind regards,
>>
>> Paul
>>
> 


