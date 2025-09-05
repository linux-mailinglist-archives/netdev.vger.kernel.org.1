Return-Path: <netdev+bounces-220299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69BB4555C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7535A5F40
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5A31984E;
	Fri,  5 Sep 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTulhI/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EC3164D1;
	Fri,  5 Sep 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069645; cv=none; b=s4C3i7M1B6T0BpfndHHIuZ2DBaSSuiDMsypZe2rsLlmAU6Xs1l6PS05kPrzFx//vGf0bQwPy0D22X5ON7O3FF487kWimA2e+93bHvOQ+X/amaCJ2+CFceJ72FsR8QMGxc3AxQYhribjJs7M4Zv27GDvNTmvlcG/hnpF887ZD9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069645; c=relaxed/simple;
	bh=yyxsnVlPjFkzn1+8XbKAYlbEXwaNDMP/41nT73ZfPAI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=QNHy/A9OFnc0bomVvyKx+YlsOZArCiOiGALzaD4/wjbEWfN4OS8eTMUIGlQFQZkXQOnpBWwvGhWSzGtLlfIbr98EhRbG7xr6SaxinrX/VFlIIPYOo3txAzgTTIaUuQqL6hukAfL73W3xsoneYoeBphRZgm08Pbelosq9Pjw226g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTulhI/q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3dae49b1293so1136698f8f.1;
        Fri, 05 Sep 2025 03:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069642; x=1757674442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yHvBVisMHGwoNSzTgNpM46X/q8q2/6v8Wpisu1xjvm4=;
        b=PTulhI/qOvSfY2pqB2h2+3jlE2YvI4L78XBlsZZWSuKQYuQXdIXGZ6YbL0QuxKLm0G
         L0a42AVVHSNYReWuIvbgiJNuXHk+8Mkli6FiOABLSvjn3ScqIZzJ2oZxh2ywplgiM4iy
         W5nC3TZ/d1hunW9NlH8WQd+Q1DIKqKjQmgMwoKOGarc2y73uIpmKUl+blbkyXafkE8vE
         sgoUEa3yYvox+jWPp/viNFdBqLrhfvjwM2Wxy8ItMqcTCpqhG1hwNvkibzoSjJNg7vD8
         kVT3uTP9D8ZsN8UF26/xzO2qxgOnvluxWQwi5pt9Z00+axclz8eNz5Yz5ksvcW5yBYG1
         MH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069642; x=1757674442;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHvBVisMHGwoNSzTgNpM46X/q8q2/6v8Wpisu1xjvm4=;
        b=N16y6gvwtoWauvzR97iZ+VPr4eNWFhgCcoqhEe+CsPAdna0eq6gD71nlkRGfwm1iVB
         EaydlFPTkIbsfFCSNPacyVn4D6PoDSSx1rMGY2VjV469n6TmWNU9kz3JmGQwEkFOXxAh
         pMKV6ndn7r6RTNXxZxmdNRv77aKC5CYeqNinJh27HJgemxcSKQm+wogojFzM0lB15LYw
         P+mBxNxsjIravfLgpFwZgsifUna63z6cR376jC32hvwPH+UCsGT7lQMkGTELByCIs0LE
         lyDg91qWUDVnXGPQwEDl2rPuTuZ+PiBU5lnhYCfv1qgu5ynUiixw6Sm41d5otYEu9Iql
         A2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVmlYWFhKO/D012T5s8gCkoJr7tGjVpsX8bAjR4Y+lNPL0WZ/iuOllGlFXWaASITEi1i0LJ5uZjDFY6ZGg=@vger.kernel.org, AJvYcCWZWJzV7cSMwem9pERh3QEPXKm4+NqpugwzDMOVfo9lGZ4bRCe2SHwj6YLp447ZOkwLLbH6FjHE@vger.kernel.org
X-Gm-Message-State: AOJu0YygxIbgw6qg+L7x2ODqiFRiPLKvv3+NoX5N7pVEYjPVeCy06yDB
	PBmB0p8xFqPDcqQpJ/AtJpTM4HH/TGpl/7k1r3mAzhSDu4IB1sGDpdcN+9d2cnXI
X-Gm-Gg: ASbGncspAbgH1EuyO/f2vGeZcVvzeMztUUhvD89Wgv0Pzs8WX6FyOjjLs7o42b/USBy
	Rtel2z77tQcjha4OsMqe99LBPHahSoA5NjJCyeLV43ynrZ1crXgHnh4ZDHtNNV0JlJZZZir7fwU
	WXTtSIDrjt/Go6AzGgZvTzzQG0iOLjaJS+7I5tCdEf8xzENwwuu9X2JL6eN9AhUwk8piFcXuf4W
	jJpisfM5SehWoPYzaOL/Rb/9dTwomFHb4SRXAn4zGpiWgPXmyIBNRg1j2BdaPNlbvE2qLXvFJ3d
	iyjX+YkcJeHw708x6h7DpvhlB+kbAQffEkMRGmXrPU8IUcPEhzfFIeKDzJdr8SmIxkekmx49tHi
	tQ6DNF79E7OZyf2Gbq0vgVeuXAQq3a+nhvPLTKNth9kSLbA==
X-Google-Smtp-Source: AGHT+IH/w4mCntnKqWpCCaG9P6GZVl+kuBsFJzbpXmpVyVNp+5zxdFKxJOMhWfm4Gma6EHo1BLzpCA==
X-Received: by 2002:a05:6000:2313:b0:3e4:e4e:344e with SMTP id ffacd0b85a97d-3e40e4e3be5mr1294346f8f.29.1757069641867;
        Fri, 05 Sep 2025 03:54:01 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e237646de6sm4362640f8f.42.2025.09.05.03.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:54:01 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/11] tools: ynl-gen: define nlattr *array in
 a block scope
In-Reply-To: <20250904220156.1006541-5-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:44:13 +0100
Message-ID: <m2y0qtxjpe.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-5-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> Instead of trying to define "struct nlattr *array;" in the all
> the right places, then simply define it in a block scope,
> as it's only used here.
>
> Before this patch it was generated for attribute set _put()
> functions, like wireguard_wgpeer_put(), but missing and caused a
> compile error for the command function wireguard_set_device().
>
> $ make -C tools/net/ynl/generated wireguard-user.o
> -e      CC wireguard-user.o
> wireguard-user.c: In function =E2=80=98wireguard_set_device=E2=80=99:
> wireguard-user.c:548:9: error: =E2=80=98array=E2=80=99 undeclared (first =
use in ..)
>   548 |         array =3D ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
>       |         ^~~~~
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

