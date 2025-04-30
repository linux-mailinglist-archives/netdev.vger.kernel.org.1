Return-Path: <netdev+bounces-187098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A4AA4F21
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0ED3A4B0A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EF4190676;
	Wed, 30 Apr 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg4ND/rY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3992DC791;
	Wed, 30 Apr 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024716; cv=none; b=DevUgGK2M+J1UV0ND7yrRXPhNlWuMWee8x0N72fh1akoQVkK/4N1q7emRj8rwdDE5H9KWEtzeHryC7Bt/McdE4STccDF6CjAe4BIcyhDsLJSIET/kSNmaXFvnqED40aZapqsNE83T8NfXnq1GmNSJb2rGvN6l7H4gGp8p1Fuwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024716; c=relaxed/simple;
	bh=ANvnHXXLsM2HHt2X59/E8B7LKSskGxwtvY+ASlMHa0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUXfcBJmNawdLEpsH0VhT8wN2o06DKGnp/nS2KlU3C+J1Zm3NsI9klpTVUxkZEP7sUfYtlKNtIXC+ZutOvh7JcCzHgrGdpjQVn8Fk2iu2Lanu4uxRLtDDI8ukcCFayC1uB/gbJGpvPqmbt1LQk7r8JwnKkcLvl5o6QKDFA1aJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg4ND/rY; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4768f90bf36so83731151cf.0;
        Wed, 30 Apr 2025 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746024713; x=1746629513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khLP39BEbjSp5OxOSY1cE6o564PDLjgx1FqwEwzCaKo=;
        b=Sg4ND/rY8mGW2wU1deaaq2EBswhBugWIRIUeacuILcVFrVFqtzqs7kxJnGnx71FMQR
         O6XG0/HpBSGrP9f3bfcM30ca1W1EMLsvCjPuWIfgJwPs3ULm05duE1YetadNHugOdVcY
         ATDX06cCDSH/yHl4k26rrD5cei4AcTbTqnYLb2viTx5yoRQzS9Ox9SoRefds7k7lzoyg
         a/dNv02dEARo/J2DAkttiP4p3NZjtO3qCKUzoNjdJlxHPeZuJ03csyvzzgHv1lf2/UVR
         pdfsA1KwWF597L6jNDDJgAxfdGLAndcZq8lIV8BRq5aRRXGZxpAMtuQcj7FLAJS5DS0F
         gORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746024713; x=1746629513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khLP39BEbjSp5OxOSY1cE6o564PDLjgx1FqwEwzCaKo=;
        b=nSm49mWX2f6yZOK/EVi/qRUgHMNApk9sq64M0oD3VFTJUVpqBvsyD+Dlj9qT9k1wAV
         zwD7ojJstpaM/X23y2yIMfim6LM/jn+MkJSUqb3LVvTDbMzMaBxXx/7PXUUsdhujYAN5
         AaEympWA7I3wRyt2g8wmOv839I0PKHSueQkm3m2lepmLeI+ctkKgs3mPBtz76vhFRJK2
         0BUHk8Zza+yVBoee++r117+DULYFhhdt+26gVlAayHdDex39NVodDonX2CRefYM6VXGa
         Ch82zdya1/ACHkUWJHhqDFkTTHjcYMRXkPTNuFrQ6GZ5ytZmL+FwrG3o1uM8tD0t5Bxs
         IOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJSIoC7WkWFTC9ZbdDsMfjBHDZyF66xA8wIL4K2C5Nf8i5QbNfTzXYFERisaiwo9ZpXwYZWoQv@vger.kernel.org, AJvYcCW+10B2sQO4nTgxNiJ2IR/JbGShi2cBIr1+FGzXWKlQpkT4al98YLfhd3Ai/a6W+THy6tdlGhbnMeBOGBRL@vger.kernel.org, AJvYcCXaAyi22Li2rrpdcRzG5CDmtu/Qk/957Ckqhi/0ksTuJNAdIDHNVSQDTJ9RmC6SJ+SSd3aMN4853MCE@vger.kernel.org
X-Gm-Message-State: AOJu0YxzpTspXhQEMqxh3nPMiQJD8cRMLed4GoMl0n7Kj3KJjvQGke+Y
	5rz4TUY8sE9Su0OF/lxaNFmlmVnYk9NNAywZowEMy9Vap5ALYzeE8pEmkyR/oj1jkdfNRQ4HAZn
	Q5JdPUjxeHC+PR2zVeA8x61FtEsTSVjRVD+hJlKUH
X-Gm-Gg: ASbGncv3vlEVR6S7m9EtafeVkBIBi4eDBiXUqOH74EdDsQhifL0PDlEy12zRP0y1agL
	h4NA53lkErP9gwqSwGIyzF91nMYcvN5MhzLGn3ziF4+vWkYzqcV3k6Wkorjx2iXQ24TZRQ1nsXP
	FByk9Fithrya1NWNT42r4tgHR6yV4GTxTe8i1QGrOF5Y3KXbzBawyRlA==
X-Google-Smtp-Source: AGHT+IEKc/pO4ycFj+V8i2s/1L594kwA2Gdb2sAylgWPbU3n+ww3m+g7WIpxkisXNDK8wuk/OCrcHDMU8zMho4EQ4MI=
X-Received: by 2002:a05:622a:4187:b0:477:6f28:3eb7 with SMTP id
 d75a77b69052e-489e44b5a51mr49674381cf.3.1746024713459; Wed, 30 Apr 2025
 07:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430-rhine-binding-v2-1-4290156c0f57@gmail.com> <236a2ace-24ca-421f-82e8-a2d3910730c7@kernel.org>
In-Reply-To: <236a2ace-24ca-421f-82e8-a2d3910730c7@kernel.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 30 Apr 2025 18:51:43 +0400
X-Gm-Features: ATxdqUHo5BlXS1S6bG3pKo3phkXPn6pPaAqcL5Z1mpGc7fhpdiLuN2IJZZ-TQMg
Message-ID: <CABjd4YzpkJTh2v-EzZemSgK6iwwsJJ=4sxpQ7-0vxeQby=1KaA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: net: via-rhine: Convert to YAML
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 5:25=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 30/04/2025 12:42, Alexey Charkov wrote:
> > Rewrite the textual description for the VIA Rhine platform Ethernet
> > controller as YAML schema, and switch the filename to follow the
> > compatible string. These are used in several VIA/WonderMedia SoCs
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > Changes in v2:
> > - Dropped the update to MAINTAINERS for now to reduce merge conflicts
> >   across different trees
> > - Split out the Rhine binding separately from the big series affecting
> >   multiple subsystems unnecessarily (thanks Rob)
> > - Link to v1: https://lore.kernel.org/all/20250416-wmt-updates-v1-4-f9a=
f689cdfc2@gmail.com/
> > ---
>
> You should have net-next prefix (see maintainer-netdev).

Duly noted, thank you Krzysztof!

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Alexey

