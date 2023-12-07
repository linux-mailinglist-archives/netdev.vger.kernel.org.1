Return-Path: <netdev+bounces-55097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF70F80955B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D829F1C20A80
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E556B7B;
	Thu,  7 Dec 2023 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVcdCUUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74257300
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 22:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB20C433C7;
	Thu,  7 Dec 2023 22:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701988264;
	bh=bZwkSALgAsVCXIZhgUhG9SoQisgL6tDqYzcUPfnqBNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZVcdCUUIpaJKmcxGg9aYzpQ6DzgoP+5+U2S0aNGryqXNAVW/WvnzJGQHMHvQLNzgS
	 bGzM0XZsJgLP3taXoan9GkW079iEmLYGj1wzlCoXePu6oRpydH+oGi25TidIsAY3FR
	 V+0w7swzVZ8ZyyQjNaoGzlRB9n4nn3ZlvClRbD99krJziidSvoTBZz9Fa30b86tSHU
	 sYV4hz6VlBoF3M6VBj2+kCTHOmgo25Xrh3WYIrvznqGHO1MlkYxfCQ4BLpLUL1kZmN
	 19JFwg3zJmpHxC6uaVDoUe31G+am3X22ibsYts7nr2niGLoJFtG2S8MtzoZpzRZDgy
	 QcWS01/WlcHoA==
Date: Thu, 7 Dec 2023 14:31:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net v2 3/4] bnxt_en: Fix wrong return value check in
 bnxt_close_nic()
Message-ID: <20231207143102.049820a2@kernel.org>
In-Reply-To: <CACKFLi=ZV42LZqAC6_cWtLfwURyzd6DW9-BQddbozkBSfr31kg@mail.gmail.com>
References: <20231207000551.138584-1-michael.chan@broadcom.com>
	<20231207000551.138584-4-michael.chan@broadcom.com>
	<20231207102718.4d930353@kernel.org>
	<CACKFLi=ZV42LZqAC6_cWtLfwURyzd6DW9-BQddbozkBSfr31kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 14:24:24 -0800 Michael Chan wrote:
> The code will always proceed to do the close when
> wait_event_interruptible_timeout() returns for any reason.  The check
> is just to log a warning message that the wait has timed out and we're
> closing anyway.
> 
> What I can do is to log another warning if the wait is interrupted by
> a signal.  Since we do the close no matter what, the error code should
> not be returned to the caller and the function should be changed to
> void.  Does that sound reasonable?

Yup!

