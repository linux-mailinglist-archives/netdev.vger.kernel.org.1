Return-Path: <netdev+bounces-59243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E122581A0B2
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE521C22912
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA6037D0A;
	Wed, 20 Dec 2023 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTzf0ap7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EFD38DE3
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 14:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EDCC433C8;
	Wed, 20 Dec 2023 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703081206;
	bh=SpCJMDeCD4HcYyrbVLA99GfUPdLi6W145asKWtGiHLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTzf0ap7hqC1j6y7Vgy7MnGAbNMIP4MnuuyMCchI5tfqdPru2AJrqYyZEZmhNYym6
	 chQHop0N3jC3PEPCT1xGY77k1RzQNVNGyJWG7GYa2T5Bvzbz+Ia8D5oldgA6rRjehY
	 tRynVWabzRhWqiRJMavYpTXwkn4beRyzyslVwasfaAx2DkUjCSPVEwXa4qEXSgFO0n
	 uEcU57zBeqqU1/tIXiaoCPz5kbBvyGY8zp+qxVrGHMXo/PyKcd6/cFgdPcy2UPXuUh
	 adZve6lKFNaZmFGf8FRsIqYUZg5K7q1t+FN6uiLMFCQpVWejTk/3wG5zMrKWnyy5Yz
	 e5V6KCPAVyAjw==
Date: Wed, 20 Dec 2023 15:06:40 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Mendes <dmendes@redhat.com>,
	Florian Westphal <fw@strlen.de>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] kselftest: rtnetlink.sh: use grep_fail when
 expecting the cmd fail
Message-ID: <20231220140640.GG882741@kernel.org>
References: <20231219065737.1725120-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219065737.1725120-1-liuhangbin@gmail.com>

On Tue, Dec 19, 2023 at 02:57:37PM +0800, Hangbin Liu wrote:
> run_cmd_grep_fail should be used when expecting the cmd fail, or the ret
> will be set to 1, and the total test return 1 when exiting. This would cause
> the result report to fail if run via run_kselftest.sh.
> 
> Before fix:
>  # ./rtnetlink.sh -t kci_test_addrlft
>  PASS: preferred_lft addresses have expired
>  # echo $?
>  1
> 
> After fix:
>  # ./rtnetlink.sh -t kci_test_addrlft
>  PASS: preferred_lft addresses have expired
>  # echo $?
>  0
> 
> Fixes: 9c2a19f71515 ("kselftest: rtnetlink.sh: add verbose flag")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks,

I agree that this corrects inverted logic wrt setting
the global 'ret' value and in turn the exit value of the script.

I also agree that the problem was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

