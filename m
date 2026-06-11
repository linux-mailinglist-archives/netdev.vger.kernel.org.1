Return-Path: <netdev+bounces-298244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4q4aLfzsKmoSzgMAu9opvQ
	(envelope-from <netdev+bounces-298244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF464673E4F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:14:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=hxVxaaVz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298244-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298244-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 893F9305DF67
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764354279FC;
	Thu, 11 Jun 2026 16:58:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1E40BCD3
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:58:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197121; cv=none; b=sV4I1bk12ZOU8kOt5xWU7ciWAFPmaOaduHbR+Q6hQlLCGli2SBXqcMbt9cXR6tZdzqpl+bJW+TZLMgnwk9Jwc7zxmF5mSpCqfalamV8SDhhh9/fJ0pWuFumEJXVBwfhg209cTooDO8BSSMPtuPx7JtZxs/+nTtPwRjd3Y84hh/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197121; c=relaxed/simple;
	bh=MtH5MrqfJ0innke6B507gEspNv/Po+C6OSD5D0FLWHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRztd1vh+W5M0ybDFOvwrb0OuYp2NwSpkn8AOW9IazdUtjwqzBDqPvCol8a2QzubR483KayzOebGtsQ5NPa3ZlFOR3WNoPO04+/6i05ggh1YPIgAUQsqIY/vKGrV+nauVt55G9X8wnxkD4RqL0CIladYPSVJTvB98WBKHw1Ppac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hxVxaaVz; arc=none smtp.client-ip=74.125.82.226
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-304ddfcf72cso151279eec.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781197119; x=1781801919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9ksOv65wdintddQvv5k0AzyLLccSaifyeuockXa2a8=;
        b=B4za0+ToCJpYv/Npgu5eNdk2xf5GWbNpx3jEf4fyzfVe3OpQtoOAmvd68lav5WgRFL
         VkjwHQB0rIbzjZ5d5BEAzpiiPsn7bGDxIRdYjR6zhDfJKJsAIXtYlAevaaAz8h5p3Ics
         G/OQwP9ubeLC5GuKWKMky2rcPzzwvfKryLV3lVqoALOe8fn9KAPu020bbp3qeXsmql73
         QrDSfSfoKAUHIriwj2ioTz0WBNyC33bXi3BCas/MfJmguR5I5YH3Z2IPDU92rjQLQrV8
         XZNc/3x9mfKqN9HSqsOnM67Ww/dwHdO3lozWR98a3fEiy6AwBtcwQ0wcew8/oiIkzixd
         DElA==
X-Forwarded-Encrypted: i=1; AFNElJ++AX2xNOK0T17zEts2AAcmYfq/NN8ufyVJnxiU2rhgUIY6+9iljDgP9s6l2gTN7lCuzso9b9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvrxNbaLhlDirUjYSxT2HyrIxrvkWd2cO4RXWVIV3Rm6PEoQ3
	lzttZq8hAqZGWG0P5UB8ik3UZRHygNtjvqTvftczaaM4Nzca7o42B+Ddae3G7lcCni6JdpywwAB
	U6mZaYH2XPXcsm4be5iNWgDo1aev3lwZA6rQaM6uQPCMN28MLLpV2Y9Nl1dwDjelAgNWavb6/dQ
	OEeni41Tzvvqv728Ib6RHSAaA3BbrHZGV9PjaZz1E6zYaIY2ExLrbYAIjjTIaQ4HMAlhFvAATse
	NSAdmgfLg==
X-Gm-Gg: Acq92OHCsWQ6qfcv6uGJWqQN9uNgbhG12vJOEnrYvDQ45+j7ZX2q5ywE/ITWTBdtP8T
	ZsjZ8Xc61l2MqbOAZ7/VzvAXhjr1hmhfJmd38vyeddnjq9vmx0j3j23zQl+rB9grZCmkTUfYXp0
	JTgNGok98fgmIDx2V8q+8LWlWSCNBfZiiNvhdL2OuQ+CZ2PY7X9QxgqmbrOjy3IvK+GD0/x1PGf
	4ZeX1znRxRebe16ugdwHRdIUjW/e8QqVsl+HjwHX/gaAQ80XQrbYup9bdSA6iDXqXwP6X4Ns9Ko
	qiWAYC66sjUbUeUVyOumZs1yz/lyepW91v7lVsvKR3KFf9M8P4FhkeamhGqH1dy/aKfvoKQsuOl
	GmXvoB0FwzoXHPzVuxX0DI1Sijm3mY2CcmzEV3SHAI1s0wjlfPf/ZLBegqzZKi1PRnUMCs26QFY
	Y6xJGHbF7VdETPYkjjFsUvbnyAE9Omfuhtl2kmUpu33E1h1S/v80BN2oyrUg==
X-Received: by 2002:a05:7300:fb8b:b0:2be:833c:149d with SMTP id 5a478bee46e88-30804ba574emr2543576eec.28.1781197119254;
        Thu, 11 Jun 2026 09:58:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-30806c4293bsm169629eec.11.2026.06.11.09.58.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:58:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ccd51bc2f5so1905896d6.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781197118; x=1781801918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9ksOv65wdintddQvv5k0AzyLLccSaifyeuockXa2a8=;
        b=hxVxaaVzM/qeI2pr+Jz1g0nnEz1Ta2Db/tkBXQG4vscYSwaVWRj1bfN454HPtHsY1N
         S/3yj7VIwamXTGrQcLCqofD/hHbF9MR1sFy1h6V0DvYa7Q13qLaRt1uQGqw1mZfz5ZlM
         08xBZxWNuWxyWEBINEs1PkKA7TkT5fns+vUT0=
X-Forwarded-Encrypted: i=1; AFNElJ8vKQvSKoG75ODZW4OlCJpDuv6kPzYxTGp2gfrPQt5Y9W0Z5+xRTzvrgSus9WOfBRbgpDBj7zo=@vger.kernel.org
X-Received: by 2002:a05:6214:5708:b0:8cc:d765:4fb7 with SMTP id 6a1803df08f44-8d1dc1a5579mr63985716d6.35.1781197117707;
        Thu, 11 Jun 2026 09:58:37 -0700 (PDT)
X-Received: by 2002:a05:6214:5708:b0:8cc:d765:4fb7 with SMTP id 6a1803df08f44-8d1dc1a5579mr63985216d6.35.1781197117239;
        Thu, 11 Jun 2026 09:58:37 -0700 (PDT)
Received: from [10.14.7.225] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e838f3a5sm23064766d6.18.2026.06.11.09.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:58:36 -0700 (PDT)
Message-ID: <d8def490-4740-4ad6-ba9e-c2f6206453c4@broadcom.com>
Date: Thu, 11 Jun 2026 09:58:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: bcmgenet: convert RX path to page_pool
To: Nicolai Buchwitz <nb@tipi-net.de>, opendmb@gmail.com,
 florian.fainelli@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: phil@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260610114835.2225423-1-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260610114835.2225423-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phil@raspberrypi.com,m:bcm-kernel-feedback-list@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tipi-net.de:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF464673E4F



On 6/10/26 4:48 AM, Nicolai Buchwitz wrote:
> Replace the per-packet __netdev_alloc_skb() + dma_map_single() in the
> RX path with page_pool. SKBs are built from pool pages via
> napi_build_skb() with skb_mark_for_recycle() so the network stack
> returns pages to the pool, and DMA mapping happens once per page
> instead of once per packet.
> 
> Reject HW-reported lengths smaller than the RSB so a runt cannot
> underflow the SKB build path.
> 
> Drop the now-unused priv->rx_buf_len field and the rx_dma_failed soft
> MIB counter (nothing increments it after the conversion). This
> removes the "rx_dma_failed" entry from ethtool -S, which is a
> user-visible change for monitoring tools that key on stat names.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Tested-by: Justin Chen <justin.chen@broadcom.com>


