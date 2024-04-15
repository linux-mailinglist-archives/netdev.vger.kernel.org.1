Return-Path: <netdev+bounces-88092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83718A5A3F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 20:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD9284C10
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45178154C11;
	Mon, 15 Apr 2024 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyBwYu2T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182813B78F
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207378; cv=none; b=fuItNsGtPJONZF42Q1zqF5o7JT6xmwWfaKP7RuMNp9eYy2QAYdwN9P4LRMRAPutIFy2+OUMu/7VtdT1MEOPxz/NcKWvLBTRUGcrRIcYzlNIMxMyognUNXEOVEqy2btTCY/v2QMQQdHxe4ADk4Cn1W3b6Xh+bTTAslDQbrBW3HLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207378; c=relaxed/simple;
	bh=FctM977lEAAwwANhWYYm9bvXkUV70k9ZmIKMwBZQv7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eibF8w2mraxfGgeZn1yFkZD2P+ZC2NtIqa7x9Z2KfwgSKp+ojvpIaR2YH8H2e6tJRrEjSZvWV84jbBmECeATZH1rqX/vv87a+g4k/nP4P2humIEC1vTjy5rTi7O9iJq6KiRd3rQl9WDW89uTP0Xa6RbxFpuzeT5ZLcyyrJ2GVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyBwYu2T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41884f8f35bso2738275e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713207375; x=1713812175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FctM977lEAAwwANhWYYm9bvXkUV70k9ZmIKMwBZQv7g=;
        b=gyBwYu2TdrmXmpIeVF3En1fT+BIG6Zyh5SWKpEF0Z/GNs1bnOCAayIEtOA6TMtwUE4
         aAbqmLAaa5P00/dia+kfo/V1fsWo0RvuCQvCYqlgC8Iu5u46gQ4/M5GnfbwT4Oyn27B+
         FnX5Ybq8zUJZyut2I4gdAUdw4I4rUopBJdXToVOHkGG8Zc9FtKj2+iGRoE1hIZRYuHgS
         FKnZ6uPOqzBcb94MpEix6QYPl5wCV0ERfMdnG954NC+/D1Y0s+fio0g5FQ7NIe0ekdYT
         ezp6+oKE4kTwukPf8BoigHAo9Rl3nNW6dIuGmJSzfCJIZsmKMOrUGWVRbLQzwK4ltXjZ
         8OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207375; x=1713812175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FctM977lEAAwwANhWYYm9bvXkUV70k9ZmIKMwBZQv7g=;
        b=s1k8DjcG4ar+P8vEfwLTvwrQTqbbZXsNg9LF9AvrABfOg1VCjq//VTQa/H786hN3U9
         vWjkgubms7FRjJbj1c5g51HkuWgtUxsqGSJknm4Zf7NSw8Mh/xZIUVe3UGThiDn5GiU7
         hbQXVaKSMDh6fNLu0kc5BvBMPwSZHIoL7Ym9JXdI40H0fA6dAbVrWVfa+OdYFAwnlPkC
         iBRzOoyDp0d1ftJDIEUOCCscfErM1pLXqTZLZDUtDNif8n6/FIdDSn80SWJntk6jtZwE
         0UlyaIbIRKOl9Oa7Wxl0HwK2coAeAF4i0v5RLIZcJ7fsYnRMoRMwa3OmVJFXQZ0DOOGm
         15Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWhVC8VtunphFAOdJO9L2MQsEWLu81NCEuNAcH9l+dL2gP2Y5HSJK2FFWnFWmx/JHYsBW2PgcQcj0U6E+WANhOjUAcHFjqa
X-Gm-Message-State: AOJu0Yy+axPPvwTNlTFPNdu7eZfT+85PQRgf7s3uETRir6SKKSNCtXwk
	lhKwmWFj6mme5qXdzx71P0QYBELA5XlNf3diyTQDEtIP4Euny4FnekD4dgTUxKUp0DYwdeBeJGv
	Jy+xCyHb/Uoqn4XVoeErB5YZc+5I=
X-Google-Smtp-Source: AGHT+IFOZmOgSvZHwbgU7f6VXIaKp8VxMqo1sjwuijMPc3HxP3jbPQTQJ1VHsSJZOpZ9+IKkhi5HpF0nZ7Q+r29bwWQ=
X-Received: by 2002:a05:600c:314c:b0:414:1325:e8a8 with SMTP id
 h12-20020a05600c314c00b004141325e8a8mr8218935wmo.39.1713207374931; Mon, 15
 Apr 2024 11:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com> <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com> <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com> <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com> <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org> <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
 <20240415111918.340ebb98@kernel.org>
In-Reply-To: <20240415111918.340ebb98@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 15 Apr 2024 11:55:37 -0700
Message-ID: <CAKgT0Ud366SsaLftQ6Gd4hg+MW9VixOhG9nA9pa4VKh0maozBg@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 15 Apr 2024 11:03:13 -0700 Alexander Duyck wrote:
> > This wasn't my full argument. You truncated the part where I
> > specifically called out that it is hard to justify us pushing a
> > proprietary API that is only used by our driver.
>
> I see. Please be careful when making such arguments, tho.
>
> > The "we know best" is more of an "I know best" as someone who has
> > worked with page pool and the page fragment API since well before it
> > existed. My push back is based on the fact that we don't want to
> > allocate fragments, we want to allocate pages and fragment them
> > ourselves after the fact. As such it doesn't make much sense to add an
> > API that will have us trying to use the page fragment API which holds
> > onto the page when the expectation is that we will take the whole
> > thing and just fragment it ourselves.
>
> To be clear I'm not arguing for the exact use of the API as suggested.
> Or even that we should support this in the shared API. One would
> probably have to take a stab at coding it up to find out what works
> best. My first try FWIW would be to mask off the low bits of the
> page index, eg. for 64k page making entries 0-15 all use rx_buf
> index 0...

It would take a few more changes to make it all work. Basically we
would need to map the page into every descriptor entry since the worst
case scenario would be that somehow we end up with things getting so
tight that the page is only partially mapped and we are working
through it as a subset of 4K slices with some at the beginning being
unmapped from the descriptor ring while some are still waiting to be
assigned to a descriptor and used. What I would probably have to look
at doing is adding some sort of cache on the ring to hold onto it
while we dole it out 4K at a time to the descriptors. Either that or
enforce a hard 16 descriptor limit where we have to assign a full page
with every allocation meaning we are at a higher risk for starving the
device for memory.

The bigger issue would be how could we test it? This is an OCP NIC and
as far as I am aware we don't have any systems available that would
support a 64K page. I suppose I could rebuild the QEMU for an
architecture that supports 64K pages and test it. It would just be
painful to have to set up a virtual system to test code that would
literally never be used again. I am not sure QEMU can generate enough
stress to really test the page allocator and make sure all corner
cases are covered.

