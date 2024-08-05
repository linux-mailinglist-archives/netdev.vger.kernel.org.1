Return-Path: <netdev+bounces-115808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C661947DA1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5273B1C203BC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC4913C683;
	Mon,  5 Aug 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpWaIJAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206396F2F6;
	Mon,  5 Aug 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870290; cv=none; b=lkMahnCLSppImajjKWgn8naQ51Erf87Th6JL3A4kURAFgTmxNghOakfGLoam5M9Pni7wyMnZjAMYCdBQi+8Cx1jbo9En0MK6c3Km2/f9dJ0Pzl0zjgFSvBwiaT3n5nExA7ukqDmW8DSPA1aU5jfLeJBKUMFaSCxxsuWBYK20O50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870290; c=relaxed/simple;
	bh=/Gqb82182GJ7ifqE0uk/Nla2L7+0JFR4zbzbtq/Xhqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQoGtLJPRsCZfkDSI0JMVuHXMVswsGLca3w3RFN2Msu6ZQbiNY/Z6P5lyMwwPnYrCKArhWa/eWBQ45W6I7MPFodfJbc18/wToK1gqy2VbT7nszkEILFxrm/dTg4I3u6gZZhu/rwcSMWhO+7H8yWldVbmNrRdaF/gAlRLCzDHcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpWaIJAp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efa98b11eso1721336e87.2;
        Mon, 05 Aug 2024 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722870287; x=1723475087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Gqb82182GJ7ifqE0uk/Nla2L7+0JFR4zbzbtq/Xhqs=;
        b=lpWaIJAp16ZMjI+8rwHTpDmsJhEmuF1rk2fVVRqGM/4YqO/i4MImA1kqlBBd2U6B+g
         XUYvDgPUtBjeIDVcbwFfqXSd8yg3Uy29IhcNH8GB0of/g9B0WnDOCs11mXb3J+y5Cst+
         tV37Z7S8T6hPCB2YBr2ahO1JffLLS1Z4xeA7gNXHwJNXgyCSSVS1X08CdxdA2/SCD5QP
         HNEZZKW4fuDK8UCYAZXLrC1pc+tz8hNhUHL9TkefYeZKATAJ+wgj1UQjV0W43VVtltYk
         OlJmrBRMTrMg2uQMaZHcZPWmWR+HnxD+fghg1rwGTL/IZYyt9WDkp/i39AAgt6NjD4Ka
         2GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870287; x=1723475087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Gqb82182GJ7ifqE0uk/Nla2L7+0JFR4zbzbtq/Xhqs=;
        b=ADUtiH9P7BztbxBvNKXs1SIMSBR0PbyBaXrkKNxzstmfQn/QttN98xmbCQYF8j8Ptg
         tcNlJfdBOt2TaPfpJqabp/OD9YaeNKxl2FsdsqXVYd0BUck+wB3gYtFt0WIPPAqVhZMX
         VVcIB09FGOjV3eV2fGq86dpnDU/nJVoRJ0X39VH7Ng6oFAFwDx6p+I3IWs7YV/hVAh0E
         w//F6z9bUd9wNhzdghqvg/t0hxUOFYmHsWKS8urKUm/1myp/cinv1+dgUCRjFJC+ayXv
         kvNlsCq3BepzAlZZyWSs76IUtzK3q5t4SHATMCwxKsgBY83+3XzzQM9JWeMtqunBQXKP
         kiKw==
X-Forwarded-Encrypted: i=1; AJvYcCUuSySQw8o1UwAwi1sfSLde5J3XRUg6uSFCAuF1iis3fTY8vmcPkMonWDLEuKX8WtZ7PSBlTrpEQY/tqbRopVZanWFeF6eGyX1Bepykp7umIr3Z0FGSitP5HyUZ/KSDBPI2fZNu
X-Gm-Message-State: AOJu0Yzes7TA+F7lEE2+yMKnskkMs+os60U/R9YN0YYFkd2Nw5icYKRR
	6Fn1pXoQ1w/hbJTK7hQl1PqwdV5ow4LIfQExzc1fhwICLJjYiIwrZ6qTjl8Y8JyoaJoMlBXGxdT
	lfslnxvesBX6wwLiuaT5nZvVjwRI=
X-Google-Smtp-Source: AGHT+IHtXF/b+BdgRW8ydHE95gguroW5hoRvA3hMIjAViRuKfUcgtBZQtCBnMeKEeFvh1998hhv6k2Xrmz0ePllO4Kk=
X-Received: by 2002:a05:6512:3ca4:b0:52e:ccf4:c222 with SMTP id
 2adb3069b0e04-530bb3b7bdemr4459342e87.9.1722870286858; Mon, 05 Aug 2024
 08:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805145735.2385752-1-csokas.bence@prolan.hu>
In-Reply-To: <20240805145735.2385752-1-csokas.bence@prolan.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Aug 2024 12:04:35 -0300
Message-ID: <CAOMZO5BzcZR8PwKKwBssQq_wAGzVgf1ffwe_nhpQJjviTdxy-w@mail.gmail.com>
Subject: Re: [PATCH] net: fec: Stop PPS on driver remove
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 11:59=E2=80=AFAM Cs=C3=B3k=C3=A1s, Bence <csokas.ben=
ce@prolan.hu> wrote:
>
> PPS was not stopped in `fec_ptp_stop()`, called when
> the adapter was removed. Consequentially, you couldn't
> safely reload the driver with the PPS signal on.
>
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>

It seems this one deserves a Fixes tag.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

