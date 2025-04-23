Return-Path: <netdev+bounces-185058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E747A986A5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590E1189BA9D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E422F773;
	Wed, 23 Apr 2025 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6GMN43t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78651EB198
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402512; cv=none; b=mL/uDhWs8P+cMxeWtdNwmwLv71+YsKIqCrhT+0hRtthBSM9OLvK+DwTOfDAgeNnRMo/MB/au/xohlGAnbe/rT/pmlmHnemLbOioYarFOCZsk+/2q8KAt1YeuZi7+RQZ0XZiRQOhewzCxW3gRJAa7CmW37Aiv8CDceeQUDOElIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402512; c=relaxed/simple;
	bh=nv8JLHYDC2xOcut+2tS9pdLAbaCM0agWONcGBv7sls4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ujlipvo+D2PXl9LIkgQ6/kywZZgxYH9A4QUCSKamkr/FDNHNzFWHEwjW3sQJZ91IZgVne9ybi+CS1MTnqhE/CvUIP3H/NuxDJvJuFM4UvWeh04MXSMyNGJdnJa9yEAJ/4GhiSGXcfw2ElNFYk4rxtAlMPbcf4aRzhJzr1sRbDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6GMN43t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745402509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEa4Jm6UzeVd+a2A5Ueja4N+wKFxUkh/wMN5U9m9PM4=;
	b=P6GMN43tmPBfLw/PcU6yFajZKhvtVP43FjGCCEYs/G4Kpkt2cqlT/qu3QotoW6eK5IvyqW
	fnPJOJLEtMZXcrsjpN39yZuYwxilIU4qmM61G5m3aDK2M1rbn8upsck7OXpg/aRrkW0ICk
	JKCGlsXfaCSvdcNWWk6yTOzpbCknyJ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-KuCNJN3lOeyf1Y25qgGD_g-1; Wed, 23 Apr 2025 06:01:48 -0400
X-MC-Unique: KuCNJN3lOeyf1Y25qgGD_g-1
X-Mimecast-MFC-AGG-ID: KuCNJN3lOeyf1Y25qgGD_g_1745402507
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39979ad285bso2768589f8f.2
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 03:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402507; x=1746007307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEa4Jm6UzeVd+a2A5Ueja4N+wKFxUkh/wMN5U9m9PM4=;
        b=Lq+eMVLz8GdmelPlU43RyUlBHf4yKzs0x9w+cPLVh4xLjyRI4EA8c+qILCXeJaczba
         IjA/3NQCpIKtTly4zH3gEx414sO/l6mbggspx6fS89VNEmbQNNywvQJ6Iu15PlDoPBP1
         cXul+EWEeqvtmqSvqNV+DVQFswjYFEMa7WA4B1PpcQ6Y13ddRG9GD5KhxXRdESvKSVAO
         Gf4bKZGsjDq3uZGhpYW+il+nGREr558IRKHlsxfpPw9cpby9Cd8H9xbU4Nos99AIAwQ6
         sJzPzaA5OCLcMOiwEGfSOwuK5WtQN2hbmnKJnn1062YQCrfEOD2m/07VAN0bz1vT5QTW
         PV6w==
X-Gm-Message-State: AOJu0YzA5didHJ0sDnh63ZQhwWIxv586C9aMgGgp/l1pwXB7OLeHnUeb
	kALx7skiizYa+3UYlbuUL4awzOmf8+RWnNBY3nFNT5i4sVApUvdUtpRpOfHLm0UwfScK9gp6oUX
	8s5E1xNzqiJQH51xenZ6OrkXDz8mNrBot8x3+Qu0OsW2shfvDUxZ7Eg==
X-Gm-Gg: ASbGncshxgCBdat2dt8OPMhlZwHIwJ0X676YsZl9NlZdLc8JnYpsrjKQCMepjs85rKE
	EUiLX/7HYC4L0C6AiwAclMwCzoaXyK6pH+r2Gm5lgI6fLgdy6e8H8zu2eJXymiADtuq/e3PH7pL
	NA/jp0X9rO3mAGfMM0EQpmZJ1wb9fmGpucNbPQu7b8Kb7Jhbqi+jo5z9EdVljdjbnYFOmcvl4ms
	57o1S2PBRAzpN8eu0BNqoeG31Bm+pjhf4jjMlsNhIqRmN67eIQTIMlrRrUKJYw8WpUzhCtTZUVa
	kHD0Ew==
X-Received: by 2002:a5d:5f8a:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39efba2c924mr14032493f8f.1.1745402506825;
        Wed, 23 Apr 2025 03:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4G2U9kgv92X9sS4XHICgmED1HPmyDoyHHpcKYM/4QdqRwsN2Bs7wLbrqwJzV+WWUid8F8Ig==
X-Received: by 2002:a5d:5f8a:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39efba2c924mr14032460f8f.1.1745402506426;
        Wed, 23 Apr 2025 03:01:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4235dasm17963014f8f.9.2025.04.23.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 03:01:45 -0700 (PDT)
Date: Wed, 23 Apr 2025 06:01:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David George <dgeorgester@gmail.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com
Subject: Re: Supporting out of tree custom vhost target modules
Message-ID: <20250423060040-mutt-send-email-mst@kernel.org>
References: <CA+Lg+WFYqXdNUJ2ZQ0=TY58T+Pyay4ONT=8z3LASQXSqN3A0VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Lg+WFYqXdNUJ2ZQ0=TY58T+Pyay4ONT=8z3LASQXSqN3A0VA@mail.gmail.com>

On Wed, Apr 23, 2025 at 11:47:49AM +0200, David George wrote:
> Hello all
> 
> I am in the process of writing an out of tree kernel module that does a very
> similar job to vhost_net.  The problem is that plain tap devices aren't quite
> going to cover what I want to do (1:N device mapping and various exotic
> offloads).
> 
> The approach I am taking at the moment is to tweak vhost/net.c to suit my needs
> and operate it as an out of tree module. The problem with this approach is the
> "vhost.h" is not in include/ so won't be usable without the whole source tree
> to compile against.
> 
> Is promoting vhost.h from drivers/vhost to include/xyz/ something that could be
> considered?
> 
> Alternatively, what I want to do could perhaps be done through an API to
> register a custom socket associated with a custom misc dev within vhost_net,
> but that is a lot more invasive.
> 
> Thanks,
> David George

See no good reason for that, that header is there so modules outside
of vhost don't use it by mistake.


