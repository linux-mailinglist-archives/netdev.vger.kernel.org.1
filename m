Return-Path: <netdev+bounces-68223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8358462B8
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 22:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D201F2404C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 21:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4573D542;
	Thu,  1 Feb 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk0L1jb6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5F3CF74
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823673; cv=none; b=dTCdjN2cvnn/f6z0FN1oNOyuP+WNc4UdZ/3hubJPzX3tlqk5yOBPOTjQ4wsqAoGowz4sKItlCBjjKZFbfppD+/q5nGpAVDSXydajBsHiwzaQodgiqqolsVyC4RSbC48gcK4Rag9TzSv9+92HLJsEKSebGdYa/v9aZ+GzPmDAtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823673; c=relaxed/simple;
	bh=g7SXkoeTW2KA52Kwf9BHGDyeXrMxWbrAYz1LhW9b6ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hum0y7o5aGpL4oAWeJJed4sncGQIEm3RMAByaHFUQ9ko/WFs8IaH8Sh61li/4PpMydZu9z9goFvEMQSmtCRaXvKX6NTf45d0p3nfQ6oJ5aMcUSpFJHDfaCkPwzlBZ1xhA/cnGa9ejOZXbkCFceSSKRNNWIBsOmlWcW+Y2Fskwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk0L1jb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF5BC433F1;
	Thu,  1 Feb 2024 21:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706823672;
	bh=g7SXkoeTW2KA52Kwf9BHGDyeXrMxWbrAYz1LhW9b6ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bk0L1jb6cVkci1dyvLPG7juZwmwrGs+NRtLuHAFN5ceE/JyG1VJEpraKTK4Yo/vi5
	 JvUYiJ/aLECMohnRziWwPEP87SqrPt1Yu/HVAXLTCkUtoCij+l2hGvs3rV1um3BDf4
	 WRsnKHlBHQclA3AR0Q7ulOOvnYmFf6Usd1c+JOqKr56Yznq5zRjSfRs7pcbQE2rssR
	 gWNlmhMFZ1WKlrA1x5rfD/QSlY2TFyb0ZTSPNOfbZBetLLIyM2+ga/QqZsKslvdBcL
	 1OsL+Ba6ndipYzaS7rwzwWfHiaJOq/EC0F1g4MMXfUVrd0fkZpRHagJWIMCzc3loKF
	 KySdvBY3LE6iA==
Date: Thu, 1 Feb 2024 13:41:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] netdevsim: avoid potential loop in
 nsim_dev_trap_report_work()
Message-ID: <20240201134108.195cf302@kernel.org>
In-Reply-To: <CANn89i+MLtYa9kxc4r_etSrz87hoMF8L_HHbJXtaNEU7C22-Ng@mail.gmail.com>
References: <20240201175324.3752746-1-edumazet@google.com>
	<9259d368c091b071d16bd1969240f4e9dffe92fb.camel@redhat.com>
	<CANn89i+MLtYa9kxc4r_etSrz87hoMF8L_HHbJXtaNEU7C22-Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 21:10:46 +0100 Eric Dumazet wrote:
> > And possibly adding 1ms delay there could be problematic?  
> 
> A conversion to schedule_delayed_work() would be needed I think.
> 
> I looked at all syzbot reports and did not find
> devlink_rel_nested_in_notify_work() in them,
> I guess we were lucky all this time :)

FWIW the devlink_rel_* stuff is for linecards and SIOV sub function
instances, netdevsim can't fake those so syzbot probably never
exercises that code :(

Jiri is on CC, so we can consider him notified about the problem
and leave it to him? :)

