Return-Path: <netdev+bounces-227469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E7EBB0204
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 13:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CDA3B80A4
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD62C325A;
	Wed,  1 Oct 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXdYR8BM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F72522BE
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317729; cv=none; b=UHakK60tr6vscl7hWUyYZnYQee6fUddQ+UN44d/r9kjJo2fK8620phrPYyj0qKVNQhPvOdKTX5BG+/aj+xaHnZ2shlyekq4Hq7IB+RqiLmgzOA7LWOXU2n3Skzq92JQuUbturFJr118iDzMIS8pFXrNGmoGoiUT6RF+EiSS/N8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317729; c=relaxed/simple;
	bh=MHUSi4P/U4csGmhflVuOc3gtRv4O4p5QklistO68IOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvksM7OsLb87vmAPzXVVNUI/NLKNt0LK+rdYs8EFvGXWyixC5X6gv6cDBMF8KVzVC1VmnSlk7v3/q41reR0CQKArRKWbc0yq9AkEBtePdacBE4si7SQ4Xz9EwmrexZU5owWVq8yy771OA4Tz2ewqC+g83VU6K3GdFX5AUYJZ93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXdYR8BM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759317726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ql3BeV8zLppnm7zJzsQP4NuOCJwg+ayk79UQ80gXYqg=;
	b=iXdYR8BMmDBxquLWQGAE/DAvT49wRvs8MiQqLoQ0z1aWy3r4p3iPN5no0t4a28QdFSCTZI
	SyCv+OXZLw5hG0bAWEihz1eFx9D1Ms4ft/4Y56EXGUT1H18zGscclT5u5kZluC0CpfYpGw
	ni5teKlvJSlIRHZIK3EXXEyGBeMjNiM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-PBHDh7Q8MOShcGkJaWEaxA-1; Wed, 01 Oct 2025 07:22:05 -0400
X-MC-Unique: PBHDh7Q8MOShcGkJaWEaxA-1
X-Mimecast-MFC-AGG-ID: PBHDh7Q8MOShcGkJaWEaxA_1759317724
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f3c118cbb3so4541702f8f.3
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 04:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317724; x=1759922524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql3BeV8zLppnm7zJzsQP4NuOCJwg+ayk79UQ80gXYqg=;
        b=dNVWitc5je5XceF+ZxzCBNDOgU7UGvGgDVPQ/4Q4Sc6812hAh+COHHhBHelnp3JNZf
         YGaXIyFYRXwU1MENpiIvguUynkqBo8NprqZg79g1oW4XavXjbt77bQyGBKv+B+We4TJb
         jtEGmaGrFZLm1xthS4wsIZi8eS3RgS2Zmv9Q6s7VGsOjJ97aNEjLqqgtvcj6x5ALnIU7
         A1grIcn7wHQ2PAD9UYvzzRnG/cCFCePYh8uezUFoAAZBUGozCWKzlbjQ9oZv2d1k0jdx
         4HcnFtNreW2xu03/T/UBVtXS0lleyKaP7Fs5eHUYW/pc03UrAn6/IxwR4lHLIVNorQzU
         byng==
X-Forwarded-Encrypted: i=1; AJvYcCVrdZFx6721+mYMYSUvF3/SWQDUCYfsGbVj2IHjCNWih0oTydQe++Yrzrkg4I5TmMw2VjFpYTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVSAibxwP9ZA4Ioy/v4F8qAjtCD55rrE8ZiA34bWpPTRnT5Nj
	zLh4gSvHWxXZPSFRDqCtdC77/Rb3cO9j3dyXzMrv/2+jj7Pjey9ywqq7IfvjuctRGZ+T6ftQkj7
	33XxxUQRMNc8nDclv0q8WDyH4r/XjllpcPyTrs+S62kVbaVuWhLTHzzcMSg==
X-Gm-Gg: ASbGncs08v4kwVnIwF6izihzwkkCZ6yIfAj8CyoqV3w1MdiS+lNp3sGZ7GONk4CGMkg
	+eDg/JZT58Extb2XtiqLDI4NCErOt3AkiiGqhGkZyH4B/PBXArZKARldTBsGlGcIxaoDJnm594o
	ltmJbegv0rv5GAP1UfcpNBn7/CUrTEgII8B74dS5SYq7b3ULke0UZnSow6Joxx5JBA7xqCRs0ig
	vRFf4fWPjYQ/CKit2slJtT22uZAGyfmz6AW6J/WjmHVfsLMrgepUh0JTX7BSnXeftXWtBaS14y0
	JTX0cHzrCnK9axaCka+3ulItVP8jlFdpkn2oGkg=
X-Received: by 2002:a05:6000:1a8e:b0:3ec:a019:3936 with SMTP id ffacd0b85a97d-42557816dadmr2479670f8f.55.1759317723712;
        Wed, 01 Oct 2025 04:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2YMfWSirAsieLM5wvLlIAO/DtCA3N6PuMAY/Nmj+lVBGtH+Oqh6a2oWTtM5/KVZ/v7RwKwA==
X-Received: by 2002:a05:6000:1a8e:b0:3ec:a019:3936 with SMTP id ffacd0b85a97d-42557816dadmr2479627f8f.55.1759317723082;
        Wed, 01 Oct 2025 04:22:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm27105223f8f.20.2025.10.01.04.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:22:02 -0700 (PDT)
Date: Wed, 1 Oct 2025 07:22:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com, jasowang@redhat.com,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net] vhost: vringh: Fix copy_to_iter return value check
Message-ID: <20251001071456-mutt-send-email-mst@kernel.org>
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758723310.git.mst@redhat.com>
 <175893420700.108864.10199269230355246073.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175893420700.108864.10199269230355246073.git-patchwork-notify@kernel.org>

On Sat, Sep 27, 2025 at 12:50:07AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 25 Sep 2025 02:04:08 -0400 you wrote:
> > The return value of copy_to_iter can't be negative, check whether the
> > copied length is equal to the requested length instead of checking for
> > negative values.
> > 
> > Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net] vhost: vringh: Fix copy_to_iter return value check
>     https://git.kernel.org/netdev/net/c/439263376c2c
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 


It's probably stable material. Does netdev still have a separate
stable process? I'm not sure I remember.

-- 
MST


