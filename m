Return-Path: <netdev+bounces-26960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A8779AB1
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE71C20AC0
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D134CC6;
	Fri, 11 Aug 2023 22:24:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864B8833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B76C433C7;
	Fri, 11 Aug 2023 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691792681;
	bh=SJm8zql4R1blYBqCgF0cDibC+/Ws9z7Xbqu36AMpLnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GcatsjGaSpQEWZH/kdvZXZM2tvP3v+uevNPu8PNgJ1ky1kNrIb/DzxUkj5HSk7vSi
	 OqzBAF2vka5jvtpTPAXkXk9zaOV6vk40If5poOXGzMqWNdZhCZtVpI9wIGXztTJ3WL
	 pyosqdBQpuwDZrY9HfaIxR4ubPdDDqTucLxxVT3q1yxJE08kcRwIfFvvrE65ZxyvWf
	 X+1kxdYlQrmJyRusph49vL40zpcv4Scy6/vFCWdcWb98bfeAwlIcemexP1FCZprKpu
	 lIdWWp8hnZfhfScGk4p8Hn65TqZs/9gnAO7x19ioSDT0eb56De/27GBt9ag0dzwIv+
	 YBjI7IKCa9a9Q==
Date: Fri, 11 Aug 2023 15:24:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Michal Kubecek <mkubecek@suse.cz>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 johannes@sipsolutions.net, Vladimir Oltean <vladimir.oltean@nxp.com>,
 gal@nvidia.com, tariqt@nvidia.com, lucien.xin@gmail.com,
 f.fainelli@gmail.com, andrew@lunn.ch, simon.horman@corigine.com,
 linux@rempel-privat.de
Subject: Re: [PATCH net-next v2 10/10] ethtool: netlink: always pass
 genl_info to .prepare_data
Message-ID: <20230811152440.516c6bc2@kernel.org>
In-Reply-To: <ZNXjdj3edS1Up3Mt@nanopsycho>
References: <20230810233845.2318049-1-kuba@kernel.org>
	<20230810233845.2318049-11-kuba@kernel.org>
	<ZNXYZRNJkAqw686J@nanopsycho>
	<20230811071324.gfkzlpb3gbwvuufm@lion.mk-sys.cz>
	<ZNXjdj3edS1Up3Mt@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 09:29:58 +0200 Jiri Pirko wrote:
> >> Anyway, the genl_info_is_ntf() itself seems a bit odd to me. The only
> >> user is here and I doubt there ever going to be any other. This
> >> conditional per-op attr fill seems a bit odd.
> >> 
> >> Can't you handle this in side ethtool somehow? IDK :/  
> >
> >I don't think so. The point here is that notification can be seen by any
> >unprivileged process so as long as we agree that those should not see
> >the wake up passwords, we must not include the password in them. While
> >ethtool could certanly drop the password from its output, any other
> >utility parsing the notifications (or even patched ethtool) could still
> >show it to anyone.  
> 
> Yeah, the question is, if it is a good design to have one CMD type
> to conditionally send sensitive data. I would argue that sensitive data
> could be sent over separate CMD with no notifier for it.

Good catch!

Hopefully we can address that separately (I mean someone who cares can
send a patch? :)). We had multiple people get surprised by info being
NULL I think the value of the other changes outweighs resolving this
little oddity. I'm going to send a v3 with the bug fixed later.

On the existence of genl_info_is_ntf(), I would rather keep it.
I'm a bit worried someone else will need to know at some point and
will do it based on contents of info directly, which will make
future refactoring risky.

