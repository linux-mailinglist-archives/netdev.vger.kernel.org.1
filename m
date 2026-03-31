Return-Path: <netdev+bounces-273647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFEPOFzUy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:04:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC236AA10
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82C563033EC1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0F3F9F5A;
	Tue, 31 Mar 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOZn6qtL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tJuo61I6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE23F99F9
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965823; cv=none; b=isey8Qg8XVoBm8ZWzi/5w7F6pIlI/CdD5vK63OMBqTZsxKJmYT4EUkwblagk00daC6iXgO6HwUgosSS3rD3rs/odCdwX+cafLo+Lh8a4J9Vfm8MMOuQve/GsZ/BkwDtCeuQ8Ym4IjamM+zod8AtdRdtlgeyRq+cTKbDIpzwMQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965823; c=relaxed/simple;
	bh=xrQq23TtbjZ94/X1hHcZDYLTSVmDS1M92DkIZdySJNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXHQjCWW6s2IbcE6MEIYZ6zzr39uvotrJ9s8z2OmAMIr9KTZbvfhoyyS3OgnOQgPIRpFgpF8qVat6VLUuMO5LrsTliA3bpkQgA9b0PApkDzn95wO9ULhWlqvO1pgvagLidZw32/VlzpAE7C/XsnDtdYpZt0yk9E66SCgBv4MT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOZn6qtL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tJuo61I6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774965819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQEk/FtRrWUwmhDN28lgE3xRb0D8fD62ggS2FOnsJI0=;
	b=DOZn6qtLBAfflYmXYMAwF+66nT9RD/sjeol3aBPAKXQ+Orq2G2ZF9hqeSJ8X1cMOQpwCCr
	4BrQtqFC/a91jrshyVBV/yptlnpKU35SkcRVP4dBTYnZ1XHv0lKwp2XfBsG+jINWaG0/5d
	ZS15rMj19wwefCEVFfcmtOSXqe9tU5w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-7iQY0t9NMbyfW3DthtdkHQ-1; Tue, 31 Mar 2026 10:03:38 -0400
X-MC-Unique: 7iQY0t9NMbyfW3DthtdkHQ-1
X-Mimecast-MFC-AGG-ID: 7iQY0t9NMbyfW3DthtdkHQ_1774965816
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cfb72377bso1834137f8f.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774965816; x=1775570616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQEk/FtRrWUwmhDN28lgE3xRb0D8fD62ggS2FOnsJI0=;
        b=tJuo61I6gMzcX/SngnKPcWbPT05FzDElYsJf3UC/L3+nYjg54QhslnzuMmuRHtdhFY
         4husc5rmPVANDyJCH8BmijR42Z9CY4DTO8gVp6eF4TRrsugagIXVfjPJu7SIkMZRW6ty
         GuiJV7yiE3tE62Cnc6b4OmsDfE1NAEYrgOunn5LBnp7+7D8WG+xfukZYN+/k8babY2VH
         RmMnGttjkY8uZlJgIwjDJK0ZP+TxRGjVNsh2hWNs1HGwEwi54D8IQ7gc7o4e/C1vfYAD
         FqfQbloLM14STGErDqTLj6oL7gA1lY55tsckwBK/Q6L0ZOkD7lWbliMOxZX3hwus4hEq
         GIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965816; x=1775570616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQEk/FtRrWUwmhDN28lgE3xRb0D8fD62ggS2FOnsJI0=;
        b=cXEYZTrsT+8U03ItbAIpE0uM/AatwIn5+Z3HdqhA8YoG0rTUNXYIOzuAC1qquIshDJ
         ymUJyfSdIT87LXSSZuOQTjp7EWincav+ioWsOCbXAUCvN7JLDcfCFdUBlyt2xNqUQEXl
         2kiIRQr9j3Q2xwAWz50YSk4aLIj2ppKqHuTqZ+KKGtddA3Lcx5rAW76h58zpvxO+RgRS
         57ABMEhw8xiReIrFtBKcop7zMWulLD4oms7mhG/8MSkQ+duRq2Op6iAVSSLrjrNALibV
         jMVMjzUnwWHMjT6284qu2KhqKLj15KeQGIfUc87icE8gzjdTlOjTtCqzJu9W8ApwkNiy
         A/nQ==
X-Gm-Message-State: AOJu0Yw5Hi4mCrTDW1XW0rDdp9eSLsFEFAC2rPXL7vL7owFNVIr1QKMm
	QwwcHcjjy2FaamsFh7a1PH/2WTqfmLlS/JwEF9X1dxSmKHWQM593G8ZamJh/yCc+MU3iqIMnHyC
	hYG9Ze8Gu/WKW8boPA7g/r533+ekQctvkkecNIBzISGhfdBZNvcszzz3YbA==
X-Gm-Gg: ATEYQzxXxzGelQFDR9gUVljQPOVXVtVc2a51co1a72aNimoUlC8tju3Bz/GTrvwlHcl
	gGUtoOR1e4DhORo8uN744dmZMmgelErOZ2ds7jE1bj0TfFPxjI6/2CiXAuOG9raAn3H/gDwMH2E
	T+AJ6R9LLJcIZv716raBbPWw428Mz3EoCr7Bgz7Po7UmEFzG5bXI4bs6QSFJNP3Sqb3Li7Je7hR
	Es6mjrjeBK027nECd8S/oYxTVcsOSKk9M6bkQ8jDfLOcSWUf1eJ+sWyC8iwTm62EiOttS9ZRjzb
	4z9BN5pN1Sbmd2f/bNuRFfcndDll1WXK30kqAq5TeVhs/uod9//jwxurKG+d+GTXs6+JdVXTuV6
	W6aGyMqIc48Q54EnppfupThf6KYPduLzA7N0nutZR3tpONIjomV618mUn
X-Received: by 2002:a05:6000:4203:b0:432:8504:8d5b with SMTP id ffacd0b85a97d-43b9ea76473mr27821374f8f.50.1774965815829;
        Tue, 31 Mar 2026 07:03:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:432:8504:8d5b with SMTP id ffacd0b85a97d-43b9ea76473mr27821292f8f.50.1774965815217;
        Tue, 31 Mar 2026 07:03:35 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm28751972f8f.1.2026.03.31.07.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 07:03:34 -0700 (PDT)
Message-ID: <3e8bac40-5400-4eb0-9a44-7174efd805f1@redhat.com>
Date: Tue, 31 Mar 2026 16:03:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 06/10] bng_en: add HW stats infra and
 structured ethtool ops
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com
References: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
 <20260327201343.16146-7-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260327201343.16146-7-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273647-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CAC236AA10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 9:13 PM, Bhargava Marreddy wrote:
> @@ -1024,10 +1208,12 @@ static int bnge_alloc_core(struct bnge_net *bn)
>  		txr->bnapi = bnapi2;
>  	}
>  
> -	rc = bnge_alloc_ring_stats(bn);
> +	rc = bnge_alloc_stats(bn);
>  	if (rc)
>  		goto err_free_core;

Sashico says:

---
Does tying the statistics memory allocation to bnge_alloc_core() cause
accumulated statistics to be lost when the interface is toggled down?
When the interface is brought down, bnge_free_core() calls
bnge_free_port_stats() which frees sw_stats and clears the
BNGE_FLAG_PORT_STATS flag. Any ethtool queries made while the interface
is down will then silently abort and return empty statistics, and all
historical counters will be permanently erased.
Should the software accumulators be allocated once at probe time so they
can persist across link state changes?
---

Please have a look at the full report, it could include other relevant
things.

https://sashiko.dev/#/patchset/20260327201343.16146-1-bhargava.marreddy%40broadcom.com

/P


