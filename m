Return-Path: <netdev+bounces-175935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A6BA68076
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ECE3B2F95
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85401207E02;
	Tue, 18 Mar 2025 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TTAOBaRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4EF18C03A
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339272; cv=none; b=FWb8jw9XFkZlDfjEhFhGOCWjJTxYZ7tOrTxEnOmeJNN+fNVAEBf6iNR0xwk9NaP2t4xpmPZOhNfIfL9gBV2Gt5UUue0DbbwQkTDkwfqk6O6l95POM+1dKQu4bhqruZEHh3pnOCME5NzUT3gqXb2GSJvg+KzG6npM3I+ZMiKA/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339272; c=relaxed/simple;
	bh=q7ryEWx94sGFK9j4bbYaRkOisLAZ1YYAgqwn4dwvZj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukFbvPb5mR6y8orkDDqAj7jfjDsja0Htk7IrCmLvvvUNbJsVyIBQDOYEOc87eNWdhB4hxFZAFjMZXgFAZ4lQ4fGYUXwkq7LLYbJn9HjlawU3E9QL+ewu0LVCXMz9OTuUIOnz0QOeu5W5ffEwNK+C7o2hnZHTLkyrTke35QX9ZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TTAOBaRU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so252777a91.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742339270; x=1742944070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LryqtCOl1kW/qjkSVK7YUBP0UtxICvr9+FISp7QIe74=;
        b=TTAOBaRU4Irr73SZvbdS46OZpgYrEcSQ60+Bh/fA4KgzspKQFwzt8eiXhZ+6zFn8fV
         V0bMhcRbhVatJsEMIcftXRpDfx6dwrSUywjEydXHXT8bQbyJqzxHTh+zuykg8RR2tdvP
         pbY0N/3St7AXbZ5wv9hHD7z4+13WtxzUDP+ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339270; x=1742944070;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LryqtCOl1kW/qjkSVK7YUBP0UtxICvr9+FISp7QIe74=;
        b=CGjAYmgScEfT4+lVTvDjxtcr//hwp/TegoDeE8jPD9yt8Wb4MvxLjrKABGnyRYrlEq
         qyOz099EzQqqHnNIygotHVfTKqULwpi1p8F1iATrR/riOA4vv7H8QOdO6ZVFUPDfJ9o0
         cJbeEgJ+jVLhK5OlDoDbfpsXwaDtobTHQFPDP4reV/ccbWWsWzijIMRinM7d4LKhmHLY
         1aoP7M59Eu2k0auFhJcZ4h4FQ54MfaL17im/jF2njgIZlZE2ta8NFDq+aey4hJdefHJ8
         Ln0oCZCxp8/E/MFYuC0upo7VaGK+xaPqF99NuhSLn3AAeL40CaH2fAL1EvV1M56D1PK1
         /GsA==
X-Forwarded-Encrypted: i=1; AJvYcCUlke7oFyjRQsC0KV4D4mIcRyy1YNCNIxVwuhKPzP1mZsZLv0rCvsrehU5BPtQVbw1yxm/YEp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIj3VYz4dfWAY73puoDKat6HuBfR1lfiUWcFi9P3IMI8J8I6C
	/1Yi3uI4rnjZnMJRb+iNjKQiPkvHLNkAyzaVbxCgvrrnVs0oqaXUjw3VFI4mphM=
X-Gm-Gg: ASbGnctO5BBJVeSCPOtRaZJf2eTcXulkcL7UDStlLYv67KSK2jmIuSsd+D+G+HCZZsa
	wXGdYvTe9wa2aO2GjfGHTOusnTr5sZB3jcMij2/OMmo38GpBXecpVJumVs3JhCsGK8encqok6a/
	Xf05cpg4upC+mQA3galIp2/FIqZr+0ahGYZmaJJu3DnPb/3Ud0in0Oef8dZToY5IUqQRn6kG6/v
	L2AHAB9aWTxy/HvYBSJqfCpbXDt8OloYC7mXk6Id0yvSFaT3QYb4HNzvy3hzf37uTQQPZZ+OEtl
	vj7i1/pL2Bcej/9LVN6PVDtRA6V0OYVgKPul/PQY1myiNJhQWxjY7Ve/96fNLHQqBAHGnIULwMK
	EhMJ15xg8laMIw2ik3mV3HT2yEsI=
X-Google-Smtp-Source: AGHT+IFnviLx/vP38B/hCrcK1kFuSsgcpEy/4bCGNVluUVWJ03VuUZ5QDI952bqfcFDYVkbjIejZfA==
X-Received: by 2002:a17:90a:d445:b0:2fa:562c:c1cf with SMTP id 98e67ed59e1d1-301a5b04431mr7113218a91.1.1742339270209;
        Tue, 18 Mar 2025 16:07:50 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba712asm99983285ad.131.2025.03.18.16.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:07:49 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:07:47 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 1/4] af_unix: Sort headers.
Message-ID: <Z9n8w-6nXiBUI20T@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250318034934.86708-1-kuniyu@amazon.com>
 <20250318034934.86708-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318034934.86708-2-kuniyu@amazon.com>

On Mon, Mar 17, 2025 at 08:48:48PM -0700, Kuniyuki Iwashima wrote:
> This is a prep patch to make the following changes cleaner.
> 
> No functional change intended.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h      |  4 +--
>  net/unix/af_unix.c         | 62 +++++++++++++++++++-------------------
>  net/unix/diag.c            | 15 ++++-----
>  net/unix/garbage.c         | 17 +++++------
>  net/unix/sysctl_net_unix.c |  1 -
>  net/unix/unix_bpf.c        |  4 +--
>  6 files changed, 51 insertions(+), 52 deletions(-)

[...]

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 7f8f3859cdb3..1ff0ac99f3f3 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c

[...]

> +#include <linux/in.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mount.h>
> +#include <linux/namei.h>
> +#include <linux/net.h>
> +#include <linux/netdevice.h>
>  #include <linux/poll.h>
> +#include <linux/proc_fs.h>
>  #include <linux/rtnetlink.h>
> -#include <linux/mount.h>
> -#include <net/checksum.h>
> +#include <linux/sched/signal.h>

Not sure what the sorting rules are, but I was wondering if maybe
"linux/sched/*.h" should come after linux/*.h and not sorted within
linux/s*.h ?

>  #include <linux/security.h>
> +#include <linux/seq_file.h>
> +#include <linux/signal.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/socket.h>
> +#include <linux/sockios.h>

