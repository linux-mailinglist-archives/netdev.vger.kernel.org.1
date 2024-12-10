Return-Path: <netdev+bounces-150747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1BF9EB665
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2848C2823CD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0D1C579D;
	Tue, 10 Dec 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hf66nXEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698A1BD004
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848131; cv=none; b=VyD0MbT9h4/W/CcBuRgj8nq9sMViU01PLpKunWoLVC/u5coUTFhp1p0M51z1U07+lDtChiAyNpcZLf66Ek0zeZjTKNjoJQb/uWhZwWRBXdQVD3LonLPjuYl19Wx2TP2hGxzzX2ZmqyQaZjo6DHCGMhoEuTEjvYbZCZOo0w8/fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848131; c=relaxed/simple;
	bh=L8zZS+5vpYxW5QotLbpQWWWL3HA8cKGK24qRz6jBPBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD8UaZ70ySCi8gKed8lUUGVvP6D59ntxpyli9kwVk+Rhu1G8uEZ6jcPL/2Cd/sPVLibCTll+Rb/pjgkU3xEgqVQ1nkInRvfi//cYaj7JVPSYlOj6O7GhL6LYFv1LJKumoRqw/10HR8tdp35kd6rSDvR7XUkU0OAMVktgeDK4Tj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hf66nXEd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21675fd60feso10937255ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733848129; x=1734452929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj4MHdnpYsp681nq+qrKAbIFA8R/Y7sxbnd8+ouUZPs=;
        b=hf66nXEd/Jcz+r6C+YJWjGWiPoooFgvLyS2fuXgbyllAdotF828LhTavSiacbv+4Hn
         yCYwdwJ1I2YcAETkD6GxcXBlMtAW2Zlw7fbOps+DfeqD8Aqb9zyO023/O0cqPjnmu2Dr
         H0gidyX5yFL3g0GD1eJqBPrNFeTZEHF3h0g7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848129; x=1734452929;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mj4MHdnpYsp681nq+qrKAbIFA8R/Y7sxbnd8+ouUZPs=;
        b=MwRvc2W4egahiVvvvqOBg5hgLKX8ncS1I9PTZQQ9TP3Gd33GOU0IO1Mn/finpsRKgp
         VnZJe+acVDlW3NIRBBcu0w1ey0uu6qc860L2rJMaPs9oGbJ4uFM1d1Rk9fMLj24DQHOD
         FojzvNb1UK1hW3pDrK6Z3rMvbeDzNq6BnpBREBT8ToFL4ur4eOUl7orcS7X46IG7WwFI
         pnW+VQJbQw7GToK6NFeJV2K1x6mbldaqR2ovr3+xtktH2M9LGytMe3YZ0Je+Jy8rZv1k
         BIhNNGnOE9r7ysRI0aPr5lcaxm2U5uGYBijGE/eyR2pImV5zYeKg38dCSEcxV15e1ZNH
         kQpA==
X-Gm-Message-State: AOJu0YwFD1xEBTtbAYqGohjd6FO/B8qbhShaj/Qg+Fbo1uUpK1xGaYSP
	00Ksfcb2xV+I5+tqNlopJmsUUFXH2muvJ+MZ7e8Fq0AT8Ml0qbgNT0uGFZ91cPo=
X-Gm-Gg: ASbGncsx90t7Twu8X6C5Xq3+LKBP+G/N+8lF7/fyA23ShUApyfsCcfabyZTsex4ReUZ
	+CFAvZu2m50Pig41p7y648UD3F8J/qjYa7CbekF2BWDKjAsxnbtuc/hym9dPmeKnKE+qugHHPpM
	2dYjgHViMk3lsVNkUGRhWqqKgCDU0nDvVf8637nTTtUWxYnK+fabuh8GEsu5rd9o2+zdXDW9snD
	MuHzDzRfDUfRyfNTE3/9hR3bftSpDF4WnciEpVFKtT8mypzzwDbV06+kzLbUPn9OIu19QNvA/Om
	ps5nI08rVq9An1Gq+6Jt
X-Google-Smtp-Source: AGHT+IEtgwyNJx3QaHHEzPTwoCjXsg8GMUEN+CgmtihyPC+PN4MzAUpVMRw/PLiYKbMt3qlJgKKa+w==
X-Received: by 2002:a17:902:c412:b0:216:725c:a12c with SMTP id d9443c01a7336-216725ca3bfmr41703775ad.9.1733848128663;
        Tue, 10 Dec 2024 08:28:48 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21632b2b26csm55443055ad.98.2024.12.10.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:28:48 -0800 (PST)
Date: Tue, 10 Dec 2024 08:28:45 -0800
From: Joe Damato <jdamato@fastly.com>
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	xiyou.wangcong@gmail.com, David.Laight@aculab.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z1hsPdG3ITuDlWnT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Frederik Deweerdt <deweerdt.lkml@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	xiyou.wangcong@gmail.com, David.Laight@aculab.com,
	stable@vger.kernel.org
References: <Z1fMaHkRf8cfubuE@xiberoa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1fMaHkRf8cfubuE@xiberoa>

On Mon, Dec 09, 2024 at 09:06:48PM -0800, Frederik Deweerdt wrote:
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, for example when using sendfile over unix sockets.
> 
> Using the test code in [1] in my test setup (2G single core qemu),
> the client receives a 1000M file in:
> - without the patch: 1482ms (+/- 36ms)
> - with the patch: 652.5ms (+/- 22.9ms)
> 
> This commit addresses the issue by marking checksumming as unnecessary in
> `unix_stream_sendmsg`
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
> ---
>  net/unix/af_unix.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Joe Damato <jdamato@fastly.com>

