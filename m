Return-Path: <netdev+bounces-160350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B8A195C0
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043A53ACCF9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81E213E99;
	Wed, 22 Jan 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw41mbnK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FA214229
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560882; cv=none; b=LSznim5M1g2E9T1Ud+2/o9/d2rp+Jqz4499fzFufP5pozXrpvpYImZGbCB8hpOFalqcWiJPrq3IPocc+e+rCY1YirrgmfHs42lv3cFf+Jxr5pRtjVb8xvnQ9Th+rvDU9BcmmOioV6VRVF+ky3eDkZLagE5Fk7Uyn3dKS5gBKCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560882; c=relaxed/simple;
	bh=csYjS7ZMqdBVxVU4jkfW6KvCGGCL+cpAwuWtusozMNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IN5l/d3tdSnATIE0SV1TOYYKI2WF40ThV84GSY51jYhpk42At1buYhnid3QXsoa4PK7BVTi4kfbL5KED48KquLWToin0jxf38nsLREfvacDgheOP5pn0EU0hCk+IuvKiqkWAoRVgMFyoN6hg+yQl6sT8MY8AVwnaEsLQYPlz/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sw41mbnK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737560879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wfREgroYFiqgBlx5WjHx+t0bN9d9Z+FguVVAzVnbrWs=;
	b=Sw41mbnKPwUKuSnBp4Nh4XDzD17nZVCPc8MdqnGfvx9GBW8srO/X+9sYM9uhzLfw+/7ZUL
	ssGZk1Vo90WVsG1h+Y2x6Kdd+BrGxw4hqJBBKw/kcLNjFlGlULxIFVl/f6gpS7OQXcHU8q
	39tgyR+3Z3A/euoJ9MIXkkg8XwFqSTQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-A_FRMahfNe6gYm4vLxbYZA-1; Wed, 22 Jan 2025 10:47:58 -0500
X-MC-Unique: A_FRMahfNe6gYm4vLxbYZA-1
X-Mimecast-MFC-AGG-ID: A_FRMahfNe6gYm4vLxbYZA
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e5505f613e5so2608024276.0
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 07:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737560877; x=1738165677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfREgroYFiqgBlx5WjHx+t0bN9d9Z+FguVVAzVnbrWs=;
        b=wdOPQQBJpLvXtXEiKaF91IKYU+H4TFDWIu2EZVLnk7bjsOuFgHXHTgO+JKPTjIPhBP
         d4we5AooKEKuQRRDkWkiv8y7U4BlMkzBFuziKff7NTKAbP9wUMw3N65EkZXTmE2V5kkj
         q2SeoySSisLn4PoPWkkGvZNHsffEyrwVIrFuegYVM5cm2KRKNaXp+07aRmrU9zrUBrkE
         4aTJ/ZphKEtB6SGay3kBH6XJDVet3Jmbdam8mh2KLAiNFj/odRh9RMIg7DdGas5LkT7K
         GbSQOK3Zrz7sTJp4ZAD4JCesbWVE/Ho75ABlUjGT4tOqiMyMwJpKmq5/8eugMvhzgfgF
         4iKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fAMCyz2zIYuQrei6TdKx2zEIUCP80xsBR13StpUcZecuczUh7hz4C6BJs4jI2Owv92tuQh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHKH1dzdRlLyCR8EAq0eB8X5Lexk3Hdc3qBEPg6H4NN43kwGf
	bxP9fBnawIvimFDZe6VSVZi4WoeYNI6eHToQHTzsYU1mgvL9cj8Ne55+12EABa8CDGC9dTDgTFa
	6rToHycqoJ4CQxtT1Rdm8zaOUrnJZYxc0Y98esm6rFQSbbaPCGQ/D8vRalfgCS/d79zLsezfLby
	bUMQ1bgxbLW89c33ysSPj3kj4Om5BH
X-Gm-Gg: ASbGnct1iEG87wln8vWlHyK8OpHmA1Mv5hmUs/knBisVjeHkKXLh7lHDgfHIoqwmDaZ
	D0GiHpsNbir9i2GbONognY5KMnm+kZFvcvDKEVaMtqSW3hOIH+Ms=
X-Received: by 2002:a05:690c:63c6:b0:6e2:41fa:9d4 with SMTP id 00721157ae682-6f6eb8cd478mr164157747b3.15.1737560877651;
        Wed, 22 Jan 2025 07:47:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAOBCR5TGf9x8ZiWSsUS6YD++VFJRUTH5QwT9T0pBsUkzJT4bWtUYNUi1dDSrRGo9JczAcRZrI7XLzY6nu3tw=
X-Received: by 2002:a05:690c:63c6:b0:6e2:41fa:9d4 with SMTP id
 00721157ae682-6f6eb8cd478mr164157587b3.15.1737560877318; Wed, 22 Jan 2025
 07:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <kxipc432xhur74ygdjw3ybcmg7amg6mnt2k4op3d4cb5d3com6@jsv3jzic5nrw> <282fbb3c-97d6-4835-86d3-97eb14ff74ea@rbox.co>
In-Reply-To: <282fbb3c-97d6-4835-86d3-97eb14ff74ea@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 22 Jan 2025 16:47:46 +0100
X-Gm-Features: AWEUYZkKHoHkSMSlHnQ7CeTOXpAnKRIAPqHCtH77lsugcC0XTyWPmBXnE4lXMDE
Message-ID: <CAGxU2F5zhfWymY8u0hrKksW8PumXAYz-9_qRmW==92oAx1BX3g@mail.gmail.com>
Subject: Re: [PATCH net v2 0/6] vsock: Transport reassignment and error
 handling issues
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jan 2025 at 15:16, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 1/22/25 12:45, Stefano Garzarella wrote:
> > On Tue, Jan 21, 2025 at 03:44:01PM +0100, Michal Luczaj wrote:
> >> Series deals with two issues:
> >> - socket reference count imbalance due to an unforgiving transport release
> >>  (triggered by transport reassignment);
> >> - unintentional API feature, a failing connect() making the socket
> >>  impossible to use for any subsequent connect() attempts.
> >>
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >> Changes in v2:
> >> - Introduce vsock_connect_fd(), simplify the tests, stick to SOCK_STREAM,
> >>  collect Reviewed-by (Stefano)
> >> - Link to v1: https://lore.kernel.org/r/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co
> >
> > Thanks for sorting out my comments, I've reviewed it all and got it
> > running, it seems to be going well!
>
> Great! I was worried that I might have oversimplified the UAF selftest
> (won't trigger the splat if second transport == NULL), so please let me
> know if it starts acting strangely (quietly passes the test on an unpatched
> system), and for what combination of enabled transports.

Yeah, I was worrying the same and thinking if it's better to add more
connect also with LOOPBACK and a CID > 2 to be sure we test all the
scenarios, but we can do later, for now let's have this series merged
to fix the real issue.

I tested without the fixes (first 2 patches) and I can see the
use-after-free reports only on the "host" where I have both loopback
and H2G loaded, but this should be fine.

Thanks for your work!
Stefano


