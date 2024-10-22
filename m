Return-Path: <netdev+bounces-137902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E49AB0D4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C7B2180C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A751A08DB;
	Tue, 22 Oct 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Oxurvs7y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C519EED0
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607345; cv=none; b=TaGOpGGjIlom0yLn8N23Y2sUuc7dpIE67JUmC/AkRrJVrEMUm/mbYfVUxvFG0yvOaiZizjl5F0EYUPDT2dT9xbWBQxFnAjLvZ496dLlgRoNisOZOjD65cUftqHuXxAIE4pSy8Q3TG3CdyJ3/0VJZEYgiMJXnt8AfYbo+3Ps0bL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607345; c=relaxed/simple;
	bh=FWIUzDJsMLIU8LmwxOdULgE14BEiPOqKtaJ7NvsJTKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdp8jekCof/ts5yjH3l2Q0T1K6umSQGS2QvFsZALHEiPYLUj7T/s7CsKCHtQaLhzoqNvNKYH8z3NPKxbnY/++6lL4ZpUSLrTYigSGMs88+eLVtagbmZwJaa0IajKhH07fZfnB5VGhUvvV80RkWwEg60VLE+ivACLG18yIVj44gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Oxurvs7y; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b161fa1c7bso228981285a.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729607343; x=1730212143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBQs0VktZnZLMvhoI85WO8zPMaVfIDxzSx1BsoDRynk=;
        b=Oxurvs7yXvalAKMsBc/nP+/D+5la6Rkxlhdm9Ddkq8teH7t+oHpH7ZPJ+mVwHFfk5W
         wxpWq5N/4aRo4KVxiOisV/uySj5b8oJ3ynZNKVOd3clM1EmoUaX7yHLk8CnFODVP13eb
         N7fht01EuJdQr+AIuw6NEB71zGLc/POVDDPOZHy4hK2fMwM9nr4wlySNrWHEkgUi9jlN
         feWU3ztMlmnHFVnIRphfcFybCCaMbczHzYOoWoeL8mg9ryltTKNVU1a7VqZqb735OtLo
         axITeO/szettRnvohX4iLo+FINW4Bm7Db00hnc4vdqlOpcuwYfRYjpIs1QFXXye7dlsC
         /Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607343; x=1730212143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBQs0VktZnZLMvhoI85WO8zPMaVfIDxzSx1BsoDRynk=;
        b=tSWndgFc+7tDYiyUufvye1f1R0IqmmkKfCbNq5C25MVbefoIaiFfN5WTwm8iB+CTGD
         ZOCH1sHGKllPv7zWubZHQ07oa3V9gmeB6bgdb2kl0NL6Cj6O8woCUYNOzEcZNERyw0Nz
         8R5YKXCw6TYfElPIMB70LfV2FX9Q0gliAGb0hlWAOC4Xp+/mxh4UXVyCeLcpNBHaZ7zf
         dHJrJoAegSvZd6UuYMRPrPjsC4roU2Wzg6TtqUMq1Kny74N3Wk8T4cytB1si7RVh9W9N
         o70duxz91AC/31OgcDlydx4VGOkew9GkUc76ezP/xEgzSfcC+7ZK0SU0dm1Dv2NnvMwf
         5uNg==
X-Forwarded-Encrypted: i=1; AJvYcCVDCKFXRpC++xtm/aOmQ+KxtSAOd+tjyoQx8zqKmJXcXinwFIvhmSZjVUXXpeqYLI2brhF6cm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynn33mrB3YGsA7e1TkShiVzv3NsfRLUS+NU5xLlyhX3B/ADa/Y
	6WYKvbNBybn5zbJoJnk81eOjk+TULvHPiJpp2jgEfOFVJIHzR1u4XeypnmiAUq8lIRoUxuSUxMs
	i
X-Google-Smtp-Source: AGHT+IH8N2eHg9nw+vHszANEXOFWLyJrLXfEthKl81Z7ZBHmwyuw+1iu3EyqKAdTOb/FJU0+FqZosQ==
X-Received: by 2002:a05:620a:40c2:b0:7b1:47bb:5334 with SMTP id af79cd13be357-7b157be0c1fmr1774276585a.40.1729607342834;
        Tue, 22 Oct 2024 07:29:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm285619185a.60.2024.10.22.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:29:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t3Fsb-003rIb-1c;
	Tue, 22 Oct 2024 11:29:01 -0300
Date: Tue, 22 Oct 2024 11:29:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+6dee15fdb0606ef7b6ba@syzkaller.appspotmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] INFO: task hung in add_one_compat_dev (3)
Message-ID: <20241022142901.GA13306@ziepe.ca>
References: <671756af.050a0220.10f4f4.010f.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671756af.050a0220.10f4f4.010f.GAE@google.com>

On Tue, Oct 22, 2024 at 12:39:27AM -0700, syzbot wrote:

> 1 lock held by syz-executor/27959:
>  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: __rtnl_newlink net/core/rtnetlink.c:3749 [inline]
>  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_newlink+0xab7/0x20a0 net/core/rtnetlink.c:3772

There is really something wrong with the new sykzaller reporting, can
someone fix it?

The kernel log that shows the programs:

https://syzkaller.appspot.com/x/log.txt?x=10d72727980000

Doesn't have the word "newlink"/"new"/"link" etc, and yet there is an
executor clearly sitting in a newlink netlink callback when we
crashed.

We need to see the syzkaller programs that are triggering these issues
to get ideas, and for some reason they are missing now.

Jason

