Return-Path: <netdev+bounces-128725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2EA97B2BB
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 18:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051D81F21953
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90146168491;
	Tue, 17 Sep 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7EiURbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F0142621;
	Tue, 17 Sep 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589695; cv=none; b=VrSvPZ89lnv5REpsraoLInhiPdWajndb7iSm5yMtokXKd3Hh2SjGyCfVSUnHk2Ssp3vfltJ1/3o7oxIXMBsRZ7EHZCb3NJXUHtQ9/1mkBZUB+RhFUuq82o1wVwehbrWhB31A0RM53EgJbi4xQxxjD3yCcs42vKNa9VqMnFcwApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589695; c=relaxed/simple;
	bh=+u2RJleW7OosPIezCRO5B0gsnBqFgz+H5aixrVCNud4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7URslX5IJCbDGQ5e8rJC0oCsXvwvUWBmq1gY62ezWhqBJWbxHknQfPk8pbb5j5io8h4dYH4p0ewJbC3pCFxfIgrGt4/0ul8ECWLAsl8cRNy4qrGD1mr6rljtMZoHDzR40U6yRDtZaGTi32bNp88UcV52RTXe+aaI67j1cOct8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7EiURbz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206e614953aso58846465ad.1;
        Tue, 17 Sep 2024 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726589693; x=1727194493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wo0qb/nMmiuLtTdnX5Rf3I7jGGV05/OqWpK1YrlbbxY=;
        b=Q7EiURbz0JU4o8fb+MRbHgBRIfzAwbXizS0/8AYqoc9OPDhtC4iOvVREuPn0MbBV3H
         OZoO51H1IboYIGN3E3xtzTna+nSPJJGr8EDPMzNXEszx2ol9GeC8awsAX2gWcezQPaTo
         pgStyoye5rkghKfZ5i5ufpDTbMx6NRN5R60zsoxghcKAfcVpQ0p1xJCNBwCjwmHiR0TW
         uG3EwqNNthEtFqr3a5avpNbh3PNng9sCBR4qgyZHOp4pOOPecNxwMIQxd0RPzQQHq/DR
         ZAKuN90gaKWZsjyRIN7adA2lVwW5LzaUdQS6D3WknqmBS45KDJ+ho4OEY1Z7SyJK0nXx
         c3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726589693; x=1727194493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo0qb/nMmiuLtTdnX5Rf3I7jGGV05/OqWpK1YrlbbxY=;
        b=QoyQ18ZtMoiEG48rFJTWogyq4P4Qx5nKU5TCsT7pb7ZzxVfSFcpSY5pu7TXvJDnpB2
         TkoZLt/cg8QfFEsr6awsW8ywZbVEvMqhcSpCygZzHCS5k2mw80UZ75Ybq3U4gPBn2yOa
         AOoQ4L6I4pziDHLr82nMkwy4Aqj6ic6wiiEs69bXXdqBY/7xh0T0a9cdzruI3F66QBsw
         2om18jE3wmiyFF7GUOCXaqXD7JsSW/gEwR4P/CpU+jq42Dsa9HqjnfgAb9YEEei8EmX2
         YxUoq4PDmqIKWb4IBThYNI/UieYzP3i7e04kcePr2kcSkIFxX/f15+zoSKxvpr/96fyJ
         Oe2A==
X-Forwarded-Encrypted: i=1; AJvYcCUkKfx8t+ysE/GE6G8hoR8GDfT+Qu4Atp2KrL8kgqoXhNWE0KzsaxIUr1MISfEn9D8ikuUuGypCa6DozQs=@vger.kernel.org, AJvYcCVbIvTEiSq2219jgddIdjlK8wP3/zYvEAtoOOUfb0OryMKeWIHGOH12ubx5IyrvleDbmzGls/SJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXi+8YpehWJifWDQ4P1oC/d+aGDupg+25oeRewBNYe1eL1bTv
	SAXcCyyoIIeNLHoMbInP9voGGTli6sBXqACouB12IQ8es9agQgs=
X-Google-Smtp-Source: AGHT+IGoQX3Bw1vVKlCgZNNh843NpLvAVYG/428YjYeyjrq289lY+FxTU4k8bBiwudl5/WX/n5vgGQ==
X-Received: by 2002:a17:903:1cd:b0:207:20e3:c693 with SMTP id d9443c01a7336-2076e4129efmr269372655ad.43.1726589693262;
        Tue, 17 Sep 2024 09:14:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d291csm51999745ad.143.2024.09.17.09.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:14:52 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:14:52 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Zach Walton <me@zach.us>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: Allow ioctl TUNSETIFF without CAP_NET_ADMIN via seccomp?
Message-ID: <Zumq_CxJZ9hWuJIk@mini-arch>
References: <CABQG4PHGcZggTbDytM4Qq_zk2r3GPGAXEKPiFf9htjFpp+ouKg@mail.gmail.com>
 <66e9419c6c8f9_2561f32947d@willemb.c.googlers.com.notmuch>
 <CABQG4PF+xeeAckkop5oas0zjE4aKM1Y=fSLRAHt5WiZOhJMGtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABQG4PF+xeeAckkop5oas0zjE4aKM1Y=fSLRAHt5WiZOhJMGtA@mail.gmail.com>

On 09/17, Zach Walton wrote:
> Thanks, I think this might have been a misunderstanding on my part;
> seccomp is meant to restrict, not expand, permissions. I spent some
> time looking for prior art and see nothing like it.
> 
> I will look into alternatives like AppArmor/eBPF. Appreciate the response.

There is a bit of "expand capabilities" prior art in the bind cgroup hooks:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/include/linux/bpf.h#n2075

The BPF program can return special value to ask kernel to not apply
CAP_NET_BIND_SERVICE. But this eBPF hook, not a seccomp..

