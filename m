Return-Path: <netdev+bounces-168866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4446CA41201
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 23:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FCD189380E
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FCF15746E;
	Sun, 23 Feb 2025 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irodU3KO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A621804A;
	Sun, 23 Feb 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740349037; cv=none; b=gGNfX7vJE77zyDlH5L8FDMQzN0LYE7zPwdKDFmOSaDu0UTKjAHCs+J9LqBjDXIkkfdqcQaXbS+fh6eU7G90tymn//VV7PhqA6Z+DRKKRe6ZcN1FVj9eDrLjI3HQLq1byL1HOhtWu4RS4Jy3GqdtVcQTuPWQpjayH8z+jcmGvAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740349037; c=relaxed/simple;
	bh=9bL/hNqAXKBz1zAhIeNb/hVycnTaqKHOdQWTKZfYha8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNZ81OBypuZjujQuwXN4OosmyfOyX1egMR+J0UpeIzKs4CcS6MRR2bTCEv5bfKYd80fGCy3l8peL/o2+ynaR1WeA2xmTC1PjnNLkurA4cEpt0YQfZZRcIbjI3D7kS3aoF6CElalIvkhIszqc9dsIM8EAvBoaNbL3TnKphFRMYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irodU3KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235F0C4CEDD;
	Sun, 23 Feb 2025 22:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740349036;
	bh=9bL/hNqAXKBz1zAhIeNb/hVycnTaqKHOdQWTKZfYha8=;
	h=From:To:Cc:Subject:Date:From;
	b=irodU3KO+15KNqa+f4QHCEssjq305N3d7Wwj6uFhNXWPmcXQ95dR0EpPD4Ng4HQRw
	 yKxM7JOEYIs7yL0Bvf/APokBkm1bquT2M45DHk4t5ynEw/zp4AC8OJE+oYFqUiRJUu
	 hzXuLBjBnyMjCDladscPWMS4Gg9N7LtZWgeTvyAtTiOtmYsWhJTW0hszHeMgHL0j9S
	 2muv7WIWv3I7/7TYW84jhmxih2iNFTlcMnMCD1xth88u2xO+x/zaT1evTc4EYsQBKj
	 o7rzTOzG1fMsUOpd9jbhU/mNcvPgs5hdl7yxBIBFcEb19fdpMUvTnv44fFZ7zJK48k
	 iGquL07EzECow==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	netdev@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net v2] net: Handle napi_schedule() calls from non-interrupt
Date: Sun, 23 Feb 2025 23:17:08 +0100
Message-ID: <20250223221708.27130-1-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_schedule() is expected to be called either:

* From an interrupt, where raised softirqs are handled on IRQ exit

* From a softirq disabled section, where raised softirqs are handled on
  the next call to local_bh_enable().

* From a softirq handler, where raised softirqs are handled on the next
  round in do_softirq(), or further deferred to a dedicated kthread.

Other bare tasks context may end up ignoring the raised NET_RX vector
until the next random softirq handling opportunity, which may not
happen before a while if the CPU goes idle afterwards with the tick
stopped.

Such "misuses" have been detected on several places thanks to messages
of the kind:

	"NOHZ tick-stop error: local softirq work is pending, handler #08!!!"

For example:

       __raise_softirq_irqoff
        __napi_schedule
        rtl8152_runtime_resume.isra.0
        rtl8152_resume
        usb_resume_interface.isra.0
        usb_resume_both
        __rpm_callback
        rpm_callback
        rpm_resume
        __pm_runtime_resume
        usb_autoresume_device
        usb_remote_wakeup
        hub_event
        process_one_work
        worker_thread
        kthread
        ret_from_fork
        ret_from_fork_asm

And also:

* drivers/net/usb/r8152.c::rtl_work_func_t
* drivers/net/netdevsim/netdev.c::nsim_start_xmit

There is a long history of issues of this kind:

	019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
	330068589389 ("idpf: disable local BH when scheduling napi for marker packets")
	e3d5d70cb483 ("net: lan78xx: fix "softirq work is pending" error")
	e55c27ed9ccf ("mt76: mt7615: add missing bh-disable around rx napi schedule")
	c0182aa98570 ("mt76: mt7915: add missing bh-disable around tx napi enable/schedule")
	970be1dff26d ("mt76: disable BH around napi_schedule() calls")
	019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
	30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finish(): add new  function to be called from threaded interrupt")
	e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schdule()")
	83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule")
	bd4ce941c8d5 ("mlx4: Invoke softirqs after napi_reschedule")
	8cf699ec849f ("mlx4: do not call napi_schedule() without care")
	ec13ee80145c ("virtio_net: invoke softirqs after __napi_schedule")

This shows that relying on the caller to arrange a proper context for
the softirqs to be handled while calling napi_schedule() is very fragile
and error prone. Also fixing them can also prove challenging if the
caller may be called from different kinds of contexts.

Therefore fix this from napi_schedule() itself with waking up ksoftirqd
when softirqs are raised from task contexts.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Francois Romieu <romieu@fr.zoreil.com>
Closes: https://lore.kernel.org/lkml/354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de/
Cc: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 80e415ccf2c8..5c1b93a3f50a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4693,7 +4693,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	 * we have to raise NET_RX_SOFTIRQ.
 	 */
 	if (!sd->in_net_rx_action)
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		raise_softirq_irqoff(NET_RX_SOFTIRQ);
 }
 
 #ifdef CONFIG_RPS
-- 
2.48.1


