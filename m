Return-Path: <netdev+bounces-213794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D604B26B1E
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FC75C30F8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7130223DFB;
	Thu, 14 Aug 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EP0Zh5mv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4EA223DF6
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185465; cv=none; b=AUT/x2iuecTqCLM9k5dxgzVFz1buYk+HuIu/juc6uROC0RVVCdj+hyJVbXSD7ApiePkCl/pWfJHR9fU5v9Yz6RCFuVz7Z6Q7hkOSIPMP2MNrMT6EqkQdFVY3HP6wdFXQxKG+9vEczpUbxytBN5D69tcWbxUbTvVpRwv5o3dFdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185465; c=relaxed/simple;
	bh=6pEXfEutJZNFRvI9iOQTeyeyiNCFfdCXQmwpC/lAWTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8QExL0b4IIVyVIy7F7YRZI0fzLvMoRLKt7rkPMXSiz7SBu2fjY0rXxZNLVF65ro2JNjJ9qQcsraaV9MNy+CSDkVC+LZ8F8Sut4ehJOfpOaHY7hmH4fbku7ogYfiY9Sou0ACrUTryWM8VIb0M2YqVOD7EJ2Arus+LIGf6NuLKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EP0Zh5mv; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88432dc61d8so85899139f.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755185463; x=1755790263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P81sLlQTBntaiAmYzutesJIvj0Q6YtF/nY9RwqB2OPg=;
        b=EP0Zh5mvgRkeSespWlx8Bxo1bZi+JsDUlMxfzcjBx7PvtHBc0cZtFRz6kpVWSRATGZ
         zhxIA9Ef/z6NwcRL9JWdei1bNjySEyR/oDVYv24Xp1BPHJd9p0YTxmR5qZF7SVrGBmFn
         qPf4waKU4d8FWl+vY+VWHT876/DLdAQ27xonc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185463; x=1755790263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P81sLlQTBntaiAmYzutesJIvj0Q6YtF/nY9RwqB2OPg=;
        b=c7otjEUuChTBFIX2Ze9rhHCN+fCB/7s07c2FDdi2ktD3J/eALUW/IRtE5ibaxMKEBx
         0zPzxD3yz5NLsSEZVSID5LKAmKsqqmyQ/2LrTl355l5/Kei6rwpuRdtVmUlr0JF5mpAX
         QB0oCDV4A8j25bD3XiWXN8KctRVqelQAQhW3rYAvnwZdFMjPyBf9SENBBEZQ2Bvjsu7B
         ykUEIKlibwf+TJEca39yHKU3RwgclmAUG5R58P//6s/KN8cLrFBcFVJK++diQ9WG1qKU
         D8sNlM77U/F43Wq9RW6MTzMtqXgwc7hO+mrL8cd+4uScRj79EKyc35IyIotyYhlnnA+m
         9S+w==
X-Forwarded-Encrypted: i=1; AJvYcCVBxNo/vhDLpNrvfwBFyoTU7QwcxQjWfz2iOj4zEKXPEEk08jgNt3x5NjLVkMmDDT6fxKkBs6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXS9EBukgkDjkAVzYPU4aby87GeoC5kRAub/n5xBEB4OYu+4W
	WmNN4sP0I+k29+Fg3sQdmEnEvyBLVg/h5/AO9S32bZ4Py96ISzaNCUre4VqQ5lfeZj0=
X-Gm-Gg: ASbGncuYLkFgV51cDOn0Fd3ehWO8dQVfCdSFZ68SFRPpj+wBxEoWNcSR0twEez3gcRs
	l1u7Qo8C5veVQ5MysASS/wakEMnCNdmamWypwKXzhNQnx/JoEuSmC3Wm0Dfgz8zuihqEVkuDaCR
	r6bEeFRSbo9Z8+Uvz+AkWwqB5e8m0AordJ70ijYMEYCziK3a0l9bzR2QiW6L+IZcTgFxs95S558
	1fHi0Brh6be5ETVRGcB6B03DAJTSyFnnyo8fbM4t9FlfBGChI9bjpxjNGhx8mK8AoXSxPOJnwm0
	pUzjw00VO9NOlUGhnCGM8Y5xH1ykiuHAAujanHBbbI5eP+b6/X/P+IymBSj7ruuia/A62j1muPO
	Cky8fjqk/Zq3hoIKx6diNO1fwbC88Pj0iCkiJMvajR8E7JA==
X-Google-Smtp-Source: AGHT+IHqEzRf3rffyzPsHD2EKsF4U453EP+95KNO41JbKJnPnjn6DHb2sPXPvKuMmoj+GWLiCfXedQ==
X-Received: by 2002:a05:6602:148a:b0:87c:38f7:556a with SMTP id ca18e2360f4ac-88433c9b735mr588192239f.8.1755185438769;
        Thu, 14 Aug 2025 08:30:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f18d5d77sm535160439f.14.2025.08.14.08.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:30:38 -0700 (PDT)
Message-ID: <08a4b41b-fdcc-4104-b02c-ec28078ae80a@linuxfoundation.org>
Date: Thu, 14 Aug 2025 09:30:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] print: fix spelling error in message
To: Madhur Kumar <madhurkumar004@gmail.com>, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, shuah@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250814144916.338054-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250814144916.338054-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 08:49, Madhur Kumar wrote:

Missing changelog - commit summary log is missing the subsystem
details - selftests/net: ------

> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 8a0396bfa..b521e0dea 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -1877,7 +1877,7 @@ class OvsPacket(GenericNetlinkSocket):
>                       elif msg["cmd"] == OvsPacket.OVS_PACKET_CMD_EXECUTE:
>                           up.execute(msg)
>                       else:
> -                        print("Unkonwn cmd: %d" % msg["cmd"])
> +                        print("Unknown cmd: %d" % msg["cmd"])
>               except NetlinkError as ne:
>                   raise ne
>   

Look at the submitting patches documentation to learn how to write
commit summary, logs, and how to submit patches in general.

thanks,
-- Shuah

