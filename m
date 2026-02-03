Return-Path: <netdev+bounces-256215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOdJMba9gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:19:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4BD6B88
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9631305420D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C66395DB7;
	Tue,  3 Feb 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiFTRx3T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lf7zKLgU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D22EC08C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110361; cv=none; b=oQyAMZsfxd5DkPUjW+ashU2gf2bljsMuWqwSXB5mWFPHsYUs/HXoxJmV2zNi5H9cZziJo7hT4IGJi1bibXzhNDm6nHB1sGOgW67XJLgD7J52CAupE0kjjVCDzCU3sNgaLgKZz1gW8lm+n7anaVp/ypNTcR3QcNHJ/+XYSgopxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110361; c=relaxed/simple;
	bh=JxpEZ5tbLRwPZDvaOIBEHKKckKzdOtkFQm5l5V5uiLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH3ykUfXI28iSygiUNbLmtsOmb4RJd5mX8KcGYdfF9SxVvYcyuHt7JuH8DqAlpBzh5Te95GfqTdqi2BnPGM1l+86Uada9qK4H3IONVX+pdxbNG4dNZyDQUsqpHjzyah2+f7hgEHBhLV3322dkkdr8fZUuCYt51iclm+ZNhatohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiFTRx3T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lf7zKLgU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770110358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Jpk8ObAb0wujGpkASRD1s52R/DYhqpf5NMLaAUU7Vs=;
	b=GiFTRx3TVU5IHjqvizL0da8CskqET9HXXXdJfJq3M9Vp2S9rbJkDVkxUfl27Ie7oMuo/gR
	IZGabi5Yq6m37UK6GdHElUcMpB2y53GoPA/GTKqipyb1el5KzpWpuIS5isoIbU4LqpXx/c
	91bZ4W6+F/oH+ofg4GB7WRtdr0GhYO4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-27wu4zxuOMqGTAt7iHYdLQ-1; Tue, 03 Feb 2026 04:19:17 -0500
X-MC-Unique: 27wu4zxuOMqGTAt7iHYdLQ-1
X-Mimecast-MFC-AGG-ID: 27wu4zxuOMqGTAt7iHYdLQ_1770110356
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso46022485e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 01:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770110355; x=1770715155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Jpk8ObAb0wujGpkASRD1s52R/DYhqpf5NMLaAUU7Vs=;
        b=Lf7zKLgU0BESW9ko15HRt1UImHexqnAaZWfOa5JKsWI9mKS5QyHBwga8G6JhnDstHO
         0OcTUZ6OYvGlxs04PWjOW32LOL+5BMfmHbWukIaqGU/lNKLNlJoakTvXaPGCrK5fW+5c
         L3E1qdYMv9TfRcCW1zMYE41MseS9hr97V7jPnPcHdCCIg/AEtczWOfeOiTSgBrvD4Ohz
         Wf+ZXhJCEYHg3m0TTxEn6zfAxd+52CHXcYxraSfIizTw5xTXJHgABp7ljzN+TvO9yasp
         rKeqbvmbhRCfVpox+wCiE4b9hqw7rAR1GfVxadMp7+stpYrNnWH9nnV17u7SMJXKoXFh
         YdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770110356; x=1770715156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Jpk8ObAb0wujGpkASRD1s52R/DYhqpf5NMLaAUU7Vs=;
        b=bIAbYsnbe8b2BqhYrfxJ78VloRYHQVH8dderMXzWsHSbEyk13wa8AXkTkq3/K1odWT
         eB7GIl7MPyJC4wrCV5/5mIsAnGxWE0CIukucSLp4+Z3Nx/orFX27k0KsBfPmDUpDxmhd
         MSFbdhm+SODFNJxBHdxOF39EENa1iFsyQh5/BOl3X7YrVdXDUhLxfsyONAqb3qrwFl1o
         BKYcAeBSNE4isdfZcCksbdQhgN0rbyjR8t1ACVT10Oijt2SbtlIMWnbLNFY6wyKmDqbX
         5Y6zb2yI5Zyo0LLk60G4g4SOPx3u49XsQ/s0NSYKNAlQvQOlEAcVAZYgF6U3mZ54PJps
         D57A==
X-Forwarded-Encrypted: i=1; AJvYcCXGI9dAYez+j1KmbIf+VE8NwpKhfTRPM2PhOHWnpBrtafDHZRMijJPTQzXywI+CyKeytVqF5as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0KkbohBmL0NMVLazR5TVSVMfAAgvCyD6wfsBfgLHALAUN2+s
	mBS4hN/4kEKuXEAZfu260rHETWr/XrqfE8GmV5bCY2HIgKx+Vfsq+9WI4BGYWbjOqPjFEKInSqf
	B22od4nngLYml7pnyKr7uU/a2fganH9oGfswh65FUj3G6DKkIpjJkJRmviSt5hAzL+w==
X-Gm-Gg: AZuq6aLjPkDSU7xodefGc37r+Q3YxvRPVvZf8pyU15EHYWhKeNHqvlmJcOOFEJrm9U6
	8Yboi5e94HSVk2D8pvZ+MoMx9hf0+y9H0659R2/iJ2asr/SWDikl87rsYm4cc23b2vQ4N0C4eh/
	JDU3y+DJT5GmpiwhiVXmLkB/howmcS0aECIs6/h8UzV5DtoE1x0Qlr/OoySsvpht+bVuNJ58WV7
	t43nXdsuTYlMeBEY9/ybT1cVMP5QEThIpQTPhA+H705ICsdtkaIwGcXVl2qnJ3uz0UErLyscOgr
	y2WZT8F1bXNthsDe6Wjos65eTsGvsn80T78hJ6B1xZEDZQU0qdY8wR+25Gaklj6Jf0PkSEkr84J
	vi2JEMkx7KEo=
X-Received: by 2002:a05:600c:8b2f:b0:480:1d0b:2d15 with SMTP id 5b1f17b1804b1-482db486e65mr192394395e9.27.1770110355631;
        Tue, 03 Feb 2026 01:19:15 -0800 (PST)
X-Received: by 2002:a05:600c:8b2f:b0:480:1d0b:2d15 with SMTP id 5b1f17b1804b1-482db486e65mr192393995e9.27.1770110355153;
        Tue, 03 Feb 2026 01:19:15 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da6bcad7sm157523385e9.0.2026.02.03.01.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 01:19:14 -0800 (PST)
Message-ID: <90017867-2649-4632-8497-96e2592c73c3@redhat.com>
Date: Tue, 3 Feb 2026 10:19:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260202170518.9076-1-danielj@nvidia.com>
 <20260202170518.9076-8-danielj@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260202170518.9076-8-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256215-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44D4BD6B88
X-Rspamd-Action: no action

Hi,

The AI review reported a possible issue that looks valid to me.
Reporting the feedback manually because I think only one to the AI
remarks is valid, see below.

On 2/2/26 6:05 PM, Daniel Jurgens wrote:
> +static bool validate_eth_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct ethhdr *cap, *mask;
> +	struct ethhdr zeros = {};
> +
> +	cap = (struct ethhdr *)&sel_cap->mask;
> +	mask = (struct ethhdr *)&sel->mask;

This function casts sel_cap->mask to struct ethhdr * and accesses fields
at offsets 0, 6, and 12. Shouldn't there be validation that
sel_cap->length is at least sizeof(struct ethhdr) = 14 bytes?

Looking at virtnet_ff_init() at line 6291, it only checks that
sel->length <= MAX_SEL_LEN (40 bytes) but doesn't enforce a minimum
length for the ETH selector type. If a device provides an ETH selector
capability with length < 14 bytes, won't validate_eth_mask() read beyond
the allocated mask array?
---

Note that the AI review additionally reported a possible leak on xarray,
but I think it got confused possibly because it run out of token and
mixed-up the patch context.

/P


