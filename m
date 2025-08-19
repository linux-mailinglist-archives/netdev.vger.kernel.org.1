Return-Path: <netdev+bounces-215052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5F3B2CE8C
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 23:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0526B162F9F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97712620C3;
	Tue, 19 Aug 2025 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYSTnI3o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6B220687
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639063; cv=none; b=HyoY9wywkVYm8MlJFcgJVx5tFvNMOCZaQ1lXkkN6U44P8rifxgJOLgzxBmkkkloT1ILLqCsBha/DSCw3VFQUdGmS5IUIMxM8v3Aby4i87M2oaGOJmhQKZsk8ZuD7pNKKNZlh970qv2Udz5oih3MntVO/Buvw3SA34W3PXbzHKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639063; c=relaxed/simple;
	bh=/UQSGrmwmn8YczXd4v1oRryMb7Tfx60LkhNyEHK8aRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em/T5IsJXi4A3+crcLcvF9Vq8KabWKwLzhvRyNDVec8Xzr0blgAk72ur6Gac05dnSnpbtY+ag9fGDiN70rDZVYuVeV8wIpgbTSUqqurc3kj3+cjwA+QEk65RXdUsZYUDeNdLBh5Be9Cj5ESWPwsXveeEDivKMKKHnmmmzkEO5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYSTnI3o; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55df3796649so2748e87.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755639060; x=1756243860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UQSGrmwmn8YczXd4v1oRryMb7Tfx60LkhNyEHK8aRo=;
        b=zYSTnI3oVfFKK3nY8DKfD6yS2+e3kP9Nu7iHeV+BJ7hH6fFwVEevGnCk//QWGs/BYc
         Rp4PRy95lltrOQfXmNvxF/iT3iKT4WMHF7uMeWqstefWI8aJpaFGLS69xeKRCsQAlryc
         XkiVTFHItSWmWde3cr1lz5m38nB2Mjp92VdfE6YGCvhsRMjojIkgc9Up31YEfxCbif0f
         PGFPFc/oCuE6gEXnXtqOw8TxsH35cM0luBSAq6fhyNLobp79+XNi+zrc/rkyINFumZ5m
         GZZPrgg7fqF7kQ8Y/hfVTb62ceRZ/aNK9HWPNW4uOz+khel0SeEcOBEXsniv6/NMXCeZ
         goAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755639060; x=1756243860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UQSGrmwmn8YczXd4v1oRryMb7Tfx60LkhNyEHK8aRo=;
        b=v6uqgZGZoqk7t0nmNyHvZSxj592sdT+wq/Mcddp4T+Z5N9L47ARtLVGMAM3Eezxrut
         1RiAjY5wbLmBSU4FG87yxFM9Evsv4AjzI7zXn+0zNQUTvEWkZuWBKaRim6p3SrxAuMJB
         oJM950AAz4qbnbxkpcYLPM7DBtxXGSaQZDCFXA7NxXXiSrmG4jL+7mx0Snyb4LGgGrrF
         7bCu3eLFViinnFhs9ltkSi1q6rDn2lvJps1jWZdx1Asbh7WHs7wGZMkxAWl1fviZrpW9
         9PLO0NaCaebemqjGQWiSOeNY6vmozsYC+W2W18H3PsQQ347KxWEcTjWqJWz0DmlIbJ9G
         RqWg==
X-Forwarded-Encrypted: i=1; AJvYcCUL3AYKFkCP0DeId60vWO/gJ+QiWBmiakNcEdoe3bnczO9z3QB90iC4JhKGVTnNk7vnRTP4dj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVtGBh0GAbp88imUL0+ljWI7xxoy3F50GRDxBSpWrxh5Fa/aZ
	Y5y6ugEYGTEVSaYulelavK4bZ/7WlXvAa5lL6T2wCqKcMC/WjpIk4N1Pguk1ILugFi5AS3R876P
	8nc+Ee3LpshPE4oEXA6jynXkhYdj2VEYnNDg2yl3S
X-Gm-Gg: ASbGncuYYlo9rqVLTT0PfqEJg7FB777FhNJxkA43Loi6lIckMF/8G2lIZ7Qf+Ai7COP
	G0qrixd+Rnwh1XuwRxVkXN3yTOHZfwJTEJ6lPwjLTwbTS+z+S978M9/O6ZaRjOFezxrzIoPaZKj
	wtikc4dPDEDuUdhTz7I/WJAzECdb9ex2KXmaKH82ULJp1A1ygpaOO3Qnhl9O9FoefoXT2w3XNMR
	AQLiqxoVZ4UFplXbQiSSP+lvSx+H6xYJPWR2EkgypS9Atyq1mTYcVQ=
X-Google-Smtp-Source: AGHT+IGdMHPs1GsyML54rmJWwEz/UgGgdUvH4DhmTG5Te/uyjIvvo9Y/djBh8mKSRlBD20AX/zgNoduJqn/WAGp1obU=
X-Received: by 2002:ac2:499b:0:b0:55e:24d:ee80 with SMTP id
 2adb3069b0e04-55e07047031mr20680e87.3.1755639059692; Tue, 19 Aug 2025
 14:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <bc5d49dc4dcc97b4dcf2504720e9d043b56c911f.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <bc5d49dc4dcc97b4dcf2504720e9d043b56c911f.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 14:30:43 -0700
X-Gm-Features: Ac12FXxjiGJ4UU-vDlsX8zgDS9DbCBuv6ltBRKcrZz6FLHRi0lrhBZIW9GIkYsQ
Message-ID: <CAHS8izOeM0rXEmbQTfKb1RL+itS4wwH8J+pCxO4F3Adq_b-NnA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 13/23] net: pass extack to netdev_rx_queue_restart()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Pass extack to netdev_rx_queue_restart(). Subsequent change will need it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

