Return-Path: <netdev+bounces-251402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B925FD3C365
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8959B5068B0
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119043D1CAD;
	Tue, 20 Jan 2026 09:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA823D1CAF
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900635; cv=none; b=hYUUHvKiG1UTHPiFghHS61JlRUqD1AMpDB23bWdLGw38NP+WPDRrTXTHWOuDnzB0TppKQpxw+kNE5QfW+BJ+qC8koek+vjEkZU2s9raPlNsQ6PfUEyCyR6Nh5wFAWUD+jedOjx5xRhZ/ASDiDD5r4wxTr1o61F0IP0JwZc5bfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900635; c=relaxed/simple;
	bh=/TUOBC0WYfd/Xrf1Aif9NdWpL6jDj72FVGtHUkudOr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMfWiLJnu4U/KZmWTrlt3BSG20L5jyXXxvz+CRJdLWNg1Op/wnobdFeQztg+bhndxBkpjrPTVWZzaXWqnZYrsdjAHRX7wYa3REvmT5bfixxJAUl3o/y2swE/IokuidnNZAY7fb5MTRoYA1/gYf/TCyDRjkyjLLe/nOhabkcdXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfd0f2ab32so3660167a34.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900633; x=1769505433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcwOoX1hGZl+EMxknP6NmBWll+17b+9EN1tr1+RrdwM=;
        b=gS2SpOAaH/rgK7Z6DNkPh90JOl6bex89NUuOypLbeyJSSRpHuI1e8PZRJufLiSSJUx
         QqpkvhNhYtsuv2wro1eLNt+IKWDrvlIOQIbmKt/3eKcNiFyx7BxbBQv1F99JneyAojoR
         Sohv+a9FyYBZQPvIAA6FyjZWzrGR0u+cna1/oUfyxXsvtJ6VEpxlJ6/Cl+T2E5AY0+IY
         4dXEtQpb0+RHQWJYMvx87C1InkOi44uD2HndGShcGRF23OsSkcgnDe26latt+UnUhXJz
         99VuItP1L1l2s/JNdyUF0vvjFYLq7wM5ILp6vIaifCuCfCk9f6hGXIEj76HsVNiSYBvC
         J+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXIC1srNAw1dfDxHHyNch6GjZzuj7JN4JVXAk5FC1OSdzmUpO8BtF93vfgkko34PZGSTrpZ1RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRARfxP8Y/3PxZfv0ZiSIBY4MYogfSmr66xvlMd44+0hvKeOW
	5CUjdgE9sjhPuMIsqPpg6DslF1ncHCXVkCrVw9ag1hx58XefraDWTsq9SDTqhg==
X-Gm-Gg: AY/fxX5DtcMd4T/WQdr5JuwpBN1QYVTwgvHUzbdMRZ23REBDJ4wOXp1wvo9zsAEiaMO
	8pAEeAdO18X+KW1ks3nh3PcILYoksPhMCRM8ldzqTmNUfAi0h07FeyGFtjVjxE+76snM+zKrt2M
	BiIV7RqdGr4I6f/IefFYkvTTeAdS5Sskbe//FLObZKqalGVCvb/R1slw+T9doKc2aIEMB+DZJN1
	dQLkthWcUCzcewpyKx7N5yxT96kVw8UkhLdsrF6KKmhibaKE20UMN5cy6KJB/F0JRTLcAKEA4G5
	P4GcFSGGUWXCwsuFv9ckareT7NQBzw0uKe2pym5KjRwZ2UwXUE8hFaN2VkpP841gYK+YJ3aCUIg
	rVoGOV8MmM3goCXuzgxq6Rjt/oP1dctJzH+y+vY9MqBw3tWDBL9cO4q0mcAW0F90OjWlSCtmXE1
	X0NMCWO1eD4i9T
X-Received: by 2002:a05:6830:6a92:b0:7cf:d1b7:40b6 with SMTP id 46e09a7af769-7cfded69860mr8534579a34.11.1768900632978;
        Tue, 20 Jan 2026 01:17:12 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0d9142sm8157393a34.1.2026.01.20.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:17:12 -0800 (PST)
Date: Tue, 20 Jan 2026 01:17:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, osandov@osandov.com, 
	mpdesouza@suse.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
	jv@jvosburgh.net, kernel-team@meta.com, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <aW9H3o5hFDmJFKsH@gmail.com>
References: <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
 <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
 <aWpekVlhRpD4CaDI@pathway.suse.cz>
 <aWpfDKd64DLX32Hl@pathway.suse.cz>
 <6tryrckp7mah2qghxu5fktrwexoik6anplubfvybushtcgocq5@kg6ln44istyk>
 <aW446yxd-FQ1JJ9Q@pathway.suse.cz>
 <bvmrtic6pr52cxwf6mis526zz4sbxstxjd2wiqkd2emueatv33@eccynoxgjgo2>
 <aW9D5M0o9_8hdVvt@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9D5M0o9_8hdVvt@pathway.suse.cz>

On Tue, Jan 20, 2026 at 09:59:16AM +0100, Petr Mladek wrote:
> On Mon 2026-01-19 08:34:42, Breno Leitao wrote:
> > Back o this current patch, I've tested it internally and run a test for
> > hours without any current issue in terms of task->comm/cpu. 
> > How would you prefer to proceed to get the patch in?
> 
> Is the netconsole part ready for mainline?
> 
> If yes, I would suggest to send the full patchset for review and
> it might go in via the networking tree.

Yes, it is. I will focus on it today, then!

Thanks
--breno

