Return-Path: <netdev+bounces-232253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53689C03327
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F41A658C8
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E67F34D4E6;
	Thu, 23 Oct 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmXuKXx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793735B138
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248261; cv=none; b=PO168n0Z8K5Dr2NMw4PKa3DmafySNxJ3TJTIEiJNK0k7BjIGGQs1rRNiP31Ib++qBWHVj0RNBNTQMr+51Uar/RlMYPhNsqnDxXJLloOLLMLbExYeBXj66Pai8njGz5ikUzEnL885VdbzrCFI2VHShrPLV7X6ER/hsvefyDIHogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248261; c=relaxed/simple;
	bh=lSgu3nilc+FoS0eOXBUtZUH7bFANmrn+EnLRvkUufcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwdEGO+qk6petaXfr61NYVC1OUZ9o/yMixx5ZCZ29cz7y7Ho+BMpCQvkhe24pStsJUBi01jmrZhMluTp9Ua5e0pIUxe0YUMhCjFPOt6nRSgygfQdvq0D9eddGkhKEQI5E6cvJkv892TcpXIlgV25WySpu5u3U0o6RJsGMTeGQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmXuKXx5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cea3f34ebso868029a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761248258; x=1761853058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ1LxDTD94mTUxZEgC//vZy3WRPH3SzHMiLz9if+iA8=;
        b=hmXuKXx5al7xrzBvjqvu5Vq5PUL7Y1ca02dPCo5sQwQVn8JnUnkHo1q7mr8qJYo6JX
         by2pqnd+8IKUdczE6QH2x/DgzVbHLfMcunK/Fr2u0nw990gg5X/qBUYnoDciAkoISRP1
         PflhUGwGGwFUcSyuudSUAuMYVNH+24YlW1JjsaTMfu+izVm/C7IyxwAbdYsvai9nzS4n
         YtPjO946wQwnQ31CIrg9DwN72XmNRHuGVMi8ZfH5btetFNgtbPJoMt0rJY93keqJi6Ec
         ZzWI2HN00BlHrsmZv2KVGN3Xj5L0UG2PJYho5EinI6noFhhlHR0npX3UGeG/Zj25Y0xt
         wn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761248258; x=1761853058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ1LxDTD94mTUxZEgC//vZy3WRPH3SzHMiLz9if+iA8=;
        b=ThnyTnWlWWfPT7dMJ6OHgk9RgWwyk4o/7Y///4B88YtQEG7zn4ssA+jH2R56sn52Ex
         9IaDiY8UG8dIvNhowKwcuQCFZF4JoklqfM8Uym7xif2IoAnhBrbSVOvWnVk/RfZVnHKd
         zMZKHnrQU34OpxPrBLpzVYZWJ2jzOfpVbJIraLM/qmUZdF0OR3BD8rpg3FA6gA/tOzQ/
         EDG5sUCdZympiQG9lLSR+cc237sjGEwt584N6VsGU9yshUzArVvmMmIhOYi2fTQr08wu
         4D8EEZ84s9zXf6T4nUKg2T+KafdkoINnlOSRfF9e9Q79X0gbz01m8gTHCPxueQncsEXs
         xGug==
X-Forwarded-Encrypted: i=1; AJvYcCWsiM+7OxssiExx9CtDnjWkvFWJDZUPvkJovKW+1638pvXRRt/V/vaUX4xSHpZWx/hQXz8RhJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtgi8s8gTL1GMOMJiy3RrisvxmoqVJq1wnA5533K4mq/JRm45F
	qNbIkB0YelyPdgENU7XWIQdMQh3KgJIK0VOnhmbDLIzaQ0UbSoS++xBToAmHhBSmgRSkUpfY+i6
	cDKblSYVYMtE0ZtscosXIlETA0ch8RahU4dSncn7B
X-Gm-Gg: ASbGncvth9WSBMRv+ycyZA38MKCVR1jXABlid+EvSPOV3DuipvXaps4UJESO+4PaXr4
	gHC74DhW9EnY1swMAMALXreVOLWP+8VOA/bovCbbOTedTKteSapZ/NEYuoSGiLPdqBzsERYEp/z
	DXkdqEpbitftod2qisSdB/61YB3u9UV0ytUUuZ6ybZQl5TjNtzA7BcA8U51L8UZzzU/V/D1Oui+
	IrP/8u9kuBnL7KJNfFT6DqkDSEUWp5EjJeaP0H5HL4CMc51vKrmmzBHMWBIniKYju93BEmPCIfN
	X+7+hb5/Nx5JWgfu5arI4PJa2g==
X-Google-Smtp-Source: AGHT+IEdJA3haUsbTz+16YzBdMM68eI0eHjD98BC0sTPMoAeLto2g3VcHvdassvHL9jiwGwrO33J0kGL9Kn2MLkP/pc=
X-Received: by 2002:a17:902:e88e:b0:290:9332:eed1 with SMTP id
 d9443c01a7336-290ca12153emr299361315ad.34.1761248257584; Thu, 23 Oct 2025
 12:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
 <20251023144805.1979484-1-wokezhong@tencent.com> <20251023144805.1979484-3-wokezhong@tencent.com>
In-Reply-To: <20251023144805.1979484-3-wokezhong@tencent.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Oct 2025 12:37:26 -0700
X-Gm-Features: AS18NWCNBUrdZzai3h5f3kN93-JxNAspDqdkgoGxQ_vgOOCGtaLuec2K14EBHaY
Message-ID: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net/tcp: add packetdrill test for FIN-WAIT-1
 zero-window fix
To: HaiYang Zhong <wokezhong@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wokezhong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:48=E2=80=AFAM HaiYang Zhong <wokezhong@gmail.com>=
 wrote:
>
> Add packetdrill test to reproduce and verify the permanent FIN-WAIT-1
> state issue when continuous zero window packets are received.
>
> The test simulates:
> - TCP connection establishment
> - Peer advertising zero window
> - Local FIN blocked in send buffer due to zero window
> - Continuous zero window ACKs from peer
> - Verification of connection timeout (after fix)
>
> Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
> ---
>  .../net/tcp_fin_wait1_zero_window.pkt         | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 tools/testing/selftests/net/tcp_fin_wait1_zero_window=
.pkt
>
> diff --git a/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt b/=
tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt
> new file mode 100644
> index 000000000000..86ceb95de744
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt
> @@ -0,0 +1,58 @@
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
> ++1.600 > . 5:5(0) ack 1
> ++3.200 > . 5:5(0) ack 1
> ++6.400 > . 5:5(0) ack 1
> ++12.800 > . 5:5(0) ack 1
> +
> +// Continuously sending zero-window ACKs
> +30.000 < . 1:1(0) ack 6 win 0
> +
> +// Key verification points
> +// Without fix: waiting for packet timeout due to timer reset
> +// With fix: this probe is sent as scheduled
> ++22.000~+23.000 > . 5:5(0) ack 1
> +
> +// More zero-window ACKs from peer
> +60.000 < . 1:1(0) ack 6 win 0
> +90.000 < . 1:1(0) ack 6 win 0
> ++16.000~+19.000 > . 5:5(0) ack 1
> +120.000 < . 1:1(0) ack 6 win 0
> +150.000 < . 1:1(0) ack 6 win 0
> +180.000 < . 1:1(0) ack 6 win 0
> +210.000 < . 1:1(0) ack 6 win 0
> ++0.000~+5.000  > . 5:5(0) ack 1
> +240.000 < . 1:1(0) ack 6 win 0
> +270.000 < . 1:1(0) ack 6 win 0
> +300.000 < . 1:1(0) ack 6 win 0
> +330.000 < . 1:1(0) ack 6 win 0
> +360.000 < . 1:1(0) ack 6 win 0
> +
> +// Connection reset after zero-window probe timeout
> ++0.000 > R 6:6(0)

I guess this test will time out if you run via selftest ?

