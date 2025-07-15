Return-Path: <netdev+bounces-207181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E846B061ED
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCCB5044B1
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B441E5710;
	Tue, 15 Jul 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiqR77ez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDB1E834F
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590912; cv=none; b=fEIfOqdp65U96UwyCKpTWRvwW8Kla6cwsT3TfiHFBhZAJsQb6aS/gzC+MNtdD251cNf4+WxJqnb55+rPdgbs/WsV3JLgfMfVHQFqHbEw3dZeOoVThmNjzGQWZrG55YSfX4vXCsd9CHAEZIW49efKoqIspgMyPPrg4vCmdRmITag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590912; c=relaxed/simple;
	bh=kjd8J1QyRSMxi2R5UYVWN/B388GsbuobvrFO4L751dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atoLcoaUNYB+eC/9467d35jC70yVawNoYDugID1aJFqKTIxrr8D4/x4QMBw3oMsHPlzPbuhbXSV1L9p7Exj7nXnAcd9EgEcdBXn+y5ZZySMwa7ajQyG3Ab0WgMqXEmEJAR78X2fUFR5uvIQdL9h5Kzkc/74HQMstR3WqTd2AswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aiqR77ez; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso4564623a91.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752590910; x=1753195710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LXCe7vXC3cVdnINUzgQ6yl9HtA003N86C/8zvLxE1U=;
        b=aiqR77ezIS5wk9xSLONhHgATC8wsoXsBFlTmV/OIysPBK9vkW7ofhJq+7+MkahE942
         jCaLPgL4KV5Rp7V83HsncFrZ/ZlD7rjX0n1PnlkREUi8Ux4vGiWhAHZQDuEqgKsDMvnW
         3ySrudt0cckYaOYtTZ+/hltkAUeXWaEsNAUX+XyRj0clTxJjJW3A8aSR2oBlqBFesonf
         7ImmATm/olIj11tq/69VNCQqj7rA1gPwstE3LsYHPgdpoLOJppjbhrNWkg/eAiBmc4KR
         IvyXoTp0OG0RvnUOG87TTSTlctdgpbe6zi+kKfYIrNQ/Bd5CqIFZS/9FaVpAlNxA2IMZ
         EIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752590910; x=1753195710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LXCe7vXC3cVdnINUzgQ6yl9HtA003N86C/8zvLxE1U=;
        b=w3myanN36NtQpcYLNucMuMzkH6g6pEfut1aelm7JP91JqFVWpeDqzyH/RJzTkb8zBn
         2ozbP61lEJFzw5csoXfz6F5HHo2DKkTlsxdh/IW7eUrrHIFbb46DzNkjYDnmBIiCuFKI
         EDfqyFJA74+lr6eKYLs8zY0jPjaxS3az7ORbZiA4xbq7iNO7Sv5NR2tzoG/6qEIN5Hct
         WtB3NZG77AY1Nzo1j7uWyzpvyRiP8Dvtk5hzbMUcjDsCwQmu2eS/+ZUBgOuMXPscWbXZ
         hhGfekIfzA+JLwsCPZbcJnFMKep+U8V5iciqbz5LdWrQ+OnIL73wLWbigB79AB4/Gj5N
         lT0g==
X-Forwarded-Encrypted: i=1; AJvYcCXsABZipcgLkEV+lQ8fOn3K26GxavleJ56Eapnfcwx4hI0Z21fKV58C/XWGEmjp3d1Y9HDknOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYUQqzr2NHzsW/zhKIkhQeHZIFt0GDqhkG8KI3bXrWdmP/Lhn
	Tp42fAXCoGv0bnm08jSwZb4gwP817hbXJadLp1sYC1XO9OlWW5xpzM4wm1KF+isOICBlEdSjAeC
	ODpWNAWYA61jXDK4gN6ibw9AH8+uNuePigZoLEBJ2
X-Gm-Gg: ASbGncuRFrXSQvEFFr2NnGX7XQHZrPyqjnKddQqfM2bym8EcLH/5xqs2JV5Se1q5y/V
	sUAGI2KTb5IZmXQgknOr2hPEymcJFARcBeqbDar2KtOiSWWf5wHTp9ybimSSgfBBubi2sbW+vBA
	9ifGcM49TYfZ/d1EcQGiJOg0s4kpO2LWe01MTEUwJvWbuhkLZ6Cb6WhzLKEf/M5zQkJfJGCJ/ii
	c1LTifqZxaWfI6WsHKRJmhNJBwjsjsMRBE83yKx
X-Google-Smtp-Source: AGHT+IFDRkChtqk+Qk99sapmg4o/969rKL7xNz4Wu2Y9pXnB1qsuKf4Nxc128zz7KdoGKg8uBmWSMCXnL5A8NmQPBLY=
X-Received: by 2002:a17:90b:3c0e:b0:312:f0d0:bc4 with SMTP id
 98e67ed59e1d1-31c4f48b7a4mr25080785a91.5.1752590910099; Tue, 15 Jul 2025
 07:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com>
 <d0fea525-5488-48b7-9f88-f6892b5954bf@kernel.org> <6a599379-1eb5-41c2-84fc-eb6fde36d3ba@redhat.com>
 <20250715062829.0408857d@kernel.org> <20250715063314.43a993f9@kernel.org>
In-Reply-To: <20250715063314.43a993f9@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 15 Jul 2025 07:48:18 -0700
X-Gm-Features: Ac12FXzb7-nCxc0fVesO3CBBEjuPjyHIwdpGBx78tGP28W3eEECJYo0RpeIs-NY
Message-ID: <CAAVpQUBt7SWEz0gtZD2NkjRvHj6qmYij=mcW0G3+Qxgg53zv4A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 15 Jul 2025 06:28:29 -0700 Jakub Kicinski wrote:
> > # (null):17: error handling packet: timing error: expected outbound pac=
ket at 0.074144 sec but happened at -1752585909.757339 sec; tolerance 0.004=
000 sec
> > # script packet:  0.074144 S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
> > # actual packet: -1752585909.757339 S.0 0:0(0) ack 1 <mss 1460,nop,wsca=
le 0>
>
> This is definitely compiler related, I rebuilt with clang and the build
> error goes away. Now I get a more sane failure:
>
> # tcp_rcv_big_endseq.pkt:41: error handling packet: timing error: expecte=
d outbound packet at 1.230105 sec but happened at 1.190101 sec; tolerance 0=
.005046 sec
> # script packet:  1.230105 . 1:1(0) ack 54001 win 0
> # actual packet:  1.190101 . 1:1(0) ack 54001 win 0
>
> $ gcc --version
> gcc (GCC) 15.1.1 20250521 (Red Hat 15.1.1-2)
>
> I don't understand why the ack is supposed to be delayed, should we
> just do this? (I think Eric is OOO, FWIW)
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.p=
kt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> index 7e170b94fd36..3848b419e68c 100644
> --- a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> @@ -38,7 +38,7 @@
>
>  // If queue is empty, accept a packet even if its end_seq is above wup +=
 rcv_wnd
>    +0 < P. 4001:54001(50000) ack 1 win 257
> -  +.040 > .  1:1(0) ack 54001 win 0
> +  +0 > .  1:1(0) ack 54001 win 0
>
>  // Check LINUX_MIB_BEYOND_WINDOW has been incremented 3 times.
>  +0 `nstat | grep TcpExtBeyondWindow | grep -q " 3 "`

I remember I didn't see this error just after the commit that added the tes=
t,
and now I see the failure after commit 1d2fbaad7cd8c ("tcp: stronger
sk_rcvbuf checks").

[root@fedora packetdrill]# uname -r
6.16.0-rc5-01431-g75dff0584cce
[root@fedora packetdrill]# ./ksft_runner.sh tcp_rcv_big_endseq.pkt
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

[root@fedora packetdrill]# uname -r
6.16.0-rc5-01432-g1d2fbaad7cd8
[root@fedora packetdrill]# ./ksft_runner.sh tcp_rcv_big_endseq.pkt
TAP version 13
1..2
tcp_rcv_big_endseq.pkt:41: error handling packet: timing error:
expected outbound packet at 1.148682 sec but happened at 1.108681 sec;
tolerance 0.005005 sec
script packet:  1.148682 . 1:1(0) ack 54001 win 0
actual packet:  1.108681 . 1:1(0) ack 54001 win 0
not ok 1 ipv4
tcp_rcv_big_endseq.pkt:41: error handling packet: timing error:
expected outbound packet at 1.146130 sec but happened at 1.106130 sec;
tolerance 0.005005 sec
script packet:  1.146130 . 1:1(0) ack 54001 win 0
actual packet:  1.106130 . 1:1(0) ack 54001 win 0
not ok 2 ipv6
# Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0


On 75dff0584cce, the test failed if I removed the delay.
I haven't checked where it comes from, but probably that's
why Eric added the delay ?

[root@fedora packetdrill]# ./ksft_runner.sh tcp_rcv_big_endseq.pkt
TAP version 13
1..2
tcp_rcv_big_endseq.pkt:41: error handling packet: timing error:
expected outbound packet at 1.105941 sec but happened at 1.146774 sec;
tolerance 0.004000 sec
script packet:  1.105941 . 1:1(0) ack 54001 win 0
actual packet:  1.146774 . 1:1(0) ack 54001 win 0
not ok 1 ipv4
tcp_rcv_big_endseq.pkt:41: error handling packet: timing error:
expected outbound packet at 1.106215 sec but happened at 1.146815 sec;
tolerance 0.004000 sec
script packet:  1.106215 . 1:1(0) ack 54001 win 0
actual packet:  1.146815 . 1:1(0) ack 54001 win 0

not ok 2 ipv6
# Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0

