Return-Path: <netdev+bounces-196549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09273AD53AC
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BA63AE43A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C82E613D;
	Wed, 11 Jun 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJ4rfANA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001182E612F
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640861; cv=none; b=Ed3vNnvIlzF5FnVp+/atH0FAh6IAaV7562I+vFm5XU6Jb7uQNNTYyCjVGqEC7vP2r2hrx1Pfkxs2zKE63aJyeZFJvcPGM1Xd4aL6A5WJTo2ty535v1avAt6b/HRyOx+8PBN2BKTVnkYhW0TRfUy2dchGisq0knxB0f2oo+4wbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640861; c=relaxed/simple;
	bh=nhc2FmlprfMjQn//mvmTM5gOWbWyuiv4jpX6k3MygD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjetqQLamSyUlZbCqlq55pVEU9uBcyNXB0XXlKY1EU/BpfBln+wxhAtpo2u2HkLSgT7Z47qoSqRBYkhts8bGJxZzX7C4anfh851XM4cTHl/31nHgA1bIFDF66/eCrU2jTnqgH4B0Fknh5wOcfRu3JSvowrN5zMB6oHOVmaWKLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJ4rfANA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a43afb04a7so37205531cf.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749640859; x=1750245659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S4V3FixsQXiHZgH6w6UrbUo2RtkfzWy+gWDKSkX+Ew=;
        b=dJ4rfANAe3PApY04b4sGdByBK86GuQigxY+pmLMegYv+0wqEBLCHgk9nHeLfKa2jpn
         0hsYUUc0ieKDHPegWzhyiQHNOKUlDebI/4E/NH3YVqhGByVIUxwEfJrmV4Q+NVgVB1zN
         l6bH/adCkNdT5erSScCIgThYOI/yeghe2RSf4s9tje7fxVficgaT0sZ56QVMW9CIlfIc
         iGo6fqEIbRbHvDNVSbhYJ7HZA8T43pphuBfu3S4L2TryyMpmSFihIiqyAdigPgHRSM13
         t23MZjxVZj/bJJi02z/axMl6NX2UI24xux+fYcAWJhoksMQDptKb9ohILDEU3qSSE/1k
         WtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640859; x=1750245659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S4V3FixsQXiHZgH6w6UrbUo2RtkfzWy+gWDKSkX+Ew=;
        b=FolFTOwvCg4hjeAKXd5B2H6pOTGByE3wKZ3Iw5wACaI6TFsxkuBs0gfrTjoI12bwT1
         qBVpZ+rs0jyNg/w52yMZRVfNoLu9eKw3fhTc8UJ5nfIPviWFQmuPEJUWcJQ/zPWj+sVr
         Re0JWVv3hvin0jifz4/5XmKT8BmgBMftS39Ye12hTSXW7cqwNc3jynQsWlzzLSNDmwWK
         oTcb4QQZR1yRrBVcCijtLgdsg86XL12SVvKHCJzVxBOqwt5A7yiHZ1bTFEUahIZdJsfd
         4rkPdnRSze4QiwzNZ2uYImljZgZKicQrFqIXBdGTpPkxDbWKHpkYreuvnw/Axu1YC+T0
         luwA==
X-Gm-Message-State: AOJu0YyBtKi7Rju+dLrwz3GPJXYBYsxPhWkSpdx1y0nndg47M+Q7m/Aw
	IYHQ3TGYaVQHe2Gphd3KkR0d3blZyY8JBBoJlSbJgIQgxnUEjPb5hxUjZSo2TDAmpmZxlEQiIq6
	aELqwXl1wPTznYaoRbUNOd3sm0EsqE1IuXuJzOttF
X-Gm-Gg: ASbGncvkj+XvGzJkZyWvKVaEfVL5QfF5DNEHLOqPsFlrGYWQJmKi0UhyOvl7gbDB4N6
	+FrLFGA/hZAN2sJC6Af1n9cXWodHQRS5OiIu9KrlUfq2+rF6Ru7h8fogLzwNt23ING5Kg3mvLjA
	7aQw+KTinfQgBU5Wd0OZ+R6dZs1GYRiIZR8RG7YEJb7Fxlx64cn9Yi3PJ1hgST55I0As6fg8vLs
	9VNsQ==
X-Google-Smtp-Source: AGHT+IGE4R0J7CdjwF6N3YaAk1Fw8A4luMzfctSNwsf3e6XEOL9TScPaFwJomzPTL01BVZTd/VZDc5fw2xWjDzlyFn4=
X-Received: by 2002:a05:622a:1e0b:b0:48a:e2ec:a3b4 with SMTP id
 d75a77b69052e-4a713b99d5amr50579871cf.17.1749640858542; Wed, 11 Jun 2025
 04:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <046a1b5d6087a4af6aa0e734dcf8312a4bab4a66.1749640237.git.jgh@exim.org>
In-Reply-To: <046a1b5d6087a4af6aa0e734dcf8312a4bab4a66.1749640237.git.jgh@exim.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Jun 2025 04:20:47 -0700
X-Gm-Features: AX0GCFsn4utWrIs4Q6SPLv59rIbPkGI8ov8L72henHuF2JP_ZIctGs-6QLiKBe4
Message-ID: <CANn89iKo1BAkcbnPfTfgN8sd=6trg37sghzFXqSS6vJAOU70PA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix TCP_DEFER_ACCEPT for Fast Open
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:15=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> The TCP_DEFER_ACCEPT socket option defers sending the 3rd-ack segment
> for a connection until a data write (or timeout).  The existing
> implementation works for traditional connections but not for Fast Open,
> where the syn moves us to ESTABLISHED and data in the SYN then causes an
> ACK to be sent.
>
> Fix by adding checks in those ACK paths for the state set by the
> setsockopt, and clear down that state when we send data.
>
> Signed-off-by: Jeremy Harris <jgh@exim.org>

You seem to prefer patches adding code in the fast path, again for a
very seldom used TCP feature.

Please find a better way ?

Thank you.

