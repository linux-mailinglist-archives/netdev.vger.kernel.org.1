Return-Path: <netdev+bounces-127561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0513D975BAD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75041F21F8E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF361BB680;
	Wed, 11 Sep 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mte2mOay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B51BA893
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086251; cv=none; b=pAtLCLuJ9uOOcW5a7qvhj+4+LGfNgWeYlMj29R7MG3EG40BfPNWsp33sjkkyNUkEA/0MRcTBFnBf+jf5Tzgwa5bP6YvoNdQigEHSpGQqvpUMRDlw/CFZ7maDP57vwH908FrD6UBh4zdTcCPyfN4UxFhihnRyJHgFyMW44mBFtsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086251; c=relaxed/simple;
	bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/+EcfwkIf01kya0Jo3YXvJ7c2X8eLTTSVPQxvLSuQuZ4ornZPXBUyXLwBKq1jVuSKF+fum78uoh2kQE0cdPBe8Q5HxJLUaHc19ahlLxx27o21kwyz4bIbrvjRTC7pjkEfsqdcRsb7MuanvWbeLRaNbjVj+rWcbG/xS4G4C05Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mte2mOay; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53568ffc525so292331e87.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086248; x=1726691048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
        b=Mte2mOay+G/EbCZ/OGKyDKHs5jH4R7UiY+YG7dJ6wd5rXB1nXygNDGXun3QyNYWMlI
         s/LW8V2WtYvN/eYV9GriZSrN8clWJO7fQOMcKdnkebkn5ktPL/PwuCKG/GNOfjDNmUhT
         X7BSauC41wx2HCUuetnVUZH1pSUtocVb+XdZRhMg4OwJnD73KBFlevNCf4c1X2407Xpf
         9fy+vD9ai9MZBlxJFigzZ3IwWjLPWFR0ETuKylWuM18BV0UrwBQgNw73fp+Qpy58Oxyi
         28M09XRQKr5C5ufu5y3fmbfYX3W4UAQu4sKAUwFXxLIPTNocsP6ooG5mnlqRyWgnIbCl
         CzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086248; x=1726691048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
        b=S4Yz7XtlGO5bw1XoWKp84SPjJA1RgjmBzAlvoXwmHv1fba0PBOOC4pzQzb9icZO3S2
         Si79acKbynLKcxZ2xVk+MNfX88YJESbdX0ijV17h5CxAdUj75H++emaXPPmky47NNSr0
         rvxber2SsLfHmgpBqv0n2uWua8UNUcQzrGAKpD+MilKNEdfEtK8RqiRG/i5xRLu8cP/5
         bPCoRcX4w2ALCsMklRbDnT3Hh5Pjc3GJwZ9g2GZEQMR1MqBTTXmfq1GW2v92cEpM7jq2
         eoRyoDuoblGvyiN+nvwMrw+wYUCReW9R0Oa6KyZuVDnDQu7xDArhYz/PkCSRMcszn/dQ
         qdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX75DJKSvvp04mAiHFe6WkWF1NJVuLxmQDTbQfRt1TBip8L2LI4uNCHMfYdD8fcQYfFg34LrRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtCVK1qaAadHNgsEbEr3ZijvtuN/6i2wha8aiR492hU6qXDRF
	Yc0/3HXJHmr8He30sLU3gM881bJVw0u3mnz8+4R6ABY3IDRjksdwIeH5rhheSCgHFIUHcinFCne
	A5lLs5hFOMN2gJEvxakQUMDJirPKaXQwW6sI=
X-Google-Smtp-Source: AGHT+IGRxWn7AtTgeZpuWRz8V5rd6W5D28c5D4Sbrcq9HPFNDqqf74JfyLHjNc0/1W2sZ5vG7LWV4Sedoj4/HpTIDrY=
X-Received: by 2002:a05:6512:2807:b0:533:4b38:3983 with SMTP id
 2adb3069b0e04-53678fba44cmr295554e87.20.1726086247114; Wed, 11 Sep 2024
 13:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-8-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-8-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:23:55 -0700
Message-ID: <CANDhNCpaBb2TJb8K0frcyqDPD9qDjuBdUkHkK906-H5f+uOm+A@mail.gmail.com>
Subject: Re: [PATCH 08/21] ntp: Move tick_length* into ntp_data
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Continue the conversion from static variables to struct based data.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

