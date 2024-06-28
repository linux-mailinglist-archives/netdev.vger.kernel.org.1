Return-Path: <netdev+bounces-107533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A091B5BE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 06:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39ABA1F2295C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF97224E8;
	Fri, 28 Jun 2024 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d4WQr5Rl"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D97224CC
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719549825; cv=none; b=Bs4+gntRSW2G5fBtaAsYNUttE/ux8V0JCe3OjcJV/XFLJix8HMu7ahGXTTK/Pn+vNvWEy902EqwmtcBOR+y6Yk65KADiWgD0joxRMbOq1/aXxhSSD0snnCBVaYtIv9rvactQqrO0zHvN22S2nF713Swow4zhdHaqLtcS9a8HrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719549825; c=relaxed/simple;
	bh=+xXHkUufrrcYG9WDBvVWf8soHkYTeIaxADIL9ESLOMw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=V6JhT0xZb62BcqMR+JmorDai/NnPdhB3IMSMUJQZZ+U6eSvX9bmJlPG1DYu41/QkMmubEvR55PV8GSHNUlMzThZfXx42cD0FcoJ2owtSfCbJm9BtjX+ol9b806qXQoUwJrh4eV77AbAheCBEU7e3AJZgdaL0ohzG6R/zSHY1ki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d4WQr5Rl; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719549820; h=Message-ID:Subject:Date:From:To;
	bh=auH3+QHNBzqsrmTAhbYY9fgchGOL7oOgaSgTbAkVsHw=;
	b=d4WQr5Rl5wH6GOsnTQF76QfSXxjkXoYi8dwunqsZxbZBA+WnY2y3Oxp2v0OX5GfRqnMANA/JhYuNaC/yBzI1mo1a9uifYzOYXSTdHqCzxpwveSOx2P5AhHF8LSQbx0McEWW8eoTt8j2CjTK4uDCl36NdGRBvaleoPq4YXp1sncY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9P4ZGV_1719549819;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W9P4ZGV_1719549819)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 12:43:40 +0800
Message-ID: <1719549707.337246-22-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net] net: ethtool: Fix the panic caused by dev being null when dumping coalesce
Date: Fri, 28 Jun 2024 12:41:47 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>,
 "David S.  Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Vladimir  Oltean <vladimir.oltean@nxp.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Simon  Horman <horms@kernel.org>,
 syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
References: <20240626153421.102107-1-hengqi@linux.alibaba.com>
 <20240627123932.4c7e964a@kernel.org>
In-Reply-To: <20240627123932.4c7e964a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 27 Jun 2024 12:39:32 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 26 Jun 2024 23:34:21 +0800 Heng Qi wrote:
> > The problematic commit targeted by this fix may still be in the next branch.
> 
> Could you resend with [PATCH net-next] in the subject instead, in this
> case? Our build bot trusts the designation in the subject so since this
> was submitted as "PATCH net" and patch doesn't apply to net - it
> rejected the patch.

Hi, Jakub

The new patch has been submitted to:
    https://lore.kernel.org/all/20240628044018.73885-1-hengqi@linux.alibaba.com/

Thanks.


> -- 
> pw-bot: cr

