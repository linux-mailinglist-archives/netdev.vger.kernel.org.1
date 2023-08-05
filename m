Return-Path: <netdev+bounces-24636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E1E770E54
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB4428103E
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA665393;
	Sat,  5 Aug 2023 07:20:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3116FD7
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F28C433C8;
	Sat,  5 Aug 2023 07:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691220031;
	bh=E1PIlbTFJQA9r8kekwxzd4Owvg+EkNadytJeWZUkZas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6x+GH4JVHu3NfBx98nzpH5KaTHoKAGe9i17fBJCfMQPltV9zI/M3+4dVzWPkzIjI
	 XxU7OHvQ7Jhkk76o+VOAKUJjS7880peRkl7garYOGyHxYODI8fLMpDK+5+GtRERtye
	 kZeemqY6qXQlqbZQYmWIXWEoi1izMaK1bzzoEbDzFJ6Km8PitW+Vjd0uQ8Qt4ThdZU
	 zH3XnAwBD5UQvpJXBFMYk+KqRXWniiNtaYULO6PHPs2yfxvLb0DAxW28o+BgKFhO/w
	 0u1uKM7iooM50OUa1oVgHwcynrfxYJMRlTsDel5wKT+qi4EGlruOCoxcAqR5toAyu2
	 HmclBcE/hwX9Q==
Date: Sat, 5 Aug 2023 09:20:28 +0200
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
	danymadden@us.ibm.com, tlfalcon@linux.ibm.com,
	bjking1@linux.ibm.com
Subject: Re: [PATCH net 5/5] ibmvnic: Ensure login failure recovery is safe
 from other resets
Message-ID: <ZM34PDnLW6Ubt4ML@vergenet.net>
References: <20230803202010.37149-1-nnac123@linux.ibm.com>
 <20230803202010.37149-5-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803202010.37149-5-nnac123@linux.ibm.com>

On Thu, Aug 03, 2023 at 03:20:10PM -0500, Nick Child wrote:
> If a login request fails, the recovery process should be protected
> against parallel resets. It is a known issue that freeing and
> registering CRQ's in quick succession can result in a failover CRQ from
> the VIOS. Processing a failover during login recovery is dangerous for
> two reasons:
>  1. This will result in two parallel initialization processes, this can
>  cause serious issues during login.
>  2. It is possible that the failover CRQ is received but never executed.
>  We get notified of a pending failover through a transport event CRQ.
>  The reset is not performed until a INIT CRQ request is received.
>  Previously, if CRQ init fails during login recovery, then the ibmvnic
>  irq is freed and the login process returned error. If failover_pending
>  is true (a transport event was received), then the ibmvnic device
>  would never be able to process the reset since it cannot receive the
>  CRQ_INIT request due to the irq being freed. This leaved the device
>  in a inoperable state.
> 
> Therefore, the login failure recovery process must be hardened against
> these possible issues. Possible failovers (due to quick CRQ free and
> init) must be avoided and any issues during re-initialization should be
> dealt with instead of being propagated up the stack. This logic is
> similar to that of ibmvnic_probe().
> 
> Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


