Return-Path: <netdev+bounces-211079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206BFB167C4
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 22:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36398582DA2
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE82222D4;
	Wed, 30 Jul 2025 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHheDNHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03591221F02
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908666; cv=none; b=ml9lIUqdMGzZjDzvOAFOvWxEfTWaZ9B64i3pPKe7J29q7F+uBF0dJg8CjDR8kJqZXc6FDTsW3WkCtvRXLqsGFV9nX5KXX6NdGmSL6HzfLHbmD8Ev4cGzI/zlo03MjzzlMU54+xv/FE3gC8fjtOvkaweAaCtd8NWc3YgpHF+5OaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908666; c=relaxed/simple;
	bh=iVYbyzIT2CcbZBT5zfZP1D0mCxH9m70EEgOYSdaOVu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CsU5zASt+KBiYFEgB1GFayQ0VEj5oSeVysAXlIsNr9WuLknAQ1x1ele2Fua0MBu3boOnhpT+oM/oNOWSEcNpIpnnfnvCHd9c4Jkfn6DpcTb0xZ3VTKA2pxtE3gxhWv6vTyEjmJabGt7fx8z6r9ir2Ajqj03mPSqDW5w8z+7bxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHheDNHa; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e62a1cbf82so24919985a.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753908664; x=1754513464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ELYyUMM/RtwYS0EHYI75dftDRkLU9si17hHS6JeWJOs=;
        b=WHheDNHai+qlQlOo8tVLeZBkOhUFlBupawsEIkg2fOuWU75y5MRiWisASlgOJ/goUN
         QZaXAUfV0mFSFuo3AKhcOzeQ1vSEFhlQumj12dhWIpqwvx19HYpk7satVkp59YCgnnxN
         QE+zVTk7CX04AHT/oukD6x0ija+Wi9cSR2AascmUEaThOTda0yBwvE1LOtYa3DM7r/vN
         2ySegajaB9zzwCFQlHeuYT7YzqhOe28a1Uf52zkrivevZpDEUzUQaQckzruLgXrOvt8a
         nDgn4/D+AKHJC8gbXEeMryRPd5esitWjZdD0wva3h1roIUjirKoecJOUQ5BSjNh0cixd
         YXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908664; x=1754513464;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELYyUMM/RtwYS0EHYI75dftDRkLU9si17hHS6JeWJOs=;
        b=ldft1WiAr/n6DTEfipngPYzicito6V79MSyUzjhsC9xa+F3aOrSM8yJINkS68WFqH3
         iIU7s6YS75W7f6QTOpyXyvVxWu5fc11gmGDbGbnEIgpI3SlyfEMh8NPnW4KWAA4qLDyH
         LcVrhwOjmX8dKOV66i6bkPAVCU2gSG46G+oDtNjJzuAZrVXh7DxsPk9CX1BK9o1QWndk
         oVGe3Sd8Y3k1pP99onAfrXJmJOayaHWBrpxKeMvEmFREqvOzaGdeif1bC0fX3/iYjNaK
         Pcklvb+61+PAfqasMcHUif9E4+pFTOU1Pzp4g5oKMySDgcDEpJwe3OAwkfpHIKnO58BI
         a8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWNgS5vMSDzZxN0hrxmhTcEjUncM+jH3xljjC7ikyYlurrOsGKb2jMT6mqsJUTZFOI+yRe9ZDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJKqgHM3RKKh1hJn2EEyJO8DdP2Yyc8lVQF1l3HzuBNQDkZ/3i
	sob2RUJeyM3LINfqLMX7qqQlxHOq7b5/81rXsJLsu80B+2CHswqNN4rBc+4cXQ==
X-Gm-Gg: ASbGncuF0K9S4gAqJW0B+/Zvysg9XtdHJI8MFn4QVtGrBHwccS/rJgcI2pVPTn32A9D
	zCxWh9GMqxWMLKc1xdns7/EmzG1iJKYTsUhIvc24eUs5U7r8C9QXctkwINSsTY7rXFTEOvnozAD
	00aoAIyl31odiWnNUYfP1jsfJrb0cEZVUsmnEbq4/2zlZ5cimzsb4J2KCOcoYvbvfsx1IcifTxd
	qsFaDvJ8UZ9Ne7rY9Eh3NukUUv8f08VDe5euVWOiSBW/+/PjrLGQovXmyf+qK0pi9539eVN7lx5
	6QVkZUnD1JQOBoV2Gh56Do0moc4qSRvX0GFpwZtTplNmfPqPsUsKZCQ8ukXDGQqWq6x7hfrHPa+
	JtI+B+aeU874SHv3Al7h9mzfzXZcn8cbcqal8hvShZl3Gwj/UbRV3vGJ3wdHO
X-Google-Smtp-Source: AGHT+IHRh2fpv4M12nUTt2aEr/sUWj2m6K9yMn8PPToR+0Yj4zSezm1X+wVifq1Q2af9xyK+QElEYg==
X-Received: by 2002:a05:620a:2584:b0:7e6:67c2:a95b with SMTP id af79cd13be357-7e66f3b4567mr636621285a.51.1753908663586;
        Wed, 30 Jul 2025 13:51:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f75bf3bsm1608085a.84.2025.07.30.13.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 13:51:03 -0700 (PDT)
Message-ID: <87e4b093-39a0-4765-8fda-dcf8615c7dd3@gmail.com>
Date: Wed, 30 Jul 2025 13:51:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: no printk output in dmesg
To: _ <j9@nchip.com>, netdev@vger.kernel.org
References: <439babd9-2f47-4881-a541-5cb63b94aa57@nchip.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <439babd9-2f47-4881-a541-5cb63b94aa57@nchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 16:26, _ wrote:
> Hi
> 
> In "stmmac_main.c", in function "stmmac_dvr_probe", after probing is 
> done and "ret = register_netdev(ndev);" is successfully executed I try this
> 
> netdev_info(priv->dev, "%s:%d", __func__, __LINE__);
> netdev_alert(priv->dev, "%s:%d", __func__, __LINE__);
> printk(KERN_ALERT "%s : %d", __func__, __LINE__);
> 
> But in kernel buffer there is no messages from these 3 function calls
> 
> Any suggestions how to make printing work and why these are skipped ?

Are you sure that the kernel sources that you modified and compiled 
correspond to the kernel image you are running?
-- 
Florian

