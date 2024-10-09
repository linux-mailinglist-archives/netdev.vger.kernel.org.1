Return-Path: <netdev+bounces-133895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E35997617
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8991E1F22CA0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8C81E1051;
	Wed,  9 Oct 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/3o8xwf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613191D318A
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503928; cv=none; b=YaBqX+igia6Xk/WfXLVLur/i3zyPJd09zqjfyvPLZbuBiQ/WTedhYNWwbVtrKITqhzAxfNQ3NaqDMjPXGU8YX3amk6hfTmt+HeZhaALl0ETPEeaI47Zndy0WEkqIt+QENIqB7B2kcBwlPmCR6WMOSpjpjq8mtDksxqyFnFEAtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503928; c=relaxed/simple;
	bh=NfHTMlcLeIvdDweTgtwVoYY5GdBkXiWBWcHPSsaJyA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyY6UhP01DUUO2OweLjDzogVrMkTaU+E6lL636vrj5wdr7YtPVUycqC/FiyceXgzxLeTe2/cC5st8lShkB3RHEmL+Q6dOYrNW1kmlmN4upmTJk0k2fktPNWPCM+t+EfGXsRFaXwE11a/9byiYDlm1BvhbuJ2DZ7XB6juvq8NqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/3o8xwf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c924667851so106662a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728503925; x=1729108725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfHTMlcLeIvdDweTgtwVoYY5GdBkXiWBWcHPSsaJyA0=;
        b=e/3o8xwf7X/zfSnovyyvLNt8yAoaHMXLObgzChX+HVr2cv0RgPpnLerNfN8O3XT1Dz
         nXvlYjBLl0VzNjTJheahwRAnHGYDaxqEdjT1pIaBEhPNdSLbr3tsW8naExMUIS1ajKQ3
         j1xzCIh/zmATjxjHCJBaGeppExHAE2IwGlIhtPpgqUA8S/sKhCnxuXIPy78/YV5VnHfc
         JjXMCEzt/2lzU39+k3wUxm5NJabXEQXixhKuqywjD89nLZGIBqRlIIn1BM3/gJE+IsmI
         UAfQTwHIcnJ2FvQGLDnkk7M5TQgDsgk7iAjU3zrKplpX14A5uEqYISK4nFxChQG1gJKp
         5h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728503925; x=1729108725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfHTMlcLeIvdDweTgtwVoYY5GdBkXiWBWcHPSsaJyA0=;
        b=hJ6ASZwyySuY0uBdZekJZY0+GXFmXgWz7gP0qaz8YFwT3Xkad11mfPY3P2NGzCRL0Y
         2jUi40G9iDspgyBcPG7YB4TTWczR1xDwZhu8LVDDmMh5Bo8AN7L2zA6fm5P/crbnzo0D
         V/hniAPphtZ3ktYfmi1imCSJdMRua3xJl8v+z0rqxnaT2yYrHOECdNLp4mParKH4s+cO
         FZHX87XsdkE3rRifTTj2qJUd51WdR5MTj+DrTw2/wdatE+TQGYVZ6K9k+e5ImdHXBFYg
         0MQ0YYiUWOzW/H8YrOhKFLP4ZpCe7D8FJG777BvKbiqOnW3YQbkEqfFeAMI/LA+uGLHo
         72vg==
X-Forwarded-Encrypted: i=1; AJvYcCXxf8E7LLXxlonKaJO02idLadihyezu86m59h0KWx6Hi+E+5ui91iTrir3ASDcbCjnp/NmXtWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcFRRFFPV+GqT81f+2iVdkr3ltStgEzLPBxZwhYIJ3mx2E/9w
	y1Wbt16xQ0kXJO2r9X1ZIyxLw6bsQP87ERgPkKtjXG2rOiljeeRqn+A5JvGMNO+TZo5n8JXiJDc
	vb0//hWVbC4Hc5QECwKPe/5/kyGMH/d8n++A=
X-Google-Smtp-Source: AGHT+IHxtYkLIkxNlDjK87qi1yhBQTPxuSD3L45q7+j8+ET8HOF9fuHAjTNBiHXNu0dr5D6OrP/tk5ih65g65aAxdqc=
X-Received: by 2002:a17:907:1c16:b0:a8a:6c5d:63b2 with SMTP id
 a640c23a62f3a-a999e695b1dmr120436566b.18.1728503924422; Wed, 09 Oct 2024
 12:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-4-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-4-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Oct 2024 12:58:32 -0700
Message-ID: <CANDhNCojYH=c8Dqgi2nPP4tK7QPqxpQMLCCAyrDJbyhv2761gg@mail.gmail.com>
Subject: Re: [PATCH v2 04/25] timekeeping: Abort clocksource change in case of failure
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> There is no point to go through a full timekeeping update when acquiring =
a
> module reference or enabling the new clocksource fails.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

