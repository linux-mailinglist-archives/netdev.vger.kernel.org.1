Return-Path: <netdev+bounces-301346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gwKhMPRmOmqY8AcAu9opvQ
	(envelope-from <netdev+bounces-301346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FED6B676B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:59:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EU69jAKG;
	dkim=pass header.d=redhat.com header.s=google header.b=Kh4Nlm7H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301346-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301346-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB10B3041A47
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70E3D0939;
	Tue, 23 Jun 2026 10:57:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997543D0BE4
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:57:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212270; cv=none; b=cy0ZkdYsXaeFFmy+63lBAqHRX8yOgfy2vRrP/M3dhNHLyNTDpbArsEXEfwLWsGeVyvKu2WQkuPetCa+JFbJP10njh31A7R0hKhjR9LtntDcmjXKhqBVe/Dy3hqQ/Ks6P6ElWpF3sMuTYkSSvEhZSREUwkMhgnOyQXsibmxphPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212270; c=relaxed/simple;
	bh=w284zWyGlA8zSLYL9YiCV7XpcJPGn/1WTChcWaTE1XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIE5Y9O6OHbYOjfHhYkLYGgipIB0OSzNljNPUAa1LxKKfrQ5MeRx3giDgrdFhTUZ14eB+Bsn5GID7fz9cTNvrxBf6PF5jaFdtm6PPoyUvQoGyY93dZ/IZpb1IIofXdtpSY65lJw4m+HJMjgYQL+QWykBOBJx7R9KZCZ1kbEaUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EU69jAKG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kh4Nlm7H; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782212267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qdcx8pE/nw7N4Xhb05KzxoHXjXPkYTO5AuxwEAinnqw=;
	b=EU69jAKGPb4VIDZnUBuf0WUo4KfL9SAcXw/ex8q8DANQJT56Uae+WTJJa6NdXPJc2AHj2M
	uGOMK7czZkiCghwQXfbKXZueHNJQbcxvWMecITFDrD0cW92eMSFCQU0GRlR2g46vkYxsHN
	ukpXtgtPWYOOEm9CB+hMUppClBr2yaY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-pHqLVa_gPTuWI6LCcmG4Qw-1; Tue, 23 Jun 2026 06:57:46 -0400
X-MC-Unique: pHqLVa_gPTuWI6LCcmG4Qw-1
X-Mimecast-MFC-AGG-ID: pHqLVa_gPTuWI6LCcmG4Qw_1782212265
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-463aaa77ffeso3417474f8f.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782212265; x=1782817065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qdcx8pE/nw7N4Xhb05KzxoHXjXPkYTO5AuxwEAinnqw=;
        b=Kh4Nlm7Hghx0KI6TRRGzjvzXH5y5SE8H04TGA5r0TdrqCnFnpumK1eD7GZdscVyfQV
         RCEj9kleREP37KVHq6vKFBTh06eIoY6nLPjeIKRP9UPASok3J3SDgAojutu2MgAfKxmX
         U6eIMPLWGct+x3WISt87APtgmDpwIvJnAECoJA0BsIS+LkqtxhaiguinyfWdmNsIrdPZ
         kae6wJRMdqvqsLDUjfSC8Mq1P079MSsTs72ZXJCELrB8nitsUWtKYj4iyDdGhtrUxguT
         nfMHCPIq+jfKvHEyf5uQdKbqmie+qi/FV/s9CPAK0mKR9UxW4IbSLxYyPUK6h4+7jtUx
         znwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782212265; x=1782817065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qdcx8pE/nw7N4Xhb05KzxoHXjXPkYTO5AuxwEAinnqw=;
        b=dpu23L4lLUmVwZ59xzAW+4v5EaoS3cT6ZWp355XaJcicfmxyWet7k9KmZ7enTnWsCL
         Zq3ZmknW0HbZ6y3o17CXh9HeSlsY7p3V6c8EcdMw29eAYNvwyxsU24hvpRT6EaNj5rRK
         8f9oCIxhOSKBtSGRWl5kTdC+G7pyqdwpYrfcka+gAiB0iyQUasqAEkhnQI4oTngNwc64
         xOtiXsvqp1nOmkjmRmnq9NgN78Uq9p/F8mYSfC0BMItyBoXqH19ZWa713jcYKELdtgQ+
         vnyk52WSvLDPePDXEhScqVPqYhVThk+L8oiIkKCkpOVCbj+9PmaYO9PGbWaucjZT0I93
         RqDA==
X-Gm-Message-State: AOJu0YzZ03gz08HrYxa3k06F2iZofgGhsTSHXrYLVK0a0RvI/1QlQUdq
	AE4WuUP30Hd0ckeVb/ofnAmvNJfwGRNWdfJUmqP3RBMs6y5y2zKYmtjO9dy0gap+4OTDkT13cHS
	ONGdcKGsb5PRhuJSKm8/QolBIdVn6x+/vWW6atYfZNzIUVAJRnnS5s/Eetw==
X-Gm-Gg: AfdE7clqzYC/de3GEPwcmxrQObZFbGpfL8P4n0Kdpwy0TCvUryY4PIPxLeBLazpi7La
	EEYQpWH5dnBOIus6TZn6AnCJgX0oZBtwhCd2GVoF3B3QBm6u1sVFM3fBga7Nt/Z0GXMHEp5dLqa
	UiBPDZgVUoWAv8+d3lSBNVhWXJp4FAd66phZHMKNYdtXdlcR8TyNQMcZh/v1j8TjL69emXU5bB1
	OJ+FPQ3H1NEbG4xoi/Pk0olVy7QUkMUcmDFLfIakuqi/zQW4XRtoExl1mjBzKHIqZzIBDyylDLQ
	OcSQw//ZBcOO+DQzXVEcmq9xYb6RxWmS85ZSp4zGaiK/wEA0P6eDaGsrSWb5mYKzokojaJgpjw=
	=
X-Received: by 2002:a05:600c:e558:10b0:490:bcc1:4edb with SMTP id 5b1f17b1804b1-49240e95442mr204023895e9.27.1782212265005;
        Tue, 23 Jun 2026 03:57:45 -0700 (PDT)
X-Received: by 2002:a05:600c:e558:10b0:490:bcc1:4edb with SMTP id 5b1f17b1804b1-49240e95442mr204023585e9.27.1782212264580;
        Tue, 23 Jun 2026 03:57:44 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494496cdsm260372885e9.10.2026.06.23.03.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 03:57:43 -0700 (PDT)
Message-ID: <987aa5d0-9ca8-4038-b77f-94adba497e40@redhat.com>
Date: Tue, 23 Jun 2026 12:57:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: clear the default forwarding VSI rule when
 releasing a VSI
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, michal.swiatkowski@linux.intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260622081030.2312129-1-poros@redhat.com>
 <20260623102934.1072800-1-horms@kernel.org>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260623102934.1072800-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301346-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58FED6B676B


On 6/23/26 12:29, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ice: clear the default forwarding VSI rule when releasing a VSI
>
> This patch restores the cleanup of the default forwarding VSI rule
> in ice_vsi_release(), clearing it when the VSI owns it. This prevents
> a rule leak if a trusted VF enters promiscuous mode and is then destroyed.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -2871,6 +2871,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
>>   		return -ENODEV;
>>   	pf = vsi->back;
>>   
>> +	if (ice_is_vsi_dflt_vsi(vsi))
>> +		ice_clear_dflt_vsi(vsi);
>> +
> [Severity: High]
> Is there a time-of-check to time-of-use race here?
>
> ice_is_vsi_dflt_vsi() acquires and releases the filt_rule_lock to check if
> the current VSI is the default. If true, ice_clear_dflt_vsi() is called,
> which acquires the lock again during rule removal.
>
> If the lock is dropped between these two calls, could another thread
> establish a new default VSI rule before ice_clear_dflt_vsi() runs?
>
> When ice_clear_dflt_vsi() executes, it appears the rule search only matches
> by l_data and flag:
>
> ice_switch.c:ice_find_rule_entry() {
> 	if (!memcmp(&f_info->l_data, &list_itr->fltr_info.l_data,
> 		    sizeof(f_info->l_data)) &&
> 	    f_info->flag == list_itr->fltr_info.flag) {
>          ...
> }
>
> For the default VSI rule, l_data is empty, so it might match any newly
> established default rule.
>
> And since ice_remove_rule_internal() does not appear to validate the
> vsi_handle for non-list rules:
>
> ice_switch.c:ice_remove_rule_internal() {
> 	if (list_elem->fltr_info.fltr_act != ICE_FWD_TO_VSI_LIST) {
> 		remove_rule = true;
>          ...
> }
>
> Could this blindly remove the default forwarding configuration for a
> completely unrelated VSI?
  The dropped lock isn't new here. The whole dflt_vsi API is check-then-act.
  ice_vsi_sync_fltr() does the same if (ice_is_vsi_dflt_vsi(vsi))
  ice_clear_dflt_vsi(vsi), and this path runs under vf->cfg_lock, the same
  domain as the ice_vf_clear_all_promisc_modes() cleanup it restores. There
  is at most one DFLT rule per direction, because a second default VSI folds
  both into one ICE_FWD_TO_VSI_LIST, which is the leak this fixes, so the
  empty l_data match is unambiguous. In that list case removal honors the
  handle via ice_rem_update_vsi_list() and drops only the requested VSI. The
  unvalidated whole rule branch is only the single VSI case where that 
VSI is
  the sole default, so removing it is intended. An unrelated removal would
  require another context to clear this VSI and install a different sole
  default in the gap, but those flows are serialized per context with rtnl,
  vf->cfg_lock and ICE_CFG_BUSY.

Regards,

Petr


>>   	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
>>   		ice_rss_clean(vsi);


