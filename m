Return-Path: <netdev+bounces-137216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5659A4DD1
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 14:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E4D1F264C6
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED51DE4EE;
	Sat, 19 Oct 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+xnowLF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31722629D
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341612; cv=none; b=J6PHjDlOkuIs1XkV1KwpHGi0bfA7DqAwAE3K5PQI1ItFnhpDmrcb6B7yBe6Uc9YPqEeyruGFHEgVSr1m80+NepGc+gQmq3IHoYKQsAPfsAb1aI3D+Re+4F2n07h+4rkakwMDiSGGHSbBchulfUdtdHrVXLSLYgxfxuoQo3C6ttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341612; c=relaxed/simple;
	bh=UVid1VDk7pD0527fHY7tDklEnM7TnMQtWmeCEV26pks=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l2zsnN3nxQ1wjdj2UEkrgi8OvRIvCfUgE7SKqSBzAkroE2UWzfa0iFQhc8r8c7hRXRgN0BrTI4cQ/W2ww0+/VvGbq596AknbjhYkXmvOvnWrPssUhaI+xAFhc4Lye6Lgo8RhG4VlwADvZ/ffEnYRdos4NERgRl89u5uAY2G7vlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+xnowLF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so485478066b.1
        for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729341609; x=1729946409; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UVid1VDk7pD0527fHY7tDklEnM7TnMQtWmeCEV26pks=;
        b=l+xnowLFgsXICwP6qPhB3OciTTQ+WhQyjRlAcbsF5JeYaEWilsdJSpoos+FqhRAt/z
         qRUuoDVedMfZzXDA/7LuWjVoAhWJhRQWKT3dfgL98/d3KdcVmY904iNLwmfQ8mKQbB3q
         jfU9cXVQfRrb4FawOIEtVY1CAc8I4UyH//I593XlMayiI6mFtdjr4N5mE8N8c0qrhFue
         zR9ONFohGJn/zgd87j2XouGULwx5t9daMBpJiPIJkTVYYcRY+kbuZ/hyYpQ9Bd17mVmM
         lYuZNUaT7R+oZy8STCDkqfurh4+T1AEi4JPIyAnSvSusPk7xVSS0944ESYMHXiNR7zIj
         lXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729341609; x=1729946409;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVid1VDk7pD0527fHY7tDklEnM7TnMQtWmeCEV26pks=;
        b=oFgyd3cMm8JHbyycEdin+PtqJzwupfW8QVpLwd+zAQfMjCGR2r1tkQKL3RjemxflHX
         h3GD68J1QT5Pbhz6aqnpc6t3fWpw4R32eE57OOoMuJ8ssBP3hJk1sMKFrFlMgma3zsfI
         wNQ7dBs8nC9aoC7LD1rG4zVg0yAYbpJ0cwjB/qfXyMV6sMAtH4+UuoeNvwqDokQtPk+/
         j+dp1hnqlKCvNa3xxeCmKLMtLxGYymwK8zFQvofiW1ARjH4ftKub0pXFP0vILEOVkel2
         YkLCE5sBhfw0CS/NwhIqZtXPLTF9vBygc2Rsq2Ku6COdpmrvEaFsokKTlxbaeIqCtN2P
         ViEQ==
X-Gm-Message-State: AOJu0YxjYN5pCoaIIDlEhi9LzaWKUqTQnCnUSrJK0Nb49Cr7PNHTXyJD
	fnpx9fU3ZCQuqYqkeU/9dNkfVcMoDtDwhvH7Z+ITanfd5PxhYpRfSEPh+I24fK1XOxkdFKBENN/
	zoyhK875+xMZgbJKTGZGxx4aibJgluu6g
X-Google-Smtp-Source: AGHT+IEWy3wr1Ir6MciVYNaLHjZbsRMFQkWofyWykpblTsTeNqdDxTSiX8/zYKsLAmod9DPR/Aihg04ReVwleZQ23BY=
X-Received: by 2002:a17:907:7e9e:b0:a9a:161:8da4 with SMTP id
 a640c23a62f3a-a9a69cdd435mr533515766b.55.1729341609022; Sat, 19 Oct 2024
 05:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stefan Dimitrov <stefan.k.dimitrov@gmail.com>
Date: Sat, 19 Oct 2024 15:39:58 +0300
Message-ID: <CAE8EbV3aruDHKrBezSLg_hy0XZG2Dr1pkzvXVVTj0QpNpH86nw@mail.gmail.com>
Subject: igb driver: i210 (8086:1533) very bad SNR performance
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello All,

I am reporting the problem only, because the exact same
environment/setup is working perfectly in Win7 with Intel driver
version 12.13.27.0 from 7/8/2019 (I guess that is the latest driver
version for Win7 as it is not supported for years, but it's the only
Windows version I had during my tests).

So, in very short: the same 20-25m of UTP cable, works perfectly in
Win7 and not at all in Linux with i210/igb driver and my best guess is
PHY initialization in the Linux driver compared to the one in Win7
drivers somehow reduces dramatically the Signal-to-Noise performance.

(the UTP cable is of unknown type, because it's a preexisting
installation in the walls of the building, I guesstimated it's 20-25m
of length based on the walls it passes and there are not any markings
on the cable, at least on the portions of it that I can see, i.e. that
are not inside the walls, but what I can at least tell is that it's
solid copper wires when look at its wires in the RJ45 plugs)

in other words, the problem is:

* in Win7: i210 with the above aforementioned driver version, the Link
connects as 1Gbps, I see no issues at all on 24/7 basis, it's running
with no connection drops, it just seems perfectly working

* in Linux: i210 with the in kernel 'igb' driver the Link cannot
connect even as 10Mbps. when I force it to 100Mbps, it connects for a
very short moment and then it disconnects and that repeats endlessly,
I observed no connection at all when set to 1Gbps.

Initially, I thought it's some issue between Linux i210/igb and the
other end device, but no - I can reproduce the problem with 3 other
1gbps switches (2 netgear and 1 cisco) that I own (and are not
property of the building) connected to the other end of the cable.

So, it turns out the only thing that makes difference for i210/igb in
Linux is the UTP cable itself - I bought 20m of branded and supposedly
high-quality UTP cat6a cable and use those 3 switches that I own to
simulate a test-environment.

that makes me believe Sound-to-Noise ration performance of i210/igb is
really very bad compared to Win7 driver (i.e. something in the PHY
initialization), considering the same UTP cable gives 1gbps in Win7
and cannot even connect to 10Mbps in Linux - that is like at least 100
times worse performance if we look at it as Link speed. Also, maybe
the length is at play, because I am guesstimating about 25m of the
building UTP cable, and I tested with only 20m - the length of the one
I bought. so, I don't exclude even with the branded cable I bought if
it has length of 25m or more the problem will not arise again.

Anyway, the main point I guess is that in Win7 same (bad) UTP cable
works perfectly. unfortunately, I doubt that is an easy problem for
someone familiar with i210/igb driver to investigate, because I guess
it's not that easy to reproduce (otherwise they will be similar
reports already or maybe it's very uncommon those ethernet adapters to
be used with such long UTP cables, maybe most desktop machines using
them are connected with very short cable to an active device like
switch, etc and that masks the problem) - again I guess some special
test equipment is necessary that can inject control amount of noise
over the UTP cable and that way compare the threshold between Win7 and
Linux to prove the problem when exact difference in SNR performance is
measured.

I still hope someone will have some idea, because it's such big
difference between Win7 driver and Linux igb driver...

P.S. it seems i217 (8086:153a and 8086:153b) is also affected, at
least based on my very short and not extensive tests I did today.

thanks,
stefan

