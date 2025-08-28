Return-Path: <netdev+bounces-217592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF081B39222
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 05:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DA2167361
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF613957E;
	Thu, 28 Aug 2025 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTQs7YIi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECC30CD94
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756350973; cv=none; b=Rr8gwKzQVQ7XJJE/9cFTzHsSHHpkGv5rk/XTAoEkZSistUFIeDYulHShCXNF5ow1ChIbv1BVi+/V5y8Yc0lX2QuWK84FGwBkgJGdUTl+8/GZIZ6rFxtRdmJFlZnOFmHiJD7qVdpKmEWVT5Hi2rUfeALg7JXG+fwL31C6A+qxo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756350973; c=relaxed/simple;
	bh=oRXQYKOz9nqKFjkx6A8LVNPu+/dLXmMO/MocSUnjrz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+GSxvKuvbadtNUCkYyGomhIWJBWSwwHzPvYDP5X1Vc+xwnP9OvJZv1ejvgi831MzBXW5/jhDqRJ+8z901+9W/qY+WBVEkA/7x/uocRwDO89XUkrp/7wQ3u14AT4vU80QCb3CHUHmsgZqWsi5m6l6M1d5NwUKQWPON3aVA0FrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTQs7YIi; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b1099192b0so9509721cf.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756350970; x=1756955770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRXQYKOz9nqKFjkx6A8LVNPu+/dLXmMO/MocSUnjrz8=;
        b=GTQs7YIiExQGe3ONjw8AHabOGpEJeJpWAuU/KSSxfUJAg3TaXAYNCAtQOPtPHYU5cs
         zk1aXrma3mwSLH4S9O6DGVOtB1fQ5IDsXHYPgFygFeu+KkB2wbThtBER+9om1enYnBcZ
         5Twle3cqqfdPRKoK9Xyv2Y/M8Y6Gl+pHqXlTfF+TvPzZhmOYQgy7hOxJReKQFhBi3zvi
         cLtHyrHvcYb99tYcSM6YXx1zOMaENW4yMCdj5fYIQuRsQvPzFTeWnqiZr8qvE7BnEeND
         7s7j+j7Gap0kh2rQD11kAL6qdW1LT+et781eDqYwfubJOkCwD2+mSBtzh3GPh0gKLiC7
         hKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756350970; x=1756955770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRXQYKOz9nqKFjkx6A8LVNPu+/dLXmMO/MocSUnjrz8=;
        b=tTllnbJHFQ0iwtsvgWajp2BzIzwG7615ONCxaP6HRhDgQ+Uao8Q8Ftf1Q1752RDyiV
         gYk0hGx0rvHZhD/uEU16/yaphaaQRZZsFUTn7LZok4VKQyJ6IC9yoplrKCWDlnCR+hk5
         A+oKNnTwd3HQFWa/tyP/yjNlHdp2wmfd3z6fWvsvkNuABEPsWHSAbxvV4GMCzLlWqWkp
         dTAYLK2G8O1+8Xpn+C8m0wVvn3n7vU4SLZrIShspbpQ9n4Iy5cpUc812BB7gt+RtpSIi
         2tLJZLF1yq2q0mDjMqoYFwWak6bY3fpgg2TUGJb9IXgxbYyQTSUYZJeGtd01KBjKS2Cu
         86cA==
X-Gm-Message-State: AOJu0Yy0t6kfvLh4q42i+8TI52T2jHjF67dq/IntFi8DLmqj6nK5Jpjn
	FzwSR7JEEHI/n3Vu4suvDlupeyAOuXvBoaWe9RlPL5oR3kDSuf90XD5kROxkVQqecMVmCR/Qzb3
	3sMak21rG2zeq1dRB9K6C2tbb1xPpJjkMJzrRxnwB
X-Gm-Gg: ASbGncuNyJWA8+pgGmLVgB0hnsT4I7RBKBsWC7HH/muStNepc/01HWJ6iuGl+ckgC4p
	eniMih6JY/3A+pX5N2YCTxClX8W5wprrJF2G2CAnmFPeLCfqifwV6nFok/rgVtndKPF91ks6vcz
	9XLXmzFKj66x7zZob4GidlEVxBBaT+XGSjGQ+fdX7QDXsVQA1Q3iAEkDzhJzPiADjUyaT7JCPxL
	pzzxphzRZOZM5Ux/6lIDg==
X-Google-Smtp-Source: AGHT+IHwQa/ppt6xLE/qP3WHHS2SKWlyv/2GZolNQ9dkZ9z4fK6hLvSk5PzJLy602g7YUl7kwE0VYbUiUooOTnwmbTM=
X-Received: by 2002:ac8:7f47:0:b0:4b2:fa4b:e097 with SMTP id
 d75a77b69052e-4b2fa4be31cmr39605921cf.78.1756350970097; Wed, 27 Aug 2025
 20:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DS0PR11MB77685D8DB5CEACC52391D4E6FD3BA@DS0PR11MB7768.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB77685D8DB5CEACC52391D4E6FD3BA@DS0PR11MB7768.namprd11.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Aug 2025 20:15:59 -0700
X-Gm-Features: Ac12FXz3sWqf2vQe4xAJC4c5TkYVBWA7crbYou1dAMI7CjMFjatVcUBZlKn54lI
Message-ID: <CANn89iJJkpSPMeK7PFH6Hrs=0Hw3Np1haR-+6GOhPwmvsq9x5Q@mail.gmail.com>
Subject: Re: [BUG] TCP: Duplicate ACK storm after reordering with delayed
 packet (BBR RTO triggered)
To: "Ahmed, Shehab Sarar" <shehaba2@illinois.edu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"kuniyu@google.com" <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:12=E2=80=AFPM Ahmed, Shehab Sarar
<shehaba2@illinois.edu> wrote:
>
> Hello,
>
> I am a PhD student doing research on adversarial testing of different TCP=
 protocols. Recently, I found an interesting behavior of TCP that I am desc=
ribing below:
>
> The network RTT was high for about a second before it was abruptly reduce=
d. Some packets sent during the high RTT phase experienced long delays in r=
eaching the destination, while later packets, benefiting from the lower RTT=
, arrived earlier. This out-of-order arrival triggered the receiver to gene=
rate duplicate acknowledgments (dup ACKs). Due to the low RTT, these dup AC=
Ks quickly reached the sender. Upon receiving three dup ACKs, the sender in=
itiated a fast retransmission for an earlier packet that was not lost but w=
as simply taking longer to arrive. Interestingly, despite the fast-retransm=
itted packet experienced a lower RTT, the original delayed packet still arr=
ived first. When the receiver received this packet, it sent an ACK for the =
next packet in sequence. However, upon later receiving the fast-retransmitt=
ed packet, an issue arose in its logic for updating the acknowledgment numb=
er. As a result, even after the next expected packet was received, the ackn=
owledgment number was not updated correctly. The receiver continued sending=
 dup ACKs, ultimately forcing the congestion control protocol into the retr=
ansmission timeout (RTO) phase.
>
> I experienced this behavior in linux kernel 5.4.230 version and was wonde=
ring if the same issue persists in the recent-most kernel. Do you know of a=
ny commit that addressed this issue? If not, I am highly enthusiastic to in=
vestigate further. My suspicion is that the problem lies in tcp_input.c. I =
will be eagerly waiting for your reply.

I really wonder why anyone would do any research on v5.4.230, a more
than 2 years old kernel, clearly unsupported.

I suggest you write a packetdrill test to exhibit the issue, then run
a reverse bisection to find the commit fixing it (assuming recent
kernels are fixed).

There are about 8200 patches between v5.4.230 and v5.4.296, a
bisection should be fast.

>
> Thanks
> Shehab

