Return-Path: <netdev+bounces-244040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC4CAE4FE
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 23:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED2A3061EBC
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 22:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB67C2DF146;
	Mon,  8 Dec 2025 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Q+uVixpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87B24C692
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765232297; cv=none; b=oXAVQ5jRJnl5RUQStTJAs70nUXTGFrHcybpLFmiTkbq8rBjfsdcV9yvZGx8sCWN9CjXIha4J9rPSC7RmStTQVlJXpD+sxm0gWkxbDo6XN7MfSVncAeY2jXTorJqRqScEiu6J847jX5DAhBqzLCEgYzMo9M7nb/boJhH+y7P0Dxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765232297; c=relaxed/simple;
	bh=CXqDrn499vkP/7pAKdTMT7A76pjQqRyFDgh2clUvMm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RidmSFk3bmOhGM9qKaOJQaMP2i6GGBq8BVqLnWG7+YiATupnWdOh5ga9h6CrVjSzpXnwjz+YZ4E2STOLahqa8xRzglQPmhAuaWpK5+1KHZIQYOIQpkd4vT3z7wYeipUhwNHNeQ7gfQxsxLPqFNc9s8E1xJtiSSq7xEFNDBtkgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Q+uVixpN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed6882991aso39901341cf.1
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765232295; x=1765837095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXqDrn499vkP/7pAKdTMT7A76pjQqRyFDgh2clUvMm8=;
        b=Q+uVixpNyqHMvyNU0WBHdkAUklYcHD8kNMKiWEVFBoO1OkzwN1fvxs0LYhSRx4QGVH
         xnJ8gcV3FhuWYIvC0W9Uw3daw6yhJZrJenzvBkTYH0vmAlCgANoIbnXC9OUERCP/F0QK
         NDE1KxDqIS7341ugdAj3az/Mnwh9bP05u+c5VITgpF3qkoqTqmZO2+UYpYXRw1sIViHS
         wkF2qHw/zOZjorOaM7prXvItRS7S8pqzF/1hiAR2ER8ob1XBqQ//AuBpsEv+ZxReSGJa
         lYDXZLTUI0uSD2tfze2rHVmFyBZHYwkhmUI5uqTiDhACdBvtpKZPGRE9yIGaLezrPYDQ
         sNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765232295; x=1765837095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CXqDrn499vkP/7pAKdTMT7A76pjQqRyFDgh2clUvMm8=;
        b=Bu31bj3wkA6Vblni+OFJWiphJMDehB1KylHKnrTXLP8RiLOzya/9Abb2Da153xGGeJ
         95FEF4NUU2ipRqoEWcaONAuLfS8wGJbcAmvbo0tI8b6h4i1vs5KS0neSSRtp2BXR2hze
         h+eSLR14zodX7uu9ogqw0xuCCUwhniL13sm/nMG7Gfhov6g2nZkgyaO3/ltREfQa62OG
         Dre+Kf4j2mlsb+jspL23Qc7zh1ykUXqo9ywN2rewY1PaRLwoZcuCy32s9fPhAs8KYqbP
         hKsbwl1KzbVbF8Mb7ETgF4rKWr+jgcGVIWeiNXSTm8TSDfD0Fh4aGziP5m3rlG2fCJjG
         zSpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9RP7LFNpVq3l/0D3SoFjPnUUsMAIUQ0gtUqk6g3vvt8E7nH5tfInvxBqKrs0ni3TuHCRaW3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+LJEXyW6t5yHquh+LnPqW2BShKdhBqm1+LMDscG2qtByla33
	Du0iOTEeKeSrUuFO54ldbkFMi109GdTjXCz25KjMnCI4FoGCnVXGAh+Q2wCZZkJy8qMYpwiLr1v
	ZdToAZGFrgg9ppLD1yx8mBzAW+JM460wHWqdhloavoI4GvD04nJCy4A==
X-Gm-Gg: ASbGnctjSYaU2tQfjjPKcTlfjEyTxhr9kzN4hNG+4JOg+CQ8Kv5T3C0IaxBk6ubNFOY
	+EM5Nlgrpi3yZ9yiONAiqi8YmU2b7MkEtfFYYqd+FhQXVwuyEN53F4FAySydaLX373k+qOifrOD
	uW7CYXMdlfHsrug3qh+53B6Cx4ecW1hfS+/DVQ0B+/+pr7+dSQ/L0V4ejascf0EgjNyKNHcRRlV
	rt9GsgcQcjWNjaJpXwjX8ly5Sg9K40SqnmE2e/Cjq7bNcG5UhvWeqOauPziPYkCJJzjh+9+SWXZ
	2cvT4FY=
X-Google-Smtp-Source: AGHT+IG9K2MdIkqcCs1niANQTQcxZaJZ0dlnTgjTalyiZmwDfjrNC7fVu9tpV/XJLSEGE4PNuU8G3aixn4o+vXvG7oU=
X-Received: by 2002:a05:622a:189a:b0:4ee:1ec6:aeda with SMTP id
 d75a77b69052e-4f1a421b1fdmr15300951cf.34.1765232294783; Mon, 08 Dec 2025
 14:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205014855.736723-1-xmei5@asu.edu> <4mxbjdgdxufrv7rm7krt4j7nknqlwi6kcilpjg2tbcxzgrxif3@tdobbjya7euj>
 <aTYDlZ+uJfm7cQAn@pop-os.localdomain>
In-Reply-To: <aTYDlZ+uJfm7cQAn@pop-os.localdomain>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 8 Dec 2025 15:17:57 -0700
X-Gm-Features: AQt7F2r2UvtsCY05sJbZcWZ_c7e6W06l7KojrgWAOKVPGTJHh6WX1CDingKfLLc
Message-ID: <CAPpSM+T51DDkcSehkc-3r3FbcYQzXkTq4LGx8RRfD2fACwM8pg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_qfq: Fix NULL deref when deactivating
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: security@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for not explaining that. This PoC could be complex to use TC to
trigger. I was thinking about the same thing: transforming this C
program to `tc` commands so we can have a tc-tests case, but this bug
is related to a race condition.

We have to use racing to create the state mentioned in the commit
message: "Two qfq_class objects may point to the same
leaf_qdisc"(Racing between tc_new_tfilter and qdisc_delete). I failed
to find a clean way to use `tc` to trigger this race after several
hours of trial, so I gave up on that. For non-race condition bugs,
I'll try to provide self-tests.

Thanks,
Xiang

On Sun, Dec 7, 2025 at 3:45=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Thu, Dec 04, 2025 at 07:11:12PM -0700, Xiang Mei wrote:
> > The PoC and intended crash are attached for your reference:
> >
> > PoC:
> > ```c
>
> I hate to ask every time, but is it possible to turn this C reproducer
> into a selftest? To save your time, use AI?
>
> Maybe I should add a warning in checkpatch.pl to catch net_sched fixes
> without selftests. :)
>
> Thanks,
> Cong

