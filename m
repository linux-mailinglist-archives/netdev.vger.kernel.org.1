Return-Path: <netdev+bounces-271001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CsaDTBxwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-271001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:10:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8FE3070DF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68AD53089A26
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D9D3E6DDB;
	Tue, 24 Mar 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsTKp/qv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jZ1meEOg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F3264A65
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350225; cv=none; b=pg6erbNAeWXioR1sMEGzfO4YSSbSgO68rTvk1GTw1PgSlwtKb1CMVi+T/jOEpwRAptqoJNe9aERzb/NphXEt6d7hcD5A8xxL278Y+h5tjajlAKudW2vrH2J2jK/Z8IVpVG/2n3p7IzfDzCW0zlahRnhdh6YsFcggEjMKmFF7/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350225; c=relaxed/simple;
	bh=7UraO4dglaksPNTanlAZQ41lUWjbrZ+rn/5BdzV3KGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBehrMbSwNN5K2lF9adtiWCJXEBAXQO9nlSxTP2lH0QUv3mqrzeemjjh7lSDZzN173HZ2EoluXi0k92sEtTGNtWjmmCYeH9x1DiZZnQeViHFhPGLmp+cGXiuBf+/tv2ykv+niuYEJlKo194ZMA8WHDUidFtg02vwYYIemDa+hSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsTKp/qv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jZ1meEOg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774350223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn88B+Jk4xaYv5o/3ZZaHy9YAu2hPUmi4YuKkPVhWBg=;
	b=hsTKp/qv9X/bYbgSGzfbLpI/RZTkHkFi1njqmyslsjxnohcgow0H1ov4JCcToqC9b513xa
	smVO2UJa5y/V6GZ71Cq/hNKzayAnWA1QxeSS/2Sy9eOzoTgLMPwsxIVOo1jUbN/SSrThnu
	bi5TITs/TVHlFv+SPjn+loRDk5gzMlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-mXVSiSyzOyKIy0VcCRRUUg-1; Tue, 24 Mar 2026 07:03:41 -0400
X-MC-Unique: mXVSiSyzOyKIy0VcCRRUUg-1
X-Mimecast-MFC-AGG-ID: mXVSiSyzOyKIy0VcCRRUUg_1774350220
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fb29a8b8so46980925e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774350220; x=1774955020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qn88B+Jk4xaYv5o/3ZZaHy9YAu2hPUmi4YuKkPVhWBg=;
        b=jZ1meEOgLDTFfxKvZASl3nM2MOd8mRr5d3tnWAcyESe/7Bi8sxxA1v6l20nFNLA0VL
         xQrPIbtrpeT3d/6ul/gfGw9jFyLOC+w5++r1co0vOam5LSN6I2/jK2yK7FwuFrFJJrJT
         dEo7YG3lDV0VPHF7HdPMxhgaLQc1RWwoKoFmuLN41C+yPK+HP9KqLtaE5lL10dHXaVr3
         sNHp96uxLo2datqMlc6ruu6BTnHHQMemMAM1bTpA5AATQEcNIpROpR8oVQpXnLay87VX
         qlEjaS+jkhSAGGyIVN1w0dlvAe/G8b7P4C3nQ3FM7AA0DaC/GhO6aNoSDbZugURh4lxO
         ZpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774350220; x=1774955020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qn88B+Jk4xaYv5o/3ZZaHy9YAu2hPUmi4YuKkPVhWBg=;
        b=N9uBygsuDtu8MErH4KKvZIKRLzpeZMfCDg2mE/z7xXp/wmpNmbztzjrTPY3ZiQj3Mu
         0lewsV05mmBKS5YX7BSQkgSvch6Ul55ZvYFbcxfv2cKTkjydtARh95LzbmUbhwvPClBl
         rpsF77XhFK/iyl7HTivHV66YBZKgjWmz4SF0SB7Fm+fHpbnp8K9d/f8pJRxh199kQJqa
         Dt41ziRS76FgfjmFNKcSoPt7YlHAiGJ5wO3vIHlDop1K1ScLE+B2v3CagtFfi8OVFErE
         PeXdSByP0bDvCOiAaECYFX0Plx0U9HrdcjQDxRGP3eZcNe1NKYhGhYNSai2TLBe+zpnv
         XgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqQsx52v26kRwVi/SHhf3EZjKvhUTcdxWDyQCI/pEqobdPW/BfEGv2xaPcU4PAdZJdkK6INv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSMr7IEjonT/cuPjgR6MzY7CThrk1tbSucmGer090E1VFTyCIC
	PlJTVwEbHL54597wo3AcXJU3q5/pY03NEy2FnSm9U++nLfObMyJfVFwEwgYW0KFY2cWozNa5Dyc
	7vPps0vKW/TNLiMOkCDTGDUmFFMgJeyyClaQd1JVqi4vxm7Gxd32hx2uUAQ==
X-Gm-Gg: ATEYQzzLTtiUEgl3MTdnz9Iv910QG2eSeeR1LQALPiJmXeNFpYj1qD5DS94qYs5T+EA
	KDg7HEjTNq15hl2HK4fCx/zY0bWn3mEOykWSLW9M8m4OTZQzTAvtn2jE4FTaSz3apfDd7H9QeCo
	jJsPnqh7gEIaIQl/XLgRo0dSZr6URT4749K075HDsp9/uUzdZsn0Uu4NpzZJEnCKxWIvDekZeuo
	zl1XcWpkS+NTIu6PR6MUd2W11lTsYOQa/kTlU8G7BLdKWPrlGqeelWU2HxZBxtjutme2VEAsxli
	RPjPt3lcelXBTyH78b+HuQfA4kZeQWN+lFRvk/5I40xg6oF6+rHml3lCrU7tB0Okcv6rbbFAQA+
	AtVHl73R0VI1Bo5BQMzZLuFV4N21nkCDkKR4JPqFIVo+QgqCgO+nKFFat
X-Received: by 2002:a05:600c:8219:b0:485:ae14:8187 with SMTP id 5b1f17b1804b1-486febb5996mr207492475e9.2.1774350220314;
        Tue, 24 Mar 2026 04:03:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8219:b0:485:ae14:8187 with SMTP id 5b1f17b1804b1-486febb5996mr207491755e9.2.1774350219805;
        Tue, 24 Mar 2026 04:03:39 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116c0c13sm83877085e9.7.2026.03.24.04.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 04:03:39 -0700 (PDT)
Message-ID: <c8fe221f-2e1c-47a0-970f-e7a1318a15bf@redhat.com>
Date: Tue, 24 Mar 2026 12:03:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Use at least SZ_4K in doorbell ID
 range check
To: Simon Horman <horms@kernel.org>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shradhagupta@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, kotaranov@microsoft.com, yury.norov@gmail.com,
 kees@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260320122107.1560839-1-ernis@linux.microsoft.com>
 <20260321100425.GX74886@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260321100425.GX74886@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-271001-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DF8FE3070DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/21/26 11:04 AM, Simon Horman wrote:
> On Fri, Mar 20, 2026 at 05:21:01AM -0700, Erni Sri Satya Vennela wrote:
>> mana_gd_ring_doorbell() accesses doorbell offsets up to 0xFF8 + 8 = 4KB
>> within a doorbell page. When db_page_size is zero, the validation check
>> in mana_gd_register_device() reduces to:
>>   db_page_off + 0 > bar0_size
>> which passes, even though mana_gd_ring_doorbell() will access
>> [db_page_off, db_page_off + 4KB) and may go beyond BAR0.
>>
>> Use max(SZ_4K, db_page_size) in the range check so that a zero or
>> unexpectedly small db_page_size still results in a rejection when the
>> doorbell page would fall outside BAR0.
> 
> Thanks Erni,
> 
> I understand the maths here. And to that extent this change makes sense to me.
> But I am curious to know how a db_page_size of zero works. I was expecting
> some space is required there.

To rephrase Simon's question, this feels like papering over a
memory/state corruption. I think at best it deserves a cleaner explanation.

/P


