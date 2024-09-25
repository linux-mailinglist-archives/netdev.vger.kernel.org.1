Return-Path: <netdev+bounces-129818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9898664A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FC01F20F43
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA734D8BF;
	Wed, 25 Sep 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1b61+9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486E1D5ADC;
	Wed, 25 Sep 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289042; cv=none; b=lRkbScIW8z2ihGdNder3sNh4URyJTrcsEK28+HjT7OpPNaVkjxcCQfbN2Ym/MVwT8urNLfSoiDgQ8amxnT7sggEqWdyZ/BVr3oINDuXdIDDrIAY9Qsd6/PAo2WW0HgjzdxOCZJAF3M/tQhrQ+Na9/xQL/gFWAdx1s5OJ/bBw0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289042; c=relaxed/simple;
	bh=rCVfh1YcnQdRwRTGp5hSq3bNXJ39sMKutBAw1jlny9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbs2vaWhtEjwjzm0OJcKeNdS8d6VIDOQ+VUK1Ao7l9fuPGS/ITVtoZ0utrguoR9BjXeuT56yyFrwR3CdvhzpnvH3dSC04zMJpGC9R3dKLdi3SJGdlPjub1/fshhowWzcqTz/VP+vGGA+VlF2pMh+/eImzS0PhXgLBdkU8V/bcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1b61+9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A54C4CEC3;
	Wed, 25 Sep 2024 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727289041;
	bh=rCVfh1YcnQdRwRTGp5hSq3bNXJ39sMKutBAw1jlny9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1b61+9lBP1hv0l8LCCNmAdETPhM1Amw6RRUwFaWxRlZ/HZhCcaTulJ4YiqxrcXt6
	 kETQaFMixIBRCzStOBxfvJdRBJCW73swjJzKXcWcHt/1XDUx1zQxVdtH9ebq5BI49z
	 GxCQS9xJkmWY7s9i84S8lCMlYmCNZKoE7wNHJ2wXgEcQMAMDpLz1iSeHuT+VOxT4CT
	 n2JEGJlbnVd6bHw8dFYpNao/D2AIExLJEw3HSef/x3rLjBTcqyRFke4nRAEzF2mdcj
	 q9B8DC9ITKhkSJhYj27r3PQkMYvxqMqB3AEAKrFOK16Uag87i13XPHKQizMjm5JPBq
	 emquRfqSpi3QA==
Date: Wed, 25 Sep 2024 19:30:35 +0100
From: Simon Horman <horms@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Jeff Garzik <jgarzik@redhat.com>, Ying Hsu <yinghsu@chromium.org>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] igb: Do not bring the device up after non-fatal
 error
Message-ID: <20240925183035.GV4029621@kernel.org>
References: <20240924210604.123175-1-mkhalfella@purestorage.com>
 <20240924210604.123175-2-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924210604.123175-2-mkhalfella@purestorage.com>

On Tue, Sep 24, 2024 at 03:06:01PM -0600, Mohamed Khalfella wrote:
> Commit 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
> changed igb_io_error_detected() to ignore non-fatal pcie errors in order
> to avoid hung task that can happen when igb_down() is called multiple
> times. This caused an issue when processing transient non-fatal errors.
> igb_io_resume(), which is called after igb_io_error_detected(), assumes
> that device is brought down by igb_io_error_detected() if the interface
> is up. This resulted in panic with stacktrace below.
> 
> [ T3256] igb 0000:09:00.0 haeth0: igb: haeth0 NIC Link is Down
> [  T292] pcieport 0000:00:1c.5: AER: Uncorrected (Non-Fatal) error received: 0000:09:00.0
> [  T292] igb 0000:09:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> [  T292] igb 0000:09:00.0:   device [8086:1537] error status/mask=00004000/00000000
> [  T292] igb 0000:09:00.0:    [14] CmpltTO [  200.105524,009][  T292] igb 0000:09:00.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
> [  T292] pcieport 0000:00:1c.5: AER: broadcast error_detected message
> [  T292] igb 0000:09:00.0: Non-correctable non-fatal error reported.
> [  T292] pcieport 0000:00:1c.5: AER: broadcast mmio_enabled message
> [  T292] pcieport 0000:00:1c.5: AER: broadcast resume message
> [  T292] ------------[ cut here ]------------
> [  T292] kernel BUG at net/core/dev.c:6539!
> [  T292] invalid opcode: 0000 [#1] PREEMPT SMP
> [  T292] RIP: 0010:napi_enable+0x37/0x40
> [  T292] Call Trace:
> [  T292]  <TASK>
> [  T292]  ? die+0x33/0x90
> [  T292]  ? do_trap+0xdc/0x110
> [  T292]  ? napi_enable+0x37/0x40
> [  T292]  ? do_error_trap+0x70/0xb0
> [  T292]  ? napi_enable+0x37/0x40
> [  T292]  ? napi_enable+0x37/0x40
> [  T292]  ? exc_invalid_op+0x4e/0x70
> [  T292]  ? napi_enable+0x37/0x40
> [  T292]  ? asm_exc_invalid_op+0x16/0x20
> [  T292]  ? napi_enable+0x37/0x40
> [  T292]  igb_up+0x41/0x150
> [  T292]  igb_io_resume+0x25/0x70
> [  T292]  report_resume+0x54/0x70
> [  T292]  ? report_frozen_detected+0x20/0x20
> [  T292]  pci_walk_bus+0x6c/0x90
> [  T292]  ? aer_print_port_info+0xa0/0xa0
> [  T292]  pcie_do_recovery+0x22f/0x380
> [  T292]  aer_process_err_devices+0x110/0x160
> [  T292]  aer_isr+0x1c1/0x1e0
> [  T292]  ? disable_irq_nosync+0x10/0x10
> [  T292]  irq_thread_fn+0x1a/0x60
> [  T292]  irq_thread+0xe3/0x1a0
> [  T292]  ? irq_set_affinity_notifier+0x120/0x120
> [  T292]  ? irq_affinity_notify+0x100/0x100
> [  T292]  kthread+0xe2/0x110
> [  T292]  ? kthread_complete_and_exit+0x20/0x20
> [  T292]  ret_from_fork+0x2d/0x50
> [  T292]  ? kthread_complete_and_exit+0x20/0x20
> [  T292]  ret_from_fork_asm+0x11/0x20
> [  T292]  </TASK>
> 
> To fix this issue igb_io_resume() checks if the interface is running and
> the device is not down this means igb_io_error_detected() did not bring
> the device down and there is no need to bring it up.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Yuanyuan Zhong<yzhong@purestorage.com>
> Fixes: 004d25060c78 ("igb: Fix igb_down hung on surprise removal")

Thanks for the update, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

