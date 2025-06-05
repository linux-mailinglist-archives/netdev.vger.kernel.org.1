Return-Path: <netdev+bounces-195250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7320CACF0EE
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F06188C941
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41825D525;
	Thu,  5 Jun 2025 13:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9A25C813
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130822; cv=none; b=Jlx1kg2JPXcFp4zLzRvVjzz1hh46HqVlc+yWaq1i70xgDmu10R4fBTbZ9x/uHyfQSbSahGuUPr6AyDkpNMCn4LI4PmAteQCU0mLFv/0uBXIvxMgom2Bj8OBfZH2FLVtjpBjgwmN0nOhFXWTwX/5lJdCrwVZqGEZtSUbo0lpAoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130822; c=relaxed/simple;
	bh=eHfQrTC0YqcsfNHP+pfBrnfS8oHwL+W9menMSWW99rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Co4hMQFRQDJSASdz2j14UoPeWUxwibIWvuWiacgrs/tBU0DFLsApk7awH/H6MQCpJd/71Nh3BjHFdzbolIhKg0XuKv8EiJaC/Z25UkbRslObvlx2GOdNOOemrTt1kFIo3DEbdoGkVgbkybskDFUPIYyW9G1zcp0fS5uEZNsAIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c09f8369cso268964a34.3
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 06:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130817; x=1749735617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeCZVZW7lnBPQQGcRFRIqFvWhqdxCwtGKMH0CVJpWqs=;
        b=u7LE02GzWS4pGTnWc+ShWQOOfFdF2iQ1hwRJ1cbUgvlKxFmVgBuk1vKg9189NHngg2
         /XC4O/sbIVPU6DSh/gVo5EbTpCRwmlmGZLPoQYaUpTeHJR5DJwL6ugmqOzzR3adrK81k
         3gw0aGMNyo6QgPC67GMSGfsa8oTUnJfR+9srLdCsq/60jpES/AqVsU834lP20XgCANtZ
         RxkJ0iutIIeDaCbTScRBxwmUasTVaD7vyvmqwNMCvM9yVdjbaAtYmp04tEbaSmwKKcmJ
         ZzDraQ4OSv24fUvC/ualsZJjoRfJNS492XFw3sQQF/725L/hYZVq8uTTw7vURy5DlvVH
         J7CA==
X-Forwarded-Encrypted: i=1; AJvYcCX2W/Z4sNHZb94y+GHlf0hfJf4yPQQHeeAZmJ/6F6wM3kAe4zurZJ7L0RpMBD1RiSdEIAskjCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRuHMYN6dU6Jolv4fBUNTe/IfVrvHkp5QUk8o88CHR/cn+nKn
	AGV4fDDPdSJzofwUiI7XmZ077ltu9g0vBoLtBSYtzDN0O0B/zQ1xBswhPRRrEELyRig=
X-Gm-Gg: ASbGncsuwFaG+O94LMEI0x4S5WjUnKTS08Nd35QxKz+gDj5EinYgf0P7/v+Qh510DOq
	XBm07d9CCW54ZT1aWgKSfGvubQXwmnt6Pv6Jgwz7XSuoV96RQnmjn/YFmOySeumvsMWH3/Rn/yn
	mINfPlq2ZK2DzVM++4UCWxgpd/Nkw9AMyv8aoEPAMrJHlyqfd5I1o5bt529+Z5mQgVWkFyJHqQe
	G35jD0ut9JKNPDT6TNkZwidO6wVGVgKXP+OLLDFN5s/FMfTaGPra4z0DC/oLkfixkRUgUbYY+eb
	fASH+VJXJEqP6YsPc6WJKu/Yeu60zaLIuy9B55aSFxkcV+1ojXUdstyEsHKZ88m92VU342CRpFq
	o3y1XvATIISMHJy1Pkw==
X-Google-Smtp-Source: AGHT+IHVqhyK1dRrdLTRKyiwBS+ngJEL6T5pi9Zkm69jadiJfNnUnjAf/FsK6iQWjJqkBX6gKkq8hA==
X-Received: by 2002:a05:6830:6488:b0:735:51b9:4688 with SMTP id 46e09a7af769-73869de72f6mr5073576a34.19.1749130816857;
        Thu, 05 Jun 2025 06:40:16 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af9bc883sm2632632a34.54.2025.06.05.06.40.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:40:16 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4080548891fso375803b6e.3
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 06:40:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+TDGBQ/gDNzq61A3vVp2RVyFyfdXtENGZnmU0ruNPmffov4kdyLI+DPo1v3k/JX/tu5R5vY4=@vger.kernel.org
X-Received: by 2002:a05:6102:5494:b0:4dd:b192:960f with SMTP id
 ada2fe7eead31-4e746e18d59mr5244968137.13.1749130806053; Thu, 05 Jun 2025
 06:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423103923.2513425-1-tianx@yunsilicon.com>
 <20250423104000.2513425-15-tianx@yunsilicon.com> <20250424184840.064657da@kernel.org>
 <3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com> <20250605062855.019d4d2d@kernel.org>
In-Reply-To: <20250605062855.019d4d2d@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Jun 2025 15:39:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVMrFzeFUu+H0MvMmf82TDc=4qfM2kjcoUCXiOFLmutDA@mail.gmail.com>
X-Gm-Features: AX0GCFuR08tAnWqKWeAah0zNgGtTLBVIaYN9uACTHjmSu7IPJg6CjzystwAQEIU
Message-ID: <CAMuHMdVMrFzeFUu+H0MvMmf82TDc=4qfM2kjcoUCXiOFLmutDA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org, leon@kernel.org, 
	andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com, 
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com, 
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com, 
	jacky@yunsilicon.com, horms@kernel.org, parthiban.veerasooran@microchip.com, 
	masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com, 
	geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Jun 2025 at 15:29, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 5 Jun 2025 15:25:21 +0800 Xin Tian wrote:
> > Regarding u64_stats_sync.h helpers:
> > Since our driver exclusively runs on 64-bit platforms (ARM64 or x86_64)
> > where u64 accesses are atomic, is it still necessary to use these helpers?
>
> alright.

[PATCH 1/14] indeed has:

    depends on PCI
    depends on ARM64 || X86_64 || COMPILE_TEST

However, if this device is available on a PCIe expansion card, it
could be plugged into any system with a PCIe expansion slot?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

