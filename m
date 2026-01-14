Return-Path: <netdev+bounces-249853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8674DD1F7B7
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E912C300DA69
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D02C2D94BB;
	Wed, 14 Jan 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nepQYUb0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CD22B5A5
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401167; cv=none; b=isV5x3MO/5OfmZga7RpwF5uLhbgerPbLQw2uJJ0gPgIwn0fYwGOSl7yXv395ms6NzoqsXgDqccXyMp+dfnjxN9PqChtZBAfdUoq2DPcyqq4ZAogpbFCOYGyOwABkkQQ3wrcCbQxo9Fc8NW6DdgOBy5B3Cwib4/JiuWWyyG0KFW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401167; c=relaxed/simple;
	bh=qQZhH/MEd3fGN4OPOWdeUBdYa+XsJhkaROihpCPQY28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMAsmTtzl36sB05p9ouM3rkJcFvLqL0c9xZbFbRrzUg0ly/CC6vuPPMpmfh13SlcGV3UD7xSjPHLXRMTq6Qn3sjUYnKWAjrwpcrsDNmX2VmlesedIfTNFoeccie7TrkRjiO7orMmNA/S+ElalfOVBB3DwdT6KQHDKxJPQ5/qFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nepQYUb0; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ed0b816d76so2546359137.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768401165; x=1769005965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvjffxgxOPgzQu5IYkugYM5RZ08ODCAjHZ4DzEhZhjc=;
        b=nepQYUb0XbKi9hZkEYKMfcEYmJHA+rNl3MmgXpbSHMoj4EhriS7gNhiborF4z5FymV
         D9389WyJVFi1eG5s+NaU/gatJItVb5e8g3SPk03gG276laWyzK5L28RnQlErnmNeNqtL
         OHf+oiu1h1XeYCpGPiaugFWxxepxJ/EQZhrcXPfN1HLb3xRzONIduYLLDvDQCDPuQXhQ
         VUXWLHoe/JgJv4RmNk+T2Q057iLerF3McLZPyRMVS92nGAeS8aiTa3hGWUPqcO/HvbPM
         Y5VGwEm1CrCEXhF88jSb+zEua0voKjEW4ZU/RLFcsiOKXx0RR2/fQu3Etf5Uyfwffxi6
         tOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768401165; x=1769005965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvjffxgxOPgzQu5IYkugYM5RZ08ODCAjHZ4DzEhZhjc=;
        b=aIMy4gecsu0tCGY9IChmkPOdbScyo4t/091M5zm7DZgxUAo6AmyoaYexHw8eBOd3Tp
         XC9UIhQZWVcaWJrTIwjI1jfMMx1pWIMUHDlR7sncB0enXZTVcwRWKq81CIKI1l6TxEHV
         3U79Jhvs8eTJknafkOEMZ1GHvzblW0vJKwLuBFjjuO5DAP+1S8T6UCye99idtoFCwVSA
         lhrHiPs/CKz46quELL3Ofuz6tuGae7pfFgT8um/NUnZvu4S7ykocBCn7H+VkhsCu+G/q
         vU6DYoQQ97HM7r3C32wmr3ti1/78S8lV9jmsWpEOQ+4eEBm9Rm7PiUTsJwwgZMNYNapu
         G3kA==
X-Gm-Message-State: AOJu0Yy224WkFmPctOfYVwntRlUzhQnx4B05IfeanpT7prLIvQMri8rq
	jchbjw1K4RLHprQAdyRrtXwJQ8mBhH/vLc9vgXCGUXJ/5hwopHM09TJXWqNWE+KhXXsbOI1wdkv
	8YwmRxelAuskIdtubtBkLEM4AnA2VX7Tdbg==
X-Gm-Gg: AY/fxX5dzzb6ux3fVmBFwMrcUTuS95WjfyU9Hsen8SdCeqHBf0jH+Z2r692D/e8guU9
	AgQrnsq56X/Y37PoS4N4PCsLXpGCewShr2fiJaLYLKXRNAXAgr3zoyvRrbve2NsIp7nwvNKcsDP
	J56Of4nLlxz7UDks6csCVdbf1UsrIc/XNLT9BxWOWnaxPMcbeeDxsRVgH1TY3wJ5v0kfdg+V2bF
	4Lkxd6oRkcgNsqTAAA19ik0oKUBv5Vx/sYcEOAluKC7WPKTsQ/E9Q2lqCACXL+j0Ydphq/2kRIF
	60hwqP3TmAQFQhFOqLDzarL2OzqfthzqsVaNNA==
X-Received: by 2002:a05:6102:644b:b0:5ef:a6e8:3143 with SMTP id
 ada2fe7eead31-5f17f66a78bmr945744137.37.1768401164578; Wed, 14 Jan 2026
 06:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFfO_h5k7n7pJrSimuUaexwbMh9s+f0_n6jJ0TX4=+ywQyUaeg@mail.gmail.com>
In-Reply-To: <CAFfO_h5k7n7pJrSimuUaexwbMh9s+f0_n6jJ0TX4=+ywQyUaeg@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 14 Jan 2026 20:32:33 +0600
X-Gm-Features: AZwV_QidMrcVw-ipAMGaK0viTl8ZeetGlhjStdWzMSy3wtTrxR0xKQYf_48ndhY
Message-ID: <CAFfO_h6bLS5vc8YUBnFffk2hS4Oj9MK7EdEyCA__5KWMqyqAPg@mail.gmail.com>
Subject: Re: Question about timeout bug in recvmmsg
To: netdev@vger.kernel.org
Cc: "edumazet@google.com" <edumazet@google.com>, kuniyu@google.com, pabeni@redhat.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Gentle ping regarding this request. I would really appreciate some
input on this. Thank you!

Regards,
Dorjoy

On Thu, Jan 8, 2026 at 12:39=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Hi,
> Hope everyone is doing well. I came upon this timeout bug in the
> recvmmsg system call from this URL:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D75371 . I am not familiar
> with the linux kernel code. I thought it would be a good idea to try
> to fix it and as a side effect I can get to know the code a bit
> better. As far as I can see, the system call eventually goes through
> the do_recvmmsg function in the net/socket.c file. There is a while
> loop that checks for timeout after the call to ___sys_recvmmsg(...).
> So this probably is still a bug where if the socket was not configured
> with any SO_RCVTIMEO (i.e., sk_rcvtimeo in struct sock), the call can
> block indefinitely. Is this considered something that should ideally
> be fixed?
>
> If this is something that should be fixed, I can try to take a look
> into it. I have tried to follow the codepath a bit and from what I
> understand, if we keep following the main function calls i.e.,
> do_recvmmsg, ___sys_recvmmsg ... we eventually reach
> tcp_recvmsg_locked function in net/ipv4/tcp.c (there are of course
> other ipv6, udp code paths as well). In this function, the timeo
> variable represents the timeout I think and it gets the timeout value
> from the sock_rcvtimeo function. I think this is where we need to use
> the smaller one between sk_rcvtimeo and the remaining timeout
> (converted to 'long' from struct timespec) from the recvmmsg call (we
> need to consider the case of timeout values 0 here of course). It
> probably would have been easier if we could add a new member in struct
> sock after sk_rcvtimeo, that way the change would only have to be in
> sock_rcvtimeo function implementation. But this new timeout  value
> from the recvmmsg call probably doesn't make sense to be part of
> struct sock. So we need to pass this remaining timeout from
> do_recvmmsg all the way to tcp_recvmsg_locked (and similar other
> places) and do the check for smaller between the passed parameter and
> return value from sock_rcvtimeo function. As we need to pass a new
> timeout parameter anyway, it probably then makes sense to move the
> sock_rcvtimeo call all the way up the call chain to do_recvmmsg and
> compare and send the finalized timeout value to the function calls
> upto tcp_recvmsg_locked, right?
>
> I would really appreciate any suggestion about this issue so that I
> can try to fix it. Thank you!
>
> Regards,
> Dorjoy

