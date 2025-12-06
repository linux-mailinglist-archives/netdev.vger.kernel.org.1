Return-Path: <netdev+bounces-243905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65068CAA618
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 13:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 941AD306338E
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF7A2EC558;
	Sat,  6 Dec 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2oQ5onQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60628D8DA
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765023736; cv=none; b=E1Wb2UJw1g8HSJazYFRirz2ZBgHmiX0G1Qxkl9ibd6HmUzq+Q7lJBeoInOqXlcvsdvXk/mNa+bkO9IauO1wbASNW3uywxN+Oc4epZOTp0thH3YFA6GTx8pkWFfJ9DQ+zdsjzuZt+TTzJXlj8NRkanGG2kTp1s3M0XfUOLc1XOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765023736; c=relaxed/simple;
	bh=avqE80FuNxtKhYsrQn86s5EDGliZlYwIo6L89ALC9u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ+pFaO5z0peVwe5Rt+uEvdFXjkSPaT0S1ly74SOzaBgh3AkW89lNA8mODOGzseai/laWIBBRDdo6fWewjab+CmKT6T6Y+RiEyv/dXBxBhtMrRfWs9678LNJlRm6bSGGUGkdiVeJckeZk7ezqYJdbkQYZdzu+hIGcPHXbSVd7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2oQ5onQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b38de7940so1581416f8f.3
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765023733; x=1765628533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avqE80FuNxtKhYsrQn86s5EDGliZlYwIo6L89ALC9u0=;
        b=H2oQ5onQ0pFPhEa0hqbyseC8fjech6UnCLlnhYLjodg7Zx/vPRKm+McNKFK440OPWM
         UWpJJOAiDD39gSq/Ry6xLP5rwUj0dy8oBRgVoT/maGQMF2uqotYfR3v2cHPScIgU057r
         1SCbxK7kiHxihJ1fCGqYV/RH51K9QSZoTVXq0Y1AyZ9nzUlBCpISo2w6LzlS9aKkeguO
         3scPe+pTcLevUkLBnALK7CDsOCn/ilthriuzhurw4LlEUY7EFDnZQ2pLmLfjM0bczUee
         BECVBQYW187EjwSHteGWpep81lfwgfdVMIvughbEU7O2/ZkYQ1aK16nFee03/u3Qig1f
         AWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765023733; x=1765628533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avqE80FuNxtKhYsrQn86s5EDGliZlYwIo6L89ALC9u0=;
        b=vAWUTZXY8twNriBM+GrULhyQyQcbsaq9xyQc1v6eIeTVBErUoyf+cYyQ2quN2pHnY4
         56w6frV3OGxHyGRX0vsA4TatGPVeeh+9abqMj289JOxxqpFp/yalNjRjvg5SpmJuEAtU
         U24qy8GhWhw2iAFZ+YyFzb7C0vUKQMBxg7vudqEev7Aivqkr+CBEKMpcFqsZAAi4xzL8
         8V+Vp+YsXID9cY+s2LCgj7Q0GL3yYmX66Mc295maJDXJGQGd5leSeif+noC7PGeWUriv
         WBUAYm5tqe4OQ0wxjHtC3mRnY6ePIwD3zpYAwBGxHKW4tLWtRECWZSWlB2Sl/xLRZGpN
         G1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmozpdKKil85MhxsquDogUo2qeZxGUhbZ0UceaAAkEwraw6VOKyF0y5W0bJAWyRFgmWs9I2Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISqINAEzUeCrrsrVJifDoriwpbqHM0rOICHhdFp7VXJrrLZ+u
	of8Ig274PCsjMnfC8GxiMCS+s9KNU6HamdCJSZ9NPII9fqWsKyXMP5ViYgQtWhQ9hKxMDwunR6d
	kBmVhyJFOHCzZyiJod9ya4CMiy0q1m3E=
X-Gm-Gg: ASbGnctWE9EcGlyXe4yKERTbpeLBSgFrD2beNAYy7DAQ1CQDN6h5M0v1YZoMJHtqkym
	o7ZwOf3h+1IuaGk0jBp6fxXo3csMCHsBPuPDvxgOjeObBBQe54aCVIFa9ZKJqxaj5B130/jfVvp
	WkaQEpHjMDoYsGWDbp3aZlBXHL0QLZtj/DkCeeMzRArtj8j+8WiSvy4X7p/ssF4czVKEU2Jjl8H
	/zkGHNfE8c5WL+CICRduKZ0EPHzqsMe+ga4YJ+ENc/Z28jo6l+unZiAUppBOs15VrsGalsv
X-Google-Smtp-Source: AGHT+IFKw1cI9zye4JnFcVRfCJWeiris14USYPq+Fx80W4JZDV4qC19cHYIhu0zTEYoB+fP0fkJHMvEAuQZHqn37SP4=
X-Received: by 2002:a5d:5d86:0:b0:42b:397f:8dd4 with SMTP id
 ffacd0b85a97d-42f89f56433mr2390728f8f.49.1765023733038; Sat, 06 Dec 2025
 04:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKxZv9hCLeFz60Sra5t4J4h=EncoKW3K1OyEBePAfqmuQ@mail.gmail.com>
 <20251206121418.59654-1-enjuk@amazon.com>
In-Reply-To: <20251206121418.59654-1-enjuk@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 6 Dec 2025 04:22:02 -0800
X-Gm-Features: AQt7F2pje1q34bfp3bykmYzXEPk-ALtUw0mFaR5D3NfbkPUolo5MgMXaH7eX0os
Message-ID: <CAADnVQKJ2wzZSCmYPR_wTfp3pLDpHjTVQ0RLviHWGMtWzVy8-Q@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
To: Kohei Enju <enjuk@amazon.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, kohei.enju@gmail.com, 
	KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Song Liu <song@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 9:14=E2=80=AFPM Kohei Enju <enjuk@amazon.com> wrote:
>
> On Sat, 6 Dec 2025 04:06:38 -0800, Alexei Starovoitov wrote:
>
> >On Sat, Dec 6, 2025 at 9:01=E2=80=AFPM Kohei Enju <enjuk@amazon.com> wro=
te:
> >>
> >> Ah, I forgot that bpf-next is closed until Jan 2nd due to the merge wi=
ndow.
> >> I'll resend v2 after Jan 2nd :)
> >
> >?! It's not closed. net-next is.
>
> Oh, really?
> Hmm, I've read the documentation[1], but I may misunderstand something. P=
erhaps that documentation is outdated?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/bpf/bpf_devel_QA.rst#n232

yes. It's seriously outdated. bpf-next was never closed.

