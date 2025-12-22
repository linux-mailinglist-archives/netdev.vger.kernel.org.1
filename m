Return-Path: <netdev+bounces-245770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E4CD738C
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD3AD3015108
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5AC271456;
	Mon, 22 Dec 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX1RL1lR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168210E3
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766439999; cv=none; b=kreyk6OAHUWsZWiJPDDqkIw1fwaqlkbRyHKjOh7akQg0cfcRG7yapKMopdFzbC6PF9GT3fY2LDfNF+Cse8/eQt/0ikd3M7mP5/J8vesuhbEQ5kTu3RG7a8b0JSd/rZhW7Wj4iyNaXVWYJnd0pzT0FXmnVm7sTWX2NByf9JdDD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766439999; c=relaxed/simple;
	bh=1ei49KbANRq7CNP96JkkU9tfYeU+h+9EcASwiCoAZes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8VnzFu7B8H3REp9hd7pjZm8BgjiTDqutuH7jSNFw5eH509b8DdNgWqtG3q/0mmMEocjtZOmhAqtxdXSDhDVhPYsbpUj2McC3K5v0hNS28MbSsa7yUoCVX22xkufR46KsLbKQZTPX0ldnjqoHCAgzSzM6VpcPS/+AMWPOVFmK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX1RL1lR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso2906713a91.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766439998; x=1767044798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ei49KbANRq7CNP96JkkU9tfYeU+h+9EcASwiCoAZes=;
        b=FX1RL1lRDUY3VliF+VFRcsAy5HzlI1UVNoJz7xymfWIrNriCAhN8hVNHnULLYu6e7J
         jMEBittDRS2JLB2YPb2vmKN+OPQIm4hk0gD/KSaSLogQnTq95Y6fq2FqD2SGk4glQdSM
         vwUoq2SAByuQCkA358xeEiFW8Eg1174ZAfDKrRhLnMY59zeWhmm+GdbtVZj48Pp097pW
         qZLyyBV9yok70Q2RwqdXMu39QevjnU1ztT5ES0x0AlFJqupN0hhQar/xq/9lFIecVSTf
         90GnffISq9XSEk9/7vbtYHImfsD3SC8quBAbCKgIlX448cIwsWBMrzl6vQCHYpt2GQep
         iw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766439998; x=1767044798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ei49KbANRq7CNP96JkkU9tfYeU+h+9EcASwiCoAZes=;
        b=OmmoIqzobG0PuZQVEmnUb/YdRMeq/YuJ5h0sEMu+/F8igQE40hgB5uPL8yxDAi+vIj
         nm7KbRgihZ05ixRWp3KLFJnI+Tl13QPJQSB4FqkH0fukjWYbMC/fEOHcJEF/ukewti64
         lMEDq845nbv36tcfpRUjz7fYElvzUAc6lVHOX3N6T0O5LuuMooqE3JyO2/FgYySIjh84
         T5RVMoP0i/njvwsb2s4YYzrJ6JZhNrPCxBhKeX/y1Bbj89Rv878sHoY8yNOBlmGJkbj3
         0jxk0CUzAuLgFp8O7GN+dO3jJQv8NmTXiDHUEvGvBUlbth+3eC315evaGYb8hx2PYRS4
         dRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTABB6ETboJGT0XNRlKzEP9UCELVBFh2ttA+0behu5DjJpdpUMNrnsbr0kkLDcXk/sG44zTpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsa/CJ6Sj+aX+V7+mfr0J3lYwnfeUa5Tnt8VQuR2A0RawfIBUV
	pvqASUbuN0LQa6Z5h2yvvuFqxDljth/gvV0b3If6YKAAB2cDp0dnYHT3ljMtfdF7WdZUZHEUDZn
	GM04WrEf0kV74cC/IlkINh0AfE2yOvxw=
X-Gm-Gg: AY/fxX6VwJds8oeIoAsz74APTYM1QyvJ2R9XLSgSZvt0M7TSGX6KXSIEh+ieqCebmUh
	iaVEsOP7vywGCsZWk+wEV0E7ifUE/MzLGaFEFPwcTNcz1g0bAKxAlaXdW2RCzEHHwI1TulyT4kn
	foKU57NJ7/y4fLYg1vdCqH6wybtxUUWjzBGaRqlINupGv0IYuU6M49deURj/u3NhPVacnyuzFTG
	SCAIGx2xHe2oHp0+RHJJs4ACUA7UFgfMuFhL20baurTWmAt8cJ73cBmo4yxJ2Z9qhdcIW6j
X-Google-Smtp-Source: AGHT+IEbl7+ZZmM9l9yiXqj+1iV8M2uyhdx7/B1dLeFPQaieD8mnvSZ7tK7BajbfHZumnT7WeuMDteD+7UoTsy+hwRA=
X-Received: by 2002:a17:90a:e18e:b0:32e:a8b7:e9c with SMTP id
 98e67ed59e1d1-34e921cc9c6mr11180543a91.29.1766439997737; Mon, 22 Dec 2025
 13:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1766349632.git.marcdevel@gmail.com> <3cfd28edb2c2b055e74b975623a3d38ade0237f1.1766349632.git.marcdevel@gmail.com>
 <cfb231cd-17bc-41aa-9533-f1a048eeb1be@linux.dev>
In-Reply-To: <cfb231cd-17bc-41aa-9533-f1a048eeb1be@linux.dev>
From: Marc Sune <marcdevel@gmail.com>
Date: Mon, 22 Dec 2025 22:46:27 +0100
X-Gm-Features: AQt7F2rMalKEvyczmATgtY6cFb-CnwW3cyICc11O3TSpcbFnCWMkB9T7sjZHR2w
Message-ID: <CA+3n-TqBq3WVcN46Au6_x=LM2QnKbvtRSaRFZ=un-3C4i6_zqw@mail.gmail.com>
Subject: Re: [PATCH RFC net 5/5] selftests/net: use scapy for no_bcastnull_poison
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Missatge de Vadim Fedorenko <vadim.fedorenko@linux.dev> del dia dl.,
22 de des. 2025 a les 10:34:
>
> On 21/12/2025 21:19, Marc Su=C3=83=C2=B1=C3=83=C2=A9 wrote:
> > Use Scapy to generate ARP/ND packets for ARP/ND no bcast/NULL MAC
> > poisoning.
>
> What's wrong with current implementation in arp_send.c and ndisc_send.c?

Nothing. The Scapy version of the tooling is shorter, that's all.

This is discussed in the cover letter, comments section c). Patch 5/5
can be dropped if Scapy is not acceptable, else squash them with
patches 2 (arp_send.c) and 4 (ndisc_send.c).

