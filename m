Return-Path: <netdev+bounces-184130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3BA93655
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAD216BA9A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7512638B2;
	Fri, 18 Apr 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="BWQezP2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243661FC0ED
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974593; cv=none; b=o7q5P+IObPq1uwZVb1ddUtvewBO/Sq1vQya8yeE3XoHA5M2AhVu+huys1MJJ8bZlxAi9tvhICmDse5VcjiKL9IeXhJLbN0J2KMq3Nc6cfNuof+QRUD8es1c0tTrFfNLRCFpHPI5dkT03DXISALrpGQ5sfcMrH8iwNM7TnPgBlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974593; c=relaxed/simple;
	bh=Fi4t0dOtp1flcVqhoQ2RlXXYxZd3os1aw4AUw9OM/6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOGyOQs88xG2oYUdffmVxGArQsxiVHrFayEsCcIcH30Q8YI9XcfrVrjrmVMIkGb06doT34N+Jhh17WMKE3AcEWQQ+eArp2xlBsdt+VkoogmxtGZsSiOFRVwSMaANdTqPRcy5HgmBxX5wANdgdXHlOloH4wT58jsxge0whFQ1tPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=BWQezP2Y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af50f56b862so1268272a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744974591; x=1745579391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdUhbH0T6t5beq2qKoJ5PRG1F9USek/zSZIjlkdZiAg=;
        b=BWQezP2YkKw3lh9/9LHX9VO03aFIHgiop6GdJIIZGYuMO5vfIRk63fJd4GQwmT9zje
         pBema96kHZ5nanBmxzvnbZys8rgdtSa9tIKSJwnTcK3ARqJOB0jVq4UA3RBu02+j2aBd
         0+A7DzZ4d7X7vJRGAK4ZOxvWe1YEwHpFK4JkNSLkRgHdeP8uLmmHWeT3USggh4bwUeA8
         WRZPPS/Qx0rxByC/2SsBnU8ooQdFb43wFBT+EyfuaHzgn3E/S8prOyj9BPdhK6yZ4lxD
         nNbLJJjxTrSReLrxryuow+Cpy4EcQ6CZ+M1VAC4uq4bPmIOxf678HV2OkgMmnkyqSIT5
         aaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974591; x=1745579391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdUhbH0T6t5beq2qKoJ5PRG1F9USek/zSZIjlkdZiAg=;
        b=DtNWa8KQArAvAFIbbCXnvN17FeYgy/DSivyYh1e32x1TH8nohEKUwlTBecx7x4MmWH
         uNKDHdFaHVKeSh6MsXH5g1L2yIjILDZIQ/D0Aao6ggd5RZcd4q4no8E3XX129qkkfXz8
         JGJT+z3bYqQIwon1xxi8J2wH1ZIul/cfCCMb+xD+b2z06zT+zgdD0r2I+gIkKAu5h/DF
         BMq92eGtU7azDV5IK/TbRC+YGz6mElt8YNMSwidSkokrjWnftDITx1mGUbZ/uBJleNi6
         5BQg0FUI9Mvz/cH5XsYRsuPfb8nFSAZmvwwYJccGz9qufGuuLzsAXj9hAJE5HXMplAxW
         Fv1Q==
X-Gm-Message-State: AOJu0YwojWzB1oNUlXcEDCEAvqQGkU9x+i0Wa76/qH4IHl7EGVav/Mjo
	zyq3Lly0oOujdnA2/hNwgzslP/8SaDMM7WOYjAegPdZsT+sTFkJ4wCPRIEmWzGmomvG0zQpEgui
	RzjbqK4WK6Z/LN9HNTLw30JK6xZ21j+VsARJl
X-Gm-Gg: ASbGnctETsAuhSEcw0glB0LtbGxkeTpQnJ/Ek/TFIhsA09TW79mVlexXwJW9XZzZUFD
	j56ca+zcGcUNoY+3PPRCVOrAX5cgsq/zMt5z6A0ANPQuYF/Cpo5bfFyL7TK3x2UZa0Crk9fVu22
	p7RAcCbpPIckIKfQ2CKTIpUg==
X-Google-Smtp-Source: AGHT+IGq877F73El6DrVn3eZV1jrB1hFFCQ+5823Zg8zy0hUy6Su+wkV8b6JlEIpD6do3/QsFH2M4NpI1yeK+2b/zBM=
X-Received: by 2002:a17:90b:2b8b:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-3087bcc8abcmr2824497a91.31.1744974591333; Fri, 18 Apr 2025
 04:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 18 Apr 2025 07:09:40 -0400
X-Gm-Features: ATxdqUE20WdvtN6MCGFdWs0uykzdSAtjKO5pahOscCA0I55k1zn-9_b7E9z5Pwg
Message-ID: <CAM0EoMkXW2rSTG1yr4Ni-y-Kc0BMXoEvYFf300NpM10XT6G7Eg@mail.gmail.com>
Subject: Re: [Patch net v2 0/3] net_sched: Fix UAF vulnerability in HFSC qdisc
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, gerrard.tai@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 2:47=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> This patchset contains two bug fixes and a selftest for the first one
> which we have a reliable reproducer, please check each patch
> description for details.
>

For the patchset:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
> v2: Add a fix for hfsc_dequeue
>
> Cong Wang (3):
>   net_sched: hfsc: Fix a UAF vulnerability in class handling
>   net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
>   selftests/tc-testing: Add test for HFSC queue emptying during peek
>     operation
>
>  net/sched/sch_hfsc.c                          | 23 ++++++++---
>  .../tc-testing/tc-tests/infra/qdiscs.json     | 39 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>

