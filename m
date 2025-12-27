Return-Path: <netdev+bounces-246113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B22CDF560
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB8E23006AA6
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516D23505E;
	Sat, 27 Dec 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKEkjg2p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950B21146C
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766825747; cv=none; b=KLVJkddtTbPFSHIAXNIHeyYyFNHW2z3Sy3vQT6mh3xaWA/a97kN3/ZLlRUUzaW5ZZKXCTiekWKvPHCU01hXIlhEzdit5BihSMeJDU15lnu5n3qqHehOmAzkk+24cTk5zUY7DhCpI6DKWltXOBHoNOKFPPaO5pJISBom3CKtWQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766825747; c=relaxed/simple;
	bh=7cfeEWuv8uK+fyIOJzcnge3KyxIGEGN/rqeXvKxcwQY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=XN8VyPXgnIxdd5E+nPJfNJogwhvMpPm/QuYxbMAKJw1Sz4v6ooeSlck4zz3xeSOUhK76+UX8VTN6pm6KYaP2xHtb8bbskBn/nXZzpAje0/DKlYSLBVQYBCE8fmId+SecPguajfZpjYqkBp90MArYyafEWwFtS+X47PSKdthYrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKEkjg2p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so8417360a91.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 00:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766825745; x=1767430545; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMTRZi0Y5Cq2uagABxlNiFBOS1A/ftQM7so1PS5Zrb0=;
        b=XKEkjg2pgaUS+n46C33EXXSsj17kG4J8UcDyt7wJglxXPW7l8Et2oCfdFX5RJjqjBM
         qlhcKvGozTd/cXW8iMuGui1xvoNwAQgR4mQWdubEGJzgKuqkCQVVmcaAltoMZJewevbS
         yuOxveiW91vL+NyAO2L8QFsLmtoVSEnke3nCZnsTP8wzg7uiFrkPTqLUJzulyY2cxIyT
         17RvpwtUf6Zn3m7orwBwiXu6mx8LWDlt/1YPSAWmYli9vKv9v9ZWgzhmd13Of3y+IaO+
         c6g3hrxf2M9mHARmBq5EE3mR0ZOiAgFJe1kaQgCPKj+v3Pue7WtCfuJqqouNcUxEAJut
         g0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766825745; x=1767430545;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMTRZi0Y5Cq2uagABxlNiFBOS1A/ftQM7so1PS5Zrb0=;
        b=iYc/CRTM6ypPqJPjP41VBs+mjD2rX4w2sdXoD5mvK8HICXjuCz1oGpZCxmqo0lI5pK
         nKOXxw8kc8mYbGWZetANRWU5KwlibFsjeymb/IMuPjFTRTb0HOzLKAzVCa4PlP+zYFZB
         B7Nu7KOd0x0X4YciZ2xSIukrS+jva7zhzmbinNA4eiJKWPaa8a8ZDK4bbELvM1Zipp5C
         +l0wVEFeYDzIerx6HsxW9vzzRdwtC69gfuK9/I1dMTcdkT2fb5fsFFX+3riSgyZPwcxe
         7Ua3mNzOKZwXEgyJgyLx2Lct7udxivJlgcznliBvc5mL+TcSCDH0Xxk/plAxI6yGGakj
         gNiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKe9B9bRSkU+9CwJy9+0KnGaTkT5W1pnog9kxFgprEDEKAeBgux5EjKXZrpJ4NrY6LabDA154=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRiXWD9F3Sn7eu5iBYZBEfkcqeF1XF0R4936ZsPndkBDtu6UG
	Y/ABGOR3k6KSX9qp3oR17hsJh0LsM59XCwaOJrJ73QQqcrbbYtPReQu7
X-Gm-Gg: AY/fxX6TH+Ir6IpMaOaKc2zc8ATbhCsbujffdxiaddGJkJHcMWd0N8QjzOx3y72ladq
	eNquidyqid0m9tVng9kMxeYnmFBFlDG+M0+xjloUcyaH/i9qT78oV6FQdkfSIyP/6ZOiyJCvqoy
	tJb2qEWPK2NkCim8KZLb364gpsCfJVZD/ev1LhN4VnsCXBpIt6GN8yo73MgWyCSAPLh9zkNRfyH
	GsgXAEybdXbNObocPhlZW8pgDz28NRCe0ucc636vAgUPW9uln8bB06aCTwbFWY++mjWEEfNNhTU
	vVl9LocoKOkoAstetv2snR4DaSuyLErK2MzeKpQvSj/x9R+Kd+5jQCY3flC+ar5An6G+1MkLP0H
	Fi7mud+CXPThHhajrgC0S7hREolGAD/rmOrz4eC4mVb4ThI3Vu7zBT62+G6mW1tsxnabzVnMuOj
	L3c4RUgpDFOgMFkFs=
X-Google-Smtp-Source: AGHT+IExxrbtPED9ni4GJa40wGb0R3hBItrv0Ks+I02DdqHnMckn6gYR3u8VGUXE6TLPlay0EBHTDg==
X-Received: by 2002:a05:6300:210b:b0:34f:ec81:bc3a with SMTP id adf61e73a8af0-376a8bc2ef7mr25671076637.28.1766825744954;
        Sat, 27 Dec 2025 00:55:44 -0800 (PST)
Received: from localhost ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7e2sm25192194a91.2.2025.12.27.00.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 00:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 17:55:40 +0900
Message-Id: <DF8VGBZ8TBB7.3KB0PWZUJD428@gmail.com>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net] net: dlink: mask rx_coalesce/rx_timeout before
 writing RxDMAIntCtrl
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Andrew Lunn" <andrew@lunn.ch>, "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.21.0
References: <20251223001006.17285-1-yyyynoom@gmail.com>
 <ca3335ea-b9cd-4158-91a3-758cba9df804@lunn.ch>
In-Reply-To: <ca3335ea-b9cd-4158-91a3-758cba9df804@lunn.ch>

Hi Andrew,

Sorry for the late reply. I recently started a new job and have been
busy.

On Tue Dec 23, 2025 at 6:43 PM KST, Andrew Lunn wrote:
>
> It would be better to do range checks in rio_probe1() and call
> netdev_err() and return -EINVAL?
>
> Anybody trying to use very large values then gets an error message
> rather than it working, but not as expected.
>
I was planning to add the range checks in rio_probe1() in the next merge
window to keep this patch small, but I agree it's better to include them no=
w.
I'll send a v2 with the checks added.

Thanks for the review.

    Yeounsu Moon

