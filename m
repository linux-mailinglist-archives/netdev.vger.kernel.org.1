Return-Path: <netdev+bounces-179364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C57A7C1EF
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A6D1896FF7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4020E33E;
	Fri,  4 Apr 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2v4QAORQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD711F181F
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785861; cv=none; b=WLmIK2OHZ9yj3ZqHiqQE84TE8fmRaxXfyB62SaF57R8Q2zS++1KWKMidQYD+wDDrSBEfrLcE1k2qiCIpNlX/kCiZXOgIJ3rQWC3F60ish798Cn8xxI6UAzoq3P5505Q8oMKQXXqCeefVjJtyFuHDD48C5l97b3/TGbb+UXIVzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785861; c=relaxed/simple;
	bh=C1WHNjVICirt+LcG92/pa9gnj51Y+6daX3GfTCAZfVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVf0Qq5c9hUINIp4eyGSCt2ib4ne3gAqpDli57z8NeyIUXvu1zknz1FT5I0ioJ6ewfSaSqyzmR/pOaDP+0r9c0/Yzj29E/tqzdeSiVyYin8c47gWVktqUxvZtDnm/T2fj21aCzSMppTFBGvQBm+C88KOIYYbQrWP6CVTg0VDlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2v4QAORQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af579e46b5dso1515056a12.3
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743785859; x=1744390659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoQh2N77bzJpmFltxTMJKWKzZDSJM18BFg7QwacmcxE=;
        b=2v4QAORQPLiM2oXzf0JzobZkvmMd0dt8PtCaljMuz4Xhoc9TPff7cb+h/meeUDWYBW
         zYEY+9BNrylPju9LM19qijNuszStJ1Bi1zG552hoUWk+I7QRYyHiZM84Odmro80AeHAr
         j/yKqjEVh7b4zNh0o134SRh0KV+MjOC8RSEXFT9qtw0YhNAT6aZDqmwp8EEBUagbkMfu
         wPsJUDRbT9J+FOeqldog8RQ4fJ2rp/fd4zBqhP+NDhm1n4JZ9X0RfPjzb0lquh4zwbjg
         69ZmLuzD4rf+1vFg17DuL3zfrCApZiSPpP/OJQ/GkQWg9gzLTR76fAwHSwVkUDnjDStp
         SVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785859; x=1744390659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoQh2N77bzJpmFltxTMJKWKzZDSJM18BFg7QwacmcxE=;
        b=XfuCIHtIZNHwcXD/q2hQhTzSJzQ2UTTQY3lYJ3+z8FngWMX7/K2IfUdlHE5qKrc6Lf
         9MGTi9ycsK8G1T/+XSABlym6gMn9VnjQvn85yUJWD1eiqXc2gapmS0BrPM9sfPftwOWj
         K43xwSfmqnanxxQtG5yQtH5GYfNTstlMmrsOYjH/J7Kr/kjuRHaV2+EAmMAKAFcPXlRB
         GkvFt93V6ffYj0eD5nXT8wm1sjDp6WKx7LZFE86sbOxrbYFsPh+KPovUk4sJ5fHXPh2t
         gAyFUTl3+OWy/WHCwGGM5GLTkCrYS9iYM+xWq11PlfZa8bP6QoPdxV9PbBVLTxUDq+Q/
         q3eA==
X-Forwarded-Encrypted: i=1; AJvYcCXyJGDOLruFXLk50yOfECeltXfkK03lOmoyq+EwqQUW67vKI6oIs+G+Wpciays+ySXXyBy8coM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LAJkbmBgjTot6/c2dMLJxnqsp9zl8k1Q6+LFsFu7e15PO9ey
	pEW1TXH1s1OBXmVWaAltEIVAgoPkr0dCRSFHrWpHKy8iCcOtWZEcIzXxwTbGsDlcC/4Fnpus8hY
	=
X-Gm-Gg: ASbGnctfGgIQ4Aa1lG4X9CaSPbYfvJ/Q02VK1xP3svz68ZeHU2ESOa7rkzBK5CLip+G
	IKrCpG/pXi0WSfwkPMriRj9JjeEbRmaB157hL3qia3Si7bnlghGOw/Ep3XmHAj1AWsEBl8PNSET
	7S1tXPyGSekVWAGb21eWhKnQuyFF2WWm7+LBY2lulWxpca40FIShVTkDgtTH5NUtKki3PtrKUSQ
	kr+XjMFnpe4JFjufmSDpgeOMaYWHDH2H5G5eRYL05MrsdcBK/kimGY5H/xByeogtRw4NuiiFUnN
	jt7iutuTeNdzYoFEoDWptVM/ywugMCfp8fOxLccpXge2nbTR4eaqbbHHnZ5V01oPVsY7C05Vkr2
	yBAj/trEGLYHMu30=
X-Google-Smtp-Source: AGHT+IENQwoHrXYT+cSs1JmeVMdjXN5NqBRta5pYDWWQ9ED81OJuaqDOaYqlJ/zy9Gg9pEaYMsOitQ==
X-Received: by 2002:a17:90a:f950:b0:2ff:5357:1c7f with SMTP id 98e67ed59e1d1-306a6240e1bmr4305214a91.30.1743785859092;
        Fri, 04 Apr 2025 09:57:39 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:8485:ad62:3938:da65:566f? ([2804:7f1:e2c3:8485:ad62:3938:da65:566f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30584761e65sm3732814a91.13.2025.04.04.09.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 09:57:38 -0700 (PDT)
Message-ID: <f2ce7673-fe7b-4474-a760-9aad245b5151@mojatatu.com>
Date: Fri, 4 Apr 2025 13:57:35 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 07/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with HTB parent
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, Pedro Tammela <pctammela@mojatatu.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-2-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250403211636.166257-2-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2025 18:16, Cong Wang wrote:
> Add a test case for FQ_CODEL with HTB parent to verify packet drop
> behavior when the queue becomes empty. This helps ensure proper
> notification mechanisms between qdiscs.
> 
> Note this is best-effort, it is hard to play with those parameters
> perfectly to always trigger ->qlen_notify().
> 
> Cc: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

