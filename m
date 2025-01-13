Return-Path: <netdev+bounces-157888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587CA0C2BE
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F48616834D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FA71CEAAC;
	Mon, 13 Jan 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ike3IMQ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B11C9B62
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801310; cv=none; b=WwvJkiv2wEr+lCpVdiiTQRgxoeoW6Jbvb2W8I8dxKooCXbOHxa2IdiMudMN02JpUKHK3mOiafrrIkCftMSwnvwAkaCcsOw5Ty9KvbYa9SFxjOZ90sr8eA8mUQ3s7j4TfpqD7A3OD1atFIWdlrD0t3yz6gRAN6WNqw0qGbfUzjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801310; c=relaxed/simple;
	bh=90zcy6qhbSgU8cmRVjafWRdr0cYIUm4MqsbDWeQxGHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJO+7YT6d3eiGjlUROv5RrT8XU3EA6LeSbAS2BkfLprz5/Qw2Lskpj9HLRbPta8O1j7EbNYuepLyb0U4pijrKVmxqJ5GeIP9cSIsPdoYCESviiM7XGwHJjt1aEbgV6x+RtqnfxYzTO3PmOdLnPcwwO8cFc0ByVmhWYcJaTqXp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ike3IMQ6; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=90zcy6qhbSgU8cmRVjafWRdr0cYIUm4MqsbDWeQxGHo=; t=1736801308; x=1737665308; 
	b=ike3IMQ6zqCXcSfQFsYqQkp8L4EMM7AXZfDISbxfz1m1rJyL0D1tD1LVYZXWsdZfGHn6HkLuq8c
	WNYH1JOkckRi7r4cNzeZX8e0Jwcf7rPoVTdNbadwiROo/6AyKM19ORypS9PoEUgooP3Jb/r7qntcD
	GYJxZWVideodVpqOztMJQkbuOzU+u9QQMOpA6GsoA+FlWH5bPckJnThCilbTHYy+xfEAgTxx4qkk9
	W7cqtIwefXgEJCso7vgd/FunRl0EGuRjXTrph+gxd7TsGGJyC7gGsKSFK3o6d/4OZBwftw1tJxQOX
	q2EGRfTmlSuqIkkHcrvv0sSmiYkM2UOf/AUg==;
Received: from mail-oo1-f46.google.com ([209.85.161.46]:60640)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tXRMH-0002VE-SS
	for netdev@vger.kernel.org; Mon, 13 Jan 2025 12:48:27 -0800
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f33ad7d6faso3370852eaf.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:48:25 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8zSoSYHVXqyc08ZWt+PIkmb+qVHQdA61MurnLJpdZQncS9eMZ
	ysyKnMlO2J5usAXQdn2TMC5q5+cVN6Euxvo5HXGzqh6Y998AyhFOcLjZdihPAi336+vOl/7kOPV
	e2WgzGOT0/0hthxIN0lAdxVQDPdA=
X-Google-Smtp-Source: AGHT+IGc5DOuVszfphTiq5xBX/ZOxbHPsP38qqq0RaUuBcXGN0yl2Bshh7QNmYBBEMMz/+P+EVojy7oBXgAB/gU1PNs=
X-Received: by 2002:a05:6870:2f0b:b0:29e:5e7b:dc0f with SMTP id
 586e51a60fabf-2aa06998858mr11968128fac.38.1736801305307; Mon, 13 Jan 2025
 12:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <CAGXJAmxyNRfJp9UemEdVpxegf1bnK5eBMYe5etmUoS-kZd98vg@mail.gmail.com>
 <24e75641-ad78-4ceb-a42a-c61c1ea5b367@lunn.ch>
In-Reply-To: <24e75641-ad78-4ceb-a42a-c61c1ea5b367@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 13 Jan 2025 12:47:48 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxKsVwJ3Ty0jhQ3s5geOMD1WWBhBQK-9DcnH519xUV3Hg@mail.gmail.com>
X-Gm-Features: AbW1kvY1qK32DYm_7_pIlS8wJGH0YBIKTxaBDh9ZIXnCAmlG69mkBD03wn0gpWc
Message-ID: <CAGXJAmxKsVwJ3Ty0jhQ3s5geOMD1WWBhBQK-9DcnH519xUV3Hg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/12] Begin upstreaming Homa transport protocol
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 1.7
X-Spam-Level: *
X-Scan-Signature: 67f4a389e065da33eb5969ecb4726704

On Mon, Jan 13, 2025 at 12:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Mon, Jan 13, 2025 at 09:27:34AM -0800, John Ousterhout wrote:
> > The Patchwork Web page for this patch set
> > (https://patchwork.kernel.org/project/netdevbpf/list/?series=3D922654&s=
tate=3D*)
> > is showing errors for the "netdev/contest" context for each of the
> > patches in the series. The errors are the same for each patch, and
> > they seem to be coming from places other than Homa.
>
> Hi John
>
> The tests take too long to run for each patchset, so i _think_ all
> patches in a 3 hour window are tested in a batch. So it could well be
> some other patchset in the batch broke something.
>
> You should be able to run the test yourself, on your own build.
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/937341/60-bpf-offl=
oad-py/stdout
> shows you the command line. However, the test environment, what tools
> you need installed etc, is less clear.
>
> To me, it does seem unlikely that HOMA would cause:
>
> cat: /sys/kernel/debug/netdevsim/netdevsim20347//ports/0//queue_reset:
> Invalid argument
>
> So i would not worry about it too much. However, if the next
> submission has the same issues....

Thanks for the information; I'll take your advice and see if the
problem goes away with the next submission.

-John-

