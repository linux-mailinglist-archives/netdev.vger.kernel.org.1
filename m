Return-Path: <netdev+bounces-181135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52EA83C05
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D31B642AB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E71E5729;
	Thu, 10 Apr 2025 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRtgeq4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B71E1DF8
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272298; cv=none; b=fABbwxq66s3EtPDgnfLcaRgScktjQE69AAykNYkFnK7/F8z1uwMYyLrvlZ7mpef4LfRCBxSLtztiLMxqDGFv4vjzSHMI7eIYsKYY9S8+37Ur601xUBjRVDmQ4bsvH2W4mLruCftlWyGWMF+NrHcIOc1X/Hcut7ed1TTn2H7DrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272298; c=relaxed/simple;
	bh=meSSP8a70ro5KR6XsGtVh/XPLlTjZJaf5Hv6He5tEls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ur+OxTY5TOwNTk6VH44ad6IZFruNhBE90iTMkc+k+/lgqSuvhnbbSwLM4zEeJdou/Nz72/CznqET2XXDodhn+0qm18C4sX+r9cFW5IVrDxkIPjzuWhy1w94czYhfe1WNr/E9iW2m6HMqK/VO2pWh8SNgpnLgLWgtOqvSfhxQAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRtgeq4R; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c592764e24so57845785a.0
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744272296; x=1744877096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meSSP8a70ro5KR6XsGtVh/XPLlTjZJaf5Hv6He5tEls=;
        b=XRtgeq4RKH4LV9kVH3sSEl0m3vMEKdt2NbToZyyJ3JpgxQEXtaqIVFA82M0ZZYX1zs
         M77fOwOk1pjIuqk3K/ZRViC2/j/Hb7eZb0nppfuL71yqkn+E+wCqpxH1dPjWWheRlYyg
         b95V7H/7LWkG6IoyCgcGx83+soWgdEuhed8gKN0P3FTCgMyanHMujREll+dAg/AfjbAY
         J1epYTQjFtrF3KFYTDNvWzTLNlcWu9NT+O6RP2FM2HZuqjkGGARnzkinWRDbWVPEtIq0
         BQE0RhOcU2MqYQOPdwRoipWvxm8ESudZH8zkNZyYdD7PVNFuobiifV7j2MTsZWVFEluY
         FX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744272296; x=1744877096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meSSP8a70ro5KR6XsGtVh/XPLlTjZJaf5Hv6He5tEls=;
        b=JSn+uUYpE4RRAcRADnzCzgRH/6g5o5WsybFRMp4IRfqcfxoS3fvcCadpLp6r+XtT+x
         irpIeyhc/dF97cdv32lLm1WILxw6V/u91UnfaeDnKH0z5uGx3uFAsUQMZRBPYzJPaLJ3
         8OyPwZOx+SnYLw2o6iReiwfIRTBrEZUMbdnbdrzvvgXTSdVS6A/T3Tqr3kwYEJwNWZZZ
         fJLDHeV2egZxnmfPJnT1erh2fxQRWSeSWH6FcPIQKT5HiTnwndpSzi5n2zk/tYvFv1Y8
         AG+jxaSmQSJC4gHTFN/tUyirR13rqrEsn23B5E1RtweqyXTAipoU69fDc4W8Iza/T3QE
         q6aA==
X-Forwarded-Encrypted: i=1; AJvYcCU2MQm4rpSD1yQurEHh37ECkXxc1ahpDvjfL4Ua0YpdToOYpICQlQumUTxuB2z15IagLQhN9lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQs64A43TQUuz9YHwnjnA/XcNUabt/kAcZO4/Bwy7Huc5sVRh
	GNNJfREXGgzp7ImtQhvjyNyO4sC5HHW+lGpWF2c6vRWXPm31sJ++Q/J8WhnoC+KXcvkkQJIFbFj
	gGBehrLqMlHNo1Nn9nH9ch4d7bFfYcUnFwx/j
X-Gm-Gg: ASbGncu1sI1jYUhw6Xf8ZLRG1Ymxh7XSriBwjgYSqBa2sv2DyRHsp6EwDS1vnU1XfY+
	Rcjz6pkJR2oAoLuIkJUJioooyL7oHXCesKkeAZ+iq3IbFFeBIWwbRcjdAh70mYqFjS/8chnfChu
	GsIGtKLnO7e57iYyvKS44haQ==
X-Google-Smtp-Source: AGHT+IHnRoD7AjtOsJpc2K3JrlbTQWZaQjx3IprtXz+uXHZfGGRJtSOFutrwzuUQicc+jUPnlbCkJ5k6h2a3aQNQnsw=
X-Received: by 2002:a05:620a:4094:b0:7b6:cb3c:cb81 with SMTP id
 af79cd13be357-7c7a76b9749mr250640485a.18.1744272295691; Thu, 10 Apr 2025
 01:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410-fix_net-v2-1-d69e7c5739a4@quicinc.com> <20250410035328.23034-1-kuniyu@amazon.com>
In-Reply-To: <20250410035328.23034-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Apr 2025 10:04:44 +0200
X-Gm-Features: ATxdqUGT0OfB2mWkqNiahR6P-89QRZDY9kNVpov5Ci1k3NZwNDvCbVoDxpoCgdU
Message-ID: <CANn89i+-V5G7XTDEd01gH_+efCDMGA4hdF7uRjYv6bsEqkoQOw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] sock: Correct error checking condition for (assign|release)_proto_idx()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: zijun_hu@icloud.com, dada1@cosmosbay.com, davem@davemloft.net, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, quic_zijuhu@quicinc.com, 
	willemb@google.com, xemul@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 5:53=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> > [PATCH net-next v2] sock: Correct error checking condition for (assign|=
release)_proto_idx()
>
> Maybe net instead of net-next ?
>

I think this is a minor change, I would not add a Fixes: tag and risk
another CVE for such a case that is never reached.

We do not have 63 protocols, getting to 64 limit is moot.

As a matter of fact, release_proto_idx(struct proto *prot) should
never hit the condition.

