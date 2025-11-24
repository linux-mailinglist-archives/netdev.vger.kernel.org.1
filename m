Return-Path: <netdev+bounces-241229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B251C819D8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 280634E6C97
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042129B217;
	Mon, 24 Nov 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UERqPXaH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB429A9FE
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002304; cv=none; b=q7KRohZY3JxSVBmumTy/4JIfzuTi11PrRpRq11UYn/IY3KTmLfuCjycVGQrkv/MTmVol1/MxN6YqJfLV+1rPeFl3a9in2PwBnaDKDJE601VlnVC7CQbXWb0XFeTFfjcS95GlKA/GmjGWUvNofUsbRK/YC8YaAjzYFIBxGqwtxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002304; c=relaxed/simple;
	bh=3rbprMtPD2eY2sunMvqf5QJbAo/YyKZdpHGRmjm/2r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRBU/ZG0BVGBM2xL57+lI1wYxOjRr8nFDeoTYt/X51zLF4QpxbcKvpozCri1j+PL6dmE7s5Ts0bEPw31E9ybknhBUfJOTNyyV5ymQcWn5E03fGu/2kwjq2WkT2y38UnZdPQR2gmIyESaaux7CbMAyrYjlxjX837BR3CjJUUYiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UERqPXaH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4edb8d6e98aso716581cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764002301; x=1764607101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiUM7KRSU7QlAoTqTS99+whGuPwaEZKawwdmzgZ1kjc=;
        b=UERqPXaHwFw2xOtZIf4nbis2HsKIxp9a/jjf6AJ2sFSCde8bn7vN8gd8HjrOvYoNy+
         6VnOrpzZ/CgbRtXxqPAhraEn8WK35c7OGnz53hsdTeQAPiNS1CfCYlFsI51TqYBzRpjC
         8k/G35A2JmRj+9RuUX6eWHbbnbJ6w7nV7baNoHLW/oJmE62MfLbd10c9FYlwYKgmOACu
         tEh+KipbtECOg8fnOngyKZrDkehmmQexhdO/oJOdPnY62b1rZcGn58O7BtHEkaAKy672
         0jpmDqHszAWJQE+rbond5njkJ9nzTs8rw+tlhxZ4RB4QvaDqW7mzXRy7803HXymHXG4r
         7Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764002301; x=1764607101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xiUM7KRSU7QlAoTqTS99+whGuPwaEZKawwdmzgZ1kjc=;
        b=TMAZmO7kmDVvASQNMEvrBbwNtDToiZ899z52bUOn3JxKL9UinAc7SCahYr3hnK0rlk
         6u+tXSfaigSA/vsYWwYKiSdu34k369zgIV+/Kj3uwu0Z0aQF6Sy7rFSu8XP/SWJ7sbtK
         /X9KDAtwDbYlAw1TJpobANiGtIKoxh655y1aznL6pPJqTP26j+v3JKe7zINOv1Ih0Xq3
         aRpN3EaFOed9PJ0Ej41wUEWTCkZaro/MIAEb0eUNTLCee01cVQZToTKQa8mitNHyk5ip
         QvzwE4UwPHFnBix1VA1zu9jB/TfskKM5rtf5fIXfrHFc/oBbPnQdaUTtJIqvnkzq8Kmn
         secQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSg9ztqK93VwW4zLq4kjZTDbziPBVuY7IMNpOjrQVwXP4s4ut+FPnTHK41gH8zuNd3Vq89OJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kw1V0CxNvDC1NhOxByqKGRsUhwvPjv+EZVi24yFI5kDExWi2
	Zrmw+QiB7YpWWHHyPdzaXUCIcMLJRvbxqNLGGK9TaN0T1Xyz58oHXC+m7SqKosCGSHqd31VXCO7
	6SrVRFJZ60CJ929tU86VCH3059bnxVXtUBu1tCuT5
X-Gm-Gg: ASbGncvnD9F+Yb/AhcD/8nFc9yLHyaJm1nwp2hEsn+2d3GMrSLiR2o8D7IRZzNChLE+
	H4j6PfpVTO2nTUGveUNmplr813jUarO9CMYZ7eXcogxScbIdl2i57jCMR29/W2Hfek/DVedMwDO
	xUlDh+uQnhwcDJv1ffxviGDEDq2TvNYTfcPD91kX5LGtyjD5qNtdZ8ulD00AWC+9VoPkcsWYbWg
	kagaFl4HeKVAFBAbiScU57L3cMRBpN6AArKOu372BJSkkScbPqLHloPwIAlUuaEw70iXxfwkcqy
	7ZvCtIC0pUyG7jDEKGlU+9NaNt4GAuJ1w4hR1FE6rnvoGpQSCx6Zd00QQZr3
X-Google-Smtp-Source: AGHT+IHGabRdkq6JBCyIFXsY37bTEL4i538496MbkfOLHxciWDC6S2u+QQ4UU/atzHT3/Gfcu29wScT7XCStNnx4Bfw=
X-Received: by 2002:a05:622a:15c7:b0:4ed:ff77:1a87 with SMTP id
 d75a77b69052e-4ee6108d8aamr11313521cf.19.1764002300774; Mon, 24 Nov 2025
 08:38:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124071831.4cbbf412@kernel.org> <willemdebruijn.kernel.1fe4306a89d08@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1fe4306a89d08@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 24 Nov 2025 11:38:03 -0500
X-Gm-Features: AWmQ_bmToGaiwX6D0ZhRW-Hnr6JZouoxJYqMprYnSFkzEEsZAEBJvERzeg-rbaU
Message-ID: <CADVnQym7Whnbc9xf_dew-ey1fGFBY1dSf6RJ=9qLNP=u+NYOEw@mail.gmail.com>
Subject: Re: [TEST] tcp_zerocopy_maxfrags.pkt fails
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 11:33=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > Hi Willem!
> >
> > I migrated netdev CI to our own infra now, and the slightly faster,
> > Fedora-based system is failing tcp_zerocopy_maxfrags.pkt:
> >
> > # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect outbou=
nd data payload
> > # script packet:  1.000237 P. 36:37(1) ack 1
> > # actual packet:  1.000235 P. 36:37(1) ack 1 win 1050
> > # not ok 1 ipv4
> > # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect outbou=
nd data payload
> > # script packet:  1.000209 P. 36:37(1) ack 1
> > # actual packet:  1.000208 P. 36:37(1) ack 1 win 1050
> > # not ok 2 ipv6
> > # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
> >
> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/3999=
42/13-tcp-zerocopy-maxfrags-pkt/stdout
> >
> > This happens on both debug and non-debug kernel (tho on the former
> > the failure is masked due to MACHINE_SLOW).
>
> That's an odd error.
>
> The test send an msg_iov of 18 1 byte fragments. And verifies that
> only 17 fit in one packet, followed by a single 1 byte packet. The
> test does not explicitly initialize payload, but trusts packetdrill
> to handle that. Relevant snippet below.
>
> Packetdrill complains about payload contents. That error is only
> generated by the below check in run_packet.c. Pretty straightforward.
>
> Packetdrill agrees that the packet is one byte long. The win argument
> is optional on outgoing packets, not relevant to the failure.
>
> So somehow the data in that frag got overwritten in the short window
> between when it was injected into the kernel and when it was observed?
> Seems so unlikely.
>
> Sorry, I'm a bit at a loss at least initially as to the cause.

I agree this is odd. It looks like either a very concerning kernel
bug, or very concerning packetdrill bug. :-)

Could someone please run the test with tcpump in the background to
capture the full packet contents, to verify that indeed the packet has
the wrong contents?

This would help make sure that this is a kernel bug and not a
packetdrill bug. :-)

thanks,
neal

