Return-Path: <netdev+bounces-118117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF455950929
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760C61F21CA5
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E71A0708;
	Tue, 13 Aug 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmPa4LIB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B51A0706
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563086; cv=none; b=hWA7Furfcumgo00n66yOtUy7WRNILnzyLhFchH25DeRwX5+oDIUqDSW5EBdE/0H9AGJJhW+6x2aoNNw/hbHVV2Pwk3TKMe8dAsuorP1bDAaz5fvja3m49dhEJOtTp9vosM5qJr7wIfw0Z0SOSM9lqrRLcgd5QUF3RrQ+2YiZSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563086; c=relaxed/simple;
	bh=2kh1KDpDSUfdtvO0ykNbUZ1A5KePRUMfG/WaAjP2vQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/ThaW+uLBA7frC0zxhMNrnli/C0C1lQ5VY/5m6ALsKhuqLigEfn9DoJBJaTQDJlYWrFYstC5CV9NwoqVkiZUR53kvn/lU4+aJrwjLVKGKWUxX0IiT2OyqipZFOvYhFtJiMgT2ntfzBgRMT1EWXt8z+dE5+kUrceuuBFPl/jumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmPa4LIB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723563082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIktfzjts8BmA6SSU6kHS3U8j/95D+EzcZLHOXCu0E0=;
	b=FmPa4LIB7dupUuOtMLiLW8ha7iGlhyJy8dd5ZMZTpLWbBCCLidVsDskexCqWB3XM+Bww25
	OUD441OIAZDFKwHdhhm961W9ggLzW5eaNweI5wtzN49cJwxnVAyAD1twiQD1SK1F2vj+s4
	q0dJ3/ltX5GlgPzI2Wq3HBxLPBNAeBo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-V4h6kKBSPry5_NA5YOikOg-1; Tue, 13 Aug 2024 11:31:21 -0400
X-MC-Unique: V4h6kKBSPry5_NA5YOikOg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso10455725e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 08:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723563080; x=1724167880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIktfzjts8BmA6SSU6kHS3U8j/95D+EzcZLHOXCu0E0=;
        b=rUpzXmRwHpUN6+yo7EIe9Z9Scvu6jX46h3cB0JW0+EMyPdiSAawR+Xop0u2u9+YyeL
         U2mYzDdWLtVj3wTJSgZoVbJn01/uBblu18eByO5G0UxV8123Vy/fq0NHdyVTLTOwikuZ
         IUXvGPlMkfkW5+BM5SpZwT2e0dy8In4aKdMC7muEZtNRQN2nVPFZEs2wSIbRtGbWCN4K
         DNUrviwra5H2nFji0mLNzrhNH6DTcx9vYRP903NAlCv635GP80U0YVGbByO+V9nXR+1z
         JxNDT+cfW6f+Bcx/fzcEDKkhLqc/maSgrrS70GBISgDa0/ro6hAWrs4Vbw639/KuifuS
         yRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQsvOPdahQXfTCx9/nNpDCEw5Cr60mOIUEih6EEadFogYID2ZcFH+/QBuf5Alxw2leFt2hg1myz9XATHjbpxF5TRoApPMh
X-Gm-Message-State: AOJu0YzYMk72kbMcYDt3Ls0/RN8XYieo2FAbbPxaXZkqn7HNCqrv0Dyi
	hdQc2Q65CrQ+iFwz+BlnMnCOpoj2cSEW7ClM+TuM4yJfhCbcwKj7VwAGYN8z2u0ovmejBDuZJAN
	DnjMgPn2HZI31tGxkZkALKczd7bbJXp4Hqe9mefc7oRXer9m5B5tT1g==
X-Received: by 2002:a05:6000:2a6:b0:366:e4b4:c055 with SMTP id ffacd0b85a97d-3716fc6daecmr1220701f8f.7.1723563080280;
        Tue, 13 Aug 2024 08:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcrBd6hOSXTOLKrF8CjggBPc1ttHwk5oLum2SlcFBmC7g8V8OYQZqKkt7dxNFG5f9bNEiQ8g==
X-Received: by 2002:a05:6000:2a6:b0:366:e4b4:c055 with SMTP id ffacd0b85a97d-3716fc6daecmr1220683f8f.7.1723563079791;
        Tue, 13 Aug 2024 08:31:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110::f71? ([2a0d:3344:1708:9110::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfef131sm10662800f8f.54.2024.08.13.08.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 08:31:19 -0700 (PDT)
Message-ID: <9f4854e4-f199-467a-bf42-9633033f191d@redhat.com>
Date: Tue, 13 Aug 2024 17:31:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
 <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
 <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
 <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
 <ZrHLj0e4_FaNjzPL@nanopsycho.orion>
 <f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
 <20240812082544.277b594d@kernel.org> <Zro9PhW7SmveJ2mv@nanopsycho.orion>
 <20240812104221.22bc0cca@kernel.org> <ZrrxZnsTRw2WPEsU@nanopsycho.orion>
 <20240813071214.5724e81b@kernel.org>
 <eb027f6b-83aa-4524-8956-266808a1f919@redhat.com>
 <20240813075828.4ead43d4@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240813075828.4ead43d4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/24 16:58, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 16:47:34 +0200 Paolo Abeni wrote:
>>>> Creating a node inside a tree, isn't it? Therefore subtree.
>>>
>>> All nodes are inside the tree.
>>>    
>>>> But it could be unified to node_set() as Paolo suggested. That would
>>>> work for any node, including leaf, tree, non-existent internal node.
>>>
>>> A "set" operation which creates a node.
>>
>> Here the outcome is unclear to me. My understanding is that group() does
>> not fit Jiri nor Donald and and node_set() or subtree_set() do not fit
>> Jakub.
>>
>> Did I misread something? As a trade-off, what about, group_set()?
> 
> "set" is not a sensible verb for creating something. "group" in
> the original was the verb.
> Why are both saying "set" and not "create"? What am I missing?

Please, don't read too much in my limited English skills!
I'm fine with group_create() - or create_group()

Still WRT naming, I almost forgot about the much blamed 'detached' 
scope. Would 'node' or 'group' be a better name? (the latter only if we 
rename the homonymous operation)

Thanks,

Paolo


