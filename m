Return-Path: <netdev+bounces-74668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8575F86228E
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 04:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBCF1C213DA
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6913AFB;
	Sat, 24 Feb 2024 03:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbhDIRB1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD84168A9
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708746902; cv=none; b=W3sxVHvUPk+MpVJiFoo57yH3hWuMTR/fsOhfBKywRpDdi7jtQk1+U1bQcWco+aYMuSkQyykx3b+yw/DnUc/kdSbeq7SLQgPpYkzcHqDkkrSLUi/zih7dvIALy1i/u+jc8RuSa6NffLacttQ8lmEQSKwwzTtUfFoszd8d76iOFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708746902; c=relaxed/simple;
	bh=s6q6rNp+0NFSmrrw1Z2exdtxoWWTdD2u6Cu5S+7iN6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBNsmIK4JczrkVT70BkOmAznW4oYlLCPKME1EDOv/2BNKq8A3qVcQNwXr70xyyZvUmlS1mcaJwxEMZCocP5/yK7PsvA2WLTfaAz9PT7ce/zPcHE5bpaYh37oM40IQcWvI9kA7H0GJZkhok1HHlhF/FG9XG3BbzwxewaXal11Ynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbhDIRB1; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e4881bccc9so367736a34.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708746900; x=1709351700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCM3i7TPmZZg2O2F+yDPYQDZWVARd1qRRCCAkNl11jo=;
        b=MbhDIRB1GqEnuKs2egCQiRZOu+GweouLoNoCuSavkBHWh/AJjO2K6qnDFGeHtvpffX
         aQEnnQeTt6iSwoGND0attnKWM9PPgU+8GVfUGLVzw8I6975V1Cxfbw3hCpG0RksqQSEi
         APdBJsxTGfb8WFAvolCOUK6lrhvuXFXrNl4Cq3pHYReTB9NA8iZ4b2rWbI8DmGgWPwsN
         bXPvrncujDt0CM6dPGJAV9AOPaNyTaxVzgvgnYF56CSTUlDbu6wUkv++uMlu4456j5QE
         9kx+7llp7ozwbYA9CprW5QlDKpPucMx0a8cspz/yib2s6JN3VBuIhXcJP6RNmxeGRTbI
         Im0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708746900; x=1709351700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCM3i7TPmZZg2O2F+yDPYQDZWVARd1qRRCCAkNl11jo=;
        b=cKkX9oZ6obojmkq1EKLZ+XR6k+NAGLf09gd94/SU7meqFu4T1ODKV70h8Tv3rWArxH
         vuS44Vq77dWV3cN3BuACUHqhC9lfPaOCK3m+YaiiBgW2zSvqLg0Oet85u6vw5dqMqz24
         PSklovvdZ1lNMlAU53hgQzmac5vhkIO9Hmt7MUfOahoIqySxQkQKC91OAWjehes3SJCr
         9L16FJ2gL2SRGdYUOEISqMcr7Aw2O/p6A2Jkxse6HyCzokDfitFX4ZQFKCd+JtHDpPAw
         WY/3cxPU1PvL3Q/o8mCX77DbT+KKybbnISfgj9QWE5RpJ4RfKnbjhjwPp4whNFqznuCK
         8ktw==
X-Gm-Message-State: AOJu0YzgcFUz0JYapOYI1+ucRD+APEn0dykH1hCGI/kXY40oflxervHu
	Oolq211wRmu0usg/DGAJppKpMIJ9ebuS05E+M2r1DSM18ZgtdRKe
X-Google-Smtp-Source: AGHT+IFBqcfDFR4fmf0A0SQviOjTC5kyLM3j1gc8mIfBVGtrSD4vWgKmu/ykwpAKFcYpkmOx3EE19Q==
X-Received: by 2002:a05:6830:4489:b0:6e4:8235:37d2 with SMTP id r9-20020a056830448900b006e4823537d2mr2126978otv.21.1708746899758;
        Fri, 23 Feb 2024 19:54:59 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:f349:a51b:edf0:db7d? ([2600:1700:6cf8:1240:f349:a51b:edf0:db7d])
        by smtp.gmail.com with ESMTPSA id g3-20020a0ddd03000000b00607b3038a7dsm102976ywe.9.2024.02.23.19.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 19:54:59 -0800 (PST)
Message-ID: <88e80625-5b62-416b-936e-f232f84aa330@gmail.com>
Date: Fri, 23 Feb 2024 19:54:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a test.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuifeng@meta.com
References: <20240223081346.2052267-1-thinker.li@gmail.com>
 <20240223182109.3cb573a2@kernel.org>
 <b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/24 19:15, David Ahern wrote:
> On 2/23/24 7:21 PM, Jakub Kicinski wrote:
>> On Fri, 23 Feb 2024 00:13:46 -0800 Kui-Feng Lee wrote:
>>> Due to the slowness of the test environment
>>
>> Would be interesting if it's slowness, because it failed 2 times
>> on the debug runner but 5 times on the non-debug one. We'll see.
> 
> hmmm... that should be debugged. waiting 2*N + 1 and then requesting GC
> and still failing suggests something else is at play

Do you mean it is still happening even with this patch?

