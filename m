Return-Path: <netdev+bounces-72185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD7856E38
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40791C23B82
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87F13AA3F;
	Thu, 15 Feb 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsbxfWvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180813AA3D
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027078; cv=none; b=l6DZriEH9w7ynx/B8aYhUMcGNs8dPujqgO6mELVXfA6HPbOCZGoXmzlNidJGPCinYW5p3ys2F86/n3jWMtNUgEky5X5oulWNodSzYq3cZ4A5mbCWYoYxJKiXvk7hqHeix6iP0D5gkuANU3qKCd/g2xhu3usf+IiJER96Zf+rMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027078; c=relaxed/simple;
	bh=Dn/+lUnm+Dskc6cxU48td2b9NBJKmAVPJGzAU7aARwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txNRrLG54Ptiu1LjuABDUefkwkGQCOTZ8GA4V3ry5KGcHE2BnNweMbCbI1f0sLEIh1rBk8uOGdThi0yuRD6VspIbY2Rz1T8110L5qaTZmeg6w87evjxmaS7D2aN/U2Lm2buxbMVav1otXlS2Zlownly+4c+i1A2FJak3U+ZHAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsbxfWvq; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-46d3b3e0671so97100137.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708027076; x=1708631876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGZwULsr7/JZu7+F4XUfP0xvOqUtS8xAVSixm8qqZe8=;
        b=VsbxfWvqR4hfIefKtwAAF5xUnlM0FDFTCrGKX42BQV1sFDOPyFQytGnxmAA7x7ntGM
         V9JbFkDPLt+uzj9Ov4o5vAUTgoVPZVaoJPzJKePYJjUtuz9E671MP5Nji+7hgxo81V0J
         dvEVqKqI+GbdMn4GzMOyBUHOU1P2l2SiHDjpqI3F/uVzCJ/8yRSarvHdJM58sOZkMj3a
         ST9DVgZBysl3OPivwainoSsdb4Ox6lN8jvEA7/DpvAagWS0eh7LzUouDGoTJuAJJFBrz
         r9ERWqhckfPmY1lcv8PGabvFUIaEWb1k4bZd8hye4DJxnhKOxnMusjhlnR9fAIbdrCeD
         bqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027076; x=1708631876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGZwULsr7/JZu7+F4XUfP0xvOqUtS8xAVSixm8qqZe8=;
        b=dK7nXN9QdcZK3r1FxrKhVBlVI79N8rrn8FUQ7wqW0yul666rtNxl0inY38DqjKjJoN
         vGTFbxt8a8ru0tiqrGWKR10Pu7aUdo3Lp+p5qIIFEyIgLeTv8DBkWEctwgWzFpfRkOC4
         hR2OxG31fQDxpM0Q4EYAjXdzKMWag2IACw2MBzsa21o2T98U2F5jaBO0zemfN8vybZBw
         H6YxBqAqWSXnmOVokC8jOCnctzSM+kQwd9Tce/UwJ57UU1850gUWNIhJg74gMwLGHh2H
         xpWWW1vJOyLv1TROUoapogiaNsPEtU761MTJz8wlw59twJBRIVUUaZJmw1bzocv24E+k
         fGtg==
X-Forwarded-Encrypted: i=1; AJvYcCWotkdaqm80IU7HTOvG59oZ9BTnbxhe6Th4TO1MLCMLzBMP9j+kM5Kb6hOWL2vacXUbFJjqEedpGn+9U/XTZQbyHVEs6ODm
X-Gm-Message-State: AOJu0YwWEbkgSshpSCq94eV1TD8B2044EeshvrjEnUEHVxS5D4EvQIg3
	ZFy+108LCYJeYtQ7ez8fc4JtOUtEMxxzY/LtTXpzegWDTrnzskX0ZoqOTX6YKZIMBMPZuyp3a/O
	YjuJOTGpF8R2NAk4uxv79raYrOdKQJ4OO5leT
X-Google-Smtp-Source: AGHT+IH+qNqeabpjX+fGInAxnMg+7mbZ/vsNhCFlI7FcTykt+Vs1sE0er6JySes2o0SSUf1NKP0g0rU7xeoAR0Cy75U=
X-Received: by 2002:a05:6102:5f58:b0:46e:ba1f:a754 with SMTP id
 il24-20020a0561025f5800b0046eba1fa754mr2636446vsb.12.1708027075782; Thu, 15
 Feb 2024 11:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213223135.85957-1-kuniyu@amazon.com>
In-Reply-To: <20240213223135.85957-1-kuniyu@amazon.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 Feb 2024 12:57:35 -0700
Message-ID: <CADVnQykqkpNTfO30_aswZEaeSkdu5YNuKag++h-RSguALdeohw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-s390@vger.kernel.org, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Rick Jones <jonesrick@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> remove SOCK_DEBUG macro") removed the macro.
>
> Now is the time to deprecate the oldest socket option.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

I would like to kindly implore you to please not remove the
functionality of the SO_DEBUG socket option. This socket option is a
key mechanism that the Google TCP team uses for automated testing of
Linux TCP, including BBR congestion control.

Widely used tools like netperf allow users to enable the SO_DEBUG
socket option via the command line (-g in netperf). Then debugging
code in the kernel can use the SOCK_DBG bit to decide whether to take
special actions, such as logging debug information, which can be used
to generate graphs or assertions about correct internal behavior. For
example, the transperf network testing tool that our team open-sourced
- https://github.com/google/transperf - uses the netperf -g/SO_DEBUG
mechanism to trigger debug logging that we use for testing,
troubleshooting, analysis, and development.

The SO_DEBUG mechanism is nice in that it works well no matter what
policy an application or benchmarking tool uses for choosing other
attributes (like port numbers) that could conceivably be used to point
out connections that should receive debug treatment. For example, most
benchmarking or production workloads will effectively end up with
random port numbers, which makes port numbers hard to use  for
triggering debug treatment.

This mechanism is very simple and battle-tested, it works well, and
IMHO it would be a tragedy to remove it. It would cause our team
meaningful headaches to replace it. Please keep the SO_DEBUG socket
option functionality as-is. :-)

Thanks for your consideration on this!

Best regards,
neal

