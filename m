Return-Path: <netdev+bounces-152511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB0C9F461C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCAD188B293
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450AF1C54B3;
	Tue, 17 Dec 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/mdTuVk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CF42AA1
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424447; cv=none; b=Q4FVbcQzPU8CH3XBjCZWs3tM5PRHwBu7cwYFOJSUI7v6nDrKc/Bb83X1xyStFKQWKC5fQpVn7qIIoYN1XjYH/McPL0+utAmdF7kCnp+3q9qKJ8SICi1nlFCInup1nZqKos+L4TNwH89xKZ0dhFYwMkt+UR9J9MQKk47WDaQBUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424447; c=relaxed/simple;
	bh=Arvryk9fl3rNZHpfN14PFf7wFJruaecK/cLkBk655sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOhewmbLpID9RFSVHtIEE8bACekH19elwG5kqut15QSsRQaG72lqPZBDmWNzrXr+79P8dfE2WumL4GLsZ4l+/TejtEwcFJWAI60v3ABvPmiOz380lgDp4yxGggad7VDaZMuy5I5erT7cIbbTcEAZshdtOm/3B2HQovY8AtMlw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/mdTuVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734424444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTgyAm/t6E5caA9IVSmP44Sy6axmriB2cCoPsf2gtMI=;
	b=T/mdTuVkO0YTzf9BZuVeTBNc1+i4QXRelimM73vgEMgCwh336hCCl4ykqXdo4MZEDrFA15
	IrpI29XrqwN3hcDAmjj7opEtt2klFaZx7/DERhmFM+J8G2E4cVfcNgsXVN9wijwk7WmSpJ
	xIhBYQIKNmGczCskD5BzcdR9dnAX+NA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-KLF35WutO9-WF9U-lPEEsg-1; Tue, 17 Dec 2024 03:34:03 -0500
X-MC-Unique: KLF35WutO9-WF9U-lPEEsg-1
X-Mimecast-MFC-AGG-ID: KLF35WutO9-WF9U-lPEEsg
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e391a2f0f1fso6723510276.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 00:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734424442; x=1735029242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTgyAm/t6E5caA9IVSmP44Sy6axmriB2cCoPsf2gtMI=;
        b=t3LCyzzj1Yyfr/VWROVDclqNFv8IclwLz8yYOx1RDf+iPPpOog+1GkFbnBCyGnMZVG
         1Uk10hVrgLLoZMBV391VkFYizE4IZr3ZOvjPpb0CchaP9Nejem5Gz45NumB8t5VHtZ8q
         YzMWhwIoLK69hboKjDV3PpShWEI8fP4aiUIDu2PS7PmN5vOSMVjpoohPzpR48Vjd7Py1
         wTCyL0+XCUQk0CCS5pEx8ZWUE61mwUR7prXGfGVm0whOabZ0dn5VHxFGU1ZRicqKi/mN
         +Bjy9j/AD/gDA0u6/yYVjQNglWZ1xtDKtmwhUtwkW+W3knu9KmPEOkRmveTlKQG2/dcx
         stHA==
X-Gm-Message-State: AOJu0YzzI+dosizm1dztWEQP4zolq0yp6GweExoTVSDKigbCynl/59kS
	ocBsPdghZirqpuOJgjgbb8kUYZ6H9/RY/Xw5MCIwB/UQDRbdffhOebutlkY0uDvFeqGCGSXzthG
	1fWihdOnrs9po2Q/ZpMEkVf5NUfllIl2QWZem5K7h0+mkiK0TV4b7yYCKC44M1NeT9ggkIvKvpD
	FPQE8OQbw/CmJfs4t0Qiq/DvVTqJ/YpTaB0O28yZo=
X-Gm-Gg: ASbGnctLxDC7YRYm8+K6kmi9VpQk46mEkqC+ihBecL54OpgDrb00AYh9EkRh53p300G
	2vmABAfMwdtxUDfuhuBUNI9sSShb4KAAIz30B
X-Received: by 2002:a05:6902:2689:b0:e4d:25c6:c3b0 with SMTP id 3f1490d57ef6-e4d25c6d191mr4684779276.9.1734424442227;
        Tue, 17 Dec 2024 00:34:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk4Ye+VtTD0k53vvmkzIEMHmo2VfkNaawna/QtLGYrdkGaPQXKTIjLGAJU+Ch/2sc6qc45987gT1bQVsiWu3c=
X-Received: by 2002:a05:6902:2689:b0:e4d:25c6:c3b0 with SMTP id
 3f1490d57ef6-e4d25c6d191mr4684776276.9.1734424441872; Tue, 17 Dec 2024
 00:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-2-55e1405742fc@rbox.co> <ybwa5wswrwbfmqyttvqljxelmczko5ds2ln5lvyv2z5rcf75us@22lzbskdiv3d>
 <12fd9c75-8a93-4ce5-949c-2ff2c7c727d6@rbox.co>
In-Reply-To: <12fd9c75-8a93-4ce5-949c-2ff2c7c727d6@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 17 Dec 2024 09:33:50 +0100
Message-ID: <CAGxU2F5zVTrYEkcQDBbHWysUnOR-Y4Z6+uuJ5+Zfmj+QOgD=Wg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/6] vsock/test: Introduce option to run a
 single test
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 4:14=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 12/16/24 15:32, Stefano Garzarella wrote:
> > On Mon, Dec 16, 2024 at 01:00:58PM +0100, Michal Luczaj wrote:
> >> Allow for singling out a specific test ID to be executed.
> >>
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> [...]
> >> +            case 't':
> >> +                    pick_test(test_cases, ARRAY_SIZE(test_cases) - 1,
> >> +                              optarg);
> >> +                    break;
> >
> > Cool, thanks for adding it!
> > Currently, if we use multiple times `--test X`, only the last one is
> > executed.
> >
> > If we want that behaviour, we should document in the help, or just erro=
r
> > on second time.
> >
> > But it would be cool to support multiple --test, so maybe we could do
> > the following:
> > - the first time we call pick_test, set skip to true in all tests
> > - from that point on go, set skip to false for each specified test
> >
> > I mean this patch applied on top of your patch (feel free to change it,
> > it's just an example to explain better the idea) [...]
>
> Sure, make sense. One question, though: do you want to stick with the ver=
b
> --test? Or should it be something more descriptive, e.g. --select, --pick=
,
> --choose?
>

I'm terrible with names :-)

--test looks nice, but also --pick is great since we have --skip.
So I'd vote for --pick, but I'm fine with --test too.

Thanks,
Stefano


