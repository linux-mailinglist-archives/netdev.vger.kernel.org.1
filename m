Return-Path: <netdev+bounces-111122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6404692FEAA
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 18:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF6E1F22127
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC37217623E;
	Fri, 12 Jul 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yDEJKAva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA52176220
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802194; cv=none; b=NxVOORSJI5hlf+ITj5sHAIMT3aHfgsJtb7DlfO3WFFT8h3T1TWILR/jnfK/aVqYmBpYZ5rByXXLu/5f/B8UW4HwVIikj0TinQw4xTDYJ5jYFokbMZYOVCdmx4xkw398o28oHIdUEqeiLC7nZZqoEz4Pi5lxLk3W80IYlnM2LO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802194; c=relaxed/simple;
	bh=Q+eUgasNNrBRtBGArjWHhYi7BKk7Sg0Hctyi1MeRtTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqeXuiHtagSFJGCfQ/2Vn5ML9yPbRwRZ9d9chIY82yQwtV3CpEPzbzVc6CXRJDWMczgq2pAd7GOdO2io28cxEiMvB6DPol4oZDC3G5YEgsATZSEFFSfCGMGDgYgWzSc3dYNgfG+pV/v2Cub5Whn9EiLunaPd6TlyjfuAZAu0eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yDEJKAva; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so13858a12.1
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720802191; x=1721406991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+eUgasNNrBRtBGArjWHhYi7BKk7Sg0Hctyi1MeRtTo=;
        b=yDEJKAvazgd+p2sA30d6k7afqEUidx5tAbaHciU98rvMxB6HZVXaSpd+sYGoV5sqGc
         72JQwKD7TpOaDVfX8xjiB9BC/3oi9fVRIpJJ+/vWGqFsbd1e4Mt4oBYnimW0wtE6hA9Z
         BRDTuWrn/C+0tOMW0I15HOma9968kRIAgtAIxQmxekKZFJuVPl+Jxo7Tif5KKvoQGTg5
         SrV8LGfBJXhulFKIEazNNcF+ObBsArIKdvnp+nnaEzvwq0CjXmY0TJdOyB4YQHMOvn8p
         BsXS7XQqnU+0S+gyNFBAab98h3/Z//e0/1mmtNTxbKHT0prryv3fsbqpra6YvudmKT29
         TyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802191; x=1721406991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+eUgasNNrBRtBGArjWHhYi7BKk7Sg0Hctyi1MeRtTo=;
        b=J33lbqskosANMdcb74Eg+W4wMLXfW2xRQL+MZmATycmM2WVcw6pzb4prYWCmKFRCKI
         uZhqKzqxndGQmEtL/r4xArk0q/pue9RL9XUDho9nNv9mz7d7vXDEWCRoVIvMl8EAsSSD
         DoLpUKhQ04a9yqNH8gRF5Nz0NsHOYl2eZUVKGfQysxFc1Lci+T7I5T+NERgEYwiLkUsd
         ocLU3TTNNo2ruyn1vwyoH+TYXruLjOt0pdmHwpVvUL6qbHRZdfWlnErAPFetelCgc0SV
         2rHDxmrRu0YP5k0SAKl2HIFsMvV1+QNvxIa5mXnWoa8q/WMx9DQuU6dyWoxmSFqhmPae
         Qirg==
X-Forwarded-Encrypted: i=1; AJvYcCVI6V26GOieIpuw4lYSUlRdAvh2LrSPu5i4V6mqGssWV4C4maQEMCmnGaNwQIOyu65NRZKggZR16LuZ1n1mlDAoyCQUAOJu
X-Gm-Message-State: AOJu0YxPIwstBrOzklpQIunuK2onitEVTyFJRZQN5ZSdze/xxaL79N4T
	wjT4MvA5Uz1cPx2riJB2686NZB+qKn3SbbyW5ETpU1GM+V/qtKa2pyxT85m8r8kOxenZmHM6Uxx
	jE0HnlIWr1i+d0VI5KdW1oukfPuTFwld+1z5e
X-Google-Smtp-Source: AGHT+IEiidXKcJS+6y/kit+jVK4ZbCZPpMuXc9Ks0S13qwD9jaG7oeORoJWBxB+XKUhbeC/jYAXC6G90hqboJG2Vfjc=
X-Received: by 2002:a05:6402:358c:b0:58b:5725:dedc with SMTP id
 4fb4d7f45d1cf-5997a4d6499mr289915a12.4.1720802191090; Fri, 12 Jul 2024
 09:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712143415.1141039-1-leitao@debian.org>
In-Reply-To: <20240712143415.1141039-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jul 2024 09:36:17 -0700
Message-ID: <CANn89iLxq_PGZLRkkOMSMZkZRnM5NveFvOiJfQqywpqZS6fDwA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: netconsole: Disable target before netpoll cleanup
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Matt Mackall <mpm@selenic.com>, thepacketgeek@gmail.com, riel@surriel.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:34=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Currently, netconsole cleans up the netpoll structure before disabling
> the target. This approach can lead to race conditions, as message
> senders (write_ext_msg() and write_msg()) check if the target is
> enabled before using netpoll. The sender can validate that the target is
> enabled, but, the netpoll might be de-allocated already, causing
> undesired behaviours.
>
> This patch reverses the order of operations:
> 1. Disable the target
> 2. Clean up the netpoll structure
>
> This change eliminates the potential race condition, ensuring that
> no messages are sent through a partially cleaned-up netpoll structure.
>
> Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Goof catch, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

