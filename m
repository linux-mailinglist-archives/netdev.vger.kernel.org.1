Return-Path: <netdev+bounces-163330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B6A29EEA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3601E18890D5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161EE13AD1C;
	Thu,  6 Feb 2025 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/NVjRFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD655136358;
	Thu,  6 Feb 2025 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809801; cv=none; b=r9BQElYj3shGV28v3hsAPttKeJ6+gbjSmKserICo+S5i05im74jrvD28CUDOZYlHP0KdlgXmwaNJ7ipbmpGDzV5X8LW7SXqQfoe2go5M8B+V3fz811arNKDS710hlmzZHSP9SHXO92B9hvudeP+sNnaGz8LNCF2JnNLaIJ/9i2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809801; c=relaxed/simple;
	bh=ZEZDfgRcu52nvjxYE1DABkW3ziDj/VmxqBcRU7+YjN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPsLN5nbmipqJjV6nhceG3mQazCjsIM9ZFe/nHSfE/3FC0YLNXNd46lEA984AYDSB6lCuKn4thW/xl6vR0k6LFQ3YoiwnzOGYMavjUssZl7juB8S4RCWpvjaF02L8EWPCbQKURqA/aMD/SSPvS9GH7jICVCpTBdOJZ1Qzx7NZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/NVjRFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0706C4CED1;
	Thu,  6 Feb 2025 02:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738809800;
	bh=ZEZDfgRcu52nvjxYE1DABkW3ziDj/VmxqBcRU7+YjN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/NVjRFwwIeAlxAKwgqOQTxrjZ4HeZLqVBqnX+eAs1OFPx6mnpNOSMc6ulQMtg6IR
	 +FbqmzDG9jAUQhZ1pADXN/+Satl6CiXL7KHkE2uCYxYVRTWaoOKlvCMA7BgfgCNE52
	 oF0B7OZbfVdVdTf4V/a6IMH0w7DuV2iCVdnZC6JiRl9D+GBpWlLAueaPmws1v9Ss5w
	 fb6hj9GpxF9MHcsfLtX699hTovKmsPG+9wrI5ZCUu2Gb8vJFRNkZtMBHMk9BIV2/QE
	 ETgh5zQ/sF67roxw7wd3EKFD7C6k+Icdou0sd7y+SW4ytFVqjyZButdy2EqxQQX/51
	 RQFnxIl6g1RSQ==
Date: Wed, 5 Feb 2025 18:43:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Long Li
 <longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 2/2] hv_netvsc: Use VF's tso_max_size value when data
 path is VF
Message-ID: <20250205184319.360d2ca0@kernel.org>
In-Reply-To: <1738729316-25922-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1738729257-25510-1-git-send-email-shradhagupta@linux.microsoft.com>
	<1738729316-25922-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 20:21:55 -0800 Shradha Gupta wrote:
> Therefore, we use netif_set_tso_max_size() to set max segment size

I think the term "segment" is used incorrectly throughout the patch ?
Isn't the right term "superframe", "aggregate" or some such ?
-- 
pw-bot: cr

