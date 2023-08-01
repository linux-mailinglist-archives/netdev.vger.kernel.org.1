Return-Path: <netdev+bounces-23397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67276BC6F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF3F1C21058
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953BA2514C;
	Tue,  1 Aug 2023 18:25:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A123BD0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801B4C433C7;
	Tue,  1 Aug 2023 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690914331;
	bh=MEGB0fvf8E6pcjZgn0TbRDSQ1Y9b9+JJUC9Ir1Z7aTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0JE0zTClBDnqIT4QdyHBdwSCMy9Cvl8XOiSelLFEQZasbnkOINid8BrObVLuOfVL
	 XzpAeP1WNB41DmKVBWqE8O/GCu5nUHaXdyWARdUPq0p1aHvmChK85Y0vxR+K+YMo5J
	 682F81nr+VL/wEQWNnqSP7SUC48jTgN6PCkl0Iqx6umQrlALjF5SR9/8oRw9bkwlT/
	 hHXLXjhP1zpQItfMowtOgEHQ+HinyixeoaXRLdAj5JHESitsV67Mdfhb7jKpRcQZoQ
	 mBgLCSJ8inrFZTfk9DaDGcPzzVUpoUqnbA3qXkaTbhwBT6LY1gXXAHg/7MfOLSZo+Y
	 1UYjA/9SXeZuw==
Date: Tue, 1 Aug 2023 11:25:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next 1/8] ynl-gen-c.py: fix rendering of validate
 field
Message-ID: <20230801112530.277d3090@kernel.org>
In-Reply-To: <20230801141907.816280-2-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
	<20230801141907.816280-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Aug 2023 16:19:00 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> For split ops, do and dump has different value in validate field. Fix
> the rendering so for do op, only "strict" is filled out and for dump op,
> "strict" is prefixed by "dump-".
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/net/ynl/ynl-gen-c.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 650be9b8b693..1c36d0c935da 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -1988,9 +1988,17 @@ def print_kernel_op_table(family, cw):
>                  cw.block_start()
>                  members = [('cmd', op.enum_name)]
>                  if 'dont-validate' in op:
> +                    dont_validate = []
> +                    for x in op['dont-validate']:
> +                        if op_mode == 'do' and x == 'dump':
> +                            continue
> +                        if op_mode == "dump" and x == 'strict':
> +                            x = 'dump-' + x
> +                        dont_validate.append(x)
> +
>                      members.append(('validate',
>                                      ' | '.join([c_upper('genl-dont-validate-' + x)
> -                                                for x in op['dont-validate']])), )
> +                                                for x in dont_validate])), )
>                  name = c_lower(f"{family.name}-nl-{op_name}-{op_mode}it")
>                  if 'pre' in op[op_mode]:
>                      members.append((cb_names[op_mode]['pre'], c_lower(op[op_mode]['pre'])))

I was hoping we can delete GENL_DONT_VALIDATE_DUMP_STRICT
but there is one cmd (TIPC_NL_LINK_GET) which
sets GENL_DONT_VALIDATE_STRICT and nothing about the dump.

To express something like that we should add dump-strict as
an allowed flag explicitly rather than doing the auto-prepending
-- 
pw-bot: cr

