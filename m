Return-Path: <netdev+bounces-138899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5E9AF563
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A21F24A0B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A8218581;
	Thu, 24 Oct 2024 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqMgaNrN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8722B644
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808967; cv=none; b=p0c4fBbk9efYVQu5SXsRmItF5VHE1rCUb17OPd+6mtzwnY4sMEffLFXlpP37zlNKEwfWbeNV9fOU0ALMbtyRwQZXOeUun2WX6k6QHHilNesB1WRL00cvfV68supSsa8f4CBm7bawdMTffquJwNDt5A2Ufs62y21yB22jzvA8I4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808967; c=relaxed/simple;
	bh=fTf7NiontjVxpkvw+lLYNC81W5vLDGAzeU0TCcUfWnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRqFuI0rqg46MEZg429oU0VdOHSpbv2t9IcoDAkx2rwwl3Wog+ssSwOAufK1EBThsrnyCCqFKilx7EpgTH/gmEkwuf0fFV+MyLmO23xcEDAE+c4wJ3Ul8ypYdGiSBhpK1EMjSPqBTHeEcWHpi2wau54q4JECSNbO38RD42ilxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqMgaNrN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a4031f69fso194183966b.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808963; x=1730413763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTf7NiontjVxpkvw+lLYNC81W5vLDGAzeU0TCcUfWnI=;
        b=UqMgaNrN0AABY0U0gCYmZE8CaQ7fPplf1/6FYyLE70MyvB879f6AxUq5Pk6WSomwPa
         tGWeJ7T/GJac+8enqAXNrOY5EWJSnscHzF6cQgFtlmNT7eT3Kd8TVhn8hYtK/MURU4ql
         EfrLWFeoxbJK3V4p71XQzS7TzZaeH+cM31rXwmvQgDLhBd6h6JwGjotJ09JgitDMWjTZ
         xmK4rnih5Tv7aLQYU8OPycCtlKm3jVH4ZVeKbqmm6+4B5GOZ9x4GuK4G/bujFt/XXToR
         XP7gMpuo8U57qEa8ZtMhyrBFTYOoMKqOZG2x9lslTym5BCECUxzXcGH9QWR9G/GQQ6dN
         8nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808963; x=1730413763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTf7NiontjVxpkvw+lLYNC81W5vLDGAzeU0TCcUfWnI=;
        b=uJMdoHfk/0/UU8pxbGrfp6jCjaq9ux1cnG2wcJnoDE+w91SYkcCjTyfj3b4GSXuzYg
         VZqhFp5+itw28EIaiDd67XZYge2aXo0/WSg7/9g84Ge+05g+lra92cBFYdQknWhjZ18x
         SauHkV/s1QByWIjF/nVJ5r7rihQqnY2aLLkv5johSW/INiSkMppsKdMglpxDagfR25s4
         Boe00RbA/0+bY0xz2ijPofCsRjDaX0uDe/5491qdDK+7KPgByys4Ykn6rIajgaA6EFwJ
         v9tluf2nx31RK5FlglcSvHZ/AmEf8v5Be9ghRvIY3hTZx6J1SfKH9u0X3blp35usFu4j
         zx8w==
X-Forwarded-Encrypted: i=1; AJvYcCVdJeQwwZxWu0t2+MoGbqJjgGsOlTod1RzpqtT4Jf5a3nh2iVOBu71CjsZQnXbnLzp4GU9BGRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PXPM3YOPG0HrftHlXjbs4/XEzLiu9gD5fOtEauxd8sqHOXc2
	K0sX4rp2+4WTbmAY4gbVkbxxy5KJs4RKZabURgouaYhBOg3EW+vF9lR8bOGsNVoLYH57Ft+Tfyd
	j486Fgy/JS2A4cvdn2Tnmc+Cf+6RwJzBgoXE=
X-Google-Smtp-Source: AGHT+IEc36rAB8BR3DaQjrgb/NHilWXJBRfWv0wyuG153HxlKlI4YHPEaahgwR7NMaaZfstGKIU5LnVV8xSJYW//nlQ=
X-Received: by 2002:a17:906:794d:b0:a99:f4be:7a6c with SMTP id
 a640c23a62f3a-a9ad285ee47mr307782966b.52.1729808962710; Thu, 24 Oct 2024
 15:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-24-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-24-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:29:11 -0700
Message-ID: <CANDhNCqregz2eyuw=n+Ci8kAsORMWp8yp3e5JSgxUOVD=6qeEA@mail.gmail.com>
Subject: Re: [PATCH v2 24/25] timekeeping: Remove TK_MIRROR
 timekeeping_update() action
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
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> All call sites of using TK_MIRROR flag in timekeeping_update() are
> gone. The TK_MIRROR dependent code path is therefore dead code.
>
> Remove it along with the TK_MIRROR define.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Ah, apologies, this makes the earlier change in 14/25 much more
obviously good. Sorry for not seeing the big picture until I got here.
I withdraw any objection there

For both, now:
Acked-by: John Stultz <jstultz@google.com>

