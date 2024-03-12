Return-Path: <netdev+bounces-79528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E1879CBC
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 21:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B491F211B6
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486661428F9;
	Tue, 12 Mar 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U7QWMctl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A37E104
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274647; cv=none; b=BYTukKFlhxQl9THf9rLYoO0cktmJHGIBIP8ndArCMCCfJbVo6j4V1mFiWALzTu1GGlZqOUtD9tWj4QkEL9BSel67IgE9Nb/T2c+TrSSbFzobYtZOyEw5t1RRBI8Ipb3OYkrFfzdvZNVpPrPEs359wx0GEE983GU/lzxE0e7dorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274647; c=relaxed/simple;
	bh=QfiI841UMd+b4M6uGOAl6Tti6206LQPlspjZ1aGj+vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVf5EbSj3C4BogBW6SINPjF5Tw9rTLK6OlJOvAILHVmvTH88o+osHIhdAMOI6YXqFeq7qcjNNFbAOPc3N6VetQaQ4+4bLmGYZzavt+Dhbjix2siMrM/650K2GZTUBwPhHELhzJxeuv5vxXIjhmG2yp+xRStHvMfjyTw8X7avjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U7QWMctl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5686677bda1so388203a12.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710274643; x=1710879443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vIGv442Bb3GoyJ4GTJ4MmhCFvAXMUZvcBMa8Hexcis0=;
        b=U7QWMctl/G45JotggaKN/dnbq4z7uMEANnSMQSWr8GgMCMq8NX4Vu+jhYssskbwA1V
         wc7293ZskkTB/97luDvU/tXjNdI2uVhGlvN13HVt8VpmCpV+uNewwkhM30iP2C2xn9Qp
         IPJwg3n8bk/FIVjJEeP1IuPK2eI8R122Ann5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274643; x=1710879443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIGv442Bb3GoyJ4GTJ4MmhCFvAXMUZvcBMa8Hexcis0=;
        b=V0QKtE4zae9XDWRvHnkgcTaMn8u+8s1rFOvt1buhg8/yreWf1oqJr0esHRrKgCAWg1
         8xgkJWBpNRez7ePzmtXSlhfkMZkyFsUFkDDL18QJVSeSS58PhPkuHrfgoNp4g5pQepaS
         G7foYJ22ax4niPn+bRJ/RaPKorNmrcQcnkAJfSQFLzVj5ULGQTsRu8JTtuMVp6Ebzz8m
         k2HKsYNVQT8JzfkV9dgTws9pj/1m7ZtOjKHQfUa6FdZ2RaTtIqDut/pvM1HI1J+hGuQb
         yVYRO+rJT6vCrIz8xGjlNRlMM771updkctpBvShsf0LZ3mnQX18jbKN5lkQB1ECLtpRH
         nayQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm+R0bSW/wIoeNrRW2XAztKIHAxAqkl4QCqT7ydwBhDcVXtzcPEe1vI9X0XV3H6jN1/SkCLbVX2MCeU7HYxhz6L4qRNkzJ
X-Gm-Message-State: AOJu0YweGEVCSvwURurL6njXNhLU6t0QIxvy+YneV0PJjtJAjSNsvmpH
	zDPeEwiSajYOovRW0BZSr1f2hP85FU19S+WIHBhpfVU+8H7EFxsC+vDlDLc/Cr4UfMb6aQtg+Kj
	N5LAzbw==
X-Google-Smtp-Source: AGHT+IFTmSLkaz/UiRZTCwa6jsdR40z/O/kqAVUH8x2y7IXdFpKYxNMjSuEKrYa+lPdbbJuUxGo2nA==
X-Received: by 2002:a17:906:6b9a:b0:a46:4e06:634e with SMTP id l26-20020a1709066b9a00b00a464e06634emr573214ejr.31.1710274643429;
        Tue, 12 Mar 2024 13:17:23 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id bn21-20020a170906c0d500b00a462e5d8d4asm1951655ejb.114.2024.03.12.13.17.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 13:17:22 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a450615d1c4so38825066b.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 13:17:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8B6RjPgDCs7my+s7GqijHFfHDjt5JHxpIIqg90wZdOfAY1H7Bt++b5Zh0D81cAzem1g0mOOLnnAzkepcDeDGdpdIFS+0N
X-Received: by 2002:a17:906:6c8e:b0:a46:479c:1c1 with SMTP id
 s14-20020a1709066c8e00b00a46479c01c1mr521289ejr.19.1710274642338; Tue, 12 Mar
 2024 13:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org>
In-Reply-To: <20240312042504.1835743-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 13:17:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
Message-ID: <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 21:25, Jakub Kicinski <kuba@kernel.org> wrote:
>
> I get what looks like blk-iocost deadlock when I try to run
> your current tree on real Meta servers :(

Hmm. This "it breaks on real hardware, but works in virtual boxes"
sounds like it might be the DM queue limit issue.

Did the tree you tested with perhaps have commit 8e0ef4128694 (which
came in yesterday through the block merge (merge commit 1ddeeb2a058d
just after 11am Monday), but not the revert (commit bff4b74625fe, six
hours later).

IOW, just how current was that "current"? Your email was sent multiple
hours after the revert happened and was pushed out, but I would not be
surprised if your testing was done with something that was in that
broken window.

So if you merged some *other* tree than one from that six-hour window,
please holler - because there's something else going on and we need to
get the block people on it.

               Linus

