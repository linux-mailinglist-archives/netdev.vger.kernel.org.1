Return-Path: <netdev+bounces-179707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F2A7E3FD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB073B4634
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46101FC0FB;
	Mon,  7 Apr 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/cIxNx7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC51FC0FC
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038748; cv=none; b=RkruvwRJCX3HlSA3frStHoB8nK30+CqtA8TL/xysJd5BaVHEzAT/9oDqUvCjnjDJ1FWzECCnDjny98bbBzysfL/VkzAlYn4oppxVlUMoU6GvlR+clhqMZNgXn632SbhJlvGBOU8Pdid+IaZMUSgEt1CvlMZPhQErIDWvfIbHHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038748; c=relaxed/simple;
	bh=b1gI8E1E28WQecVQKN5b+DO4ZIEbl/2FOkLqdJv9i5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAeUYgTSTJbWuC5AV21TdddB8ZO8wfMasnZaPNBE43TIxmXvA7ClVMGwZtv2AibqGT40Jru/Qih+1QKbVuNU6siuxkQr0Q1Edg83bT5G5iQmvkB6j4/eQY9YplKI0dC3JqS9pJWq/IDvhdaRkYIfvuTuTJG8/PrAqtw7+8V/ksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/cIxNx7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744038746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HTubAnjzZxExTxDbZU0avjG6k42VOFqyditg+d66wE=;
	b=Y/cIxNx7cy1naF00w2/U2Sz81cpjA7AxmViQMvdkkLO1PUvYBt6MGd6QhKT3G3fejDSVSs
	9UAgvDz9rKugJ8HYSE6UUGV7+vRlyE+xTmXNgRSncITyBVpWi/j5K65MNyBBNgSKxnds9v
	zU6c2bbd4u/TxwbMsOm8KLaYeBRzh7E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-6H0iXdZqOIS5BXDRzZ0UoA-1; Mon, 07 Apr 2025 11:12:24 -0400
X-MC-Unique: 6H0iXdZqOIS5BXDRzZ0UoA-1
X-Mimecast-MFC-AGG-ID: 6H0iXdZqOIS5BXDRzZ0UoA_1744038743
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so34918965e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 08:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744038743; x=1744643543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HTubAnjzZxExTxDbZU0avjG6k42VOFqyditg+d66wE=;
        b=nyd0puwZHlLEZJ4+TatJFzAqORxQq7JjAZfhJGcstVxQGqNK4c4AsaWZWTBt0b7a4d
         OzL9lGs5opuSnERiznPSSMdKJm4GNZSyIIVXmXpKpj+TjTCKS7UA1Kevv/8NOK9BCARe
         xfsQoYJTmupKpyHBO6ap7SCAi7VO/DZf8d6vJGXWnCurhwzItr7e/VaeuzIafEsquGaU
         hXtpjXPKJO/5QLfxAbEIjOoNdLDe1oAfJV+NHLnHSsAWCNKFxr+wUoP4tt7wU94xBgw4
         FVllJrnXjyyvtlLetf3SVNILl8UKLN2VlA/pFgIVHhCgwBbMqOdVKSKUE6Nj4sefhorY
         1XfA==
X-Gm-Message-State: AOJu0YzeOJDuGQco/11wRCwPor25aTrLI8bXfttiynrnJapuu3OoLTzn
	ThioxVxLhl7G+OQVAPEKvab9X2IvYGBQ8+dUZNrYEVru3bVdXWdSoTNc5o/tD7JpE8tts1fro/0
	ZrnBiWrMleIz0oKVPANg5varrLxt21KokSJjC2qGfdpWNk2VC4KGKpA==
X-Gm-Gg: ASbGncvrUa2y7dXvnHRX670GAbhFEPyl07JJQUC2im258atURobOEn130gSTqA7K6+g
	zoldSJNw/cMzAEmvT7SBKP+hRQrXdZPOlK0WzDbEhxdZCjVkl29UUL7xrz+xcgW55ju3f1KVkHm
	hEPLqDzzEc91WqSNJHnRkVIjX7/I0SZwaYeOD6bhP1pspaOQ4HslGzllg4Tqq9hqUHneUbqJUFb
	V3NJ1aezOu1KFgnKtMhXopdr3aBtyucKSP8I2tuystZP7v6ciTP8yF/aQGJly8V9wHxuHABEXHQ
	DX8=
X-Received: by 2002:a05:600c:1e0f:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43ee0769282mr63616675e9.21.1744038743544;
        Mon, 07 Apr 2025 08:12:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL1DOU6EpsA9RKpIiNPzxLNRI5vP8GcgK4J8ZHpRKGFjwW3EJ3I7RtK906PF9dzkCSyLhiWA==
X-Received: by 2002:a05:600c:1e0f:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43ee0769282mr63616365e9.21.1744038743170;
        Mon, 07 Apr 2025 08:12:23 -0700 (PDT)
Received: from debian ([2001:4649:fcb8:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a7615sm132429945e9.9.2025.04.07.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:12:22 -0700 (PDT)
Date: Mon, 7 Apr 2025 17:12:19 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	stfomichev@gmail.com
Subject: Re: [PATCH net 0/2] ipv6: Multipath routing fixes
Message-ID: <Z/PrU2D8pZrJDn9b@debian>
References: <20250402114224.293392-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402114224.293392-1-idosch@nvidia.com>

On Wed, Apr 02, 2025 at 02:42:22PM +0300, Ido Schimmel wrote:
> This patchset contains two fixes for IPv6 multipath routing. See the
> commit messages for more details.

Thanks for fixing this Ido! I've sucessfully tested the patches
(although it's too late for a Tested-by tag).

> Ido Schimmel (2):
>   ipv6: Start path selection from the first nexthop
>   ipv6: Do not consider link down nexthops in path selection
> 
>  net/ipv6/route.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> -- 
> 2.49.0
> 


