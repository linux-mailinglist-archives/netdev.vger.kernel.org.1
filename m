Return-Path: <netdev+bounces-66731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA898406BB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47881F246AD
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D516280C;
	Mon, 29 Jan 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NchS+6Nw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9E62A02
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534589; cv=none; b=ZHizdO0nlRN4Rd76V8o80KQ8cEEnRCD8yLcHIfI+6cQ349t3T7JX/eoio2JLodDHVarx1+ADOJ4tVJCQZyuAty1f/2agdBczR9e+YhMECrhQet5qVXcPXFX9Ynz1vZP8LOeBWRnnRCAoqPNwsGG1N5/HkJAfH7KwKBq5AzjQeig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534589; c=relaxed/simple;
	bh=GOL4CLf7NJSi1+Yl6Eux39JaESbVEoPmfBFe2dFCDvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miQPZmCyg5dkNXtPGtW40GsKPa7vBPOBReG+lAEh6EolB8q0v1oC1ju7tMOIBHNpKDwtn2T1fDUFVVUnX/ksZlQzeIXvecXDX6YnBfouRM1a+bif+LgD9uBWUd86qDqC355IZzdc0zyXYm0lYR3q8VKPPV1U12W/P3xa3vk6m7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NchS+6Nw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55eda7c5bffso8496a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706534586; x=1707139386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOL4CLf7NJSi1+Yl6Eux39JaESbVEoPmfBFe2dFCDvc=;
        b=NchS+6NwDS6r4IRefpKVS2LqB+DEKBdMPk/o6EJzgCS5qiU5GJ/+2zpUFUvTs366Bp
         K6Fd/27iPgaSvVbZZQdOlswH8tZ2/tKeasamnTFwcpFXemiQLl2+bMv/4H/XoQE9v5MF
         +LQQdUcZNWgfKBeI7t1fSLD3aHMl6kafZtlti8eS7UKBiuFYPLciO8wTPrnfHRTSHzzw
         xE082tsC+J+e6GpUtI0Fs/7KSFG6zno3nF8EWrhnymU/r87FSTdh1RA58ezb4Jci8/Ww
         IWjcfjToVuhAYCLLNEfb5ZFtXncb5/MwbooDB9LKorUgSXzbGsmAi3mpHMGZN7JglTxn
         jJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534586; x=1707139386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOL4CLf7NJSi1+Yl6Eux39JaESbVEoPmfBFe2dFCDvc=;
        b=T060QmN3k2+CvvTyLR4iAQaMKYjN7BseD6hvlBPKlltfI4DVd3RnXFLe5817kHu0e1
         jNJyffou1/uNe8t4tgsvEC73iaYY/Ke9DPwkmSAGfg60yR3ruWi7niDpb7EZfChj3Lnj
         BudZNki7Hc8J1Pc5xAmuTRRFt+R7FxZRJ05xd/t/gVOkfCYy45A6OpO/c7/psY3GjYBW
         6gTg4pQJPK9cGQURI5+pidMsUQYYOIvdAuCXCBHCbeWZVe9mtrQbIToxXtfPC4//AThk
         JTjbN2epkqh1/AIYcVdyQEVa9B1bCLlwSMeZoZgd0gSnM61AlhrHcOD+DzncqQ/G7FvO
         7E/g==
X-Gm-Message-State: AOJu0YwqKzBFyoaZyq3hiqNEmY7jGwtgrPQTov2IAmNDoTvx+erBD9Nq
	YbuboIwiuy+ICPhCFGo4Bd91dnAk/bDCH8qgUlgSXA5xY2qyrGSylywYxRnXJiw3MDE+q03pNlY
	rkWQ8sAM13roVTy+fXxJRyjvcUW2JFLO3k2jZ
X-Google-Smtp-Source: AGHT+IG1astNKH1/HDc0wBTVk6TC8yGv+pvI7UwKY5UN/sQS0hwFaBZIZw8cIgMPOsBKIZYZeMT8luqWWhKHlR6S/3c=
X-Received: by 2002:a05:6402:b9d:b0:55c:ebca:e69e with SMTP id
 cf29-20020a0564020b9d00b0055cebcae69emr482056edb.5.1706534586055; Mon, 29 Jan
 2024 05:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129091017.2938835-1-alexious@zju.edu.cn>
In-Reply-To: <20240129091017.2938835-1-alexious@zju.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jan 2024 14:22:55 +0100
Message-ID: <CANn89i+eR_WHdndbCWCgZymB=QnmMaURKeVj-by-+=fXJNgDxg@mail.gmail.com>
Subject: Re: [PATCH] [v2] net: ipv4: fix a memleak in ip_setup_cork
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:23=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> w=
rote:
>
> When inetdev_valid_mtu fails, cork->opt should be freed if it is
> allocated in ip_setup_cork. Otherwise there could be a memleak.
>
> Fixes: 501a90c94510 ("inet: protect against too small mtu values.")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---

Okay, although the changelog is a bit confusing, since we do not free
cork->opt anymore in V2...

Reviewed-by: Eric Dumazet <edumazet@google.com>

