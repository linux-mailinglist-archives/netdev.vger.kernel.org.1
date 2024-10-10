Return-Path: <netdev+bounces-134137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AABF998255
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A83A1C22648
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4671B3725;
	Thu, 10 Oct 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqw3SfPg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC21B5337
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552820; cv=none; b=Auswe2Rcm/xp0iUgkiXrcmyWZq4tDWI3wjX4vHylh+mRHzao2wlbY/Kr5qI03u6JdRKc4+BMiaD/w4BU6kM50NH+oLakeAI/zwi1+h+VpDqCB5FvKCtuaSE1BD9hsPprsPUVfH6A/1ErpOjv7bAtiw83XZqXK08ajl1GzFvphxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552820; c=relaxed/simple;
	bh=9g2GZgX7YLMTfizr3uLJ3YSM33EUN4l2EdYzFB7P/Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao2qhCFNbuaukkY4KfGBF02I7ZwgK7qt6NMt3DhDsdObyUaQdzBND0A/IT515hd5PXP5lT82YqS+E63L9OCAIN8KeY/dR8oKHFhR2gDz+Ugb2AcVBIlqXXq1dU8d8eAcOwnz0BdXc8DRcC3CovbRvs+jGjti5XNgjG9nyXalUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqw3SfPg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c928611371so899171a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728552817; x=1729157617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8ZN3sGcHFW5cNxDCNYw4XoVBsmt6TsaSDQA/98TMGs=;
        b=vqw3SfPgzp4NoN2ZoWB7a1BuB2ORuvLRJPLdD8w6A/wwSty3oR4Do5EBJ6iwsXzKhU
         iTihCQkygvoGPz6orjSj+9DbyOLxMpFtx9KS+dS37LWry4e51zWMjPp/wae5xs51EYw2
         9lbH3SbkmQdCHWBer+j6LdsU/T2NfarTx0yfkDeC7zbpFRAKtIRa9OG4sn9wOpsBjyqP
         pvFY//leuna9wO9yzYr2bFjVk8qh9iUKdKsNOn77TSeIixYSKBfNafXrAm74EsPDNAPO
         wE3LeBdBvkxqPb3rBgYom+7ZuMF/WTmnhpIW6qn7JgDfUqEexcGk+nUOrwquvIKWf4Hz
         MonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728552817; x=1729157617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8ZN3sGcHFW5cNxDCNYw4XoVBsmt6TsaSDQA/98TMGs=;
        b=gMLJznDWFjoMEccSMvvqWRQ3JpY6bpHKSJYN9cRYxbpllXOIEhvmXJ04G5aKYFMar7
         inaM6exWP/sDrszy/2vxEXIVnjXBvgTgw4IoKTCQhmz4lFP3Dcf4NFLSfIlOM1A7ehKj
         KuCX/LPdIDrDEz1h8KOvuMeAqF/Kfb8ei+4PK9OKhUSjqlV6qROyqoAmm9KxFv49qj/k
         75cB4s9SJvxr7NRyvsHnPyJoovnSeexPYp8hIh/MuPiQJ1+Ry35KvRxC/Fi66StHCNnz
         5XI4xjYW/RQPMI4r4Z5jxlpWT88TkrEA2jupmxIkIBrGhhxWC9xdUohjuj+RN+4G1VJc
         EbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbOeDx+V/DIqyXFqjQKajwRKJOZ9IkgU4uVLw5Z3a31WDridyb7BMPO3MzrcP1TUt+Xvtz0Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgfwtlk7nWf/UKJ8pi/agJVKp7vjWRgrDmQlniX2lfd8fxdnAA
	S76ppONLBWakFPlRDC383c7kn+NgNJqLRw59v8RFnYBpHty9DkTN8eZlCtS3KiSIy1ZsD5RENCV
	lahY8BsBczuVhNMgqK262TdsrBEKUCXck+896
X-Google-Smtp-Source: AGHT+IG6f+1+cShAjm+Q/P4EmH5hUmriaWo+nOB8KCxL3gEZC5cUue+lZ847TKGtOySucv9TQcoW/3Agr6kYOY/k8iY=
X-Received: by 2002:a05:6402:51ca:b0:5c8:9f3c:ea01 with SMTP id
 4fb4d7f45d1cf-5c91d54d157mr3661316a12.2.1728552816698; Thu, 10 Oct 2024
 02:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com> <20241010090741.1980100-9-stefan.wiehler@nokia.com>
In-Reply-To: <20241010090741.1980100-9-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 11:33:25 +0200
Message-ID: <CANn89i++SBxvJzPb8Xp8_P6gJEaBm0M50SFB=z+xNQrmM8jVfA@mail.gmail.com>
Subject: Re: [PATCH net v3 4/4] ip6mr: Lock RCU before ip6mr_get_table() call
 in ip6mr_get_route()
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:12=E2=80=AFAM Stefan Wiehler
<stefan.wiehler@nokia.com> wrote:
>
> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
> must be done under RCU or RTNL lock.
>
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> ---

Please send a cover letter in your next version.

Please add a 5th patch in the series reverting

commit b6dd5acde3f165e364881c36de942c5b252e2a27
Author: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Date:   Sat May 16 13:15:15 2020 +0530

    ipv6: Fix suspicious RCU usage warning in ip6mr

This way, tests will detect more easily if something is wrong.

Thank you.

