Return-Path: <netdev+bounces-189079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA4AB04D0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86C79E76FE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718AC28A1ED;
	Thu,  8 May 2025 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQnIrt8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B221D5B6
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736968; cv=none; b=aKdGMUR4VVEyvF9pwzTvaLt0QxZsSrfg3XDJtPW5ReFZNzfk8cPGwYxV96Hc+V2gf0HGWHEmUI3mj52No5moQc77OjHNcOLv7/hDZtSXyR48J/1NXOP+qxCPMmUzQ/AIbES2R+PNPOI03NrsVy36FXHM3g4kx2nxzjly0h9HgH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736968; c=relaxed/simple;
	bh=2WjSgAYTDhvbAta73SExM249Ul6aNo6XuJkBZUMjmhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml00Ot8Ern0tQKN3LrCWof0JpaAfH0/lDcnIDG7+9uI5kYGl9nxSuUecm5IpaHQufZrcI4LIOlRAok5NxcrljfCjtmD0Xlzd/fgAPxBxK5dYoMFVVob46cH8qZ377hKsR9ZO5+OE6VnxwO2OANQ+SgZBEkmAOYis5C839G7hemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQnIrt8z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e42641d7cso66655ad.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746736966; x=1747341766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WjSgAYTDhvbAta73SExM249Ul6aNo6XuJkBZUMjmhg=;
        b=RQnIrt8z03vWpaObewOf0ZDylNqahyW00XhFJkyQGxSik84kHsJz119Jj8jf3fNTFz
         roC1p3AcgMhroE7b/DKuILyJZ1Y1rQisxcKFU+3r+21SQ0bvNeyQiigpiY8pYLlY6Gfi
         MgksUdCTE6uduCB+fgWwh+asiKE6v6AvCaULEMCITFSzEbBGskmSQtc+T5vbNTtAGglf
         rU+sdHCiH5u1sdN4AlNyBBpojtFEuwew1YiLKNGQ2J1Mou6EFg3sfEg+DWL0en1YZr4n
         ynVPjuGieIUHN/ZFSCXRF4LmqtqfkALF1wcHmZTtM1CiE3Thm8AcksKiDmy4FT4z0M1X
         mQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736966; x=1747341766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WjSgAYTDhvbAta73SExM249Ul6aNo6XuJkBZUMjmhg=;
        b=XR4BoeBiRrd8GwNmjGS9w8xofyImdtqmZniUCkss/JhU2P+TeBaLaNbtrEvBhdRJiA
         3WJAsIwPteSWv3QbOCBZDP2daEapptuuNmpCtb00vx4oje8hIAC+m+12enw/HVOR7xUP
         r+7jpPSxhKRsk9TBlRjT9ya3Lt1Qje87IlUSXwFuOSotlCt3h1V3tX9o/I2q/ETGJAuV
         w1yyHuylk4ckyEcJGrKXJXF18Ra+l7RnVGVz0q2gQTvGNU06uDKlOs+od5vB5XyA2SaE
         LVQIJQDgP9jIts6WrX7ccrD3FnH04iedK4tgcO1paOLM+1DYJJOI3OH0JTvhtdmgMh7U
         DuUA==
X-Gm-Message-State: AOJu0Yz9R0P5LHJd+j6h0NCyVQ4YncviGGZSHbVedlEXN5SHSAsJ+7kF
	rO7wAzM1M294ObhLsf5jbyc/KedfDzq+hDExJKy2IoxzcdhRF//zNpdhj3WIPHtfq3URMT9RCto
	zeHEDtdA55/1vlnASXaLgpm7OLzrI+0/s8/LP
X-Gm-Gg: ASbGncuDk2SaH0vzX7PESOUSBECJESL1S3irLTDtDf8jGkpfnIwkLIBMedcqqom8rnq
	bC5iCjBI1e8Ez6/QYFcAUL9z6uj3LyUmrK/EFYRcRtmXa02VGPNBupKNkL59YTQNRl3NQRlBhF0
	+OFFEsRJVEiMJ1dtMONl70+VjQLz7y4UHg+Dqa4Qw/FOpnALwEJ5o=
X-Google-Smtp-Source: AGHT+IGdOqXYobYdZKHXuDIEEOvNgsSbJwnLZmEFuT3awRjJJMwhBX74nhjfWYBMobjCH1pxPLr3WpVKK77rfK+2Xvw=
X-Received: by 2002:a17:903:1c3:b0:224:a93:704d with SMTP id
 d9443c01a7336-22fca87efcdmr917055ad.2.1746736965812; Thu, 08 May 2025
 13:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508084434.1933069-1-cratiu@nvidia.com>
In-Reply-To: <20250508084434.1933069-1-cratiu@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 8 May 2025 13:42:32 -0700
X-Gm-Features: ATxdqUHt7L8EEX_0vDGwwK1FdTdskqmrajC3kVKNUyPt_gFUFA5qLwMg3p8W5SU
Message-ID: <CAHS8izMkqMr6r6nYeDH9BgLWrf5_DsCibcg6-BcRhZiJQqiTyg@mail.gmail.com>
Subject: Re: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
	Joe Damato <jdamato@fastly.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:45=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com> wro=
te:
>
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
>
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
>
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Thank you very much.

Reviewed-by: Mina Almasry <almasrymina@google.com>

Also, I think there was a discussion in v1 about increasing the amount
of memory that ncdevmem uses by default (currently it's 64MB) as Stan
suggested. I have it in my TODO list to implement that change but I
don't think I'll get to it soon. If you (or anyone) gets to it before
me, it's a welcome change. AFAIU it'll unblock you from running
ncdevmem on your driver which expects much more dmabuf memory
available.

But to be clear, that can be a follow up change. I think this is good as-is=
.

--=20
Thanks,
Mina

