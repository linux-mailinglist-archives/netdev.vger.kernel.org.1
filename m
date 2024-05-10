Return-Path: <netdev+bounces-95550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1C98C2980
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 19:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A073E1C2243D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380AF1D530;
	Fri, 10 May 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfuFEdBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B511BDEF
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363105; cv=none; b=DUGkI9BCal1BcHaoQdhQgV77aCOaiWs/5aXArrSCl4SHuQBgpeOiqKjRV632zR8EMoejte0aPukIwx4R1bYLBV2oPrwgKNpvwZY3TyKs1bMTmujapUb9+RbjCrVZdUb+3cLuYfrQNcPeecBG4yrnfdYtEHzPz9mso25HcIwQgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363105; c=relaxed/simple;
	bh=77jCAZN4T1MnK/eg9Dn9s0HYNi5Gbz3bp+wgywtPJ8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5L0cIHeYols9wm02m9xLE16euOsUcve4R6divldA+CPxadT8I5Us4HCe4Ml37N+RfARACh+pJr3Zh5GTRSQpPEgvGUOK5+PU6/mHTSZHcnowy1R9az+WlvJn40KypUiCHDhVb3Gem4jWtzzzuqqaCGZHrUxvVoTLTbYjKguDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jfuFEdBq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso2345799b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715363103; x=1715967903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RH25751FQUD9IraRYi3Ng4hTjnmqYgAtJrim8UnR4Lw=;
        b=jfuFEdBq40eHLbgJonwdgyHWGexUVHfl/U2WW3h9qOJOjLZNjcnA4rmlz3LsW3PY9l
         lLHdaQ/U7kZ89eZzT6755BvDnteknBtwwOq7Ax64FoSWW4B+//LtSTSThtqsdIR8FVtB
         2SCa3WkY0z3T2hVv21Ck9YMQUsl+7up5H4s4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363103; x=1715967903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH25751FQUD9IraRYi3Ng4hTjnmqYgAtJrim8UnR4Lw=;
        b=kwTbBkMcjar+0gu9J+kvWVqvux/BZeycpUNtD4RuMDeTJk6kllLCW+H6rrkm7HzHze
         6ZTfwq+No6vjluwDdgovMEVLq9/fkEui1Q/2bDxT93KoCLCLwuXH6o1rK2dkcLyYoxoQ
         +UjvLMg4hXclD/tc34LnxJd5cq/psVg8OpBNVUv9m/fqIvPhUGUVnb35iwYHuIPK8Mxs
         ftC6dDOO228G+27Z5ghlqPhEZcRFxE8HoEh+owEd2GCD20TvakecQZFgV5PWaCfn4EXw
         0rsgA4dw1z0mgpR7Mnl98PeeZ1IbmywZKQ5y8HegOOA2E53/3it24NrNDKt7pewLV/fJ
         GfAw==
X-Forwarded-Encrypted: i=1; AJvYcCV4eeSq7zpGmGX4SVdQaJG8ZAsjoKb+KK+uWaJkysvSbNYUnnpp8cE71g8AxWKxBgAxCznE85ftsygYUmyI36UhgGBkM/fg
X-Gm-Message-State: AOJu0Yxq4Pn2kOqtaxrUpn2e4d0W1gezyp2l1GxafTVtzpOHTy2O9Lw3
	UqOQPMZtozG4npBuJeYb859t0K639P5PNaNGlA5ZHmX/RthRmX8ecWAWRAy+4w==
X-Google-Smtp-Source: AGHT+IGGFWmKinmr/BozpgZxQxrIJHVGNpMfgrtBUBSomrJR7j5qbTiNJokxk2pPxp48vFhrBfY0LA==
X-Received: by 2002:a05:6a21:3405:b0:1a8:e79a:2b0a with SMTP id adf61e73a8af0-1afddf036eemr3785881637.0.1715363103156;
        Fri, 10 May 2024 10:45:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341134706asm2937275a12.86.2024.05.10.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:45:02 -0700 (PDT)
Date: Fri, 10 May 2024 10:45:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 55/66] selftests/seccomp: Drop define _GNU_SOURCE
Message-ID: <202405101044.DB260BB@keescook>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-56-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-56-edliaw@google.com>

On Fri, May 10, 2024 at 12:07:12AM +0000, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

