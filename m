Return-Path: <netdev+bounces-37714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025937B6B8C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AE3E12816B7
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F1328B7;
	Tue,  3 Oct 2023 14:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51412940B
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63763C433C8;
	Tue,  3 Oct 2023 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696343381;
	bh=+eDfQ7/6kHNRVZ6hqrZ8rATomwjuzLC03PEvxIcNHZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S14nDzhe0DYFyKj9wXcbpNikorK8WZn9MtBGWUiU5Z+/HrjF6icVssPZ+lFINAEUq
	 c45BKiMvWJ47WcnoYp8WnniaIYYdIr8EwiY7MCwUMdOxoLLJ9GtT4yKMeTtYKOOgdT
	 j0TM94nPvplAaXqFFu8NJRgLY9gxZEKZayrbF3JT0JAysNqoBU/oF+w9AFO52kHcnA
	 KAJG9TNO79S8GElN58gIY8nvYRR5KJ/MFz4647pOqqcIH703E8yYZGB1roofTvl3K3
	 /d1EleE3XcWA7/seGX740rwSmU6tZMx1TahXFFXzULvVHgZ4Pgt4hthh22q27xzPBM
	 rhTdEvIHhFZ0A==
Message-ID: <9c4b954f-fa3c-7818-ef01-16eae542cd53@kernel.org>
Date: Tue, 3 Oct 2023 08:29:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/4] tcp_metrics: optimize
 tcp_metrics_flush_all()
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230922220356.3739090-1-edumazet@google.com>
 <20230922220356.3739090-5-edumazet@google.com>
 <e7a1d01a-6607-fa6f-33f8-db31a3fb75a8@kernel.org>
 <e6bda1486e3787b6aeac4024d30df97910366028.camel@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e6bda1486e3787b6aeac4024d30df97910366028.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/23 2:04 AM, Paolo Abeni wrote:
>> I have found cond_resched() can occur some unnecessary overhead if
>> called too often. Wrap in `if (need_resched)`?
> 
> Interesting. I could not find any significant overhead with code
> inspection - it should be a matter of 2 conditionals instead of one -
> Any idea why?

I would need to go through the ftrace output. I think it is really use
case dependent and for this one and the way tcp_metrics_nl_cmd_del is
called just cond_resched is ok.


