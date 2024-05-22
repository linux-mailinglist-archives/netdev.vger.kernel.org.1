Return-Path: <netdev+bounces-97606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69F8CC4E9
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 18:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83A3B20DD0
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC831411F3;
	Wed, 22 May 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b1W5D3q2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6114038F
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395709; cv=none; b=RXHTJryhYNjHejNSDfZxKEccVp5jXf1S0XBLINoqWJPU+WZ1VMqMzGJWIkTzDFWKbywxfDelvaVUB4e3s4v2Eyv0oMPfPI3Uk5nvXJzS2/985X/WYeYKokBkgs0/RDplYhhRqB7Q1Ciu8VbUahEdwv1P2SLbCPIZ6ncqWKHb+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395709; c=relaxed/simple;
	bh=wow702hEWO/XsKIRiOeK7H7iVtAxQpkaiyuys0HINig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dD6hbAO3Sf9TVv9mqU9o6Qst97iy0MCaIDBrylkCKv5UweDApAOjrYZQ00WOrLAJ2UIA31zf2HpPGqs/ekMSSIlA0CQoAVhpnvRFLnzWA0QDurxnO6B4VuiNmom6UoDBhqlqFJ4+bsr2iUrOJTtQ6OyrMQq2MW6pgSfa17/sBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b1W5D3q2; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2b7af31d7so329062eaf.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716395707; x=1717000507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FF30FLh4FVIj5wgbcXLnpEEb1c/d7E6kmTu0z50oYHg=;
        b=b1W5D3q2beJtX3N9HzvoDuQ7BBtVhni8fHJ1kkFxClZdRBBrPwN11W+d/L45GTTpam
         TwaV+CD33Hjdo5YBrAIZySOKgdLuyNNYxRJz0GMKwaAhpxCkAXENKgGf4kLlwGHkKtfX
         L6QaLdyGvfMmd0q7a0i2j9/SbepGGDlun2SNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716395707; x=1717000507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FF30FLh4FVIj5wgbcXLnpEEb1c/d7E6kmTu0z50oYHg=;
        b=ALwb9v6PtS4uJD54FtU9H7tQAQ/WMYFoA2O07VjkYfyGxepjsC7clcZ64q81BsLiH9
         EBrTZDoG8dckV6rH92z75vjpQ6XB43zsVHVlV3ELBIyIai4FiZM7fGjLAiU6tN2eTIUy
         OYZE1dXnR3mIy4Sybhjr2/R+k79wgcq/GkAxN7gdS9YoxGYBHJCSpbk/Q0rO349NOtpt
         cEI7Id4pnV80kPzvvsSkJ4CgZqRTw6a+kKJ6Eq5BiF7Taz3AnNkM4rSqr9cYXr6eIOJo
         VyMonH+5KZomZNUIMJkBCMjUEUCxBiU0EXInTEyjeKiia5BRRpBDSyiiJGApvTOglaGY
         Q8tA==
X-Forwarded-Encrypted: i=1; AJvYcCWCpHB4ll34LYMxWpAiNXQ3dGkYd34vvkEzHmCoF2RfniWhTi2Eb0KlQOlaip7GugNntTMkDXmUCBsz6g4cfFq62x3qfRSB
X-Gm-Message-State: AOJu0Yz/OOCIXPYJo6Te6yDCdgLZubze6KJu6VX3qx4qzBOHCEUBDt4i
	lmMwiuTP76zUG1YNRwQ48bEaj7JF4WqMeK0sZ17beH55f3XiKOGuUPFQPK1vIBY=
X-Google-Smtp-Source: AGHT+IGHfAC3qkCN6OulIhZiaDBbxXmwg5VKYB936DJVaSdhJlQGCxL++LW2UUdg3/EuZDRuVOh0Ug==
X-Received: by 2002:a05:6820:2585:b0:5b2:7d9f:e708 with SMTP id 006d021491bc7-5b6a2df34f2mr2891522eaf.1.1716395707090;
        Wed, 22 May 2024 09:35:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b31b52263fsm2644126eaf.21.2024.05.22.09.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 09:35:06 -0700 (PDT)
Message-ID: <25596b05-205a-471d-884f-289db262c485@linuxfoundation.org>
Date: Wed, 22 May 2024 10:35:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: Paolo Abeni <pabeni@redhat.com>, Edward Liaw <edliaw@google.com>,
 shuah@kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <b5e333368d9e69efc6325187a23cef4f4337c738.camel@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b5e333368d9e69efc6325187a23cef4f4337c738.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 01:42, Paolo Abeni wrote:
> On Wed, 2024-05-22 at 00:56 +0000, Edward Liaw wrote:
>> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
>> redefinitions of _GNU_SOURCE from source code.
>>
>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
>> asprintf into kselftest_harness.h, which is a GNU extension and needs
>> _GNU_SOURCE to either be defined prior to including headers or with the
>> -D_GNU_SOURCE flag passed to the compiler.
> 
> I'm sorry for the late question, but what is the merge plan here?
> 


I have asked Edward Liaw explore options to localize the fix to the
problem introduced by the following commit

809216233555 ("selftests/harness: remove use of LINE_MAX")

I am not happy with the churn. I don't plan to merge this series
as it for sure.

If and when this problem gets fixed, I plan to merge the change and
take it through kselftest.

thanks,
-- Shuah

