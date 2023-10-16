Return-Path: <netdev+bounces-41551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA67CB4A7
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF4528174F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42DF262A1;
	Mon, 16 Oct 2023 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96D381A9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:33:02 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAAA9B;
	Mon, 16 Oct 2023 13:33:00 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qsUGl-0002pi-1W; Mon, 16 Oct 2023 22:32:55 +0200
Date: Mon, 16 Oct 2023 22:32:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [net-next PATCH] net: skb_find_text: Ignore patterns extending
 past 'to'
Message-ID: <20231016203255.GB10271@breakpoint.cc>
References: <20231013195113.3663-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013195113.3663-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Phil Sutter <phil@nwl.cc> wrote:
> Assume that caller's 'to' offset really represents an upper boundary for
> the pattern search, so patterns extending past this offset are to be
> rejected.
> 
> The old behaviour also was kind of inconsistent when it comes to
> fragmentation (or otherwise non-linear skbs): If the pattern started in
> between 'to' and 'from' offsets but extended to the next fragment, it
> was not found if 'to' offset was still within the current fragment.
> 
> Test the new behaviour in a kselftest using iptables' string match.
> 
> Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Fixes: f72b948dcbb85 ("[NET]: skb_find_text ignores to argument")

FYI, checkpatch complains about the fixes tag.

> diff --git a/tools/testing/selftests/netfilter/xt_string.sh b/tools/testing/selftests/netfilter/xt_string.sh
> new file mode 100755
> index 0000000000000..1802653a47287
> --- /dev/null
> +++ b/tools/testing/selftests/netfilter/xt_string.sh

Thanks for the test case. Is there a reason why its not hooked
up to the kselftest makefile?

I think it should be.

