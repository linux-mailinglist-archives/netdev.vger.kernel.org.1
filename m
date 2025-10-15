Return-Path: <netdev+bounces-229447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6CABDC610
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3EB3C4801
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB82C08C8;
	Wed, 15 Oct 2025 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M71qbZB1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900D28A3F2
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500028; cv=none; b=Z/M5N6wiuiDJ0XY7+J5iBCQZpIhrA5bAiuF0ASrNkxoW47qPow1AFr6uv65gLzpeoDPpWXz4zWkaDBgeqmeiFzmAEObNIOiK5BzF6CvO3bzzqAxMx4ArrrmSNW2aj5kV+t218VgR2jAgmBwp9rUiwr8/mwd07OX+lvNFeVyjg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500028; c=relaxed/simple;
	bh=Xwqx5YKZEmVmyAtIVnnJcVVYkaFGbS80LvhnkpwqsCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mj0jvRcYQVUc/PQ5NQsJHmdvMpCz0qfNdg7LLelyoTlCpqpj4eJDyPJQQuUHkGDstv9C5clIuzViiikm/ap5TD4ps8kilB0JUluTBFAYuGNMd0iKqRkn5IoawI4DqJdfqVmUC83qPxRiFHg9u0bRuZfiaQvG+REyUBM6C2NahP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M71qbZB1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-28e8c5d64d8so56348885ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760500026; x=1761104826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwqx5YKZEmVmyAtIVnnJcVVYkaFGbS80LvhnkpwqsCU=;
        b=M71qbZB18J5nIUjLJTtcUNXPSkEUmcVllPIVWL+okcb6Pu1uK3iU0lWoj1+a88dY2h
         uoavscotVmPNnc9xGYMEUSKg4Qv80RAyZ04lCzUUOGOaxw5Fu3wUEMJIQJJG6FdvzRnn
         ukuJt0oxU5C3iQpk26tRzds5KZBiW44b5TOp0i3z2/3RdrxwzKg7CTFZa9MPAI4BPepY
         E0lTMTEzI/pIRqXm2a47gfMZXCGV1WiiybpXPhIuZ78Oi5HMw1fEWQdJ7XNEUc0yyA7f
         vN7KNJ6gEcn/K2EvVKoZlV1wbK7UCjFpHdwAKuRsnHChNBwOHPdH7IDfsKKybHwGNcdn
         Ev0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760500026; x=1761104826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwqx5YKZEmVmyAtIVnnJcVVYkaFGbS80LvhnkpwqsCU=;
        b=B8oFleTmAeXRs+gNK+EcPVV0xGXn7F8YvgiVB58dXn8F4ww8mOy/TJpQuUO16vVpuh
         SS05pQmOFBH80Ws8eoz47ZDV/2UFyOdGKC04EuPstjQoHN6rtlVZfJqlE0/LegQ8rdAt
         7EvAVBnC1zcDno67IwSd9SoOU32BaJpBD1QCWKwqyKMwJDUOVAKhFFpq566jExl+nsZc
         A20mQTdaDBlP1Ctdcdvn8p0wkvJdLzc+X8z65vRZGrsS3w39vQyLq/6VUQ+oIfzkVI9K
         yeXKTITzan+X5PO5HG7ooeBnVoOkPjsw43XpdoboKEIaReqna59rf4eRyDZWZYAoYCsT
         3IXA==
X-Forwarded-Encrypted: i=1; AJvYcCXFvUMdhnlM8a02bfIC4yMJkmP+HmL4uZA/GbZ2Rxi/KAYevvkKXsrdUSuvBAUTusmcbQpzjz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbTCJS1ay5n+D518OpCWt5u3YTMtNLhtnNondBk+5p2dGZ5ib
	prTc2Z3fwNzDvj4mDEjevFb0PuMczzsIriiUWqB2lLK/D6vbZ4RDoI/yfSTG4GNOeeRdly8NOiH
	3RZZmz+ZjUSDfmkluYj46AlXULKXRvN2TFc18gxf6
X-Gm-Gg: ASbGncvw8/W+79jaIdQXaoXtvPdaliZHch356T81NlwDK9zQn4lvNfH1d0VhJlZHVT6
	vehJlHVRQ+S6yURouxNJcSj3aICV+Bb+a5ox3KYhCRdkxw2EYvUt603LlxNoVAaZ2f2dcNofjT1
	BjofsBdIx/swSirxiQ+dqOfq8hA7F/YxsOfvvVQqtmKKV6qDtbCc18zgQ7PYMr2qTo3uOFGx9+o
	qs7Ju1nqdynqRPuBX1eAhtKiz3wsPHtet5YN7S+LiSJxDv0bZ9l8DodImW3rx/dk4yLaVulXsY=
X-Google-Smtp-Source: AGHT+IGQq5N5OUlqRrWF2KdT0RqUYu8wCF3DnGyoWDgZqlnaiEgI99MpKAeozEQrGaQdw4XuZ61wSw9DzA4DTsD2ih8=
X-Received: by 2002:a17:903:1a06:b0:283:c950:a783 with SMTP id
 d9443c01a7336-2902741e42amr341029455ad.56.1760500025652; Tue, 14 Oct 2025
 20:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013152234.842065-1-edumazet@google.com> <20251013152234.842065-4-edumazet@google.com>
In-Reply-To: <20251013152234.842065-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 20:46:54 -0700
X-Gm-Features: AS18NWCLpuVI8eeSOUtF1dAb43Ct_maUGi_RwdGI_vHsHtjS6JgR9-8DHHuu348
Message-ID: <CAAVpQUBzSwq9BkrsaVpFeDPvHiYT5tRMNwWO+jeyHFqW0BOj=g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] net: add /proc/sys/net/core/txq_reselection_ms
 control
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:22=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add a new sysctl to control how often a queue reselection
> can happen even if a flow has a persistent queue of skbs
> in a Qdisc or NIC queue.
>
> A value of zero means the feature is disabled.
>
> Default is 1000 (1 second).
>
> This sysctl is used in the following patch.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

