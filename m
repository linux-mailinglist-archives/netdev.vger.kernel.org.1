Return-Path: <netdev+bounces-128093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5F977F4F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BFF28216E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29711D932F;
	Fri, 13 Sep 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivwRDyOw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF21D88D4
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229460; cv=none; b=IcOuXaSRsMwioKyzn5OgWNPJSvC5xab2OJ2YdIFsS0vB2G5kQznDrRiUq4S50433ks0WX/h9cebp8HNGnvwOv5VIrsL67KQNkG0rPzjjptXKPJZY/yAhxl7NdvvWuRbjLStSEztqJmuwqdY3Uw3B9zvhdHu0/e/e2pMXsjFueZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229460; c=relaxed/simple;
	bh=d27/f00X2+JZtXB11WduhSe/Lbkser6pZpmmruFCsb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxBgZkbk9PIyDoJaGIFVkacJec1MM80OE1Cjq0RoQvDUGNaoUTVCphOkQ1zqKKaTtEntWI+pPypuXTveFurzyfUy4Owlq5jFDwP/UoX5axKbUQ3a9P1fHpl9wjOoVHp4GM1bZzJ0Dsb5yoC5e9XtB76UucDjeKBHU6vmiJy6NC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivwRDyOw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726229457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d27/f00X2+JZtXB11WduhSe/Lbkser6pZpmmruFCsb0=;
	b=ivwRDyOwpvXK0i5xJX1QaybXvM2bdv99a5cRq76OADt9DUNtH9U6cKcrKf8YVco+LTPYdD
	y9uRX74scdc4/9CFV//fQnsRiNJDJKBCLa1pxiWaB1NdHG1MH2E0W/fdsUqI+fRgoMABEt
	tkA0rdRWyZxpBU9KkIcwBOQkUytRXa4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-IIfIYw0iNaGu5tPocrX8Mw-1; Fri, 13 Sep 2024 08:10:56 -0400
X-MC-Unique: IIfIYw0iNaGu5tPocrX8Mw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb471a230so15321275e9.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 05:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229455; x=1726834255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d27/f00X2+JZtXB11WduhSe/Lbkser6pZpmmruFCsb0=;
        b=Ut3UoSYYEtltX7RrrVvwdt6SDbcrxWPSJf9CnbqUxc0//YP2kkJg0s7qYC/BEZhfxR
         yPkRGnePJ3bUxA3qJHQzIHohWLukWw1pJ3pP3fLyauBHkux4yGVcAle5oEHD6cwKeLYz
         v9LEcT8iyEvOygTOM6UTnm7zhT/mPerpfEI2eQELgb9cJk5DMPZJcSYSiyKOFw//Z3+Y
         qQlf9BK0ywYeFQpJ8liXpx6G0IKNZYbgpW/LHy4Sn0aMHMErokQYI7JBbZ8XbZtZRaBh
         WvTLtgJ0TtLwl4lu5ON2hBXiaJV2cx6nmLnUCFJFhjtij1Gh4eOTb8IAdetPVrTodK5s
         hHoQ==
X-Gm-Message-State: AOJu0YxsfLXBGzFQc0INJ/b8KqlDUyypiE75e2B42pip+DjO/THosogs
	ZjWSvxlUW8DFphhPxU3pgvm/IV5Ay21D65YneV4HQQv/9aTKOAEt7nrnNlFwDYmCCN/EAVS7vg9
	WB8x6QuRCTvA4iVYA2YQBTSsYOx0jvIDsrk56EWGbXpJmGvkXhSI1qw==
X-Received: by 2002:a05:600c:3b15:b0:42c:bdb0:c625 with SMTP id 5b1f17b1804b1-42cdb539d15mr51075525e9.14.1726229455690;
        Fri, 13 Sep 2024 05:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfVTK94oUnYF3RdFWWV7/MR2yW7XaqW3rNkGcbfMe4rcjUVj3Wfc1so4qNmxkEYi5U1q7+3A==
X-Received: by 2002:a05:600c:3b15:b0:42c:bdb0:c625 with SMTP id 5b1f17b1804b1-42cdb539d15mr51075205e9.14.1726229454991;
        Fri, 13 Sep 2024 05:10:54 -0700 (PDT)
Received: from debian (2a01cb058d23d600f8cdc4d4209368b3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f8cd:c4d4:2093:68b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05a6f5sm22972575e9.4.2024.09.13.05.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:10:54 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:10:52 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 2/6] ipv4: fib_rules: Add DSCP selector support
Message-ID: <ZuQrzDQIIzynsMrO@debian>
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <20240911093748.3662015-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911093748.3662015-3-idosch@nvidia.com>

On Wed, Sep 11, 2024 at 12:37:44PM +0300, Ido Schimmel wrote:
> Implement support for the new DSCP selector that allows IPv4 FIB rules
> to match on the entire DSCP field, unlike the existing TOS selector that
> only matches on the three lower DSCP bits.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


