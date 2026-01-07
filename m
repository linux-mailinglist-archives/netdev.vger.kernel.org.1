Return-Path: <netdev+bounces-247589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90004CFC287
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 07:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA32301B4B8
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 06:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF426E6F4;
	Wed,  7 Jan 2026 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVVVjkc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA46513AD26
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767766380; cv=none; b=aVw/SMnlmX/YyuZmf2wThvNCzRal6R7ghMZX60s7fp/TYJSxjPwAGB4JbM78GSqPI4atQM6GBfSnLr0JBNIWjctzdvdrtIwfGX1aOMWliNmVW/qqE7QAIqaijj7OcwLzvQO39FeQGBK5ueRwANlMUQKUiG3sleoyPvmAjb4oWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767766380; c=relaxed/simple;
	bh=D3BXtcumwJvvq9eXw6PUSHKum6X81vvHyYQBCXThgmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+x24TAt0CcV4CPazpfD7+Ov2FzehE4HoHPGHAj1aabG2YfkOY8G2GvMhqu7NoSUjHtO5IO8Xes1kTjiz8ilYJ+0eCz+4xsgkqV9gU1Hx+5Pm76Gl6LJWuWCU1Wl4DbNNJzJXSXw7JxJmZLqUwxsbvjH4SciwuJ5xJkMCUxXddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVVVjkc+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b72b495aa81so316086766b.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 22:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767766377; x=1768371177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D3BXtcumwJvvq9eXw6PUSHKum6X81vvHyYQBCXThgmk=;
        b=RVVVjkc+qXrUCuCNQicKoZtaJxy9iibUc5ipRTxOdgBBpFjwxnfr8CqEfLX8Qn030j
         IHXNVYElAKoMUhv7ZTy9MW3p/QDVdK0d3oTc6owPBWLnwY+Y4V1XkvGtsmvSgqwTyTaa
         Lof/lektqLIoQuiA1m6LqTkmjzjR18ZentLjRPSp9b+Nxrt3A+DN75zQeo17nMZCSlOM
         iNRS3/rCnrSDhoGQ49S78p3NYWmZ5UQWeIcTzFuTWBUgC7GsdNIpOlcyRN4NzchOUnAz
         YoYOICkYbXwiSjwZG7R2Ehxzr2z5WYlLPywStD3xvp50hD8lgIDVBH8qn7cSu3q6lhtc
         AqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767766377; x=1768371177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3BXtcumwJvvq9eXw6PUSHKum6X81vvHyYQBCXThgmk=;
        b=tc1dcW/abCqQhJHKUnDLfPsK5Nh900Rih7i3+eA4wWQuWNgVbn+eVmLLaP6rZvgfUX
         hpEYxZVfpYEBI4tiPPgqHFQB3Ig7xAQwMV4DlKzb9UZ+rP4hLBLSLI++8iCk3YWN0VOY
         8j9DCMzVgE4N/cgmaiteyWqAASh/72t69wn4QtD1j/oektwB+XP6SIxbblBEq9hlOnOY
         4NG3FYdOrY7/vut+SXVHyHlfcvWfMl1mTrfGqroWtMXs77Zb0776Wt9qKh5fREeW0NMc
         hda89Gw5hKpz6+5C3fhevS6ojN1ezYsEmglu7uRXcQ2GzWfYR4oEY8RM9Q9dk8G4DmPj
         Y8bg==
X-Gm-Message-State: AOJu0YyH0Oe4UKp8WcCwWjgaq5LYjS2Xu4ieNUsZzkT0rR1V0XNKRmLP
	RmstUn1LyMqnFeWlFVWkG0oQjDN5Ne0UgDvOZg9hWFFk5HoWtMcr/lk5/HvWG8nFpuegXa5pL1M
	zg9UoNO5118DMcwHpjEg14Z9Dt+Q6aPo=
X-Gm-Gg: AY/fxX7PzKYTevaAqjvVqoh10ilxKdOVyJ9NN7LzHktyuqYcPJStXQc3tpk9I4hqSH8
	OjFWlScK5VwaJeSX0+j/2QBq+tFtCofep7jz41N+mxewueZXMqcy7Ui7nov2BJZL/oZVFd6awGg
	I8x+3ykQnZQSxkjvcFhduPLqlxuWLA8jVqP6igOpPYq5uHWDmNU4IrllpB61ZkFVwCFg9ZXeHVs
	gCTCVXcCcBLQ3MHLD2Kf2xrucqOq9/WskiUArBPhlp+0dPzKI0lqxhpph3GqmGCoCNtEoWSJPPV
	053ns3j/OxvIQeeIxkXA20K0bG0=
X-Google-Smtp-Source: AGHT+IGEdXauSnucruM/n3OjiiAB139nO+cqvugOWDgfSThFPqTn7sY0WVAynZZkYDoxwk9mYMwoDO7ZCh7XOtdZ4vc=
X-Received: by 2002:a17:907:3f9b:b0:b73:54d8:7bc8 with SMTP id
 a640c23a62f3a-b84454481e0mr132675166b.59.1767766376964; Tue, 06 Jan 2026
 22:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
 <20260102180530.1559514-3-viswanathiyyappan@gmail.com> <1767698557.9158366-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1767698557.9158366-1-xuanzhuo@linux.alibaba.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 7 Jan 2026 11:42:45 +0530
X-Gm-Features: AQt7F2pNx_sz0Kz4voUNMq2vLTYeuDB9vTdIYRox5y4oe9K2F8DBFcuRCXwgv2c
Message-ID: <CAPrAcgOp6K_udUQUZhb+JhJqS26M3YjBzHDdS=i1_9iXy+3k7A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] virtio-net: Implement ndo_write_rx_mode callback
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	eperezma@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"

This refactor has the secondary benefit of stopping set rx_mode
requests from building up as only the most recent request (before the
work has gotten a chance to run) will be confirmed/executed. Does this
sound good enough to justify the refactor for drivers which do the I/O
under a driver specific spin lock?

On Tue, 6 Jan 2026 at 16:53, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> If this is a common requirement, it would be better to provide more examples of
> driver modifications.
>
> Thanks.

I am planning on modifying these drivers which I can test with
QEMU/vng. Does this list sound good?

e1000
8139cp

(I will do these if the secondary benefit sounds useful)

vmxnet3
pcnet32

