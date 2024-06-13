Return-Path: <netdev+bounces-103413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E7907EB9
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E4C282CA9
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7898A14B96A;
	Thu, 13 Jun 2024 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F8hu2pjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98714B94F
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317096; cv=none; b=C8ADl1tpksBjnQHxRamePktIDXaZ3UWeumjIHohHNTleW82tZn2bD+vbnHMfG2i851fuL04OnWsl1qELEbsenltEM4Slae1WJ7k/M29wKD+kfa+B5uGm5okqJofpEAAeqx5OqCoP99IbUaIdw21sqEasT4CBiTcxRrfuQCfKrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317096; c=relaxed/simple;
	bh=GspCeXbe53JYdKAHLrPNjz5Bk3zxp4umRvOyOhKibSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hq6U90eyeEvt8yMECYwNrRFqHep/Bl4yha/t06xYamh5zqEgQKHscXtBqOyj67KSwU7UHYafHFZnezJ5QLSCjSumIAOhQgAbnnaFmtqpQdAv+YEkI5o5vm9owAA3Y6Rky892cWlTv931y0EQ+syX4van9LqJSFkoblQ6m3qCdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F8hu2pjx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec10324791so3239801fa.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718317092; x=1718921892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivv8xxFePEFaIPZc0G+v3++kMFBsUSKEIP1k/xbjdQI=;
        b=F8hu2pjx0zRLoSXjyqV03rAwVJHdiSjYSNKVQL+4WGHUtBPfp8aogbw/DoSrfgTk40
         g4lHlHrkD/jvUMSm/xopfaumtQU2i+fQrQquhfUW0JSh5McZPKFiX5mdl2M+0gM6OQH0
         qrX7dssbpzn8BL2QafqybrQHPa1cusaHOlN7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718317092; x=1718921892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ivv8xxFePEFaIPZc0G+v3++kMFBsUSKEIP1k/xbjdQI=;
        b=nLDCKhMs3iDK1ryanFe3kCfUIn0rX1+PUpNRlhPO3TuXZycksVRAtuuAjmzG3T373H
         R9d0PKWZCo71+TGnG1HjX59vPnJmmlIvybLaIGCZ/A+zDOoSon5yLm7yUuF5glp9soPb
         KNwMcpAfx0pzal4iATDzR7/yERXOX+4gJGwN6m26cg/FV41ucqNZHdApsROxY3LcwzGb
         s8wfUdPPPDEvd09Gs+qP/2zvFWH8qlghbxqD+odv9JFp59VpZQ3FN+c7hwDdixqzwGVC
         yvfc5fZdYNm56/AaOWUwl7rLYXWIrWl5HJpaWKLptIsl6x1ODyeKt677RJben6pkXWYW
         AkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwS+KocxxGjZEG47JTMTX6mAcwVhYsOzQ3sgGkUtLbSkqogKm4BdRcxvspJIbhKN43T5bpBfvzFTUMWz/++TI16bshxcok
X-Gm-Message-State: AOJu0Yybl3eXIcdU8Dp1CKRZin1qnTYmDkR6wsBK/040/fCEWPoueou/
	Cdx+8fK7c463MxejcDloEwHw7iePP+1v2ayNC+J9q4Uxm2HuViuH5u84O84c4veLny82TOVTGfd
	CfnibvQ==
X-Google-Smtp-Source: AGHT+IGh0xUrDK+BScmoJ3sgJd30mFABvsXpMZ12cGnrV4Fe7E0la/D/+cZJ+iTGM6rHZ5deODwoLA==
X-Received: by 2002:a2e:8916:0:b0:2ec:95:d6fe with SMTP id 38308e7fff4ca-2ec0e5d0c72mr6441481fa.24.1718317092540;
        Thu, 13 Jun 2024 15:18:12 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c78422sm3832061fa.95.2024.06.13.15.18.10
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 15:18:11 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e72224c395so14045121fa.3
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGdwNLVtHlITcVJEwUCOxfuYPXbss7yyCwmoV47peJ4bw720i0i6Yw1Es0Cybebkrfwb4Rl1CLKvN5aHql9bEzBEdvRxEo
X-Received: by 2002:a2e:92d6:0:b0:2eb:242b:652a with SMTP id
 38308e7fff4ca-2ec0e5c6ce9mr6646061fa.15.1718317090589; Thu, 13 Jun 2024
 15:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023044.45873-1-laoar.shao@gmail.com> <20240613023044.45873-6-laoar.shao@gmail.com>
 <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
In-Reply-To: <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 15:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
Message-ID: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mm/util: Fix possible race condition in kstrdup()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 14:14, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> The concept sounds a little strange.  If some code takes a copy of a
> string while some other code is altering it, yes, the result will be a
> mess.  This is why get_task_comm() exists, and why it uses locking.

The thing is, get_task_comm() is terminally broken.

Nobody sane uses it, and sometimes it's literally _because_ it uses locking.

Let's look at the numbers:

 - 39 uses of get_task_comm()

 - 2 uses of __get_task_comm() because the locking doesn't work

 - 447 uses of raw "current->comm"

 - 112 uses of raw 'ta*sk->comm' (and possibly

IOW, we need to just accept the fact that nobody actually wants to use
"get_task_comm()". It's a broken interface. It's inconvenient, and the
locking makes it worse.

Now, I'm not convinced that kstrdup() is what anybody should use
should, but of the 600 "raw" uses of ->comm, four of them do seem to
be kstrdup.

Not great, I think they could be removed, but they are examples of
people doing this. And I think it *would* be good to have the
guarantee that yes, the kstrdup() result is always a proper string,
even if it's used for unstable sources. Who knows what other unstable
sources exist?

I do suspect that most of the raw uses of 'xyz->comm' is for
printouts. And I think we would be better with a '%pTSK' vsnprintf()
format thing for that.

Sadly, I don't think coccinelle can do the kinds of transforms that
involve printf format strings.

And no, a printk() string still couldn't use the locking version.

               Linus

