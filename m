Return-Path: <netdev+bounces-204319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28913AFA129
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 20:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70601BC6066
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7C211A11;
	Sat,  5 Jul 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnG4QEGv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6731E1DEC
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751739884; cv=none; b=u5VarrMgv7stLw2nsqDCgoZtj1kgOciRY3V0n9EYDH2Jxl8yk4P8EVTzKhsmc71PRZPO3hM+q3nIW4oOvMGAK36d/cXjFVO8pOt7o+AFIYklrtROfZd8ElrNeO+KU6909h6jRIhS2SXJXjsAVL1XbtZv7w9d0YmuI0xcWAX/t2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751739884; c=relaxed/simple;
	bh=XmWVWcRQPw5DD7IhdHfZNnpclUG+dTxU3BcmKttJF8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URLcS35OkZU9OPeRyOtZIchoh5kdnMHeS1W+kx0rEJkLsMgwBm9gKTruNuGnP2H/d+ovvJswaZboZe0yHEj3MBE9c9KF8Ya0pjtQOl6fZ+TRPkl211KllyGRkmNGydOSy6UhdW3kAZQsqW7NYKtl01n+n8dpQBcnbDmXZbJ8Guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnG4QEGv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a5ac8fae12so1282941cf.0
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751739882; x=1752344682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmWVWcRQPw5DD7IhdHfZNnpclUG+dTxU3BcmKttJF8g=;
        b=hnG4QEGvT1xW795EUPjXeLz4Js1V+l2YONF4oU0VmuQKCuONDppzOr4jLkuFCeiEXu
         vB1meifXcXVvcdzXzkPL+Ik0E5mWESMG8O+iuDyNcGntTq1o32Uoynza3mh8xPKAfYa9
         Ec47jL0zVDtVOoqr4qSD3834AvNSsT+Ou4xsCb0Im1gVXxR7DF8xSOVqRm7xnozDLt6d
         iEfFNI5TA7fdTzKykCNc3MPu2EMRqPqfpo6GoCJ6PWA0+sU4DBmu1JGxkh5kEk7oIcPf
         gQ7FZu7jeMKRM4lJxcC9jX6xMmJcnf78VemgyYIy5yKSDoi56ixopOfqsAUXrFf7kktB
         AldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751739882; x=1752344682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmWVWcRQPw5DD7IhdHfZNnpclUG+dTxU3BcmKttJF8g=;
        b=EXSo0eZNwEAwfkaT8M3Cc3ElUYJh+enZo04ew5sT2y8sJok+BF2VWolAxnggq1vsND
         el+IqDYMy60xWvmgSx/qBYdvwcwk4MzNQZuc5PO9QAiFsTLO4BHqTeXWD0fRZfmKx66R
         iQjuzhjAhW1LoZRhZGqlNnK29NaNtzIWZhK9m/FSrwoMav5vK37+vD1lvGg4/DjtFx8k
         pVM+QQC7ppJTDCoEYJ49jxjOnxN79QWsykX7Lcptmd4vtPEFPLSqHSONz7TgJCtEF1i0
         YwJ7uV6/kRqMLoCkO34gRpZ9DXEmLSlUkN98Tu37bx59/juGAzgrnLOvVQq7cSh3Z2Xg
         ZU5A==
X-Forwarded-Encrypted: i=1; AJvYcCX4kQU1EFs2jAc3nDeEBBhD9mlIUrr1SWHsR9rCN7G21gHPGs8yRu6Ta31sK7aK7dNAWnMApZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOlvTjA/HjPtsVkSsrbh8UHiLM+6C4w7kl1s+PCeD+vUSMyEb
	DpDSLiu+ywJzH7wQwOU1+62hn971iFb25aiZ7HZbcRj+dFJaRyPmAxT//u/AiPTgZb1MyioD6OU
	KpifMKD4fXPOaiPe4vzpwuWjAbw28jgZn92Gth8Q8
X-Gm-Gg: ASbGncvmw5AZ+AoiMc84TXC418TzWyW+Gk9HgIQc4K1tWdAkMgnpbn9Eve9KSRmEsJo
	PXm/hyCfXus/xyQM2Ou3xCcNIKE29mAHQlWKIZXQmfq5JwEHxTr0xPc0TJUnyLZIStOBRc44g1v
	kAeJftfBFnAKwHL/02w5j2m1R63K//r+MOBuQl1MPm6BhV1xU+8BHjQjBkP8CTSH/vzNyt5wIzT
	GyX
X-Google-Smtp-Source: AGHT+IH1gVcJjyCLWU/oXeWVCwJ9KkcRqlgUsCAIKGjCgd/Fy1Gg4KAwrEfmSn2SckDnva7cvF1pqbLMYnHKKqSKCW8=
X-Received: by 2002:a05:622a:83:b0:4a8:ea8:67e with SMTP id
 d75a77b69052e-4a987e934aemr11191111cf.2.1751739881184; Sat, 05 Jul 2025
 11:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705163647.301231-1-guoxin0309@gmail.com>
In-Reply-To: <20250705163647.301231-1-guoxin0309@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 5 Jul 2025 14:24:25 -0400
X-Gm-Features: Ac12FXw62FacOZWA_dOq7xgyYy651hGzZ1l-tTHwA_5zSgeKCxqzICXjapoREGg
Message-ID: <CADVnQy=nXuhs514XXm18zhPSFc_z4XjO+b-+rm5oA9egEkk=RA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: update the outdated ref draft-ietf-tcpm-rack
To: Xin Guo <guoxin0309@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 12:37=E2=80=AFPM Xin Guo <guoxin0309@gmail.com> wrot=
e:
>
> As RACK-TLP was published as a standards-track RFC8985,
> so the outdated ref draft-ietf-tcpm-rack need to be updated.
>
> Signed-off-by: Xin Guo <guoxin0309@gmail.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Looks good to me.

BTW, normally I think a second version of a patch like this would be
marked as v2 rather than v1. (That is, the first post of a patch is
implicitly v1.) But AFAIK there's no need to resend. :-)

Thanks!

neal

