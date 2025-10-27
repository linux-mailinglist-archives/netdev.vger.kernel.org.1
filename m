Return-Path: <netdev+bounces-233289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E787DC10B92
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7780E463F25
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946DA32D7D9;
	Mon, 27 Oct 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVSwdn4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069232D7C7
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592135; cv=none; b=fyvFHzhXf6N6ASZQtADt3UDBukZPQVrOGtPhyaKlPaAgA4M6ya+IimQryLr+dwdmozNPFuk+p+htyrrczGeJi1JuiwUxrSkRbgPdK83P99R/hMDTMGbKLs65lPRU/qH9LIvG5tbD+HTYZUK2Nbz0FhF7zjCJv+9e5j3mE501Rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592135; c=relaxed/simple;
	bh=LwAmk/7MTnIWI2oZ7HDPyu3lp0S1pBrNDG9x+kH9r9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaDbjwX1QGVIF/zgHbp8J+O3iYdSuNXLDiv/nUnROW7+5F5/20gTY2HojhYD1vkkV84ekFdTiC72NxGcncEFacLvpymoRi87/7PGA7XG5rPJPThGI+gNdIf0kbdJ3TkPG6F3jyf9nFjPZooSTKsXCbgN3JPBQYjElZLwe4gTtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVSwdn4J; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e3a7a67a4so5519028d50.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761592132; x=1762196932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBa16o2HS8qCHNhSfYkAhXZ4L9FP6XeHVGIquo4j2vI=;
        b=hVSwdn4JOcoqaHNLFfLQxTu7eWx01Rgqd59pBAURulTcRJlYT9XZil8D64vaoIKaOU
         gfhxXps4MOYzdEvxMaV1knXwOsJHCSSn408048iYjmlqbWP/0AcrxiPSiyjj1Ssa8OPP
         p7Lio09UtU4OeVO4jyJOTDKLcTpqHqFVjBhsUNQ0nesJO4M46fw4zBeXMfl5M8TyZhOg
         E0/Zy38JkAphtr6W7H6oRnKX5ujQ/DAJqP9JlL8+Fmhd5ptzzNnOOqmaIhKJqyuKwyWy
         9X146AywMJ0HzBTfXY5bZettFAhXL5zRIs/afSJUQRFwHucVtfLCnF7+aGlI4DkFiRGW
         XE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761592132; x=1762196932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBa16o2HS8qCHNhSfYkAhXZ4L9FP6XeHVGIquo4j2vI=;
        b=UZO3G+bXD1HdHvNKqEwei29SSJHsKqtBjCTPh+cfshv2ByNlIyjldKINMHUBqN522c
         SCC5CBNrGF26XnI0k5moMh03EJGoRTZHN+aoHwUcEiCg62EKlzy/0MaAgGaQDzvG4yQx
         V78pHJYZ8r8BweSgcJRDkEr1gb6tYpyVj7hj5r8k1VB/l+WGPZ9YMWAzvt0hSHsyZNwx
         NkoH+iGfle0Lpl5DiGRV/CDTa3/V/JDcm7k0Q9/MJjLtgMBDGIw9r9tkZDVi+dxAuwve
         gN2+sQuPMc1Roh8cHpAiLJ81rivlrftMmnZAfRDgMtHEOYi3WO4YVYJ9fNK0K3YRt/TY
         5S9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLRr4y8uXzVdh7iHI4w79NywZTS1yESm3SZxnNe3iIxw5XgtZh3YMna4MiEhOIcvcTR+UD9cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNHVO+oBjMMZzPbYxm/Imevfv7KnjTi9ZFpNmGs/RksOYHS0f
	Z3hdr0S1QuCoCsk+iARMz5qP8uwF4lHyKacsy9WJJkNKuysqQtZ2XYSX
X-Gm-Gg: ASbGncuYgSaButBucRDqlMYirV/qkbFwT4fkGcLM9EQAqWXIswOP+MXt/yZDjGCaRnl
	beVnfaUaPZExffIALLCNFP9nO53tY2giZXQpEI8S7Bp2j4em5Kkhfmt3WGHuJdzsV5gWq80mM5Q
	GsKi4ySYbi5UzrhsHx0zN6XnsEk46KuM9SW1CsfaAB2zPKfW1xhcj8RPsWUmdPLPsu7hR6kagy5
	KKV/zAjOOuoL1YU3euinsIoxsWN4LG4psqJ/W4TqDgV/syYYyAugWVRWK0kAvAJ0iNwSoG9y8FK
	jtG1OXhG9jNcemoNwMRtGHriGnUvX6nfyQv0vnDD2F0ai4gLPJHcVU7Ija5btc6X20SM5mYoqc6
	zydiP+FyaEvVvWLZ31ZYCv5STAwYcOQ1uoJgXJTd3JuQRRzYF11LosvrJ1sWc59eMl37jHZfbRW
	EYiLAcMTRQvBqzzlIyAJxv+eXEhf09IrFze66xjwTNsGZ8Drs=
X-Google-Smtp-Source: AGHT+IGyyVhNMyFPJ1iH6VB3LobfrBQTkhvZ12vnfHgjuauZlHjFnodUEDbnz8J1VMMlZEjH/eQK1A==
X-Received: by 2002:a53:cd41:0:b0:63c:f5a6:f2ef with SMTP id 956f58d0204a3-63f6bab5662mr707347d50.65.1761592130958;
        Mon, 27 Oct 2025 12:08:50 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c441fe2sm2525648d50.15.2025.10.27.12.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:08:50 -0700 (PDT)
Date: Mon, 27 Oct 2025 12:08:48 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>

On Mon, Oct 27, 2025 at 11:01:36AM -0700, Bobby Eshleman wrote:
> On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> > On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > > the vsock_test binary. This encapsulates several items of repeat logic,
> > > such as waiting for the server to reach listening state and
> > > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > > from hiding failures.
> > > 
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > shellcheck has some (new) things to say about this patch too.
> > Could you take a look over them?
> > 
> > ...
> 

It looks like the errors are SC2317 and SC2119, but are false-positives.
Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
being passed zero arguments (logging its stdin instead).

I also see that SC2317 has many other false positives elsewhere in the
file (80+), reporting even lines like `rm "${QEMU_PIDFILE}"` as
unreachable. I wonder if we should add a patch to this series to disable
this check at the file-level?

Best,
Bobby

