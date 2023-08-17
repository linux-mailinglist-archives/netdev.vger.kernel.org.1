Return-Path: <netdev+bounces-28300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3DC77EF3D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 04:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6AB281BA3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 02:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0EF397;
	Thu, 17 Aug 2023 02:58:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DA36A;
	Thu, 17 Aug 2023 02:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEDEC433C7;
	Thu, 17 Aug 2023 02:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692241135;
	bh=59wvIo/jbNZ1NEkMzIFE8KXmJTTM9lHColO0mupz8/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tl+H3n1XaCFaGkNitVc5mElUg0G+/g5ttGguNk/2EYe3VDTIE7DNThYxt6Yhmh2Z5
	 EQO/fLwR+0OPV0JlsJWTtDLeu3XrQ5d56H3CvIG6M678+DxvCD0o8A0IYL/CIRwMtA
	 Cr6CRljC0qhuJCf6tvVtuimjjAH4A4mpPY9JepQqjMyZvlTqD/le5zMVQLBinhczIs
	 kgqXL0ciZePKUCJWvhjN7GUblxvdlbzI8kDAntHRQTW22GthOPjeSHMowWptv40Ov8
	 yq0vnvESoB2MGiuDyDXuLqrxBNbH2D8ahYp1VBhJzZ1B3Poubd6wnNC1Xjqj0tLTm6
	 /E7CIzH5/naTw==
Date: Wed, 16 Aug 2023 19:58:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Pedro Tammela <pctammela@mojatatu.com>, Victor
 Nogueira <victor@mojatatu.com>, syzbot
 <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
 edumazet@google.com, jiri@nvidia.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
Message-ID: <20230816195853.7c2475d7@kernel.org>
In-Reply-To: <20230816225759.g25x76kmgzya2gei@skbuf>
References: <0000000000008a1fbb0602d4088a@google.com>
	<20230814160303.41b383b0@kernel.org>
	<20230815112821.vs7nvsgmncv6zfbw@skbuf>
	<20230816225759.g25x76kmgzya2gei@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 01:57:59 +0300 Vladimir Oltean wrote:
> There are multiple workarounds that can be done in taprio (and mqprio)
> depending on what is considered as being sane API. Though I don't want
> to get ahead of myself. Maybe there is a way to fast-forward the
> qdisc_destroy() of the previous taprio so it doesn't overlap with the
> new one's qdisc_create().

Thanks for the details. I'm going to let others comment, but sounds 
a bit similar to the recent problem with the ingress qdisc. The qdisc
expects to own the netdev which explodes when its lifetime rules are
fully exercised :(

