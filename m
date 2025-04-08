Return-Path: <netdev+bounces-180393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 158C2A8132E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFFF4E4965
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4A232378;
	Tue,  8 Apr 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjuyYhAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB523A98D;
	Tue,  8 Apr 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131671; cv=none; b=T00Ux2DYP7H9ufGgrJWKM0xJbWtSLaIHHZUBnpbfY26IpbgJo5dPthgzkTBpZJjGd3CfTnVqVeoVkIHL9Vgi472pOQGw9T/vGY2NBXp0L4bblZeMw0xY9x7/+1o6PPkvuvdIRknIE7Q7CDmXYO0qx7bpnq9ER51AZxe171eCubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131671; c=relaxed/simple;
	bh=N6kP2++cC4tYB/jmzigw2pfWwl2+6CJWNdXFfBt87EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4cuD20KHXcQ/t+Akx5RkzKSTg4P42VLcJclo8D4slx62BoJqvKkkLoQoVHv4oJe4djgftbJMqJexi37QTPFCmp1U1yjmaOBVAZQO/IPhavWqilGznTIppo96dnvH18ey4S6LJcjzPnJtg5PmKGs9Uegv3EER1e2iZbpl+Sq6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjuyYhAb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301302a328bso6261069a91.2;
        Tue, 08 Apr 2025 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744131669; x=1744736469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWc9jP7frlP15MsVrsg1eAcE6YUj4TFtJPNbl9lMOFI=;
        b=BjuyYhAbQyfldKgmPTJWNKsYaw1Hj6Pi2O7hK1kZX6elQ8H8DBtObYZDHcEzvl6qLT
         GWnXGftE2d3LjMqkjkk+hFt63HQgXOM2UeF9Qgof0m7kXrHuflV/yXZ+CEYS9RamXtyh
         syVAKTG3H+f6Qc5WhEeWuUz4XKDrqcJ7y1khwIQf4CQE10UAvbgFCvzO66i692Vc1Brg
         iTreD1p8XB4+eIc5VhFOFakrQhMWLHjKmPyBfG4keSHfJr4kcoJwe8mETCJhdH+7ZH99
         is1ZjdoriGGNgFJC8KQLQ+9qltYywcAv4kxg+3JLxF1w1hpn8em5LiP2ehAoHoALsCZf
         gXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744131669; x=1744736469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWc9jP7frlP15MsVrsg1eAcE6YUj4TFtJPNbl9lMOFI=;
        b=H8iEFtgI6m31o6MihmiWvZNSXXy9KUaJ4IX4I3FJAQpd0/ZHDkMMn03flKx5PXNYY9
         nXQDiEgYEApMJmQvSoo0yfulE2mKYFTG0faDVRz4boRhAsgQACXxzT1ocoCpt7DDllIl
         I4bVMHHSDHGSv2WDHak6zT+r124lzuESMBNpvNKEHTH8SO59XIyCbAc++hxScxWnkLgD
         3ygSVVYI+kP6FxcrIcKk5WRbl2j/4rd/bXt+F4iyw7ANr3GG+dNGvmtMX/A72gHO0+QC
         j2OepgAemVwgC+hyXDDXvAVKsw25Ih5M5Va+iAfZydb6rH+02UiHljlVcPXAMEWwS3L7
         mksQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuvjhsp3N0h91eciyBSKvh3qosvcnUQZPSG1VKb1ErbgaNvrjaqxqjesNCkQ7whgb8YV4xdoQEEeJqs2M=@vger.kernel.org, AJvYcCXAGoQLUu+VVJT6cZ31w8dAvF0/+6q51/5XkK+/VSxwPQ2//Wt4Qnxk+SF/ap6fcYLivgVFuw6O@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOb6QdKZpeBwA3Qok/zlYRHPUJrs0aijY0AhJsclCpe4sYXHx
	fLoNWy2O7w9JRlnoyJ8a7CK2zLqhVF1Vwn6QDmiu30T1neX5sDHlMlXIr5JK9z/6
X-Gm-Gg: ASbGnctNYs+y7+h9htq2NmV05yCOlJoDO6fokYvmsTDiUgU/5BRD2EdmuFDd6FEbl/h
	oVHlIWjWvt8VGAzuHHwXcTAF1aMCwVDr0P6KxGhVPSsh6dLwKQri8V/NXfm8ae29mR8x6nZ3CR7
	KEX9rISvG5vKt8NXQ5KN4qEsI96M+xHu6JYwN0d3BKh6vasNUVNgnKkrHLlT8zIXt92K/UwTspA
	hnLgU+1ugPbHZoyHfVKlTR1Qvj5WD5WWr1bjo06ZKV8QX2ZpWzLa8Nl4Vo2bknq6uGKM+rSVKkr
	Ip5QayPxmAU/Hr3ABYRzkZO++VXa/IdkmoPilOfcnTs1QhvnGTf346CXx5aL0X9/rCFjxPIj7Pk
	gI9hxoMIRQNmpDlqmZUC+
X-Google-Smtp-Source: AGHT+IG18mb409Cnnfo0FgJPQtpkR3IOWmGFxLJQRKYZN3B9w5fVN9mvVZ8KR0T8Mgq30KwBagp/FQ==
X-Received: by 2002:a17:90b:1347:b0:2ff:5016:7fd2 with SMTP id 98e67ed59e1d1-306a626a0a1mr24782562a91.24.1744131667576;
        Tue, 08 Apr 2025 10:01:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:ed73:89b2:721a:76ad? ([2620:10d:c090:500::5:7de6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306d3738b90sm1980962a91.1.2025.04.08.10.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 10:01:07 -0700 (PDT)
Message-ID: <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
Date: Tue, 8 Apr 2025 10:01:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
To: Sam Mendoza-Jonas <sam@mendozajonas.com>, fercerpav@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: npeacock@meta.com, akozlov@meta.com
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
Content-Language: en-US
From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2025 2:44 PM, Sam Mendoza-Jonas wrote:
> On 8/04/2025 4:19 am, kalavakunta.hari.prasad@gmail.com wrote:

> 
> Looking at e.g. DSP0222 1.2.0a, you're right about the field widths, but 
> it's not particularly explicit about whether the full 64 bits is used. 
> I'd assume so, but do you see the upper bits of e.g. the packet counters 
> return expected data? Otherwise looks good.
> 
It is possible that these statistics have not been previously explored 
or utilized, which may explain why they went unnoticed. As you pointed 
out, the checksum offset within the struct is not currently being 
checked, and similarly, the returned packet sizes are also not being 
verified.

