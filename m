Return-Path: <netdev+bounces-175678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC8A6714F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AC1422897
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF8207E0E;
	Tue, 18 Mar 2025 10:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B6207A1F
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293796; cv=none; b=hzMtPhA0tZCtaDFHC3x4Di314nPC6qUjb+fIeo90UG/KDxC2wHd3IZGHjG4hPwYkfOD9ZOSvAZBanobHOWJPINuWmT4LHkAkV5RWEhPlnABULa91uy0cove+URnL8weVgNkVMWA5gW76SqrLXOMrtC63bgCkTi6NAkbRdEyzzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293796; c=relaxed/simple;
	bh=nxtYdJtAwIvQV6WWOLH2soTuvIbwPJCNRZf6WBGrXgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqSTFYBwBRgcooa1TIFLZviSGl8/aBYMo5r7mLmA2Veax53bIuq9YyxuUWk+SC5O1p/BOtakZ9TiZPUg3RMUhR2Ch97KdwC22/CvE0T29yTbeDuJ0pRgBdrq5MMBTA4IN47Woj26llz3aNg9dkoS5habPjb3fPCW77TkmxjSpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so4784297241.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293787; x=1742898587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKrk7+vxUdH6kiKOUnmRtc6uP7TiRr77NK3XaYEDH+8=;
        b=MREaRvVIslCvPOXGhFSV0P5a0+yswZlT8cm9cTG1IP7ixmE9AR5FgHlEiCggYKFCio
         8ylzoFar3DBoRecq4woa2m0kI06D7UeWjtgztt296MQQzDL57Qps001YTMUiSH/4uHe2
         Y6a7VEXs3FYkDKEJ0mD0iog0BqbV8/eOK7ZDVOl5xSLk4pe/16D+Oc5oqrp1LtBUq/HP
         aoSzIdwCCSbBWA+E3ODW5NsntJ3keG553rJ4KhPcEXE6bEa/AmvhXs1kfHup8YLaGe4X
         D+V3FK/tywpa6BxnyhLkdT/o6h0Zk8dwUN5sFrtQ/da+bxikQiYyc8HCm8RQJfUDNqON
         fK0g==
X-Forwarded-Encrypted: i=1; AJvYcCXWV8SmhtVFZSwf2tyv712hCzbc8U3Obg9IoPIcewCsOoSLtDlsf9jrH+iKc124/aevFfzIO40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyabJLJdvAwM3pnW+x3+Yj3bK/3DecsO0xZ0SO3meNZlQIj96Hp
	h6WeTnVt8Lsc7PguTzS+epdHt6F5DQhGB4iE2rwmidazHxNhjrLrUsjocWvm
X-Gm-Gg: ASbGncun6kiRrp1PN+K1pzrZVbsapxz/9zRmarKkNtvPZ2koUu8QsKdA9pzTSrF1j7f
	RrLaaGymI1cfig9eMW5vDnUO4vgmMm9RfuTxQVUgUpLk1UNsbuFeOuVBXVK/EKCrHVwhLqvEEl9
	D222XPY62vfIQXzF4Q3khhS7U8z/vHRAItNuY6YtcxjiiEq1dNF+L0DLM6SEgApm1vXJl52OgWw
	OX8mm8M0GNTzlFzN0v0mSYg2uXvpLLLokLsVXX1jGvuNgjQccudoQj/XbqWvUBp1V39ugydGeXM
	gWEW5nJxgRSM4L/aSNALrCpNTahfCKqXQCIwKTAbrEV0DwuR1PpW/i0GWFjO+wIQuqIdaRD7EQV
	BFy3CeiY=
X-Google-Smtp-Source: AGHT+IFhZgU8jWWHU04jb8EUC366NjSN15BHkQexhYytMb7yLkG/RAKfO+BmZ6yzuyG9E1fSTAdy9g==
X-Received: by 2002:a05:6102:396f:b0:4c4:e414:b4e4 with SMTP id ada2fe7eead31-4c4e414b996mr252371137.11.1742293786777;
        Tue, 18 Mar 2025 03:29:46 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90e74885sm1949387241.21.2025.03.18.03.29.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:29:45 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so4784246241.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:29:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9GWzcuhLWxVTeZVnh6QhkKW1J0MP+pEMYch/fi5EWSX/y/248sDp0uLtZBxlmHTv8VooDGjQ=@vger.kernel.org
X-Received: by 2002:a05:6102:511e:b0:4c1:9288:906c with SMTP id
 ada2fe7eead31-4c38313995cmr10389128137.9.1742293785034; Tue, 18 Mar 2025
 03:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100827.555320-3-tianx@yunsilicon.com>
 <20250310063429.GF4159220@kernel.org> <69c322e0-7e38-4ac6-b390-7a9b294261b3@yunsilicon.com>
 <c94717a8-0d96-4914-8e24-9eb2959aa193@yunsilicon.com>
In-Reply-To: <c94717a8-0d96-4914-8e24-9eb2959aa193@yunsilicon.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Mar 2025 11:29:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxkvE=o7VOpPqSo3dkd6=YP8iWJ5V_=S=uAyrCBygEjQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpitwGRv5DQHmZTMYSfQvVeXSfwnnU2-gK_Wl1boJP3U0wZ5qy56cU_E2A
Message-ID: <CAMuHMdXxkvE=o7VOpPqSo3dkd6=YP8iWJ5V_=S=uAyrCBygEjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 02/14] xsc: Enable command queue
To: Xin Tian <tianx@yunsilicon.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, leon@kernel.org, 
	andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com, 
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com, 
	jacky@yunsilicon.com, parthiban.veerasooran@microchip.com, 
	masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com, 
	geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 11:06, Xin Tian <tianx@yunsilicon.com> wrote:
> On 2025/3/12 17:17, Xin Tian wrote:
> > On 2025/3/10 14:34, Simon Horman wrote:
> >> On Fri, Mar 07, 2025 at 06:08:29PM +0800, Xin Tian wrote:
> >>> The command queue is a hardware channel for sending
> >>> commands between the driver and the firmware.
> >>> xsc_cmd.h defines the command protocol structures.
> >>> The logic for command allocation, sending,
> >>> completion handling, and error handling is implemented
> >>> in cmdq.c.
> >>>
> >>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> >>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> >>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> >>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> >>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> >> Hi Xin,
> >>
> >> Some minor feedback from my side.
> >>
> >> ...
> >>
> >>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
> >> ...
> >>
> >>> +static int xsc_copy_to_cmd_msg(struct xsc_cmd_msg *to, void *from, int size)
> >>> +{
> >>> +   struct xsc_cmd_prot_block *block;
> >>> +   struct xsc_cmd_mailbox *next;
> >>> +   int copy;
> >>> +
> >>> +   if (!to || !from)
> >>> +           return -ENOMEM;
> >>> +
> >>> +   copy = min_t(int, size, sizeof(to->first.data));
> >> nit: I expect that using min() is sufficient here...
> > Ack
>
> min(size, sizeof(to->first.data)) will lead to a compile warning.
> size is int and sizeof(to->first.data) is size_t.
> So I kept this in v9

Sizes should be unsigned, perhaps even size_t (depending on the
expected maximum size).
What if someone passes a negative number? Then copy will be negative
too.  When calling memcpy(), it will be promoted to a very large
unsigned number, ... boom!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

