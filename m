Return-Path: <netdev+bounces-131484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C38798E9EE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D59E1C21F6B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 06:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4169C84A50;
	Thu,  3 Oct 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Acpooszm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C142A8F
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938674; cv=none; b=kUOpFZeVdRxJy9PLJRJ0CDuiDtI+L2BtXRrcdv4OKDRHXlVwY2iwacUgWueqixFClLRfFEU5UXZFuvhIBDcI9+80vq03dNMT0HJIgI7ZKAx9hB+DKeNcQShpbERxl5i70dnuR9j+JWnJNwRNcXctP5x1HVe4o9FH+V/tgRnL044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938674; c=relaxed/simple;
	bh=ynBrWsnxcwVLt9SgsbUK7XZrBX0QGrfc9MgqajAXQ1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNRfkReAy98STvWggwp01YAJRE95o4xyd03Q0d9C/LqzLl6cly5Sj3dCqPM3GNgcz1OFYrI7+LaSodFl22/Krtet0mmAYptnaPi5LzUbbwMPMsTxmtMn61D1ZbMwDs/NcEsHbED2vaphG/PTdg8DRKP+Wba0rzZvSFPlgqImsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Acpooszm; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-45b4e638a9aso140951cf.1
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938672; x=1728543472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynBrWsnxcwVLt9SgsbUK7XZrBX0QGrfc9MgqajAXQ1g=;
        b=AcpooszmXKJbYrEwJELrApSt6A+2ZrlBQkfFbbgNXiIyIbxndP0geyrJDOhYZnNnrj
         EoPhZZtULPHecW8zlJwxEz3mRNEm+PbxlFQv7qnXO0hmmqPWa6CMznpozdQgG1BQns9y
         Cxa5NgCtALjNlEncdo3k+FTlRL3aF4yG/GWM+VB3mWZkDKtOeZzkdZXp8fKzzuHHTdvX
         V7EwgEk4XYDrBgNtVLlkka8kiWgvorA/CabNPyRgUEwL6Se8l95sJIQ+A/qIJh06acMj
         qfU5fsSgMu3xG51re43bxzunuz2VbcGK5J6HGN0oTIaaeZSrlm5hi2/AyNhAmYwGMqeq
         1lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938672; x=1728543472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynBrWsnxcwVLt9SgsbUK7XZrBX0QGrfc9MgqajAXQ1g=;
        b=n+/ikwvAW3X/baNpAN9oBbzAjF4un9AykU9iTGviZuLxkksV3vFZm4z06vi37v5h+m
         8jTPEMCUxnsorLjdfPuWdwFRj4PXnGBiMY2bbdCDu5zfGpM6fN3AFVde+VdpoyxQTotZ
         Lxy3uFuWRXwKmKSiu710MLER8VEO7PxxwSF6aD++Eo0CBRYoC5bUAOIeeeKPiuZL0wMe
         rxGZNdvlpTyiTWA5QpzwZW5SC0ofR9FB/iv90q1bvS6tFugBbgG8u/BCmxRDdqACWRhM
         uGObGaxCFRrSzhWp/gHcqXj3NLPDJkEbSAVBx0jRwKFl2WQao2xy5YvL0bG2HiCBAFKT
         mxZQ==
X-Gm-Message-State: AOJu0Yz2whH8QtsraMr+A6SOS3/GYgYjr/bBDVujzyuRu6IqBd9PbSW0
	ALV/yLLmiwCGh33bEJEWAFYkNuORoldioESQYOsdE1zWGjbTnjDoYtVvkiRe/Lie5BfPB7+OTe0
	WrBE7ALRXPWgVxFLnM3eR+ak2pV0ePLPh2Agx
X-Google-Smtp-Source: AGHT+IGuOmMrIlzp1owAL1PZ7FoB4fzz4/wuq7LIfUvgAfjLWULQjF4PHhCqvCq5DEoKcwFmJX/im5uf5P3pzwM5NzM=
X-Received: by 2002:a05:622a:560a:b0:447:f108:f80e with SMTP id
 d75a77b69052e-45d8e1fc5fbmr2206051cf.16.1727938671485; Wed, 02 Oct 2024
 23:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-4-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-4-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 2 Oct 2024 23:57:39 -0700
Message-ID: <CAHS8izPsXvuArMFMDtvqkQZB5T0qKK_GVero6qrMtswjr8807w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 03/12] selftests: ncdevmem: Unify error handling
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> There is a bunch of places where error() calls look out of place.
> Use the same error(1, errno, ...) pattern everywhere.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Useful looking cleanup, the return code of ncdevmem is not checked and
not set correctly really. Returning 1 everywhere seems a bit cleaner.

Reviewed-by: Mina Almasry <almasrymina@google.com>

