Return-Path: <netdev+bounces-250431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 04243D2B208
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AF37300E8EE
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F99C335BBB;
	Fri, 16 Jan 2026 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0+Bixvr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C842313E08
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536243; cv=none; b=tQXCxnxfF2GSFMpwJ7v7oRZ7vx4Cp/tXKhTnWEntRePcIarpub6URTKgYsEsnWb+jOCnlgoRuJ9fru12qMHPySwFsN+9KAUMXKWbZG9d3Nq/ixcPK9hK6+vmK/7v4SiaAhjbP2M77dkiJVgjtL33tNMzv60A7fICMApKfxoVNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536243; c=relaxed/simple;
	bh=wUqf59FZkC4PEctXpuk3cUNpM9MlGvBuLzUN4hrHl9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkryBxh3lOY/BLrB3z+PbCKoA3A/nfJ0BqdRCQxOdqILDQ6n+2+ufqW+CxSvUUmw1JH+Z7TDUZ5cWvTkeKgUnsRYH10CVKf0yqQJsWAqC60AuaQ0KMyXoMtoqejLPetnr8O294j9lIjsw6ZTcGvfk4H8pF47mijQrytauwsdnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0+Bixvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB86C116C6;
	Fri, 16 Jan 2026 04:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536242;
	bh=wUqf59FZkC4PEctXpuk3cUNpM9MlGvBuLzUN4hrHl9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B0+BixvrQjSfKbkK6zBRoGjt86kXUpMRMqZeoCu4c5QpZLrzpKOLWDdif0c5EsVq6
	 ytCrQeifl2gLqQp6KMkzyFJL5oRkg28Cl7BmlF4shCMFtLFDQeng3eg8+sbmyBLIzk
	 mkX0h9f0DP5MWoPYFxTspEhVMn9FDkHYCESGMc9/4ZiI8f38ksn0qFcorMpUDOrlSM
	 /ULPCudi6mlqlRP/qQFzjB4aXRSpN3heo1RsG2WV2evCRCdu04X6Bfk2TQhpq1is1x
	 mrSTQgANmv1frDVt9BWnOxkPjJqaYxrcXn0D94SkCGJIfvCHEkee+0gUPzWYVsRu61
	 lCMQ3n6iPASOg==
Date: Thu, 15 Jan 2026 20:04:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
 Vishal Badole <Vishal.Badole@amd.com>
Subject: Re: [PATCH net-next v3] xgbe: Use netlink extack to report errors
 to ethtool
Message-ID: <20260115200401.71dddc86@kernel.org>
In-Reply-To: <20260114080357.1778132-1-Raju.Rangoju@amd.com>
References: <20260114080357.1778132-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 13:33:57 +0530 Raju Rangoju wrote:
> From: Vishal Badole <Vishal.Badole@amd.com>
> 
> Upgrade XGBE driver to report errors via netlink extack instead
> of netdev_error so ethtool userspace can be aware of failures.

Please have another read of:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
we ask for a 24h between version so that situation like what we had
here where Vadim acked v2 when v3 was on the list already do not happen.
-- 
pv-bot: 24h

