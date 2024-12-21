Return-Path: <netdev+bounces-153943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5D9FA229
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 20:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A06C16464C
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D06517BB24;
	Sat, 21 Dec 2024 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H5QUcRJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC52155342
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809052; cv=none; b=YgJz5LlSMEbk/GCiT0sn29a2OgyTYvbxbFT2rf0XHDcGPgvblujlh+6FXgNlKAjttQYMTQKBRasyoAMHD6lfxPjjkJB2gI5M7pBpPNwkAXEQLaT0+K3fR7rkXtVevzypDUacKNTWomriEwjgsllNvfHa1ANQ2bj7pKAgP+mAslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809052; c=relaxed/simple;
	bh=3b+zHvea9cKHj6T++qmfvZlWCPqBD6A42wajl14DSAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeFsl/3d7M3h28fe7kTlTlGn98nWyR2ZGkb89N/bRe/rHMepTzG7ToIAYawAsg138o12cKTd3gEw++HTQHjKneuJBtjXMe5Zi1ptkGv06Vapaqgmh3F3v4dNCT8wyOxVHUyKlaCdV4nRdYMUdRb3oFhcKmp5mOt3Z6nWZ+CTwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H5QUcRJH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa67f31a858so525856766b.2
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 11:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734809049; x=1735413849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FgRY31V4J3YXxNtclTUESjesGeOmptqFSuTQWyZWZNI=;
        b=H5QUcRJHPt6zVsn3lcG2ckOSdL3fkAd++7uzabqPJeCcagKU2palC24Ie1C7MI85QT
         1QFwGRO21TQMMcrPZ5gyYdizMYVCdXdOVwSToAyxUqxnJMNL35nXzbhLTSgotvWKHi6k
         SoTNjaeA+ygVnEGkl5wE+9RgEEjnwaxYGYcCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734809049; x=1735413849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgRY31V4J3YXxNtclTUESjesGeOmptqFSuTQWyZWZNI=;
        b=dhThBOxVXhSTxIzkCdgZ+9ohs+rhsTuHMmub9e9FsP6xK1I4OOeBwqp69MPMZGxqrf
         eFqeTrFleOAHpMk0aSnTNlR3H7V8gWYUoBzlbDHC7buZbgR6gXusnYL6nQ9mLtI3/o4K
         SXh59AoGjvs8YonnG+nlKA0H55foyj9/cPVnF1C7Ij7VyV0wq3L2zCXE4Uo+oIhW2//s
         yRFA/pAXCTRy6Pp1Elw5R9+Li1YMP6qeKXDyKpglrkGL+MQgg/4z4qba/gLNWa8M0Yxc
         LoiAhYBKuj66q3dDd+o0dYzPc0hP1hpwVXwrIjH+P1gfV+BmiQUquepXAzrROocN5a6y
         biIA==
X-Forwarded-Encrypted: i=1; AJvYcCXo+Y5K4YwSPT4Z+h5Vd75ahjuAcfLbT9ovtY5s+bPocBmPvVLveZluqG1i53pRff8qW9gk4bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYuP2p7xJFBg/0EncxiSvMyGYQHm5R7DWDZWlQQ9TRRqiixEoh
	MZ28c4sXg2QRKK1TFyNLDIN9HbUo4P5zp4gtQ8/X1FL+iKOuAHX1D1tGDDRZkN0YgN96b/IGezb
	fPgs=
X-Gm-Gg: ASbGnctG4H/lUx9NU4cMBlSla9wgEH6ZZzs4RotQrCB7q3iDKahU4/VEUxKjePhB5q0
	8Lv/tzaw3VhupoYaxcPnapaHTpoKSJ2vzcAYOiaNErGL+LkHvpbglTl8CZw/M+Z/PIWeCw+73Fl
	QJIIrSNpQ8ACKr51065R3Wd/sAxu9+DxiHC8z5xTqT61glf7Uj1GwPUWWrGsuUTllZ48MCnz7Jc
	7R+bbfglN7SmBoPWvMBu8wEzhW3kK6wAWnrum/TH9myuMoBYIZkitJsRABJzAMI6g7dazVL5LNr
	K62DUt90KR3VuAOPrWWbrqK5zS7oqZo=
X-Google-Smtp-Source: AGHT+IEdxR8QL2q/VJ5nSqGXMU8rRn7h0bRp4Q/O2kqIu8R8tC5uwMmf0ZE/+xb6NXH31Nqq+wosyg==
X-Received: by 2002:a17:907:7e92:b0:aa6:3e97:f9e2 with SMTP id a640c23a62f3a-aac334e17a3mr588989866b.47.1734809049323;
        Sat, 21 Dec 2024 11:24:09 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae5902sm309902466b.85.2024.12.21.11.24.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 11:24:08 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aab9e281bc0so552654166b.3
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 11:24:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVp+OqriN2V41fXDi4LkzkTOTgRj+H5v93IDhsbCbZxW+YvlVvYeX/8nBo3FrkQM2Dbrh5chgc=@vger.kernel.org
X-Received: by 2002:a17:907:9728:b0:aa6:82e8:e896 with SMTP id
 a640c23a62f3a-aac26958bc8mr590576866b.0.1734809047907; Sat, 21 Dec 2024
 11:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221002123.491623-1-daniel@iogearbox.net>
In-Reply-To: <20241221002123.491623-1-daniel@iogearbox.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Dec 2024 11:23:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmQSiZzQuUMLHf7jn5eS1=PEhpPdTNVq8LX0qBk31w0A@mail.gmail.com>
Message-ID: <CAHk-=whmQSiZzQuUMLHf7jn5eS1=PEhpPdTNVq8LX0qBk31w0A@mail.gmail.com>
Subject: Re: [GIT PULL] bpf for v6.13-rc4
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, martin.lau@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Dec 2024 at 16:21, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> - Fix inlining of bpf_get_smp_processor_id helper for !CONFIG_SMP
>   systems (Andrea Righi)

LOL.

However, it strikes me that this only handles the x86-64 case.

The other cases (arm64, RISC-V) may not have the pcpu_hot crash, but
they still generate silly code to load off the thread pointer. Does
that even exist (or get initialized) in UP?

End result: I think you should have done the UP case separately and
outside the CONFIG_X86_64.. And why do this only for the
"verifier_inlines_helper_call()" case rather than just do it
unconditionally?

Anyway, I obviously pulled this, but it does seem silly.

          Linus

