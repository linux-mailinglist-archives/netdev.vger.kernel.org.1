Return-Path: <netdev+bounces-224532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11913B85EE0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5696244F0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7442C3126C3;
	Thu, 18 Sep 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6tF/S+1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9033DF59
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212072; cv=none; b=Hjqc05U7kzHRdlG05WMt4IERBQfFPvdpAirsPvpVu7SI4DrGefBIBTCDt8c7NIs36iEdvi3Mwxg0yLHIZAEIpnK1gPF1Gt2FSMLJiVOX5VnfNv9EqM8g46YDUstreJBbnr9zKiZQKVsVGzixbCG8cFUL8kkmkV0a42NNBgO8i0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212072; c=relaxed/simple;
	bh=bmboGWdmYKGEjDqvYv1DVm9bs5qgX4S3Ny/0S2so/l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/eUZG5VUUUA1V/TsPdSO9T9iKWaAjxihdo4P1a5fRdAjxID7IvpkIT29allo6tTf4MGClAyj4PZC0NahXVh3Nk4x/WQeo3V9OvZqate8K64gAljany6J9Q4Pp7YlfXj6TES9adQYXhIckajp9g8MbgO8L8E76b9b8mkViVhWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6tF/S+1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758212069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4F3hybZYhx1Ydbv1SoblmjPS3ZmGcfGwW98Zsh1rblI=;
	b=f6tF/S+1ZTa9D2ppr+4JssBn1v/5wiclLz1kaX+we1pe28ckicr3+Sj0J0XTrDL5yjZhAS
	YuSWRwLk+rN7GKd9uaYuYPFfcgIHn7TAWFNbUBPr29YUMlQnqHX2rvlXpMOlwjT5+y6van
	P6oxA02FFvKa2ttlaaSNee98dnMq90k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-G0rZW8kxNUWGJ18JAdHhqQ-1; Thu, 18 Sep 2025 12:14:28 -0400
X-MC-Unique: G0rZW8kxNUWGJ18JAdHhqQ-1
X-Mimecast-MFC-AGG-ID: G0rZW8kxNUWGJ18JAdHhqQ_1758212067
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee1317b132so457488f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212067; x=1758816867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F3hybZYhx1Ydbv1SoblmjPS3ZmGcfGwW98Zsh1rblI=;
        b=RTu4AUH4qhipvsDEzyFI8uGtGvryR65AuSvkx5Tw0FKa8fsOjOuaCZySo2Ch4O4D7q
         edTc4VniqHFN0jR6mgP5ruKFgnKfix985rJvdteAhFoHQuhE4GeVZyNk8o55wuR6BYzY
         +O6u3YnGmadBPqxymJSidvppw07DIiU2aZzRm35qr5O+W0ueYakJtmJjocJbjmwJ7mqR
         P0byKdmF7sU4qvxwPNGVtjuEEwQuTjf1PYix3wwSlGKjlA7QIrH83nHKQZCKlLNBTn7R
         uzp8hmkYYyfPDhGU9m2/A9qw5edNYa1MBysYhIPT25UCLMcb97y8kE6qaBDlLD305qe2
         AKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGVPVjvn4aI15yWG6V7+HxlXzKqrgqiNx9UxpEDutXynE7zgPw5zYplwYqrJH01/16RRuc13M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3gEBKChRaJHjTr5zlpEM6fdqAr3n60pZXdsIUFU3gSQAxmbC
	dBUrLmQuCxiQ/Vg1/5axZwJiT/wP00fYgxjnV5W6Fy96Y9Xgf//OQiNPvqNhI0Z7V7BSpEEGB7Z
	5sbAYMG1i+7fmVHRbEyUjcYSG3ygDdXmEN0MteacrEiShtp1TfB6J4nJvnw==
X-Gm-Gg: ASbGncsmRpWKrhHw0aoe1WrlUFBFnxuJq19Lgo09WxeNZSELWZuHzV3TuWRs92gCvO7
	zVHIb6PrqN4dbv8jGTOYBXZ5qvWssQEBFv2VLGyBzbaNPieXRg1/lOxURCG92J8wDakz+5Ynurm
	+hnKsltZxcPJwl/kNgFrnfBpTbsBnH/wfQn1GinBs/Yf8F+34KC+Bc4YNw55B+3ftnXW8WlnysW
	yOImnB4qvu5BaSKVWYTEutLyTTHmVGobdzD1XEYnI5doCWlVAnW1lYBj5F0E2RKqVPhqH2Gyv9H
	24SGdNz3K2Ar71mje+1dHTYpU26hEu1eoqE=
X-Received: by 2002:a05:6000:2283:b0:3eb:df84:62e with SMTP id ffacd0b85a97d-3ecdf9b4972mr6994285f8f.3.1758212066832;
        Thu, 18 Sep 2025 09:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWuV5SNvbO5Tb9W3Xvg5a4aZyLEyh56k2xiIjkOqz9AqDLzlVKqyG0LIYCFPiIYi4OwFCHPQ==
X-Received: by 2002:a05:6000:2283:b0:3eb:df84:62e with SMTP id ffacd0b85a97d-3ecdf9b4972mr6994243f8f.3.1758212066373;
        Thu, 18 Sep 2025 09:14:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm4388197f8f.37.2025.09.18.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:14:25 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:14:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, maxbr@linux.ibm.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
Message-ID: <20250918121248-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918110946-mutt-send-email-mst@kernel.org>

OK and now Filip asked me to drop this too.
I am really batting 100x.
Linus pls ignore all this.
Very sorry.

I judge rest of patches here aren't important enough for a pull,
I will want for more patches to land and get tested.
Thanks!

On Thu, Sep 18, 2025 at 11:09:49AM -0400, Michael S. Tsirkin wrote:
> changes from v1:
> drop Sean's patches as an issue was found there.
> 
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 1cedefff4a75baba48b9e4cfba8a6832005f89fe:
> 
>   virtio_config: clarify output parameters (2025-09-18 11:05:32 -0400)
> 
> ----------------------------------------------------------------
> virtio,vhost: last minute fixes
> 
> More small fixes. Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alok Tiwari (1):
>       vhost-scsi: fix argument order in tport allocation error message
> 
> Alyssa Ross (1):
>       virtio_config: clarify output parameters
> 
> Ashwini Sahu (1):
>       uapi: vduse: fix typo in comment
> 
> Michael S. Tsirkin (1):
>       Revert "virtio_console: fix order of fields cols and rows"
> 
> zhang jiao (1):
>       vhost: vringh: Modify the return value check
> 
>  drivers/char/virtio_console.c |  2 +-
>  drivers/vhost/scsi.c          |  2 +-
>  drivers/vhost/vringh.c        |  7 ++++---
>  include/linux/virtio_config.h | 11 ++++++-----
>  include/uapi/linux/vduse.h    |  2 +-
>  5 files changed, 13 insertions(+), 11 deletions(-)


