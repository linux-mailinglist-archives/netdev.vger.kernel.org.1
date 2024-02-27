Return-Path: <netdev+bounces-75372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD76869A02
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31671F243E0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA85148303;
	Tue, 27 Feb 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="iQTf4Nry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E71482EF
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046649; cv=none; b=M1Edq+81UV5qyoBT3zOi+Xe0fVjEmbXbGLOL1C5NiqG2LbErXwOWvhGHDouMIS25aFI3p6Wpev5PfZTJuzarPZC+D6lfgzhiay6GCq1/1HN51kH0nz3eheRz8bvufuV4jXAE/IsXdjFN50QcDc4Mv+yl/v2tnRXs4MqWuWzZ70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046649; c=relaxed/simple;
	bh=ddAU8HPlRHaoyOxquKo6gD8/UIymUyb1YHHHrQBJCRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTn9E9PhnYpDbLoSl4LU5zn/pUbcv31HB9UBEHPq62ukkYBkCF06e9zG97389GBDEt3kOSvbRbNzLYLM7tv+jyw89vZTSbfjsLdPIXOfW3UirG/+W8FBa/gfxPIAC1qiC0MEG0i6y2BlNi3f6aIACENFuYZCdYfbuMVvWh2XWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=iQTf4Nry; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso1742214f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1709046645; x=1709651445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IDCso4UDBgGm1YIXg8VCsvKs2Kig0hQK75M9w2PEIYI=;
        b=iQTf4NryQg/Aef+h+nK1I1z9zJBJupgGyHqSMw2Km/u1rmbmtD5PFe6YHdQL0rz1/7
         i0IwGMChUJNA/i60510bdxgxvD/T7kn+TIs9Nuffq0s4grNQ6FxZTGriPtF99xddt7A0
         gc0v8T6FZM4o1L9i1XUxoP/6C7sKBFJt9NmXTuSSHmnJl5QIwj9E94potzpL2svVB2rK
         pIDaUTV5cW/4M6Qg8sFLumUmlpv9bcjiWQX6c2SnqIWyaQW5NRKhE5MforwzgRt8zcOu
         k1/eTumCjNSDirNfe1z4GhDMvb578E6+AMegwC78SC7Lc3INnV8hWA4Y8Cdup+eD04Sr
         w1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046645; x=1709651445;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDCso4UDBgGm1YIXg8VCsvKs2Kig0hQK75M9w2PEIYI=;
        b=vstOoU+J+qcjBPkVnYtXcSUk8afihW4rfvr4T7YpWU8sbGCQrYTE8yAlTRYqC/6HC5
         8X/RnrPW5Xc6aT8swpeqFQNd7r6xfoyGxOVtvRihB7ptfWP2l1wOLdi7CjCnX3mYcsUj
         m9Y6EnLCimMmuSLazDTE9TS9MOJT4QOb7vOkIfl9fHpp+kog+zfRnH+0KQv93Wvmd8YX
         1sj8A5IZI+4ky/zQbQ3ws3F+WtD6I0/AVercGpXG1TFF0CebE6XnYzNgH9PzOoAmqptm
         SE2iuMDajznKOReiffBCCkJnJ0qe8h2N3Ke0dKIdzsoIbGaR9irwoZnKLybusopv3YNM
         wwWg==
X-Forwarded-Encrypted: i=1; AJvYcCXwzLtq13W+wdBqy5r+PMqPPiE4/rBXv8JYIslHc1ls6n8RCFWjcGeDrrfJOkcnp6Iiv3CM0+Sa2Ix7NyeTRRT4s3oCVZ8H
X-Gm-Message-State: AOJu0YxrNusXwJP8Uf4x3ZwV3N+NfEFRaRpVnBWlDODvimERaA1uMaDG
	aw3/nFE5p7bPuNb4AiaanfrlziheAu59WYB59875uFWa29DmvtPTNoBGCUwszHU=
X-Google-Smtp-Source: AGHT+IG2YlvtHkz+5rfXp9LyO2BtxCgg6xuo3H+TfHg1Yh2ePzhWPHTLX34hHiSCe9/a8atW64kX3g==
X-Received: by 2002:a05:6000:120a:b0:33d:2567:995c with SMTP id e10-20020a056000120a00b0033d2567995cmr8105807wrx.1.1709046645623;
        Tue, 27 Feb 2024 07:10:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:535b:621:9ce6:7091? ([2a01:e0a:b41:c160:535b:621:9ce6:7091])
        by smtp.gmail.com with ESMTPSA id cc13-20020a5d5c0d000000b0033db0bbc2ccsm12149698wrb.3.2024.02.27.07.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:10:45 -0800 (PST)
Message-ID: <c60fdfff-9792-44ce-a811-b2ccf201d3ed@6wind.com>
Date: Tue, 27 Feb 2024 16:10:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2 02/15] tools: ynl: create local attribute
 helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, jiri@resnulli.us, sdf@google.com
References: <20240226212021.1247379-1-kuba@kernel.org>
 <20240226212021.1247379-3-kuba@kernel.org>
 <8047ae8d-e2c0-4818-942d-2581ab56ad6d@6wind.com>
 <20240227065614.57946760@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240227065614.57946760@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 27/02/2024 à 15:56, Jakub Kicinski a écrit :
> On Tue, 27 Feb 2024 12:05:31 +0100 Nicolas Dichtel wrote:
>>> +static inline __s16 ynl_attr_get_s16(const struct nlattr *attr)
>>> +{
>>> +	__s16 tmp;
>>> +
>>> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));  
>> The same would work here, am I wrong?
>> return *(__s16 *)ynl_attr_data(attr);
>>
>> Same for all kind of int.
> 
> What about unaligned access?
Attributes are aligned, at least u16 and u32
For u64, it's not true anymore (:


