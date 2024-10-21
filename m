Return-Path: <netdev+bounces-137635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136649A90EB
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C92B20CCA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FC1FBC9A;
	Mon, 21 Oct 2024 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqVQo0zm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA791CF7C3
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542036; cv=none; b=tGDx+5BBtKku0hRKBthwUm8JSOYp6OKlViyT6f8FtkmKgrgUrxGoh4avRGy38S3m3vDUmci3qdrYVxA6gRKqATAR8MfX10Y04duprJIU5JfsHRqduqAyFQA2OSrdToWmiFaQrMI5EMKc3pP8E4Q0efmHCA1htrZ6GKJR+fxgZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542036; c=relaxed/simple;
	bh=znZ140NR/z9TDmn3SjQBL1WfoOVc+8Ci06qB8JkE6hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjboa/LBUiAwPvP11DJsbrsmaNNhWTxh4dXpQtblk+3q3r7EJw4RPt6ljE2djU5doLsd1Ht8z5tUaLCuV7gTQHc5uHfbLPD3P9j7LdhYlvMD5MWx73rsJZiFsgCIbqf89m7LMgPbFJJ1oQ+7PE4OTyL81hPcWVtaQYg2RFONLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqVQo0zm; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83ac817aac3so91378239f.0
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729542034; x=1730146834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=he15j17bujact2RcnojpG36y+JrAm2XC5jeyU53khBA=;
        b=cqVQo0zmPNJ02fwEjz5lOCXV8KSr1EuAK5r8QBMTGuZsSoaOFdavDorwlCnxIAc5ex
         XgdLFHT7wohOYRZeEI4KtLze0UagUOR5kBEmcTKnU6fWKOSicBQWfWM1OeagrirR3X1B
         DUDzvp0404D9Kh/w4rtmwVAtzp5DSmto2fNzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729542034; x=1730146834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=he15j17bujact2RcnojpG36y+JrAm2XC5jeyU53khBA=;
        b=QtECe1meycbx4q8xMoqEfiTfm0+H15R4Yv+MMoTNsFueOiijS0Bcecwndsertk677U
         bQ6+2I6Ajx/0ckkJQAYJzSKddX63wygHP3SASFDp5hWckTSrOmy1GEo+bnqZ8jifS8if
         wZwq5LtEY0KXgOYUTAURG+RHDOhreoJ7IuMbKfLucKgy+Nw3r23llunPELuX/nOGOaHY
         YJp0FWbMJKQ0MyTUJAJuHeYgaGMWhhLf6CzwfxifPC2iOSBRFD02a2M+YmyedwoSPdOW
         FRwaQp3sPDrNq1SvP+1g4sIRg+WJB1+EhRCxFOTFIrtlcs7ALVwAbYWD9xiPgwgrxSLN
         OPDQ==
X-Gm-Message-State: AOJu0Yx/Q+G0nfx2EkmM4jeg+1n+m5nqjley73RwfHoV/aqj+dDRaqpQ
	UX2+HneiHQLNh4zl/+6EO3gMLtcnTWIeR3c0SMl7xx5tdiNoGVkCVYExR+vbhto=
X-Google-Smtp-Source: AGHT+IHd9qziGMyQ1AhdZCOiSb9uY4471JM6Di+r7XnHuIvILD6e7R8lWDL0hcUbFyIN4NO5K6Bt5Q==
X-Received: by 2002:a05:6602:6d14:b0:83a:b500:3513 with SMTP id ca18e2360f4ac-83ae8ab71b5mr148279039f.8.1729542033935;
        Mon, 21 Oct 2024 13:20:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a630571sm1218028173.147.2024.10.21.13.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:20:33 -0700 (PDT)
Message-ID: <9e7df8d1-b7d9-41be-a65d-cfcd81e7e24a@linuxfoundation.org>
Date: Mon, 21 Oct 2024 14:20:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tc-testing: Fixed typo error
To: Karan Sanghavi <karansanghvi98@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anup <anupnewsmail@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241019-multiple_spell_error-v1-1-facff43b5610@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241019-multiple_spell_error-v1-1-facff43b5610@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/24 05:52, Karan Sanghavi wrote:
> Corrected the multiple and different typo errors in json files
> 

It should say "Correct or Fix" - Same comment in short log
"Fix" instead of "Fixed"

Do refer to commit for the subsystems and file to get an idea
on the convention.

> - "diffferent" is corrected to "different".
> - "muliple" and "miltiple" is corrected to "multiple".
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
>   tools/testing/selftests/tc-testing/tc-tests/filters/basic.json  | 6 +++---
>   tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json | 6 +++---
>   tools/testing/selftests/tc-testing/tc-tests/filters/flow.json   | 2 +-
>   tools/testing/selftests/tc-testing/tc-tests/filters/route.json  | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)
> 

Otherwise the changes look good to me. With the above change
to short and commit logs:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


