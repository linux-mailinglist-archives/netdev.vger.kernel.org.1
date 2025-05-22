Return-Path: <netdev+bounces-192639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E22DAC09E7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950AF3B5202
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319B0262FEA;
	Thu, 22 May 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="BSSGICHC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38D1C5489
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910073; cv=none; b=os46zGAycXdPb18lfmbH3b0zAuhCqv0u6w9X2Vm0LLGSrge184qutaQtSGo2JoiGspn7nRE3ds4UkI5mhnaIV9zuJI0apj7uvv9J4G7NyZsi3h1ek7ZTKDWKDvUMx6FBmNRQ8KoUi5SI/2heGvY7UBOveOlm2oX69RjMbTIYY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910073; c=relaxed/simple;
	bh=UpgFHrl7pS7BU6Xn5TVQ9ys09X56TVnC1s1iJP0lJrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahU2Ar11EY6ncvmuoBFHs1vTce1zp5Z1EHJD7DdVAvPMR43ho9YbO/kgUuy4WUUaZz1Rq/xThnDAhmY5FHe0idy2vBtANYZr4mwplSmWqYKdTuSbz81cQpYGFJqyVEGV+bbdkr8DRixLFiYkFEcLagnsVHpOG81x0grjRJ6qPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=BSSGICHC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-551efcb745eso5899604e87.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1747910069; x=1748514869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UpgFHrl7pS7BU6Xn5TVQ9ys09X56TVnC1s1iJP0lJrg=;
        b=BSSGICHCcLdWjtyE72jsPwmvg3Xwj1Gk4jNw7GaZQi59o7qa0uvdShiGO1T9/fnnwq
         WlGam+UxVHatI13El+1oyXUMH6G3XRBDm4vhynKxpb0FW4/zVZlgrOQiqsDoUj4nkB1/
         NHiFKqw6WqFFj//SldkdfgotpedpZoKh4DBFynOTYWumvIRiUm3IaL1AC9D7fvTfhwQJ
         pTKtQQ+746mwe2y1mfUafj2VLptxRpDU8W10QJcG/bM0KfmQjjALQNjXec3RCB+gyB+H
         u85J8A7RhZacFgoK73l+fo7NaEY44ctiKYctEiu8w/o8NueiXdGzoARJtXNB2uSJW/J3
         HmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747910069; x=1748514869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpgFHrl7pS7BU6Xn5TVQ9ys09X56TVnC1s1iJP0lJrg=;
        b=U/GEN3BG/AKRZ3biohg7m/Kq+2BDgtbKVt/ZZNuE20otb4kltSfptFGezZR7n2e9Bt
         EuaotglLtPgD0vMapVAS0fdrvgVpI4dzfk7Y6PCY5R0MXR121MGUmHQsHpH4AkHg1HV1
         9TqcyYTA+bp+LhnCvg+rV4U/wFOuy7P5mxVQqNxZ/W1jM5M8O04V0rLiqgkGyZVZ2cck
         It+byCFIWYg1H7BkJiyFuH24HMwGzReisJNv8C53iQeYatlzKRifMD1LVC/OOzR79bNV
         I04WXHP2mf+Qj2UO/XKZoizvrad3RU0IupCPpAMZWxg0giotH2EEmwPy0NzEIcl3cBMK
         vu3Q==
X-Gm-Message-State: AOJu0YzB8GOlYHREW1SGZ7vz8ZoRfpO8DJkLeKUqCC4EdFOHdcj/Wdgj
	BE0DZ68arj7uPlxBzkkGEYQ4ibBPbVkUZ568eb2N9YuKLp1KoCRWjdM+thE7Hw5QtHnA8SiQ2H8
	vEmqrsd5qnf1Mdo4U0eZ4KvyOyo1ywI5Se+CWxyO8kg==
X-Gm-Gg: ASbGncvA1j8bo+YbQF/qzlacfapLrEWXkXFHgtqAd8qbjkeClwf/LrysKfyxjZs0JO1
	iwUGPi0RMx/FV2bVrvDW/f6/Jf0KR4dQezPOaoLP6b9sMMZ25cgcDERgkfwRLvK4IBDFJMW26ya
	WkI5VSC6p3fDIuVAlRQtguL2pnNKqkkiX9F4SvXDjiFF7DKtMVsQnw5mya2iTQKioMtQ==
X-Google-Smtp-Source: AGHT+IFAaPZQq2jYrbaOxOd/aj+rRZA6KNwKrL1W2F0Pt9WITBfhSqkMd2f7zrC7Ool+7KUUIKrUvHLQhHaLNgDTwAA=
X-Received: by 2002:a05:6512:2284:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-550e71e48c0mr9278968e87.31.1747910068865; Thu, 22 May 2025
 03:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
 <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com>
 <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
 <CAAHxn9_++G0icFE1F+NCfnj3AkErmytQ3LUz2C-oY-TJKbdwmg@mail.gmail.com> <CADVnQymURKQQHHwrcGRKqgbZuJrEpaC6t7tT7VeUsETcDTWg2Q@mail.gmail.com>
In-Reply-To: <CADVnQymURKQQHHwrcGRKqgbZuJrEpaC6t7tT7VeUsETcDTWg2Q@mail.gmail.com>
From: Simon Campion <simon.campion@deepl.com>
Date: Thu, 22 May 2025 12:34:18 +0200
X-Gm-Features: AX0GCFtP7VHNYtt74WBRRRSS9WhWAmLEwnC4754SDPE4TjoO7mDoFyQk-aj5NQU
Message-ID: <CAAHxn9_waCMAh3Me63WQv+1h=FmT10grA13t09xaym4hX1KgCg@mail.gmail.com>
Subject: Re: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 May 2025 at 17:56, Neal Cardwell <ncardwell@google.com> wrote:
> For my education, why do you set net.ipv4.tcp_shrink_window=1?

We enabled it mainly as an attempt to decrease the frequency of a
different issue in which jumbo frames were dropped indefinitely on a
host, presumably after memory pressure, discussed in [1]. The jumbo
frame issue is most likely triggered by system-wide memory pressure
rather than hitting net.ipv4.tcp_mem. So,
net.ipv4.tcp_shrink_window=1, which, as far as we understand, makes
hitting net.ipv4.tcp_mem less likely, probably didn't help with
decreasing the frequency of the jumbo frame issue. But the issue had
sufficiently serious impact and we were sufficiently unsure about the
root cause that we deemed net.ipv4.tcp_shrink_window=1 worth a try.
(Also, the rationale behind net.ipv4.tcp_shrink_window=1 laid out in
[2] and [3] sounded reasonable.)

But yes, it's feasible for us to revert to the default
net.ipv4.tcp_shrink_window=0, in particular because there's another
workaround for the jumbo frame issue: reduce the MTU. We've set
net.ipv4.tcp_shrink_window=0 yesterday and haven't seen the issue
since. So:

6.6.74 + net.ipv4.tcp_shrink_window=1: issue occurs
6.6.83 + net.ipv4.tcp_shrink_window=1: issue occurs
6.6.74 + net.ipv4.tcp_shrink_window=0: no issue so far
6.6.83 + net.ipv4.tcp_shrink_window=0: no issue so far

Since the issue occurred sporadically, it's too soon to be fully
confident that it's gone with net.ipv4.tcp_shrink_window=0. We'll
write again in a week or so to confirm.

If net.ipv4.tcp_shrink_window=1 seems to have caused this issue, we'd
still be curious to understand why it leads to TCP connections being
stuck indefinitely even though the recv-q (as reported by ss) is 0.
Assuming the recv-q was indeed correctly reported as 0, the issue
might be that receive buffers can fill up in a way so that the only
way for data to leave the receive buffer is receipt of further data.
In particular, the application can't read data out of the receive
buffer and empty it that way. Maybe filling up buffers with data
received out-of-order (whether we SACK it or not) satisfies this
condition. This would explain why we saw this issue only in the
presence of SACK flags before we disabled SACK. With
net.ipv4.tcp_shrink_window=1, a full receive buffer leads to a zero
window being advertised (see [2]) and if the buffer filled up in a way
so that no data can leave until further data is received, we are stuck
forever because the kernel drops incoming data due to the zero window.
In contrast, with ipv4.tcp_shrink_window=0, we will keep advertising a
non-zero window, so incoming data isn't dropped and we can have data
leave the receive buffer. I'm speculating here; once we confirm that
the issue seems to have been triggered by
net.ipv4.tcp_shrink_window=1, I'd be keen to hear other thoughts as to
why the setting may have this effect in certain environments.

[1] https://marc.info/?l=linux-netdev&m=174600337131981&w=2
[2] https://github.com/torvalds/linux/commit/b650d953cd391595e536153ce30b4aab385643ac
[3] https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/

