Return-Path: <netdev+bounces-203755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA8AF7070
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB904A3C24
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9052EE278;
	Thu,  3 Jul 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACHETcIn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96682ED86E
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538484; cv=none; b=N2uW37VQuciFgoTzt/ECvdDKfLLNQTiwAi/Rzn/U7T923DT3bHWtxMYE3nMHWz/P0C5elelr4a2rXIwxS9WvABNrVUiDdMnBS81OOl7nEJovfnyKlkKz7mxa70qzuzaKamXBoNWYPqfuLEOqUyM6T8kyDiKfP8VhmF0YV7cd+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538484; c=relaxed/simple;
	bh=Vd/uqzKHQD/JhOyhhE5UNHdt60KiHkdTU4ai+BQ8KUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHlBYuttEVQer/GYAde6WpBNETrZ8KaQmFr8Iprael0guKb7Ss2rczFz5P9MO75TDMshwpdUc7NeN3ntHFmNiBMFHneXXfJPaRPqIEDvEyWLA3lvpRfENzleBlhkyhDHAdbtoKljtYlFQ+Ao/a0cRIv48gNHv/2Jrz5ohtmbC7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACHETcIn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751538481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KweAxO9X1ydH2zSi0gHOQdMmBGyk8VXrJktfpgZZZcw=;
	b=ACHETcInhb9vEzVeEUTSWIkPwKoFcdD+1M+ZJOKl2J74oNy41tF3BJWI9OnpuR8fl6LojD
	4ZDWrjx5NmngjisbQh5NAtgpB3WKY878KaEA3hbwrBDCpC+6lOq0p57OJv76Hn4F/+d9Sf
	t4Zet9Qev2LdpKV7Pv3wsQ0vGf+nS+8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-suZRRnVhMRy0uYrNOucAyw-1; Thu, 03 Jul 2025 06:27:58 -0400
X-MC-Unique: suZRRnVhMRy0uYrNOucAyw-1
X-Mimecast-MFC-AGG-ID: suZRRnVhMRy0uYrNOucAyw_1751538477
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4530ec2c87cso35423955e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 03:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751538477; x=1752143277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KweAxO9X1ydH2zSi0gHOQdMmBGyk8VXrJktfpgZZZcw=;
        b=u5ovVCoAtgyv8lvj4UgC2cnAflMT1iSynh95CtL1eOdHI5TTeHc/efwcicgPuxWQ4O
         PGJuVc+AFZ1eA/BnqYmOvPSBT2lnUnFnoje52ApFBeKf1ZuIzDSJ1dvHEgzUJKMFIxnY
         2WKFN8vACiIGlAvAT0MBWy+QnPQWpdKq14h+UjAMk/uMBmSNnI8jZC802eaRz7SjH/9N
         OQH+KDkg/g0uHhW7FnixLuRYudp5JNGerUthqDYfIZeXG8ikS4x+or4fqzI52pcsZOCR
         d3buA8/Dxk7Wsx3SCpuLeHqe25TnzR1QA17m8K1izLcpo35qkR+oBNXG537yhtE0gRFu
         kDXA==
X-Gm-Message-State: AOJu0YxosTNbyCFYzMygvbnYH7dtMObdWOAhiAg8e2jbCicMK66Qox9k
	wSe+LAUfBL1KKVULqUbafC82d4E7khIlR8YcXGi0HFs2lNolnw/GgvmBsVJO5XJfzjfykchKBLi
	xA6dsdJjWgB0UNbNHCLSxjTNJkvzYQjG0pXG4fcp5QQSPAfZTi4NKDRo1uw==
X-Gm-Gg: ASbGnctOyfJ2ndz02QbHsUGgvx68IFiYxpnBDG9uFPCdzfoW9OBIM42xYIgkhffFS2M
	rE9opG+EKGS1MmRSjeFZyN6ZVUg7QLHGfQxJL688PBFirRbaYhIh/52l+VjptkdLcaUj4aFgnSG
	1yTjO5ai9rD6guuLP/aaJRCNkvfptn+LrjhgnjmBD1bwOr5eJj3Oxw3M/E4mMoPOqc/e9EghKzx
	DE7zkte8iNBALvVa11xAJ3tSXDdYjq6m+iqE3XIDpgjBgHaRBiNLECW7NW/bkv7ozvjiq53L4O4
	FNo186kEyCbilkYrSftVAO0Yxc9LHdHmpRPqNJ37Dyb5SbZhU0fp05uve2s5+ui0hoE=
X-Received: by 2002:a05:600c:8b68:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-454a9c9ea30mr37310235e9.16.1751538476822;
        Thu, 03 Jul 2025 03:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhEtUC06vqPeBFU+gz9F16qvcD6gBqNVKKefyqfB1TtM5DvQhTjkFUHnSqAxNRPZeSLSfSag==
X-Received: by 2002:a05:600c:8b68:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-454a9c9ea30mr37309875e9.16.1751538476382;
        Thu, 03 Jul 2025 03:27:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9beb22asm22670945e9.36.2025.07.03.03.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 03:27:55 -0700 (PDT)
Message-ID: <faca1b8e-bd39-4501-a380-24246a8234d6@redhat.com>
Date: Thu, 3 Jul 2025 12:27:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
References: <20250701130923.579834908@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250701130923.579834908@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 3:26 PM, Thomas Gleixner wrote:
> This is a follow up to the V1 series, which can be found here:
> 
>      https://lore.kernel.org/all/20250626124327.667087805@linutronix.de
> 
> to address the merge logistics problem, which I created myself.
> 
> Changes vs. V1:
> 
>     - Make patch 1, which provides the timestamping function temporarily
>       define CLOCK_AUX* if undefined so that it can be merged independently,
> 
>     - Add a missing check for CONFIG_POSIX_AUX_CLOCK in the PTP IOCTL
> 
>     - Picked up tags
> 
> Merge logistics if agreed on:
> 
>     1) Patch #1 is applied to the tip tree on top of plain v6.16-rc1 and
>        tagged
> 
>     2) That tag is merged into tip:timers/ptp and the temporary CLOCK_AUX
>        define is removed in a subsequent commit
> 
>     3) Network folks merge the tag and apply patches #2 + #3
> 
> So the only fallout from this are the extra merges in both trees and the
> cleanup commit in the tip tree. But that way there are no dependencies and
> no duplicate commits with different SHAs.
> 
> Thoughts?

I'm sorry for the latency here; the plan works for me! I'll wait for the
tag reference.

Could you please drop a notice here when such tag will be available?

Thanks,

Paolo


