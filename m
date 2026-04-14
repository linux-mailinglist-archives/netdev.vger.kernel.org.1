Return-Path: <netdev+bounces-278329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJwpKkf13WlolgkAu9opvQ
	(envelope-from <netdev+bounces-278329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:05:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7443F6EC2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C5013012C8E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6938B7DC;
	Tue, 14 Apr 2026 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GElbqjki";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oWm9mT5E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043C38B7B4
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153850; cv=none; b=tsBvXAYAxiPUtK13T24PLGwGOdTL7LbZ6VMJb9omyMTnoHrzr+mlF3zW9tPNsIs486b+wMYEdbBJcINYou36vbnHcgdwYKhpTyUzR/fE1xtd/pzKWgK7pOZKnpjy+N1XCh1Jx+6JeYlivkPe2/NWrwlxkOqNE8j6MoYJajqkzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153850; c=relaxed/simple;
	bh=Hnyj9T6i6WMrLQZCuxbS1CYUIk9h22kkXtxhKguP4AQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P+chkEHv12Xbj5IWBS823AgIjDCNsTmUbbvL8ySY90xjRFwkCVzMsmYDqRkl24CPo5o2eFjVQHHzu3ecebG/f21AgVm5R0MLKJ/15jQZ0hpSkr0jWzB8JrZLulK6I2J3ZQonR5F/BJmkiy3QieboB1WP+nRwIQs2dtQqZAd4Wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GElbqjki; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oWm9mT5E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776153848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnCO8guhms1mkaeYnJ8PInVTX4vnN/AYoV2EE/jBklQ=;
	b=GElbqjkiXQlv5bon15AZROLiEFE1VFkavY4edRWyv8667X0gT1a6n+cKuACLR5sahmy2NR
	jUSg0eEC3pCLDPv/WWu2kY/ZzG544YMSWlM+PDCQCKxKMe9tcRG3O8xNq6HtTrCq6qzawD
	JknyHxPN2CJaHPU2xaxZ6uXuIPxKRnw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-77raemmSO4GVrbct1SBNSQ-1; Tue, 14 Apr 2026 04:04:06 -0400
X-MC-Unique: 77raemmSO4GVrbct1SBNSQ-1
X-Mimecast-MFC-AGG-ID: 77raemmSO4GVrbct1SBNSQ_1776153846
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so2784128f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776153845; x=1776758645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dnCO8guhms1mkaeYnJ8PInVTX4vnN/AYoV2EE/jBklQ=;
        b=oWm9mT5EIOa8TVG7CPo6/H3RibTUOp6zEdfqfGmg2EeOc74Xr7FZMlzK7LMIRKcejc
         eubCEkm0NZH6/XfCYS6zAVoVWkBxa1fME12CAGBoD/PJvncW7SWHj+nEUoxdFNLcFzrZ
         tki7z8hJ6iWOi1dY1Ycp0n3Rta3R2H/LAnhQ+Ge0f7C2rhpE84eEqxDlMXpcQYVgScYR
         6PIwSyQo5RH03VawRg3tiLtHs6+0nUffoP7OsTgBAdNUnX4lLm6O2hEjTGqwfZtY3C/J
         G2Ky72pnHwYtpMw0vYQEWFleRce02/RpxIsHFUNaUpi64GfQp/pkvnFpEwfT/kEI/5bF
         zArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776153845; x=1776758645;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnCO8guhms1mkaeYnJ8PInVTX4vnN/AYoV2EE/jBklQ=;
        b=MFCXYVNIgiuJhhmktdLqn81ChWOkX6eSlYNFwX1OSxfhx+jwUNi1zU8z/FWU43J8hb
         tHKjNE04xh93no8Ri/t7o4ZAGCBlIDK2vfzh4CLYjwY/On0ZStb4hv9TcBj27Ctt4DhH
         c76HsxqV49KzYA7Y2pGGenD42BrtYo9JCTBPo4bnInGdQkZqDns4Dt2szlGTsdirCjnZ
         8x3EKArypRoiT8XZZpTOn0WRT73yoZRookxEXLl372cCIjnw4WdWjFG6fwaP6UZYs8Lt
         vSLBNdbNYamIcNEAAPvf+BsDiyuO/FqsS0980Bt0/u5DdeaIFXyzHgxD43DbDg45MmLP
         121g==
X-Forwarded-Encrypted: i=1; AFNElJ9ELcNyqCLlOfWyognCV/+PLjtOUnXceQ6xeSowWuj/4McQPlSPDNlIMU6w3OnX1GWsjHDQncE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKpyiJxr3BcqHR9VtizvqvzzgRcnvOaqG/r2/cz5QpovSdNZZ
	BDnnoEMVqvUV7ww+t8M99/loPhlMMAaoI+kJdsU3Tlq9L8ZgmPdUpePUWkSqW24LpuFfQyIOX/V
	ezFA8aUd+5C632uiGeZ8yfxo3hAE9rvXAqoHQFmYnL6toNw6NHr3whl44HA==
X-Gm-Gg: AeBDieuqqAq8dZQx0XwNseH0d76UPyEkiXKxS/ctiblevimUMQ2Xn2PvwbOJ2oUUc21
	fpsGZfxNOEEQrQ/R0StVvmgL4cUnDwPOtADkcOMIJxpUr3bSAvppU17oRZIzgyFAemMH7Rylwmx
	hkNbGXdpAa7AzH6bukrgHfZAvxfC3ZZO810IFF1vBI8/8VVrbgKD41QZnorP0BSCf672PxsOY3c
	raHo+KS4ynNJy3WAYNkEcbPiQU8+MkA4lCQfx6hv0pKleA8RrNRzZkJlsD17OOXU2G8yq2AmUTA
	pmKLK8fDIWNIy+p49JX+vfn24I3EO/FADGY9KcHGT4OkpWZLP0xhqN54RF8DdZUJCGO+uXddU3E
	+bq+sff3XCCZPXIVg+E3sfrlNW8wEuyYDH+piphSURn9aDS8f8A4jWGc9
X-Received: by 2002:a05:6000:40e1:b0:43d:772d:2b61 with SMTP id ffacd0b85a97d-43d772d2cb7mr11831181f8f.15.1776153845549;
        Tue, 14 Apr 2026 01:04:05 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:43d:772d:2b61 with SMTP id ffacd0b85a97d-43d772d2cb7mr11831099f8f.15.1776153844935;
        Tue, 14 Apr 2026 01:04:04 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7794cce5sm16813327f8f.9.2026.04.14.01.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:04:04 -0700 (PDT)
Message-ID: <afc0a3ca-311d-4c6a-9380-98d1b23ea536@redhat.com>
Date: Tue, 14 Apr 2026 10:04:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] nfc: nci: fix u8 underflow in
 nci_store_general_bytes_nfc_dep
From: Paolo Abeni <pabeni@redhat.com>
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-nfc@lists.01.org, stable@vger.kernel.org, horms@kernel.org,
 =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
References: <20260409164129.GO469338@kernel.org>
 <20260409185958.1821242-1-snowwlake@icloud.com>
 <20260409185958.1821242-2-snowwlake@icloud.com>
 <5a6a95f0-a26c-4eed-9c9a-98e22c3bc682@redhat.com>
Content-Language: en-US
In-Reply-To: <5a6a95f0-a26c-4eed-9c9a-98e22c3bc682@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lists.01.org,vger.kernel.org,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_TO(0.00)[icloud.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278329-lists,netdev=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[outlook.com:server fail];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[outlook.com:server fail];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RBL_SEM_FAIL(0.00)[172.105.105.114:server fail];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E7443F6EC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 9:34 AM, Paolo Abeni wrote:
> On 4/9/26 8:59 PM, Lekë Hapçiu wrote:
>> From: Lekë Hapçiu <framemain@outlook.com>
>>
>> nci_store_general_bytes_nfc_dep() computes the number of General Bytes
>> to copy from an ATR_RES or ATR_REQ frame by subtracting a fixed header
>> offset from the peer-supplied length field:
>>
>>   ndev->remote_gb_len = min_t(__u8,
>>       (atr_res_len - NFC_ATR_RES_GT_OFFSET),   /* offset = 15 */
>>       NFC_ATR_RES_GB_MAXSIZE);
>>
>> Both length fields are __u8.  When a malicious NFC-DEP target (POLL mode)
>> or initiator (LISTEN mode) sends an ATR_RES/ATR_REQ whose length field is
>> smaller than the fixed offset (< 15 or < 14 respectively), the subtraction
>> wraps in unsigned u8 arithmetic:
>>
>>   e.g. atr_res_len = 0 -> (u8)(0 - 15) = 241
>>
>> min_t(__u8, 241, 47) then yields 47, so the subsequent memcpy reads
>> 47 bytes from beyond the end of the valid activation parameter data into
>> ndev->remote_gb[].  This buffer is later passed to nfc_llcp_parse_gb_tlv()
>> as a TLV array, feeding directly into the TLV parser hardened by the
>> companion patch.
>>
>> Fix: add an explicit lower-bound check on each length field before the
>> subtraction.  If the length is smaller than the required offset the frame
>> is malformed; leave remote_gb_len at zero and skip the memcpy.
>>
>> Both the POLL (atr_res_len / NFC_ATR_RES_GT_OFFSET = 15) and the LISTEN
>> (atr_req_len / NFC_ATR_REQ_GT_OFFSET = 14) paths are affected; both are
>> fixed symmetrically.
>>
>> Reachability: the ATR_RES is sent by an NFC-DEP target during RF
>> activation, before any authentication or pairing.  The bug is therefore
>> reachable from any NFC peer within ~4 cm.
>>
>> Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
>> ---
>>  net/nfc/nci/ntf.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
>> index c96512bb8..8eb295580 100644
>> --- a/net/nfc/nci/ntf.c
>> +++ b/net/nfc/nci/ntf.c
>> @@ -631,25 +631,31 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
>>  	switch (ntf->activation_rf_tech_and_mode) {
>>  	case NCI_NFC_A_PASSIVE_POLL_MODE:
>>  	case NCI_NFC_F_PASSIVE_POLL_MODE:
>> +		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
>> +		    NFC_ATR_RES_GT_OFFSET)
>> +			break;
> 
> This does not look the right fix: nci_store_general_bytes_nfc_dep() will
> return success to the caller, and processing will proceed even if the
> packet is malformed.
> 
> Looking at the (rather incomplete) error handling in
> nci_rf_intf_activated_ntf_packet(), the latter function should error out
> with EINVAL for truncated/malformed packets.
> 
> You should return a proper error code here _and_ handle such error in
> nci_rf_intf_activated_ntf_packet().
> 
> The same comment applies to the simlar check below.
> 
>>  		ndev->remote_gb_len = min_t(__u8,
>> -			(ntf->activation_params.poll_nfc_dep.atr_res_len
>> -						- NFC_ATR_RES_GT_OFFSET),
>> +			ntf->activation_params.poll_nfc_dep.atr_res_len
>> +						- NFC_ATR_RES_GT_OFFSET,
> 
> Please do not include style-related changes in 'net' fix: it should
> include the minimal delta to address the issue.
> 
> Other similar chuncks below.

I almost forgot: do not send you patches in reply to older revision: it
will foul patchwork and make the review process harder, if possible at all.

/P


