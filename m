Return-Path: <netdev+bounces-270426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJCLLF39wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:44:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E12EE6A7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1707305260D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976F73803C7;
	Mon, 23 Mar 2026 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtFgfQmB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ztb6sEgO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AE2C187
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255058; cv=none; b=azNzjV/Rzcu9PuUWzChdZgSbLaiQ/yZ9ml+nmIixgn1bSuGzVDH8afsXIGPmL+9HlWNSSVvc+/kfEuR4yRjx/WO+g1/JgB2ZkQGOAfcFsg3wg3P7DFtTonsi1e2F9oalZVxlNK+y3GiItvv1FYr9Ja/XN0djhqSaGAPXWXSG+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255058; c=relaxed/simple;
	bh=kV9qxt9z5kUBnQypg0tvwqy0X1j74YUSzCnUnCVOp0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAuiY1z5hTCeZsutHV//9cSiV21LXbiRChzYI3JnvSfYZzAVcPAM5UrHjbpjWAfzlIQ3FRKhMxPDmNg8MwdJv12UNcPmQAO3B9qWK31vFYQPKUlayQdJxHC6RbfTc0iXp8Sjzea+FzuP2EwPg+3TIzp5/sMehffm1GKaP5CaiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtFgfQmB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ztb6sEgO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774255054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTAb3BalGSZwPh5wtxjIj5LdP1IEByYqFV8DXSZ3Z9E=;
	b=HtFgfQmBi0Kgsx6mBEit9386JungFE6ZnUdX/SLlXJmAOP3V98RjCVaiK8O4dZ4E4XLJH7
	U02YTQE4xjrA29THDNXYquM/hU2l7tsVEAKya5gekoNxA7QriR6mdZAXo/FPRgH8pGSRvw
	Av2OSUOJU+Y790tW1GqYjnvT7sIoqfw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-rScUrbuIPJm5xmAjiMQ0Hg-1; Mon, 23 Mar 2026 04:37:33 -0400
X-MC-Unique: rScUrbuIPJm5xmAjiMQ0Hg-1
X-Mimecast-MFC-AGG-ID: rScUrbuIPJm5xmAjiMQ0Hg_1774255052
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48378df3469so32370565e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774255052; x=1774859852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTAb3BalGSZwPh5wtxjIj5LdP1IEByYqFV8DXSZ3Z9E=;
        b=Ztb6sEgO9wZpyoAHxVPVq7AfwYtNLOjkOC1smkvVO7eMyjzMIaEvb3mV2m+OxqSnbU
         YXJW25T+7bDWZcsbdhI4BzD54vZ7krINRRFPPEW3u8WsVxmg5VTf4pUn9KmwPsgjZ6EA
         NQ/aVXMpx5cQ2HsU9i3WTczRrmct2p/AxiEPF7zUGLPXQOTYfNHQHJNKx9X0a6tT6/Bw
         l0uRjpAoDjE8G+oryLpq/Y8804uj1gMYJdIl47OCUxPO3MLcHocRJCf/rUKcfmJLMvOQ
         /B272nzZDwspSsiCy5Sgv3DSD24thMIGK7ENAOTx/Ty6z/nPyEXULrdBUXUypl6h6kJ6
         0BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774255052; x=1774859852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTAb3BalGSZwPh5wtxjIj5LdP1IEByYqFV8DXSZ3Z9E=;
        b=rB/7kZqRC59FlXKXaR1Y9xOaK9n4EQScqcxg882OZbvL8DqfldInSk5ZIDIs8oFjER
         IAuIXPvBWXa4RnYxQz1fMjaT1TeewUFO2LPtjMxw0z9P6OLm04n0O0ci1lz2KTMTmFGl
         H4HyWzi4cwECE8YM0KSDc25lxLNQphtbxBPcad25wn+lMEAPCigY38rInvFPczj7FvPE
         M3v6ZHXAMHAwSYf5QbsDY959hgEHI7gxfSxPBkk7a6/g4u6a6/nbE9kSi4TByPtTWOEZ
         wmyN/ot8/dMhl+yITW+oL6EJOpz3s/+Be6Tcy95XeRduLIIiRqNCGPxPVB9HGPOVYgkf
         c/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUnVa59oY3HEXeyPH7ziCbnsx8oplJ62jnbtn2jFJ/37WF/DOX1FkWdiamHH+gfn2W4BmpjTPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwyHAnzQTpIiuk4RPZy3AnBRnv1A6UkD/BiqnwJt/yPK4oH8e
	dWJwGkhSW2L+NijqIgpY8gtjsNVF7dvJEiCY3fhjy84QXZUXd0x9prrQKyQpWJgKY4BJWzEJnSZ
	2SmQHJqcd2Ro2IlAcSBwRNeS+xB8mcDqqTBgfLpt5Xe6Db9lnP6TXcAvNww==
X-Gm-Gg: ATEYQzwFZF4ACmXinLXCrggAvuUi83ekQD97js5dRr10UsAe+RlwhpTRJYc2aMSMXh8
	/7C+LrqdlOWLiYz2FVeo/eZYvamupuzemP/58MXIdc3bIoZeoA6S9+L2eO3ViGijllfCf6pPTcP
	iNWophuT7PWZKSh0Xsx2r+doFQp7jCNQPw+31VFLObiZzbRFcgJcl6zDudbvrQsTBSFTv4+yT9Y
	qfcF/8DLYcDHalWzLrI1EQFwg1En1X7r+Lz0DxxwA+OjT7p0Gr9PTsocF/Ik3pTG1ia6HfhekZr
	3cnlpKJjELlV6SzeyXh4fRt2YhFSIZMuWTRtz/rfBV/EVF1u0Ji8JHHEiJeZ2LSJt0vS+1HWw3j
	q2vpBFUNpbCApbspOXjBK
X-Received: by 2002:a05:600c:3b94:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-486fe8ef087mr180279215e9.12.1774255051968;
        Mon, 23 Mar 2026 01:37:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3b94:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-486fe8ef087mr180278855e9.12.1774255051520;
        Mon, 23 Mar 2026 01:37:31 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe879d37sm98149575e9.1.2026.03.23.01.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 01:37:30 -0700 (PDT)
Message-ID: <c2fa7a08-b75d-49a9-8725-fc98217c2dbe@redhat.com>
Date: Mon, 23 Mar 2026 09:37:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] iavf: fix wrong VLAN mask for
 legacy Rx descriptors L2TAG2
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <310379eb-9b99-444d-bf02-2bde3bd79374@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270426-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 183E12EE6A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/20/26 15:29, Paul Menzel wrote:
> Dear Petr,
>
>
> Thank you for your patch.
>
> Am 20.03.26 um 14:53 schrieb Petr Oros:
>> The IAVF_RXD_LEGACY_L2TAG2_M mask was incorrectly defined as
>> GENMASK_ULL(63, 32), extracting 32 bits from qw2 instead of the
>> 16-bit VLAN tag. In the legacy Rx descriptor layout, the 2nd L2TAG2
>> (VLAN tag) occupies bits 63:48 of qw2, not 63:32.
>>
>> The oversized mask causes FIELD_GET to return a 32-bit value where the
>> actual VLAN tag sits in bits 31:16. When this value is passed to
>> iavf_receive_skb() as a u16 parameter, it gets truncated to the lower
>> 16 bits (which contain the 1st L2TAG2, typically zero). As a result,
>> __vlan_hwaccel_put_tag() is never called and software VLAN interfaces
>> on VFs receive no traffic.
>>
>> This affects VFs behind ice PF (VIRTCHNL VLAN v2) when the PF
>> advertises VLAN stripping into L2TAG2_2 and legacy descriptors are
>> used.
>>
>> The flex descriptor path already uses the correct mask
>> (IAVF_RXD_FLEX_L2TAG2_2_M = GENMASK_ULL(63, 48)).
>
> Do you have a reproducer to verify the fix?

Yes, i have

  1. Create 2 VFs on ice PF (echo 2 > sriov_numvfs)
  2. Disable spoofchk on both VFs
  3. Move each VF into a separate network namespace
  4. On each VF: create VLAN interface (e.g. vlan 198), assign IP, bring up
  5. Set rx-vlan-offload OFF on both VFs
  6. Ping between VLAN interfaces → expect PASS
      (VLAN tag stays in packet data, kernel matches in-band)
  7. Set rx-vlan-offload ON on both VFs
  8. Ping between VLAN interfaces → expect FAIL if bug present
      (HW strips VLAN tag into descriptor L2TAG2 field,
       wrong mask extracts bits 47:32 instead of 63:48,
       truncated to u16 → zero, __vlan_hwaccel_put_tag() never called,
       packet delivered to parent interface, not VLAN interface)

>
>> Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support 
>> legacy and flex descriptors")
>
> (That first entered Linux v6.15-rc1, and Linux 6.12 and 6.18 are LTS 
> series.)
>
The reproducer works but requires legacy Rx descriptors to be in use.
On modern ice + iavf with full PTP support, flex descriptors are always
negotiated and the buggy legacy path is never reached.

Flex descriptors require all of the following:
   - CONFIG_PTP_1588_CLOCK enabled in kernel config
   - VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC granted by PF
   - PTP capabilities negotiated (VIRTCHNL_VF_CAP_PTP)
   - VIRTCHNL_1588_PTP_CAP_RX_TSTAMP supported
   - VIRTCHNL_RXDID_2_FLEX_SQ_NIC present in DDP profile

If any of these conditions is not met, iavf_select_rx_desc_format()
falls back to legacy descriptors (RXDID=1) and the wrong L2TAG2 mask is hit.

In our kernel we ended up in a state where the iavf Rx path refactor was
backported but the full PTP support chain was not. Without PTP,
iavf_ptp_cap_supported() returns false and flex descriptors
are never selected, exposing the bug.

Regards,

Petr


>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_type.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h 
>> b/drivers/net/ethernet/intel/iavf/iavf_type.h
>> index 1d8cf29cb65ac5..5bb1de1cfd33b1 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_type.h
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
>> @@ -277,7 +277,7 @@ struct iavf_rx_desc {
>>   /* L2 Tag 2 Presence */
>>   #define IAVF_RXD_LEGACY_L2TAG2P_M        BIT(0)
>>   /* Stripped S-TAG VLAN from the receive packet */
>> -#define IAVF_RXD_LEGACY_L2TAG2_M        GENMASK_ULL(63, 32)
>> +#define IAVF_RXD_LEGACY_L2TAG2_M        GENMASK_ULL(63, 48)
>>   /* Stripped S-TAG VLAN from the receive packet */
>>   #define IAVF_RXD_FLEX_L2TAG2_2_M        GENMASK_ULL(63, 48)
>>   /* The packet is a UDP tunneled packet */
>
> Nice find.
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
>


