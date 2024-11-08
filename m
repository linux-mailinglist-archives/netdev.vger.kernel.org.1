Return-Path: <netdev+bounces-143452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF779C2799
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 23:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1591C2177F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552831E00B6;
	Fri,  8 Nov 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0uUMcD2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251121A9B5C
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105133; cv=none; b=uRCSnf50djo/f4pIo06OBCJwgJMJ9k6ipW2PmyRgD1TAfHrlamzOe0m0Tlz2Y4TRyXrJwcki9wammP7aFQ4fgJxoiOnckVDVRKF604Zq0dI3XCaFoFxFLC5QFWl+poxiKopnH2SUvUxPgS5JqWrKtNXjg9hcAX4bs9EAnNA0Fdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105133; c=relaxed/simple;
	bh=BV1DG2nZYDkYnerBJ8vgdCr1Rv0kBw5xvyNF5SYsqFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq5blagJwchAHXzpoQKhfvEgak5EjeyaMBPvu3g5+AdtvDAfgQZfBxK+IiVZv66oVz2ljmxnT/dleDfn69kCd4KpjodxTNQ6rXjaOZ7qp7dB/XVv4nRcaKabfpN3l9De/+M3M5bSOctIb86yyqY0Fov8CUVicPZ29sbMFOP3vfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0uUMcD2Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cb47387ceso29896645ad.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 14:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731105130; x=1731709930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMFxAHevlzFNIrxGQ+K9VcftJHP16vdgP3TXcAXmVVA=;
        b=0uUMcD2Zh8+a/uiKRXpYcFoe8LxueY6XNs0fERKtfC1Q25w29n8UgLpcaPntjJ3LzD
         Rnj1qEw7K6HKGTvlomB4P45uhC+HqFPXpA0XQ0K5qTxP3jxTNEYJA7j17YviA0jqZPBJ
         +L35UakllJgmyF65ZCf9oG/CTE0MAs0GOaQaiKHESEl5ynx++4Q5MpUe/aIAQ0MDT+o3
         WGZ1Kfc/dKTQa2vcmXT9qHEunOuo98A8mDso/4WUyPt4oAQTrs7dz9n8wlnZmXLaNdkh
         gFyctsuSU2bxnFFWWRB3RsgRt2A5I6H+2sdl0JvTEPBGPgOl4wAx1IkkEZqmrkNyH/jJ
         bz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731105130; x=1731709930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMFxAHevlzFNIrxGQ+K9VcftJHP16vdgP3TXcAXmVVA=;
        b=nGHJYQojQKQYaiWgYeTW9pFrMlZoPPfnvmDGm2EY08Eqnj5iuCqfFeiUa5dkQamOn5
         L72fom/cb0manWZrF+oYDENoS7hAFDQqgFbBpuW3n2ex4FPNUGUtYN1XM1QsqWsRQ6H6
         FqMLalMNAq7eHyN9ckS2mt30nXVJ7QQo36TyqtEqrxPbPiC+sMMNXfWWI9kAj3APktmc
         3OjKUdEl6jrAmCFrPU/w9rsyDNDiU2/qmWiw3/jZndirShhr4YqQ4GBXTrMS0KcPB+U+
         NN8Gn7cdm/1NBJ9mXA5+LxSATEIWoUn1VlRq/5Z7p/WJf+KLfFXE2CnvItjoH6dEBWvt
         1Ieg==
X-Forwarded-Encrypted: i=1; AJvYcCU9zkjZGk054WPXCKVI+tQr/b0QyAlVtwxJD+aFHULxreMxTbpdlEvLQB14NF3eLlDwXDbFCCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziIDrXz+4eQGaLIu1uCMvvRwa83P73I00XWQd7zpvWQvC4GlPU
	jruZK40T70fow3ROlonTl4NjyokEMCKmzRCBmy23vyDafcCWR3nA8Zb6PpGrpEHxwk2pchjdRF2
	S
X-Google-Smtp-Source: AGHT+IEvfUMRQu40BNgwv4zU+Ictx5fEGNli377jI/LInxc8xAl/zMaK9alWOyVlP7LkMtcHGhqpFw==
X-Received: by 2002:a17:902:da8f:b0:20b:61c0:43ed with SMTP id d9443c01a7336-21183545842mr64191745ad.30.1731105130294;
        Fri, 08 Nov 2024 14:32:10 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf7e1sm35951695ad.106.2024.11.08.14.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 14:32:10 -0800 (PST)
Date: Fri, 8 Nov 2024 14:32:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for
 Homa
Message-ID: <20241108143208.2a08d972@hermes.local>
In-Reply-To: <6467b078-4ee9-ecb2-6174-825c3a2d5007@gmail.com>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
	<20241028213541.1529-2-ouster@cs.stanford.edu>
	<174d72f1-6636-538a-72d2-fd20f9c4cbd0@gmail.com>
	<CAGXJAmxdRVm7jY7FZCNsvd8Kvd_p5FPUSHq8gbZvzn0GSK6=2w@mail.gmail.com>
	<6467b078-4ee9-ecb2-6174-825c3a2d5007@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 22:02:27 +0000
Edward Cree <ecree.xilinx@gmail.com> wrote:

> > Do you know of other low-level kernel-call wrappers in
> > Linux that are analogous to these? If so, how are they handled?  
> 
> The closest analogy that comes to mind is the bpf system call and libbpf.
> libbpf lives in the tools/lib/bpf/ directory of the kernel tree, but is
>  often packaged and distributed independently[2] of the kernel package.
> If there is a reason to tie the maintenance of your wrappers to the
>  kernel project/git repo then this can be suitable.

liburing for ioring calls is a better example.
There are lots of versioning issues in any API. It took several years
for BPF to get to run anywhere status. Hopefully, you can learn from
those problems.

