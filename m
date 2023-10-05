Return-Path: <netdev+bounces-38441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC87BAF27
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 68F232822C9
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89FD43699;
	Thu,  5 Oct 2023 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFLMVXPe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3843692
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 23:10:27 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD4D79
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:10:19 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dd7139aa57so975778fac.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547417; x=1697152217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/YtWbTk+ogUdRC0TaUNLH0mjAz4ZjMf7BjFozKWCr4=;
        b=AFLMVXPeg5AM8dkTNry21oak9DwrjG9EyWaqYRnL34AZFSMc5wWNJfy17Os8URahoG
         JKOuzt0ERG3W9R4M1nk2H1pZ79hOd1994UYuDY3fsjsn+Ua5p7eq5LMpNQSyCbq4zNvs
         HCMSJiWYhjJM7cJbBWr/BQx0/bpDNWKyzIK0hN3oBh7vf5GDu5laZnlO7YffJ2mZWNJl
         NOT3IjhTDIGD7BzbCWxEeu9mV2D64ks/hzMv9KRtNSAs4OmhOYu2RsXlEr9JEtjYx8RO
         ydeEdijaYLSMPESApHlT6NR/pDj33hIBAIb/CZg8hzeXvjllYPai+AdZGxe+gYtz13UR
         630w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547417; x=1697152217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/YtWbTk+ogUdRC0TaUNLH0mjAz4ZjMf7BjFozKWCr4=;
        b=uNmzmWUX7JTXrcOUN42B7JXaSQ8zvCmNLCN3i/5JgqzdmvN2kW0QXhvorNYJZslipA
         kTwHcjcEkzaCXSdddtQ7l4dwBft/Y5gA8os3gLiL0WMt9KdED7YvJE0OFgaAdcXRRsbt
         UKasFNr47oPHh7izzOAD85qPhhhf48Sq9ADBM6Kf9ErxxdH+RpfxnqHlvwzy8YETqIHK
         a64GwVN3imKl6BAF7aGplRZ2O7/7ABbHaqNPEHuHZPid4kQOYiPPsWCSykSTW9IZWMW5
         9LeH0Lzasob37G86mLSfkO6fYm7T2LN1GPEl68oyVHBZfdtOzNRxn7/5kQz/eITpuYAa
         wLRw==
X-Gm-Message-State: AOJu0YwiYTpqRwdVSYrCmqHK7DavpEiyvq+fEITK2Dw2ZaRIn2grQhP/
	HxNAaPC6HnkSsMr4fIWB/9kgOigEaUypdb5ZyO6bTA==
X-Google-Smtp-Source: AGHT+IEi5mt0HUWvGXoOR9/HihUuvyjLFuF042LlV5NUednd2sjFg1KVbs7kTHVGnRgnM9lXJBh44olZr34CTe9R6yA=
X-Received: by 2002:a05:6870:c6a4:b0:1b0:3637:2bbe with SMTP id
 cv36-20020a056870c6a400b001b036372bbemr7422579oab.54.1696547416661; Thu, 05
 Oct 2023 16:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003041704.1746303-1-maheshb@google.com> <ZRzqYO2eV9Lmm8+O@hoboy.vegasvil.org>
In-Reply-To: <ZRzqYO2eV9Lmm8+O@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Thu, 5 Oct 2023 16:09:50 -0700
Message-ID: <CAF2d9jgRwSF426u9jgYZeVd5+Cd3B21m-bT_FcSzW83riJvhhw@mail.gmail.com>
Subject: Re: [PATCHv2 next 2/3] ptp: add ioctl interface for ptp_gettimex64any()
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 9:30=E2=80=AFPM Richard Cochran <richardcochran@gmai=
l.com> wrote:
>
> On Mon, Oct 02, 2023 at 09:17:04PM -0700, Mahesh Bandewar wrote:
> > add an ioctl op PTP_SYS_OFFSET_ANY2 to support ptp_gettimex64any() meth=
od
>
> NAK.
>
Could you elaborate?

> > +     case PTP_SYS_OFFSET_ANY2:
>
> 2?
>
> What happended to 1?

My reading from the commit 415606588c61 ("PTP: introduce new versions
of IOCTLs") is that we have an issue with the version 1 and hence we
added ver 2 of the existing ops. Since it's a new implementation, I
can skip the old part and just implement ver 2.
However, I can do something like
     #define PTP_SYS_OFFSET_ANY PTP_OFFSET_ANY2
is that something inline with the mix of ver 1 and ver 2 expectation?

