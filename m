Return-Path: <netdev+bounces-130057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055F2987DCD
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 07:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376021C227BA
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 05:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0771750;
	Fri, 27 Sep 2024 05:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="nuYOX2Kq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E699184F
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727414183; cv=none; b=ECNTPwTVQdThTd6UA9odyy4Qv1hgFU2YajX3m49QCg9rjUKXk19Khcsk1ojbiAcN1QMjBN8/XAz4SDb6mbMYBERKgtOOlR0x7m7KmyFUKTcxNN6MkNI3jBxP2zxCcvWiwVQh8qAiqkrI4ihnKCH98kunQcZQ7ygZO7r3gff+P9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727414183; c=relaxed/simple;
	bh=9AAw5btleGGiV7XRXNQp6uOjmZ57QQoEoZeMw4x9J24=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jR1eGDOML8+KasUDUrr0TvvPW34kXGuxrJzSl6RCTQt1ObK06ojUvDVGTEH5UxiOn1u6TRoiYjaoGciGAPNIZBF8rE14Yj6e6YK3mZovfGMaKY7VVsmVTXU4DaloBz/epU4jTty+XLdBvcuoLjPqIG0vdAeNCaXprUWWgCI6Z18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=nuYOX2Kq; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9AAw5btleGGiV7XRXNQp6uOjmZ57QQoEoZeMw4x9J24=; t=1727414182; x=1728278182; 
	b=nuYOX2KqVxy/bBObB8KwTqRQB1Xl/CTTvLFfTerHp+O/Qxo5zlJRbymyXDYKQsYjyqPlHDME0MG
	WXfi+X8LiPqJUfOlkc1yHfRF0eqGB9ga2hlPI1eHouV4ogSNFbuX+RdIT/UZDdTyh6hK3nYdDPRGB
	pjE/AYJPpj4LTOQqtx0+eKMqUI840pfbfnYaF4rf2jwblrxkZ8lG3TrXMIo3IJwvkhWJxXLW8GULc
	UcYqHSbuXvAL7yI89kAiFwu+Yd/cJbk2wk5ritfoRerPuiCZFYN/NYY03zBAh7Ooj15vycJOW6lHF
	3i/xq93wDHY9iWyEPGPd7P6slLBYXaXSA/Kw==;
Received: from mail-oo1-f49.google.com ([209.85.161.49]:57828)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1su30I-0003Rn-FP
	for netdev@vger.kernel.org; Thu, 26 Sep 2024 21:54:55 -0700
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e1b35030aeso988917eaf.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 21:54:54 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyta3xhHuFMPrdvNkKdhh2aS3xEvJr8UBcmrVBHkr68FQ9rW8+B
	z65dCbwfN6m1kwfGWHZHb3SS+B1bGsCA4F10sWd8j8LovWjo5a805tFYD0BpM0bfbMOifZwFrvL
	0vwosHpU4XdsvsLmxUNF9qtn+oyE=
X-Google-Smtp-Source: AGHT+IHXoU8XQDvsSGxCnBbFTELKcascjyIqg/nIQ3ZDzwa5qWPLUwe7n6uBaTN7dzGodPja1RZgx9C5s2tvPmi1lcM=
X-Received: by 2002:a05:6871:7295:b0:277:fe14:e68c with SMTP id
 586e51a60fabf-28710b9e1acmr1791368fac.33.1727412893887; Thu, 26 Sep 2024
 21:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 26 Sep 2024 21:54:18 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxbJ7tN-8c0sT6WC_OBmJRTvrt-xvAZyQoM0HoNJFYycQ@mail.gmail.com>
Message-ID: <CAGXJAmxbJ7tN-8c0sT6WC_OBmJRTvrt-xvAZyQoM0HoNJFYycQ@mail.gmail.com>
Subject: Advice on upstreaming Homa
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Score: 1.7
X-Spam-Level: *
X-Scan-Signature: acf3039aa8d32d1ac60a71149e52b94c

I would like to start the process of upstreaming the Homa transport
protocol, and I'm writing for some advice.

Homa contains about 15 Klines of code. I have heard conflicting
suggestions about how much to break it up for the upstreaming process,
ranging from "just do it all in one patch set" to "it will need to be
chopped up into chunks of a few hundred lines". The all-at-once
approach is certainly easiest for me, and if it's broken up, the
upstreamed code won't be functional until a significant fraction of it
has been upstreamed. What's the recommended approach here?

I'm still pretty much a newbie when it comes to submitting Linux code.
Is there anyone with more experience who would be willing to act as my
guide? This would involve answering occasional questions and pointing
me to online information that I might otherwise miss, in order to
minimize the number of stupid things that I do.

I am happy to serve as maintainer for the code once it is uploaded. Is
it a prerequisite for there to be at least 2 maintainers?

Any other thoughts and suggestions are also welcome.

-John-

