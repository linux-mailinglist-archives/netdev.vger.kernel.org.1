Return-Path: <netdev+bounces-120479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A131795981E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A187B20ECE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38881D678C;
	Wed, 21 Aug 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVu+MJWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64F1D678B
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230461; cv=none; b=DmNoOkZFthkeaHuNnePcpz4IAm1eSck/58rlholhXukbxGVrpWEPo4N4qjQ/6N+X0gF4+fNcH03tcYDIJBlFcYBAOUsOsTnu0t0jg0nvLahwsbBz+aaqqEMm7XiaGmWVKfQRW4SJ4G+x5m4SahA2yXUtbUvB0W/SvtAzK5igcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230461; c=relaxed/simple;
	bh=UUup3xrgT01M/uZWtMp4rDupYDkBMzqDyJtJaDtY4bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRn0/f4mSmTO4orj7CmANAXIMi1zX6wz1KStyl21jsUgoGDv5ZvsAtr082DkDQJQ36Id4/3xbyw1HgITIU9fOmTHylFCEQPPK/jR914BtxuYLmqU6fqHtv5ACdDFoUmoN1gEkZViwPIqFAPZnJp97qBOcwZt4o6+Y8gl28ayoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVu+MJWi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533488ffaf7so537162e87.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724230458; x=1724835258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz0jr9qqfu54bGaXt4/twJCQnqEPAKheQDbgCmy5Mpw=;
        b=nVu+MJWigZg4+A2kdKwWg5g3trXoE235L77+sA07SsaQtzfG/KzFyvfWJ6J1EhGgpT
         KHRlnPiWox9NjRADvRtaKj9dOL0CedLrHTSOT7034WLSZPHG8WthBCs0gKdw0kX7sgZ3
         uHZeGk9oXeu2br7nDKbdaqqrzjlqI1eBQ6GiA9X1al+q/42FnRBVbxsmoGDRqaaTZLRy
         GY4dNNgEIj6BcLBsuULc5qKtT1g4rP+zqw05JlvDH/NToya3rZ3M2W6L7bNPqb53PMU2
         Xt2T7HnELT+ienfYJNyck4lvjxH4n4dyN7dYMXYnGSzcoMR/FaZOOrIFyM6CRwApA9Af
         1g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724230458; x=1724835258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz0jr9qqfu54bGaXt4/twJCQnqEPAKheQDbgCmy5Mpw=;
        b=QgXvG+7IOw2pne1JkpukUv4FPcgFYi62+aEczyv+eVijx4YODxyi65bsiUycYw2cQS
         XystUBIEqHjvkUw2w5GWBMY7EDh+i/ylB/cOAOqgsB87Q086/0gXrf6qmsmXvT3/4Vj+
         f78A6XiOcu/QW478Igu+UO6Sof0V0mPpS+eaJ53QlAiTaeUuOCCYJDUhy5g8X/8fO7Wi
         cld6NQCwnMhao2dJifq5xbvxWgl9jbvPqhI+oQDAjigqh51bgqNBMDH9VjtDldRK5T4w
         ytsweVwvgTr9y29XdZp8GKumAj82C3YiCwRi3rjaJx7NU3aFWZnMr00g96YbnM95dPPh
         pY2w==
X-Forwarded-Encrypted: i=1; AJvYcCWU0G+NgIFFH3muwX7UHU2RAv7k8kYtRyprp61F/RRKSSYAeDPH9NYu4vh+RljvELNh9yQ7qjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgXGOhs7ArEij4DGxSdlE5fsFVf3aedexv4OeCTKfnWWRqoWm
	jC7XQXuCN/TsSx7syFeLT551vBcGZ2UQ1WevZe5xnxreQa/alTGLwMFS1qB+BjU6cLis5TtjQL1
	skSqUpNhcDIGjqAgavLF/TRcGMg/bB8icMcPDJu/zoJgp5ds98w==
X-Google-Smtp-Source: AGHT+IHUh1diU/Bk5SXnmnJb5PjwqaffYWyJo0uLkDohneS/UxMCGBQEZVaYQM9JKwYOk3bUCfAbTyeYTcPp4ZSEELg=
X-Received: by 2002:a05:6512:3d93:b0:52b:9c8a:734f with SMTP id
 2adb3069b0e04-533485f4877mr1026652e87.50.1724230457669; Wed, 21 Aug 2024
 01:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820205119.1321322-1-kuba@kernel.org>
In-Reply-To: <20240820205119.1321322-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Aug 2024 10:54:04 +0200
Message-ID: <CANn89iLu8K1CA1rABkucVyxog5t35_OTZEsDpHt5KV0Yj-faGg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: repack struct netdev_queue
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 10:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Adding the NAPI pointer to struct netdev_queue made it grow into another
> cacheline, even though there was 44 bytes of padding available.
>
> The struct was historically grouped as follows:
>
>     /* read-mostly stuff (align) */
>     /* ... random control path fields ... */
>     /* write-mostly stuff (align) */
>     /* ... 40 byte hole ... */
>     /* struct dql (align) */
>
> It seems that people want to add control path fields after
> the read only fields. struct dql looks pretty innocent
> but it forces its own alignment and nothing indicates that
> there is a lot of empty space above it.
>
> Move dql above the xmit_lock. This shifts the empty space
> to the end of the struct rather than in the middle of it.
> Move two example fields there to set an example.
> Hopefully people will now add new fields at the end of
> the struct. A lot of the read-only stuff is also control
> path-only, but if we move it all we'll have another hole
> in the middle.

Reviewed-by: Eric Dumazet <edumazet@google.com>

