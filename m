Return-Path: <netdev+bounces-230166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B373BE4F98
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7356A188CA5C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829EC2248B0;
	Thu, 16 Oct 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCAzbcHv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1057464
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637683; cv=none; b=HY9A1gAJNxL4r9Z9IBfCiHsx8J7Rk9LKUw/4BIs19DOPsUURT38S/tYi3RLP/tL+j2YCfWhGcAzweCXlYXgCifSxPFfN6qyT8uBLPJLGfd4TAxNL4c/+2sOk2ssErCrSlPjKCGwmrecDJy5Z8pt5yUKrIuDEwQ5kYFmCrBVTHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637683; c=relaxed/simple;
	bh=efm1aAhK9B0AUbBIga9BbPWfhxR3h/kATOEoWO0lXSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixkuf7bzv8oWhms95LfFPfH5/gLgzX9ikvounRcRhgVdPqwKk52lZyUryXnetPn31kcS7NQAPMnjXI3uYlwLP5azYPXTK8iOSdRIm6uGhaX9t+YtKd8wvUZwbntLvJUuGtdhEZEgdl1a2i+hAmjj4BV+tBGT7qdWTgGDVCBbJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCAzbcHv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-88f2b29b651so145884685a.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760637680; x=1761242480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQDQw2Zz7nPALlC+aZk2XdJIOsrHB67rv/4hINgyaKQ=;
        b=KCAzbcHvNDmlmDrFV7F07b9HCi5z0zeQPHmicem1Bck/zpg/16nFHKjZetJLlNFr4g
         XXimvtukdRM4BiBMUZbYtoicevdZa440TzyNukqYW5/nSPUWrDD4c6NXTLYsU0lqgZlr
         w692RpnIIei/3xEmJS34DLYxzyJnhzBH9RdQ8dA1hd8kpI2Hm6CgIwGbhb6oB4vai5FR
         4vDQU+8LTqOxkQaWoyohSoFo+eURESpciwEu80T9CKXHShiUXNcNg+lPVWQbC2dLimF8
         LrRR5/3fMw3IocshVipvXieYAv/jzoDRoBw1G0xIRKb4fDIZnVlrvh+w5wfT5l0zlJ/G
         9FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637680; x=1761242480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQDQw2Zz7nPALlC+aZk2XdJIOsrHB67rv/4hINgyaKQ=;
        b=nYVRm+Xx/ERymHmikth1fbkQ+pldidNcGaYjGLk30JP6F4zhGoQaa3SakpWN3kR/uV
         ioGl5sJ/CQsWOozRzBu+Jee4yPz88/WUwKISpfy4IoW9uLj9guLBzvBv+4hNP5TmXkb6
         TVe9hmzzmMlPZIM66DIvsEMQE+5TlGfmuj+krPH59Jx/OvCM1SuPtT6mDidIRdzYlzoF
         o8zUAMIcx++y2lRYpFTL87aRU5nXjZzFLdiI03aY+PYwS38MRenZPBiTTCCkpd3EO4rd
         ozvNeozpDUhXWMA/Lpv+AIwcC7NyQly5SFyiQi4JZnhhIJVeSbJFT/9m5mKFE+Izxfor
         ldRw==
X-Forwarded-Encrypted: i=1; AJvYcCUsPkLZlfFLbhaehbWku2ZckiasqMKm8AIAImuAbRlcdc9v9LTbZjwEIt1bci1HfYtnp+QXylg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrfyWiqIJSMOwHc8dU/YrsEIdHcckISDL0UL4AXSu3IfbnBZT
	oTIjwyKpZZSrF9uRwGAoJMpwT4bT/vr4X/V7shvYjq/2t6+5MWYBf7NfM4QXEfhU9H+lHcBIAiL
	2/x1/bjACRd/lzDDG1/mXNG8BYYxO3DxMF5iY/Bs1
X-Gm-Gg: ASbGncsAOL74K1As/7ae2KXMfm+aUX9iFLLnKOnCAAW9SKVUDWlZQ9+xmrmFwlKocHS
	HAvH6Icw9OjQMktJ51zVsO2OwXHva92ob8zVTvAcpGFHRdphfZRJeiISI/YVUKelveOhIVxpGut
	wfbRlEQZzXFBId3rk4ixadOTm+Whp1fjfqMx9ZQjJGI+ilqRn9qtkukk0kHdiRqz2DrEazQBxH4
	HUHjSKJYZsrHNIXAgkXaA23nNIw07NcPvciqbR2W1qiO7WayW1J2xHeNdrOHw==
X-Google-Smtp-Source: AGHT+IE3ZvZtDScoLeW07g1X4xgiOQoi68aAnngD/UQ2PdkMefEfYvNx365v2bnhIeN5LzO5IOz7pWiJZcEJW9j15qE=
X-Received: by 2002:ac8:41cc:0:b0:4e8:9e9d:556b with SMTP id
 d75a77b69052e-4e89e9d5611mr4695711cf.54.1760637680070; Thu, 16 Oct 2025
 11:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016115147.18503-1-fw@strlen.de> <aPEkQA6cF2-STgv2@horms.kernel.org>
In-Reply-To: <aPEkQA6cF2-STgv2@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 11:01:08 -0700
X-Gm-Features: AS18NWC4zZq0A28fXWQuCEeJejhPcJJRqdWp22EZA7o2fLqmE1E1GlRlxsCKuAs
Message-ID: <CANn89iJDMuzUDP=NBk+nV-i7kWqsLyXFY4KyXehr3_pdsp5qGw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Kconfig: discourage drop_monitor enablement
To: Simon Horman <horms@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 9:58=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Oct 16, 2025 at 01:51:47PM +0200, Florian Westphal wrote:
> > Quoting Eric Dumazet:
> > "I do not understand the fascination with net/core/drop_monitor.c [..]
> > misses all the features, flexibility, scalability  that 'perf',
> > eBPF tracing, bpftrace, .... have today."
> >
> > Reword DROP_MONITOR kconfig help text to clearly state that its not
> > related to perf-based drop monitoring and that its safe to disable
> > this unless support for the older netlink-based tools is needed.
> >
> > Signed-off-by: Florian Westphal <fw@strlen.de>
>
> I think it is always good to guide people in the right direction.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks Florian :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

