Return-Path: <netdev+bounces-210150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931BB122EA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D177BFC1E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232092EF66B;
	Fri, 25 Jul 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9EkWudX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504F2749C0
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464062; cv=none; b=Gi1RTCKUGyB2UudKujmccfwBM219+Gnwmtkfiaipck3+/rtL4R/xRkMUoXSTcqIlL2/6+SO4HyZz3efDXsGbIoYJ8Fq9sPYUgG5GnnW+koZCq1ygZymVtAEwfXIOOa2r+31PuDD1bMN/fYrY0k+zJ2+IOPEeuEiUdBAWtfNBFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464062; c=relaxed/simple;
	bh=ztW5g9Io+DwYXSX5Bjb/sZm/RkMW/CjJ9zOMGyQfjIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTEKl3L5+XOjo8mYOtheHjKhKhMLH1p3DWcn8TGftDK3UGuvATv3zDgjUkr35Wua9hWduS9i4zrbRGAh4YVErA+Sgr2TJtHM/lxY70NNhz/DVZjmwCwTHmqpEqmxAz+OAUTAgMvW2oeKpQgAu20r/j1JVmQCpCUHotm98AzuicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9EkWudX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23dd9ae5aacso7325ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753464060; x=1754068860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztW5g9Io+DwYXSX5Bjb/sZm/RkMW/CjJ9zOMGyQfjIw=;
        b=d9EkWudX7JQDV9rHyMYMOYx2hVLOx78xGL/5Lmvt8vg98SD38FMzmIl3LAZZLNZ3++
         7Sac6CNYM8Y9t5IxCz6zh9IaXs5ft7iujKXiJ1Pgdpa3dF5nGTaWUCO6jXB+c1YhchfN
         2nID9+OIx55YNDCxTvL/FZdFVxQFVlySRpXJ65KrYxV9AIFnAwDuX54a93mfbJ4EyXCk
         KUTG8Ud2UG+t8Yuczh7O5an/aU8zYMuXbWDLP/ORQFhVrnddmsKDJ6QTHSLYQPswJZm+
         c4teoeF4BVSWqDHeUs5fvh6x62pVquRiUX7HB4OVB3EcJ1mKN2ifV0Qso7zqsJD75s1u
         6Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464060; x=1754068860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztW5g9Io+DwYXSX5Bjb/sZm/RkMW/CjJ9zOMGyQfjIw=;
        b=SB6OUpLg8GKyhykkAufWR2HUI5RYeFxO50Y8M7oPOooKv2bXM/sMrU+I3oJLKXbrOZ
         dxQdOrVMu0fhcJ7+/pYCBlsll3Jxb7MrFZX1EPSFlXqVS8Z+0hnwi0NWzu067heUG+hk
         uJnxftDfHpk1F/4TrTEdRbNBRkSZY+1pcP/i8vJeYt9/YxTwcJ3DJapf09fkt0fHgwMK
         FxVTpfSkgs+U1V8OmeEiXuh6gRoiLW83co92+Fhj0zmBuyhdlgrpqh73A5lCls1SKgTH
         g5lhJfkE0oj5Oq15J87WDpXUujWkQrVjLK7a/033ng8//buSqvHdSaTFNqvah+yIk8Pu
         6ZBg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Iuszcpiq0vsIPgf/haWaIPow70CPGWacLmIsJ14r7g1uO1XBHgjhukO9W8qbNg38z6Mn/NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1O3JsAOES4zmzDdgriQKpkILZds0RXqsw0gynElLbmn5phCWZ
	0FGy9sKaurz8WMhTwHBDhmR2vJRwa/Y3jUvVzAkfxx517kMpd7jJkI25H1kbOiXaWco4pBTvL7+
	rmbXkLdcneSmyq15kCOOUzS5mZZw/WwTJ0TBIH7UI
X-Gm-Gg: ASbGnctwcj8icYHyaKVf1MlH7SjGb3ZO8i7gx6zDxIJtvhjqxCfZsIaEFcPFi2pRuI/
	VA2gYIOlrc+d6/phJaTEzamHBtuVZuOWqoeiFxhY+vY860tSYI3mIMg5Q6J7N/+ZueaGwpMd2Le
	PQV54uJlfFJ8MZALZ3f+knbISCvm0dapOmsmhojwDbhnrxIlrTaWNkWkJVbBIKRwoMKSGHaq1U6
	JgH
X-Google-Smtp-Source: AGHT+IG3La2ZTD3NRSPrjHKZQ5evO30wkrLX+Kpt+QdhR94hbkea+gCEFQx5xnAWugOKKY5PaeRMhwgBkwadUW1udNg=
X-Received: by 2002:a17:903:2bcb:b0:234:8eeb:d81a with SMTP id
 d9443c01a7336-23fadb18ed0mr3827435ad.16.1753464059728; Fri, 25 Jul 2025
 10:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724223225.1481960-6-samitolvanen@google.com>
 <c7241cc9-2b20-4f32-8ae2-93f40d12fc85@linux.dev> <CABCJKud8u_AF6=gWvvYqMeP71kWG3k88jjozEBmXpW9r4YxGKQ@mail.gmail.com>
 <f82341df-bf2a-4913-a58c-e0acdfb245d2@linux.dev>
In-Reply-To: <f82341df-bf2a-4913-a58c-e0acdfb245d2@linux.dev>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 25 Jul 2025 10:20:21 -0700
X-Gm-Features: Ac12FXwiLGc5GdsZn_qOja2m3m-3Suv_aTBv8aMYUOQDME3DEqdrTQ3FkvdZlpw
Message-ID: <CABCJKueq=a6Y_2YmSDOa-VTCW9jwYPiXq94125EAMoZ5Y6-ypA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Use correct destructor kfunc types
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 9:54=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> I just tried arm64 with your patch set. CFI crash still happened:
>
> CFI failure at tcp_ack+0xe74/0x13cc (target: bpf__tcp_congestion_ops_in_a=
ck_event+0x0/0x78; expected type: 0x64424
> 87a)

This one should fixed by the other series I posted earlier:

https://lore.kernel.org/bpf/20250722205357.3347626-5-samitolvanen@google.co=
m/

Sami

