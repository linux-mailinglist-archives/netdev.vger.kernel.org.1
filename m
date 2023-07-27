Return-Path: <netdev+bounces-22040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835B765BD9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46442822B2
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FA51989B;
	Thu, 27 Jul 2023 19:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23327127
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24416C433C7;
	Thu, 27 Jul 2023 19:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690484723;
	bh=6n1hxKoAxhSd9tu71Hxc0S41CHLjqKNvtMKeTAZ6R/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g6PJqzWrhEPcKuV37iYS8a5YIJr7QXBRZXiVPqYqFl5aw4DcFjOZJeYu+WLbJcGJa
	 9dd3qa3OkGWQIakMdKm0V/tXeveiUY8WpHbBX0QC47yH05spVbs/sW6l/c/I9j3Rg6
	 AWlft3nrfzPtHSBDZrDnMlychYf99CfIEJ0CcVHQ9FpQfjEaeX+H7s/fIOOChL9CF5
	 FVmuXZlclIBNafvn0KdRALL2E6+YxXQyMBJ/RiBnY6AL1E+Q7YN3Mq6O7ZN0dSHpA5
	 dnYORXDLFq8AJFhmdV0hjqZ6pgrKrKPbliszbU47z0DJIO4wHxbLd6rrC6Xqtkujio
	 ccpFUCihcrZkA==
Date: Thu, 27 Jul 2023 12:05:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net] bnxt: don't handle XDP in netpoll
Message-ID: <20230727120522.392fe60b@kernel.org>
In-Reply-To: <CACKFLikZfjMnK3gwJ=xP8Hb3Bfu8CYa1NMGqHJj7ChcJTWwjmg@mail.gmail.com>
References: <20230727170505.1298325-1-kuba@kernel.org>
	<CACKFLikZfjMnK3gwJ=xP8Hb3Bfu8CYa1NMGqHJj7ChcJTWwjmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 11:52:10 -0700 Michael Chan wrote:
> These TX packet completions have already been counted in
> __bnxt_poll_work().  If we do nothing here, I think the TX ring will
> forever be out-of-sync with the completion ring.

I see...

Do you prefer adding a return value to tx_int() to tell
__bnxt_poll_work_done() whether the work has been done;
or to clear tx_pkts in the handler itself rather than
the caller?


