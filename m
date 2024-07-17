Return-Path: <netdev+bounces-111966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFC4934516
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 01:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B211C215E2
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB16EB7D;
	Wed, 17 Jul 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qp5NDi5y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797A1878
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721259702; cv=none; b=dd5k399e/iCNLpBvqLYWgBZ9o8JQeEnMSHcqKDJeNKgky/7OCjpV6KoOj+CB1mgTBSYMUIdIzsHDQloNF3MyuXR8fsw4OumxtpIVkYQvoNuZPj54Y4xniAfn4PZDDZmM9GmiVQE/zCyHKq/yM2jbwA07A4riRCcBIXTjY8esFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721259702; c=relaxed/simple;
	bh=OePmnBNxXcqQ8hkL4Opt+Ze5aDkg/NsMFsvb1a/5MZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRopNo1VGRUp1T3W+KpE2nxXqa5zPZXWXoPCznBxLwf/umnrcvSKC3lRo2O+pEMb8Ou6IJW+a3EgwG5ZhPqdU6I3g7Bu7h3rwNRmSMKChvwxOvreSNsjtYLE1dIKVn8VDwAhU/V93vQYM9I87kax1id5/stqXWCj5zVGlnH5vt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qp5NDi5y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64789495923so2113787b3.0
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 16:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721259696; x=1721864496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OePmnBNxXcqQ8hkL4Opt+Ze5aDkg/NsMFsvb1a/5MZw=;
        b=qp5NDi5y2zIOcH9AXZL8LA0LDxn1mI6Wn8o/aUOnjeivzxkcY1/8jWtS6avr/mNea2
         zivbb+OnlVWx3ga+G3eqXpY4ek7V97mCB62hFJ70u5RohGikDlITZQMTa6Pe1JGV5bfi
         NB/MXt7HNT7zHyvJziQ4ttJEcc8wbMxD5oePo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721259696; x=1721864496;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OePmnBNxXcqQ8hkL4Opt+Ze5aDkg/NsMFsvb1a/5MZw=;
        b=g149ZhzhPaPn0E+zFeGVh107xC1s60B+FsRCzDalksvsXn7yZttMiq6xN4WFj6Afis
         NjZxnaquEphnH6Ctotb95h7LJGseoG1L5ghhVqOhnyX9JkGkgJ7aXKWufFeM5AwaKaea
         NdeklD9SeebnaBnffKB85mJiUzffWIXkHzcVyg5Cmnm7pDlDQ8LAriCmpsa4zj4B5e+Z
         DvCzgEjqjMUlooLNTe3+AzzfDJQtukN2J9UPZpMMdchfoPBEEMF4hYaAS5SckSvD4ko5
         g8E8g8xVZ5kJCeZIVOHxMy3xgj84w2MYi7fBYnwv3Srsrbx9mEm02aVjcf9weToN7r5F
         dxNA==
X-Forwarded-Encrypted: i=1; AJvYcCXc0aY2HhoqeWm1+DMiZYZUG55dx9NXG7jaNDgc9LNKuuhsNQK9g8f8iitXUL3ANktgqDSLNLtHappJpDDxP8VM2ay77Wx0
X-Gm-Message-State: AOJu0YzGq8PwGb91hLohGNp6wzMZlqsZ24Ofu/ouCFHhi9kz3Q49CF+Y
	18GGrHqM026PIHgErGQue2ZjvVDU0iYt1nYyaKBmjA7F20uC3EINIrnG4KR0/K8=
X-Google-Smtp-Source: AGHT+IG06EEyyEmG++GQzdMvsD/Q2ymdzca3Nl7yHImDDfUblOJ5Ej+W6vy3FASnQs2XXt0uDqmTAQ==
X-Received: by 2002:a05:690c:2712:b0:64b:a3f0:5eee with SMTP id 00721157ae682-66601dc3816mr11547417b3.17.1721259696404;
        Wed, 17 Jul 2024 16:41:36 -0700 (PDT)
Received: from LQ3V64L9R2 ([2600:381:1f09:7c46:a087:d053:b69a:b5a9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666043b97f0sm1152897b3.142.2024.07.17.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 16:41:35 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:41:32 -0700
From: Joe Damato <jdamato@fastly.com>
To: James Tucker <jftucker@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: uapi: add TCPI_OPT_NODELAY to tcp_info
Message-ID: <ZphWrG0H3TR0vg7R@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	James Tucker <jftucker@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240717-nagle-tcpinfo-v1-1-83e149ef9953@gmail.com>
 <ZphI8Z89iLe3ksVP@LQ3V64L9R2>
 <ZphJyabJV2wDrKzi@LQ3V64L9R2>
 <CABGa_T9HJdFiO8gSn72_YP6rp3t+RhSEtYXtgqxp2GUzQJiBmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGa_T9HJdFiO8gSn72_YP6rp3t+RhSEtYXtgqxp2GUzQJiBmg@mail.gmail.com>

On Wed, Jul 17, 2024 at 03:53:07PM -0700, James Tucker wrote:
> I'm using b4, as gmail SMTP is not suitable. b4 crashed after sending the
> email, failing to create it's own tracking metadata.

Not sure what you mean exactly, but I presume this is why you are
top posting? In the future, please reply in line.

> Should I create a new thread in two weeks with the updates you suggest?

Yes - or you can create an RFC in the meantime to get feedback from
others.

