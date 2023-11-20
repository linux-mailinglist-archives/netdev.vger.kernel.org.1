Return-Path: <netdev+bounces-49315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874047F1A50
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DAA1F254F1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426FC22331;
	Mon, 20 Nov 2023 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3XwzmVc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDCB22330
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45543C433C8;
	Mon, 20 Nov 2023 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700501720;
	bh=qAqDABdLidiX3t3Zps3jWa2tM42jqufzz5C/5QP6aGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3XwzmVc9y70UG7QT3wq3leq2FynkAP6UeQk8vzDeolLzKUD2+CC8cJXlluva/I/x
	 Gd3HPbon2SeZJGo58a6XeWH/jwyO8JQ6OZ+9IswcjmEpJKHwLxlWjk8GevyBWFOzY8
	 8IBJ6uKxifLlOvz/nmmJ7vfxy2tnPGVslf1A5CDBwK/+dMU63QL1GjE02GzqKYuJe/
	 2snwSUPTQLkQRhM99sTS3MUgO2/jHJkpMFfxTLamS7I8qMdiCq2lp7jy/p+HqpHbVB
	 d59HX5x6rQPrHrCJi7lknUqU+wi+n+SA5XnAv+Fgiu1ber5HAS+QHkM+nMZCeIjXEz
	 MCUGVVbRUQ5cw==
Date: Mon, 20 Nov 2023 17:35:15 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 3/6] selftests: tc-testing: use netns delete
 from pyroute2
Message-ID: <20231120173515.GD245676@kernel.org>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
 <20231117171208.2066136-4-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117171208.2066136-4-pctammela@mojatatu.com>

On Fri, Nov 17, 2023 at 02:12:05PM -0300, Pedro Tammela wrote:
> When pyroute2 is available, use the native netns delete routine instead
> of calling iproute2 to do it. As forks are expensive with some kernel
> configs, minimize its usage to avoid kselftests timeouts.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

I have a suggestion for a follow up below, but this change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../testing/selftests/tc-testing/plugin-lib/nsPlugin.py  | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
> index 2b8cbfdf1083..920dcbedc395 100644
> --- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
> +++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
> @@ -64,7 +64,10 @@ class SubPlugin(TdcPlugin):
>          if self.args.verbose:
>              print('{}.post_case'.format(self.sub_class))
>  
> -        self._ns_destroy()
> +        if netlink == True:
> +            self._nl_ns_destroy()
> +        else:
> +            self._ns_destroy()

As an aside, I think it would to rename _ns_* to
_iproute2_ns_* or similar, to make the distinction with _nl_ns_* clearer.

>  
>      def post_suite(self, index):
>          if self.args.verbose:
> @@ -174,6 +177,10 @@ class SubPlugin(TdcPlugin):
>          '''
>          self._exec_cmd_batched('pre', self._ns_create_cmds())
>  
> +    def _nl_ns_destroy(self):
> +        ns = self.args.NAMES['NS']
> +        netns.remove(ns)
> +
>      def _ns_destroy_cmd(self):
>          return self._replace_keywords('netns delete {}'.format(self.args.NAMES['NS']))
>  
> -- 
> 2.40.1
> 

