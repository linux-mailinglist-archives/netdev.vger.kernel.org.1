Return-Path: <netdev+bounces-237628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A9C4DFF1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C983B907E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765E3331233;
	Tue, 11 Nov 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOk5nSJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D041EFF9B
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865274; cv=none; b=NCvynGkhkOm0Ry1DJ6GWXREsNUTv5d6AaBL8fEQ3tTf1gKyf20NH2n++DtfO9nxT4FCOPsO56WHEqJur7H94yws1imtQBeySY011vKl58BNGmoAU+Jnr4SNy5Qlxct6DfyIG73ge1Xe4Jq0f+uX84pJSIVjV5isuZuiE1EusjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865274; c=relaxed/simple;
	bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWwnVlj9jHfsaPXhXfOk2y4cjzgijBzO8Kfp+87RL2jSx8wc5wfVsoinGI151vzCge0uPSTiFO5jGjzXxyD1bCoaOZBLpHaQNfrXkQwvwDGOdl0Cuj87rbhJWGa4EdZT9xhcqHU9d4QYtn8BjqvtzPWAju1QF9ym6+ELnvD4o8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOk5nSJo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b5a8184144dso545199066b.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 04:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762865271; x=1763470071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
        b=FOk5nSJoQjCABGf/sAQ/B20xKRrjjzuVFux5FDtYHfJmC+xnmTh1dtMrDF6UeAR/WF
         BiK82c2sdHROsJ2oUWIM2cnG834hTGNhcXCn2F9sGchGrHU+wRVf/quAtsAW317w4Spv
         pzJDBy2ejovyN95vUNSUgWanj5LCIRhY8Mq1NJ1FuwEkbLgIezViO0BOhf2X408j5JhE
         YujDkfwwt24qTzOOHp4+voMv6LXJtJJ13MNIPDLU2XuhmNj1XBFn+33p9XRzLjgrfos3
         HtKfPZkjX+I6v4YzutV5f27+cKn/jjUAcGjpOgmd7OLaZUtmHBNVEaqhppYeZXC/B8fE
         mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865271; x=1763470071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
        b=nmEQ3rrcNejtcsCnR76jRBoB3EHj+h9g4wtDkbVnysHkX4YabowXSDaJ/4SyZGruS8
         /1Y340/RMfxF5yEIoRKjJ7k6WUFkqnnE7GIW8jEi1lz3gvQbUTBcRX9Cf0qrfNNKMpQ0
         fLmuwKsFLImZ7KpOAtzktFYiGQcnwGkbgZwmH+IDANirvThqEvV6KprWAuP0QmINNEDT
         pOb0KgfP3kp6inDzdsyd5rBNxekZXTZyy6qCffVgGOQa364XrLVqNJl2nKhtMIh48FzG
         oDain5BTVVu5nqlZdLSJeFolZo5u0w3kL4PWkl5bH3DciFbrNEchQ1dY1lNIWoaBUszE
         DcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP9jk15VxoOLsUn97pDfOggkBYyc+tfFqF71qfKgNWOEjEZiN0euDO3Y1px6XYLNJlbwABARM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJw3LYSxVptQGxbNaJQDCqKSCs2MGfP+CUvoGK7CLFXexM0GF
	ZosGtIiILJYFky7xxIrZu+2TX/t4FymNGGuPgVTGZcZqcpawVUULIKOESYTcCOf171cys9PDzBt
	zEFo3YRlkByHrtq536OlQ8NL0kviltNA=
X-Gm-Gg: ASbGncurBEVKAc1wHmcmUibadIu5r0ZwEDNZh28cg+t4BiZuoweTRQ1xTn7yKAhby6H
	WV6TCwTt2OlpT1dgMK8h2LpMwgoXrMeBdeldgddiMoMHNl6MI6jee11P1UmNODpr+JtFTB3psLe
	Bizi4sKQNtfh+8piDPjCQsSOqICeht25+TUzhZ5apSqALLaEYJmVztJLy1w9xjZsWY67yo/LA5y
	bH8zNORvuYJCZaWxdz4BGSF2wF6HnjirXreG392Y4W7UfO3Gn+JSDrW3bZp
X-Google-Smtp-Source: AGHT+IGiAQgwMVRiGCnMiDWwUKJTp3VVUil3hi7anG6LPGbxJTxQiXv+QsMmKl7eVBT6UKFdaroeoqA7jwP8sNFm9RI=
X-Received: by 2002:a17:907:96a6:b0:b65:b9fb:e4a7 with SMTP id
 a640c23a62f3a-b72e02b337fmr1061707966b.9.1762865270901; Tue, 11 Nov 2025
 04:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122023745.584995-1-2045gemini@gmail.com> <20250123071201.3d38d8f6@kernel.org>
 <CAOPYjvbqkDwMt-PdUOhQXQtZEBvryCjyQ3O1=TNtwrYWdhzb2g@mail.gmail.com>
In-Reply-To: <CAOPYjvbqkDwMt-PdUOhQXQtZEBvryCjyQ3O1=TNtwrYWdhzb2g@mail.gmail.com>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Tue, 11 Nov 2025 20:47:14 +0800
X-Gm-Features: AWmQ_bl7jKmbrVcAN8OrZV0RsO9xo9Mq7861gNjqd0U45fWXiyojg8RitqkJLAo
Message-ID: <CAOPYjvbEbrU6qOewg4Ddc8CBDjmXous=PbgFF+5cQHf98Jtftw@mail.gmail.com>
Subject: Re: [PATCH v2] atm/fore200e: Fix possible data race in fore200e_open()
To: Jakub Kicinski <kuba@kernel.org>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	horms@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub and Simon,

I was organizing my emails and noticed this v2 patch from January.
Simon kindly provided a "Reviewed-by" tag for it.

It seems this patch may have been overlooked and was not merged.
I checked the current upstream tree, and the data race in
fore200e_open() (accessing fore200e->available_cell_rate
without the rate_mtx lock in the error path) still exists.

Could you please take another look and consider this patch for merging?

Thank you,
Gui-Dong Han

