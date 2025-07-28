Return-Path: <netdev+bounces-210504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AED9B13A2B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB417A27C7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58375248F72;
	Mon, 28 Jul 2025 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0FfGMeB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303881B412A;
	Mon, 28 Jul 2025 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704121; cv=none; b=R1CoGSJnb8z8ekBF05LT8AY3j+I+NtsEoy5lLWIJSoP5PVN56L5gz3KNzSNNAXQ0OdHSuL9Jffxzjslc+WkDqvgADueCxoAUo4uwXX4Mb/4Tq0+fJVKyv789c249UUKCKhjdVJNDfnyZsPmnVXWtf+OZEUTX7Lp3G/nIyf8aK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704121; c=relaxed/simple;
	bh=K5omD7RGOhPEzhUznjylosuNOQe0HHUSXY8RpKWqF50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKIiBO+YrVup8VBFV3e8msE0foD8A/M4w7acU5sFUxxsU/SKtItgVGZFG758Uhi5CYxg3GB8K5Bu47b4jkbK9DZXofggt2B9FXr91bBAHtIzA2TzOqUYLvKgW6hsFsgyhC5nM0Re/6rwGu0E5FZMyU00l1grExqid8eN63j0ZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0FfGMeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECEEC4CEE7;
	Mon, 28 Jul 2025 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753704120;
	bh=K5omD7RGOhPEzhUznjylosuNOQe0HHUSXY8RpKWqF50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0FfGMeBfQ8OuR+dpvluBCpDrMR7vx/DMnvUHvt/xTFjV+XySV0Wsh/9p8NLIxWWI
	 tadEH4ydZThUEzmdsHYJ+LklZoIZ1rIfHeM4IV0pSO9r1uWSww3GBzOspXli441h9x
	 kwf690hHHXz5zbzQZHhQZE0wtonNOVNdXkG7bHeb+0r+NsyeNVgpVJzjUuepDU8pnS
	 Fx3t/xZ3ZdRcbFe19OycsU9xhjsoKCVViyejTNk07+3iTlVsGXTIKKHkI2wed9CnbB
	 R6m/g3NCdPAKsT5Kr1xkIMutiA7mwlS+vKdy+VxvYKB3GBckZx7O/7zfFrc1xkdElQ
	 VAl85G6bYUcNQ==
Date: Mon, 28 Jul 2025 13:01:55 +0100
From: Simon Horman <horms@kernel.org>
To: fan.yu9@zte.com.cn
Cc: xiyou.wangcong@gmail.com, dumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, jiri@resnulli.us,
	jhs@mojatatu.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn, tu.qiang35@zte.com.cn,
	jiang.kun2@zte.com.cn, wang.yaxin@zte.com.cn, qiu.yutan@zte.com.cn,
	he.peilin@zte.com.cn
Subject: Re: [PATCH net-next] net/sched: Add precise drop reason for
 pfifo_fast queue overflows
Message-ID: <20250728120155.GB1367887@horms.kernel.org>
References: <aIO+CKQ/kvpX5lMo@pop-os.localdomain>
 <202507281711372379BW_PL4oZvcBoW5Xti7yO@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507281711372379BW_PL4oZvcBoW5Xti7yO@zte.com.cn>

On Mon, Jul 28, 2025 at 05:11:37PM +0800, fan.yu9@zte.com.cn wrote:
> > BTW, it seems net-next is closed, you may need to resend it after it is> re-open.>> Thanks.
> 
> Hi Cong,  
> Thank you for your review and the feedback!
> Could you kindly share how to track the status of the net-next merge window?
> Should I monitor the linux-netdev mailing list for announcements, or is there a specific schedule I can follow? 

Hi,

The merge-window opens when a new version of the Kernel is released, in
this case v6.16 was released yesterday. It remains open until the
subsequent rc1 release is made, in this case that will be v6.17-rc1. That
is typically two weeks after the merge-window opens.

You can observe the current Kernel release in a variety of ways,
including visiting https://www.kernel.org/

The timing of the merge window can be predicted with some accuracy by
following kernel rc releases: it usually occurs 1 week after an rc7
release. (If not, an rc8 release occurs, and the merge window will likely
open a week after that; and so on.)


net-next closes around the time that the merge-window opens.
But there is some variance in exactly when this occurs, due
to the schedules of the maintainers.

net-next re-opens around the time that the merge-window closes.
But again there is some variance.

The opening and closing of net-next is announced, with [ANN] in
the subject on the netdev mailing list.

https://lore.kernel.org/netdev/?q=ANN


There is some more information on this topic here:
https://docs.kernel.org/process/maintainer-netdev.html#development-cycle

