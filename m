Return-Path: <netdev+bounces-85229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05574899D3E
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B601F22A27
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D7F13C673;
	Fri,  5 Apr 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXnwZiKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B301649DF
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320932; cv=none; b=DKgFbzbHGyvzhkbDgdA7pnpA5pn+Ml8XtP3rjHKCGOiG5XIPkoP+akLObRIWmYShcI+wgJyL8LBpIhc+GCkhwcLv3IIZH6zMNum+6lpyLUNoxJ8JUec8oNlW4QP0CS3okWTCgr31ahQs7QQx/C220MOzGqJdOIkcXWh7fe2JlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320932; c=relaxed/simple;
	bh=SXUNLeIIkC+dmaNcU+Yxqy2ljJq5wklXQ51/I8Tbrek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gY1DRh0VQVQ7EE3RDsOt22OlKcugeousKwetHgWzLZvwUt9gv1fphpMTBjbStHccx0GehtECl+NWs041qoJcrRCO0VUB3YVPkfkMJC4RzVuYBcWsXdIY3bJgHgkYGkSe5YDUBJ8gyAfa5Z33F+leIy2P8nVkKvadsN63sYPLGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXnwZiKC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so8107a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712320928; x=1712925728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVBvJilZY3Ooedngi0kJwoAC9G+3Khq4/wHI4eXqFHQ=;
        b=ZXnwZiKCbHOFl3IiNOCPogtD7rIAPOF1pZoBuUS8eP2dQkjJop1J+hgaGUm4oONcC9
         C0oSK2aeshaak7KI2gtYqbxlbodbaHkG9Xn1HSC214Yj1jTXPep+t2Qy7LYCKEkfa8Ru
         f3baN5z7FllZpdQ6c/xaIr6AtaRg9VIxgFXImCd3CSbgcEp5rs/bHT+jlhFrdbJh/K6/
         UhYbOue/Jjd7bamF8ixB38KRBN+Go6ZWburw0ZtsgGx9kmS1tKKhytNYl8DRPYLgtZjD
         Y/9fUdxa0teEu0V+PtAtSLwU6NQb9MdpBJ8MC8SMFwPltAesZlpUhL+/qoOIxXCo3au6
         eLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320928; x=1712925728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVBvJilZY3Ooedngi0kJwoAC9G+3Khq4/wHI4eXqFHQ=;
        b=sT3jvt1f3a34ewswOmsQyUsJIi0PklPbOwyfvxyEIhiNJkipy1RLD726Rsk/cuK4Uw
         ICnSKyzRxiqADykQQcLboz4oqPmN/sPQAdwruvWpeiWsJtGYk7TSZ5dggu6NaEW8+uVC
         lepoKzl4EXDamtoudectC6wtA6VuGqMhOJVSHbkuYisG9jmyS6xsC9Lh2bbC6aKiEBnt
         jabznJybrh3QwgN6k2tCw3jjXLYoy3NqE4/kCtBWbUYsJoz8pWo6PtTIJDuCH8qWJUTy
         uXbVdttXDm5ti2dSSSllpzjozfTRQ+XksXkssdVe2JHfn6/8thAiVu4mH9MYPZfdPGrs
         pDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrr0jmuBgIsrBrzBEIZkgFdt6Ib35H07Qupazc7FVqyRNmuE1qwrBw00cNJTFg/KNx8FU5RQ97sh8DhaPbL+wED/sV11cU
X-Gm-Message-State: AOJu0Yzs1shAWh/NtQCb0/magsU6wcvJ73O3eOyahBLW+o33Nc2qA+yo
	EDQYXVkCmJW2K49dvVtKYx0CFb+0JZwYfCPecVsG9LqfMhVzvj/uGksXBaXU0jnM/u7BhIHzloe
	1AOxk2qGVaufE7c/mEVcj5/Bw7oSm9tM1IuJw
X-Google-Smtp-Source: AGHT+IFPAHKIJ/1yJhnZmS0vik0zLdsQtl/+FxlV6/w+aHTBFigb86WPpQMcVfiyeUwzuAMtfjsONbs4D+6LkJmw7Ug=
X-Received: by 2002:aa7:c40c:0:b0:56d:e27:369c with SMTP id
 j12-20020aa7c40c000000b0056d0e27369cmr303313edq.3.1712320927774; Fri, 05 Apr
 2024 05:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
 <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
 <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com> <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
 <CAL+tcoC4m7wO386UiCoax1rsuAYANgjfHyaqBz7=Usme_2jxuw@mail.gmail.com> <CANn89iJ+WXUcXna+s6eVh=-HJf2ExsdLTkXV=CTww9syR2KGVg@mail.gmail.com>
In-Reply-To: <CANn89iJ+WXUcXna+s6eVh=-HJf2ExsdLTkXV=CTww9syR2KGVg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 14:41:53 +0200
Message-ID: <CANn89iLUQ1DsBd_nemdhcgfvc_ybQmM_sGwWLwzeyOW+5C2KnA@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu skb_attempt_defer_free
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:38=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:

> There are false positives at this moment whenever frag_list are used in r=
x skbs.
>
> (Small MAX_SKB_FRAGS, small MTU, big GRO size)

 perf record -a -g -e skb:kfree_skb sleep 1
[ perf record: Woken up 84 times to write data ]
[ perf record: Captured and wrote 21.594 MB perf.data (95653 samples) ]

perf script

netserver 43113 [051] 2053323.508683: skb:kfree_skb:
skbaddr=3D0xffff8d699e0b8f00 protocol=3D34525 location=3Dskb_release_data
reason: NOT_SPECIFIED
            7fffa5bcadb8 kfree_skb_list_reason ([kernel.kallsyms])
            7fffa5bcadb8 kfree_skb_list_reason ([kernel.kallsyms])
            7fffa5bcb7b8 skb_release_data ([kernel.kallsyms])
            7fffa5bcaa5f __kfree_skb ([kernel.kallsyms])
            7fffa5bd7099 skb_attempt_defer_free ([kernel.kallsyms])
            7fffa5ce81fa tcp_recvmsg_locked ([kernel.kallsyms])
            7fffa5ce7cf9 tcp_recvmsg ([kernel.kallsyms])
            7fffa5dac407 inet6_recvmsg ([kernel.kallsyms])
            7fffa5bb9bc2 sock_recvmsg ([kernel.kallsyms])
            7fffa5bbbc8b __sys_recvfrom ([kernel.kallsyms])
            7fffa5bbbd3a __x64_sys_recvfrom ([kernel.kallsyms])
            7fffa5eeb367 do_syscall_64 ([kernel.kallsyms])
            7fffa600312a entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                  1220d2 __libc_recv (/usr/grte/v3/lib64/libc-2.15.so)

