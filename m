Return-Path: <netdev+bounces-157904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B1A0C44B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006B53A5F3E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE81CEAD0;
	Mon, 13 Jan 2025 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZhAsqoDU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0B1C4617
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805638; cv=none; b=CL1xsIHERUHq+21gxKfe4Ts6ViDYG8xHiXSkegHLhNkD0MoTl50Cpz01jrS2eV4JJifZcdSfPxpjh9DuCcalua59JqQUogG9QTlrvMSHzg23xkDxOm6vHGCnCLvaFFkgEHJOVlOdWoR2xUDS0GLg18zCmc9DJ5aofiFmGqfIhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805638; c=relaxed/simple;
	bh=0A5M0e51wjvXR7ZQ6LTvidL8/MUyCbwv/F+psn0AIQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2we/C2gbCCmBxejziSpsDzHEzXYIOIsuXLgf5jPncsYx2vvUe/O07iT5NlxaXREQRhK3p3De2pjkw+TUIGKjWIWNw3fQfnfdBubXeNS0ZERHvxid7b7Vq94ZbBMRtPPb4ZYlN8nt+VV+G/p2o0EJAWwDzHDUo0z8iyuNpEk6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZhAsqoDU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216401de828so79218945ad.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736805636; x=1737410436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4voa8XyHCzrkRU2Eq/Ak88DuX+qGosXOiT+uso21Fw=;
        b=ZhAsqoDU8kH5ETld71E8/azID5HV/0DD98sSOXzWqBuXE8BGJVRp47OSo36uOWzhgF
         ic/g5DI22JmolXbK96QA/JDxyCFydhkUwCy4dP5L3mJAzu3rOwNg5wJmOEU//RlOmRgt
         RrI9Xzh5hC1oguCMiw32+9yrJfpZSqx4WARGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736805636; x=1737410436;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4voa8XyHCzrkRU2Eq/Ak88DuX+qGosXOiT+uso21Fw=;
        b=mrR4UUIqErlincY3ScYI0KlEZq/BX44uNp991VwefvQszVH42tuZiWlmjh7vXUdrqb
         ye97pDfR7kOo1TDHHto+QxYsr6DMfGoEuWi6ybbY8jXEqIH5648bcWrsYzn5jVdoU9lw
         OiAjmj+MbxGm5H+v7byczF4E2yttCXUr4BTD/+npfqBvvPMqEEkRuiX9bd5l4PwmmypR
         qgBb8+E0l+rTui2nGq2rPchMG5JgQGTiBkH6x3zU1PtBzRQnOwmQTmTtgtnkLIGctvrw
         GgwG/3KSQJkEji9S/5eqCek0q0/X6v92srm7fNyVj1uaeX0kDnHqCCxdSKC8hXLTpXG1
         zcyg==
X-Forwarded-Encrypted: i=1; AJvYcCUYb+h1x4JbTDTowh8KM48MvOkicSmaXY/3YZsKrZaETgVWEpQE/6OlGjZwJWUHdtajc8xi4Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37VTPW895IS2BM0r5GD0YBCDUjRWQojZRKpytelar21JfLzYG
	AqjxKOcaehJOezya5m1xkL2GOOT9zAAK9rrHmR6Xabn/irYc79iXckDJhqKqseA=
X-Gm-Gg: ASbGncupu1XdVjHsEQslJD6SbcomRLiOmTh3dsgKFujE+bhSxaHvQ6JHircoNQJRbLq
	Ce/9Ahog6No02jxJT5mtS92jFrQl2v3nBvNKAxZvUPc3z1G1V0tO+adH1yp2V75uVca07t6otrE
	4vdzfiNyzar2C7xGQ0T06Jr1gj9w8Pc2pdOI3rcSEAiO1QNEvvKqhwH+9Bz7UT3PDBMgV08afQK
	8BhZ7/GB/wV4v7GQY7iew4PnnKJeAzOgf/7cu++Q8NDBWbMrxHQgg06VWolORpyQ89d8bOiAFA3
	XfW4VDCaz4KsPyDZ1NyMhNc=
X-Google-Smtp-Source: AGHT+IEpOPzFn/NpZh2AwNtetYMBw+QAbdG9DTpSl/oQOSIDbl8WpM8vUGIa88S4rEuuWQqI/SLi7Q==
X-Received: by 2002:a17:902:da87:b0:215:a96d:ec17 with SMTP id d9443c01a7336-21a83f4d80dmr363675675ad.14.1736805635769;
        Mon, 13 Jan 2025 14:00:35 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm57011795ad.233.2025.01.13.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 14:00:35 -0800 (PST)
Date: Mon, 13 Jan 2025 14:00:32 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: cleanup init_dummy_netdev_core()
Message-ID: <Z4WNABG5YgHquT9r@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250113003456.3904110-1-kuba@kernel.org>
 <20250113003456.3904110-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113003456.3904110-2-kuba@kernel.org>

On Sun, Jan 12, 2025 at 04:34:56PM -0800, Jakub Kicinski wrote:
> init_dummy_netdev_core() used to cater to net_devices which
> did not come from alloc_netdev_mqs(). Since that's no longer
> supported remove the init logic which duplicates alloc_netdev_mqs().
> 
> While at it rename back to init_dummy_netdev().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

