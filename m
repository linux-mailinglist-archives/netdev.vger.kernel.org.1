Return-Path: <netdev+bounces-217994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A5B3ABB2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ACA1BA19D3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80B284B27;
	Thu, 28 Aug 2025 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmC/Ge7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369330CD84;
	Thu, 28 Aug 2025 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413234; cv=none; b=H4oWx1KRqcg9GdaWS16S3/ikztEhXlvQEH9ZXAVq3oi/84kMJbohskiDV2jvl+uZi22KJOBI+z+SjhFHdtOrV36aGeCZMRMvjHNbwb3UA1yPtU4EOI34uE/xoo9WtIq6JkbxJZKfhQE2JNC5LzphIGWJeE63YbwkvFqFbAMW+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413234; c=relaxed/simple;
	bh=oD5veRPeSKOUCJz6lmXPx51TmD7FNK/BfadlJ2sFV/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti0sirwvrFnGHOy3b8Rutbpx9vb+UTGbwGRzUuCvh+qBJaPcD+9e4/+8mJSgXjqCKnm6AXqIoDTghks3P5UM+7jYCY0ybClHiygs5fEzuiGy+jF8PDoH72x04MOq0niKKVNCgdcYEKuWrFJyMbxm7yYtgJxqx5SZBsWmJaVbBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmC/Ge7i; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afe7584b6c1so16995766b.0;
        Thu, 28 Aug 2025 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756413231; x=1757018031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkaYxjYHvoyzrzNQ+/rmfpF/F2e2Gc7qf9aPUXa1ing=;
        b=jmC/Ge7i9UN/z2uPZ175uEURCBh+400ikO8pQ0NWe6dYb4lwetsYFBhB9qGVTwuryq
         Qp4G8fP5uZa4IHveOyABxkIms8bcw9cQWSmO6OmQBRJV+4ifC6t6J8RNtttBkb7HaMv2
         sOs0UW5GawDjlzotiOq3ZrErDAOqdpYKVBmoKk+dVotoLL8rk5r1bh2S3XKW5bz0gV6E
         6gCFJqBbtOWWynHSwEtopVBZa5zKXem+Ed6EST8A0mgMA+eUFtc9t8+ILkot2LGXI5+e
         AOIg2HQ4XbfIVC9rF4ZmWjyZMtXyese4VEK0IWyI3srXp/rokvHKmr+g6uFiMeuTX8v1
         /nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413231; x=1757018031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkaYxjYHvoyzrzNQ+/rmfpF/F2e2Gc7qf9aPUXa1ing=;
        b=i8XWshhCXWYEhJF1IvnIZ99+gZ13dWR2oqutdmTpcTrMqHcv9CpZ7Ti7LfytJbWav4
         YKbD5w0y9L8sMNtLG0WBaj/TbJruN6yHVvBFKmMvDwOzDSRRix6LZLP7kfXFU5I8wbzZ
         /Dx1sYLa3Kzz5xb7TkxUnX/QcqrV9q6DQN/AAKa3nOr9WjSTECl1Tki3jP83mzxzhT4E
         aovVy9xGukqjRaQScelY7Rn8U0cMwZWcg0O4IuzxT1/x7bgB+4QBBTKO7CpGWXL7laCm
         MV+bQj1Xudd7MoYDlTT2lsE/YTjQ+Fn9lEDQUJyo75cA3EdMSupDFEU7DaXENd8gCDYd
         nVvw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkUyUZ3Ri8i9SpSM4lzhdk+2cZ5IVfi1m8ot/8p722G9Cr/XOlGResQbsTbuEFw8klgJbErRC@vger.kernel.org, AJvYcCVwpYzO9PMXxNrMSz2KEFbhYrDXGe8/Pyzo0FQOO/ISqz+lAzNP0rd+yBI4+D4mDmQ8LeNsMuBofYesWYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDUDuqLQeou96zlxGHwxLRy0HXhUg3n/z1TM/R9a4HEJ+CEEv
	6kLyEM/WTrNKU/toqtfi3OwpxlT9hzG14n/GWSwKcT1DKlQtqqGYol4v
X-Gm-Gg: ASbGncuuJSgkTzU7m1PHWq2CvR7vsyHrYFw6GGiLiDURUTAfA3p6i5Nph4PX5D3Gnng
	vAkJr5MHIrTMfce7jKAiY9kJoytmMM2R2vT9zwPFiTMc/GQtMXWrBMh5TZTtsmww2Mf8ETiiMPC
	RY9qcFix730UHwedVbZW3lidmVk17DvMqcljp1ciF0+KTtJEqWDPJkddy/CNSyyUuvx7aNpf49X
	KH4B22EHjEpxhHhp4tpuEBED+C66MJB1/T8HIMY6y9Jox221+rGw655pqfYSezaaoBVfbKp7diP
	4s12POgAINTpfcHjKlqL3LBLU3fGYR5Av+RkJFMBszbOxz+RgX+bb2mNJKoa/tOemLQrZ9BDgT2
	AZASnC5x4XvarxwqI4HAf5Pf5CA==
X-Google-Smtp-Source: AGHT+IGq1Wu31vL5Hgrcu1MlSAJ9ffpGygD8tF4/ClTyANhncYBDOA9LcfdbNdkxJ7KXh89tW72reQ==
X-Received: by 2002:a17:907:970c:b0:afe:ae6c:4141 with SMTP id a640c23a62f3a-afeae6c482fmr492993566b.2.1756413231015;
        Thu, 28 Aug 2025 13:33:51 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2cf6:b150:1dce:5f2e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca08b17sm34359766b.35.2025.08.28.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:33:48 -0700 (PDT)
Date: Thu, 28 Aug 2025 23:33:46 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 1/6] net: dsa: lantiq_gswip: move to
 dedicated folder
Message-ID: <20250828203346.eqe5bzk52pcizqt5@skbuf>
References: <cover.1756228750.git.daniel@makrotopia.org>
 <ceb75451afb48ee791a2585463d718772b2cf357.1756228750.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb75451afb48ee791a2585463d718772b2cf357.1756228750.git.daniel@makrotopia.org>

On Wed, Aug 27, 2025 at 12:05:28AM +0100, Daniel Golle wrote:
> Move the lantiq_gswip driver to its own folder and update
> MAINTAINERS file accordingly.
> This is done ahead of extending the driver to support the MaxLinear
> GSW1xx series of standalone switch ICs, which includes adding a bunch
> of files.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: move driver to its own folder
> 
>  MAINTAINERS                                 | 3 +--
>  drivers/net/dsa/Kconfig                     | 8 +-------
>  drivers/net/dsa/Makefile                    | 2 +-
>  drivers/net/dsa/lantiq/Kconfig              | 7 +++++++
>  drivers/net/dsa/lantiq/Makefile             | 1 +
>  drivers/net/dsa/{ => lantiq}/lantiq_gswip.c | 0
>  drivers/net/dsa/{ => lantiq}/lantiq_gswip.h | 0
>  drivers/net/dsa/{ => lantiq}/lantiq_pce.h   | 0
>  8 files changed, 11 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/net/dsa/lantiq/Kconfig
>  create mode 100644 drivers/net/dsa/lantiq/Makefile
>  rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.c (100%)
>  rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.h (100%)
>  rename drivers/net/dsa/{ => lantiq}/lantiq_pce.h (100%)

I don't have a problem with this patch per se, but it will make it
harder to avoid conflicts for the known and unsubmitted bug fixes, like:
https://github.com/dangowrt/linux/commit/c7445039b965e1a6aad1a4435e7efd4b7cb30f5b
https://github.com/dangowrt/linux/commit/48d5cac46fc95a826b5eb49434a3a68b75a8ae1a
which I haven't found the time to submit (sorry). Are we okay with that?

