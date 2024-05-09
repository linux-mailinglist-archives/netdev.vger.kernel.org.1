Return-Path: <netdev+bounces-95170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B868C19C2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 01:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7A81F23FBC
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174D12D758;
	Thu,  9 May 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rtGMrxWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3C86245
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296002; cv=none; b=trhFrEZ0pXaTDQw8zYqid/JxIt/3lOpow1ZOI0kIJPy9V2BdtN0ZHU27+fiV8gldRakM2MwPVHBXoOhavecNYib2ppOXbIpdjpfLbz4SvGclSAsetZ+GKGjMcKAMhfoHE5BT5l1k0BiN+VNbwPOLCA2LpDY7brKDoP4DZUDvE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296002; c=relaxed/simple;
	bh=Ng18fVP8U39tP/Yi0NGN1v5+V+jbpidoZX+xxyxIFck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po7Haq5Xc88b4zf9aIEJCTeq9DEIUGnWLuO41bdbfaMf+TBAukSOnFw4QgW49B4DNLsE1rhf8brzRhBDmoT1NxshBL5YwoSxCIMy2mIORMgdkJiDlH2N+Yt4WTWZMtNF8wPFUpgZ3jzsQb8X3mT5iNFjt4CeWbU2oIE6v43alOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rtGMrxWN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1028548a12.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715296000; x=1715900800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrQui9B6BoEIY/rh+mexhaF7aELyfYWuHXoeSmqlVL0=;
        b=rtGMrxWNHvsrkMZKxcoyo6lwbgezQ83jdWTAEPN9zbjUSXotTl9RE2f6Fs3xdTVffl
         4uAWy+bwDKNqRWpz/eMnxUU3Bf7dopkdxgMffIbQzOWLqRfdlTk+trm0Qp4r+nNoVist
         KdaJUO5LS0ctg48P6RS9t3n1y2TEnO1nDikuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715296000; x=1715900800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrQui9B6BoEIY/rh+mexhaF7aELyfYWuHXoeSmqlVL0=;
        b=HjxxVbywGdWbwCNJOXTOL2onaMKIkZ9iazbVt5kKy1z74Zp7Oqw/rEnA9OHznhMHQ8
         m3iJYnEdUMFcolykHx4HATY35mWWPLp7PbYpaFwaVZxwnHpTzLhxGe0I2d+98NMsOb2u
         dziTwTFKNCytMEUEv5trh05HJ8FEDuVuxVn3173I3DEr2sKL8tzWNKa7LW4WDQFnh895
         yY6HXs/Ey8aWwWWlPa67IfojIp47SSkAEily3lBeIBl/owM6VPSyqeOGyR/ulYMUeZh5
         9i1kwLqOpfp4FhwR/rBpTcy0jxEeYjl5EVAh+D6MdKjeg4s7ZZ8bVFg9xupMhOqMpeWV
         8xnA==
X-Forwarded-Encrypted: i=1; AJvYcCXj9np4ZFBtSZrfd/wWbIWnwrAERhCwq89gXtEUv8FhInjAmNS5o54AMxsC0sETmQJYWqh3oDYEC394vob5XCHnUO+JALZB
X-Gm-Message-State: AOJu0YxdbLVBb01O4i3Vprh/OFdnGrQuQ16KpiEBLfDJmaKUA3GZtg0R
	q8UdX1pOaWAGurlDGLLrDe8hbjdvwOy+e7iuQaVCdIEVx06/NyetidX9ASPlf7M=
X-Google-Smtp-Source: AGHT+IGc/iwlNZZmQjVUxnvbLuwphUnwPD4l0hWq3QPzh+j7dh2oKcWhg374+QqVtMcUzqahlUUnGg==
X-Received: by 2002:a17:90a:8a96:b0:2b2:c6f8:70b0 with SMTP id 98e67ed59e1d1-2b6cc357aefmr1012739a91.11.1715296000115;
        Thu, 09 May 2024 16:06:40 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b695f8d058sm1186647a91.2.2024.05.09.16.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 16:06:39 -0700 (PDT)
Date: Thu, 9 May 2024 16:06:36 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <Zj1W_JH-k3skeHPj@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
 <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
 <05317efb-14e9-433b-b0b6-657a98500efd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05317efb-14e9-433b-b0b6-657a98500efd@gmail.com>

On Thu, May 09, 2024 at 12:42:11PM +0300, Tariq Toukan wrote:
> ..
> 
> > > The off-channels queues (like PTP) do not exist in default. So they are out
> > > of the game unless you explicitly enables them.
> > 
> > I did not enable them, but if you saw the thread, it sounds like Jakub's
> > preference is that in the v2 I include the PTP stats in get_base_stats.
> > 
> > Are you OK with that?
> 
> Sounds good.
> 
> > Are there other queue stats I should include as well?
> > 
> 
> The QOS/HTB queues.
> See mlx5e_stats_grp_sw_update_stats_qos.

Sure, thanks, I can take a look. I think maybe an issue might be that if
I include QOS/HTB queues then tools/testing/selftests/drivers/net/stats.py
will start to fail.

I could be mistaken, but it seems that QOS/HTB are not included in the rtnl
stats, is that right?

If the goal is for queue stats to match rtnl then maybe I should leave
QOS/HTB out and they can be added to both RTNL and queue stats together at
a later time.

