Return-Path: <netdev+bounces-110003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE692AA91
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1D02830B4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A01714B97B;
	Mon,  8 Jul 2024 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/pXdxfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C914B959
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470576; cv=none; b=UBhIfHbDkRKsheMmH4Zz7z5Nrqqz7Xsm3GoYZnbp+WXMp9/wviLvCHLLoLi4ouOcUekF/4rOIW7OAJbePU9jP9es4z81uvLac5rKaHnZsc1bRVmJq1y7zKkC4wECPZobWB+4xXIJ8etwwS8ldgq3UcIjvU8JugEshMUYrHnha58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470576; c=relaxed/simple;
	bh=du5osGIHcSXKJaGt7oNaHV8Fk0tXUHqDDv91jVEbP6A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=koPY7xiDOZTpsP0ZYbXmOEWPRfp3dCaznkAv4xiDQIZ7PyYShNCuOKhUT54Ip9FWVb0bmOTlN5Fl+Lw0QgcRY62Gjsm9B6Rb31rgc9CMRphacXraEA3IGgLwVsh618XKNdWrh+CkrKTjsDtz4jQocJw4m38WfeB62SOQAYvotLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/pXdxfQ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8102bbc95d1so1437596241.2
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720470573; x=1721075373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkEfjrwUYJog8BnYxx2aUfQrQWw50EsU9jIJpemay3U=;
        b=V/pXdxfQFxj1aPkgb54Mqk6HFw3A/ib9a9OEPq/Wn3AiQi3HigwYFSsdMzFr1ASOcV
         OQpqL0/ThKpDzn05qqhhejqw9jO/YwbfwppAAkrRNzHDt/lUt1QTnSp9pDFN6JLg9IYt
         yRJuB//CyGBQ/DCMuUFro/Ig5QIIVw1xkV5MpcWAiUQ445tsGQMvhcaR9mudtG2OFDiA
         /e7Idk1o7dqTuvh7GXTxlV9NoX88SwjHsvcVACT7wzvBllfjiK3Qp1sVKGZHru1dtYrX
         yOydnW1d+wrxYcWB/V14vhetxoAKNB9HJT7Xg1nH2j288yBHzRpYmoWJxtBe23AGIqrF
         hvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720470573; x=1721075373;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wkEfjrwUYJog8BnYxx2aUfQrQWw50EsU9jIJpemay3U=;
        b=Skmz6dqHh3N2x0e+cgm9Q5fUupEJprOek6B9uUGumRHO0KLhendNuVROdrf5Nadw/v
         euesC67eBYSzM3xpweGtFg+ifHwEEfilvwIZCN1z5ZHAwPD18l8T+o4b/0ZHL2RdIDDn
         5VdoXpGZ1lfkRGGIbzpE07aGS8zt8mHr6ywAbec9iLbCa7AIzpEK31C1gLk0uS/s2Eby
         kT294/lePjsTiOU2hvIJe6aesol3BIIJvtOb+rIp0HARPzz0HbvA4DNZ3vgLUX1Szcv8
         s/5Sh3T18+AcmYQBKDD2nkQVWaRTg7Ej8RQDh7FP7phCkzEntMaoqlnmEvuLQFJsGj6W
         4dOg==
X-Forwarded-Encrypted: i=1; AJvYcCXs5/Bm3dp8SXPxefeI7eOuQKG+gc2Le0ZFUOtwmkJGDM2HL+4wZV3N43R6GbEl5VaKY95Snx2fi3IcoDvVL+OjjEZ8eKzh
X-Gm-Message-State: AOJu0Yz4/yP2hiHqno0d85X/ZObTa/keovfn/ugfvhjlOL3dBNAtFc/q
	8jKH945GtmUBQKa44dbhlL790JKoVqz1+dJ76SsZgoqZiahfrX+Q
X-Google-Smtp-Source: AGHT+IFHSUL6xrHN7NyszDZpijspfpR45U5VT06wUdxFvCM6j9ZRjHuge+V6cFz+6n1nWlD0+Cu6qA==
X-Received: by 2002:a05:6102:1520:b0:48f:e9d8:b172 with SMTP id ada2fe7eead31-4903223023dmr744203137.33.1720470573386;
        Mon, 08 Jul 2024 13:29:33 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd23b4sm2846631cf.66.2024.07.08.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 13:29:32 -0700 (PDT)
Date: Mon, 08 Jul 2024 16:29:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 petrm@nvidia.com, 
 przemyslaw.kitszel@intel.com, 
 ecree.xilinx@gmail.com
Message-ID: <668c4c2cad160_19d5c1294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240708130407.7d22058d@kernel.org>
References: <20240705015725.680275-1-kuba@kernel.org>
 <20240705015725.680275-4-kuba@kernel.org>
 <66894e1a6b087_12869e294de@willemb.c.googlers.com.notmuch>
 <20240708091701.4cb6c5c0@kernel.org>
 <668c1a2168f55_1960bd29446@willemb.c.googlers.com.notmuch>
 <20240708130407.7d22058d@kernel.org>
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: rss_ctx: test queue
 changes vs user RSS config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon, 08 Jul 2024 12:56:01 -0400 Willem de Bruijn wrote:
> > > There may be background noise traffic on the main context.
> > > If we are running iperf to the main context the noise will just add up
> > > to the iperf traffic and all other queues should be completely idle.
> > > If we're testing additional context we'll get only iperf traffic on
> > > the target context, and all non-iperf noise stays on main context
> > > (hence noise rather than empty)  
> > 
> > That makes sense. Should the following be inverted then?
> > 
> > +    if main_ctx:
> > +        other_key = 'empty'
> > +        defer(ethtool, f"-X {cfg.ifname} default")
> > +    else:
> > +        other_key = 'noise'
> 
> No, unless I'm confused. if we're testing the main context the other
> queues will be empty. Else we're testing other (additional) contexts
> and queues outside those contexts will contain noise (the queues in 
> the main context, specifically).

Nope, I'm the one who was confused, of course :)

I for some reason assumed that the contexts had exclusive queue sets.
Rather than these being absolute queue indexes and overlapping with
main_ctx.

In which case, understood. Sorry for the noise.

