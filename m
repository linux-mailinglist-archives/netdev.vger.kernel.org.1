Return-Path: <netdev+bounces-69765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42B384C819
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D021F26CD2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CC2376D;
	Wed,  7 Feb 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQUG6FWK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881625566
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299829; cv=none; b=d/AtkiR4KxGfEuGvqwMxph+feX+ur9/VCGFetub5WPwc6CQfGotS91xOyfg+jaWHP3CP72osHZLYYYFpFBJqrDi9+dfqOte5HxD+T359GzQO6dmssmfYnQG+4xsMsSpxyIjLJQfcmbwkPvJWtUL29UayP02aY9INcUOWUk5JP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299829; c=relaxed/simple;
	bh=Cv7/9dP3yWXOSwSLBEBu/XNpX5fgFWr4tiIcfDvbPTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LsHWmcXHO0Yc+Om6VS04XK1UugpF6FXY5vExfqlXo73DlX6NVeJQLS0FTmFmvewg2Q1eulq3FGv4InLvsu5Xu/pHH2xzizjvFZ1KrW3F1IQE+zI0eWsONSo1KfY4pwRzpUTcl3s18282F0H5ZD28Zuqzwnl+dVh5kXPUVYDAegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQUG6FWK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707299826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv7/9dP3yWXOSwSLBEBu/XNpX5fgFWr4tiIcfDvbPTA=;
	b=EQUG6FWKlOc+3A0XZaZh2RLHmAendT8545+S/yDLKTq7DESppFJew9t0NHT6AQwLzFUIgG
	n0P+1rkx6kDLKfx8TRFAiNtlyxxdNi7SqUHjgEfpJj05scAVO287aeeJJHid7TogJvyxp3
	DIMwLlf6bjAixqKZ7RrFy5E74LFMSB4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-KKk4C4L3NtqS67beJQSR4A-1; Wed, 07 Feb 2024 04:57:04 -0500
X-MC-Unique: KKk4C4L3NtqS67beJQSR4A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-560ead77e0cso15264a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 01:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299823; x=1707904623;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv7/9dP3yWXOSwSLBEBu/XNpX5fgFWr4tiIcfDvbPTA=;
        b=cAWnzhvC1/ym9YY6nLbO/h18HM05T+RhxY1+UEaltEUIUSh9j9B4RkB1Q7+X4jdOzm
         d4vri5kB7LzLVgcEhxT3i79toa7hhDKh9e8A9+ZnmXoiQg1u/AShtZBdmf/fVIYUUCUF
         ES+AhK4INVSJmzAhCQ8rJlZK9iMY5hg9s5qOB94GDakkOtp7wo1ms2UaINysyK/Xa9OP
         XXc7qUKyZcw3YLoTJeBMe8cd4CzgfWTF4G1IpumjyVwsxdpBs/RsPm+lu09SaYr0Y3u3
         854isThdKAiRY0co6WXgRwoET2sgKpjMVOGTNTKBO1Xh4qOVz9so/sC8g28zRH+Tju4h
         ERkw==
X-Gm-Message-State: AOJu0YxUrZnNIajuJOL1c4oAOV87W6HRts+lnV1xYVOmakDiIXctVeis
	gX9TA+h1OAtiM/FfbGWjXN2wy+SATdDPGGPAtH/T3wBpw3uZJrrWF+Z8Dw82gcPUw347JT93v75
	K9enZU3GDD3BYWRMUmbNo+sBKctN3+19+Fgisn0JD8zmRoUO4xPFPEw==
X-Received: by 2002:a17:906:81d2:b0:a35:b7e6:e6f1 with SMTP id e18-20020a17090681d200b00a35b7e6e6f1mr4063798ejx.1.1707299823632;
        Wed, 07 Feb 2024 01:57:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSwAmWY9RJJ9TUjSBXFh9kgpiVX2NKugmz0T8d/UqurWryGKbM7hfHALn2pzP7Yq20/18XtQ==
X-Received: by 2002:a17:906:81d2:b0:a35:b7e6:e6f1 with SMTP id e18-20020a17090681d200b00a35b7e6e6f1mr4063775ejx.1.1707299823283;
        Wed, 07 Feb 2024 01:57:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKPS/bKWSeOFffzQPpPbeysS2Op/4B+/Qoow7qwB8GhXD86cynZcog4BGMd4I60H8vixL+cC8niAaW1ySC94GbWKcNSflNMSQG04ekaxvBAnLyhTMdxLpWZsFDVSin1nkDSKZpCeuSOjq2U972amigDIJ3AU5jYq5tFJ4VN27SXgvqXq1uKew0P//+jLkGnTCq61+oi8x7iUedqBEcML+jdjxLHAW1WIjB81xIPxEbm6GGy8ppiJkl0Evy6HsOcE1Bokn17YCFVVkpooJ3aS9Y76b2NQbY4fNNUfSttEOuSE2dx255nykkBsrYZ660ZjnkZTPenXfIBV+PSDHyLVuBbwou1MaIy1VqXHZDM/TKFkL2/7wpGoXydWAUyrox2dGh8Q8hJeWeyQTfgb/wa6WHgqAlTXFhd8nvptkPOi2c4aVsVXAunpObTBNnd6JXIrajzohFvbU8H5PFEE0kenT2C3tTJs3JpqSy5O8eiMv/dVYx0+M/nrI0nb6DxSjl0pu+mVrsszw=
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id vw4-20020a170907a70400b00a3881262235sm337321ejc.78.2024.02.07.01.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:57:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1F71D108B18B; Wed,  7 Feb 2024 10:57:02 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, magnus.karlsson@intel.com,
 bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, maciej.fijalkowski@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, j.vosburgh@gmail.com,
 andy@greyhouse.net, hawk@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com, lorenzo@kernel.org
Cc: bpf@vger.kernel.org, Prashant Batra <prbatra.mail@gmail.com>
Subject: Re: [PATCH net v2] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
In-Reply-To: <20240207084737.20890-1-magnus.karlsson@gmail.com>
References: <20240207084737.20890-1-magnus.karlsson@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 07 Feb 2024 10:57:02 +0100
Message-ID: <87plx8vbpt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
> bonding driver does not support XDP and AF_XDP in zero-copy mode even
> if the real NIC drivers do.
>
> Note that the driver used to report everything as supported before a
> device was bonded. Instead of just masking out the zero-copy support
> from this, have the driver report that no XDP feature is supported
> until a real device is bonded. This seems to be more truthful as it is
> the real drivers that decide what XDP features are supported.
>
> Fixes: cb9e6e584d58 ("bonding: add xdp_features support")
> Reported-by: Prashant Batra <prbatra.mail@gmail.com>
> Link: https://lore.kernel.org/all/CAJ8uoz2ieZCopgqTvQ9ZY6xQgTbujmC6XkMTam=
hp68O-h_-rLg@mail.gmail.com/T/
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


