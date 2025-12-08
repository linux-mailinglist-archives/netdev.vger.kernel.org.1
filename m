Return-Path: <netdev+bounces-244029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E41B4CADCE9
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 18:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D507C303B19A
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6732E266B6B;
	Mon,  8 Dec 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcPHdJUf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C9EEBA
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213580; cv=none; b=bYz7x/2ayAPFWsWADRxCmQ72SSZaeH82AL+t0hy3r0r1M0HaGc833Wq94nxTtvsrrWnQdoPZCeTyiVKlYDHL4XTHXGIXdkOfjtVOK3V08ScafSrWNKQ32WQTc8lCLxH/02w7fuMV4xv6xbPLOhx5gLjMkCw+tN2azQw8Y6wbTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213580; c=relaxed/simple;
	bh=dWzchTxm0gXG4RlOi7Dhq5Q2vQ/4gedqC/TCr7AWiHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBAA5KKdQhHAotOCIePEbBe8gBReD5OiyvU61d/AN9VBYi2Co6WlolIRY2cRXGnhlbSGc/UEvbag9wGJT2sqmnKCc4W3X0kAFLd/LXigPGTRkhM7hGg/nxIo/+M4igBs/duf2SXxneTpkff7tPluqXthdI4ukQ1FbOeOlbVQ4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcPHdJUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29736C4CEF1;
	Mon,  8 Dec 2025 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765213579;
	bh=dWzchTxm0gXG4RlOi7Dhq5Q2vQ/4gedqC/TCr7AWiHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcPHdJUfQr7hJvkc5ghVSJDY6wK+5RSdqCPoSFVaLO8uJagVSyPL/nOHYwgABXAqc
	 z0r9HW/cri9AFjN1p3jeR6ycPVt2MTqo4zbno+gOmqiDV+D9v8LfyWlUwCIpQY+EGX
	 e3et9mw9g23EjlpkRLLB7ULidWgrxcrrAyxn+qDoIHxtgB9IugYO1xJAXa7hf6cXOP
	 bbibPsqhsdCYJox/N2KFXlc6mKhqDuLcjKZBZN8Im3gbJ1FEUzQUSghzXweYW0jEMI
	 QAiHeUi3uRzHman0AQNOxMXI5A4Sw8z2HMDdNVWh19PM6XoYa+CnEX610nHotcKvL3
	 JER78OJO/QTHw==
Date: Mon, 8 Dec 2025 17:06:14 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>, kohei.enju@gmail.com
Subject: Re: [PATCH iwl-net v1] ixgbe: fix memory leaks in
 ixgbe_recovery_probe()
Message-ID: <aTcFhoH-z2btEKT-@horms.kernel.org>
References: <20251206155146.95857-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206155146.95857-1-enjuk@amazon.com>

On Sun, Dec 07, 2025 at 12:51:27AM +0900, Kohei Enju wrote:
> ixgbe_recovery_probe() does not free the following resources in its
> error path, unlike ixgbe_probe():
> - adapter->io_addr
> - adapter->jump_tables[0]
> - adapter->mac_table
> - adapter->rss_key
> - adapter->af_xdp_zc_qps
> 
> The leaked MMIO region can be observed in /proc/vmallocinfo, and the
> remaining leaks are reported by kmemleak.
> 
> Free these allocations and unmap the MMIO region on failure to avoid the
> leaks.
> 
> Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Hi,

It seems that ixgbe_recovery_probe()  is only called from ixgbe_probe().
And that ixgbe_probe() already has an unwind ladder for these resources.
So I would suggest using that rather than replicating it
in ixgbe_recovery_probe. That is, have ixgbe_probe() unwind when
ixgbe_recovery_probe returns an error.

Also, maybe I'm wrong, but it seems that hw->aci.lock
is initialised more than once if ixgbe_recovery_probe() is called.

...

