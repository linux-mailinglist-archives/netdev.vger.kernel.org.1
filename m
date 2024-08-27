Return-Path: <netdev+bounces-122357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D5960CB0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B99281395
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1102D1C32F0;
	Tue, 27 Aug 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElwlkwBj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A919ADBE
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766955; cv=none; b=Q+S0eDEPHXqSCqW31/35DGnVgTreBMejJBDtFtamz8msi1bcoBbw9K8pi8QrmpLJYCydiUEAuGL6LG5HQ4yL939D8SRpDlQdPHOo/WAw+MjkKSYhhLe3QXScOh8do3v2DXkba3aBIeThF0yHpu64ofvxTzkzJXHQZDB4/Nb9QgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766955; c=relaxed/simple;
	bh=KCnPT2SDfFiZ0z4onLZh2+hje5aZ/T2i7RVeM82gfMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLFeYNb7E7UpLh3CrfSX1R8pu5Y4EJf5Yc8SA4mAIfTXP/fYYUyE6N+e/aib6P7oWtxv7+61J/lSkqCf4d6lJajTG6bxEa05tb5ve78lEtylgsY7uUZwm1ZA/ql5PGL60LdtW+ocbBxNfTwoq+RMFAOqXAz93+SYQVvlr9+UPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElwlkwBj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724766952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCnPT2SDfFiZ0z4onLZh2+hje5aZ/T2i7RVeM82gfMY=;
	b=ElwlkwBjOROeoesmQ/Kfchy/zTnFNvBPpCFji6/NA4fuy0ynKZqkySwJVQ55xttVJ6NEsa
	VJBbYS4k4gjfupoqzYryVTQyfJfn5RLA/v5yhZBMPvNev5V74Rk4R3iPd/mtQwEDyq3tCE
	DUPodjWuuUcrrVrUc38vsCcMt6E+n0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-yYTKSAqxN6OiYVt56g8Q5A-1; Tue, 27 Aug 2024 09:55:51 -0400
X-MC-Unique: yYTKSAqxN6OiYVt56g8Q5A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42ab8492cedso51879275e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 06:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724766950; x=1725371750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCnPT2SDfFiZ0z4onLZh2+hje5aZ/T2i7RVeM82gfMY=;
        b=GkbZu9nNZC6aKQE7YiVth1RF5F3hqdWJkRmIbpKQF56Opv9OUZuCujpaK5w2pOLLy3
         7+gA1YqsJ0Ga51FGu6QtE4ZmQsnrS17aXlkt7MwTQwHRQKaZrO/U74aF0pq9wl/Ag2e0
         Ca3JWOYqLMLPeV4zlT/ht0LVmuwONNwjFmcnHVrVHXQ8ndO052GBXFoo8gB0Rj06nFLD
         u0bFjgxGsj6KKnJhFRho3N1ysEWHwFqyLjXy2Ec0xN4FZvHX5hlNx0znD4OADXpnv6oO
         H3EgnW6HFwl8OAwqUdHBRzCSSwAHpQv3hrHLss+6anyF1Eolk1B/7cV38WP3vTgQ0tMe
         HdJA==
X-Gm-Message-State: AOJu0YxHb8cGoshYMOdTJ7J0xxy31U0NzDzas3cUfwd1gzg86fzDytVN
	xelS0+sZjrqrIYmWdzxDWhRnPY7DgGBZvU2Ox0Ses3xnevsgAPpPdgt/+m0Iald1vnO0bavBPoP
	fuAhu2GAF70UBOpQMMN4ihuWnzxTQ+ub+NDtBX4Q0xGPH7Ot7DdEZfA==
X-Received: by 2002:a05:600c:3d8e:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42b9adaa3d6mr21711025e9.5.1724766949826;
        Tue, 27 Aug 2024 06:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSAlYi7wUp9WGZSlYdHo2N7jKv0stogLqm3BN4R+RSTMfBAeOmqXMLDiKXD/L9wpodIFaT/g==
X-Received: by 2002:a05:600c:3d8e:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42b9adaa3d6mr21710645e9.5.1724766949163;
        Tue, 27 Aug 2024 06:55:49 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm185624515e9.24.2024.08.27.06.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:55:48 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:55:46 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] ipv4: Unmask upper DSCP bits in
 RTM_GETROUTE output route lookup
Message-ID: <Zs3a4rBpWrfeP7Tc@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-2-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:02PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when looking up an output route via the
> RTM_GETROUTE netlink message so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


