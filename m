Return-Path: <netdev+bounces-249358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E8D1725F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B887304A9A5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411C3254A9;
	Tue, 13 Jan 2026 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="N5GihdbJ"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE334E75D
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291282; cv=none; b=fccb9Sb/3kj+LHwSIEJhXcdA6OSQyzSqWBX2RRwL1KEkOWszGx7BXnIOQjM0UU4O49o3TWchAFNGqpw9SGx4vXCFI80SuWtZDiiBxUTBkqXDhIvEl9aFK4eeJ9LCaoetHibNeDCOH0ndUSMeUOOHDe+wRsmIDJdVe20gqRKpHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291282; c=relaxed/simple;
	bh=nbELtl/3QSzJr0m6sQSQcIZsvz75NiHd0YrLE568PJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FEP555fpxUFBSym4O41EPy1LH2XIwgxx9WRlEdm24H9L9fvE0/0ORsdB1/+TR4d42E7CslwF5iCxsNnjHHthj99/AZ316tDOGD3YHf1PHEB/4hZ/19N6q2KHPfMG7oo9WJYwpISuabEU0wS8sqEuWgopMaMtD8dkQG3I1hflGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=N5GihdbJ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=N5GihdbJkZ2n4C5L+wVpiOwzcaO7VmjF8M1IJ2bNGJ4jvbWI8MfJasOyScVgRYaAxt3u4O3IC3lVLPTJ6Vic8WIkcqIRUu81JF4Vh7HEIekEc4xL2fUl3PAquzOlwI7Fp7c6fciRYQQuTUt6EnFuYIzGG7E7JKMJCPqomUFcDGoCrpyIf63T48S0iL293ITu1DRxprehOKWM9QhtBO24y6PUMaiCd8v/Qk7RhIcX0aEqdhAvdrDfg4nzJBdys8VbBBTcHig+ZxsnM2WlD+o4yLQNo6x+ZBtQLYsflBy95UxiVdkAvmny6usMmzZtHEye+6Yej2UcHzA3uecmPa7+JQ==; s=purelymail2; d=purelymail.com; v=1; bh=nbELtl/3QSzJr0m6sQSQcIZsvz75NiHd0YrLE568PJA=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2037107046;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 13 Jan 2026 08:00:55 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
	(envelope-from <peter@korsgaard.com>)
	id 1vfZKg-00000007afI-2pk5;
	Tue, 13 Jan 2026 09:00:54 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org,  linux-usb@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Liu Junliang <liujunliang_ljl@163.com>
Subject: Re: [PATCH net-next] net: usb: dm9601: remove broken SR9700 support
In-Reply-To: <20260113063924.74464-1-enelsonmoore@gmail.com> (Ethan
	Nelson-Moore's message of "Mon, 12 Jan 2026 22:39:24 -0800")
References: <20260113063924.74464-1-enelsonmoore@gmail.com>
Date: Tue, 13 Jan 2026 09:00:54 +0100
Message-ID: <87zf6ix7pl.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

>>>>> "Ethan" == Ethan Nelson-Moore <enelsonmoore@gmail.com> writes:

 > The SR9700 chip sends more than one packet in a USB transaction,
 > like the DM962x chips can optionally do, but the dm9601 driver does not
 > support this mode, and the hardware does not have the DM962x
 > MODE_CTL register to disable it, so this driver drops packets on SR9700
 > devices. The sr9700 driver correctly handles receiving more than one
 > packet per transaction.

 > While the dm9601 driver could be improved to handle this, the easiest
 > way to fix this issue in the short term is to remove the SR9700 device
 > ID from the dm9601 driver so the sr9700 driver is always used. This
 > device ID should not have been in more than one driver to begin with.

 > The "Fixes" commit was chosen so that the patch is automatically
 > included in all kernels that have the sr9700 driver, even though the
 > issue affects dm9601.

 > Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET
 > SR9700Device Driver Support")
 > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

I do not have access to a SR9700 device (and haven't touched anything
dm9601 related for a long time), but the above sounds sensible, so:

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

