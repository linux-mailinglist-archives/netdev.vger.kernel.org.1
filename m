Return-Path: <netdev+bounces-284262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDwBF8+r+Wmh+wIAu9opvQ
	(envelope-from <netdev+bounces-284262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:35:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE14A4C8BB3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E08D93003D18
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F62F9D89;
	Tue,  5 May 2026 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEWPacXw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA822F6904
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970124; cv=none; b=MEDyy+iJpIE5y5ZqA25x9IR0iHa73SbsBHjB0VlFESgdf/nN4e7tqv4UMp9ZCN6VTrAuHi9E2G2vuvcurw3WGBpS4xlg562MBS38R7mvR4TVqGCoG9Jr/IPjBiORHJ+jRMsi/uTe6drOnLOBaNiz41cx/PPU1SvFLaOxytbxXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970124; c=relaxed/simple;
	bh=/BztKCQHCX3RSuLHQyfhOjJRVgQJCVztxTh+DTSkwjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhr35m5GaaGwruT/+dBMIHG1M1plwIyzCkweGFZy83TrFSEdBdELPv4YEYqKwENG7ykkGUeHX9CUNUiCJ9fOjE3hPsSsgc0kIamGEiLafXANLuRkNG5OgnInW5UfuMJI3HuGisp3DeiOUarnrwRnE6YZXXrzOEtWnb7YqLmGLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEWPacXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777970122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5JhLbPt3+z2C8uQsYp93wOnCY+8hxnshKHRr9sJgTc=;
	b=VEWPacXwHhnvJrlCyZpo6DlFD5IGv0v3VvC+6MQ+VbvbIUsh+JGfqHDzagPlz4+m7t6MdA
	LKPGT6sW4RE7p0xV4PBkJpq1HN2+DvDP/U0aQ+RtTn6IyjafPdaOAjBEBwxnyFXXJidRYY
	pMB0IfhXreZKjQMzjhCe1h2Pi4QP610=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-xjE9CLXDM_i4IVJMwgCyRQ-1; Tue,
 05 May 2026 04:35:18 -0400
X-MC-Unique: xjE9CLXDM_i4IVJMwgCyRQ-1
X-Mimecast-MFC-AGG-ID: xjE9CLXDM_i4IVJMwgCyRQ_1777970117
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 880C9195608C;
	Tue,  5 May 2026 08:35:17 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B463630001A1;
	Tue,  5 May 2026 08:35:16 +0000 (UTC)
Message-ID: <4491b157-210d-41ec-8679-6932b3749b90@redhat.com>
Date: Tue, 5 May 2026 10:35:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15] ice: dpll: fix rclk pin state get and
 misplaced header macros
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
 <20260430-jk-iwl-net-next-2026-04-30-v1-14-6f27ae1cd073@intel.com>
 <97261b38-3251-4b13-a106-67e4b4ecc8c8@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <97261b38-3251-4b13-a106-67e4b4ecc8c8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: EE14A4C8BB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284262-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 5/5/26 12:39 AM, Jacob Keller wrote:
> On 4/30/2026 11:37 PM, Jacob Keller wrote:
>> From: Ivan Vecera <ivecera@redhat.com>
>>
>> Fix two issues introduced in commit ad1df4f2d591 ("ice: dpll: Support
>> E825-C SyncE and dynamic pin discovery"):
>>
>> * The refactoring of ice_dpll_rclk_state_on_pin_get() to use
>>    ice_dpll_pin_get_parent_idx() omitted the base_rclk_idx adjustment
>>    that was correctly added in the ice_dpll_rclk_state_on_pin_set() path.
>>    This breaks E810 devices where base_rclk_idx is non-zero, causing
>>    the wrong hardware index to be used for pin state lookup and incorrect
>>    recovered clock state to be reported via the DPLL subsystem. E825C is
>>    unaffected as its base_rclk_idx is 0.
>>
>> * Add bounds check against ICE_DPLL_RCLK_NUM_MAX on hw_idx after the
>>    base_rclk_idx subtraction in both ice_dpll_rclk_state_on_pin_{get,set}()
>>    to prevent out-of-bounds access on the pin state array.
>>
>> * The CGU register definitions (ICE_CGU_R10, ICE_CGU_R11 and related field
>>    masks) were placed after the #endif of the _ICE_DPLL_H_ include guard,
>>    leaving them unprotected. Move them inside the guard.
>>
>> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
> Ivan,
> 
> Unless you have any objections I will go ahead and rebase this ontop of
> net and submit it in my next round of fixes. I might split the changes
> to have the CGU register definitions change in a separate patch since it
> conceptually isn't the same issue as the other two.
> 
No objections at all! :-)... Please go ahead, rebase and submit.

Thank you.

Ivan


