Return-Path: <netdev+bounces-222502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D804BB548A2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B6A1C2467F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F9F2DEA82;
	Fri, 12 Sep 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdH4pN4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B22DE6F3
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671432; cv=none; b=XuN+FQPEAttDY5cPG8wM9sVNQEF4gvpUA2ZfqHd9YFQICbB0DFZcgzQ3KlbgYfUaXfpjHtDnhnOYrHuVZ0ffVEILg2w7xqqLxoBumWF/466R02BAakrHd/sjxJ6eGPBK31gRPWTkaoXtxklgRJc3ACfzpSmLUqwKH5AMu3s1hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671432; c=relaxed/simple;
	bh=S5r8u/+o4m++Q7OEjk59HHq1b4rZX/yEUTiAFIbXwtI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SDQRzyLNyH+71bInS2MzxRVAzjOjM8YbqELUWCVNLjIOJieD0mpCifd+R2YdUVMtPG6hYN7VZdVXN4zVfb/415WAMo38EVXARsMLUF0kNBvjWIsHN1lG6AfgQwOLefu6yA2r669kX3nsn7MIK2Cc1yVz4BB1+9DQLRONLTdNHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdH4pN4H; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77264a94031so1343062b3a.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671430; x=1758276230; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CCmS4zZEAAR6mzSAhpJN9WktstQgURUjEZz2NHTbYc=;
        b=TdH4pN4HLHRdYTcAyI7qSNadrGtioBb72o88qmerkTqH4VRlweSnk1XT4swu7nhV+C
         OqpE0OQMLReIFpkuDYewfS4TKuLeMPOb4ZMImeQEbGKLBpxhAXdsnzBFIFTLhc21/ExF
         vWH3ewOc+8pJKYPhJ3fghMtMI6OlB4tu++l0XPdVm4CpcTbgPyDL1bnREWHDzrOkAaIe
         H1+b2403pKF0zBkP+Q42EBmCrnOEaejhT6ZhOSRN2RY75U8oopAVfR16R8jYhO4VwBM6
         j6qce/OzVpUystp0uTl/EIr+HTs0TOqMcQ5UjuhmdOWsr+ZTGFnbH5X2ByklLNRSEvDC
         d9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671430; x=1758276230;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9CCmS4zZEAAR6mzSAhpJN9WktstQgURUjEZz2NHTbYc=;
        b=AoQz+3gDPX/72hg0p/eIA+4A2CoLtX3mFwtq8NZ5WXUnemmQw7LquGqJ0M5JjZNw5b
         XAxf1Z6OINELP3dLNEZ5AL3dxpWIt1XDh8VfqjmjHM+8/4NZ8wqhxbgq5fh3TGKMrU4o
         Smvz54DN+ABS33LZXKIqmfa+x1eE9fhs6W8VflQgU7IWLFfYXO4Da/08FLXZ0WpGYDGm
         lcQ0wrwkn6vZiKTTnWGMm3Np6PIoza49za4RL0D8lVr3t6BQCcRFe5oDU2UvRFtS8ogZ
         W0u81PtNt4FktAnrXR2Xl/NDL1yzHDnKQLHE7SpVzUKy94ihwTiG7lb+WFIbxUrJYL/d
         fSMg==
X-Forwarded-Encrypted: i=1; AJvYcCVf07h09LXosO0hczgZ0Ad16YyOzumt8sYJBSd51kI2tun6puHX+QItUHWnXM21qYDbLiAssoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4rOhm6VyIMtur4TNFZW1/5yHCqXiQdkHAJ/dSpfXgibJr37D
	zSTQlnuZbd3JkX8Sza5fRaGyc/cwNkptgPWP7jEqNnGqZCbLQEh0tuuq
X-Gm-Gg: ASbGnct37DGgNZUFcXVSCjUnYTUdGDjwmDLBU7VNvVMR9/tz85ULuNeWXI1YGbjZHWe
	wwso9apYXqmr+YGLzJxdtZMOSqiOGI+F8p0yeEKkYW7+qT9yikoofLjT8DOn+bIrvHnwm4IPHNH
	R8KKHJEfZPxTxIguyaahz3+LTdTmuBiTdUVv0dqzRy1ZPyGHv41LqbHcDcq9pJUyCD2OXCfylKg
	MppvT1dXum+nMrdlBgsj5M0YZ0GzjQZ5xoMgVij++39xHHfYz27WCUyIsh4cBIkClfYw9uXPn2E
	WEpSS5+f+MH7vrtCQB8N2bd7bMksam1sOXnRzj4iFuf/Dpfn55a6tuvW4w20ibbxxKB9ffvb1C1
	pX/9wE6ymXMhqDKHucb9Fscuv6DXLe5oA9DHmvW28VcgWFKRva/x95U80U678bAM=
X-Google-Smtp-Source: AGHT+IGiDcPhc+jzEsuNi+XDjydRqe0OGFAXmfMB6wQuzhQmuVEOLHZQI8X2MDw0RSlQcQ/piEBtkA==
X-Received: by 2002:a05:6a21:99a7:b0:249:84dc:e0cb with SMTP id adf61e73a8af0-2602aa89c49mr2775188637.18.1757671429966;
        Fri, 12 Sep 2025 03:03:49 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c473b9sm5010393b3a.93.2025.09.12.03.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 03:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 19:03:46 +0900
Message-Id: <DCQQIQ5STYSJ.1X531TK8K9OTS@gmail.com>
Subject: Re: [PATCH net-next] net: dlink: count dropped packets on skb
 allocation failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250910054836.6599-2-yyyynoom@gmail.com>
 <20250911170815.006b3a31@kernel.org>
In-Reply-To: <20250911170815.006b3a31@kernel.org>

On Fri Sep 12, 2025 at 9:08 AM KST, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 14:48:37 +0900 Yeounsu Moon wrote:
>> Track dropped packet statistics when skb allocation fails
>> in the receive path.
>
> I'm not sure that failing to allocate a buffer results in dropping
> one packet in this driver. The statistics have specific meaning, if
> you're just trying to use dropped to mean "buffer allocation failures"
> that's not allowed. If I'm misreading the code please explain in more
> detail in the commit message and repost.
>

I think you understand the code better than I do.
Your insights are always surprising to me.

I believed that when `netdev_alloc_skb()` fails, it leads to dropping packe=
ts.
I also found many cases where `rx_dropped` was incremented when
`netdev_alloc_skb()` failed.

However, I'm not entirely sure whether such a failure actually results
in a misisng packet. I'll resend the patch after verifying whether the pack=
et
is really dropped.

Thank you for reviewing!

	Yeounsu Moon

