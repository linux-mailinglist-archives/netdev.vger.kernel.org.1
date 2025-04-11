Return-Path: <netdev+bounces-181613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE15A85B38
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4E519E17DF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9833C221297;
	Fri, 11 Apr 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Srs+ghrJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BE278E7D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369665; cv=none; b=QmKeUp7DOGO1XpR4xq/rNcontH1aup1OX4NUwQGw0x9Sf02fA2XCTTXzdLPCiK9paLmOoJzQ1UbDNdDZzKgrrnfcEXZy7uorj8AzcO6bsRV1QwOdYGNZkhw3TmTi1RJtrASUWEWeNmNGDoK2kwwBamdk/DYpcy62CgUR7ySQqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369665; c=relaxed/simple;
	bh=NVCdGWx2oZcWulAlSe9BTNwujDKzfiKzn7HY/Yoerqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qohQvCQe4lb8MX2EGyPU5hq+Bf8dY+1o01b+Ee9jBf95KocJmfZSNJlRaTyZNGPj+gWI33WWtIdRLPGt+S8W1tesoKXeVq3JCe5WdiaX8wYe3kVRlU/MVn09FDH70JAnp3kCrlEvCuB0FeYS7BMbaESLPIotbI1wbsnCOQkAUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Srs+ghrJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b350a22cso1530863b3a.1
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 04:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744369663; x=1744974463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XLG9LyOBwh9wClGUHHGD4bGh+PDIqzBXkT2KKCmZgk=;
        b=Srs+ghrJDkWQkymHwNVvqlJCI/TCPLFmYIxN8j8MVBUIlbL4IPQZgIFhrEHflYO0uc
         TwwG7VU2Ircshb1Vt8qYyVDO3KapcAE6DY5eAM77jd5JPoXX0tMYiGhCfz/P7llePaEr
         NqgEZw3eBX4FRBpUtQKUufE7FEGV+De+/9iN99dgD9wESO04B4ETc/kIMDxs0Z6/ucor
         Pzh/BnS2r2Zd9sMpPI9s/S8u5tEktazdfTsO3+J0nbxWMvL+WOSB88bpW3HuEP2mIois
         gHTOCpKve2Lt6LTmLhmLnz+Sr4jZfFwPxpdfAtD02J6gWAokAk57qpHRDTSKSdQqdn3l
         D4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369663; x=1744974463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XLG9LyOBwh9wClGUHHGD4bGh+PDIqzBXkT2KKCmZgk=;
        b=t49XGmrPdNSo/Q7AZoIL0Vuq9AKUy2GkQndStVsxWH+nUwrStKG7v7da5xhzkgRase
         fzorND3XlkW3gVeW9HecC6M8Nixt5HpA8/hAzrm9CQItfivxxrmOQ5jqO+Ek6VdyZvjs
         Zp8gv/RwNhJqFyETBub5/uxDV+EH9fdR18xLJDFEWvrSt5vgst1TZL6J8T+/ZZeguuR9
         lQ5vCMC6tNGkvg3r5L7rNq4FhEZ/f/E3fo9bLS5xG4ZgcLMxe4GYz6SYPUl0tjomk2hL
         ynFIejqg/LbDDEnt3UVNRfKN0RWcIOSSs7hpA5wU/72NLnpW0s0PuszTjLsnwROp8nJw
         A1pg==
X-Forwarded-Encrypted: i=1; AJvYcCXGY0w3l2MPe2k+dhB0oBElHafLclfFvz1IHcZlEtp7nZ5CJuJjggZyTdLds8WYMtDVTLt1mgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqFcMB/fv1+7QH/ym11dQVzHmR/zns67r7ZlRrHKk9IJO7kZj
	I1ZlcyrO8EQoj4KXXfII9EqiJ+AYVOpvVKYhFJgD+PRqInKLTdrAnFibVET7Jg==
X-Gm-Gg: ASbGncvoNXdeRUNhfgwo23rEWoV7Qp5zqnFSxrrKTDbvSi2XH6OHwuInO3JmbFKOesD
	1SQ/J6tw0nF/jBLPFAGML55b+Ym3PKPZazkMCmnPuLwD8cdSCMLCHEbAL7i2DnLRIE55gbUMzvf
	n2KLPC/z39IO/C/Btd/oCiwRw/cU2H7ysNL7drEe57pyuY+NNoBya47eLgStzGBnHqigTwyE4vq
	iYEaORJXieuN+A5b7TwaCRo0U1/Q3DSxjf8yB2XukEybtLUCyYPzETzmF1h9uUQCvN/5pt3PzX8
	LWXoy2fpTwS9BY1Qodok9Rkf5SjuQbq+7ttEDVq0GN1B9koZZpTkpohIKrfnznifgiCBBtJNpzO
	cwnLaoqM3DYw=
X-Google-Smtp-Source: AGHT+IFm7A0VgFpeL1lolsIebnz1iD2c6GvvmnzywiHF9zm6AzHf0EpYuc4cmENBCcGaza8M8Vc0Wg==
X-Received: by 2002:a05:6a00:4608:b0:736:b101:aed3 with SMTP id d2e1a72fcca58-73bd11aa506mr3032337b3a.1.1744369663061;
        Fri, 11 Apr 2025 04:07:43 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:b109:bcd7:b61f:e265:af16? ([2804:7f1:e2c3:b109:bcd7:b61f:e265:af16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c5eaesm1207682b3a.44.2025.04.11.04.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 04:07:42 -0700 (PDT)
Message-ID: <c6bd1363-df93-4757-8fcc-96af2f9293de@mojatatu.com>
Date: Fri, 11 Apr 2025 08:07:38 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] selftests/tc-testing: Add test for echo of big TC
 filters
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org
References: <20250410104322.214620-1-toke@redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250410104322.214620-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/25 07:43, Toke HÃ¸iland-JÃ¸rgensen wrote:
> Add a selftest that checks whether the kernel can successfully echo a
> big tc filter, to test the fix introduced in commit:
> 
> 369609fc6272 ("tc: Ensure we have enough buffer space when sending filter netlink notifications")
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
> v2:
> - Move to infra/actions.json
> 
>   .../tc-testing/tc-tests/infra/actions.json    | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)

Tested-by: Victor Nogueira <victor@mojatatu.com>

