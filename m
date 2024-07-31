Return-Path: <netdev+bounces-114535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F92942D84
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296B8282E83
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC711AD9F1;
	Wed, 31 Jul 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsXOmbHu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3B1AC42F;
	Wed, 31 Jul 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426838; cv=none; b=h2S+Uzoyyaog9L+ZRzt2puq5T5cFmN2kyLhLKoxRxltAMn81ktHLKrz0RB2ieBM4wFqmCVJAuwn/DafcabXnLLaAKlI1xhxHQf4vXswc+LJfTX+aJhc+wQuOg+J/goXYWD1CnLByKaj6kVuEqTPHMmij1vDBaT8hRyJ1+Jo320I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426838; c=relaxed/simple;
	bh=BE0c60Dn8MeBhBgtrnHnjt5yuBxnZsiglI20pqyZB54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W42qy++W0SSejz960D55z9/8OdQxgo0VeYnFZmmrq7MqVJnDfsfN6y2lTi1VmF3wLFIOKYZVCUT6GwRE1T7RbRQLSHaj90CCwaluzv9hSXjFvmilg9JQuC+6SlVAlDw5lCaR+OjoAU8QTKHUhSCRzqncA+kSjV8tVl5rxwcX3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsXOmbHu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso2592617a12.0;
        Wed, 31 Jul 2024 04:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722426835; x=1723031635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOsHCmFOarhzlb2gnbQtyeJ0fdjyw8foZfqF7wowC3Q=;
        b=CsXOmbHuD1MCEAfFbHWpqqsiMfqJiZ8p0uXTbf3TSXNMcknhDLVuAwxL1P0ahCaWtj
         vq2drXqeUnlqhQ/lcmZtw56hJaFmrw1quCSnHfNBlbCPmFVv0NM4k/2cWFwwMIKfwGSR
         3hMKMD24gZOGPraHPcst5J7tyw6fQruPP9gSzDtpBUeP0EQ+s4dMCdZEQq+ddTdpv9/+
         yD0HxAhEQyc4swKkvOato62Jw53nySRFmxU+LZeP9XqKU3fOtdPyhZe+Oa6ZcxH1zixi
         ZyLmUOGmIprOvSox82ccv7gSplSDXVzuy+0073qsYDdL73jQfE0/Uq+OqjGlwdMloExv
         CHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722426835; x=1723031635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOsHCmFOarhzlb2gnbQtyeJ0fdjyw8foZfqF7wowC3Q=;
        b=SlvKPMwQ3JPK4+HLezwODIFmRfraqseASkeZZuPvyIA0VVPMBxJtozXsENDFZ+ESXu
         zOxemSIXqx3rCJrCgwNSofJvSpjkFq0lL6E7jPiWgEIDRef/g7/JjBUOSn3v5DIEFLrN
         obaZgWvqbAjGFyqpq3ahjBSqGdSuGIqr4gdl3FFLDomb3HE/WyQYf8mzHQ8MKUzuLeKZ
         aYS3WRr3freGfQXF1yRqLkpCZOMH+GATkDrEL06hSwjoiTtjtEHiOfNYX3YGsmj93+UJ
         WyOUKCa0vKH61Lg6NkZS7uOD7KriY3IjMK/HNvZBY9pJr+B5ho3gsce/wJ8s9Ftj0WMn
         3lvw==
X-Forwarded-Encrypted: i=1; AJvYcCVVFA2IuerghYSYg0xQfTarO5JUbiEjQibnWrQCm6ohJgDsj3do7vrWoL90Dm0ibkhdf3t1Z1uMzSzjYBDNtG1v6p9yXFhrw6/+u8sc1qUnwMdwKJ9U9xVQbjXqdeYkDKr/YdZP
X-Gm-Message-State: AOJu0YzGiEVpRgtKsyK89u6zr4ctXlaNen5O4aBYAHc3XQayiBFqrEi1
	XYtChgskr2xNxvVi/GdRsn4+GKFac1mZtsfJytJv/Uw7E37i5fmEeJD5OcUMq3teSBtNlwe26zD
	WQ/6jNqktP15tPtKOehHR/HrOPJE=
X-Google-Smtp-Source: AGHT+IE7Lr4Xigz7xbBRvAolT/NN+LVLy8gCr+G+rCJw3WOWqQjQKmcs7MoG7oYcreEyyIbdQyL9bpo7kZ4ntvjcBT0=
X-Received: by 2002:a50:8acc:0:b0:5a1:61a7:56ce with SMTP id
 4fb4d7f45d1cf-5b0222e5315mr7691651a12.35.1722426834777; Wed, 31 Jul 2024
 04:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729104741.370327-1-leitao@debian.org> <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
 <Zqoe9/TiETNQmb7z@gmail.com>
In-Reply-To: <Zqoe9/TiETNQmb7z@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 31 Jul 2024 19:53:17 +0800
Message-ID: <CAL+tcoC-e5Oj1mPyZiS6Q8BuZcuU2XH2Vu7VChC_fxp5JqW9wA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref when debugging
To: Breno Leitao <leitao@debian.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, leit@meta.com, 
	Chris Mason <clm@fb.com>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:25=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Paolo,
>
> On Tue, Jul 30, 2024 at 11:38:38AM +0200, Paolo Abeni wrote:
> > Could you please benchmark such scenario before and after this patch?
>
> I've tested it on a 18-core Xeon D-2191A host, and I haven't found any
> different in either TX/RX in TCP or UDP. At the same time, I must admit
> that I have very low confidence in my tests.
>
> I run the following tests for 10x on the same machine, just changing my
> patch, and I getting the simple average of these 10 iterations. This is
> what I am doing for TCP and UDP:
>
> TCP:
>         # iperf -s &
>         # iperf -u -c localhost
>
>         Output: 16.5 Gbits/sec
>
> UDP:
>         # iperf -s -u &
>         # iperf -u -c localhost
>
>         Output: 1.05 Mbits/sec
>
> I don't know how to explain why UDP numbers are so low. I am happy to
> run different tests, if you have any other recommendation.

I think the iperf tool uses '-b 1' as default, which is explained in
the man page:
CLIENT SPECIFIC OPTIONS
       -b, --bandwidth n[kmgKMG][,n[kmgKMG]] | n[kmgKMG]pps
              set  target  bandwidth  to  n  bits/sec  (default  1
Mbit/sec)  or  n  packets per sec. This may be used with TCP or UDP.
Optionally, for variable loads, use format of
              mean,standard deviation

So, if you try the parameter like '-b 40MB', it will reach around
40MB/sec speed.

If I were you, I could try the following way:
1) iperf3 -s
2) iperf3 -u -c 127.0.0.1 -b 0 -l 64

Hope it can help you:)

Thanks,
Jason

>
> --breno
>

