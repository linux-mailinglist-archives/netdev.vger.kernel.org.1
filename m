Return-Path: <netdev+bounces-147898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722749DEE00
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 02:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A32816E8
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 01:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D182FC52;
	Sat, 30 Nov 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzLIWDG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A920330
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732930988; cv=none; b=YD02rVtcM1cg7hVBQc8wRCdwRuxToMO4obIsNNjVN4FzJfOPyXHmDlcBgnGtF+nCeNLrwgepmrSDAnDFTcrtwY9Vjw5Gtfmm9gokoKlZOshW4/NG9FtsCVKhce97KXjNXvSISfKOUXUj8HbeIATsSAjX+W7DacBMUe5HlqJN/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732930988; c=relaxed/simple;
	bh=pudMl8nc5oGMPdQIl48BgAN5ltBiTWIrazbJSf6Pem8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzw2h73OImu2Y3YPNyufusFUnK2TGXBmJE86lQ3ewZSNAhn6Zo18201bsewCRarrYJLIvjQoMGvXPC1lHmSAs2ID8lYp7uvn12XanXjwb3xm1/q8GoTulpY4NQBFm/Xk661pWM2vYZhLWu+H5vKLbBS4oR+ks7WKSk+lO7f0ulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzLIWDG8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-212581a0b33so20259785ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 17:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732930986; x=1733535786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqV3CiPKKjmZu2z0ijx/0vb6KtsZ/XIcfyomCwoDXH4=;
        b=fzLIWDG8dInQNWFKWdvJjvR+qayf9NwLtI2sNETlxh7xtlgeZHrTA2cXLA1LK5X5Se
         vkGR5JDoNM19RBpXKmlliGHmzDTS0ZIiEaKruvmbztR7sPUpDhglHbf6zzAuWRCareFT
         pbpkJzHxrD8Pvg0kpcDqvgIZvU95Jyr6I9wm3w7cWnV0LsvycjbaREz9iL5E4EyPAT6t
         YP1YsiO3KRodociTSNHl84peX8VWA8diPs52NvgXIPHgB1Q563KIWM6RlXZ/xjxAxkuO
         y6Y4KwsR8IfEZLYBeEEJYOZpLi+8jVNdJzZ7ivLEDrYIGtPAncxT/d6WJFZbjMWE4nY1
         UEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732930986; x=1733535786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqV3CiPKKjmZu2z0ijx/0vb6KtsZ/XIcfyomCwoDXH4=;
        b=QJF9m2EaO6USngA9fDUT/HSkT9HXQtWSWU/+KcXMWEp7nTaBRrWQML0tBFWnMPGvHD
         I8OBF7tNCCWh/7yACuNsTZS9cfWWJJ0UdFbjZ4u8nit8yy9f0DT6IeEnta2pyNrNUzHD
         nQCN39sLhAi2B7Ha1MWkdmoYEvisSer6EC4nVhNOT8aMyXevCpYjs/iX9bQlM+n9hAhI
         XQM8Trc309UKnBRmCykItkSqur+3uwUEs2c2uyK8Me9EEQB50wKpWeMb54TqvfnOhaBZ
         TB4tq5baJVPlarH7Vt0Arqc7YuuKBy4X8RmIbaHOC6VHxn8+UzenRyg4uMDmU2VZ2HmE
         /ygA==
X-Gm-Message-State: AOJu0Yx5YJJyWuuUHpoaw6nYj0qf9/4ECwbbXSJxanBDgsF9yaYlpz7Z
	nxx6mSrYpfkP1DA4cf/uBfhVkqd/lC3IlRwM1ZGWh8hewWhvriM2
X-Gm-Gg: ASbGncvAA2tVNoVoMt5jVdnUkdc80Z02U/BbQBgv4WdoHS4tJBCDD9kr8jdef0AjIhq
	tRTp0p8LE3RTVEN1rNpZ9nRy2K5+TWbqjaysJnebcy7N3OpipJVJ/h5dJpI3e0pVkVc/8zUJD/x
	uCHNNwr3YUSFoogCVBXATPriDSxJrsfUoJK4ssDZIumycPfYg+YfBj3iM9c35kcz0em+Pb0I0qx
	YAGtMTU9GKcdRX61XYKP3T/yL2OwFvdExc+T52T3CvWJaJ381zgJhh5
X-Google-Smtp-Source: AGHT+IFFdcDqXTZNk1GNccYuj4DnU/MpRC5jrnV7VRm721nK2VO/fpbaYYLmxM/jDLgM4IzhxHk4Bg==
X-Received: by 2002:a17:903:2447:b0:212:45b8:4667 with SMTP id d9443c01a7336-21501c5ff37mr152317475ad.39.1732930986105;
        Fri, 29 Nov 2024 17:43:06 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:22e0:3259:eab0:7dee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219b01f1sm37042645ad.239.2024.11.29.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:43:05 -0800 (PST)
Date: Fri, 29 Nov 2024 17:43:04 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: netdev@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z0ptqDcLjrjqruQA@pop-os.localdomain>
References: <Z0pMLtmaGPPSR3Ea@xiberoa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0pMLtmaGPPSR3Ea@xiberoa>

On Fri, Nov 29, 2024 at 03:20:14PM -0800, Frederik Deweerdt wrote:
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, as when using sendfile over unix sockets.
> 
> Using the test code [1] in my test setup (2G, single core x86_64 qemu),
> the client receives a 1000M file in:
> - without the patch: 1577ms (+/- 36.1ms)
> - with the patch: 725ms (+/- 28.3ms)
> 
> This commit skips addresses the issue by skipping checksumming when
> splice occurs a AF_UNIX socket.
> 
> [1] https://gist.github.com/deweerdt/a3ee2477d1d87524cf08618d3c179f06
> 
> Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6841e61a6bd0..49e4f9ab625f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7233,7 +7233,7 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
>  				goto out;
>  			}
>  
> -			if (skb->ip_summed == CHECKSUM_NONE)
> +			if (skb->ip_summed == CHECKSUM_NONE && skb->sk->sk_family != AF_UNIX)

Are you sure it is always safe to dereferene skb->sk here? I am not sure
about the KCM socket case.

Instead of checking skb->sk->sk_family, why not just pass an additional
boolean parameter to this function?

Thanks.

