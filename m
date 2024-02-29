Return-Path: <netdev+bounces-76270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5D386D0E8
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984F628AB6D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE570ACC;
	Thu, 29 Feb 2024 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQOkWlUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C636CBF7
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228388; cv=none; b=ZRBxxVFJ/MKqLhx+NpTpx1Wz0R3WHup3vpQ+Fgtig2N7HYCCdUxTKrxhYjebrZQTDqoqe09kOI8lvvfErSuXkXIF4iJRjVzfKd3sgN2epMSTeRhWk6nHDZuDgP4V5mAXXl9vLYOVonOa2UE48lPmknkkW/WdQ28rbSj9sAb7PBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228388; c=relaxed/simple;
	bh=Eh8xvz280lvIvlQWpVme/ptrMADTTj8O4eVNQkBx/Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFFHTEVlHM/0l0rfLwwIS/LyHgna9gXgZ7ocSIDC3g//Ai1aAiv8X7hO1Ms3FIQ5ibkptOJbZhWzQhTj1bBMMKMszPy9Vv5VFmKtpQI8QOhzkme3aElXWSkoCnsYWMcyKQDZxrXKJOjexP5qGE10Dp6sw05zAvihtXbDMczl5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQOkWlUP; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607f8894550so9071547b3.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709228386; x=1709833186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZqC1lG/1j287e0CKmPHCS58GZ4YxotunfcfaGLYRQY=;
        b=RQOkWlUPebbdiBWmqP2pFfuWVBCwfyOZmhLwX4wyEYO/LYlBQY+ucP6tDxB4cdN7/T
         wrqDPz9g7cra9LIRGOMpMgQ4J9p8P/HT0KClRTk4yKJf9TLkB5idPuDxlscXVAzt4oHn
         zQPZ7ORYar2jQrPDPjrgh9jJUcIqlZpmrK2gosmZssaul1bhCNagCnUonHj5hT+MSIs5
         Sbvh4ArmtcE2Ocan7m8eyBy9WmRoeuLHvplkfYny3J28pIP9606KLfUXPToYC/VsjjxE
         Jr3BmrkTLA0CYyqGZz48R/6aSupcI7sarUYTWt9Qa4mahPrBPkhHaxF7E7vCx2ws4zZy
         ZLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228386; x=1709833186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZqC1lG/1j287e0CKmPHCS58GZ4YxotunfcfaGLYRQY=;
        b=Tb6U6uBDRRNR7qxTFIUhsilmSWnsaySfBOOs7ZiVIhklZxNdJrZCecLXbB1nj2w2r7
         A7luWdP5X8n9my7tj2tx0Lola3Y3mh9Bk/Ih/k8NigaLJgXWCrTP0a5ueZg9FI92kPnV
         PlETxftmnmqcJZ860qVwvCRra+Bg+Awo7MWC53pEVsu6G9bmVz+3HOkiI7QxfnnXb19L
         VfZkdj4XOgS8P3hJ6c/RqB+UbDKzJ3dDMT560hx4xeGqSqVSGKk6eD6rySfLENX1PMhj
         fqg/evqTDa7xxcUke1Z6XQtVswcjWDa5n8uJlBos2R2rsYzjlNkl4/O7DmVoXNwID+K7
         aEBg==
X-Gm-Message-State: AOJu0YxshfL9dmzlgeMtKjE2k3eHV6XR4f3yoVCKvYq4P1NDxUHGbTpx
	7OXjALkDBcbw6PhKSrz/L1bTQMy5SGwISY9k9XPizPUL0dXQZC5A
X-Google-Smtp-Source: AGHT+IHklg/Iz4gu7rj7VVOwejchfD4KPfXljjQeiY30wq68JJXyGJcU5DxDr4behlFladobB4FLXQ==
X-Received: by 2002:a05:690c:dcd:b0:607:ca2e:f23e with SMTP id db13-20020a05690c0dcd00b00607ca2ef23emr3645153ywb.30.1709228386134;
        Thu, 29 Feb 2024 09:39:46 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:62fe:6011:90a9:5efd? ([2600:1700:6cf8:1240:62fe:6011:90a9:5efd])
        by smtp.gmail.com with ESMTPSA id cl14-20020a05690c0c0e00b00608a174f00fsm521172ywb.55.2024.02.29.09.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:39:45 -0800 (PST)
Message-ID: <6b73aa09-b842-4bd0-abab-7011495e7176@gmail.com>
Date: Thu, 29 Feb 2024 09:39:44 -0800
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

I did some tests, and found fib6_run_gc() do round_jiffies()
for the gc timer. So, gc_interval can increase 0.75 seconds in
some case. I am doing more investigation on this.

