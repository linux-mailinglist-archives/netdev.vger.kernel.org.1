Return-Path: <netdev+bounces-144298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFFC9C67D0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 04:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925BD1F23CB0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA57081C;
	Wed, 13 Nov 2024 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSr4DL6z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666513F435
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468611; cv=none; b=MX8Qfl85sxlgPoNdycS+NISCRVSa/kUzO0C7CxqdqZstm1b5VQCtxtFIEhGzLOcvWz7BEYoOlXhW2HeHozGJtPwHouTnbWi3H5pj4yKBnrHUdazspAzrno8cf3ceGhNuI0nNXLpgPfDepVfc8HloNNx2OQIVFDK54L76arvg1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468611; c=relaxed/simple;
	bh=WGJuT8ac0tL0tMcKrekE83mY4QGPQ82WN7FCRRQWOyE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PCk6VQkv2N+Vi2RkE8PInVJgBTG8Vtzmu8xAQd5saq766D6CNQu+iPfQ7RldmBfTjWcA51xmLhD5Jfyna1LHCJalODxheVw2yFMjqSnmTfe95flaIc4IInCR7DNhyaoxJvbN8tT0q93dL+rFVzU9awiclahYVLlftQ28BjJGsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSr4DL6z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so56578505e9.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 19:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731468608; x=1732073408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8IhV/0Yo1WY+ndtQtQIiCR/JHFR7j7deefRAmnCtvY=;
        b=aSr4DL6z7Jmlsmc22MeApkk+l1PvFPYGuH0a3pSv8tlzEI253JgeRTqxmJn9XTmezt
         sE5RD2+qFo1IJy3Zn8dzCKWhyvcaHq9kWbF09mo+WNQ8/arbSHpFfFH9Y2gPZY8SvZbC
         Ae1doXpL3gFsLmessedlll3ixhJjv1Bs1o+ZAwo4P8IuyapP/CrxX+Pvt+O+ceevKdCf
         KgRWXXPa/SgkfdPwCv+z1/fvPQQFWBzlk5rApTKVoliAu6rIkUVPssE9lzGsDY7ygaCT
         BHzf8yHM+H46EUNUiWjxMradJcHPwAdxnFPRgmT2UaFhznch3SHzgXIoBVLe4kWHHhYS
         MEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731468608; x=1732073408;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8IhV/0Yo1WY+ndtQtQIiCR/JHFR7j7deefRAmnCtvY=;
        b=oLPQ2NJ44HlkQBPpZXX53vMVIhRmwYvwjfzhKx4uINwTUsQxU13A1AJoVWTMJ3LBik
         Q/vIRlJvF58Rgq7YAfT5xj6goAlS9t9OCcxVtL9xzhd5d4l/CJBnGcwqUg3NoRgeXqic
         6jLsmayMR/WTofoUKSJZhfE//OAHHQO9X4uCZHQQQGt1LMch+qDljiclrZ369yD3NbIq
         jQmoeD4gi1iqIksGBgq/nWuFHkUA7DTmRisUXwen9XkClOyzQwzJXaLrPr5W8e724hbC
         Fhf6DkjFn2qd1B13HZ7BxDxb8dpCm3T3v+RbM79+026E/4dODKf7+BQrVwj53uKNHVHR
         wt6w==
X-Forwarded-Encrypted: i=1; AJvYcCVnv4m8HO06zSYD9/CK54P++xu+rAjtwwx0WQ6hQYArcEotAGtSl+GHimB0dScgO7wAPgUvzMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IdrlIlDxQdtY7CK64IOPMRniJuVU41n3chljNrWL8Azk8gTr
	utDHii3HPUvqi+GOzCReEdVzVyLaRc3kdTMxAB832J7A+AlphAP3
X-Google-Smtp-Source: AGHT+IEIZ/CLgBxwna2TyeRhJfkUyG2S0tsJswZ6ICrtUM1uAwLtYFZtpWAxhtm1e4Jq7UooRYFyAg==
X-Received: by 2002:a05:600c:3b0f:b0:431:5aea:969 with SMTP id 5b1f17b1804b1-432d4ab067amr12314355e9.8.1731468608233;
        Tue, 12 Nov 2024 19:30:08 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2e0esm8148815e9.2.2024.11.12.19.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 19:30:07 -0800 (PST)
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
 <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
 <Zy516d25BMTUWEo4@LQ3V64L9R2>
 <58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
 <20241109094209.7e2e63db@kernel.org>
 <7fd1c60a-3514-a880-6f63-7b6dfdc20de4@gmail.com>
 <20241112072434.71dc5236@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <07e69b19-36c2-ece4-734f-e2189b950cab@gmail.com>
Date: Wed, 13 Nov 2024 03:30:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241112072434.71dc5236@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 12/11/2024 15:24, Jakub Kicinski wrote:
> Hm, interesting idea...
> Practically speaking I think it introduces complexity and I'm not sure
> anyone will actually benefit (IOW why would anyone want to keep /
> create context for inactive queues?).

Conceivably to save re-configuring them next time they increase the
 queues again?  But I suppose anyone doing that kind of complicated
 demand-flexible tuning will be using some kind of userland software
 that can automate that.
Anyway I don't have a dog in this fight as sfc doesn't support ethtool
 set-channels.  (Which will make it difficult for me to test this; had
 I better extend netdevsim to support RSS & rxnfc?)

> My gut feeling is that we should just leave a comment for posterity
> somewhere in the code but continue to validate both based on rules 
> and based on "direct" context membership.

Will do.

