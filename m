Return-Path: <netdev+bounces-52950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67922800DE2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02039B20CDA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB883FE20;
	Fri,  1 Dec 2023 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fblCLBpf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC68171B
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:03:08 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77bcbc14899so115042285a.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701442987; x=1702047787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mDrILsdJdFn3RK4jint0RO5y2314rw2m+gKdkZIZY4=;
        b=fblCLBpfz0TCXUl78I11bnOB/g+JJ2bdXG8E1NYJK45IPBuAuPJbiZTCkQJ6bRW3cf
         35K9cu4uSO0fqT9wnG/ZD2BZVDdoVpnphXtS53Vwg5aiEZkou4O57hDAHP2FV6SQ70+W
         WtgiNar9RJ8FYz4Xjrie0fazelgdeqGVSktFoxKRFRoP2pee+GR2zOKUt05t86IgqAut
         SEbdGO5p1sIFnjML2MvKakp9Q1Ohfy7kLA4jkyCtnANGZdvcHzE4mJRbv9YnXpUjWhUY
         hDc+cU15LGkLmzPfO7fMgC2wVx1vH9WSYplMZfA4vR4JS7OkAsUtUoak66dY8xaFdeML
         X2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442987; x=1702047787;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0mDrILsdJdFn3RK4jint0RO5y2314rw2m+gKdkZIZY4=;
        b=cwU1nqS1Slh68gnGkAlO0MVH5UQ2/yNlaJTDCnKZZ35TtnNVAel9v7WAHYWlxkpLKy
         uoc7ZPzQ0m1cxiss+oRWo7PsSTUtuGEwhSjH74iBH9yrpU63yRxRG7hnPi/Qpo5Hm1rV
         LXWiRiqCKQF2KxyLYirzl/o4yA0cP4byxpUl/A1wNH8orzuQf4dJ/aa459grRJzA32Hn
         cTRWvjPZOKkZIeXx4EkOs6DfYfRrxeNL0vtu5el9w9HGfnZgZWALl3Yw52LF0k58tYK9
         fdSjs7l0smEKqIcx30jPF3XdgV2uCiD8WT+/Gu1vku0nKwAPvg9owvgGRl3G2x3snQM7
         PnCQ==
X-Gm-Message-State: AOJu0YxtWR9RcfhoiRKzCpPYSpIvK/4yTKQCUwrc0mOiwIPdAq9m6JIE
	wh8X5fQ+YS8iuMsUHygHo8q3fQrgAts=
X-Google-Smtp-Source: AGHT+IHEQb2BtsAD29iVjRmDcX5XKawJEs5JgqeE6zV6AEF4jLtDR8Gxyg9VOCobe8z1StICZT3uFA==
X-Received: by 2002:a05:620a:839a:b0:77b:e2ae:934c with SMTP id pb26-20020a05620a839a00b0077be2ae934cmr32438028qkn.12.1701442987123;
        Fri, 01 Dec 2023 07:03:07 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id z27-20020a05620a101b00b0077d8fdc7e84sm1561460qkj.5.2023.12.01.07.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:03:06 -0800 (PST)
Date: Fri, 01 Dec 2023 10:03:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 netdev@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 stable@kernel.org
Message-ID: <6569f5aa70747_138af529417@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231201131021.19999-1-daniel@iogearbox.net>
References: <20231201131021.19999-1-daniel@iogearbox.net>
Subject: Re: [PATCH net v2] packet: Move reference count in packet_sock to
 atomic_long_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Borkmann wrote:
> In some potential instances the reference count on struct packet_sock
> could be saturated and cause overflows which gets the kernel a bit
> confused. To prevent this, move to a 64-bit atomic reference count on
> 64-bit architectures to prevent the possibility of this type to overflow.
> 
> Because we can not handle saturation, using refcount_t is not possible
> in this place. Maybe someday in the future if it changes it could be
> used. Also, instead of using plain atomic64_t, use atomic_long_t instead.
> 32-bit machines tend to be memory-limited (i.e. anything that increases
> a reference uses so much memory that you can't actually get to 2**32
> references). 32-bit architectures also tend to have serious problems
> with 64-bit atomics. Hence, atomic_long_t is the more natural solution.
> 
> Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@kernel.org
> ---
>  [ No Fixes tag, needed for all currently maintained stable kernels. ]
> 
>  v1 -> v2:
>    - Switch from atomic64_t to atomic_long_t (Linus)

Reviewed-by: Willem de Bruijn <willemb@google.com>


