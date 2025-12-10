Return-Path: <netdev+bounces-244178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A1CB18E5
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 01:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AB733079798
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 00:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174911EBA19;
	Wed, 10 Dec 2025 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="NlYniuXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841A74BE1
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765328279; cv=none; b=cxTGCyZ6jL+YNK0lo8eru9MqzzEotS/nSwQ3YwKy5dlvZfViJ8oLFRj9NlQdtA6NeNw65XPtbZHgPVnKKvl+ALTbpJ7U0GbvMl2EK5jIB8hQ9XCBV7b0wSh4gmetYlfZ1+S6MkNVZJ2ggRS3Ny9xJtneI19THcVPgGxMqaO+lAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765328279; c=relaxed/simple;
	bh=rZMLizMIup2jepqNI3dv/W2X7OPvK5Ie/TjnvbMSYIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJy1r4OzNy+b6Goeb2gEshNk5lVXEOGNQhct4ta8jARr8fV4DYRyU+Tbv6064BcZ7ROklAdgWw0gGfsnaXHc3p/iI5PfzqD/Je5iAIPhnnaQj/yVwNoORNIOuFdGOA5k6+McjxHyRdzl5F4RqBXvTXFco1jJOGNZSLXm+9FeETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=NlYniuXw; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78c5adeb964so15721237b3.1
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 16:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1765328276; x=1765933076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl9HQoJJHfF0UVdoBJcE1XlRpDwFjAh5aCNInx8N6+M=;
        b=NlYniuXwMh2/owJQhKlzrUe2bwBxoLnr5HSMvnONWRz8u1lANEB2UBtGEpsHoksg7O
         xd1Zk++DTtwDejlvl4zyY8sqNrhQIlofaNuBB6+t8+0DC9zgUIPG/JqjQJE114XoNA61
         iI46Njh6jm6h6wTredttcXQEhc0O/7o0JkYVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765328276; x=1765933076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tl9HQoJJHfF0UVdoBJcE1XlRpDwFjAh5aCNInx8N6+M=;
        b=BIi0qvyudZkK4WVC7B7+trrHrZsOCbsc1Pqgp4Kots7Wp94bWE0RwR2nW6Ek5A/k6j
         +bJom3pkwSmLBEGMfii/d2wAHyQyCLeGPXQPRo5ZIDktiRTngnpWt6qDzwNg0PKkDR58
         mZ1Y9nmQ0eGYdD3QKAvGMmsoRDSbOnfyOchnaGLUhnjNxO1yh31pal6+u0cBjfVnn3pU
         7dRmg2buycY93vIzjPomDCAUjRaSZcNTcepRBUlxiEy5gkVVSHPmSHzNoYXUc3eAmW92
         VsD1XgxQ8r+kGqUAH0Owu/UuFb8dBRVD//9WiWgTm764oawwItTDlYtoSAKXjur1e4qn
         Cpsg==
X-Forwarded-Encrypted: i=1; AJvYcCUZff+pBFaCDTdp1KR+8lw/thrZ+qUsQb3J7lC2NdhCcJqB+w4M5xhDkSOPA4iwucyWV5i6vXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrE0ZfG16i0QAQhn9zpevhmLmQLZ2YdoH+V66erfTtqgDDVssc
	s/Z3516w2YwOeBToTorcWC1vrXGI5igHFEGO5blsWzy0kWbQyBunnPripZlC1fi3qElw7L2b/5A
	wk3wdKFTfhSVB3ut7ObU2cTwrKgzNlB/wA6SrEaDfsA==
X-Gm-Gg: AY/fxX5DNjTqaAAlxnFMdt/MvSK7K+8T0tVJAKN/U+FDyClo2PYPdm/pOPx3M37W+ri
	p+XE83RYTATkiHYOqMKwMt4MrZX1Qmr2WnAXx9e09B62GPM07NAUb8F44aUyHPDkbDG49NjZlcM
	hn7+aiTDK6xd1q4wltjUaYSAX0lKs16QIBBMZ5KI2R5N4ctXa8bkID/BDt4kzqRBqQ3cx+TPBuc
	IZKwCcymMr4wsCPer3BLAChamDFqhdLa4JKAS40iVIlMC+JjxawVZfvTe5yVNx3tPJHHx11B2j9
	w+F9yL80
X-Google-Smtp-Source: AGHT+IEhIWA9h+HCi5nUxtPHlwVU+Co1FUkf57FGZPD215aGGaS5M7cPz6X3fKiQ2+h/63IHbhwLXOs6YbrHiSbY8/M=
X-Received: by 2002:a05:690c:610a:b0:787:d0a2:1cb1 with SMTP id
 00721157ae682-78c9d85f3bfmr5504187b3.53.1765328276337; Tue, 09 Dec 2025
 16:57:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203184909.422955-1-chaas@riotgames.com> <20251203184909.422955-2-chaas@riotgames.com>
 <0dd3d9d5-2e44-4a6b-a8f6-d997a979e128@intel.com>
In-Reply-To: <0dd3d9d5-2e44-4a6b-a8f6-d997a979e128@intel.com>
From: Cody Haas <chaas@riotgames.com>
Date: Tue, 9 Dec 2025 16:57:45 -0800
X-Gm-Features: AQt7F2pkB3kPftzT1blYPKdiletMZfEa9NP2_sfzNnQ4yvveslI0EG4-AwdauMQ
Message-ID: <CAH7f-UKnU7AhcB-JMqMcaw3vpYN7mi=xQXjQUENp1A+QSpVseg@mail.gmail.com>
Subject: Re: [PATCH iwl-next 1/1] ice: Fix persistent failure in ice_get_rxfh
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 2:36=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> thank you again for the report, and thank you for the fix, it looks good
> just some little nitpicks from me:

Thank you for the response, I'll get working on the feedback right away.

> 1. this is a bugfix, so you should add a Fixes: tag with the commit that
> added the regression (I remember you have a "slow to rebuild" platform,
> so just let me know how far you have reached with bisection/looking for
> the root cause)

We recently moved the e810 NICs we have onto a server with a much larger CP=
U so
compilation time is no longer a concern. I believe the regression was
introduced in b66a972.
So I'm currently in the process of bisecting to verify my assumption.
Just running into an
issue with building the 5.12 kernel. I'll be reaching out to the
kernel newbies mailing list for
some advice on handling the compilation issues.

> 2. bugfixes should have [PATCH iwl-net] in the Subject
> 3. you should CC netdev mailing list on IWL submissions too:
>         netdev@vger.kernel.org

Acking these two pieces of feedback, I'll add them.

> nit: you could simply "return 0" here
> then the status variable initialization during declaration could be
> removed
>
> yet another thing: for new code I would name such variable "err"

Acking these two pieces of feedback, I'll update the code accordingly.

Thank you for your time

Cody

