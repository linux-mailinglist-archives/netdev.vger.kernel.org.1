Return-Path: <netdev+bounces-209674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C311B10531
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA671898950
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B903275AF5;
	Thu, 24 Jul 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ULswZ4tH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41A2750EC
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347844; cv=none; b=bAR7mm7TH5Zm0ool+Ix8CvREmJ7bL+TkRYTOlr3A+j5G7rlaui3kTCN+5+pZoxzcxnoJvqb9Ha/l1cjJPPmnLXfyX8T7TrfZHsVFQHc5e3hcsb7usRLd3mFoaFq9gjha3HklsrKQ+Za7V9AP4Vh3Wz90KrtUAY/LUYRPwdWdMA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347844; c=relaxed/simple;
	bh=busOX8H+NKP03yel4sfjsz8pkXOKrWf+uaygGkk8dnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQwkJTps2UraasueSFIsWnGrRDBGLgrghEj//LDfkUDOmDJF4OlRxX4jJ/FfHMMSBr7bXpfA/mTguVAGIO3+nb1LEDHL6q7mXK2BcFirO1ZQKvexd9EbqDs1rVto8ca8yj4IrXwT++kk+iV+iN1Vy47UMyFXt0lp1LmdS5tK13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ULswZ4tH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4555f89b236so6653245e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753347839; x=1753952639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXfhfh633Enne0/vUw9Tau4IPJhzzP4DhtNfiz7MQVI=;
        b=ULswZ4tHckQnjRHmrd+2wi4l/sUobyZ3onU8+cIweyDNQS6r6LE5A/IfdMudCpQqxg
         ZHxOhHOnCQA1olO06PGudO+ABZjO238zI3h/UeBnMQ1OvSiFgUxGWPE1nhIaHWj+V6aB
         7GZanYiVu/yyLtnFJIRxDu+aRkv+FtG1hc7zMPn7OP6mQeix/3eG8n5Lc+XLe1MQ2OQC
         U2GlORlIPyoPDXwIPSDXx3IBQLvMO37lCdFAHQlnu+mhSyAx/1QXjFZSvY0guHTY2Tdz
         bIDJIqsli67xRFQlEZS3C4DFszT9qvcLYkLg5mpoV7ecLMi9vJaCIVlrTvgCy2MPXPwd
         P2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753347839; x=1753952639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXfhfh633Enne0/vUw9Tau4IPJhzzP4DhtNfiz7MQVI=;
        b=qBTzVh/aSqOMLReqKqpEmNyqtjxL6QIDhABblVpYC4SJ8veOl7NP7+DTPLRVUeBbUQ
         P6+QmIgGOWBvEyWWWmD6EDLXQmJuB4rPHE5McS5IOfe9WT3vdkxxRMcYrb5EdrWVxsV6
         o3bn08JKlbKjWRVXfuoNYpd8bFphRlK2HezeXyPCGjnYOgDJrpKmOEWO+GZUJsUCvgxu
         64KjX4Wx3SLuof0BmmmjWWEhn7K7D/uCtMwb8q/rwnd1UfGEvJGohwdgMykW5G7Y7b45
         Q+eVSs3OXU0HH4YwvPdkS03/N1QxJzYHjG2urVu4iL1AG7fUFDvJhU7JuUId8jgwAuBf
         Pymg==
X-Forwarded-Encrypted: i=1; AJvYcCUW9Ev56DU0H3FYNWNRElp00XwCH6vExps67ROHiFcM1JPGFB72ZfHx43MZ0xLnQde8WmvrSkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeu2s/Yqt1Y0La2kXhde60mn99Q4u6AYoN8oW+oGEMsIEI79O
	XJF/c/gTQsU6eVAfP5Tam1CZQZ6bW1MRWQH9xnBetr26NGbHaapFSgAS+8vqb4ptG54=
X-Gm-Gg: ASbGnctAPsvgoOkMY7vQIhY1hWu8MSYRR0LDWPj5l+dLGUuV4354lVa2hRrigi6Dbfl
	9QcqY/0v87to8NmZsXlIXkUMFDFAZDoMkfogYuV0Sz8B+4ae3dypUcLlaMVGTyJQgABlV2H1USE
	2e7bJWOPq/NIWIofhOiTKqace1M31C2C3r82NiL1C1C8kckkX/lJGvPpXach5uJbX+x/ZNIDA+Q
	lYReIcxfXahwRw0pNtn1T2C80SaWR2qCNydF7daBzA+O8AggFNjSx1xd110RlYd1y4dkqdWmf2r
	fzqNzZAVtdv6b+vvbiwb5Ut5N2MSU/mXy8NeL1v7gKIBKSG80wnw85YkOBCFHFzOCVln0PPwYEO
	Hr2G76np7+lXossRzTlkWhs/gyWkJOxoCeELHXO+ug24ddP/oKsjfN6D7nTQMoN9D
X-Google-Smtp-Source: AGHT+IFSuHIz0mKo1Y9mXwFRqckeYEZ8PDM4MxRGcLaAdkrLPqq8H9KRRvQ3J7qejG7PIF1aTY99oQ==
X-Received: by 2002:a5d:5d85:0:b0:3b5:e2ca:1c2 with SMTP id ffacd0b85a97d-3b768c9e3b8mr5153341f8f.2.1753347839543;
        Thu, 24 Jul 2025 02:03:59 -0700 (PDT)
Received: from ?IPV6:2001:a61:137c:d301:8150:e550:d7c:58ec? ([2001:a61:137c:d301:8150:e550:d7c:58ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705378ffsm12032515e9.1.2025.07.24.02.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:03:58 -0700 (PDT)
Message-ID: <afdfb8e8-0d42-4b5c-86fa-e46fed35b80f@suse.com>
Date: Thu, 24 Jul 2025 11:03:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbnet: Set duplex status to unknown in the absence of
 MII
To: yicongsrfy@163.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 andrew@lunn.ch, oneukum@suse.com
Cc: davem@davemloft.net, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 yicong@kylinos.cn
References: <20250723152151.70a8034b@kernel.org>
 <20250724013133.1645142-1-yicongsrfy@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250724013133.1645142-1-yicongsrfy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 03:31, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> Currently, USB CDC devices that do not use MDIO to get link status have
> their duplex mode set to half-duplex by default. However, since the CDC
> specification does not define a duplex status, this can be misleading.
> 
> This patch changes the default to DUPLEX_UNKNOWN in the absence of MII,
> which more accurately reflects the state of the link and avoids implying
> an incorrect or error state.
> 
> v2: rewrote commmit messages and code comments
> 
> Link: https://lore.kernel.org/all/20250723152151.70a8034b@kernel.org/
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
Acked-by: Oliver Neukum <oneukum@suse.com>

