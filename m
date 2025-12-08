Return-Path: <netdev+bounces-244024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DBCAD8DD
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 16:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15100300F599
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617E2D4803;
	Mon,  8 Dec 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2AP9OKJI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE290225775
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207216; cv=none; b=UcEw4EZx2vPiF/NtNXlSwmjcHDEk6uoj8ScEm7ptfGPTgYNz8fR8nUPbP7+B9zSfwbSArVfzpRXP0vbLQAIn5A2pseqZLtO6DPMgvQTe/xbnqTGyVX/S6rNQPVcrflGkowsIzJb0TxgV24ppZjpNKyG/YPJBtRQFalS8Y9y1vlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207216; c=relaxed/simple;
	bh=ZUrrPnJe1yfnkii0gYHzRwn03lexWWRzYbUKEEPcHxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8P08wXeA5oRm43rtsx83+ckhW2MRL4ildEil65zszjOJV16WWo31TLltimTCHcuEf748Ok6ZOcSHKe1Eg8qquk1gyha7RF+DXyrqirS4OZc94J223wKhAwMdtWWHC4zEL7Y7P06Ceu4DTULj6LEF7ZQYsFQQUj8gyXJukoNsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2AP9OKJI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee0ce50b95so50979771cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765207214; x=1765812014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUrrPnJe1yfnkii0gYHzRwn03lexWWRzYbUKEEPcHxE=;
        b=2AP9OKJIHNKyT/0vXLABqMBq+kbimHKPJvZussMw8UULZAhj9/q3+NzeTeUHBkxaQN
         ClBMVyAzGE8pzknwilyT3I7MmQXhAP3x3FgIPr/ne0gbwEC/agJQ09VYR60Dm2cLpCSj
         UUKhzlhIuF05UXCmJ1tNeE/+E+8FLAJo9LhMy7ofi8ZyBxabcUh/r9Dj9DrhOpZ66sDV
         U5zHjIU508QBrXxq/NTRf4ijuxZ8f4qmvZH42JyarzzCYHJWycxnUa08rb+sEobDWbV6
         wphlAoWBagpfyL/WFnyIU30iPujwZhaSSN8DJGaSFNGXhM2INCXAC/mgLAelyljM0gNL
         r7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207214; x=1765812014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUrrPnJe1yfnkii0gYHzRwn03lexWWRzYbUKEEPcHxE=;
        b=Qv4IkblXxXGeBHgYI4bSNuJNnEs0bi8oksrXfsyFuxXUVSBSnUUGpyx1z+XCOTTRFF
         yQTYDkRIGYeIOebtnFW4CfrtkwtkFYHbiY0ZGUpj4phjv6bj/r6ScXlEgSm304Svktru
         /NgTVfq1nNvvyMV6HaGFU/7EYHQ3H9qaeaIHyt3Oh0n0ncjBGWYMD7QqtInkgk96ClGv
         3wPAnztGajrnBg7thVHAza2gDGbdlXKHH43tohfMWS4J/7rZ2Yta/oyuoL4hOR7+LrKx
         YCX0FexL1X9R/CFD7rHolqU2PN8kUFkUq3ExZXHaalhl7x3iQYMnWh0HFOUeO0mHUYeI
         cXFg==
X-Forwarded-Encrypted: i=1; AJvYcCUweypouAmYyaBlawvCic9MxNKwTde/vog/ExKj554exKAmxsLnyLpd+ScvLst2/nsm97w0Ing=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUolIUtn/66XnPPxKk5k7X/Q1I1+E/HifAn6VCi3ULWQc2BRe
	0ZUhRugZj1mtkN8hv9jeHEW8bFrLL06epEpaV0YDeAjmTVbnJVfjDzbgBjzPKWlqw0sts1RsejO
	x1P7p6LCkdGEffElulBXUHQOC7b78gghSmEGM6p5L
X-Gm-Gg: ASbGncsTeXmGDsVbjfvAH7db+eTQQ7PbIZN7P9zFz5wmeZit6yiGOGwQXRUGFkbyPSm
	85tUpbaH5gCbwQQ1RpQ5OyXlLKkt/M/5wgThwJLJ+98hCBxi0mXWz5v5YfDt+zu8NktTnHGE1h2
	9wBDLoU8Cb3LrXp06vB8bq9obsLGJvNKQJsaDslJ6ajr5s3db34u4vTpkVmh+PHkcTEaG+/KQe6
	kgLrrbGzF4V1HT6YZ51N8hNs/Ki8kWm0OzehQEYAqBQrFNTBkWY2kvlz+AlUsD0quTHKYsAGn+3
	XTF9sQ==
X-Google-Smtp-Source: AGHT+IEI+Jwv/1GCJ3oyPlYGof/NilG3ks/X42/Evg5t3ZOLDHNYGJ7gfNgux3cDJnxrB2S7HsDrtRORJWzdGaKIKx0=
X-Received: by 2002:a05:622a:490:b0:4e8:a560:d980 with SMTP id
 d75a77b69052e-4f023177514mr254180091cf.38.1765207213143; Mon, 08 Dec 2025
 07:20:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207010942.1672972-1-kuba@kernel.org> <20251207010942.1672972-5-kuba@kernel.org>
 <aTVVGM_1_B6CGZSK@strlen.de>
In-Reply-To: <aTVVGM_1_B6CGZSK@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Dec 2025 07:20:01 -0800
X-Gm-Features: AQt7F2qdGqDSu63RtH90pyLB5iJFchAMhjFUy_Ap1GQiXf8l7hd7p6C-L5JEZJ8
Message-ID: <CANn89iLnznzM=77F-UMyok=9ix_PmP46DuG4h5O=_fvwSNKXLg@mail.gmail.com>
Subject: Re: [PATCH net 4/4] netfilter: conntrack: warn when cleanup is stuck
To: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pablo@netfilter.org, netfilter-devel@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 2:21=E2=80=AFAM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Jakub Kicinski <kuba@kernel.org> wrote:
> > nf_conntrack_cleanup_net_list() calls schedule() so it does not
> > show up as a hung task. Add an explicit check to make debugging
> > leaked skbs/conntack references more obvious.
>
> Acked-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

