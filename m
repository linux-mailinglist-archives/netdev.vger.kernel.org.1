Return-Path: <netdev+bounces-46473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFF7E45F9
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424971C20A48
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43394328C6;
	Tue,  7 Nov 2023 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6QYz69F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B2328AF
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 16:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72729C433C7;
	Tue,  7 Nov 2023 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699374476;
	bh=o2zA7ZoZg8lYNCeb9GXaSXAV9fZ4rMbzX2VkYXAnHZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6QYz69FIEBk4K3P5kR7wqlhJBzXnYgpMQ+B8nOED99b19QdKKlpg+chCDYW+HH5B
	 e+dCOpePsaLaHhyIGTNcYiEiK2VFkCbiSPgpz7d8v36GFlB35c9SQQzuDyCJVzaZlU
	 o1FqIIDlz/eRKjSxW6C3vDlK3ndrp74/9H9GI4obbBwvIXfI9+RcGCO93HH6HpjwgQ
	 BaEa+5UEZVgKhOXlE14xtdnW35dYGU4m3EnjSVQDRwRXI2btuoSBybMAHCvJKZyXAG
	 ZdZ/7vZndmIk5XxxiqCQXYa3w3hapv0GF6JxLzCmEaVXWjYkU5+zYmr2LBS+ZaDHFF
	 mY/kxGbvhF4Fw==
Date: Tue, 7 Nov 2023 11:27:54 -0500
From: Simon Horman <horms@kernel.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, pablo@netfilter.org,
	Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH net] net/sched: act_ct: Always fill offloading tuple
 iifidx
Message-ID: <20231107162754.GB173253@kernel.org>
References: <20231103151410.764271-1-vladbu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103151410.764271-1-vladbu@nvidia.com>

On Fri, Nov 03, 2023 at 04:14:10PM +0100, Vlad Buslov wrote:
> Referenced commit doesn't always set iifidx when offloading the flow to
> hardware. Fix the following cases:
> 
> - nf_conn_act_ct_ext_fill() is called before extension is created with
> nf_conn_act_ct_ext_add() in tcf_ct_act(). This can cause rule offload with
> unspecified iifidx when connection is offloaded after only single
> original-direction packet has been processed by tc data path. Always fill
> the new nf_conn_act_ct_ext instance after creating it in
> nf_conn_act_ct_ext_add().
> 
> - Offloading of unidirectional UDP NEW connections is now supported, but ct
> flow iifidx field is not updated when connection is promoted to
> bidirectional which can result reply-direction iifidx to be zero when
> refreshing the connection. Fill in the extension and update flow iifidx
> before calling flow_offload_refresh().

Hi Vlad,

these changes look good to me. However, I do wonder if the changes for each
of the two points above should be split into two patches, and
if the fixes tag for the second point should be.

Fixes: 6a9bad0069cf ("net/sched: act_ct: offload UDP NEW connections")

> Fixes: 9795ded7f924 ("net/sched: act_ct: Fill offloading tuple iifidx")
> Reviewed-by: Paul Blakey <paulb@nvidia.com>
> Signed-off-by: Vlad Buslov <vladbu@nvidia.com>

...

