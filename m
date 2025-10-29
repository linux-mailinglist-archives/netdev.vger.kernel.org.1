Return-Path: <netdev+bounces-234086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE112C1C8F3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF5066131E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F6342169;
	Wed, 29 Oct 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph3/Qjco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2ED2D2382
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757265; cv=none; b=tdi+zuFBsx/gOudctWI2N0w6Y/m1+cyEU5lN/t1sxmFyLmwc3ZrtNzt27uaDbAaSq6AIC7Qt+S/gDYcsvQw5lQt3bPfTFEv/hoNRffVodZwDFvht1XDV/YFaSkg8ZjMBw0zog16o6JFSv2LBGLpjYagBSZKtUMIJpC5f1t7xZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757265; c=relaxed/simple;
	bh=Wp3fVL7+QadEa8IzaGlhGIUgVnY7Jv4oi0qCeRl/zp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwMANKilypWah6UJpo3AdCkzyrtXDY7wFob/fThfu8f7YJn0hCS0KZV4RdSmXmmC0Xla41j2v/Ni01agxl9bNpbuJL2Xitb59q1s628/vrauveUKnOsShMBnHxKSFUqX+S37f2/WiqM8ZwLoXPm/eUisxqyL31vqOhcYU6fAif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph3/Qjco; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63d8788b18dso175255d50.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761757262; x=1762362062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmVcWnyP/D/4k/CbvF/9x81DJvhDtu1WPzap00TJ1+I=;
        b=Ph3/Qjco5azbXJsW3NDTuYpi4IACUBO4d0kSTjZ0jZC72SK790gWA/OyWtD+cestRu
         Fp5ZJf6jzSAsSX7bWcwXcbcE+AmOp1HCYv+EmdbBqPJb1PgzzhjVmY7lMk5/attwM2z7
         Z49pyOIDpy4+HD661ykJk8qndAqClDh6Sjvp3PSnYeih3iBQUkmCrEAeL5DQ3vX0wDM0
         j9PqnT3BBZBrP3wr/wZzz0oCLw5xPXX51m/Flg/gsxxLMLOWVz9iY0FvHNtFKTcdFi83
         eQK6NHCsY8Eb0rbMmj93sKlN0AxrbRfo/ZseBNayi541abgTAoTf31tCNLEntLIM+oOa
         POTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757262; x=1762362062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmVcWnyP/D/4k/CbvF/9x81DJvhDtu1WPzap00TJ1+I=;
        b=hoph5hBtgSOKCaOSlMkcPlB614khQk6uY2Emr6P9gmhRXny9nC/yM6PLB+EvpTEGMr
         wmmXmac+SGFcVOlCDtt5uqO6qN5rRB8f96uylN+KqXAPgZ0pax26r5dKol43TG/fW1Wp
         BOmCTrfSXir+G73yUSTK4n1yHWHzZvlbxHLM5eZNlFNMHIjzhvrYFKcouUhuQMEZNFUS
         /EbZUtmWrEiotcMUwbOab+uvm0KoaUVWtl7UULAci48LARsiBLwJnGyFTJRJYxcQ7kci
         ZuPisKt2jN7DWCP8jCuAa1J0uRaHNPww5Ik+/DjgFjus1GIC55S3ra3mg64dbI2LfKvP
         uv+w==
X-Forwarded-Encrypted: i=1; AJvYcCXAz+u4IUihe/BZKSg7gY/Le+i0AN9tMpR59eq6IPMFiDSjdiHaqD1JxPE4mbc+I8ZHCQM/03A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVBJrJ47le+A2DDsNPH04N/Qfmf7zc+kizaPrds/tshDehZfZ
	Qf+ZNyo48m9uLgAHAK+6Xleog1yhae9OA3Ba0ejhgEWuhjTO7e5A8iH0
X-Gm-Gg: ASbGncs9KzRSUwQHiIqKn81EiOvpSt0aWEzVqmBuqKIs9gPDrFngg79yws5alXBp7lF
	m7VhEHJczRP3IXPFFEHKWmdnI5swsR09GHBWtnsDyyHbqg3f2n7zE50DmfgD6Kb5UANcesLIaLB
	6hqDLKXGAhiSFwgvKFrTN125H5tBNykyiPa8rqQQZMVpIpJz4XCBb3umMt3i5kW1aGsdr9Rgase
	5ERp5ygfbj/wtWVWz06/RlUHnyhrmNyPumQkDK0Bsyiv2YDn2BKn1HrHOVIgkMJNcneEuNUYsiu
	wTLr9Kp215opnBN6pK3SZM1AhvmrMUKPXvyXZLmbrnWyjUTDzJhs7zC27xyYRq9OsuvQ4EToRx/
	KwbPiZMELnJjUVzaDfGzVZ31u70U8O7z2riDfBayEr5Uy76uZlfQuf9zKr+tY5MkFeJfHNbm5KF
	IL4mSh/M/5Wh72g/8HcPVgeBd/+CUMjqO1201e
X-Google-Smtp-Source: AGHT+IEnBgJLEOgPmmjd5Fa15mG3hNg+BcjR7XG7Mp5aLAnnOx9JAcZcMN6DeI5kKixpSyz6Fvx1Zw==
X-Received: by 2002:a53:b0cb:0:b0:63f:4b02:cc7e with SMTP id 956f58d0204a3-63f76d6734dmr2393937d50.29.1761757261825;
        Wed, 29 Oct 2025 10:01:01 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c4724b9sm4377534d50.27.2025.10.29.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:01:01 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:00:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aQJIS4waEjTCL/hI@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
 <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
 <aQJHnfsWll7Di-V0@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJHnfsWll7Di-V0@horms.kernel.org>

On Wed, Oct 29, 2025 at 04:58:05PM +0000, Simon Horman wrote:
> On Mon, Oct 27, 2025 at 12:08:48PM -0700, Bobby Eshleman wrote:
> > On Mon, Oct 27, 2025 at 11:01:36AM -0700, Bobby Eshleman wrote:
> > > On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> > > > On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > > 
> > > > > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > > > > the vsock_test binary. This encapsulates several items of repeat logic,
> > > > > such as waiting for the server to reach listening state and
> > > > > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > > > > from hiding failures.
> > > > > 
> > > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > 
> > > > shellcheck has some (new) things to say about this patch too.
> > > > Could you take a look over them?
> > > > 
> > > > ...
> > > 
> > 
> > It looks like the errors are SC2317 and SC2119, but are false-positives.
> > Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
> > SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
> > being passed zero arguments (logging its stdin instead).
> 
> Sorry about that, I thought I saw something meaningful in there.
> I guess I was mistaken.
> 

No problem at all, it brought my attention to shellcheck and the need
for exclusions, which I honestly did not know we used formally upstream.

Best,
Bobby

