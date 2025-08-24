Return-Path: <netdev+bounces-216299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17885B32EC4
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 11:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FA51892CA8
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF6261B6C;
	Sun, 24 Aug 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM4LrNog"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0879260586;
	Sun, 24 Aug 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027558; cv=none; b=CVUKmlgbOW+16Ve32lXPxofwimjqFtsTRXZL5Dk+4ZI2SlJO7WYdrrGMRTjstwZKQtcXGkXLopkVku3A3YHjNIx7M47d352plfNNYwo4BTtokkbN2ul50YCjdbAeF0t5FBS+Ef14pB2a1ASYn9STZiaufSKjoh9FP2hNenFnZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027558; c=relaxed/simple;
	bh=dTOEICqm43Y9O6OeQvI3W7rll1BPNLESR/SCHKUk5Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCM36mFYLev7TAmlkVARFpKGIB571pzVxcF3i5wjmDrON366a2G7CLNyhe33WtmgOaHOeQqFH84C7/RpujBffN3MxQjmSbOfug5gHDwUFSnIMzCyG9n0FgU3l5Nb29ShCdNoaMuWLOt806JTHorL91Fodz+db6p2/wXuTkHYFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM4LrNog; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-770305d333aso1815527b3a.0;
        Sun, 24 Aug 2025 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756027556; x=1756632356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk1kh2veeW8Yg/i9V4kgRt//Eox3Trs2UJf8d/iZcLo=;
        b=TM4LrNoga1orXOykNKfaeDON+Vcv9fDrTWRwofp4x7+UVXNJsaPi5Pu513lFYjG5Rb
         yUs6NrdgPYYvg/8Aa4BcBoahq4ed9Ijz1DdRlz2qX/Qy/nOdDWeCiAExYd0Q3B7NkdC7
         Sv3JlGXk98ZFKwr3Bqj8ridDrjz1FSv4XLBteYaW0GDshXdG+skVwt6sgAX1zNl22oXH
         jJoIaSXavRra6ljBvEgcAcaxjv8D95yGttxXjmzKE26AHdwMXRJ7YciVRr5lhZfVFpBt
         rBWpskekXNrKMXjs7EToOvAQM6IHPVcZVUH1DmVAkP4r5AOE9v/k65PfHWw+Ijm3/KzR
         Ishw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756027556; x=1756632356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk1kh2veeW8Yg/i9V4kgRt//Eox3Trs2UJf8d/iZcLo=;
        b=pMzZCqwUT/w3rB+Ag3w6p4ckxx8AZZfvuMtWDlYAGsvaumgthtNQsmOXI8lnpwHqT1
         StdXbiccSy/ivU+WrqhKXc9HWT33nXbQdYXX1gYtq9YHhpUCYZKI03IsQ/lL+qcqI60D
         oYhZCN6JPNpl4+W7o8Ag19OnLb12V6AK5PsXPFuVKMdqDrWbitpGp3I+tfpiLNygVrH+
         ITb1NecMziehWgNmOCbs5HdPAogTj/efAwCqL857CGdCqsIJxD+VdT2EU5nR1zggSWUC
         XArbif8xkInto8HGRsMqG/B53YbjtF1KoaJRI5xpMkGzTng7bBv5utkYh1f9C33eq/Gn
         kTIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCCqJeWK6oRsuJV5Gn8mlS2x2356sIooY/khsFKlQO1xrjRVuzab0LxT5sDFKogTQoqh8pLfe3sJU9@vger.kernel.org, AJvYcCV9nMKaRQiJO+44NzM4Yq8vmpKJ+b1V8ReclY9OvUM71RiAX7xlW4TbGDwiF73XwhzRMxl4O2mz9rxnwaGE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3cogcyqfwCROtkeFMpIb1/DsQJHphL2G0wtfHoPUOr57XILX
	v/f4UiJL1gEOFrZJ7rIFf5p2qT9nqEMNMyZVLCF/4otSb57H+yomnpLo7PqhRxSL2k9f/aow4HX
	0e9xmUmgrMO59kPZ9NNZ6OWc037fjO6GSi2TVcjM=
X-Gm-Gg: ASbGncv0IofWdLpYsFliu8JIWjcd/paYALXcf/MlRN6aqWqtouQjX354RmvIz6rcXdW
	8rMX2WqyT7Te8pMTcQ51ha2AetwntMjiWFL0v6RRW+Db8MJT5EpzKZcGHvKNNMxerSBsTo6Xk2z
	ZH0o+M/iQ2iK+HjLC3RZBD6fLzBtifyERE3yGtXF5/eKDp645EDavOMCW5oHsM8OeOsEP+B+H0e
	AukBEyN8iUvAQ13BJC9PVQxPBkr5ACNMmzoUfRm
X-Google-Smtp-Source: AGHT+IGiojpfJ+y9Z2bWilS9WaZCuC9u2CiHMBkuDF9L/OHA/ZRWnvPKwfBkl62q87oK5K+nurnYtzuFsRh4+F22XLA=
X-Received: by 2002:a05:6a20:5483:b0:240:11b3:bf2e with SMTP id
 adf61e73a8af0-24340b5b48bmr11908875637.16.1756027555803; Sun, 24 Aug 2025
 02:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824005116.2434998-1-mmyangfl@gmail.com> <20250824005116.2434998-2-mmyangfl@gmail.com>
 <20250824-jolly-amaranth-panther-97a835@kuoka>
In-Reply-To: <20250824-jolly-amaranth-panther-97a835@kuoka>
From: Yangfl <mmyangfl@gmail.com>
Date: Sun, 24 Aug 2025 17:25:19 +0800
X-Gm-Features: Ac12FXzP_d1UEcGGKBaUvDCw-EFyybm2MoqR9I_8BXZqTOMpttamKRZlz0tO4i4
Message-ID: <CAAXyoMOfhSWhRCiFudju-DNtvD+8kHGhLzT2NGBF2cK_Ctviyw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] dt-bindings: net: dsa: yt921x: Add
 Motorcomm YT921x switch support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 5:20=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Sun, Aug 24, 2025 at 08:51:09AM +0800, David Yang wrote:
> > The Motorcomm YT921x series is a family of Ethernet switches with up to
> > 8 internal GbE PHYs and up to 2 GMACs.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
>
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/s=
ubmitting-patches.rst#L577
>
> *If a tag was not added on purpose, please state why* and what changed.
> </form letter>
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

Thanks.

>  - use enum for reg in dt binding

I made a change in dt binding. If you are fine with that change, I'll
add the tag in the following versions (if any).

