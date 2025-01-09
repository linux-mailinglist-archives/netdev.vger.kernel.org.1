Return-Path: <netdev+bounces-156841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D8CA07FCC
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF361671A8
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5819CC20;
	Thu,  9 Jan 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC3UI+6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDD19AD8D
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447344; cv=none; b=ro1wNwc/CM5gVbVGY7zt6BaV62QBnWYLphPPiR+BYHJiKfOWLsJ4WuY8TX/0z0071EbKfr0KEnrTYgVABPtMjzhVn354vZs4Z7LSTeDDrLBESrgfTLNujyLPO07j2yplmINdmubWaeRoqhgMkp51nRJOlwcDhJZuKQqSkKcNQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447344; c=relaxed/simple;
	bh=Z/+Mv4TEviEfrGhoLuSQYvswJxhVN8kCPvhxGrOIz0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYtuvqsbBZ26I2bI0BsvQEjiLgJEDl2cO7dip62I58i1gj51KW5Ulh/5CcW//8cXdqc57lKF6O2hXdQO28Yo6SEzV+mnIsGpT2MEVrD0artiF7j4qUA7GBeCCTLy4XNFkYEGT4hqeE3wngmMJD9En68j+pc+G3cO3gFCb/afi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC3UI+6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93620C4CED2;
	Thu,  9 Jan 2025 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736447344;
	bh=Z/+Mv4TEviEfrGhoLuSQYvswJxhVN8kCPvhxGrOIz0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VC3UI+6by1MeJuCyPcrj+q5rWVJ8IFuZjxTt6cyV2RCO81NJ1dCP5mXEOHfHsrL0y
	 E9Ilh8ViZUhTuFROQJZQNBHUTc1UPP1QxENrFt08AWXCRdiLTwew0B2diveyowwthp
	 eQhAa9MzDUIMiAbOKwY24i3D6/R1au/qQ08QAcDvMolZGl266cuQ1cmJXVDffCwEF+
	 oqMTvCdIC8H1zjKx6BXDBXI9anQkB9Ew9Pabz3kO/PmxMV5bRClRBD09MpZiYQFl0P
	 BUg9/DbRw2rJ2HKM/kMQ++GNPBR0b+WCKhjheYgqhgY9YkYrh85JWPakAPw09EyQ+i
	 2+kgtZIp0Y4Ig==
Date: Thu, 9 Jan 2025 10:29:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, security@kernel.org,
 nnamrec@gmail.com
Subject: Re: [PATCH net 1/1 v2] net: sched: Disallow replacing of child
 qdisc from one parent to another
Message-ID: <20250109102902.3fd9b57d@kernel.org>
In-Reply-To: <20250109143319.26433-1-jhs@mojatatu.com>
References: <20250109143319.26433-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 09:33:19 -0500 Jamal Hadi Salim wrote:
> Lion Ackermann was able to create a UAF which can be abused for privilege
> escalation with the following script

Also looks like this upsets tc-mq-visibility.sh :(
-- 
pw-bot: cr

