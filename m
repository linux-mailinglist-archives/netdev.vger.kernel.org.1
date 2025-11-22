Return-Path: <netdev+bounces-240913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A038BC7C010
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45CD235C581
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E791EB9E3;
	Sat, 22 Nov 2025 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLHuy5+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF191E1A05
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770942; cv=none; b=G9fegPYqldry/K9OnwzN14h80p/T4nCMsGs2P2RGZU/xLxkAyJMgTpbZBtE/S0oVhLSZ9Gct9OWCsjeBccCYr1h1yDo8ViowtwJhbjtWMHgS9AmH0hmsfwkwi7Vxofl72ZZY3fzLzVllVBObN2aqKAweqn9f91qEzAvAq4cGGNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770942; c=relaxed/simple;
	bh=tKH+9xUvJ61C5pXpNcuqHhVpbRiIKMR++rhv9UJ+sSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuPC/PDELJMp5hPkJiKOBrW9++GTghWXLEl7GUb+mAtaN0gNf8h752TimAvU0t90gPc291gh7cF9jhur7/JAc1ppBr33OevyEUYlnVzoNd/1loZLhi89TrVJA5U7ikG6U2wEhcHQc8jRFCBMaE0oemqpJhxT41Jb2xw9tcOtSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLHuy5+w; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso24599455e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763770939; x=1764375739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+/6paGrk3006qZ7Bm65iZEZez0fPXCo38RfPda/UHI=;
        b=fLHuy5+w1jL9J98an5q6MQe/z9wVcMBKqyAxaSxGAQYMji+N72hpPP38S+NHHjF0Cu
         SeJAtensfm5iLM7BlQkpr1yLbYGENUVn7CUNhLGM6f44VgT3hwOsloUByUwJh6K1g3AQ
         50mr06Llh8Wl9oSt+QR4i0c5kd7fLYQ+M3xmSnLdOdEBepu5w76ntNHiyKjhT1y108lE
         dXobeUAuvRNq/UwgQLuEUzPExfPhR3XzxZh0QKKaJnj976DvXqwuH1V7dT+EdyEjEic5
         xAmMlHGj81dnJRqQ9oY0lr7yi5ktxVYjaRTSP4bIbQgM7M5Syz2Qe6bX56csLn4eDEyc
         ni9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763770939; x=1764375739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+/6paGrk3006qZ7Bm65iZEZez0fPXCo38RfPda/UHI=;
        b=YjCmTvnn1XTBo79kaPy9OwDyiEjqwtOFqEM6gm4jNczl61oSLMhDeVMn/PCds/mmQW
         r8Wk0nZLa7beIN+eYvx3iB229Omq4SY6nNYelUoLWMHHHIyno6hMg0IiBO88FYSy0AVx
         SuG6VvcBOWuQ0DaW2zENxNGk7/sk4PZP5He/EBRUIcKrU2ym62POzavSb8QUqRQ92bE+
         Y5FgDYV3QS1DVX/fGZz5G2/57amSbyI2LdPo9nrdXtY56Uxx5lTa8Nl0sb37WvWgkp7J
         9mtc1ZgigV0rRwygkILFpbns2cP03TZy49RDMrTPdXKCJGS1JYIFtlfOdTT9e2J4uBF1
         SghA==
X-Forwarded-Encrypted: i=1; AJvYcCU1v3UUzTQ7NM4lxor14KwxsS48BfDlbK1FjMem3qO7Mrj3dsh3bfAShPlINs9hDWGBfEl39ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVq/Q9g9IHE1Hlw+jNpO/Hsk9Y8DxNQYjWNEbtQ4Rq9FA3OcBW
	vyJzHI+OOlVctmsr7dqCFH0v66KnAPUsaFY6blM3kaGOqBSII4aR4CHRvkdB2EO+gOX/wkBH1/G
	fsoXC8ipq15WT3W+dW/VaHwD51qlJPRY=
X-Gm-Gg: ASbGnctOnSEYSoUXgUPU2R9QocsX+fSGC9Rh/iVXljRMBdiR8OlQWa0MW8xb5A2rfWg
	DYLWLwbPwHZnp80qMTB2U9AO/ew8r85RlQTX0ZFJl0LWiN3CWzT7ie6CGY59E7ynG2NYM0yejEI
	lwnvGi2xwNsouLkfi2E/bj3pvhNNPgUSHYdjvchLsw8qejGu2rHpzDYjpPGzpZ+H0uAfDoQY1sb
	Pjz+2mWSIxKSU1uyCEolU5VTWR2kSc+wAU494hwPkGudS+o8496JNuqpIJ0IGr7f30ceRap06O6
	X0dVS9QSKgJxbT243wconNSPx0RY
X-Google-Smtp-Source: AGHT+IFIlUv8CTTWAH9IDvU/D0EemTGa28qR8HOnKbaKdoxlazAqs4uFh8qzWMlmPckLI7FsLKQ0hY+UcakGnnRYyaI=
X-Received: by 2002:a05:600c:1d1d:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-477c01ff5bbmr50295515e9.30.1763770938648; Fri, 21 Nov 2025
 16:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-5-ameryhung@gmail.com>
In-Reply-To: <20251121231352.4032020-5-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 16:22:07 -0800
X-Gm-Features: AWmQ_bkbfNC8AbX41EiWAyASc5eiyX3WLpQNEoA9qHterxF2eSEcbHVcDGbOwU0
Message-ID: <CAADnVQLeSP654facoQxW9EHJpLBivdM3rm6WpCsimsnXPbYJ1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/6] selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS
 command
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> +/* Call test_1() of the associated struct_ops map */
> +int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, voi=
d *aux__prog)
> +{
> +       struct bpf_prog_aux *prog_aux =3D (struct bpf_prog_aux *)aux__pro=
g;

Doesn't matter for selftest that much, but it's better to use _impl
suffix here like all other kfuncs with implicit args.

