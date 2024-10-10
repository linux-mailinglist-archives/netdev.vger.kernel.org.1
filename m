Return-Path: <netdev+bounces-134421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2999994FD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DE2B23660
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F691E47BE;
	Thu, 10 Oct 2024 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpph0ljh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538D1E2317
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598457; cv=none; b=ETjF3E/qCdaTEDn7MVIWidjIOs6OnwZMsTib48u1Wwi2/KH1/tyoNEe6ji4wfjTuDvpEpAxlzN0ve4PsUBnqlKkB0zhEzte9bN2eM3Mzm8qhcBKAXKeXS+VDxWEw8U4hWj07DO9+rUb/ODUZZ84N0aIPWUp5ZUApYCg8eUZpa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598457; c=relaxed/simple;
	bh=5aXOJC90DVmyRKRcC59KgYLiJOgc3LQb25mLH79D8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbkgtxGxabGKpOrnq1nhAganQ1xImwpjh9lw1wbLpKWdL/YncwUKn249GF/4qm9o2LWFgMlInsBkXfJL3OSOWUheDgs4IPopdGMFSxrC8lM9+pj4kDmIvwFeOgJ7zBmpQJDB6l0bzzOlizViYthGM06WxTj5CG5EC/MUjEe80Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpph0ljh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728598453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5aXOJC90DVmyRKRcC59KgYLiJOgc3LQb25mLH79D8U4=;
	b=hpph0ljheqACL0HHP+5geR0qdy/ok5v8yYDCqikhE7B5qOamQdYTbpUi3My2nV0BelQqli
	yx2n6lIZoPQRNTigbJyVGvdQn6+34UyBF0dxSbwge1LCmAstg52U2MIzGhWEWC+bStT2TC
	lVuHuhxPq3xtdBJ9+7qmeAs4crqc648=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-T6QeexXBOl65Aa9AaLYbyA-1; Thu, 10 Oct 2024 18:14:12 -0400
X-MC-Unique: T6QeexXBOl65Aa9AaLYbyA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43117b2a901so9744685e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598451; x=1729203251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aXOJC90DVmyRKRcC59KgYLiJOgc3LQb25mLH79D8U4=;
        b=O4LglyjPdbPL0XUcV67Uc9mMYS6g5I7wSOvKTztz3+AqNKK3ZjVyR+72NC7scE3+UG
         Fmwr9btsET0H3sBrqfCmIt9bAdM3sxo66omB5WSzCun7cocutDBn7Y738YSfv6FyPUt/
         Ta2Wtk5GhfCnMobUFKl+bxf7+0cgT9eCK+o3R96L574KRQ203LGKwqXK+XRade8+rF5Q
         Lzx3ODmiE+FGzjWXrVbXmFrhozUm7d2cD/X990Hs7DCoDMmrvxtxF6eBdfKdtZnr+N4n
         Hl0pHOdIGUUf2kT87O0UKdhhPIEzoXrMo0WIyUtRITRSSCLF11Jvq04Sx+kazj0j73SC
         tsmQ==
X-Gm-Message-State: AOJu0YwhCwyGJmwkzHkavpiADVtkOlWtNmHvoA4xZeyvSCFmsF+NTNcu
	87k2bhk9nJ/dQ5s9BARI7Jzk/lcQ58kYO5dfX65zk1nY64yHajITIft6YYlqUg1B5nJGRRmBsS4
	Ap3KAV3dB8Kv6JAdht/AYrH73c7lyfT/vq8pIdfgIsivpCZYEuU2aIQ==
X-Received: by 2002:a05:600c:358f:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-4311dea3364mr3744895e9.6.1728598451386;
        Thu, 10 Oct 2024 15:14:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF450MhAxj1j1OaXLcIWU4E5531MZHCRJ7NKV2+VENLArHGzKOKX9euNOp2tUzudCpwU2VY0g==
X-Received: by 2002:a05:600c:358f:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-4311dea3364mr3744745e9.6.1728598450934;
        Thu, 10 Oct 2024 15:14:10 -0700 (PDT)
Received: from debian (2a01cb058d23d600a14c4a1c8a7913c2.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:a14c:4a1c:8a79:13c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51c69sm58590255e9.28.2024.10.10.15.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:14:10 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:14:07 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
	petrm@nvidia.com
Subject: Re: [PATCH iproute2-next 1/2] man: Add ip-rule(8) as generation
 target
Message-ID: <ZwhRr7DokDwmMmQT@debian>
References: <20241009062054.526485-1-idosch@nvidia.com>
 <20241009062054.526485-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009062054.526485-2-idosch@nvidia.com>

On Wed, Oct 09, 2024 at 09:20:53AM +0300, Ido Schimmel wrote:
> In a similar fashion to other man pages, add ip-rule(8) as generation
> target so that we could use variable substitutions there in a subsequent
> patch.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


