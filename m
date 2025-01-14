Return-Path: <netdev+bounces-158237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C127FA112EF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0F11888728
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A32080DF;
	Tue, 14 Jan 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT0IMeVH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3578493
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889748; cv=none; b=DjpWgHmKGGNfeTdlKXKrZAi2ozEfn9bgskvsqI9OUiMn81s1zg//+jpZs84btJvYPGWYUzbovjp7GoJXulB28k028pPg8htgWxu5gD/zHfvN3J1KTvB3GZh404HgYB19RIsE8u+6j/I/hV9X1T+o8/ywDcCQ87oshfqIeXNMHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889748; c=relaxed/simple;
	bh=cA9UpQA5vQNclqhiWhCD2JNyh9dbcM+WuIXsYGOB078=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2gHocHUdy0Oe7NU6+/4RbewZuXs95xRueLaHJDlqNSHqCsQ9fQXUoseOTHksM9vzuQulXfUBudHrcUXFKcsT07bAOSGrRFdqwY4uQVtyN5eSQciXvybAG+tZoLNiklFKSM00iD497xj0yFp5rFRJBlfZSsMu0jq3F+/DbE+OSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT0IMeVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C92FC4CEDD;
	Tue, 14 Jan 2025 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736889748;
	bh=cA9UpQA5vQNclqhiWhCD2JNyh9dbcM+WuIXsYGOB078=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VT0IMeVHUg+JC8/4uc0F6OTUOxUcYF79LFrSlhC7bblb/rp04yXl4JvfS4vQD/H+l
	 7xN4L+rAczRy+ZDaVAiCooNXh2oIuQHyzBbUkyBcwkvVflPrd2UsTftWYJChsRInRB
	 jU0sDUd+PGlY00gRwAE8FXNq9XF1yG0UcC+Ck2pYybj1C9D/hg118/vo0gD/hIe8GZ
	 Bc1mvO5gZQvaS8qU663Wk7/pHACzu6M8f1qF2FP0g8aD1BQOUqgCfRTfEeJ48r1LZ9
	 kXICoqlloE+OzBpQq2KzBSN0qm7ZWIDhStXUU+RWZ6dU2jr8imXFPhQ+7xip74h2qg
	 E7RZlOq5ugqqQ==
Date: Tue, 14 Jan 2025 13:22:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Joe Damato <jdamato@fastly.com>, magnus.karlsson@intel.com,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
Message-ID: <20250114132226.3f0fdc31@kernel.org>
In-Reply-To: <fa737740-7cd0-4109-8712-09f2cb8dbef0@engleder-embedded.com>
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
	<Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
	<91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>
	<Z4WKHnDG9VSMe5OD@LQ3V64L9R2>
	<20250113135609.13883897@kernel.org>
	<fa737740-7cd0-4109-8712-09f2cb8dbef0@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 21:58:24 +0100 Gerhard Engleder wrote:
> > XDP and AF_XDP are different things. The XDP part of AF_XDP is to some
> > extent for advertising purposes :) If memory serves me well:
> > 
> > XDP Tx -> these are additional queues automatically allocated for
> >            in-kernel XDP, allocated when XDP is attached on Rx.
> >            These should _not_ be listed in netlink queue, or NAPI;
> >            IOW should not be linked to NAPI instances.
> > XDP Rx -> is not a thing, XDP attaches to stack queues, there are no
> >            dedicated XDP Rx queues
> > AF_XDP -> AF_XDP "takes over" stack queues. It's a bit of a gray area.
> >            I don't recall if we made a call on these being linked, but
> >            they could probably be listed like devmem as a queue with
> >            an extra attribute, not a completely separate queue type.  
> 
> For tsnep if have no additional XDP Tx queues, only the netdev queues
> are used. For AF_XDP/XSK I would keep the linking, as the stack queues
> still exist and are operated still with NAPI. Maybe queues taken over
> by AF_XDP/XSK get an extra attribute in the future. So I can keep the
> permanent linking to NAPI while interface is up no matter if XDP or
> AF_XDP/XSK is used or not. Did I understand it right?

I think so.

