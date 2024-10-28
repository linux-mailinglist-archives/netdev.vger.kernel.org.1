Return-Path: <netdev+bounces-139632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E33E39B3AE0
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE151F218B3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED17719006B;
	Mon, 28 Oct 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pvbAPQUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE433A1DB
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145476; cv=none; b=Eb+NAaJmm9QjKmBuTKp8kdSbEmWmUsK5LRj8pHbtl/YdaBNSKepIckQRCCgbXXxj6WjGFOwjJtOiTatqth4DZgdgxTEHbzyZ4QVIAJcNBphQMYNEz5ywRVJXrIJGxnOTM24xwTb3Mrc7tCULgqV6zaeOcTpyBFhQzDKXdZpnAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145476; c=relaxed/simple;
	bh=zam/nFPNOavmkZ7PPeAdZQPBD/C7PlYukVRfXqALop4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqGlohMCWxmcAVJkXNMbwuIwyP+ntgzEoGRR5d+dHhRJwmvo5NWuU1mOgI8VGtSNLMCPqroj8OuB69DrYyvKT/FAysbBo7AONsUzGr8Mrr6rfdSov0WZJzBWVdNr9u/PlM3SPCgLLNl/cTZwbti/934D77I/GDBerLD67Og6ke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pvbAPQUJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c803787abso37471575ad.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730145470; x=1730750270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlqwyjTp827TDotvUc0o4geqPndOSyzGnVK+iHR0FQk=;
        b=pvbAPQUJRGDR/BvIeuuOLm+bAMLcVH3WZ1mcs9OADNwovc7lD+YfUGayxa2/vCFiaf
         uGtpvXS4Nj3HuyUgMRKK1hdVVt7pytys3FQBNP8v06PEOVpt9e8Uls9iq09dT4vtidpB
         wUN8YrQSpliM0eKkaCOAHjUhRWxmXe9s4ktvrz6QDMfXiwWwf5297Eb4L7Fjo+QDZ27F
         8XuJSzZqC6tjBiK9oEKFKw26o9LOw5hLmYaPjM0awnqUeUSqV9P70xidla/CjpRqHgN3
         I60/hCCdWV8LWtzBbUT1ldjqvIMczFjjenPFoFA08WYj1CpFAHKK6Fv2ZraV6ofVlzAu
         NoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145470; x=1730750270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlqwyjTp827TDotvUc0o4geqPndOSyzGnVK+iHR0FQk=;
        b=ij36RTUypR22CJ93fmIz815XTQ8/UXtHt14Jk0oZ8hTdoWe91btacwN5sEmj6Nx1++
         1Av77Ug2+xSgnmNJh5LlBo94Fc5hSxBNVa+/v7SMyWOuWXg/tQEkqnvHlzQVaL0zWUSZ
         gn7TttzAMWIyxA6gd+hzmEeYEzA8iAYAuZ1V1Ms+jECb6t2b7ZuF9bLn1GB4cslU3O2K
         Zc7mAimTlOL8RdNqHMv+eBN3zS+v0N1t1E8fzXl+t7Oo6aLvHO9WVCrxdW1TniHrgbXG
         GLjRZlKP+ny2JKRQ0Kh6ikXEsF6ooh26AZTxVMPiMIMbeyku2EdsGgj4NkO8/SBsf1lX
         izKA==
X-Gm-Message-State: AOJu0YypGYoLBA1yOMiypzchm8YX5EXnqP13qgKnCwJKXqEwZNGOqnwh
	465DJHjuZWlG3lnTiGC6RX/5PIFGx+CpVfJGNua23aBscLZ3zXYrvhdVTaatj61pnu0pHYO/l0j
	C
X-Google-Smtp-Source: AGHT+IHSd5nerK7eOSEKIGmf9UpG+CGIEeKNzjajfgnxuiOoIqVznRCD4gUtAoKneL+mIl6ZO0Tsgg==
X-Received: by 2002:a17:902:f54b:b0:20c:6bff:fcb1 with SMTP id d9443c01a7336-210e8f30c65mr10345545ad.1.1730145469635;
        Mon, 28 Oct 2024 12:57:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02edf3sm54197545ad.205.2024.10.28.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:57:49 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:57:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Quentin Armitage <quentin@armitage.org.uk>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] rt_names: add rt_addrprotos.d/keepalived.conf
Message-ID: <20241028125747.07b21043@hermes.local>
In-Reply-To: <20241028182707.310560-1-quentin@armitage.org.uk>
References: <20241028182707.310560-1-quentin@armitage.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 18:27:07 +0000
Quentin Armitage <quentin@armitage.org.uk> wrote:

> keepalived now sets the protocol for addresses it adds, so give it a
> protocol number it can use.
> 
> Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
> ---
>  etc/iproute2/rt_addrprotos.d/keepalived.conf | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 etc/iproute2/rt_addrprotos.d/keepalived.conf
> 
> diff --git a/etc/iproute2/rt_addrprotos.d/keepalived.conf b/etc/iproute2/rt_addrprotos.d/keepalived.conf
> new file mode 100644
> index 00000000..9a86251d
> --- /dev/null
> +++ b/etc/iproute2/rt_addrprotos.d/keepalived.conf
> @@ -0,0 +1 @@
> +18	keepalived

This would probably better off in rt_addrprotos file and make an empty
directory for user additions with similar README.

I.e follow the precedent set by rt_protos

