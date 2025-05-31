Return-Path: <netdev+bounces-194510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64DFAC9BA7
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 18:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3ED1683C3
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F40155A59;
	Sat, 31 May 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htksDfqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57F4A32
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748707922; cv=none; b=g3+wul4aUFh68yc73kI1Y/BNg2xIAQT4f1msBH0BF49JCHnWDnk+6HujH7v85i5vbAVan8MvdMfNmbeiTUZ+rKFjYROl4HlWLe+89GZOR8cXhWWY3U0go+hjPDv9xikPJQqHT9AIeq6E5wwkHDL7Ecg1CDy80mzSDdnbA8yehX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748707922; c=relaxed/simple;
	bh=KjDC6VU+M1XQK2uQy2ClUBxhvoL2sCPQfgk4BOPrPyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIWO1eGsFnh/GMJVcC7JV62q0bVizcIcsJr57wcGtuvM0WoiRbvkL8scdpPa1zf77ZD7NuuocRbU0LHb8KO6rJSZt8A5kiT2xc9aT13EBDiq6i+wuULDsl5+h5AMzuGPTCwxy9hEYad+R5TyETFhS9fZ4tkjo9DJYsd3cLTCv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htksDfqe; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86d02c3aab0so45784139f.2
        for <netdev@vger.kernel.org>; Sat, 31 May 2025 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748707920; x=1749312720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adYz4y6qWFQCvo6vlXL+7MpDMsXViXys5pOpwaDq6M4=;
        b=htksDfqelCGIKra4tOa2YiF+kiCmshPmKIHhI+wFoo49FHF4mQsW+x3NIMOoU5Ql4x
         4xhmZub5e/xJYbKKJmCdnYPCac/mt4S9EQOuoyK58iCfZCoaJuNnIzZylGc6gfjV6pqa
         g66fuCLEQxa7G/AaBz4G40oXnpmAFUpB7PDm8XLdmL4khNzhsAoWt05AFSykx3rEhRgf
         heWvWeAgBlnFDpFHJSExLB6MbGh8QgsgE10e4STJ2R9V3OBU3hgNEuerNxRY6dS2EN7e
         Vu0y8PXK0Wi8V0XoBKd2LK56WZelITDk/1pPJFtlQVpH1jM1BDs/2+CkUMKtqdc+eO6+
         z3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748707920; x=1749312720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adYz4y6qWFQCvo6vlXL+7MpDMsXViXys5pOpwaDq6M4=;
        b=U9CkplLjNze16jtSkM8g1hUc+9du2Vc2yEXIG466wR3jCSD8CQUBC4uOpbp0+gq0EI
         zwkuMN1X8FALV0+HoEyg3+X+njCbqxvjxSSexS5HBlW+WBhouZ1LPscY1LjxJW+WDrXO
         T+xTZZGvlGIBgr7nMZqRH9xIcEvH+alpbvhCnObdfcWNCzZrcj4QW8961XqpemHVD0Fe
         bNJpUIXmRekObKKoRm/rwIbyBZI2aK1T5tNXLHIwacSSQjVt7ip/4aOaVWr9+uGc/wtO
         D8lvLYYsIF8wrmTXMj1kcrKK7R9L8cto+x01wnEL5itIGrJs68afwSsKdRFJwClrgUuB
         LDJg==
X-Forwarded-Encrypted: i=1; AJvYcCWURf6c8Ns/r8CHqSw+6GaTUl9ZWXE9HYdj+5CDJ/WN75MIxMKtSCQQrNyj7DbHab6kXWUi+rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7YiEMenAl8RNcuXwZ1rFp6zvwQqaHMIbGp61FMZ79i3nA61lG
	LleRrXMzwCBFRUc0Q1/RKTvRbp1GqBoLB/wmNzHgk/7aMWSBAsGZ/k2y
X-Gm-Gg: ASbGncstC5EkapW5hYMWMJwB57TcsPJh8j/KUimXSJFxmIXk6AKTZmYYzDmewxu/6nM
	YTk+hQJczLH9v11cuYKRrTLSnzui8UTZit8A9cz/ULH7ORepIdV1LLmQHFWc5kg9NHMuTMSEzm3
	CJoMqOeeCSUqoOzlusuGr3z+WNHSxmUJky1vWJh9gqd4OW++t1HePxvAoQYrO9KkKlTJXYzEyjn
	1614tzMqzEdEFedXp+UyEw8LAzYw6XtI1l38RqnSdCVKvnN9x1eWZBNxONMiHxxSO1DPZlEIAMO
	9sY9/aal3CI9yMQ0IgfSiKYWOEnrBp+NcjsGmRo7xvK8ik9wbmG/kUtfhKLRVU24whEAr+YdzVl
	2B5qAeBMIZkp56TA0ODhM7JuDHPDKFDYTe4sUQg==
X-Google-Smtp-Source: AGHT+IHlp89OC6nl5Cd2eXTdu2BYfjx/MhuLCcOBRTamQbVmtuw5UkAjbCJVzqboYOdoNBi5jeDJlw==
X-Received: by 2002:a05:6e02:17cc:b0:3dc:7f3b:aca9 with SMTP id e9e14a558f8ab-3dd99c28a4bmr70124735ab.14.1748707919808;
        Sat, 31 May 2025 09:11:59 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:8877:7794:991a:57e2? ([2601:282:1e02:1040:8877:7794:991a:57e2])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4fdd7f29e19sm920934173.145.2025.05.31.09.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 May 2025 09:11:59 -0700 (PDT)
Message-ID: <d136f120-aaf2-4b2e-8e11-b62462e79e34@gmail.com>
Date: Sat, 31 May 2025 10:11:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip: support setting multiple features
Content-Language: en-US
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
References: <e55dec9ff62227636a4782bda3cfa7e063e614f0.1748382868.git.stfomichev@gmail.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <e55dec9ff62227636a4782bda3cfa7e063e614f0.1748382868.git.stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 3:55 PM, Stanislav Fomichev wrote:
> Commit a043bea75002 ("ip route: add support for TCP usec TS") added
> support for tcp_usec_ts but the existing code was not adjusted
> to handle multiple features in the same invocation:
> 
> $ ip route add .. dev .. features tcp_usec_ts ecn
> Error: either "to" is duplicate, or "ecn" is garbage.
> 
> The code exits the while loop as soon as it encounters any feature,
> make it more flexible. Tested with the following:
> 
> $ ip route add .. dev .. features tcp_usec_ts ecn
> $ ip route add .. dev .. features tcp_usec_ts ecn quickack 1
> 
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: a043bea75002 ("ip route: add support for TCP usec TS")
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
> v2: separate logic into separate function (Stephen)
> ---
>  ip/iproute.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
> 

applied to iproute2-next. Thanks



