Return-Path: <netdev+bounces-300714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6bz5GfNANWrKqAYAu9opvQ
	(envelope-from <netdev+bounces-300714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:15:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66E6A6041
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:15:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ONrsaVjk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300714-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66A8F3020FE5
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C5D38D419;
	Fri, 19 Jun 2026 13:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62349390CBF
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:15:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874925; cv=none; b=hR42UOg+HnjILo3Eq1I2X0Elg/sk13q8A43ZQn+JkhfIMePxwx3aQOArc29BBXmz03HNEbuvSaWGR4JH1npwVpVTEWq/LGA7ArXWIv9sExdqqv+qpLM/bgU6P/iH4VqINmGRCnp3/qrSeVAKolWTKmyPcSSB5xCY8eq1Ee/5XAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874925; c=relaxed/simple;
	bh=ayUz0QK19tunlbuPS6VpdJABgaHjTA/abbzXs3ZADjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+kGbGGTwRS6RCXItFtHRgCAiapdxpOym6ysTq6CGIMt8XYMp/F2zeJYOBHC16zDSAjiZ7h3wJCKQsgnzAEXDydFi+xSrzIM2W41KZkJuNzDvzlr64uBXoXuRw+wIeSvoNYpLF5eEGk65p2AEynvEodG+8DCqh09qwaijIthW7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONrsaVjk; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so3707108a12.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874923; x=1782479723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7g7c5YGTpHzrYKu/toqMo2x8dczkqd8MUSEXNuCeSR8=;
        b=ONrsaVjkwtj2xD7cwcZG+2Kdvm94J2Kh5QKv30DomVHq/vUBmh72z8XFGlbbWKvS/Q
         1J8sT5F5Zx9aNcLtlKVIlC4iL1PqsDB7AbTefreRJHXE8mF1mk+PnjR6ska5/hQLrC81
         ZvrYCcD8kQ45K1SW+31QZRGFr6U2YNZJzUTjcYSNwwd/1IDJgVJ3O7BXvvAvSSdWMkje
         sR2OMsBUMh5u/cZzYjHYAPriBtZvK6jhBKrbtPrNkrZ9FvuBtOdveyB6mu8hYlvyOdo3
         tecGM20Yp1Bp5uvMhJF+Pumui70A5OKwFUMF4KwQLX7wdHqvlg66SdPhsat5wnAacdxx
         KGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874923; x=1782479723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g7c5YGTpHzrYKu/toqMo2x8dczkqd8MUSEXNuCeSR8=;
        b=U6jBufb2NXDMJB1r0UTDKfWbutLtWB99qNtPd4VxKHo03WQYrAyRQxNiZ7+mjK22yd
         4utnOm1A6qxfP+daL0GoP6hSVUBXghFvdlqah5qt/sb9P3BmGmeoxWbBbr8jgQZOIV2M
         Pf3tC9VIT4X33XcDPPep1wfEyH89F/rWZFkxjYX840uvHPVaxIegLK5me9D4SgLQCW9j
         swa2daXRohLF6uLh6ldGVjtBqg4C6CeIAnwFyb5eHnfHp3TSniMzCh41MDFupu40g8Q2
         elq5WzBgyqf7c1bO1R5FHSDwsqVpzzMu4OBEqIsD3TVeBhLsEJd2AS1Hm09CmiMTGoz4
         PtbA==
X-Forwarded-Encrypted: i=1; AFNElJ8A1cyQMF5OXI3hqoqfkIVSEFsOOI1dGy9P01d1DpGX/GioAUx4mCCXMhLLmujrQbohtZv3v3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVP1xxMCOcipXo4Bafgd5Ljce4ZmIC2gGAJ91jqfpHO05oXeH
	gg7P7ua+0TfpMBTeOnmgku7xYlgaKs5lZDdE/EhLLHAugYvlw07heWFW
X-Gm-Gg: AfdE7ck6sxQQZ3DKbu12NZ35U8A/i1yriTSUvY0cErps4/IExpEVIgYqy+5XkaOkFdj
	/YTPd/1o6pI/fPRN5Gx3bALr1jEQ/Pt0RG0lwwFbfTRtXdLaGlKKvANbgBxZVewJQWHRnFHneZt
	gdYZnRumM6Ulop3HKlEl3AG3B+3m+BMa3wqskLvF+gyolbBtZIpEbPi71H2+dWdiKzW+GY/8rZK
	hAhwN6V0ToEdnwqyJljYV8KoN/4AV+AQ8i9JawbdXWJ3ffE4EB6uAJhoy1V/yqgaR7eppL7ViQA
	VbU85KFPl9647UBzDdFbYPO2pAKuQv+6LFQekFRyxzNA4e7SikwVtLrTLQb/Dzzt5UqNzzQO0ZD
	gJUTPK8kGHHi+XztbETaDdwKKktpfUlPe9F78gMgZvfzNKQN98LDcSnujcNX13zhYRiG+up9jtm
	lNWFBbhYP/6C/XeOW9Ku6tWea20IHF9PYblA9ZR5CH+wzOZ/6sgeq7oWk8oOvlwwuMZDPeYUAWO
	f0=
X-Received: by 2002:a17:907:3e1b:b0:c07:e025:1549 with SMTP id a640c23a62f3a-c097b395fdfmr179418066b.15.1781874922395;
        Fri, 19 Jun 2026 06:15:22 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0a9a009bfcsm86344066b.40.2026.06.19.06.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:15:21 -0700 (PDT)
Message-ID: <421d759b-c7cc-4503-afcf-da998950efef@gmail.com>
Date: Fri, 19 Jun 2026 14:15:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 3/5] cxl/sfc: Initialize dpa without a mailbox
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-4-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300714-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:dan.j.williams@intel.com,m:benjamin.cheatham@amd.com,m:Jonathan.Cameron@huawei.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,huawei.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC66E6A6041

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.
> 
> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc

