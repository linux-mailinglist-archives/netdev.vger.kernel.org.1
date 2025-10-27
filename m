Return-Path: <netdev+bounces-233222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E5C0EE15
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99B3465A2C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7062C324E;
	Mon, 27 Oct 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="io+ZDnGE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40314749C
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577681; cv=none; b=ZJvJu/a6k3oSKB0thrPWAB5rlZiP3BWsIYnH5sEYhPQ9/+pc/sZpjH5lBe3vfwkSOH5oNZj1vbHV6vozPYoPXxf2CG0p6SAORMFRRcYlznsQOzUXcObEkDd/t5dNIc0fmqrISPOI9PMdHZ3YovGKxDwZ61rFtrsmcJq72yU67do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577681; c=relaxed/simple;
	bh=Hj0l0j5fI+kXzEXNngd9fmM+TUubJmytvIAHFMvoWdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkG6fKrzYOBaOp0EIvP8ToG/6iARf6GFKowk4EqumuA563BjUjIYLG3xNzVLQ6294W8MtFlTb7YXUrsAEcAF6uzgmWd0aoMgbrRYPtmKcX97nw12GsUf0f8USSRizr7cgJinZmFmNXn1mmJIGFjSpfJMbbKqaw01whUUiii/I1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=io+ZDnGE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ecfd66059eso223191cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761577679; x=1762182479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFmNRNpiYRbSyKjivx5b46rxwRPMOYECqNZ5ldemnk4=;
        b=io+ZDnGE8DzB6jBf8IrNiggYJVzU+ivn0hd8no3mx0BSFH6yjcRj7JouWB9s8xRAKQ
         C/YzB0yf2pSHtm3Jj03nChPY3fxE0JiLvTWhywi2VgAGNfp0dWeLu3RqKmTMebGIx11K
         mT7VqaadNwiib9D3CSkTbAEqXMQq7fYeUBYFCm1vJ/ry7jOKFqJC52CXdB3pg7LSmr4f
         KAxLxH+MG7KutQTSuDnNwL+CAf2dCYo1n7nhvdlRx+zXlWUlFPqWQo7WAA4rDyjV8bpC
         8D72pbUMWY+Vn0qZM9ZkPwlA/JixPDU4ZclKLHnhXyg2fFhHWnGj/7X9jlTnUIRHckCs
         TKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577679; x=1762182479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFmNRNpiYRbSyKjivx5b46rxwRPMOYECqNZ5ldemnk4=;
        b=rsO6akzrIRrsW9Wb29ezFings4qIptZE/36p8MALh7n3HStSYG49vQ3KiY+f9atyDn
         bfqdqrN6/fUtsHDqzDeu5DGfp0mUrigq+uVG+qYd5/hxeidceCaR+jPgyBkCclQSCj/7
         d2jG+veDfn8Gv9qanLtPjv8002ATVhnZcd/XHoEwMr6V/gvF9JJRGjXuWrfid929I59L
         94mT2pcQlZIJgNnmMcvXaikQJQu3SWjtEh/hZVuy12H2C9Vk5IbXJGkZs0M5OofdHcQU
         Fq0aTubgPTzm6f97RG2yjUuLxqEvJJuFTfkpjKCPzgLjC6Ja+9GPcTD7NIGFlCF01SMN
         +TgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKt3/EwT5Ubo3io3oxhI5TjE4ZoRYuTicggqXxkwtSIbMie7AjJScbMA0aWpT/25mnV6EJD4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRizn+ucfgJ2jdsRd6VCatgJF1JdWUur8WN7v9cPX55n5AIlZ
	N2riGUnYBSX5rRZdOtD1ee8Urcqg083v+Gfc3nCyjRer/4tXTdEdB+IXf77r9tlvj6EAsAInCGf
	bHCQQHyQPg5okaHReRWyKe8A1ckeJAw/0xi/0esxX
X-Gm-Gg: ASbGncs2uYRgePP6F/1zjrz9AMKNNJfTcELlAobqDnMQNTlfBuqsF3NuJfwTQHrOoiw
	6kwvoyQUTmVW9fByPMK1afMT0ReCtR8ZNV9L3NhNGc3RMvFXg8TCMwLtc/whbTxfi6NKwhOVYVy
	HG9pzMXX0o7552qpMBPutOjXpw4lhRht38cV5DQqfYmFPFLMFoTsutww0UkIlPR3ZtXVH6QMdpc
	SEFP5V8xefgRqFHW7cSPdblyPxcbBp6bzFb3JFJg2O0CZeZzrmqPjKwMNAemmO2Dw5mtVbiB8Ca
	jUhqMX0c5BuMeL27sA==
X-Google-Smtp-Source: AGHT+IE/VRXLeFnFj7efFctBux16bp+sFLD27Fv9XqtJYX3+YZY6I8ih1yzTjHgLLfWUWhd+g5Oo5nCtGKvoCiF7y+A=
X-Received: by 2002:a05:622a:2b05:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4ed06efff0cmr823271cf.11.1761577677167; Mon, 27 Oct 2025
 08:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
 <20251027141542.3746029-1-wokezhong@tencent.com> <20251027141542.3746029-3-wokezhong@tencent.com>
In-Reply-To: <20251027141542.3746029-3-wokezhong@tencent.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 27 Oct 2025 11:07:40 -0400
X-Gm-Features: AWmQ_bm-jSbBd_NCN3Fm-69xCK7y8NSPpwczuYFYDkOIScJKpoudLfKYwGsdrS0
Message-ID: <CADVnQynj=5GQbwhiFXFe2gWzodH802ijvFk55xgzxLa6ipRoow@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net/tcp: add packetdrill test for FIN-WAIT-1
 zero-window fix
To: HaiYang Zhong <wokezhong@gmail.com>
Cc: kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	wokezhong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:15=E2=80=AFAM HaiYang Zhong <wokezhong@gmail.com=
> wrote:
>
> Move the packetdrill test to the packetdrill directory and shorten
> the test duration.
>
> In the previous packetdrill test script, the long duration was due to
> presenting the entire zero-window probe backoff process. The test has
> been modified to only observe the first few packets to shorten the test
> time while still effectively verifying the fix.
>
> - Moved test to tools/testing/selftests/net/packetdrill/
> - Reduced test duration from 360+ seconds to under 4 seconds
>
> Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
> ---
>  .../packetdrill/tcp_fin_wait1_zero_window.pkt | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fin_wait1=
_zero_window.pkt
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_w=
indow.pkt b/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_wind=
ow.pkt
> new file mode 100644
> index 000000000000..854ede56e7dd
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_window.p=
kt
> @@ -0,0 +1,34 @@
> +// Test for permanent FIN-WAIT-1 state with continuous zero-window adver=
tisements
> +// Author: HaiYang Zhong <wokezhong@tencent.com>
> +
> +
> +0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +0.000 bind(3, ..., ...) =3D 0
> +0.000 listen(3, 1) =3D 0
> +
> +0.100 < S 0:0(0) win 65535 <mss 1460>
> +0.100 > S. 0:0(0) ack 1 <mss 1460>
> +0.100 < . 1:1(0) ack 1 win 65535
> +0.100 accept(3, ..., ...) =3D 4
> +
> +// Send data to fill receive window
> +0.200 write(4, ..., 5) =3D 5
> +0.200 > P. 1:6(5) ack 1
> +
> +// Advertise zero-window
> +0.200 < . 1:1(0) ack 6 win 0
> +
> +// Application closes connection, sends FIN (but blocked by zero window)
> +0.200 close(4) =3D 0
> +
> +//Send zero-window probe packet
> ++0.200 > . 5:5(0) ack 1
> ++0.400 > . 5:5(0) ack 1
> ++0.800 > . 5:5(0) ack 1
> +
> ++1.000 < . 1:1(0) ack 6 win 0
> +
> +// Without fix: This probe won't match - timer was reset, probe will be =
sent 2.600s after the previous probe
> +// With fix: This probe matches - exponential backoff continues (1.600s =
after previous probe)
> ++0.600~+0.700 > . 5:5(0) ack 1
> --

Thanks for this test!

Kuniyuki rightly raised a concern about the test execution time.

But IMHO it was very nice that the original version of the test
verified that the connection would eventually be timed out. With this
shorter version of the test, AFAICT the test does not verify that the
connection actually times out eventually.

Perhaps if we tune the timeout settings we can achieve both (a) fast
execution (say, less than 10 secs?), and (b) verify that the
connection does time out?

Perhaps you can try:

+ setting net.ipv4.tcp_orphan_retries to something small, like 3 or 4
(instead of the default of 0, which dynamically sets the retry count
to 8 in tcp_orphan_retries())

+ setting net.ipv4.tcp_rto_max_ms to something small, like 5000
(instead of the default of 120000, aka 120 secs)

Another thought: the original test injected a lot of extra rwin=3D0 ACKs
that AFAICT a real remote peer would not have sent. IMHO it's better
to keep the test simpler and more realistic by not having the test
inject those extra rwin=3D0 ACKs.

Thanks,
neal

