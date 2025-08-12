Return-Path: <netdev+bounces-213052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE3BB23004
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838A368599E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9B2E4248;
	Tue, 12 Aug 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="vURs3HD2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359D2FDC56
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020761; cv=none; b=snJ019auXZsIqqPSGoI4rvOZpMkO32z/CQEu1wDTqpXUxdCotbJ6UdNzel9jPi6GOQBCoCvLSFzzpF6CbFVWmwquF9BROrDQ0JhwfO69pih0X2WPJgBQV3H1DyLuqNonwSZDar0gvo9N5osHTh+JVwPbieMfbqtWSxl3pXkoISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020761; c=relaxed/simple;
	bh=sLBrvqqsZtV1FCVTCMrMgsMw93cY6+eaaOKrjSt2vBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7io8yUTfdupLdQ9J+QRYSYoAbIuOI4dvZ74uR8MXx5KmQclWd8XC/RJu390LOlSMfFCP2AcjxxHFtn3K2x2s/VKqXc2kBny/mA9F7dnynm/HGNK0RaSg0HZ9u+NPSeDVWOUbAKz8mbUR3olnPiFLf7IveuHPLlQTimQaKVwR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=vURs3HD2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76c18568e5eso6458335b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755020759; x=1755625559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+evhD+loaePWkAdN54jiK6XfwBYZ051YhjuuP6S/D8=;
        b=vURs3HD2b/w3D5YTLmIJm33a9nM+AfVR3qJA1SBZM1Os4tmxY7mXTgVImWKAIvkEpd
         /3iIRwTnpG16K1lvibI20YJA1bVFOGsCUuTTkBUVE6SQwj8VO3tG2FBtvlr9Az2ufb23
         VmHIDTeJKfy+q2zhD4oc3tF9+AzfKJAYKd7Bkt7Ocf+TEEtl/UKWUCQemzdpWIjbXbHd
         2lqYxJ0zd0UWekzeUcPzjJVPjGaCUCSKzndBHyDjeSGYR9CHkrnCjPc4kuSCBoQgHMiF
         GKcXNxMqYATdAcrWmy23Hj/qFrp+bcd/sld5+WrRtkvbZHN7Ore/LtYsKcqAaFOS8e1m
         AtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755020759; x=1755625559;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+evhD+loaePWkAdN54jiK6XfwBYZ051YhjuuP6S/D8=;
        b=jGEpa3RSNxecAtjK5Hnc7fyK8EdEhZtqZ1eexpAlndRduzZp8iWQq0zXiYNlbS3bTA
         9tANx8hWNlZqvxlI98DVUnERgoPLXAT1448X30wyT0mMoYZ1ge85BGYSHQorlrxzdZGq
         4i5Op4PsQbFJGzGWpI5K/8R6nIpRKmiAk4g/2XGXtbkB6LJ39KKRLnEJ2RsB5SfAuqy5
         aitJxpqbzp/Sz657XLcauGcBT2gwIX8aHuZjZTf2nRDasHPD9tJIk5VRdpwuv/Sd2L7m
         m+fB0nUZayjS8t1hKP81z/0inw42IJEtm8W2j19WqkA5bq7y5julR2iMy9p7cp9gF+IG
         8w2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaHRi0qpVc2qkQfiROGYM3xSdBAcWAoU+o1XUCOK1xCixv2uWeT4UIjvoaYaP04B3aDlcimwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFL9EwXrPj4VjQ1xn/J4glZEyEbYxd7yD1FhzH/SuN1nxqY4wl
	cahZSO675M4Rg2CyxZ74M+mbppf1dCQOjsBWhaENcHIfWNynQMyN3dDPxqjGRpNiRbU=
X-Gm-Gg: ASbGncs2qJfZXZF3I1HZsDLJy0J4zXF4AXhM4AeP8z2+ksjQyJqBkNIC6rJXu5UkoYH
	uIqbLAhL72CFxg/6xe5VmjPhSpN/TiDBtXEdU3ySn2Ke02Tfa0a2AvcpKXGA2yZIX21SBSRWGYa
	ySq00S46On12uxBttOh7nkZKA9ulLRqiQrtvAMTo0OF6zf9dwfLZRJYwRNAxxa0Wa/fId+/iTIj
	92OuKubBWGGf87XMGXzcL5AUOzE+ivyLo3znDqrMkoKWO9xf5p/2Cf8MKiaSLeYAQ9nsriXlRBR
	Lg/nJDaYiQwnZ1Wc2+G5ujIuUAoMmR2/7o0GfQJLcPZlhAut056Nn8PivrnuEF3izjMTrgkKDJF
	p1x2+HpR6+77XmFyZ3owFRUoIsFznTjFMSS5MkskwBlwF8tzTWPzPSxXbx6Z8eqkqoyTtRtHl
X-Google-Smtp-Source: AGHT+IHgeepKUmWcRSt+K6fwtVExxF9zuRBGrYePdQX+VK6gDgBfVe8guzcU2VXIutR11ypHY64Xyg==
X-Received: by 2002:a05:6a00:8d4:b0:76b:ffd1:7737 with SMTP id d2e1a72fcca58-76e20fb980dmr68959b3a.22.1755020759568;
        Tue, 12 Aug 2025 10:45:59 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c61dd2ce7sm8965276b3a.41.2025.08.12.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:45:59 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:45:57 -0700
From: Joe Damato <joe@dama.to>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>,
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsock/test: Remove redundant semicolons
Message-ID: <aJt91SSkBO486bg5@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>,
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250812040115.502956-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812040115.502956-1-liaoyuanhong@vivo.com>

On Tue, Aug 12, 2025 at 12:01:15PM +0800, Liao Yuanhong wrote:
> Remove unnecessary semicolons.
> 
> Fixes: 86814d8ffd55f ("vsock/test: verify socket options after setting them")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  tools/testing/vsock/util.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index 7b861a8e997a..d843643ced6b 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
>  fail:
>  	fprintf(stderr, "%s  val %llu\n", errmsg, val);
>  	exit(EXIT_FAILURE);
> -;
>  }

This isn't a fixes since it doesn't fix a bug; it's cleanup so I'd probably
target net-next and drop the fixes tag.

