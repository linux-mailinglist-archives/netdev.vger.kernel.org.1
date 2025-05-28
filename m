Return-Path: <netdev+bounces-193964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84652AC6A44
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9BE4A0BC6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671AA286D58;
	Wed, 28 May 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXHor/Y7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABFA28688E
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438587; cv=none; b=uQx8/CO13i6QXUrbqhTdEPzcyzN91ATn1bmRSg5yVaQ8oQQ1WFcSUgwlauiC/DM+ub4pTG6qNIN0I0ky+DqqB4OTRx42I84NKECdq6zWm/ET+OLSVgJd0ROjRb6RXIWhSYn4wJ25ak3t0qK7pZokrfQEQHS5OUwUkqto34ToGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438587; c=relaxed/simple;
	bh=wLAIAFZApvRfJYt9cSIjJYMbXnMPn+iDGWN+sR5UeVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=au3PDJdkTROx+eBoxBsS8McXm8H2+Ig7wbzedUC1ephO24jPWjkOj+KqSYIDL8E372dRtnOSKohFxtWHIc6jd1tXNi3xxpEejDa6JlgFv3cbSdtzG8+QDSone1ioqhDhMd0Qq7gHckN6DG7ZAQdsXJZRTl5AUHMTTfxKliKTMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXHor/Y7; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476b89782c3so42609001cf.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748438584; x=1749043384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLAIAFZApvRfJYt9cSIjJYMbXnMPn+iDGWN+sR5UeVM=;
        b=bXHor/Y7iQUXdwSub6pJ/SULEIUI9E2G2oEq5gCdmBNzJVk/WLvueLT9dqNF6vGO0u
         jwZy5d+WWZ6RkjW0yV+i5AnCp96ClSK7wnVzflG0GZb0ljTG0NEvFs/sjhiHNbE9zIJP
         wZ5dhtaUWNiuPFYV2QBsHIqJBlZPgMTA3UM6KbHET60PIPtok/itn5OfFFTzXhpgEG7J
         shImmydziY1PQlihUm8Vdf4oDYFmoiky+Mq+bTSljcNVwkc2QZroAxVDoIiZsHQapUST
         cbnP3s8kBFciuwnQk8RBVGB79itJKm9m6SK3EEO1yOXSc1tA4oxha8hTscS4pjW6SoHS
         RTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748438584; x=1749043384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLAIAFZApvRfJYt9cSIjJYMbXnMPn+iDGWN+sR5UeVM=;
        b=BGop+cGuM08JqK/W11B+3nbB4uoM0YNsZEkyfjRUF9KyK0dpbKWuHOzKqJv8Adxa3N
         BS8IHXii6nQ7q6uYxH2PuoNoL9snSBusXhUw3W/GVR+ewY2VS1yh5O+HZRgtlrWkvR9l
         /P+rm3YMGaBS6YZNDRCMbB9fSa5fGbkb9hjJeujh2kAFIiqpHHAqtGvm6l213jaB8VMk
         3XPAqYAkhNJZmmyxLt1T+WeAm1ABjVD1Xtc2VwsnTRCEit0eZxbbQt3S6QhLzmF7GSNm
         GRDNtLweLd3A71DsqBoFnGk4rSSt12+6OARft/z55vvQB2jWTZSOx1Z3h6dFMCPhtjMl
         X6qw==
X-Forwarded-Encrypted: i=1; AJvYcCVnVvroOxBFwAECzv1xbnNHj13rgg8dRHoybhuZZhpcq27p34GvlUWTE86TkA+Y0rmRGDuQp9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwY6+mpiN09IupuwnKOacmNkALt52oJPA9Xu7mJZXyqC5xeJ+n
	P6LeMjkvhqKqu1P8Rufc5/qE3052waKCAWr6id5N3nyOd6WiZNidG6zsmfWFVOZrNTHTMPksHqY
	KcQ/MjgkVxwYeVxuPgO4VU0EHG7cFAHEIkxIi/ky6wnvXzPQW0nyYedfr
X-Gm-Gg: ASbGncuzemlkFIjn04jFNunJXBIXK5jwDjtFJpwn8TAxkqRAR2FWdNfPIfkY9NRieNc
	VZN8TeDhMGt4+E39dXo+gOlxeehg3IhUqsl/DbvjD22Nx94d0lLgFHYgy2HNOW13/+vzArpnFFl
	A2HgenDkvAaZKCoKkZilSJN6HoshhuvKjCeuUe6s0vULw=
X-Google-Smtp-Source: AGHT+IGbZYbMUUF0o/p3mJU8DlaGsdqh7xPg6DKlw1BJkyhZ4Y5kJip0JlOAmFjFmFCnoDaO4CJolysrrKy64JLg9BY=
X-Received: by 2002:a05:622a:608d:b0:494:b1f9:d683 with SMTP id
 d75a77b69052e-4a38c7dd4cfmr34934901cf.49.1748438584068; Wed, 28 May 2025
 06:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+C-qk-WhEanMS_tRiYJHHixH33MAO3u-wQVdWGJOjskw@mail.gmail.com>
 <20250526194619126ArX868H3UosA7Jz31tRqF@zte.com.cn>
In-Reply-To: <20250526194619126ArX868H3UosA7Jz31tRqF@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 May 2025 06:22:53 -0700
X-Gm-Features: AX0GCFuFbinN-PIix2adUwdlDdRnQDxrOpLHN9thHLQVIv65tW3K_tN3mCvIi88
Message-ID: <CANn89iL43q7tCETt3gW9L_HVHdRrovu9mauekA3QrWrpVSm+Ow@mail.gmail.com>
Subject: Re: [PATCH net-next] net: arp: use kfree_skb_reason() in arp_rcv()
To: jiang.kun2@zte.com.cn
Cc: davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, 
	wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, he.peilin@zte.com.cn, 
	tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn, 
	ye.xingchen@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 4:47=E2=80=AFAM <jiang.kun2@zte.com.cn> wrote:
>
> >Are these errors common enough to get dedicated drop reasons ? Most
> >stacks have implemented ARP more than 20 years ago.
> >
> >I think that for rare events like this, the standard call graph should
> >be plenty enough. (perf record -ag -e skb:kfree_skb)
> >
> >Otherwise we will get 1000 drop reasons, and the profusion of names
> >makes them useless.
>
> Thank you for your feedback.
>
> Maliciously crafted ARP packets often trigger these two scenarios.
> Using perf cannot directly distinguish between the two cases;
> additionally, enabling perf in embedded environments may lead to
> noticeable performance overhead.

ARP packets are local to the domain. They are not a concern, really.

If your local domain has 'malicious hosts', they could actually
trigger more issues by sending
complete packets, to make sure to fill various hash tables.

