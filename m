Return-Path: <netdev+bounces-213841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EEEB2705C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D95C10EF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14A272E4E;
	Thu, 14 Aug 2025 20:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF727280E;
	Thu, 14 Aug 2025 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204578; cv=none; b=KywXVnMqYwjZdV28ab4ySenWJLGZ1GEejVbA3g+rfOBd4VfIinAU9ozJRioE/xhVJrMXJDGExGluzcFKFHiLAX3tmUBBmeDbN71+1tnd1Zc7PwxPfQrskj32uO8jPB8vYukGLGgsqEazDGHIh2C+fL1TaCZbBo2GdLHebhq6zuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204578; c=relaxed/simple;
	bh=6YH0V5TtuR31e5IUVdrVVE+axIc+PE3GtGRCkmzWpu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=R38ORkwWAxPSIhd5SXPRc1kEWtRFr3QakXj+6Lc4myScMYZFJdxmY3Vxtic0ac66OjvWsQG8mXnRSrN3TCaY9XZx3FDWi3yXKuyP111p51MxiDPf3RmDKE84w2HSMhIANsTKkHdYdcubxjZj2MQ4yb6UjhbxFMyXXBoNDKDMdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6188b6572faso1604484a12.1;
        Thu, 14 Aug 2025 13:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755204572; x=1755809372;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6R5VKvGXBBIknHibjbfPhVbLYlfL5df0lj1LKuO6vVg=;
        b=ZrwxjG1YjoVqFEzH2TPVt53R1ErKtEfHEipBsgtS7qOGxP+vy2VTh3uMbz0QQEkHgm
         VkjPR5rMA8kXmYaY6LBF9tnhrI5UbU3KKnbhKWUSTCpF1B2qUUPQ9Th/eVf6n5j09Qf2
         M8C+TYFCV+QXyySw3+C2401Zy8TFDy+n2RgEdrSmt4QeMW8Qh0cko0K3REva9LgHfxfl
         KvD84DPCAQqaMOqdM3obT/xRTHXoCNfQrwzgq3cBKWgOeGlUVjX7s3QoMYxm2M9ix0iv
         zCG8f390+rkLHmStPwxqlc4hYrUInllMKEBnFk3TINl5SMNJlHwcW5SNvpvtAsCDO1XL
         BBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvGF/OG0lfNpYyO8MaelB1+LGFzIWFvA4j8FlzSoc47cixP5D7DDWfohqi2NFfmWyY+wdJwYZNRF2O4cQ=@vger.kernel.org, AJvYcCWzUVrzcQXUIOrGNgu4yAJG95ij8HJW7R9ca1u593Gjr8oJAxnTB2esWCgAn5wlZNofuMO14i5G@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbY5goMWHAgGC7ROzsz52F/LYSfXdOYaUnJgIcucmggnZVyeX
	F+u0Nfr225JG7jbynUHUwrIs2gj5YqGkKQnm9D4gwtgRVMGBzGhtTHBu
X-Gm-Gg: ASbGncujc4tWxIIPezJL7Rx3u7y1UST6Sdn39WC1EGMsLjo/kL6uQtUlI+eCoQvo1gr
	p3IBNFOJJeV11jIumjmoK0asJNLBvDbkBdNWCjIXW9ALavz+uPUh2tkHIST6pwtzLq5p3yi6TNs
	KzSSITZlE6jI9zU8vaJmF8UiNFnEq61QJiP0QW4nIQc2Z6hfPWjqaw6OkrCni4k5yparKyQ3gV+
	jPEwFMw6KqXnnFL6VSrskJCPP+0zWF+xf9f9OMKbmcI0cA4j7LGiZW+eGMDeaQly914M+5kMN7K
	Ken2fvD83QfnXuu0cdxqYFg/jDLXuVHGl7r0H3XeLGleQC05M1JLycxjbd8OmZtiMbo/gHBkimf
	KOtgcUC30x5FsBfqez8V0n1lE92oeF9czoygSYDzQ7Xm789Go1Vo=
X-Google-Smtp-Source: AGHT+IE0vlWKFKfXncxOvS8UJb7kXujbwbEcKTdhTlmU6VtLEwpk/MJV3qCWIx5ZUYHtZsnNu0Q9lQ==
X-Received: by 2002:a05:6402:5106:b0:617:d98c:3fa4 with SMTP id 4fb4d7f45d1cf-6188b9dbcffmr3730482a12.20.1755204572009;
        Thu, 14 Aug 2025 13:49:32 -0700 (PDT)
Received: from [192.168.88.248] (89-24-36-92.nat.epc.tmcz.cz. [89.24.36.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-617b11bdc49sm13660769a12.7.2025.08.14.13.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:49:31 -0700 (PDT)
Message-ID: <c5b583a8-65da-4adb-8cf1-73bf679c0593@ovn.org>
Date: Thu, 14 Aug 2025 22:49:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: openvswitch: Use for_each_cpu_from() where
 appropriate
To: Yury Norov <yury.norov@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <20250814195838.388693-1-yury.norov@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Cc: i.maximets@ovn.org
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250814195838.388693-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 9:58 PM, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> Openvswitch opencodes for_each_cpu_from(). Fix it and drop some
> housekeeping code.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  net/openvswitch/flow.c       | 14 ++++++--------
>  net/openvswitch/flow_table.c |  8 ++++----
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index b80bd3a90773..b464ab120731 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -129,15 +129,14 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
>  			struct ovs_flow_stats *ovs_stats,
>  			unsigned long *used, __be16 *tcp_flags)
>  {
> -	int cpu;
> +	/* CPU 0 is always considered */
> +	unsigned int cpu = 1;

Hmm.  I'm a bit confused here.  Where is CPU 0 considered if we start
iteration from 1?

>  
>  	*used = 0;
>  	*tcp_flags = 0;
>  	memset(ovs_stats, 0, sizeof(*ovs_stats));
>  
> -	/* We open code this to make sure cpu 0 is always considered */
> -	for (cpu = 0; cpu < nr_cpu_ids;
> -	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
> +	for_each_cpu_from(cpu, flow->cpu_used_mask) {

And why it needs to be a for_each_cpu_from() and not just for_each_cpu() ?

Note: the original logic here came from using for_each_node() back when
stats were collected per numa, and it was important to check node 0 when
the system didn't have it, so the loop was open-coded, see commit:
  40773966ccf1 ("openvswitch: fix flow stats accounting when node 0 is not possible")

Later the stats collection was changed to be per-CPU instead of per-NUMA,
th eloop was adjusted to CPUs, but remained open-coded, even though it
was probbaly safe to use for_each_cpu() macro here, as it accepts the
mask and doesn't limit it to available CPUs, unlike the for_each_node()
macro that only iterates over possible NUMA node numbers and will skip
the zero.  The zero is importnat, because it is used as long as only one
core updates the stats, regardless of the number of that core, AFAIU.

So, the comments in the code do not really make a lot of sense, especially
in this patch.

Best regards, Ilya Maximets.

