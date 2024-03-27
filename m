Return-Path: <netdev+bounces-82520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427AF88E754
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAE4301005
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258C713FD61;
	Wed, 27 Mar 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMe1Bx2P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46A130497;
	Wed, 27 Mar 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547474; cv=none; b=sXkjKKQX4u4hDzHMxJiCGshjltbSlTZ1fcg+itT1YTSkK5SqPnwE4NGrwZIyN2TNcrvBdJrzBmHwO06JI+DKyP9YEfa9uWMNvPSIqSgmv3oj+QsVVnSOF44q3/t+5x/aB04/aq0nhcG4DROBFet9/BkU4tRs4ABSb0CNncMq2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547474; c=relaxed/simple;
	bh=eBeVJJjBQuSLqK0+jgddYTUYuMVNOj2T6hARHl6y6ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4B4UxN1tuU1DRRv2YkPMb1568Yy53rL8WZrlCoxLTpCRMl5Vhge5w+Z9pTdo0mq2NfB81n/RINI6tmX6JOwtRUmoyvXoSb9S53+/9wC6Q0UbrV/7Ow94fIgqPEOtcW6y4tcxXLtdHbJ9YB4W3CGwo4xrEvNBfcnsQlL58xKBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMe1Bx2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F1BC433F1;
	Wed, 27 Mar 2024 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711547473;
	bh=eBeVJJjBQuSLqK0+jgddYTUYuMVNOj2T6hARHl6y6ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMe1Bx2PKDoJmsuc0m4kIpTX13gp4DwvDQwvRQbuIHU00Q/+kvifMuAF8yhETH1aH
	 t1XOHdNYX7HSI/Gp6LSdm65HAcDjGuNWfCfoeo1cZzaviJNA7e/7NJv38Z2lnYprh7
	 ybZZ5TFcH6hVLtUhdYlfwS/Guninir1wVcLnr9qG8IUbsWiK4w86Aoc6berB2T9fG7
	 qmCVeZ1cZcxaWlUre0gTsgYWGsU/4nGQE2hCkAeau2z8rGoWP6i9mpWvJB+/vbCRtr
	 SXXYjvJcVpqyqZqyN9H2S331i4+bviK9cbukIa02sc/3cfv6Z5iNE1UWaikTfUYZzC
	 I7URuRJvKoZLg==
Date: Wed, 27 Mar 2024 13:51:08 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llu@fiberby.dk, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 1/3] net: sched: cls_api: add skip_sw counter
Message-ID: <20240327135108.GE403975@kernel.org>
References: <20240325204740.1393349-1-ast@fiberby.net>
 <20240325204740.1393349-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325204740.1393349-2-ast@fiberby.net>

On Mon, Mar 25, 2024 at 08:47:34PM +0000, Asbjørn Sloth Tønnesen wrote:
> Maintain a count of skip_sw filters.
> 
> This counter is protected by the cb_lock, and is updated
> at the same time as offloadcnt.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


