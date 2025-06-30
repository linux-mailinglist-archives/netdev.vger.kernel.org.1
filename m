Return-Path: <netdev+bounces-202340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99972AED662
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EF27A601C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB4A23FC74;
	Mon, 30 Jun 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLjMxBM0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751A2367CB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270312; cv=none; b=B4Je0QWNKVYIRdLkQWCmLKW8OexoyX2ynd7DRMLbX/xEItUF49xNsflIO/9HX4Lzo/EuAZoN16S9Rv4E6oZatMR8WbRkKfFJ06H1julBtOiS8sxS708W1z9jNedlkiOLBzN3vyuWWqnPxzKPK8yRKMvO1N25XAQifZwQSLxGo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270312; c=relaxed/simple;
	bh=cIWLQj7tWvL2O1cLTwZUfAKHg4ehQSOPXhaj0k60wmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzYijA/Pbq35bcb7CMpFStrEd6VmUh4Nxl3VmOxN9oPjamAIhmpwGnKJt2Q6RtxQ7vuvLZ5Sll5kQOtsPxv9aYWZKGFys7/MM9hX4rXFgtYWoBg+Vayy18tG30pD3f6I32IKaxYK+yC46OJ7GxkeD1d6rllwTVNf7/1N/JxwSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLjMxBM0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751270309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEWcWVX6y9scJKOQscqFoJ6thnfYTOA+0wFODJOjNQ=;
	b=cLjMxBM0rFGILoY2+rK8cWxwx8JySK7vVNiGHLxjlLLag40jGC1xJEZDyGyeKYT7DN4iKA
	nSkfrAUsDWI9NWBWRe3DwZGfLnuOr8aMUn05DA/mU6BU9M61qpHc3twLHhSfb7GDWAjq0E
	iRTVdeDFAdKAv1oaMQ7QH7svV0OTo6E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-FLRs4X8GPFu27sTGnYTD_Q-1; Mon, 30 Jun 2025 03:58:21 -0400
X-MC-Unique: FLRs4X8GPFu27sTGnYTD_Q-1
X-Mimecast-MFC-AGG-ID: FLRs4X8GPFu27sTGnYTD_Q_1751270301
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-703d7a66d77so54359287b3.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270301; x=1751875101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgEWcWVX6y9scJKOQscqFoJ6thnfYTOA+0wFODJOjNQ=;
        b=GMZr4trkMSumc2Q1TvpeD3v+tRSUWMF1+FJRsK+vYiVyGi0j/T9OkZVwa+stVhFYAv
         2z1RgZufeKITNN4mWFDHP9d9dAnDMXI3pO7tU7i89hh2jBgImn5UHiUbhJytfkMpEyBK
         iWCO6KHDtXdFqxB4g0cQr4geXZ9G/WdSSOAhsSgwE03j96USvNccIht7DDSitbgZjnyS
         caPEcT37J1v7s1IsEZ+xligQdR525ieVk2ipUSkXDldbuSjBUh37/8/SVxaWzlwrkGoB
         5UM8BA27kW0aPb62WrBBkJK7ZyFGVBFG2aFgB2O+gvbDPpWwqyuSKhBlAbp5ghIKoWcQ
         /MeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWujJamoURG4XYoMdnDNBJU3FnXRGuoBOYBigs7pr+ZjBselVdihrttDeN3pL+/uSNLKtz/moo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjDDKn4HGUEUyfQ+zzK5vil+/LfJzEg6dIKXvTOjM3C9hJWKe
	yL0MzgctwwLTrel/44omjIK6eW9eER0C/pd3rQfXjjYfsQ3Tx70APIw+7W0FwSL2pSFOr5IMgNZ
	Fqg8z5LwRVNY9T9q1uJveL0HfcknSGIBXIRaRtLwvnKKAJ5npcDablOHkzW7mFRNxuP3ECkEgZB
	OM0j5Y/OXiTAGunVL9y8r+1sPUPtfcxO8y
X-Gm-Gg: ASbGnctKXpWb7KFNY77HcZc91AFYXFXCR4glNF0hTv5MUx+ij5o1LeBUeCCAWRXg/m1
	2uvjaHP0lgLJVsxNZJKzXd6m0n8MLlC743SDTIfWXZrSY8pHbRg/nJbDKp+2H2W7r3Keqqseuu1
	dufkSOEA==
X-Received: by 2002:a05:690c:388:b0:712:d7dd:e25a with SMTP id 00721157ae682-7151756eb18mr172064627b3.6.1751270300727;
        Mon, 30 Jun 2025 00:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9hk4iM8gEid0K715PQkHr7wTuzImJqjNS2fyvGLxyh0PAObiNySZ92qlNHU9LEDZn5W6cNeMfqE7U/ldpN9U=
X-Received: by 2002:a05:690c:388:b0:712:d7dd:e25a with SMTP id
 00721157ae682-7151756eb18mr172064347b3.6.1751270300278; Mon, 30 Jun 2025
 00:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gv5ovr6b4jsesqkrojp7xqd6ihgnxdycmohydbndligdjfrotz@bdauudix7zoq> <20250630075411.209928-1-niuxuewei.nxw@antgroup.com>
In-Reply-To: <20250630075411.209928-1-niuxuewei.nxw@antgroup.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 30 Jun 2025 09:58:07 +0200
X-Gm-Features: Ac12FXzM2abZAiLuWcV3HSuStmkPiQEYR_Hk5CCqlcO4nWGeNMcgQRF0jjd6Ui4
Message-ID: <CAGxU2F41qFrcTJdk3YeQMTwd0CP8nCqTCPpOn3ezQv=tPVx_WA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] vsock: Introduce SIOCINQ ioctl support
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, decui@microsoft.com, fupan.lfp@antgroup.com, 
	jasowang@redhat.com, kvm@vger.kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 09:54, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>
> > On Mon, Jun 30, 2025 at 03:38:24PM +0800, Xuewei Niu wrote:
> > >Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
> > >bytes.
> >
> > I think something went wrong with this version of the series, because I
> > don't see the patch introducing support for SIOCINQ ioctl in af_vsock.c,
> > or did I miss something?
>
> Oh yes. Since adding a patch for hyper-v, I forgot to update the `git
> format-patch` command...

I'd suggest using some tools like b4 or git-publish for the future:
- https://b4.docs.kernel.org/en/latest/contributor/overview.html
- https://github.com/stefanha/git-publish

>
> Please ignore this patchset and I'll resend a new one.

Please send a v5, so it's clear this version is outdated.

Thanks,
Stefano

>
> Thanks,
> Xuewei
>
> > >Similar with SIOCOUTQ ioctl, the information is transport-dependent.
> > >
> > >The first patch adds SIOCINQ ioctl support in AF_VSOCK.
> > >
> > >Thanks to @dexuan, the second patch is to fix the issue where hyper-v
> > >`hvs_stream_has_data()` doesn't return the readable bytes.
> > >
> > >The third patch wraps the ioctl into `ioctl_int()`, which implements a
> > >retry mechanism to prevent immediate failure.
> > >
> > >The last one adds two test cases to check the functionality. The changes
> > >have been tested, and the results are as expected.
> > >
> > >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> > >
> > >--
> > >
> > >v1->v2:
> > >https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
> > >- Use net-next tree.
> > >- Reuse `rx_bytes` to count unread bytes.
> > >- Wrap ioctl syscall with an int pointer argument to implement a retry
> > >  mechanism.
> > >
> > >v2->v3:
> > >https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
> > >- Update commit messages following the guidelines
> > >- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
> > >- Move the tests to the end of array
> > >- Split the refactoring patch
> > >- Include <sys/ioctl.h> in the util.c
> > >
> > >v3->v4:
> > >https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
> > >- Hyper-v `hvs_stream_has_data()` returns the readable bytes
> > >- Skip testing the null value for `actual` (int pointer)
> > >- Rename `ioctl_int()` to `vsock_ioctl_int()`
> > >- Fix a typo and a format issue in comments
> > >- Remove the `RECEIVED` barrier.
> > >- The return type of `vsock_ioctl_int()` has been changed to bool
> > >
> > >Xuewei Niu (3):
> > >  hv_sock: Return the readable bytes in hvs_stream_has_data()
> > >  test/vsock: Add retry mechanism to ioctl wrapper
> > >  test/vsock: Add ioctl SIOCINQ tests
> > >
> > > net/vmw_vsock/hyperv_transport.c | 16 +++++--
> > > tools/testing/vsock/util.c       | 32 +++++++++----
> > > tools/testing/vsock/util.h       |  1 +
> > > tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
> > > 4 files changed, 117 insertions(+), 12 deletions(-)
> > >
> > >--
> > >2.34.1
> > >
>


