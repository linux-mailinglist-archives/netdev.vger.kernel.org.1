Return-Path: <netdev+bounces-244016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894FCAD847
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32BD9309818F
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372232937C;
	Mon,  8 Dec 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8YfmJ7z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka5YX4f5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C1329367
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203602; cv=none; b=pSewETi82Lz9CBN7yRJIhjwWSzKrrfGdz4V0P3MyHPRT0KN95fC9xUlczvJD3aO5sG7ckyXr4ta+JqlLLlOd7hxlNQQWSgNiJ9arpfXfhJuiGYkIgVxhCYqTTkisGELMlWUQ1Z/DYaJQ/XtluyTwRHfb7CsNWOiiIg3VtgU+GhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203602; c=relaxed/simple;
	bh=PljNOTo0RHMKF0uIJ0F72Ecs4jdxizKa+DxYB7R6n6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q0745NNWzqVelA4hd6BuiWPg4Vlb/YJndz+J10ZT2AaUa4aeTAos6e9xjtRMzBFwOFEZ4iLOMg7i4lKtPUBp7dqgJnYiAkPS/0c+sX9iaXkqvpAGT/RjKZbbkSKNyFt18VANJlz2x2Q7UbDt05CsTPgppQgCfYrIJ6VBNnpTDOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8YfmJ7z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka5YX4f5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765203600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
	b=c8YfmJ7zrd0J9Hgv64Mo+yQdrH0+xeUs8Ow3pL0hr/IX0fAhnaQpwReDlx92cqlT39QUJk
	i1MvVJNhNiZRiD3prw3VjeGyy3tANDkKReQ1BdJshRtMGZBNnHaS3C8mPIHJ6FlnEqWguT
	XbRQjfjQQJr5akIFgbuO26l45FcU2qI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-eW3Ao3Q-PHijdyGYWM6MCQ-1; Mon, 08 Dec 2025 09:19:58 -0500
X-MC-Unique: eW3Ao3Q-PHijdyGYWM6MCQ-1
X-Mimecast-MFC-AGG-ID: eW3Ao3Q-PHijdyGYWM6MCQ_1765203598
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64095d94c2cso4847231a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765203597; x=1765808397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
        b=Ka5YX4f5jfrNDRzG2rT3gy2GzK7QDEveOuGHagrZ6jMxKwTBQC8+esc6+hk18f9E12
         fs/etNazPU2/ptkw2NyGTbH5mYH64CiVYbUMkbEH7qJTdjGSECv+hNHLqlTfGFKzxuiP
         wZ5gvzNtYPZ5F+Gtc2hce0LVpWg4jQZ1PM2erjx5UQkqN38ZJm5z20cUkUbbZY/SyCFQ
         KZS4jTZgK0dwymK47zTrTH8DcxLhKcJulOaofR+bNaC2b7HxioUXHDGpq7oJRVQPFS4m
         Kveb5ri7HTiJ7zZueRQwM7skdCLxW9p4jpcImfClRMWUhjFngiH44gdy399eRE1Ph61w
         5Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203597; x=1765808397;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
        b=NuGG78lnBa/36CB1NbcUicmHXQxV0mYXff2NtYM8Dv+1kHHzwKcsxmj6bNzldd07oJ
         mwnP0rQq0scMl27utB5CAJifEH/UZk3tmNHy4vdJ4faajHxCHTLp5jx8Hi50QQcIVky9
         pQadv8hxljKs2iu4Ahv4MaydGp5nEtKkFQp7ROUp6G9KIeajf3C2/g/U0uWgq8gdg3qt
         /2fDK9BCy4Sc0kvZtCIGjP1kDjIW+fZvmyB0vNUF+wGM94UUeaGRXhXawtL2v3r7APTo
         wDlIm1EtwdBvkKC9NXnYoeKyIrf+XzHuHynu/YOVmXrdceVZ0A/SLMgBXcU2Q0Df3Omj
         DuhA==
X-Forwarded-Encrypted: i=1; AJvYcCUW4nMjREJFUo7U71BO29zLPWrC8+ok++serqPXKEHiS9k/w4Ycgy+9VcMymFkvqenMIGfFcv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyy1LyHVu//gc11lS0mzmjaiHJMCbZoyUuoX8g5x0IjKDc1pA
	mv4nALZhMiFWTCMZNSgwwu2QA6gtIDYspX/FpIccb6HpVfALkEW8X4aewznODt1tOR5BhdQqQ0U
	NVMCfU2fwvqUnPutd1uqFwOzxHh90fIw02aaWxdUGaMiyUZrNpEALczgWIQ==
X-Gm-Gg: ASbGncu1Yrl2dUlKH+PaaLraqvRH2mIo1NR+dxaR/1xTgruG4ivoIZb4S0NT0124OkZ
	sc+25ypfx5OEZaiEAxfCSa16wawStBk01QjJmHasBPXP0QG+x3xIBfnVlPm1S8H8k/CnEVZQ1TG
	G7mpwua0KqEkWWA1fmfjymsOtNL8Ha3BOd5K9q/5sBOhQu5J0KSlmngvwXBhCMSwPggJCV+PxSI
	cTKRH0fN4T0YtUJP4DkyySwq0gW1jyuwgPnFCFQpDcicl0QSbvWc6Ca7Ob1br9v3rpQzo/OECvN
	5esEZQqEm1hZVZskcMXKXR13UL1t+xQhfYLgVpVcy0ajar7uqDpYo9oKzfG4iH4yaXz0I2TX/vs
	6UmesTBjoWGqRk2cIepauDflGaci9mhop5WUa
X-Received: by 2002:a05:6402:2552:b0:640:aae4:b84e with SMTP id 4fb4d7f45d1cf-64919c200afmr7274288a12.13.1765203597599;
        Mon, 08 Dec 2025 06:19:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlwGmklZz9ErsAvsYahFym+NTtrfrXS3XeSEv/0e+lK+B3wopu8o0DAiRcNsRnntzTB46a4Q==
X-Received: by 2002:a05:6402:2552:b0:640:aae4:b84e with SMTP id 4fb4d7f45d1cf-64919c200afmr7274253a12.13.1765203597191;
        Mon, 08 Dec 2025 06:19:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b368de06sm11276090a12.22.2025.12.08.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:19:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C3E5A3B25D7; Mon, 08 Dec 2025 15:19:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kohei.enju@gmail.com,
 Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: cpumap: propagate underlying error
 in cpu_map_update_elem()
In-Reply-To: <20251208131449.73036-2-enjuk@amazon.com>
References: <20251208131449.73036-1-enjuk@amazon.com>
 <20251208131449.73036-2-enjuk@amazon.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Dec 2025 15:19:55 +0100
Message-ID: <87o6o96ook.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kohei Enju <enjuk@amazon.com> writes:

> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>
> However, __cpu_map_entry_alloc() returns NULL on all failures, and
> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
> As a result, user space always receives -ENOMEM regardless of the actual
> underlying error.
>
> Examples of unexpected behavior:
>   - Nonexistent fd  : -ENOMEM (should be -EBADF)
>   - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>   - Bad attach type : -ENOMEM (should be -EINVAL)
>
> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
> and have cpu_map_update_elem() propagate this error.
>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


