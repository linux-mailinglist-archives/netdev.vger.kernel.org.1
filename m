Return-Path: <netdev+bounces-14628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC5742BC4
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C59280352
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4141426E;
	Thu, 29 Jun 2023 18:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641581426A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E47C433C0;
	Thu, 29 Jun 2023 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688062369;
	bh=1YlFi3lJkf1dI7ciltNa3u64Irqp6lrbGDWCr08fqaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CAjUQxpF4h8hs7qvG4kYrTR9YeeIOSMSPxbG+Db8XJ/XOnMlub2XMypBr3+/hgi+2
	 kkTgG5cTSmBlIe7FSXzipHC9VM/veUGNht4yXzCSPjfKiz4Uoog+v1Ax0qbA81+c+t
	 sHn1Nq1xDK4JUJOrPcDbdvuLBqBffxmdfjnlY5Pzr/NTPt7PWT04jjVAR3pkL+57at
	 RIFq1gOVYje5y0gpLOCi47+V4AuNljtjxbbxSz65h9RJOAfsvosOAOAasEltSfa4H/
	 EGys05MS7WVqGLKjUDL0v1vBB7+R+ljEZ6v1Cku69AZynPSjKVFQfkJ9alms1W7fco
	 nOHLTFXeONAZA==
Date: Thu, 29 Jun 2023 11:12:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
Subject: Re: [PATCH v2 net] ibmvnic: Do not reset dql stats on NON_FATAL err
Message-ID: <20230629111245.712496cc@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20230628182244.23878-1-nnac123@linux.ibm.com>
References: <20230628182244.23878-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 13:22:44 -0500 Nick Child wrote:
> All ibmvnic resets, make a call to netdev_tx_reset_queue() when
> re-opening the device. netdev_tx_reset_queue() resets the num_queued
> and num_completed byte counters. These stats are used in Byte Queue
> Limit (BQL) algorithms. The difference between these two stats tracks
> the number of bytes currently sitting on the physical NIC. ibmvnic
> increases the number of queued bytes though calls to
> netdev_tx_sent_queue() in the drivers xmit function. When, VIOS reports
> that it is done transmitting bytes, the ibmvnic device increases the
> number of completed bytes through calls to netdev_tx_completed_queue().
> It is important to note that the driver batches its transmit calls and
> num_queued is increased every time that an skb is added to the next
> batch, not necessarily when the batch is sent to VIOS for transmission.

Applied, thanks!

