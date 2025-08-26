Return-Path: <netdev+bounces-217031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA0B371FB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F791B27696
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D016226A1B9;
	Tue, 26 Aug 2025 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnF/dB8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AE3208
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231947; cv=none; b=tNEFaoOHyBJQ9QMU5kZoXMk8eLr3f3qmV72B6pYl0Z3X7f/qa5GFfqAn2aS/iwUipLP8l6zaZx/PSpQaIx4TY291GrCMQOerKhI9QUxAAnDJIKFZzhJ2/3j3qQiqZHIGazY0NTxI5sEcQgyq3ybq9ISN2KE1mDodAJdsCgU80s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231947; c=relaxed/simple;
	bh=8ykpCNSfKspOvF8drjHpseWn0ROd8rkb5c+OY/2+DKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bJDZt6nckT+9J1f8WT3MxYE/yqSAqrLZgYyKdNw1jcnxmMstJbDp6PCGF3QPrYxIEWqszBD/81qJR3naI+3nFDTrndrEouraXkeJOjY2rmXbgMVsPgjR3ALtzRnMSjZjxOO5lApfpMY2IZn992ENMpM6YsuulpKppmBq7iqGmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnF/dB8/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b5c12dd87so26471805e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756231944; x=1756836744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qBHzEdovqcbv8UCk3A2gvSz4hYQ86nl9q00ULUOjfyI=;
        b=YnF/dB8/6D9HhU+nozec1yHMA3PwZ5NFeMUPJCaUQwfp+yl+CIXRs+txfptqOJBJ1T
         BMHz6hARDypu1IjdICH+15slbT7KBITEzqB9SGctR9AajIkEZ2U3ltM0npaxi5Hkucuk
         bTCoTtNEH0TA+QMjmgc/5r+Fl0t7fg+aXOQW9jsX54ZbmqMxDPsdx/uRsYHQvUNaStxc
         oCQydnp+dkSeZKscaiAIFnKabGUqVpofxENFkTDXLhzgHMGwYEDKi6N+LI+VWY3wBZS7
         82j5qX4e6j/Jo/dUycu68EkQeJYUESENvvidYxeg6oH8SJ0uJSjmAQwgViF67SS8wAkG
         K2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231944; x=1756836744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBHzEdovqcbv8UCk3A2gvSz4hYQ86nl9q00ULUOjfyI=;
        b=kw+OySxQ0TcEYVX9o9jXJqXeKiO5Vev2fPTmidjisngfehAermc49cqgBqH5zys+mI
         Qu42i0TZxjwrnaEHhYKhep0gJoSSoHat3yHtuBvF4ka6XoDsecnq1v45WWiB2dV8FqGn
         +4i8ojJ2y2XtsrOXe6aghf1iMrCT+OFSMnlukQtvOAbnEFFVzMPkPjqGb5UpQ3pVjpTV
         Ve2HdYv/8BGchMtCbLKlLezUsIeeywpR/IEgazG6bxBC9FPkHA4Xim5jgkpYdUI5jb65
         RMRv8Ic5flLeJXzkgf5FZBR9fEe0d+70d7AyeOALptrMbyWBZQ7E+vTzC76qVB+82sBu
         uKWA==
X-Forwarded-Encrypted: i=1; AJvYcCXxPpOx/mN/mH2ZPSSnt2yd9bOUDIDdbYaBUllU7Cu0oJMSSSu1b/TRclwitZ+F0v5kgIHC0q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSmUWCSLKeOHZXtQvkn7XqZt9CJOchq0SlnXzimCm4xXA7IVJ
	P5gfTyWC+HaMh1uCq2lS6b4r+9FnlrxBF/7rWCOCrMJllcdk9pioa17I
X-Gm-Gg: ASbGnctHLKZP761zQGjk07KFlJ9MdtWFJ3BKk2YmI5KoLHKMr6TZ+M1LPwU/FRlYesc
	UXUsMpiRN17Ccb1UwDnHEMl5eKPyjbYpw/hSAlyMYEwOaxF/iyP0JIWNUfJ0jppBOKEgl2gMxWB
	KYro9/Z5bKn9V4ZMjxGpYAEbGYRYkC1vhxKFkh+gdq9ctUv1A4hO2gLT2G3qz+tecTZJUs2mOML
	1p+GL70h+ZO7bIiruv7xC+NKr7DbPvswRyGpNwEoFCnQAtpTr5/35lnz2r32io2xxAIcR3quLul
	nisMW7PGZnRAmrIciARaVzXTsDmDScSZmV6/ksXJ2wBddwgI22WQOV9aHoqO8/BAOAgIWtG7q1X
	pUXlANdprIxqKifA1Me/N2IXyLkcP8uXqkyK8+iMVXnKO
X-Google-Smtp-Source: AGHT+IFSGJ2j/a2rB49WHPrcwKAZH+uIFmQzPbEy1jiODg5lR/BZYSE1IMSsAzl58pk1xmejZkXlEg==
X-Received: by 2002:a05:600c:4fc7:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-45b517ad57emr219685225e9.16.1756231943969;
        Tue, 26 Aug 2025 11:12:23 -0700 (PDT)
Received: from [10.0.0.62] ([37.170.2.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc56bde919sm563277f8f.59.2025.08.26.11.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 11:12:23 -0700 (PDT)
Message-ID: <c804757c-6bf5-4053-8a32-43e21781633f@gmail.com>
Date: Tue, 26 Aug 2025 11:12:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Network regression on Linux 6.16.1 -> 6.16.2 (persists in
 6.16.3): intermittent IPv4 traffic on Wi-Fi and Ethernet
To: Luis Alberto <albersc2@gmail.com>, netdev@vger.kernel.org
References: <CAF4aUuukN6wde=NrLcPfZPkLiudUYjSvb5NvoY55EhP3ssLx4Q@mail.gmail.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <CAF4aUuukN6wde=NrLcPfZPkLiudUYjSvb5NvoY55EhP3ssLx4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/26/25 10:59 AM, Luis Alberto wrote:
> Hi everyone, I’m new to this mailing list.
>
> I am reporting a network regression observed on my system when
> upgrading from Linux kernel 6.16.1 to 6.16.2 (and persisting in
> 6.16.3). The issue affects both Wi-Fi and Ethernet interfaces and
> seems to originate in the kernel networking stack rather than any
> specific driver.
>
> For reference, I initially reported this issue on Bugzilla, ID 220484,
> thinking it was exclusively a Wi-Fi problem.
> Subsequent testing with a wired Ethernet connection confirmed that the
> issue affects both interfaces.
>
> System / hardware information:
> - Motherboard: Asus TUF GAMING B460M-PLUS (WI-FI)
> - CPU: Intel i5-10400
> - 16GB RAM
> - GPU: NVIDIA 4060 (proprietary open module drivers installed v580)
> - Wi-Fi: Intel AX200, driver: iwlwifi + mac80211
> - Ethernet: Intel I219-V, driver: e1000e
> - Connections use IPv4
>
> Kernel versions tested:
>    6.15.7, 6.15.8 and 6.16.1 (works fine)
>    6.16.2 and 6.16.3 (regression present)
>    LTS 6.12.43 from Aug 20 (regression present)
>
> Symptoms:
> - Internet connectivity is intermittent: when opening multiple
> websites simultaneously (e.g., 10 pages), roughly 1/4 fail to load.
> - Failed pages either remain completely blank with a connection error
> or load partially; both situations occur frequently.
> - The issue also occurs occasionally with a single webpage, or when
> downloading system updates, not limited to the browser.
> - Occurs on both Wi-Fi and wired Ethernet.
> - No connection drops; the interface remains "up".
> - Tested in more than one distro: EndeavourOS and Nobara, vanilla installations.
> - Ping comparison:
>    6.16.2+: Running ping google.com while opening 10 webpages
> successively results in >10% packet loss and several pages failing to
> load.
>    6.16.1: 0% packet loss and all pages load correctly on first
> attempt, consistently.
>
> Actions taken:
> - Opened a Bugzilla report, ID 220484, including dmesg, journal, and
> tcpdump logs.
> - Tested with both Wi-Fi and Ethernet; issue persists on both.
> - Verified IPv4 usage; IPv6 is link-local only.
> - Tested repeatedly on kernel 6.16.1 and earlier: everything works perfectly.
>
> Reproduction steps:
> 1. Boot kernel 6.16.2 or 6.16.3
> 2. Connect via Wi-Fi or Ethernet
> 3. Attempt to load multiple websites
> 4. Observe inconsistent traffic and intermittent failures
>
> Any help is much appreciated.
>
> Could anyone advise which commits between 6.16.1 and 6.16.2 might have
> introduced this behavior, or suggest any testing and further steps?
>
> Thank you very much.
>
> Best regards,
> Luis Alberto


Please try : 
https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com 
<https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com>


>

