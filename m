Return-Path: <netdev+bounces-247299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A8CF69B8
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 04:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58B5301D0CA
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 03:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BD77F39;
	Tue,  6 Jan 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="fkB98fNk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C641E511
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670390; cv=none; b=lBUmM1NncIlU3r6rTk9kgQG94iRZ0PXotAzJ+8bxdPtngv50OdXxzxPFn7LYBJEeL9Us4aSIrxlR+MORn4DCESvOTj32JXGxKu1Gv3t/8PYO+sNhGa23xfP1Dk4iQ152sFaxUCR4z1ZPDzMtOAIepWoOUsiyy1XjDT5AUtRn3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670390; c=relaxed/simple;
	bh=HuCygfmQ0Httn50tdmKYk9/QdTYXMXZOpIIRHtoXA4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWERn5JlWIH2xJCpO/kukXoqoC7x6Ztgp2b0o5tR/HWjth6f88WBzqMbJJgYJr4BkwH/ib3xOhlNFC/XHaZg9ziYEvDAsTqdGvwOBvBWAQCSRtvGsdAj5FDQqxh2qj1FhpdSHwsECp7uxV1vzs4kMsFYnGILKRRAzl2EnFkgoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=fkB98fNk; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a34450f19so5437406d6.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 19:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1767670387; x=1768275187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuCygfmQ0Httn50tdmKYk9/QdTYXMXZOpIIRHtoXA4E=;
        b=fkB98fNkOUAKF3IP/5ze+fk3uFXzDmPtiMBYSt+MZhqzbcRUsI6vDUu3VCX4QVwMCP
         gwgQ4e7qt/D5tvXdMSpiwtS0IGLfRQ8kOSD+KBnmi+kUQptX3e2bFxiG4/n+S6dB/ZPA
         JDJ5qXDMvaPD4MersZLWseUHYx+fM/1fKlePwHt+yqzGOC9/mPD3EWSeGsxUL/OZCv/d
         Q6NVioHsWcCxtQzsEPz63i5dEe7wj5vZf/azuBETeq744y32W5lre2D8mGH8oNhyaE1x
         f3jw96iFm8paQCYRTDctKETwxWwCYmScHWhWKOT5I7EVMiudRn9Bn8YvNnJ0ZR9coWPZ
         DagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767670387; x=1768275187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HuCygfmQ0Httn50tdmKYk9/QdTYXMXZOpIIRHtoXA4E=;
        b=mjYUHzA6yhSsKZlKuAOuVZ15I7Kx6QMvPxTh+Zh061WSlixkm0MKEtq8lJGAIN1qv1
         Owmie/5OJ1srSgSxEs7qRZsiDxvZ8JfH2IiqBLjYVFj60MoiJ0HyicdZnJP9rFVHvVz/
         TzxvcAND6TyVtsmYHUERY02oQErEpeMxIKo0d+EOeZzdYyET8P2G290lL6yDRejFhwhr
         EbKZUclZOPuMlQDZ20QRQEiamLoczmvUc79dpMC9fdnzZ8Cw18c9S994+e4Bt/ZpIFoF
         sVIhtqdjeLrUPu9j76cCAAZn5P0mIeRE7R3XkjTFVNmIwrAsNWxhSJAyAENPQqbx4Wh8
         Vjbg==
X-Forwarded-Encrypted: i=1; AJvYcCXFZLjk4neWG4A61OdA89TPSdvDmUXIkrvDmxVQ6o1UIt2W1w1SCnxNioy4cCABsD3w9c8JC4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAQZEOaDiQQcex3FLgxUBg9zL0b7EqD0e2GAhTR/GXF9alXj8
	Pw1dhnoOBYkOKwS4kN7hWd47szCcuGHf6+0XDKTpqTJPETsXgFWOQTUWrlEWvklD5Jq/a4rX3vO
	Qec9XEO9BAbT/byIPWuQfaLCabOKt3lmACE9KvXj9
X-Gm-Gg: AY/fxX4iDxHkkikcS9AibhV0FkzhjSyna4asM2DBlb6qHEG2JQ7EMlxYNwjtMEaR2wC
	BgCI+CENyHJkPnhEjXtV/T9xl2XsmjyYIOJG6tYijcaAKjvbKPP8l8KgTMO1T3mWcAJzJ2PXS3Q
	pSXDT974lAICw74j1IV5iI/buCOiColoGBypiZuk3lDt4EeGyrtvigZyjdwt5Qi/F6kwr4+MBqS
	gO5MMXfjiy/9TBSMjcdXHxxyOQ/lzCBwaTdN6tHE01/mDvQWZlovwfKwM7+mqEsO5jhnZcb
X-Google-Smtp-Source: AGHT+IETG1vgJcBcnKK/4sElXePCrOMoXOf0xmxDz9rAshuA2ndOUh0XafyXTm4oK8KAS+tCDZiiOZTJTlWM3naBcWg=
X-Received: by 2002:a05:6214:2f11:b0:88f:a4ff:454e with SMTP id
 6a1803df08f44-89075e57d2emr27113756d6.10.1767670387350; Mon, 05 Jan 2026
 19:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102013148.1611988-1-xmei5@asu.edu> <hvgvn5n45dla46vehvoi63frvkzk7s2wnpbi6l3mrbfl5njk2y@ttfv2gestxf2>
 <20260105163052.06bf29da@kernel.org>
In-Reply-To: <20260105163052.06bf29da@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 5 Jan 2026 20:32:56 -0700
X-Gm-Features: AQt7F2ql1l-boEkMdPCEGf7QzJov4ufVOZCzJOTbYesVhfU7dVBz1WzH7bge3vE
Message-ID: <CAPpSM+Rv8tubHj-Y59wO99MgjdVsOL6VpYU_MjzVTe37=S5XXA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: sch_qfq: Fix NULL deref when
 deactivating inactive aggregate in qfq_reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: security@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the tips. I'll update the message information in the v3 patch.

On Mon, Jan 5, 2026 at 5:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 1 Jan 2026 18:35:06 -0700 Xiang Mei wrote:
> > For the new version of patch, I attached the crash infomation decoded f=
rom
> > scripts/decode_stacktrace.sh.
>
> Please build your kernel with debug info and run it again.
> scripts/decode_stacktrace.sh should annotate the stack trace
> with line info, looks like it only decoded the asm for you.
> --
> pw-bot: cr

