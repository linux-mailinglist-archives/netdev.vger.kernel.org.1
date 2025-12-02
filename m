Return-Path: <netdev+bounces-243122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3484C99B4E
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 02:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D8344C0B
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 01:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D161ACEDA;
	Tue,  2 Dec 2025 01:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM2OKF3d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7B1519AC
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637683; cv=none; b=KxpF0sCaZLyF/DTMYPSE0VmZwRqheu6t6HUbWp7Pcgg8G+R0gJlI0NKYoQreTVzz6CuFmvBZBnm4ieT0SY+Fl8s1XiBPplgwNIvupZPSdkObk2SD9kGst887c6TwylqvIRW2RKLKW49ZLPg3Ty+MWf4Da2//pPNI8o/4vIDlRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637683; c=relaxed/simple;
	bh=eWdulhp8izbC6IuzxMY+5OmK/0KTVlwK7wHwkQI+i7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZesPkjtGCk7KTXZ8Rrib40AEbYDlHbj9n+HpD4y3QT9Ic8vwTbvFB75R5SpkjHtzYaFzySf4fzCKLADaSxc2a2d4nv/OQNh4NOZyIpXx3IyiEJeRfQtA1nn80S+8kBh0vGAn0rah5XaVgzBrAMOHsBCj5UbaYak32X0jmLsL3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM2OKF3d; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343806688c5so3793683a91.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 17:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764637682; x=1765242482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eWdulhp8izbC6IuzxMY+5OmK/0KTVlwK7wHwkQI+i7c=;
        b=PM2OKF3dpL0/rAX3AgZXI0M6mvMZvh+4h23jY06kB6zsS54v3PsaJIClj4bilQSFmx
         dcTeZw5VdEIAc+WySLDQ3YzwOycfW1MKzzywoZZ6mVCgMowf9QgfQ9t7bhNGTU7zp63S
         l9ZYF7lMNpM1zC7g7G96t0PVot/EUIK4if3QpY5ELCCtdxez90hwLZcpf/p3FX3yMWh5
         T7CZzL7fLLVK7oPSqYYI5A9hSqvgXCFiZKa9KIhG6mlIuhj++oawRY5p/eXAT2FZIsPw
         myHgBLkhm/BD7UXO79j5MRzYJfO0Z1fqHithyBrmk+njtBMBMa95QCpq+vycNHxogGuI
         CTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764637682; x=1765242482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWdulhp8izbC6IuzxMY+5OmK/0KTVlwK7wHwkQI+i7c=;
        b=oRl+i/0POdss/4VKnq1hF8Ro5cRkJ1uiBxArHDzbdLmagNFK4VUyOq91HwJQIo93p2
         q2yXau96cy5VXweASVLdvL65ZC719CKFfdMCb5PXcITywPl9pvo/qxwjINg7n3PbiJbd
         VUW7PlhjuedyHF0SCk4dLXeLlVM4O8rmiPst4fKafUcJZApSBtKRRhBp6OegJjc3oIP8
         6CBuwjCu6rrHZyfidE+Kyds+BE6QWSMwr43bF+tlJs4ai2G5cLfKcrQSNiYQpUJA/LOb
         4BFM3JRfyFPVWbKU4kl5Ce1X0SccYCgwVBeAfjOJNazH6rSIy5vWgEN73VbDN1U1XZjQ
         Vr7Q==
X-Gm-Message-State: AOJu0Yxa125gIeYhZJVekGZdvm7WJ1Hi6ke1Xyn9PPZ/NWrqAtsUQLjp
	mL7ptjGmy5slDJ2yqVz1dX3qoqVfZaL49+j9eljnGGmh1e8Y3nvNeABh
X-Gm-Gg: ASbGncskg01uf/Qsyfiq/+hxrbhuMhENZxXfJZKrC5X6OwjIYlnltDxTpimRAfR+a6V
	Wl0UGk7L/ObJDLCDvtZyClsslpsUTYpSAz/VHlloAGRlGieUtXD+EHvYeJmRBTwTn+LbJi0CtPe
	SjXkU87T+aZuGjJk0RYS5pT88tRp9PfWE5vf7Eq2qra9t8/gVarPJ2xCJkS9TQIUmTLepBrsEVf
	2tC7kxY0YqXwXrrU70I3Di4CDycxA8ZDj81+ig6rUZeicGnIMDCACrBKd4XSes/sdqGoWSJRa+o
	sEFpcKmidB30xTk0EBfRG3qfJoYaJMp0w+oEKjz10WU0rGPqFiT+R+n60hFdh6NYwlYbzePHJt1
	0An8zZdZEIve6dDpxExZVw+0Su0H1v6oro+MPecebDgQFkI37IKNwqtsD8dj1pjhQJkqRcl/mc5
	a144Kk/jQczofcdfvxnXGIR4Wq4POik5K55SFO
X-Google-Smtp-Source: AGHT+IEl0WpC/9uypCc810uLwzQAy7UVs/eCHMADhMTug1ScfnH0wvQdnTIma3Kn3kNemoY/12Lipg==
X-Received: by 2002:a17:90b:5404:b0:32e:87fa:d975 with SMTP id 98e67ed59e1d1-3475ed7d8a1mr22979302a91.34.1764637681411;
        Mon, 01 Dec 2025 17:08:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:45ae:c5bc:5f53:e134? ([2620:10d:c090:500::4:ee7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b732b91sm14401415a91.9.2025.12.01.17.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:08:01 -0800 (PST)
Message-ID: <8da95cbd0f554e3ab62a40116f8fd08201a1d593.camel@gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in
 a tail call callee program
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Date: Mon, 01 Dec 2025 17:07:59 -0800
In-Reply-To: <20251202001822.2769330-2-ameryhung@gmail.com>
References: <20251202001822.2769330-1-ameryhung@gmail.com>
	 <20251202001822.2769330-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-01 at 16:18 -0800, Amery Hung wrote:
> Check that a BPF program that uses cgroup storage cannot be added to
> a program array map.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Hi Amery,

Mabye I'm making some silly systematic mistake, but when I pick this
test w/o picking patch #1 the test still passes.
I'm at ff34657aa72a ("bpf: optimize bpf_map_update_elem() for map-in-map ty=
pes").
Inserting some printk shows that -EINVAL is propagated for map update
from kernel/bpf/core.c:__bpf_prog_map_compatible() line 2406
(`ret =3D map->owner->storage_cookie[i] =3D=3D cookie || !cookie;`).

[...]

