Return-Path: <netdev+bounces-154146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 662959FBA50
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 08:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00FD188548F
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634B18DF86;
	Tue, 24 Dec 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD/bUWCL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DFF16DEB3;
	Tue, 24 Dec 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735026970; cv=none; b=TyYWNk/Tr0fDO3FDw8OxJwE7Ih/QgQTmWkultZCx4/TfI4E52XRdFT4Ca7OUb8gCwvMJLGO903F8J8VVWX3wPcrYhR6jNbXY+dQZNJ6bpmO4X2R0Wzl6Ax1T/lZ2ts5mr7U7COa4XBn0FJvuWOpAk349y+5JlAfbGClH46Qc5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735026970; c=relaxed/simple;
	bh=DYfPZ39MyRj475906l0HgxSRj//ePs6qi2xtnlendVw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=o6ugxPzdkJFhAoMG5WRPKnuECq//RuJ6gLjnezTdrZteY4D49D+Gig6LEglDe9Wzr8uXXzTCm5XJo2tCscIlif+0142Nmrah+hx5XzddFGeJjvXZAJ0pILDfAXpOti0rgHMXSv4d4AlxjX+Z/xrZ8IXOvueDg3cu5zXSJjSKIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD/bUWCL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d84179ef26so3974025a12.3;
        Mon, 23 Dec 2024 23:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735026967; x=1735631767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYfPZ39MyRj475906l0HgxSRj//ePs6qi2xtnlendVw=;
        b=TD/bUWCLKHO74Hfg9y0e1TcVym8We7HD1LdXLfWRyfzWGCl7J4NUDoeFNidm/ebLjo
         3vpmKMRGkzei7lnoHUgY2MaTEZJqSZ1yMVnGPEoUXH+jLS22WD8nNLjiaG3KmoTQBhc8
         qRXlKvXyuTlixuODiz8x1lBPEj+pz6sGdHspR5ZYKTByNyVjaEsMKYl+v4ncViN5/91g
         xFvS3U/v3AQ0gXMh3ecFrwcKvbS+K+09m9TAoV5S1DeMwFyRnxEUWsvVFVGuh0ei6Jcf
         nvtT7aUmMaJe8vHd0akDyRClTm4qq2osAFl/2MvZdxcVvmTlGmKavBzq+xpiADOQIRIR
         /S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735026967; x=1735631767;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYfPZ39MyRj475906l0HgxSRj//ePs6qi2xtnlendVw=;
        b=vtj85CvJQgzNnyvHTrZQbEKKXklUeVr5NzXTMboC+YTK1J4wRrf3IIMK0iZ0I4oXW8
         b3t2qeMoxKZ7URQ294+ekZELkzud/72XOqw1uPGGg5G4E+W7VtFNWzVDu74oWPuff4QD
         sTqxItJS5ZdG89U14HPByFH3uIMdu+ZA1xEW99MDbJhP8PxT+FVcg/wXX6ClDTguhZIW
         lEkwH0MYIqJ/ADB+IjZ//CjBYOlq9as2n3Aol4AR1VJW/fFwlDt3JXgP0WMwT6QEXUtP
         VmViDMbKA/a5MGOvwShgIP5njfxovi1nEBaW5b1z8FUgQA+xOCNEL7cUs88oFMGSmVbM
         CzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcPpfsEzlbvbQDCEOeHDv7TsxRHAFXVd7eO9oQDgGLtcBbt0WZVKbnfWSwLExDgEZx0C2zszuQ@vger.kernel.org, AJvYcCWkObdZiuvWLIHOvzL2Uyco92yKTszn65HzgMxLjSZYuix5CnqDh09mf20Y/7v8m4Boeg8mtApoN4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPJjm4x8+f/qZJO7YWS181/hX8P8gt85V8jvAF5pZMGTl8Xq0
	Rze+ovEtnIs0SLnf9ITiD0r5eaGVBm9cOx4B5xjOdoBradBwcnfE
X-Gm-Gg: ASbGncsK6aCKVqlknEGzwEoNpdJ5GhU//e+DdK0hK83pWUT7PYYCx4CotwzPqsjL0SJ
	g/k/3k7a+fQHz/nvu9onkhAawCVbCtsbRULFa8OkAXBz0iKl6o4cWeCG4DGtbxXZ/QHODWf4zz/
	JOt9pZ17Czs+zSv9Xhzu1w1OsEEZ5Ds607uQurOgMNRtDw83+CbEyz0Pf3jFFuHoj5fe/6+iGyN
	wfx+phnLptaBS4ljRIiHyctjYGqfPhUcLCFEFVpJ/rJg4TA+fF+l3qnSQ==
X-Google-Smtp-Source: AGHT+IH3nULCTvzYbryqDPG24PJWH+1wwHyXoPc9vgdNt1AHig0ol6/zEmoM9ghe6monEtsb9DhNhA==
X-Received: by 2002:a05:6402:50d2:b0:5d3:d917:dd90 with SMTP id 4fb4d7f45d1cf-5d81dd642e4mr13413925a12.6.1735026966591;
        Mon, 23 Dec 2024 23:56:06 -0800 (PST)
Received: from [127.0.0.1] ([82.102.65.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a6d0sm5864804a12.14.2024.12.23.23.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 23:56:05 -0800 (PST)
Date: Tue, 24 Dec 2024 09:55:00 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Jinjian Song <jinjian.song@fibocom.com>, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com, corbet@lwn.net,
 linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [net v3] net: wwan: t7xx: Fix FSM command timeout issue
User-Agent: K-9 Mail for Android
In-Reply-To: <20241224041552.8711-1-jinjian.song@fibocom.com>
References: <20241224041552.8711-1-jinjian.song@fibocom.com>
Message-ID: <CA4E0537-84FE-4E1A-8BB6-7636D3799E39@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 24, 2024 6:15:52 AM GMT+02:00, Jinjian Song <jinjian=2Esong@fib=
ocom=2Ecom> wrote:
>When driver processes the internal state change command, it use an
>asynchronous thread to process the command operation=2E If the main
>thread detects that the task has timed out, the asynchronous thread
>will panic when executing the completion notification because the
>main thread completion object has been released=2E
>
>BUG: unable to handle page fault for address: fffffffffffffff8
>PGD 1f283a067 P4D 1f283a067 PUD 1f283c067 PMD 0
>Oops: 0000 [#1] PREEMPT SMP NOPTI
>RIP: 0010:complete_all+0x3e/0xa0
>[=2E=2E=2E]
>Call Trace:
> <TASK>
> ? __die_body+0x68/0xb0
> ? page_fault_oops+0x379/0x3e0
> ? exc_page_fault+0x69/0xa0
> ? asm_exc_page_fault+0x22/0x30
> ? complete_all+0x3e/0xa0
> fsm_main_thread+0xa3/0x9c0 [mtk_t7xx (HASH:1400 5)]
> ? __pfx_autoremove_wake_function+0x10/0x10
> kthread+0xd8/0x110
> ? __pfx_fsm_main_thread+0x10/0x10 [mtk_t7xx (HASH:1400 5)]
> ? __pfx_kthread+0x10/0x10
> ret_from_fork+0x38/0x50
> ? __pfx_kthread+0x10/0x10
> ret_from_fork_asm+0x1b/0x30
> </TASK>
>[=2E=2E=2E]
>CR2: fffffffffffffff8
>---[ end trace 0000000000000000 ]---
>
>Use the reference counter to ensure safe release as Sergey suggests:
>https://lore=2Ekernel=2Eorg/all/da90f64c-260a-4329-87bf-1f9ff20a5951@gmai=
l=2Ecom/
>
>Fixes: 13e920d93e37 ("net: wwan: t7xx: Add core components")
>Signed-off-by: Jinjian Song <jinjian=2Esong@fibocom=2Ecom>

Acked-by: Sergey Ryazanov <ryazanov=2Es=2Ea@gmail=2Ecom>

