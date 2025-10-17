Return-Path: <netdev+bounces-230607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E761BEBD90
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18ADD6E831C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E52D3EE0;
	Fri, 17 Oct 2025 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg7YV4fN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132219ABC6
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737889; cv=none; b=rNPREn6xlnYCecEhBC7vjtCRMnqEmcOyktoTK0eBQZtHWM+SA9MctPhmIdhnmjbLXbkVTIbWb4TEmKaeewWsiRioNfjdTKCpsOw2CJYgopHD3dnRM2HIJY30orR6Q6KuffPzjyCmIKQw//ftE1pXinTrBC5lz16zMjuq/qztKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737889; c=relaxed/simple;
	bh=rr8FFcSI+YkQ2QDg5eA9OEZHkaqwFttCqNcWzgW2LSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dp9VRuGkEYJg4ImS7C+6LiIkJegasynzByJHePbDWfiYcwUSKv563/T64HpYEP/wspWqNZQ1V8k9tOBqYaFDOTrULQt26rxLdowNZoPq1vk0UmFtuJK+JABGEjo69MfJZCkFoNGKaC3i6o+qaNje0SNcURAsJsIq2RhQVPN8thw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg7YV4fN; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so33670426d6.3
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760737887; x=1761342687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBDZ8eKanHvxL3YLLQ+3ZgNlXjyzZ6dSLC56hDdauow=;
        b=Wg7YV4fNk+qNxPCnCFEJZ73+XUX6o/DAG5ft52lUzEeDX8zrJuHx68+yVF13PdSHmA
         rWHgHIatJSv67F3MmuPCl5+Qzq4O8gEr7SqdaxIqeAkux39XtwqGdTdbnC77csYOd8If
         PgEcd8b1ZdeDmSBKCtLb0jtmXFJEhYjpvodbXAQw7XlvP29HiSDgcx1OTu+wYJSDnK0I
         76sROh5d4DzDBxuk05WdzfoUWm+EfPDfG8v/ZbZcRV1sC6NLDlOIpAHOJj27xb0tI0Tu
         MhnlSc+n5iDMmC5Ut0ZzgXlgRyNphKaOt7ATh1GjXYjJn2FTQEb2s4XeLgy0bcsGB4rC
         0s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760737887; x=1761342687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBDZ8eKanHvxL3YLLQ+3ZgNlXjyzZ6dSLC56hDdauow=;
        b=BhJQU5e7cVI6ykl53tLFIKQ+Hjc+3Ihrp6NP9oqdZ6xq9aXKZA0gh/ejD+rkQZH9en
         N388n4YN0G6qetA4rRIwzapRaiTBvPv9UoQcyRhNIXv3yeIjqkAkVjMGQeI0V7izI7JZ
         Y43j2uOWTWhAjv/jfJy0TqYrkLUiIsVwDz43runHeqZdNawKQQWpzcAc6zMoA62N4k/N
         CJ16zT8C4gY8pjPW3ih1RApuQBro+PUQlaxYf+LuVHU10h/b2MOWNReYiE0DrJ3Pbm3J
         NdhWRuSYQGyThJ3dsPv/5CYJ+wQ6Gs/uNpBkB6Wk7Uqgx3whhlzXtyYoxgzAMA9zs+6P
         vp/w==
X-Forwarded-Encrypted: i=1; AJvYcCXaWjkAdsjNw0K/KSbZxOc1wxAZ2tx7hFUqKjDrHSzmYlOk4Gza+vjyxodx6GHxx41GOQIbWVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIevOiARu5UwNYQIcB51gfT0irRKalnwjAQMTRVnubIAyTsuLA
	Fikc15ZnqeS+rb5XQJctrzB8lUiVMjJuVwZ7vfpw3ZidGgBswTrgGo9a
X-Gm-Gg: ASbGncuZQproFnQimkqIix84wup0WPhuPlk1lPODsz4tZsGfySwpGuQpnknPWYiz9X6
	j3cjReqyUE0lVWO6XW1e2KClm1xtN0MK62jApx2u7MvP0tDGV7860K8IlKoLOwfhoasQfVd+9jK
	E3VmEAOwtoGBXYNJgYDaybyuBb2OpG7yStAOtgi1W0BaG9iJ9e/5h81A0b+PfVnd6nlReXlwwgq
	bmHuh107ZHDC0aNDa85RkKJbIdB18giJ+iN/pQFvO7HHhB7bkuwznTk4EgzHWEuisv6EBzWQP1E
	Wn342hABhQcsCCCoJ84YJxClRXz+WDYnlEIhvRjujRrj9vxONjqkXR1YnA0sBBBKXOFVHj/3Xql
	+ZTe2SRgREZbGHsONFwSsN5Oz8ylUG4rEA/xeMYyn3Sm+Q2gE3JQrCDjhQMWwCk6NoQ18RyaYeO
	cv4uJ+KMDswwpp/fQ=
X-Google-Smtp-Source: AGHT+IE0/YRi/FfDvq7MkavqX8vHUTJt7cEzm2HUboMT0ZApMJrV+n4njtzUp5c9Vr8RaI4t9Ggdog==
X-Received: by 2002:a05:622a:754c:b0:4e8:9fc2:6ed3 with SMTP id d75a77b69052e-4e89fc2714bmr45297341cf.25.1760737887214;
        Fri, 17 Oct 2025 14:51:27 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11c9::10a9? ([2620:10d:c091:400::5:6f38])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab0eb034sm5870511cf.30.2025.10.17.14.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 14:51:26 -0700 (PDT)
Message-ID: <ec51df17-260e-4ec9-a44a-9f0c3d3a2766@gmail.com>
Date: Fri, 17 Oct 2025 17:51:25 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 net-next 02/11] net/mlx5: Implement cqe_compress_type
 via devlink params
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
References: <20250907012953.301746-1-saeed@kernel.org>
 <20250907012953.301746-3-saeed@kernel.org>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20250907012953.301746-3-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/6/25 9:29 PM, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> Selects which algorithm should be used by the NIC in order to decide rate of
> CQE compression dependeng on PCIe bus conditions.
>
> Supported values:
>
> 1) balanced, merges fewer CQEs, resulting in a moderate compression ratio
>     but maintaining a balance between bandwidth savings and performance
> 2) aggressive, merges more CQEs into a single entry, achieving a higher
>     compression rate and maximizing performance, particularly under high
>     traffic loads.
>

Hello,

I'm facing some issues when trying to use the devlink param introduced 
in this patch. I have a multihost system with two hosts per CX7.

My NIC is:
$ lshw -C net
   *-network
        description: Ethernet interface
        product: MT2910 Family [ConnectX-7]
        vendor: Mellanox Technologies

My fw version is: 28.43.1014

To reproduce the problem I simply read the current cqe_compress_type 
setting and then change it:

$ devlink dev param show pci/0000:56:00.0 name cqe_compress_type
pci/0000:56:00.0:
   name cqe_compress_type type driver-specific
     values:
       cmode permanent value balanced

$ devlink dev param set pci/0000:56:00.0 name cqe_compress_type value 
"aggressive" cmode permanent
kernel answers: Connection timed out

from dmesg:
[  257.111349] mlx5_core 0000:56:00.0: 
wait_func_handle_exec_timeout:1159:(pid 72061): cmd[0]: 
ACCESS_REG(0x805) No done completion
[  257.137072] mlx5_core 0000:56:00.0: wait_func:1189:(pid 72061): 
ACCESS_REG(0x805) timeout. Will cause a leak of a command resource
[  270.871521] mlx5_core 0000:56:00.0: mlx5_cmd_comp_handler:1709:(pid 
0): Command completion arrived after timeout (entry idx = 0).


subsequent attempts to use mstfwreset hang:

$ ./mstfwreset -y -d 56:00.0 reset
-E- Failed to send Register MFRL: Timed out trying to take the ICMD 
semaphore (520).

I can toggle the parameter ok using the mstconfig binary built from the 
mstflint github repo.

Let me know if I can provide any more information.

Daniel

