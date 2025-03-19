Return-Path: <netdev+bounces-176048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0ABA6877A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D49421F11
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05425178D;
	Wed, 19 Mar 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Re1v8Wby"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB892512D6
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375250; cv=none; b=arQ/fu6haeHxE4tjdf0dQRtlKQvxCISWg4/kEGApZ1zrVGyy4OPCeID7OYGMWHBC4QyfohpEFzJ49Acugagvf7XWqDpXIKiTa8X+K9HEBixnQ0zC1DxazxKGRI0bfdPXYOKXxeqNedseMK3v6afL97sC4IYkZzLbF/A122DhE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375250; c=relaxed/simple;
	bh=hEJVrnzm4GUSEpbeNp1hb6r5W3k5q0MPjzpWEDaGbds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4DxOhE3LEMf/9wpRxGCF0cdQQE/rotQhhAN0iGjYOc007ARJEXpEHUqMFOJbg2CyWzZgIEkCT7aUupsSjtCo1cJGR++44Btg78OBXhYZT0lyQ1FGUcHIOE3vzTcKqS+0b510CEEorCepWeI4SgtoFdXR9HOjcCujL4EivPeOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Re1v8Wby; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742375248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OtNSakPmsjuVGQF8Kkh6d/+HhZBiSbvtf54NcxNWCUs=;
	b=Re1v8Wbyp/EiINPcumxQaf0Ev33X8xnUsC1BzZhN3vKkzUd0KLnKMSGW4ox/CgxT+CCmWL
	cgBE2iyXkV8NKCLM1RtqxpHDVVHmCV9WznPD6RYzo17n3pCcBNdus0yrmUxmkEKoXKil85
	hhc4Qm9ckrjGF2Eklc9KcvmQ5f0U/6o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-Mpp9xUsrMaOR6P-oE61aeA-1; Wed, 19 Mar 2025 05:07:26 -0400
X-MC-Unique: Mpp9xUsrMaOR6P-oE61aeA-1
X-Mimecast-MFC-AGG-ID: Mpp9xUsrMaOR6P-oE61aeA_1742375245
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391315098b2so2607016f8f.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 02:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375245; x=1742980045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtNSakPmsjuVGQF8Kkh6d/+HhZBiSbvtf54NcxNWCUs=;
        b=Wy9JamNDJ7FvgSaSEAm1ZLOObXGdtouurURTMe1INCl/DD4fzC6Jog5nm+DRY1QHIV
         T55UfrU8CWlRuntdwPb0wg6rpePU1yLG4KOMtTZAFtMw0Z1gwpiAbZzMVN/6bZNrEd0m
         JSRY8/SBnNgHqCFinRg1I0phJx7jpFRNFCd/RwXf4uK6loZY7EeUkOnnuwJpCNyPauet
         h8BWmFjK4yMmW5Z5tc4lfUCYBhTaTAYq01t4hACGjzj+gWt91i8QUrVuKq7JDdBkskZi
         jGLZDQYnUzctu7QWUKMlGa7D609V/cUc44Kxak5gr4f7zWlAC/01ZrgX4B2U0lZRhu6r
         AENg==
X-Forwarded-Encrypted: i=1; AJvYcCWBUg6UAMVt8aw5x8DQbcvWYSgAJ04h0to/oofWzBTboDHL1mFTeooszosI/SBNN1EAcsYsIXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPWm/lmJxeWCxd6cmPierdwhxv6Et9WnSZqZtyHTP7YDpOtX8
	xJQh3X5bEx6wiwaiQOUIWA559PoDhjV1hiIXt7rcP2tWp7+eCFmr5t9eIEUAWash4KHAjRJOI/5
	6PfxITXNuFj7Vqt0LnuZ+0RINih8F9OFOeks0fCkjCTlezbNp8glqZA==
X-Gm-Gg: ASbGncvZduF/Nq9/hA9THqg0MrNRyL+n99Gxkv2DhVATjHFeTeKn1veIz9WWSov7VtS
	zJdWsgOp1ecKw2fgZ5BoaSVJwMUS63maJlqCzGG+BJTZ7nHf4k/RC68bvLV5OYWtgunwreZMyDJ
	ystwep1RVU1DadwfFy9FBnX4ywEcTiRc1/g71LYqeasFyrLoKC9it9h7F2IcVjqV987iaGUoKiV
	ehKm/7V4W/Ad1qb16NHoNxYABgbF8G1kGi3uxvP/ITPZYzEpfqDlZc6SWlPIvdAH7bxT0Ya+xLc
	wHb9vKdddA==
X-Received: by 2002:a05:6000:2c7:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39973af9236mr1203009f8f.36.1742375244956;
        Wed, 19 Mar 2025 02:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD2b47NZYxg5uLG0ig+ZUAWSFTONEyHXxR8MWacA+06Zt020C+c8ArZXSlhSHTCWh815vtbw==
X-Received: by 2002:a05:6000:2c7:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39973af9236mr1202967f8f.36.1742375244436;
        Wed, 19 Mar 2025 02:07:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a12sm20348037f8f.75.2025.03.19.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:07:23 -0700 (PDT)
Date: Wed, 19 Mar 2025 05:07:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Joe Damato <jdamato@fastly.com>, Philo Lu <lulie@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devel@daynix.com
Subject: Re: [PATCH net-next 0/4] virtio_net: Fixes and improvements
Message-ID: <20250319050708-mutt-send-email-mst@kernel.org>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>

On Tue, Mar 18, 2025 at 06:56:50PM +0900, Akihiko Odaki wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
> 
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
> 
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


