Return-Path: <netdev+bounces-57752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98AE81406F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAAC1F2153F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB6110F;
	Fri, 15 Dec 2023 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYFn85wS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB9D515
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F02EC433C7;
	Fri, 15 Dec 2023 03:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702609761;
	bh=FPibQYImoSC0PSFDPY26IWcYwFfbNKrkyGey9LhHyJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oYFn85wSZP08XSbliexEvVTZjKjnRN2m34HIr2ZoOrnGj2pDbKo18JKtbn3uOXuvC
	 YsxXMP70as0ZJ2hrS62JhkIFV4Qz1xeTRRLvPWOEHWZ6803MlV2O6MJDYLGw60XkKA
	 0bPY8ieZqgv7/Uqmyz9EGWLrgNlS8AyMS1yrKudLynZcEiJhyKolS49icFH7VUYHAK
	 dkiqoucc31JQShVCD8KRcwpXTB45oEQW+W0WRfP99XPRlUUzRu/Aj8knSMypa1TQJn
	 WMcz03utZkd8blfJJ26Ue0XjBofz35R8mivB9hGlL1h49t/pLmMIFsomhzhtQKs4x5
	 GPC+6xMzzv+Kg==
Date: Thu, 14 Dec 2023 19:09:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
 pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v6 3/3] net/sched: act_mirred: Allow mirred to
 block
Message-ID: <20231214190919.2b446e31@kernel.org>
In-Reply-To: <20231214141006.3578080-4-victor@mojatatu.com>
References: <20231214141006.3578080-1-victor@mojatatu.com>
	<20231214141006.3578080-4-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 11:10:06 -0300 Victor Nogueira wrote:
> So far the mirred action has dealt with syntax that handles mirror/redirection for netdev.
> A matching packet is redirected or mirrored to a target netdev.
> 
> In this patch we enable mirred to mirror to a tc block as well.
> IOW, the new syntax looks as follows:
> ... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >
> 
> Examples of mirroring or redirecting to a tc block:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22
> 
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22

net/sched/act_mirred.c:424:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
  424 |         int err = 0;
      |             ^
-- 
pw-bot: cr

