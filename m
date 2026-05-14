Return-Path: <netdev+bounces-287906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI/bBM2hBWo1ZAIAu9opvQ
	(envelope-from <netdev+bounces-287906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:19:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917E540509
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8990A3014133
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052A3A961A;
	Thu, 14 May 2026 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKHc1P2N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEnEIi0b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1EF3A7598
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753994; cv=none; b=rrZLCgGus8ZfW9LYnHsECz7M6G2DKr2AAewLWVHIPUaQmSnTX5AEA25t+XgpZQGtcMUob3JW0/C5YISWVJ6fsXIdcCo3T8CA800+dASbETweOKDUwgv76TZXKho7DMM+AEqVY3/RT6ukFQmZOMadq4lQxik6uLWEybg+3dUu7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753994; c=relaxed/simple;
	bh=0IKmOUzoumogJGoyd4uqy+VcQGNDmcN+WpyYRRIEP7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdV40dHj5wHivrNrfYcJyckigxaPflAOm+EZ8AOS3ufTr4s7v/xe7MtAKBmWebM9FjtiICn0gVV9jKNL4J6RmwM5C+/xNFF3iCoDWhxCEXn14mDZm8jCWeaaoM1zCSUq3wnLm0vB0Np87if5wCC0+V8Hp9y0loPIE1c+N0xqXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKHc1P2N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEnEIi0b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778753991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
	b=hKHc1P2N1cDAS+8QPdy26MEpDOeD8YJqsKQjt4jGMD4NmynOfkV07ddA13HbAFqukvOsMf
	/i2uCwi9rGPTLsaCkpPV5BW7Xfiv2D4dvvd/gsMQNUZs7UP1n34y7KDUejkano/JHLOMWq
	c/uItubeF1AqwWtCrODupFm50eq0flU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-cQtFflYvOvmZD8lcTGb_2g-1; Thu, 14 May 2026 06:19:50 -0400
X-MC-Unique: cQtFflYvOvmZD8lcTGb_2g-1
X-Mimecast-MFC-AGG-ID: cQtFflYvOvmZD8lcTGb_2g_1778753989
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43fe791a398so7153823f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778753989; x=1779358789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
        b=QEnEIi0bXeEekfIT4LaQXPEyyWxKR/fM3yitOQvv6rbkM31EKL/vl0CMih+c11ZMQn
         MuYjbdJp8zklxo/ITCoZugDu9suHUE0LPVaGFdDonMJm3Y7CDowfmas1n8/y44WdGDGy
         jdTf8DVZOJ94hBHayPqbCA+YJc+wh8M2M8WlSlwkIQBAXPemBQXX62bAGaSQFV8SuCxe
         5TZgXcc6mNnEGFun0kpxbQ7vNmTS1iVDTN+yibj+BHPczdCUg9B+otRt/elpKp8Z9LL8
         /E1jX9BMZfJi/MCUCe4jALCppaoS0vAVi2LsV+Acu21ryxw4Rp6PbMHNcqPDtdFpiQmV
         2mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778753989; x=1779358789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
        b=Fw5QWkW/aeizN5iA6TFL53jE8dIhDOljmj08sJnLUdEJT2eJJELWVaD7Pc8kx9QPxF
         XpfaWqy4QHdGfvJVtJyZH0FI6l8oHXvJtFp8Js22AijuY3IEg9xficFApIb5U5sPw0tG
         ikq5c/atSXKZ+tRyOInmFzhu5GrLA5oHJ96sKd7OUA9EIA20B6klQ68ChftiVu3nBH0V
         5TVIieKy67AhZTWhfCrFwxzJWDxz7B1RhUCYISfq0AnJ5GkU/OcViFZXJ573GAm3eM/I
         3ExIM59cM1kPez9vuWArOeGSV6iodjFWg6Ec6VzsiRWiWwn5AGd6SGzQD8wke3pQ/ojA
         mzrQ==
X-Forwarded-Encrypted: i=1; AFNElJ966T5qmp/KSzLQwcrcv+trE1OUeU5Xrq+QNNOQsK1oXN88sSbevuFlWmBt8vvSalN6R4M/zh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykP3zKBY474Ghne18tOoIIW/byIWDMO4lnJSf+8fGv/cKAQh6O
	SgraAYvoiXSRZKujn2i7XOpFHKf+l2otnf2gY1lAQ6U1xj2fEqA8Uzp3qRZSTFIhvadj5DDid9C
	hb5rr+FaBQBhAa20Ew0vHCefvCnru0Y+x/KMC8CcgYcCmZnkFCl4MVjQMBA==
X-Gm-Gg: Acq92OGPYrMWzCwa8k2r2jQ6UL1/YEIiTnOSpTRxT/EQj7LqMxTF0aGk64wrSJD/FQX
	vMBHVwrD2Kbp5Ls/O9bUByJFlddW2l3abYdhbbUii4WFYfJYJe5zP2TFl1KpSQAXMpAurIAB93Q
	GSuT0VfUqH91TWaPKFkjLcgFOk0/qGc/p/QeTon8pcwCmefXalvKKmH36hFQ+TQ+Wu4su/6TMOI
	TE0x4chq4/f0aDrrhK5XKUDqmVgkccP01rojXlYtLybqKMJWEvAPL/t5hRTC4jkPcHlOdi3RIfc
	+R0kXz9xC06ywocYnDJDS3ckcjWdlePQScgSs/9AsJ0Ddpz3i7Ntq6wOlmrpeOd7eMid6h1HiHP
	YN6nO437UKhkl9wLBv3kWPw61wo1MNt4sBdRscNazgSzg2y9QlBo2jfE=
X-Received: by 2002:a05:600c:1f85:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe1accbf4mr11294205e9.10.1778753988933;
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1f85:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe1accbf4mr11293815e9.10.1778753988485;
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6276741sm26923115e9.0.2026.05.14.03.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
Message-ID: <deb3e868-456c-43a6-886f-9d882d23975f@redhat.com>
Date: Thu, 14 May 2026 12:19:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, ubraun@linux.ibm.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, bestswngs@gmail.com
References: <20260511062138.2839584-1-xmei5@asu.edu>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260511062138.2839584-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8917E540509
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	TAGGED_FROM(0.00)[bounces-287906-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.492];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,asu.edu:email]
X-Rspamd-Action: no action

On 5/11/26 8:21 AM, Xiang Mei wrote:
> On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
> reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
> populates V2 entries starting at index 1, so when no V1 device is
> selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] ==
> NULL and ism_chid[0] == 0.
> 
> smc_v2_determine_accepted_chid() then matches the peer's CHID against
> the array starting from index 0 using the CHID alone. A malicious
> peer replying to a SMC-Dv2-only proposal with d1.chid == 0 matches
> the empty slot, ini->ism_selected becomes 0, and the subsequent
> ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
> offsetof(struct smcd_dev, lgr_lock) == 0x68:
> 
>   BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
>   Write of size 4 at addr 0000000000000068 by task exploit/144
>   Call Trace:
>    _raw_spin_lock_bh
>    smc_conn_create (net/smc/smc_core.c:1997)
>    __smc_connect (net/smc/af_smc.c:1447)
>    smc_connect (net/smc/af_smc.c:1720)
>    __sys_connect
>    __x64_sys_connect
>    do_syscall_64
> 
> Require ism_dev[i] to be non-NULL before accepting a CHID match.
> 
> Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/smc/af_smc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 185dbed7de5d..12ea3b6dbc64 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm *aclc,
>  	int i;
>  
>  	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
> -		if (ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
> +		if (ini->ism_dev[i] &&
> +		    ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
>  			ini->ism_selected = i;
>  			return 0;
>  		}

Patch LGTM, thanks!

@smc maintainers, please note that sashiko reviews:

https://sashiko.dev/#/patchset/20260511062138.2839584-1-xmei5%40asu.edu

pointed to another pre-existing issue in this area you may want to address.

/P


