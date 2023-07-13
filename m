Return-Path: <netdev+bounces-17642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82A7527ED
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA21C20A0C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784981F175;
	Thu, 13 Jul 2023 16:02:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2A1ED55
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ADEC433C7;
	Thu, 13 Jul 2023 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689264155;
	bh=cM/w8DteIuiCvz+ZdOohIJG9HbMzhPuzehxZjaExPPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IHk2BQIPyuKXc0oD1dqRMspUjGJMk/7mHCtXHU+bXtN4XIqwPOFmHnb6/vIcA6N06
	 c2FsW26g3Qo7Cte81e/mf5NBDtGJ0FTRLR1SdhmkeCZLlTMT+1BDAoMJkfsNYqa//4
	 R5ZltZMOYzASVflX4s2vSTbRSTE2TVYiXDyAhAU4zmlTJms01Djb/5eJBhrapfGJO+
	 8WHgrXBSQ2GRbXL4hd/vUpR4PxpsDEzWQHVjPnoqFOtK3e+yjUJAihwbz2bnQ0KQkF
	 bxrvs8SRpC8kpjYwV8GGUWz6wlhLcdkhSoZig1xJDrZgmDS/Fy6JLtZxtZpR+eGBir
	 fpuuOakfcAeMg==
Date: Thu, 13 Jul 2023 09:02:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 chuck.lever@oracle.com
Subject: Re: [PATCH net-next 1/2 v2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Message-ID: <20230713090234.28b04145@kernel.org>
In-Reply-To: <20230713090550.132858-2-arkadiusz.kubalewski@intel.com>
References: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
	<20230713090550.132858-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 11:05:49 +0200 Arkadiusz Kubalewski wrote:
> -        i = attr_spec.get('value-start', 0)
>          if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
>              value = set()
>              while raw:
>                  if raw & 1:
> -                    value.add(enum.entries_by_val[i].name)
> +                    value.add(enum.entries_by_val[raw & 1].name)
>                  raw >>= 1
> -                i += 1

This doesn't make sense, as I suggested you need to keep i for this
loop. Move it to the inside of the if 'enum-as-fla... and init to 0.

i is tracking which bit number we are at as we consume / shift out
bits from raw.

Have you ever used ChatGPT? No shame, just curious.
-- 
pw-bot: cr

