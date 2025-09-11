Return-Path: <netdev+bounces-222130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C426B53387
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F9D7BDBAD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A2322DCA;
	Thu, 11 Sep 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="igDt690k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F02E8DE8
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596828; cv=none; b=F4r3ReyILBADFEeK4RwJ8gAjLagrOdOYy1DeMQv14DPcWudF5aQEWc0YnhfSAvxoQrr8jZ7dCwGd+WscAbetPkuQKtkdvv7P11nCs+Kjv5ELgGRr2yEOIoVgqzazckb8vaaDO5fU8wjWE+1Bh1Efdk3Bt8NY10cU+dkclllLV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596828; c=relaxed/simple;
	bh=O5VXtAOP/OmIhTsuzJDvPX+XiTm+lHL4PKa8YEVkr/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cy1AsPAT+Dl0xpnln81dFykdhhdD79cAC+57F8kIgT8e413zwI9ORUr+A4dxeorVR2g2CCSvk0TqeD8mrGLQGQ3cdHbDzuSGEkMYm3DHQcs6+yluHbgw1TOwmuTGbxvp07hc5wDgP+JVM8uvfVFhf0ZWBMdzn/M+nBDnx5uNmxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=igDt690k; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32dd4fa054bso606180a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1757596826; x=1758201626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5VXtAOP/OmIhTsuzJDvPX+XiTm+lHL4PKa8YEVkr/s=;
        b=igDt690kF/o23uuWt9s3pSRwfzAOMeyiG2Dt9dDkmYpEFPS2hKWEK/6mDs8tYnG9Ii
         3SvTnc8Wem4NflwGycWNz96PqdS4ePjQy7qQLNf0hDQt6nAhsNYT0fY62tbDoiPYb8Rq
         WCPE6BGs8ldNs3Ad+U8qkdF4PBKJbnwRBgPgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596826; x=1758201626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5VXtAOP/OmIhTsuzJDvPX+XiTm+lHL4PKa8YEVkr/s=;
        b=hMH3dMvk2vR3tGzecACWS3pkLJ1YYAaYcw+leW5Jrn9Jor/yFLNGIPt4ohJWGUOf3H
         lpyLtU5qRpDmP9mHwRM0dEtg5tlEVHEWsBNL1AYIt7kPyr7nxyfRni8GoX+IHENUfdGt
         INxe45PhoEwr+QqVw+CxIo75tYrlQyi148s7TbnNlFZ02kLgSW61suD5vu7U+DHcWeiF
         9iYaP9rGoLjj6H4urqivmhXjJ3usD0gEshGZ8k9tQn19Oxn6Vm2mwAK3hZUzn+rcT7No
         S7J2p1ib4UMxyYYJlzfp0Ntbd0pfJGxBEm2vosBhwCASZn2pc+BUR2hfUen5wG5zu4xO
         G1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGY5YtnuupPIPjNWZLgYdab2Qoy5Jy4llyCPmmJpR08ASDdbyNzlGf3DUnVSA/Mis+CuFBlQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwV2+y04LTrM2gLXt2qWf4qY+Ial8KRCNzc7jQUgEcWJxihoGM
	NN7QWBuehEj7YZ6zZNWJOqSCP5h5YMnP9JiZ3eGtHEHL/bQafIl+ztIVAxGhbXt8fsmzUjXTHq8
	Il1qm73wCvSSQ6trZO9S/OnDYXsd2hdeImxgIJfsolg==
X-Gm-Gg: ASbGnctWTlzp4Ves8hphSrk74I9tO9PLys/gdAh5DAQKHUt0UQ3lLn2BO/b1+bNC6rv
	CE3UU1fFDSEZd0cL9sqtTSPJbbdlRh+pGMwApXxoQgquvXH+N5TPrEE3FnufVung622Z16y4aR6
	JAotnGOuEGxQqSgQ7I9rmOqtxKSPKfKPRoIoKx0z6zF7sc/9UfzZJ2lC4nVBAl/DP4yM17opY44
	ECOFc5C3pADeMChut2K
X-Google-Smtp-Source: AGHT+IHd5xyJNz01wwrpJhDl98T45ztJd8ELgxgaEy7iQhcAjFMhM3czPP8zaiJ5J9c40XxE1kOBKaWdJoKiiAcymxU=
X-Received: by 2002:a17:90b:2e51:b0:32d:a37c:4e31 with SMTP id
 98e67ed59e1d1-32dd1ee82fbmr3766136a91.17.1757596826023; Thu, 11 Sep 2025
 06:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907064349.3427600-1-daniel@thingy.jp> <20250909181322.04dc2fed@kernel.org>
In-Reply-To: <20250909181322.04dc2fed@kernel.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 11 Sep 2025 22:20:11 +0900
X-Gm-Features: Ac12FXxQ70xmDrhK5rD-Edf9LkLgt_jI1IVW96Rk2Cd3DVeZZ2SdNbJQT5z7MVc
Message-ID: <CAFr9PXkYyyCQqHt_-75GM_uup3bSvxDgjDc0-O0t=j3UY_JN6g@mail.gmail.com>
Subject: Re: [PATCH] eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 10 Sept 2025 at 10:13, Jakub Kicinski <kuba@kernel.org> wrote:
> Any idea if this is a regression, or the driver would have never worked
> on your platform / config?

I don't think this is a regression. I think the PIO mode would have
never worked.
Without that option the driver probes correctly.

