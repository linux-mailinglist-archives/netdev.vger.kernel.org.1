Return-Path: <netdev+bounces-197944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC0EADA78B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 07:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680AB1890C15
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0491B041A;
	Mon, 16 Jun 2025 05:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfO7rjLZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E48F5E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750051272; cv=none; b=AVYBYj+2Oj3MZI4d2Gj9UCT3/yopHL0E3E9N/oDJSpaekgNxu9Ju3QhsGqy0amycCNRxJyxRf3ZlA0eV7HnpFbQqjOKV4i4uDRnbfdhv5Up2XumriSlFFV3z5IHOFXtZ3MbahUaRn7d2hh0r8jBM+PprMTtOjXRSHMi7OiV27Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750051272; c=relaxed/simple;
	bh=AJtFD4xq/MzddrsGlwqGudpwpW7HQRyhVQZnqXFLrVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzm2NtWpnXTwdaAgTpAcKVuwl2p8kbgdcOKnZcLrCz6n/5IiS10jZuhyFeoLHaw5ebrkVhLV1eoN5tyVqqRU5h9h7yIIRgOYOFPQOwUUMTjlsVCb/LoxEAKgSJXmAuov3q/irPqR64uP2GVlVGuMzdEXYyEBlEKl2Rr1jmIELws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfO7rjLZ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e80edfa06fso256809137.2
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 22:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750051270; x=1750656070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJtFD4xq/MzddrsGlwqGudpwpW7HQRyhVQZnqXFLrVw=;
        b=TfO7rjLZxEgMaaPR7zikjljhGWYCYBok6Q6iAGYuMeZmTpS2+Jz46znHFzeSNzW5C5
         ljiHsNMjB6dYN7Hb+K/aSZcALy1j7CZwRuGUkBkgq1hCrGVhWpWYWSAWA7Xrok0dDLf2
         xbiO9lIjaDKNV7zyppSspvgX4NPIft9olBQ1I6uSnWk6pfHP1vPcnBUkQOW4esQgQiz2
         AIgGxFVOlTnw1rdvaCPs9ufIh0563HzG/1RNs5tleUUC28sGpYI4vIGpoH0fr/65PEsH
         ltRkl3oZsuwFHHg5YEKV4yy16F6RIvQOtGBWG7V467iqTlA42O2YuqMvclnL2u4VnOxt
         oKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750051270; x=1750656070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJtFD4xq/MzddrsGlwqGudpwpW7HQRyhVQZnqXFLrVw=;
        b=aNuEg2lrraH5ZU6EgVspCM0W22gyKTH38mU6nIBamxtLYRJsFfVXPuxNdEwRIgpxDP
         l1V9iDbqACvDiPK7Y79WQSP6Of8q5sMcv66TW6AezLt2S0B1y8UdLi/y75HV7W+Za4Pn
         vo3jWbAX3ufgdkkbAhNhcltn/AAzs3FR9Lcwnff/9W7YPTCEhk0s+qItxFxgxjOJe/Ml
         tRV9MZaL0wOc/nSqp7OZY58saj0rOycvom7Y3sTQGu6Ziee9Wp6xJ8AdH6F7BJsEJbWL
         Bc8ReEZqOmueW+BNv67vGRIiDoYjIWAeHdrpzGDYvm2Hy9vSkKU4ebeFwSSBHxMP81O9
         w+2A==
X-Forwarded-Encrypted: i=1; AJvYcCW4dD1UbT5lWzcmhEljrmWZBtw7aJggM9ZCTTamPUbEeDD2O+Uku7n+j5nx6kvA5Eid0IlPtMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYLp4sJ9ZMQdgqfYC0OHCN4Gl8FmRnMNYt+AqvpMblBNRTnVZ4
	tDvIDrGNQdpV5rCKGJVLpgiqyFzCy1oBQsOEBcse4cjEvcEiHKOJLpjERiefcKPHskiH7WHZn2v
	WLrMOTX0DnRL+RNkjwgP+MI3V/TLBZfs=
X-Gm-Gg: ASbGnct5SXHix+oThcN86E3vyKkD7LQ4R8BX75cDdZ/FQAxkuInzbtkoPFzHAWwuCiB
	qcptNlBNeLbLFADVhAzuLEIaK0g/1uEu/7/T6piXDgQETBUG1hx1dPzp4ioR9EJb8lFUPMi3RzO
	LVuD8O+NTzb1PZJEoszKH8M6vPmCSYL+SHcDNFValM2uxRge93M2k+N2L2AW+MMhrHVxXMLv+a1
	pE=
X-Google-Smtp-Source: AGHT+IEm0hHopjC6EZOFE7CYLnrWia29/xYqNJRDAHAjjZw2fXglL0QgA9od2Mza6lK/ddrSZ+FdlZd+yx6b5jU8dUQ=
X-Received: by 2002:a05:6102:54a7:b0:4e5:a9b7:df with SMTP id
 ada2fe7eead31-4e7f643cd77mr4876448137.13.1750051270313; Sun, 15 Jun 2025
 22:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613064136.3911944-1-edumazet@google.com>
In-Reply-To: <20250613064136.3911944-1-edumazet@google.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 15 Jun 2025 22:20:58 -0700
X-Gm-Features: AX0GCFvsqHgyCYPTUqCrt_p-MYTZ76YxRToTBkx0ZUk3smRhXrZQYr84KtFhRbE
Message-ID: <CAM_iQpWCXnMtZd0TJBhmKbGViEnQuL=xu4tf4SpH2pctsR8Mog@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/tc-testing: sfq: check perturb timer values
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 11:41=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Add one test to check that the kernel rejects a negative perturb timer.
>
> Add a second test checking that the kernel rejects
> a too big perturb timer.
>
> All test results:
>
> 1..2
> ok 1 cdc1 - Check that a negative perturb timer is rejected
> ok 2 a9f0 - Check that a too big perturb timer is rejected
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

