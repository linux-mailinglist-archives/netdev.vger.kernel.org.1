Return-Path: <netdev+bounces-187367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE21AA69B6
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 06:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4DF3ADC97
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 04:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF019B5B4;
	Fri,  2 May 2025 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="BtKI8nvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46728F1
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746159282; cv=none; b=KTC5dyPYSLGCq6j5y+ajes0CMAgMUGhdD6YtEm7nGKn/6M8+2+qjkK+LwQjbKQvipi0wJ6CLo+RG8VZ0jZ3bWoZVr/ZSX8508Gx3I+6nskY+kqLuY78L7FDDhpuycXOK65jiCPiUKP08+yVk5dl7F5FXPdFcaRUrO1TMBbzBjkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746159282; c=relaxed/simple;
	bh=bkO+hsiCkKkIYKZyxNYWFLOIO+ikfLHbYanlhTIbkEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJNzAHlS6u07m/pUtdUQmAbUkeT/4JMmK1q0GcddKrX103d1eSTECdpltfYSzS/Pq/vidsEFZBBQXPbFsBoVKopGO5U5d4RUF4WMbt0yj0Jv/bdTH14cPwAygxAxb1WnAfqLRWVkVw39qeGmzTTrx5CwYPksfFMsY4nBHn8UseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=BtKI8nvu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bef9b04adso14610221fa.1
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 21:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1746159279; x=1746764079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9dxMHxHGQFSFuCFJR/tpGkJfuZvFN0FE0shIf7v3xQ=;
        b=BtKI8nvuKaO+sZrpLMVJAoLC28CHrwVe7j8gIwRyu4f8iUrLxU2o8/5kID4BymtTSV
         wqQiEIPilPH3F+htGBMW5JYg7aL3ETtLRqYkN+GiKNqT2YLEEZKUR660VAhxByuDrPSb
         RDhrk/kSccDhokSxI8JhyYbWQQYgKg/Cvnh2LbqSNimrEZ2L43uA42/AII+3yjoi6XQy
         V0CoipRY8yXTYFW1LTIRtRF5mrTZjVhd3ikdIKizV/wJWgKDcSDOUTC/FWfsDoiGikvx
         7emIlQ2dqzYf4L1s5LPAGoOpAHpuxEaR7MBWRed3VTSUvC4f5285FEkp5RRIdyg0/5M3
         J+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746159279; x=1746764079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9dxMHxHGQFSFuCFJR/tpGkJfuZvFN0FE0shIf7v3xQ=;
        b=d7kuNVQYo7y0A1/gXY7S43PqIkPmrefp2QB5QFoX1TjXlQFeuevjq9QyiVaTHTJgxy
         GZKZcLmylo50du8OzsRWp1NAPhsKxYR/49JUoRDiVuIiZQEnptpomrnH4Z275nQkm6LR
         8hMo1l+Xin1bBxHBFKO13nN9nUKjsFGDubNSxReWAleqACR791q1/MxstEz9ddk5/6Uh
         1ErlQnFeqAE75nEEzZwCekAb2GxB6EnTILNAd6zkx6f4Wg8LoHQc5iJXFb2IgN6cWLnV
         UcaZb2KDJR8gd2YAQobxKhaQfFSdyiyiAAR79SzYsHByef0L+Y0O4EzspL+g1EGxPWXN
         wTXg==
X-Gm-Message-State: AOJu0Yyr1Cyk8zuoxO7q7q/9DYJahs1TmTzp7pm5HLGDbQi3L+/cPXgx
	YGOYUVFkiJAZ55MpdVhm4exLEDFnh18npNpcv8peq8HyKpt7y76jjemnYuFDe/M9q/zzO9IOkZA
	ZCY8=
X-Gm-Gg: ASbGncvE4OOu1G5dZbhZphf6/IoObDUGbSoN9UYLG0yyG2kBzL+HSCgrkXubkcHW2Lp
	jU67rMGLQO4wcTv19jV7AQSelcX8Q78r554h8x/G+QgPw0Fh78kJo/doPWrnIHDnftD6zSxotVg
	3i6arTDhnnVTg2WIcIJBqYF+Vup+Xoefl/fP0WMJvCZ0zoE+Ajp+PYNy1KExXSCd/8VMiyMevHu
	rynSu8t3vxQLv06sk2VHuyEHaY1TEIBgp+0kbmmBoqGoygT3r473hXukpYa+8NTJ0bj11337eiB
	+RbIqvsi81cmuN53OUai2x2DocXSTUvoEv7tWGwiJwcnrhMpnNkAxYTYTpEzPAK4sd7ze/EBjBS
	VQBq346AL3TXeWFXUuDAKv9BU3SH6fg==
X-Google-Smtp-Source: AGHT+IEoVyVMyOYtFJM/chy1gUkFhWkmn9T7eTV+hnbrn97tjQnk33BPCJARqicfVVsCjkgIeYlKbg==
X-Received: by 2002:a05:651c:19ab:b0:30b:d543:5a71 with SMTP id 38308e7fff4ca-320c3af139fmr2888981fa.1.1746159278745;
        Thu, 01 May 2025 21:14:38 -0700 (PDT)
Received: from ?IPV6:2a00:6020:ad81:dc00:46ab:9962:9b00:76f8? ([2a00:6020:ad81:dc00:46ab:9962:9b00:76f8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3202a89f450sm2509611fa.80.2025.05.01.21.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 21:14:38 -0700 (PDT)
Message-ID: <93e175a2-485e-437e-8957-403fad70e902@deepl.com>
Date: Fri, 2 May 2025 06:14:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: Possible Memory tracking bug with Intel ICE driver and
 jumbo frames
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <06415c07-5f29-4e1d-99c3-29e76cc2f1ae@deepl.com>
 <f5f8a9a0-a590-467e-81ad-81e1feea3b79@deepl.com>
 <445d48a8-8e4e-4605-bad8-4a80707a1452@intel.com>
Content-Language: en-US
From: Christoph Petrausch <christoph.petrausch@deepl.com>
In-Reply-To: <445d48a8-8e4e-4605-bad8-4a80707a1452@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> The faulty state perpetuates then forever? (say, at least few minutes)
Yes, the faulty state perpetuates then forever. The first time we have 
discovered this issue, it was there for hours.
I have another sad news, while bisecting this, I questioned my initial 
assumption that v5.15 is a good release. I managed to reproduce the 
issue on the v5.15 kernel release as well.

Best Regards,
Christoph Petrausch

