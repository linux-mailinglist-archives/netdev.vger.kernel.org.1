Return-Path: <netdev+bounces-195489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD95AD0748
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 19:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E4C1891495
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD719148838;
	Fri,  6 Jun 2025 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMHniWf3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1912CDBE
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230229; cv=none; b=oGbI/ueLI5RI9AIj/IdoBiAqzWXXd4bfrqaA1OIe4iqKvu4zw+EBQYwOz8JMtBvKtJunhUW1AGzv4QSFnS0WH0G5N9dXEL5FtoZpII4dBrbIZLzfhOpRYk4btOsWmtgyUbTMiwYTIOP0ZbWK1o9Tz9RIWFt7jxDmSnTZz8GrNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230229; c=relaxed/simple;
	bh=SfR0cOaGofkev22hPCQ3XghIJYkqaoiwMH2ugkUSszc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLcjbsXw+V+omH07PcjEjO1ZXqmCZWACnm3mwHdF/4bHFdCd9D3DF6/m1gMNhl1VD0M9+i+ZLqUHreb+Vfzte05H46HWIeWXZdzOOSm8rBkFsoyrLRWjgYsxqMhMX+r9FXnBPfMNNGAAPrpsydk5vCJ8H/g/zr3zdK/Ia43yeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WMHniWf3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47e9fea29easo13701cf.1
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749230227; x=1749835027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLeUStVGbo2/FnVij1rEUX9XeKz+QSY9QYDjoAQvIIw=;
        b=WMHniWf3xIzr/Gl3VKK2CkrRHcLzLubFByxd3PWtBI71HOc31KvV9XndpwS7T5aIVK
         UWAANJC4mtnyDlTdw/9Jae7+SEI6VsCnyE9qwIbt0hRDzvSXazrEqD0cgo8aLH/qR2lP
         yX8fgg5XlXAVyAJOJSxIsrGrOuH3JhIqqB/3N3x7lZubBoLldZSJ6i51uTBoPA5a/+p8
         gA9nh3JgBQpQshCi55tWRJI/hvGW4ktXP+EbNHbDES2ynE6iTK2ImqwnKbnTyruIO5Nz
         CDQn2QMn2p1JBGSj/1E6yg5RWgla5o2Gs1qNT88yfybIif26e+tnTiif4jTVmSf5Ex85
         A8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749230227; x=1749835027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLeUStVGbo2/FnVij1rEUX9XeKz+QSY9QYDjoAQvIIw=;
        b=qZthBTqw9pM6jAoE7TiUVmBPncT3jSHCRDxCQLIBJ0MKJbvqCboq4p2VXSRe2MA6bc
         UJzMhW52uxU7qfqyRbemZ8Iz0+Wp3fId8Lli27m/QVOvFv+SMAdMcqOOuoFhCDmYYAPa
         1AQcw8o/mY9D1XuPttxp3xztPgbJBiK9GviFaWn25AV2O8ucJClwP/LO2qVB7Iy2HlFR
         NOyWWPRqSmnij8zUsBegaUDaqNuBMC1hbTxbHEhqPcYGwFugh+x5kE4fkoy5441O55XF
         DrS4KG1Sgw6AWx18PQ7+qsyodAMbGyAXzic7aaHULDUNVyW6tSTeoszRuHv6Rjntz3MN
         cvvw==
X-Gm-Message-State: AOJu0YyOmIpj74LmaUF+1wfBAM4K40yDuVT1R912ga4mqE8B0cG1Kjh2
	kEeRa/+khjPvO417lJMqs57geQpUULwoqITH/fUDC5zjnJPQHoTCjNOK0uYnBX8t3JMRxnopS4A
	XRZz6ceNvia/rDS6sfdawna25+6sjvHVm0J5thkPw
X-Gm-Gg: ASbGnctWFtH1UZ/jyl1+przIajYkwuEZkSrO/AzSYLSMB29UuH3PJ30kj2I5LSQgjEW
	KLNzA0EjS84GSNClC4syDKg2Jsqgbq08NOAYrpgSFCWC9qe8+xI+2GVDRtX/bKToM5PCgnIjH2D
	vWPEHWKD9RsjCZvUWqaFk+wxvAYGG7VbHi0eCqiKqVpxUDmGeZt7znL/zwCbTURrUTKvMMEQ96A
	w==
X-Google-Smtp-Source: AGHT+IGXJYAGeILggRWXBoiM6XzanudwWwNBXwZfCBAe9BF4hZR56OJrq5T9F7Ugx77AYe3EfP69zThT+BATQRNI7i0=
X-Received: by 2002:a05:622a:59c6:b0:486:b41d:b0ed with SMTP id
 d75a77b69052e-4a5baa662femr4943861cf.12.1749230226666; Fri, 06 Jun 2025
 10:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net>
In-Reply-To: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 6 Jun 2025 13:16:49 -0400
X-Gm-Features: AX0GCFvbh4Jitx6HDUJyevwVpd9tUOP0li0ve8Oz80_3QPb9S1ZF2uEf_hxPWzc
Message-ID: <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netdev@lists.ewheeler.=
net> wrote:
>
> Hello Neal,
>
> After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6RFT+
> with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TXS at
> 10GbE via one SFP+ DAC (no bonding), we found TCP performance with
> existing devices on 1Gbit ports was <60Mbit; however, TCP with devices
> across the switch on 10Gbit ports runs at full 10GbE.
>
> Interestingly, the problem only presents itself when transmitting
> from Linux; receive traffic (to Linux) performs just fine:
>         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switch -> 1GbE  -> devi=
ce
>          ~1Gbit: device        =3DTX=3D>  1GbE -> switch -> 10GbE -> Linu=
x v6.6.85
>
> Through bisection, we found this first-bad commit:
>
>         tcp: fix to allow timestamp undo if no retransmits were sent
>                 upstream:       e37ab7373696e650d3b6262a5b882aadad69bb9e
>                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f
>
> To validate the regression, we performed the procedures below using the
> latest versions of Linux. As you can see by comparing the performance
> measurements, it is 10-16x faster after reverting. This appears to affect
> everything after ~6.6.12-rc1 when the patch was introduced, as well as an=
y
> stable releases that cherry-picked it. I have pasted the small commit tha=
t
> was reverted below for your reference.
>
> Do you understand why it would behave this way, and what the correct fix
> (or possible workaround) would be?
>
> Currently we are able to reproduce this reliably, please let me know if
> you would like us to gather any additional information.

Hi Eric,

Thank you for your detailed report and your offer to run some more tests!

I don't have any good theories yet. It is striking that the apparent
retransmit rate is more than 100x higher in your "Before Revert" case
than in your "After Revert" case. It seems like something very odd is
going on. :-)

If you could re-run tests while gathering more information, and share
that information, that would be very useful.

What would be very useful would be the following information, for both
(a) Before Revert, and (b) After Revert kernels:

# as root, before the test starts, start instrumentation
# and leave it running in the background; something like:
(while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/ss.txt &
nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  >
/tmp/nstat.txt &
tcpdump -w /tmp/tcpdump.${eth}.pcap -n -s 116 -c 1000000  &

# then run the test

# then kill the instrumentation loops running in the background:
kill %1 %2 %3

Then if you could copy the iperf output and these output files to a
web server, or Dropbox, or Google Drive, etc, and share the URL, I
would be very grateful.

For this next phase, there's no need to test both 6.6 and 6.15.
Testing either one is fine. We just need, say, 6.15 before the revert,
and 6.15 after the revert.

Thanks!
neal

