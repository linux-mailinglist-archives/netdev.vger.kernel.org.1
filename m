Return-Path: <netdev+bounces-188232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE1BAABA98
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FF21C233B1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98339264A96;
	Tue,  6 May 2025 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="VzomuK9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128424C076
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746507923; cv=none; b=DawnATSry5o7j9JQOESLevBfJ4CV+mV9YlTMf4JYipAUcKNUcz779awWSur83basjJ8jjGxRUj4jTsEmI9p65BBajNYP42/hQykVSCYW21Q42FhJl5HH5L4NNhF+TVEGObXLObF6A/b3Q61RSBipWDRgQk/k4DFYJnftF4lx0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746507923; c=relaxed/simple;
	bh=kHo65lzrUhEj26t+So9dhlAyzK3CuJvNT0tphki/V/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hg2p5ZozQnQUVHpzM/BgiO2rQP2657e3hGVhcGxEVuHVf4mTvLddnydf4P7w0l3MCkTkdipwE0ZkUh4CJZb0h/EBQGfOnpTLDSf+O8AmMvD/daWXMJeS5vlfKh9H7e8QCefyqBF0I8mh4udX5Z915d6jZXOKQileYgSwNIoxkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=VzomuK9N; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kHo65lzrUhEj26t+So9dhlAyzK3CuJvNT0tphki/V/c=; t=1746507921; x=1747371921; 
	b=VzomuK9NhWVv1C7AZVCdl1DfvyzFtFBhukwaqGyxkBMKTE6W67lso7QaLYjN4t+5mxSxOcn7hsu
	QHHF47YFqG66I3XTVNHczK00xKXx3qZvHndAhXGn9wThW5c//IZ7D/sA6yI9kaHeWEUwfE1JJNU+G
	NlapWBwKhYi4mnA1PsY6KOnDiSlfCyshM7h/nC3uum7xFIq25LCnu8vQbz9Ma5wIYm+VtguwE+mEk
	IvqKX8dsafV4HUhEQu/EOtEOiDoOynx8KqCWe4gLcmPwI05pHj/ny4upzj4HW8/djPOLTjQrx3iLv
	wBML0Oaqw4WVwK0xOZKpzqaqTVWuDADSaNXg==;
Received: from mail-oi1-f182.google.com ([209.85.167.182]:61449)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uCAUa-00017i-AW
	for netdev@vger.kernel.org; Mon, 05 May 2025 22:05:21 -0700
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f6dccdcadaso4057552b6e.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 22:05:20 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy6izhaRzsYUmBV9CAVyn11zjBnNvYUjqAqz4+l+WF4FddpGzHI
	tho/OVvl+AeLK9eeJYPZAf6uqcOPAIyU1NelbE/1afWYe/s1zxKKLPHJft2BmealFE0HUxR8K28
	Hk9EEsbTqqd9FK+ejCTXxz6FLfK4=
X-Google-Smtp-Source: AGHT+IFtzpbuhuIJwIgZeVGiK5wv4zC72nMg3BrYeVpnbkrHfAtclCwoKg+Cq3GvfvzBd6YggLx2onfvbPNn6fxXqhE=
X-Received: by 2002:a05:6808:80a9:b0:3f7:d16c:e283 with SMTP id
 5614622812f47-4035a550dfbmr6667324b6e.11.1746507919714; Mon, 05 May 2025
 22:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
In-Reply-To: <20250502233729.64220-1-ouster@cs.stanford.edu>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 5 May 2025 22:04:43 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxWSoP6=WHBBpafcpJB90Di9rpZ7TCG4qDNg8qtHE6LzQ@mail.gmail.com>
X-Gm-Features: ATxdqUGqkiFtiKuaMD_oyeb70qug9LhpBqBIa6PvbdannfGvld49cCIlx89C3RE
Message-ID: <CAGXJAmxWSoP6=WHBBpafcpJB90Di9rpZ7TCG4qDNg8qtHE6LzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] Begin upstreaming Homa transport protocol
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 58355bea2820b4cf9b9c8322cdf0b49d

On Fri, May 2, 2025 at 4:38=E2=80=AFPM John Ousterhout <ouster@cs.stanford.=
edu> wrote:
>
> This patch series begins the process of upstreaming the Homa transport
> protocol....

For some reason patchwork has not run any tests on this version of the
patch series. Is there something I need to do (differently?) to get
the tests to run?

-John-

