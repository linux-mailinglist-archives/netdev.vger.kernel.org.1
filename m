Return-Path: <netdev+bounces-202840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E75AEF4D3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAEF440319
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C182126FA4E;
	Tue,  1 Jul 2025 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5B+84TY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBE21771F
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365018; cv=none; b=ARdQorC1Oy9q2PTVGxitE1sccGieJUNi4/FlOXRKbR9ZCnYwgxsPaxJTA5kvHToWo3tw9uq6jSOF9RYLwCPDfMi+rdzTurM+LMjFnbgS+UPxS9zEtxmILJ8TtMy+Zzpr+suBwvtvk4kd7Wvbb/nOmKff4+0NUh4thyx/1eClKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365018; c=relaxed/simple;
	bh=TQC9+oQxqblFVDB80MxY1iCatqzGsHJIWGTarUSRBKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GryogDs+xT9Z7CcCTMMhrmBwCUlYX5BCDku3pLNFCtdfgf7B7mnQEIIb7EEOGXs6IwPSzfist2ifjoqvRs81HxYhb+v3kddTx8WXvXiwgTHlzQREXJvr9w/Yp/2dRTdNfQfEkUIUsnOjBwbzqtSgzYgDr59uGziE6lAaRCNmCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5B+84TY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751365015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHo/cFymct4LXXFJUfJvxL32X6eCwnlTq+zBpWThbJs=;
	b=V5B+84TYbHUWR+rbHyPcTaqsyukICVkqxiNgbiwAeGx/7aN4olCd3H6KDnDyKQq8DgJMRc
	K/me1WASCfaJFTiARQERgVCKZqbmPXJ6drp59Sp9qfzLmq+jhAddlyUm0G33UPjpQ5zIHG
	2I4xXd2lWui/V+EYXCmTZAVCXIgitVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-KCwMwZ8COaWRY9G5j8YrWA-1; Tue, 01 Jul 2025 06:16:54 -0400
X-MC-Unique: KCwMwZ8COaWRY9G5j8YrWA-1
X-Mimecast-MFC-AGG-ID: KCwMwZ8COaWRY9G5j8YrWA_1751365013
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450eaae2934so22408785e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 03:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751365013; x=1751969813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHo/cFymct4LXXFJUfJvxL32X6eCwnlTq+zBpWThbJs=;
        b=NyPB3QGOgClb1Krl2BwffmhnI/5JjTz4W2fpZZXE9f01/5w0bSz1bDhuozjeWpu4xx
         TMbgJtaHpdn8bhnxJBabustCmF9kB9tPGPKkGKdmCL0mmfGfjx1KOHSHav6tjPc1lGvq
         lqo8eKYeLi6h02BHUJ68llrgbG9OQp5CYL9iQlNmxdBLJUu5Ik6qq7gGUH8RFA2/BqFE
         0w5lRbeh7VndZ9Kx6PffUckZ+KE+n7cEZexOMcklA3Yh0jojbv1iBOu6UhfWTNtn3up5
         61gSRJ2ETWCjphsdxm+x1NqsihzS99sm7mdyrc0Y/HusbuMLDTb6F1GGyKTCKQ/x7BvD
         5Rxg==
X-Gm-Message-State: AOJu0Yx8TaaqAW3xa6B7Qe1Addb8GDmIjm8RqfyNkw4DsthqRbURAuQN
	z9wVJ8tGIW+8Xmd7Q6aF8OO9tX4w2Z8HCeK1PJAGKZvSjKlj39K/0qax4ekG3Vo+d/jApEaSwgX
	dgfdh3AR4Pvi98/Kg39FiOKAb4rP6LpH6uOI0FWmxHfB8mx5/TbZ4ACDIOA==
X-Gm-Gg: ASbGnctrjSUeuk0+EqLvAIwMV1cjAFy5h+6gDrwTVBMHDRenRZPbCOaZ/McKouyTsb6
	H/wHUvZ62UaljQZiDobjdURwOfXXyuAr48cofwddKYZknXbMhLDlx/frnuZrbkSVqG2Bg4V0KZa
	tRlIy3E2aCfYNWw1zsCMA41TX9EndOQ4h7K21Xz3zlypD6yXRo6DXtV7Opyc22ECd/jcJXCasrs
	6yuo+5XE21OYMoreSptjHpXZ35GOcRymgukm3wYpjdJV6vNvnU9kXAT9UOhqlk6Ufrwb5+Tl6Kc
	cP4wBm0sand9+dZQfgOxMQ4bW9JerzA0HSgB5l8/Zug2JEC5f0lyStlWpfuVMq0WdIU3Fw==
X-Received: by 2002:a05:600c:4ed3:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4538f244121mr174638555e9.4.1751365013241;
        Tue, 01 Jul 2025 03:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEJq4NPlQOANeFkcDdpPTn2V1nB2CZt1s+DQ2EMmFxhbNZ3FodkuTpK5r3gou56aXsP2YbRQ==
X-Received: by 2002:a05:600c:4ed3:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4538f244121mr174638105e9.4.1751365012686;
        Tue, 01 Jul 2025 03:16:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453962dd8besm100899005e9.31.2025.07.01.03.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 03:16:52 -0700 (PDT)
Message-ID: <852d45b4-d53d-42b6-bcd9-62d95aa1f39d@redhat.com>
Date: Tue, 1 Jul 2025 12:16:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 0/3] ptp: Provide support for auxiliary clocks for
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
References: <20250626124327.667087805@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250626124327.667087805@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 3:27 PM, Thomas Gleixner wrote:
> This small series enables support for auxiliary clocks on top of the
> timekeeping core infrastructure, which has been paritially merged. The
> remaining outstanding patches can be found here:
> 
>      https://lore.kernel.org/all/20250625182951.587377878@linutronix.de
> 
> Auxiliary clocks are required to support TSN use cases in automation,
> automotive, audio and other areas. They utilize PTP for synchronizing nodes
> in a network accurately, but the underlying master clock is not necessarily
> related to clock TAI. They are completely independent and just represent a
> common notion of time in a network for an application specific
> purpose. This comes with problems obvioulsy:
> 
>    1) Applications have no fast access to the time of such independent PTP
>       clocks. The only way is to utilize the file descriptor of the PTP
>       device with clock_gettime(). That's slow as it has to go all the way
>       out to the hardware.
> 
>    2) The network stack cannot access PTP time at all because accessing the
>       PTP hardware requires preemptible task context in quite some cases.
> 
> The timekeeper core changes provide support for this including the ability
> to steer these clocks independently from the core timekeeper via
> clock_adjtimex(2).
> 
> This is obviously incomplete as the user space steering daemon needs to be
> able to correlate timestamps from these auxiliary clocks with the
> associated PTP device timestamp. The PTP_SYS_OFFSET_EXTENDED IOCTL command
> already supports to select clock IDs for pre and post hardware timestamps,
> so the first step for correlation is to extend that IOCTL to allow
> selecting auxiliary clocks.
> 
> Auxiliary clocks do not provide a seperate CLOCK_MONOTONIC_RAW variant as
> they are internally utilizing the same clocksource and therefore the
> existing CLOCK_MONOTONIC_RAW correlation is valid for them too, if user
> space wants to determine the correlation to the underlying clocksource raw
> initial conversion factor:
> 
> CLOCK_MONOTONIC_RAW:
> 
>   The clocksource readout is converted to nanoseconds by a conversion
>   factor, which has been determined at setup time. This factor does not
>   change over the lifetime of the system.
> 
> CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME, CLOCK_TAI:
> 
>   The clocksource readout is converted to nanoseconds by a conversion
>   factor, which starts with the CLOCK_MONOTONIC_RAW conversion factor at
>   setup time. This factor can be steered via clock_adjtimex(CLOCK_REALTIME).
> 
>   All related clocks use the same conversion factor and internally these
>   clocks are built on top of CLOCK_MONOTONIC by adding a clock specific
>   offset after the conversion. The CLOCK_REALTIME and CLOCK_TAI offsets can
>   be set via clock_settime(2) or clock_adjtimex(2). The CLOCK_BOOTTIME
>   offset is modified after a suspend/resume cycle to take the suspend time
>   into account.
> 
> CLOCK_AUX:
> 
>   The clocksource readout is converted to nanoseconds by a conversion
>   factor, which starts with the CLOCK_MONOTONIC_RAW conversion factor at
>   setup time. This factor can be steered via clock_adjtimex(CLOCK_AUX[n]).
> 
>   Each auxiliary clock uses its own conversion factor and offset. The
>   offset can be set via clock_settime(2) or clock_adjtimex(2) for each
>   clock ID.
> 
> The series applies on top of the above mentioned timekeeper core changes
> and the PTP character device spring cleaning series, which can be found
> here:
> 
>   https://lore.kernel.org/all/20250625114404.102196103@linutronix.de
> 
> It is also available via git with all prerequisite patches:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/ptp/driver-auxclock
> 
> Miroslav: This branch should enable you to test the actual steering via a
> 	  PTP device which has PTP_SYS_OFFSET_EXTENDED support in the driver.

I have some dumb issues merging this on net-next.

It looks like we should pull from the above URL, but it looks like the
prereq series there has different hashes WRT the tip tree. Pulling from
there will cause good bunch of duplicate commits - the pre-req series vs
the tip tree and the ptp cleanup series vs already merge commits on
net-next.

I guess we want to avoid such duplicates, but I don't see how to avoid
all of them. A stable branch on top of current net-next will avoid the
ptp cleanup series duplicates, but will not avoid duplicates for
prereqs. Am I missing something obvious?

Thanks,

Paolo


