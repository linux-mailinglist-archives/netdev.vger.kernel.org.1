Return-Path: <netdev+bounces-189715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFFAB352D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF85A19E0119
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE69263892;
	Mon, 12 May 2025 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI5w3Zqe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A81187872
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047012; cv=none; b=QXdXbcU3F/WRZe18ZK2ilAtK7Vh0Yim9ZMpUYNtn6WH///VtzRIdA1x3cBApO35U8KOy6JCAPhuKGw0DDv5d2A5I377RKg58qib3OLuGL5ZuKagds6P9x305Kne1wp4cxg9FXhg5p3oswMqIiOGMlow5BGGIT3/GD8l0k8FjX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047012; c=relaxed/simple;
	bh=e+iHFFvbruofVMUiESNM5p87mXt4iKHPAlFggn2ZUrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO6hpxtXbDOMh154baYCpj7AuO2qeOxj0JZa6ArPiXfIEP2M07NTSSWovIkSD+FkI4OHpOKWwqxbNt9N75hvAoO8BezguzQmZrGkYIHUNzK5hnEkJKAcjjqqH4oI+B7/6hLcmCjuHd8FJBSFlLlVvTTrOaXuLP+uU1SH8AS1R4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI5w3Zqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954D8C4CEE7;
	Mon, 12 May 2025 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747047012;
	bh=e+iHFFvbruofVMUiESNM5p87mXt4iKHPAlFggn2ZUrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FI5w3Zqer+z3kX9ysloz9OmxlfTonSfnCVmT2AZ/SbEoelW6Xv1T5tBtiAmVVc+5W
	 7VNBec9726M2Bs2MhJ8cQJqRIVw5VHQHN7GHA1z5XCet5zZEqCB5Im89UrhU3aP8j7
	 C2CnoOYFeWiLWnDFJuPVjM0Pd7LeUhTBKXI7QKn6oIXzAfxmJ+B7dirsQpOXGlk9yB
	 SqhCyQB7RKJdun5Ya6cclqTaeEstzbaZcsfn01c8GPPHdrjDpg8fM78RU6LlS1iSCx
	 WtBGfEjbpYcyXrNQMYb6hSEZNNaKMEl0WxikNMUZ1XMpi6gV5qhk5X0nq3Giu7SayE
	 eSN2rzjCXfYbg==
Date: Mon, 12 May 2025 11:50:07 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, madhu.chittim@intel.com,
	Aleksandr.Loktionov@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, joshua.a.hay@intel.com, ahmed.zaki@intel.com
Subject: Re: [PATCH iwl-net] idpf: avoid mailbox timeout delays during reset
Message-ID: <20250512105007.GV3339421@horms.kernel.org>
References: <20250508184715.7631-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508184715.7631-1-emil.s.tantilov@intel.com>

On Thu, May 08, 2025 at 11:47:15AM -0700, Emil Tantilov wrote:
> Mailbox operations are not possible while the driver is in reset.
> Operations that require MBX exchange with the control plane will result
> in long delays if executed while a reset is in progress:
> 
> ethtool -L <inf> combined 8& echo 1 > /sys/class/net/<inf>/device/reset
> idpf 0000:83:00.0: HW reset detected
> idpf 0000:83:00.0: Device HW Reset initiated
> idpf 0000:83:00.0: Transaction timed-out (op:504 cookie:be00 vc_op:504 salt:be timeout:2000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:508 cookie:bf00 vc_op:508 salt:bf timeout:2000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:512 cookie:c000 vc_op:512 salt:c0 timeout:2000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:510 cookie:c100 vc_op:510 salt:c1 timeout:2000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:509 cookie:c200 vc_op:509 salt:c2 timeout:60000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:509 cookie:c300 vc_op:509 salt:c3 timeout:60000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:505 cookie:c400 vc_op:505 salt:c4 timeout:60000ms)
> idpf 0000:83:00.0: Failed to configure queues for vport 0, -62
> 
> Disable mailbox communication in case of a reset, unless it's done during
> a driver load, where the virtchnl operations are needed to configure the
> device.
> 
> Fixes: 8077c727561aa ("idpf: add controlq init and reset checks")
> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


