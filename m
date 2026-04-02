Return-Path: <netdev+bounces-274504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICxSFkVZzmkxnAYAu9opvQ
	(envelope-from <netdev+bounces-274504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:55:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A575A388A49
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 703C630E49F8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91663E025A;
	Thu,  2 Apr 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPhOcr/Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="enP1a3Or"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40763DDDB2
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130400; cv=none; b=CsMVlgsw0v7DkK6b7fFF3BY3EXIqToJs5iOCLT0tWQcxTR7kOviGXhEi2Ia0i4VfbVCfSjc/7+HkKSWiN978PtORuoae/B5efYWdH4SJtdjJCeOHQ7J+GXBfMbm9/6468cHlPkjMouj/ru4tNJFSB5gMsHuJX8+yEraGfqWSo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130400; c=relaxed/simple;
	bh=96/WVMIDSBKKgJSfQ4EIO42g3fE0wTNJnou+Effn79M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPtE2tK7+841SYc/lUWtnZKOI1odDpGp3OvZT76+EMgx3CM5IWep93AD7gjE4iToGY80uK7nXakh6j5M9RMbfxZ3+e4FVdgnhgHCHYWWqx6D98vyzBPJFHencxtSy0BPT6GfnLnFSpNl0wNDtzgHvC3JVtdeef030MWBHtDHvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPhOcr/Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=enP1a3Or; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775130389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WURTvV+4CxxPQ1jYB89C/0nV6RrkAMgvkGrvpp0Vmfk=;
	b=UPhOcr/QGPtWmNzdv/wi2PljI+aNH2/qsv4IVAGrlw7A8fVIXWrOanGr655u5O/kWwm/C8
	3uiUIhSQ331Vw81W0kGa20EAFxrfNdaD8hmvTSo/3Icv1F8zsrEz7pq92g1674EcSr5DBM
	R0l4tQmV5GqcdfPumjrGUGXKeXf49xw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-hhOalWF2PVWA9d8NQSXcHA-1; Thu, 02 Apr 2026 07:46:28 -0400
X-MC-Unique: hhOalWF2PVWA9d8NQSXcHA-1
X-Mimecast-MFC-AGG-ID: hhOalWF2PVWA9d8NQSXcHA_1775130387
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fb142205so7017235e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775130387; x=1775735187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WURTvV+4CxxPQ1jYB89C/0nV6RrkAMgvkGrvpp0Vmfk=;
        b=enP1a3OrP3GpfEEarv4+JTv3C0WAGcaypormI5DRQkQ5YXwR7ky3e+AFOu1sjrnvzh
         9cPQDCzWeN2b31nlCHoOf7LMNSGO7zMtmHNhZ6CSOWHa3bzZmUx4x2kfs1DlHv/+lH6g
         zgqCE4VCWfAqrFuA+BwVmuZwTEjXd5dijRpvrLtt+bN0KDpJ2cMNImME1kxkwAFVZFhi
         iNL3vRXdE+mTi+vcHzNFfHtRF0IIzuo1JwhOEIekOFDT1JqfiRcGK7CA5fD3+3HlfQ7l
         yKQlr15Qr8m1ygIf+FjX/EBQcgBwL6N04bb1KpzBntxJS0GVg5ha2OU8Rm9YSxpHGYF6
         q1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775130387; x=1775735187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WURTvV+4CxxPQ1jYB89C/0nV6RrkAMgvkGrvpp0Vmfk=;
        b=N2W22m9PWCpIaZgkZXeiUURlrKquQmV9MgCmyp194+e0SfwxuImn/9Y65R4SJEJarW
         gxa2kAC4A5qhOBGzpuy+pupmU+JqnX/gtQrmjxA/pzJBmNb0V06aH+DX7O8Cx5XEvd+t
         o5qY/Hqv1pFl4/A464hJ+EZ/5LIWLRVI90M90ByXzNL9FrIMQ9Pm5I/0aQNFVpztWM9H
         /62Lks0fZ9XspukjALuDqngc2bW6HwJIVp+2+WNOpvblhg+GvFJcB7sECwcuyxfAifdJ
         GwP5ItsSSSNUOG25RHWqS3unu7GOVMsXg/CLkBuAM+ivjQR3pA2BYdM/FpHLrI9pDJBo
         10XA==
X-Forwarded-Encrypted: i=1; AJvYcCV3uR+gquG93By02f5Bcnh/8YudEnat6UhLjeJQ1GB01zCkB6swIE7D0xRyV1OcFUK/Tw3eFZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyms+eJMiba2EnItB4aM+B9/QdYDO50Tfkp95ccfJs+4MfwL4NE
	q2uYxA4UEPmpamqEenkPipzgAHf6bHdVHsknoigOdWNqy4SwF/HqKe3bQxaFTDxuSeFTyhXoNMU
	qgoOGl7Dhb1p5GqMkOZESZIdte8ozbNoxjbjRS+F7UPfs6D8RbK1NUnwHRQ==
X-Gm-Gg: ATEYQzxMP+E5in3cQXy4wuQu5tCsi2F/r7rAQhpnigwuu4CWQ6LHWs+de3zUkTGERtP
	Gfdits3+WR0QfQKwMimfwZYBkzvnzhRBzICOOWDUufIZdA191xqzT7u+ZT1LM3LHfBvHJ/vep/9
	OAwoK6OBHeoTRfTaNVK2aO9jbbgxo6VVd3Z+xfjlz24o5H2wMpAV8rTaieNjrehna97ALZOD3sN
	j0FvIjh+Xeqzal6eEPJ0uqMlevZG3Qu0oel8GSdZVkYHoR9GLvwpJIYOpMQhFFKclaYNV8ObPFq
	ZMFOpDiiE+UEWg8wrtrL/weK59VhYLDLfgM4nh0s7Xz7xtSlUSTCy+eGp293SfAQy9AdW01+F+F
	+vrzhAwb50VkA3SzGxSYnpS6xdsglNxkfhu9NccIUYi9OjoiWK1eQOTGEBA==
X-Received: by 2002:a05:600c:a406:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-4888b7a0b07mr41585385e9.29.1775130387295;
        Thu, 02 Apr 2026 04:46:27 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-4888b7a0b07mr41585005e9.29.1775130386828;
        Thu, 02 Apr 2026 04:46:26 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm62293295e9.5.2026.04.02.04.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 04:46:26 -0700 (PDT)
Message-ID: <d088beb8-d957-48a9-85c6-85775fef2ef4@redhat.com>
Date: Thu, 2 Apr 2026 13:46:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: fix out-of-bounds write in
 bnxt_alloc_vf_resources()
To: Junrui Luo <moonafterrain@outlook.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Prashant Sreedharan <prashant@broadcom.com>,
 Jeffrey Huang <huangjw@broadcom.com>, Eddie Wai <eddie.wai@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
References: <SYBPR01MB78817B7EE349BB2CF0FC6873AF53A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <SYBPR01MB78817B7EE349BB2CF0FC6873AF53A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274504-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: A575A388A49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 11:57 AM, Junrui Luo wrote:
> bnxt_alloc_vf_resources() derives the number of DMA pages for VF HWRM
> command buffers from num_vfs and stores them in the fixed-size arrays
> hwrm_cmd_req_addr[4] and hwrm_cmd_req_dma_addr[4]. The vf_event_bmap
> bitmap is similarly fixed at 128 bits.
> 
> If num_vfs exceeds 128, the allocation loop writes past the arrays,
> corrupting adjacent fields in bnxt_pf_info.
> 
> Add BNXT_MAX_VFS to cap num_vfs at 128, matching the existing array and
> bitmap capacity.
> 
> Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h       | 2 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index a97d651130df..cee67ca2955d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1398,6 +1398,8 @@ struct bnxt_vf_info {
>  };
>  #endif
>  
> +#define BNXT_MAX_VFS	128
> +
>  struct bnxt_pf_info {
>  #define BNXT_FIRST_PF_FID	1
>  #define BNXT_FIRST_VF_FID	128
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> index 7f9829287c49..18ac0aaf4166 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> @@ -459,6 +459,12 @@ static int bnxt_alloc_vf_resources(struct bnxt *bp, int num_vfs)
>  	struct pci_dev *pdev = bp->pdev;
>  	u32 nr_pages, size, i, j, k = 0;
>  
> +	if (num_vfs > BNXT_MAX_VFS) {
> +		netdev_warn(bp->dev, "Too many VFs (%d), max is %d\n",
> +			    num_vfs, BNXT_MAX_VFS);
> +		return -EINVAL;
> +	}
> +
>  	bp->pf.vf = kzalloc_objs(struct bnxt_vf_info, num_vfs);
>  	if (!bp->pf.vf)
>  		return -ENOMEM;
> 

Makes sense to me. It would be nice some explicit ack/testing from
someone @broadcom.

Thanks,

Paolo


