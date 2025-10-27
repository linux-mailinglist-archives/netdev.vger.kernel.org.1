Return-Path: <netdev+bounces-233285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB099C0FD33
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21717350717
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97C3093CB;
	Mon, 27 Oct 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6Cx6GGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE162D6E63
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588101; cv=none; b=PuQe73JPwiFH+aZBMYw8OV6KS9n69Z7FPpZPJyfLGyCS+q/iIugXdj2/jTogMS2otdnK57U5ESxE4QYdCjDgEbjOb5d749o0vna6rUbcfJvjrMbppa0/QjqO36JrOnCxPJopQFoNxSYYvFINtXpjEkU1ALzSrRa3Ah2j3cAx22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588101; c=relaxed/simple;
	bh=F+dHEiFLnh8A5KzJ58bksVScGa0jeuzf/tPIICsdU6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuT5ydU0u8Apuy6q7x9kxIBZszgn2NgtbuVQyWdsQgKUVQ5qGM7Gk4pYhmp2BgJrbBuMiVW4TC7tPFUDE53EpzO55tAQVqWSMYuj63sKD0XREnis/Uf+4qPT+fgEskQ3V/wP6PTM6CuH3Iy8KyvxxKJkeHdcFY39hc0BHyQudXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6Cx6GGS; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-781421f5be6so55453967b3.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588098; x=1762192898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiovYXP3PtaA9Kfj7XU3nz29JiqSsYJIIOo4G6t3ivA=;
        b=O6Cx6GGSJIbiI2nx+yk+XY+6BIUZ60igmRyRnixex/8rG+NRQXEQ7mt9+dHbkKPida
         BMChyTjviwcfxMxqNp+wP4i7iO2D7FWRgC6MaZR7/GqQ6KYGC37nvhB/MRCmY58teC8w
         sztrkM+/oQORh7mDIDZ1gFI823xwKucQ4cdAyazgCqwWGNXR1nI9HJ5PqYY3tZ9p1yNz
         5cZEOeQLJ8Rz2CZ+7avlKRQFpW2Wax5/oJElUYrPpxAeVuEg6YqGBi5nanESCKYoYqGw
         b9ZITqXUzv0m+7aQ269qHr7ppIWhhRoNPZHlMjBDPwfnqyI5mQLDUBiXVcLb/hg4Nn9D
         mDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588098; x=1762192898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiovYXP3PtaA9Kfj7XU3nz29JiqSsYJIIOo4G6t3ivA=;
        b=cPQLkTb2Yq16qnbpe5srSyCOWxe3b0Gcp8TxUv75LICcDf9jjoy7oH4+gZwWAhhcOc
         Gfu1P+oy0+yyUcbNaqmz45afiPGtjOKdCzZY7EX0O36BfZT06H+NMhobVshjVMO/fLXd
         gLAnVJgdTeSpB6C251wRijujWaBpiS0subWhVeVRLptS6cFOh6Wwx5+s0K6cBA/DXyFz
         mQpKyMwl8YoW0xVg9whgrzTBF/0xmYp63MT4fkSjwLBrj2kOsrwIvE6eQSV4LPKkffrf
         GlsT3hM6zOh+fKLDGKANgD5NQL+vCFeTiaXZ3sdODOodehEGha+n943gJkF1n3m2Z5S0
         65vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDaqHnW6Ir1NXLkiWVtIjc5dR+eOPJoSS+O9z7OMOY+yIiwlAktOprYsLaAKxBBlpkjCHl8ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhBltGHKtqqX5fS5+niBRAtNBZo4Dir2pbOT6ZxouMYW378t3P
	mdmzxezONkYsrPuCdn50WQxU/o/t+6Xv8zE15OJYPSV42kR1pvE2fc23
X-Gm-Gg: ASbGncue00sbm9WDz8F+PEYPSjGgiEyZhx4B8vBpNtoPfgcwC8nYxi1do5mivvZBvs1
	s2xhFNYNhUBvo/jO0Jg/gdQ+6PbD7XTatP0mvfWXi9fU12H4okqX7/LWbmlAM01yDCFbfRcqVWD
	zVVZpOV2nXnf39bSKjCIq1pS2QOh/NSHCRRUBuTabewMsyDLiK0hht2WKY/2sx3bpWIda+cG75v
	g1NPTSIOQudYlJYvmLtj/jS0ujSvQXckM5wfbE0sOUO6x9kujev9QqrJWBBFtfPl77sZq6r4c4F
	c/MLJ4unqm7TzFMGP7vA1gKcns0QPIM+qocD3ar8ffCy8C0R8TsBkMk2ECRJ14uJMEHB7LklCIa
	xkkVcl61e1dZ07HsvNbh6gXIybI1JDf/PS7swqvAZmgkc7oyP2B9ylOrJXt1rOoratsR+KmJuon
	dZvtlzOaeSikf1DPXmIDMuauVzfBQ1uCOB8KqG
X-Google-Smtp-Source: AGHT+IGY7m5xCBIjhFzMJJMeIr2LMm+2g2vwUGpyuiJ3FoHQ+eVB5BYIwqC2NkP1JlPdGSmbLHfPDg==
X-Received: by 2002:a05:690c:ec9:b0:785:bfd8:c4c0 with SMTP id 00721157ae682-78617e03ba5mr7395497b3.4.1761588098317;
        Mon, 27 Oct 2025 11:01:38 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1c875bsm20767397b3.46.2025.10.27.11.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:01:37 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:01:36 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-kmqhvo4AFv1qm@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > the vsock_test binary. This encapsulates several items of repeat logic,
> > such as waiting for the server to reach listening state and
> > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > from hiding failures.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> shellcheck has some (new) things to say about this patch too.
> Could you take a look over them?
> 
> ...

No problem, will do.

Thanks for the reviews!

Best,
Bobby

