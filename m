Return-Path: <netdev+bounces-270773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP/VAjO8wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:18:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D94A2FE2B7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85905301BC34
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178B37F8A6;
	Mon, 23 Mar 2026 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqrgnEMX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4035CB7B
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304289; cv=none; b=PUwj/szjk+a2qgNMDIqVdpaEIpAp7AxdOmDGzoetshdtniibT440K4snrCjt92Ch5aBrVMvHw1JYyVrQ0xTXV86blqw5E2RLytjvq2UPE8eE/kMFqj1ZvLND8vhS8Uj5wV1UKywp17TL2PNyVKDtIAUQ3h+As2MDM8n1HSemqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304289; c=relaxed/simple;
	bh=tfe0Vxv2opm5hw+ZzXeTgUj1EFeDY5O/sNZWlSnCo1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hocYPfx2YZBiu151LP5NNOHrpt/QFlgDwBw9bN05D/JiGFFMc4wi6sCVRY/7gHbF+2y94ZwQam0m85WhJBg42RYvxZ/qG4uLPKUDZDL5eTpGlry4VznHizos/F8Lm/qK9qBwTthIJvW4E9iEMT1dKCBJeFyGW3Q1hn3zucWXssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqrgnEMX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso39004675e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774304287; x=1774909087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvgmpqqiB57K4H68q5ZefoGrbBATbCDpybAH6NvYNSk=;
        b=LqrgnEMXUjOmOStWs86xwtpXktyEOyBoheTuLPP5Ne34EZBP7hPoGIGtNjUju8MExd
         YRbNS6Ld81kk/zLfTRWp5sLkA399W/Zh/L26rzcpjIP3HEHDUijeu/0SbO8RhxwSwRud
         2N7x1t4EqAQxIkXJLjLwfE84dK/cMjLaSXrj/0Ygid0a4sALjLhUZ0ADYDTNUQFLD8uW
         0EEBYS8DJN7RXCLWkLcuEUEIp4R87h8QcFoYzjZERMtFDEL3n9/TYFYCPRRu09Kmrx/K
         Qk0jE7HqcxAEC+RCLe/inmtp40GMSqHzENQSJXFr2Nd76VRYr+xARs53z2V3yPwjw6YX
         T7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304287; x=1774909087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvgmpqqiB57K4H68q5ZefoGrbBATbCDpybAH6NvYNSk=;
        b=asJ361jOD+cyh+4XWYKcyZ0on/kXe/X4XI+3+I2ZjgkjwYV3ZQZmz1SXgs8FI5gcAc
         E+VJztoYxE9uCYNoGoRYAwrPT5R64PtOuOORHEHvktWARSM55UNU/bCmKxZVkev1+dCt
         m9tXT+zkjRDTkUDLelqqpDVJEvFtuGHL+gk3iHp/97K7bwX/uhZJ7MmWJiuFc3j/h7AH
         OtwFjKVxXUa5aVoUcL31G1TojUSEE+HLdS5vGZnb/5n486Q5JYHQMvCtyWUo7xBDeBRl
         56Q4BuL457GPemYvpydQHx4it5+CnNtnNiDh/A7RbN0eoXNIsQ4Q1qmRJYYjUO3fgOlC
         TywQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyj2YeQwIWxVRbQkTwx1RlP2q7iJkp6WdTTnTEMDS4VbP/3j7cvDEFOO2LjZMEnvltBQKUANU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXZu9wDibBLbk7vte7BwqqDKMKhOZIHCllXvvoD08jzfHGj4M
	FvoDFOIui/tmNEru7mj1wlOhcSslWTEB9E9IepiUADLldCxiaNzdXH1R
X-Gm-Gg: ATEYQzzc7IFRIL/nthzJf9jHXGvtMgnNeQZGeNxBZmRzTczyIKcwmV0cEiIVFvzy7YK
	iQMADVJdVznf6nBy0C+i6VVWwO0hm8PQ2fibpiJX2hNVxXKCVMnePzjMKm0z8Q6kJQSBvkI7nTC
	KQOS4eyWCijoRgj/TljBmSR0+Kuf6pbtR555l5mr1u+5sUupfS3Ai/EYoGVqTL0D//BYrYHLfFo
	F0eG37ltINYOlFOgsShMnkix0OEbYhRpVRw4S29RJ5bKF6K4LnVUsFrWZOjtZoIcz6P5EbzP38j
	W1B5/FzLT5C6H8El42EL3XywQS9KJq/eDlqNH6CKaBx1G+3YO0HF06yvLWyDsoaUMAucLKA/1TO
	0BQHdOcD8ZKllhi/NHWCkt01V0UW3xg23fBdp+ckouunjlz30uEreaXHgI8+ahmBMrGd96Z0eDj
	2jNuJrHdflu76tfDe6VnJ7mv3PDEbrsQFJgPwo6qrHphcaG3x+Q/B9T70wOMHpY8P5d0PtyAI2W
	4w/aFXsRFvXx7eEyhQMidE0
X-Received: by 2002:a05:600c:c167:b0:486:fc5f:1ab9 with SMTP id 5b1f17b1804b1-486fedcbeb7mr182654785e9.14.1774304286668;
        Mon, 23 Mar 2026 15:18:06 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm3571665e9.2.2026.03.23.15.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 15:18:06 -0700 (PDT)
Message-ID: <4d8eae17-3b95-4fba-82e3-1da6b53c0a1d@gmail.com>
Date: Mon, 23 Mar 2026 22:18:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 11/11] sfc: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dave.jiang@intel.com, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-12-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260323113117.2352709-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,huawei.com:email,amd.com:email]
X-Rspamd-Queue-Id: 5D94A2FE2B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 11:31, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PIO buffer is a region of device memory to which the driver can write a
> packet for TX, with the device handling the transmit doorbell without
> requiring a DMA for getting the packet data, which helps reducing latency
> in certain exchanges. With CXL mem protocol this latency can be lowered
> further.
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Add the disabling of those CXL-based PIO buffers if the callback for
> potential cxl endpoint removal by the CXL code happens.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

