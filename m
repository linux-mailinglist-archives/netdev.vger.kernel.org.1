Return-Path: <netdev+bounces-282263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJUwLmKw8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:16:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3749052F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C5D6302F5B8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879DE390993;
	Wed, 29 Apr 2026 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmKbZUVH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XURZciUE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085BE35A387
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446799; cv=none; b=irCq/pfKYq2MJb9vuLonGGkfo2iWUuZ8smAvPHDsRnSzILJHnj3MSeN/AH2OJxmZ5UMyWf/Ee2WKNi6CFktsQmQYSAtMIui1LoTPE8O1vEUGQ1vYpmluQTD76dPc3EZrL5DVW/VRjT+ldDn2v1aMDNjd+uCgf/93avxPworZC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446799; c=relaxed/simple;
	bh=wNILQUDbLMcTKSkCvUyt/Iw0CCFz9V3YODdTXrt+qzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwHQkEKb7a38uifRyGCeyfGCnW1jGXG3QXd8+pf3o9mmr7RSXvpCbH5pbn787Oq60/3MA4wJosU7B4yDsBSW7J/CLScy5yccPjM0Oc/pcBb7ZF4FJDDRq4TGSATA4YM1cfd2dsMLcwwebxKmXBY50/WVcReAPXGwFWjrZODZt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmKbZUVH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XURZciUE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777446797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pctx3U8jzLN+ebOHZ/syUkW1in+jvQwG0EPyRgEuVFc=;
	b=fmKbZUVHBxr2mTHK7WKzDFfnFxdW4wWj6eX7TI4P1PQ1WFGmPFhVVYd+AjnadnSjWC7vCW
	wt/NN5A5GnTLwTm0Dxayoj0gGts5wwAHFtCGutRrcIZY+9CuvekPthJuiQW+fwPhhfemXL
	kb/ei51Zrrcg3W0OT4K5WeWyYCEAxk4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-IKr-VccZNLq6TjLyMnSuvQ-1; Wed, 29 Apr 2026 03:13:15 -0400
X-MC-Unique: IKr-VccZNLq6TjLyMnSuvQ-1
X-Mimecast-MFC-AGG-ID: IKr-VccZNLq6TjLyMnSuvQ_1777446794
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d03065782so7858554f8f.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777446794; x=1778051594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pctx3U8jzLN+ebOHZ/syUkW1in+jvQwG0EPyRgEuVFc=;
        b=XURZciUEpJDyUCUcZCIcYNmfnUM9P/6BaqdqC7SKfiyfgW2JIKgOsRJqhh1UtmQKA8
         FHXtfYG1p3l9AjCdwcOS9m6tUj1wdu59iDu18fVebICzANrbLubroDYAc776LLF8rfnv
         yfKADCCGXqDF2o9m3lZC6igFodACMEeRNUAVViQRxOp96Cez5xb4KDF8eVkFWMg5FA2T
         ufEfiqPSO/Tbfeht85GjJvcB76yIrUQsVbvkfAyVXLNcTdABa21QqZiYwd2nlS/44YWA
         LtiDNFE+BUpI0jggMTpDokzoBtoMI6nwpYizMasr/Y2jghNFQe/yiqcyIfjCTdgsEPk7
         cfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777446794; x=1778051594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pctx3U8jzLN+ebOHZ/syUkW1in+jvQwG0EPyRgEuVFc=;
        b=YmEJDC/zgW8MWFErvKNVu/EauLtxpPe+gex9sQ91pKFBBxcOg+5CMXAHAMaysnJjCJ
         VgqZ8lQ5DNPscy17XrwvFDbHf2bBWNLPoqDmSHvNHg+qvp87eoJ9eB5BaF6pO8q13iqB
         8pe2sWCEg3S6jXCVICU/An8eW+FbdxHy7jwZ/IQb8XJSBQulekZhVxUwZtg3QKIzHjxl
         jyGxB1jAbqtM0yGBBg9EJVnFPD7zPySTvKqiS9+XepNH0MWote2ISieRoj6rMPpoMKTf
         ovw3GG2jBFkivftfE7q6NFteNHC5bXF4Rqe64u9/exmX5OafMLEFQ1VBT3ovcfiolZFq
         Piyg==
X-Forwarded-Encrypted: i=1; AFNElJ+rBc+9cCQCUXv9wekl/LAybBb7mRLhhCAdRu0e3y+hPTIDgFYokFd+2SKAewvUj+WZfzVDCjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZd0q1Ya+DGb6qZzld62UYGqnSDnMU4BooE+T2G3/dXlihcNKg
	gd2z7cY29ZecDUXhLClMmuBhl0kq1jlZH0GzWj3/VACRN3uMnoCa3DB45JN2aAS3vOa8ORWl2IE
	VqKi0fwRDwU0c/ZgSlDwQ2zqxiCKFTFrT64HlbESKdFytoIHNuKZTvtdFuA==
X-Gm-Gg: AeBDiet9HSHFWJFklq6cB84NPmHgQ0OCuuWYFWKhOzfbZsDPWCTy8Z8umWVSy7rdlaO
	11A3SIZoAkwOWgoYmWralcgV/r1oJ2IxoFxhsn7obWLTMQCYScfLF7MUL+1FrapcGOYo6B6i5Z/
	HHM4ka+cyA4LwiZmhnlda8KCRwmqxPBIqfIQEavQLt/haNbzuetb41dsHoOfGohkEdFCYQQzVyk
	Xkl5f4ajozlEznHiidHoAREto2tv/7nuaIAbmX2L7+hk9DuVTJY9IN38+OBvvW1b3u//Mbc5VEV
	3ZPsbso9Cu4phOOx6QLks0l1iGJOtgYjdZTmjRu5s1Xwrg83M9W4BAvO39zi6shX8cfWHpYkD7n
	ILfeHwu3m0si5FDpqwQE/Y84A/Dj+LYpQ9go5uFsJHweLcSf5nOg6exhC33S+jvJlaA==
X-Received: by 2002:a05:600c:3d90:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-48a77b1781cmr102522365e9.17.1777446793876;
        Wed, 29 Apr 2026 00:13:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3d90:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-48a77b1781cmr102521825e9.17.1777446793321;
        Wed, 29 Apr 2026 00:13:13 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b912ee3sm21514565e9.2.2026.04.29.00.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 00:13:12 -0700 (PDT)
Message-ID: <4b4bb983-45ec-4e0c-911e-466c784f2211@redhat.com>
Date: Wed, 29 Apr 2026 09:13:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: mctp i2c: check length before marking flow
 active
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 "William A.Kennington III" <william@wkennington.com>
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, wsa@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260423074741.201460-1-william@wkennington.com>
 <177737520480.421689.2467854297040801595.git-patchwork-notify@kernel.org>
 <bd8704fe0bd53e278add5cde4873256656623e2e.camel@codeconstruct.com.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bd8704fe0bd53e278add5cde4873256656623e2e.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17A3749052F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282263-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/29/26 3:23 AM, Jeremy Kerr wrote:
> Hi Pablo,
> 
>> Here is the summary with links:
>>   - [net,v2] net: mctp i2c: check length before marking flow active
>>     https://git.kernel.org/netdev/net/c/4ca07b9239bd
>>
>> You are awesome, thank you!
> 
> 4ca07b9239bd seems to have acquired an unrelated change:
> 
>    $ git show 4ca07b9239bd | diffstat
>     drivers/net/mctp/mctp-i2c.c |    4 ++--
>     net/sched/cls_flower.c      |    4 +++-
>     2 files changed, 5 insertions(+), 3 deletions(-)
> 
> While the commit structure is probably not intentional, are the Flower
> changes acceptable for the net tree?

Thanks for checking!

That is a serious error on my side, I had an unclean working tree when I
applied the patch that ended-up including random staff. Absolutely not
intended for the net tree. I'll send a fixup patch.

Thank you again for the head-up!

Paolo


