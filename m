Return-Path: <netdev+bounces-66163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00883DA4A
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 13:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723E31C219D8
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344A14015;
	Fri, 26 Jan 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+1q8MwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42A119474;
	Fri, 26 Jan 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273292; cv=none; b=aVs1rpEX6wicl61gPljlEZ2Lt+l3kzTiLjyhHA4+ZkoWJyC9P40iqv5/WUrvLlkbj4cp/0CPVcOvx9tH663TaGja/mjf7gpkCAgYT7jil49lvxSI6AcWLqmRwmDo66NCYlY6u8IfpxhfCjqAjhrpR6pE3kDtAw/tG+X1jrMIWxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273292; c=relaxed/simple;
	bh=AbCXxnvgTq0FOYmlq6xETEvEPvXHG5whrlFRmeMA8as=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GgPznsYg8rPQ5bAJOpFAhL+aYgybDXS9VRExb5roBrbG2PxcCO9TdBLeMSq1+16bchsWRI4vARRd9vue8DqAakClZ1isEk35XP2jCS9SVQWBFCGuyHZrUFnItn0qsbe5DRzY/yi0S2NUL4p/gjwp7xutgq6IL4/axYRD+xwWxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+1q8MwD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so5048445e9.2;
        Fri, 26 Jan 2024 04:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706273289; x=1706878089; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VXjStc9Bv9VVmZATT/H5BM5voqDONk04D7Kh2ueouvw=;
        b=k+1q8MwDkNIxH9ZuZ251N3bpkSWM/xbxpz4YHTQHOFnqbaFg8RmmDn2gUIqcqmzMyE
         REE+PTsuFiIWq9PkaiCznx8dbOYPKn7pGWYES0X0i0LcglMmTYICkNO+D36+8GXCOmrB
         UmvLCSdzbtUN/PzZc5zgb3POKAlp6M2ZzCDN1Uc0Hfcwv/5x7KYxeAfkQAUJ8zMsNRPg
         WwlA2AK7RPwmdhvGmwBAOSEZ1CWLYeB0M5AJDm8CdnU3bIcz7oaMGyrPmj2VmjLVVgAn
         D27VW668lPcd0nA5M+8Ngcg5BKKdsow//iZx4e+qlkc2n5TgMhwIFaJBNcFwfkn1kQYM
         fu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273289; x=1706878089;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXjStc9Bv9VVmZATT/H5BM5voqDONk04D7Kh2ueouvw=;
        b=YnPDNTrmgpxJ9oDG55Wi75GFgGE6ljpBzmtcE8rKtR1GWOE2Nli1Iw2TkkoKjuF/xy
         wYMt8Qffla1gCSEIeOapLkWrVz4BEsjbtv3NY3S3uszqI+J1St8a1GCvmiqVHAjquFr3
         7kAZoW+m6Ij2MMkElgRvlJYq3VHfcg01jUMNhrUySvFBPeICqXtwV0vUv9IHoGJfAe2W
         LYzti4P2ghuvdhsUc1CWVPkRTov7ANWL8/DlOwcwshJPO4cM/zIy2nSSVivEZ0L2haPe
         L3FsC2deorJnNPrGFsUIfeHy+NPQbUgtZizWeEv+KYyxHqFzCUfhOAjxHZl7QUCWoAZb
         XcWw==
X-Gm-Message-State: AOJu0YwPLOBDchtMDDOutrT4kdj9+ficUWLJPTCQtDzLRiey1NLPueUF
	CTuSrcO79+93LNNvDN54z3Wn83nuWgzRmgxl63uCyb7j523TCt3f
X-Google-Smtp-Source: AGHT+IEIu33aEiH7ck43gxXS8SEt5dQoK3NdSy53Ic76JJBJjv5dhyTwB+qMOnyaZ/AO98xiizJoPw==
X-Received: by 2002:a7b:c44f:0:b0:40e:aee0:125b with SMTP id l15-20020a7bc44f000000b0040eaee0125bmr910401wmi.181.1706273288860;
        Fri, 26 Jan 2024 04:48:08 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:b060:7468:8ec9:fcb])
        by smtp.gmail.com with ESMTPSA id o1-20020adfe801000000b0033725783839sm1201000wrm.110.2024.01.26.04.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:48:08 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  Breno Leitao <leitao@debian.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Alessandro Marcolini
 <alessandromarcolini99@gmail.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
In-Reply-To: <20240124073228.0e939e5c@kernel.org> (Jakub Kicinski's message of
	"Wed, 24 Jan 2024 07:32:28 -0800")
Date: Fri, 26 Jan 2024 12:44:57 +0000
Message-ID: <m2ttn0w9fa.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org> <m2ede7xeas.fsf@gmail.com>
	<20240124073228.0e939e5c@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 24 Jan 2024 09:37:31 +0000 Donald Hunter wrote:
>> > Meaning if the key is not found in current scope we'll silently and
>> > recursively try outer scopes? Did we already document that?
>> > I remember we discussed it, can you share a link to that discussion?  
>> 
>> Yes, it silently tries outer scopes. The previous discussion is here:
>> 
>> https://patchwork.kernel.org/project/netdevbpf/patch/20231130214959.27377-7-donald.hunter@gmail.com/#25622101
>> 
>> This is the doc patch that describes sub-messages:
>> 
>> https://patchwork.kernel.org/project/netdevbpf/patch/20231215093720.18774-4-donald.hunter@gmail.com/
>> 
>> It doesn't mention searching outer scopes so I can add that to the docs.
>
> I'm a tiny bit worried about the mis-ordered case. If the selector attr
> is after the sub-msg but outer scope has an attr of the same name we'll
> silently use the wrong one. It shouldn't happen in practice but can we
> notice the wrong ordering and error out cleanly?

I was quite pleased with how simple the patch turned out to be when I
used ChainMap, but it does have this weakness. In practice, the only
place this could be a problem is with tc-act-attrs which has the same
attribute name 'kind' in the nest and in tc-attrs at the top level. If
you send a create message with ynl, you could omit the 'kind' attr in
the 'act' nest and ynl would incorrectly resolve to the top level
'kind'. The kernel would reject the action with a missing 'kind' but the
rest of payload would be encoded wrongly and/or could break ynl.

My initial thought is that this might be better handled as input
validation, e.g. adding 'required: true' to the spec for 'act/kind'.
After using ynl for a while, I think it would help to specify required
attributes for messages, nests and sub-messsages. It's very hard to
discover the required attributes for families that don't provide extack
responses for errors.

Thoughts?

