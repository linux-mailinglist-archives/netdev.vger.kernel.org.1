Return-Path: <netdev+bounces-56552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81A580F571
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C65281DB8
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955397E785;
	Tue, 12 Dec 2023 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfccAbTl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713117E783
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A32C433C7;
	Tue, 12 Dec 2023 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702405385;
	bh=uCBGOxwQmDbDUaJRetPxqIoUG3iao+4boB61ae9MrbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AfccAbTlLY/jvEOi2N3unL2x/pV+T1rSEVJ4T6n2pRgpiY5eGQumcMvCDwWNSVv2P
	 pO4ql3SyGZJ/ePLK18FplKmsohGHYOJbmDsU6I0KipvWwKs6wyGeemL+OydqurP2DI
	 3F+6meNb4zJe7R2j+dJkU5jp7OaMEcZuMxGrrf4fX1vclAMc66IYUbhE1YLjsRVRDc
	 LHjiJvGQtBxcc771Lr+wzfsXxgoTTpLIX53YsmF3RPhR05YhTC+P5T4NBkFIy8zBKS
	 RWyW4277N+QLgXAz064reLVML7WZQYlCxe0mXBg5PhckOX5h+G39VvznYK80HVy9+V
	 SLpWU7yXmB2CA==
Date: Tue, 12 Dec 2023 10:23:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: 3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] atm: solos-pci: Fix potential deadlock on
 &cli_queue_lock
Message-ID: <20231212102304.4f37c828@kernel.org>
In-Reply-To: <20231207123437.42669-1-dg573847474@gmail.com>
References: <20231207123437.42669-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Dec 2023 12:34:37 +0000 Chengfeng Ye wrote:
> As &card->cli_queue_lock is acquired under softirq context along the
> following call chain from solos_bh(), other acquisition of the same
> lock inside process context should disable at least bh to avoid double
> lock.

These appear to have been applied to net, thanks!

