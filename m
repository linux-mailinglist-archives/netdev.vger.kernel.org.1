Return-Path: <netdev+bounces-129622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D30984C8D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 23:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63E71C20BCC
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 21:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173713CABC;
	Tue, 24 Sep 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MNGScPw5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0813AA31
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212179; cv=none; b=lpYsk46x3UQxUWn5T9CbJ8oBAorDVURjKIHmpP9M/MaoGClAkMFIbSjaSP7YZwe9OCcnA7JLrwgKrx8YknmYB8E1xAyeNKf/elWOQIqPPPMUv1dGihmkRDYyjTtju8MFToxoyqSljLVHgsL+/wK+8WSmncRM9TiHL11/r8pslRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212179; c=relaxed/simple;
	bh=hpxmhIs4fKSzep02/3hSvKTa+tYcPxooei4lTMawdQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2qIqfd9O8cwD5SpRaZ1qLadZNOp2tUzIvZQnMARRyqpuXQB9Zaub6w9nh6boIofm+xYXSp+wEurFF32fBySY/oQFUJQArueEYqsdR4FluwJREhlPQP4WUnj5FQwSItiz6W3YAKnTq+/CoNo2acRDodmR1DGhFRcfiMGeMfBXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MNGScPw5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-208e0a021cfso33280165ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727212177; x=1727816977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvi10htTRwsku5eDKHxkGSBGzDuBQAMC2x7T230TNcQ=;
        b=MNGScPw5411c8LIsvDckQfYZuBXOM+K7KUyGJOaT4m17p3aY2uKUP/93FM7vgTt+YN
         1+CYINdqzctqS+i105nbK4XnDGwKh3Psut3aUsLh9d/XyqleAg5QSsRR6Ngv7W4BbKcz
         3tBgWEsUbxB00OyQzo+W0+t7/SJBc5tY+ru8I3/K3K9fINc3jEIczSA/Rf7isgtm8/gT
         j7PTu3nqTrwe8M2nlmaSMGh5E9ZdMBZd48AAnlbBsHMQlpl/eOZmeT5xDqGHq3uvniDM
         9TMlsGZHjU4MB0XbKlTOWQbHYGQ1bsfE1nvDtZnGLflFLp3fAhUMJir/OdxMP0VwHu0Z
         G/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212177; x=1727816977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvi10htTRwsku5eDKHxkGSBGzDuBQAMC2x7T230TNcQ=;
        b=whPOmdLpWojIjAmKwwUga7kvZ4ZRnxSJr4neO0YC23YHwL1NugiqlDzekEfokCSLQN
         yzVV1YRFUWfMBKgYENxa4UzQxFPHP1NxqWT0VYbUUKuXAQOgsJwMKnqCACfaqN0Q8pP/
         GZpOeCx+RLfWxiGIn5REtulHDewW2tWcl+kocaqbu7ymPPUQR6b6HxMPk1w0Ir32M2WL
         hkJwv0FpMaMj/gVWMgVOsvYjyVfIUl/ObDEMDiA1ZBOPKcaGN5c90TupjxOEPNhl3x7C
         ar8xEkJBhaUkth0qEEP6IAhOErcLB9N6fG3qLpFK41e1suug6lmv/53WJZaS1fc835kO
         Vx0g==
X-Forwarded-Encrypted: i=1; AJvYcCWLaS+Mo9sNpqKuJcaSDX3Ydr51q8MM6NoSidr7u4poNQlXTvpnIFVa32h/hzK9hQU34iudcyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0uhviHNwA9oPzfa8GHVbqM0S4R9ukSFwXYuOZ/iMMAruKJ71
	d0Rt9PFeJvZ31jhxaAMgf40H9s6CxuPrQfzYbfgI5oKwy6MpO9nRARCD7HYUpt8=
X-Google-Smtp-Source: AGHT+IH3fDIW+mmLHCM91kmeHZ2EKz1hP33clsvTdfu3wSzCfU+MUEiYMOB1YSAuJizFDCnP6UeboA==
X-Received: by 2002:a05:6a21:b8b:b0:1be:c3c1:7be8 with SMTP id adf61e73a8af0-1d4d4b1998bmr582980637.26.1727212176541;
        Tue, 24 Sep 2024 14:09:36 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71afc8446fesm1581438b3a.64.2024.09.24.14.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:09:36 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:09:34 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igb: Do not bring the device up after non-fatal error
Message-ID: <ZvMqjkjbv9mURaJx@apollo.purestorage.com>
References: <20240923212218.116979-1-mkhalfella@purestorage.com>
 <2c272599-6b25-4c93-86fa-ecfd8df024c1@intel.com>
 <847a2c45-782d-4cac-9a53-83557393af80@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847a2c45-782d-4cac-9a53-83557393af80@intel.com>

On 2024-09-23 17:10:36 -0700, Jacob Keller wrote:
> 
> 
> On 9/23/2024 4:11 PM, Jacob Keller wrote:
> > 
> > 
> > On 9/23/2024 2:22 PM, Mohamed Khalfella wrote:
> >> Commit 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
> >> changed igb_io_error_detected() to ignore non-fatal pcie errors in order
> >> to avoid hung task that can happen when igb_down() is called multiple
> >> times. This caused an issue when processing transient non-fatal errors.
> >> igb_io_resume(), which is called after igb_io_error_detected(), assumes
> >> that device is brought down by igb_io_error_detected() if the interface
> >> is up. This resulted in panic with stacktrace below.
> >>
> >> [ T3256] igb 0000:09:00.0 haeth0: igb: haeth0 NIC Link is Down
> >> [  T292] pcieport 0000:00:1c.5: AER: Uncorrected (Non-Fatal) error received: 0000:09:00.0
> >> [  T292] igb 0000:09:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> >> [  T292] igb 0000:09:00.0:   device [8086:1537] error status/mask=00004000/00000000
> >> [  T292] igb 0000:09:00.0:    [14] CmpltTO [  200.105524,009][  T292] igb 0000:09:00.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
> >> [  T292] pcieport 0000:00:1c.5: AER: broadcast error_detected message
> >> [  T292] igb 0000:09:00.0: Non-correctable non-fatal error reported.
> >> [  T292] pcieport 0000:00:1c.5: AER: broadcast mmio_enabled message
> >> [  T292] pcieport 0000:00:1c.5: AER: broadcast resume message
> >> [  T292] ------------[ cut here ]------------
> >> [  T292] kernel BUG at net/core/dev.c:6539!
> >> [  T292] invalid opcode: 0000 [#1] PREEMPT SMP
> >> [  T292] RIP: 0010:napi_enable+0x37/0x40
> >> [  T292] Call Trace:
> >> [  T292]  <TASK>
> >> [  T292]  ? die+0x33/0x90
> >> [  T292]  ? do_trap+0xdc/0x110
> >> [  T292]  ? napi_enable+0x37/0x40
> >> [  T292]  ? do_error_trap+0x70/0xb0
> >> [  T292]  ? napi_enable+0x37/0x40
> >> [  T292]  ? napi_enable+0x37/0x40
> >> [  T292]  ? exc_invalid_op+0x4e/0x70
> >> [  T292]  ? napi_enable+0x37/0x40
> >> [  T292]  ? asm_exc_invalid_op+0x16/0x20
> >> [  T292]  ? napi_enable+0x37/0x40
> >> [  T292]  igb_up+0x41/0x150
> >> [  T292]  igb_io_resume+0x25/0x70
> >> [  T292]  report_resume+0x54/0x70
> >> [  T292]  ? report_frozen_detected+0x20/0x20
> >> [  T292]  pci_walk_bus+0x6c/0x90
> >> [  T292]  ? aer_print_port_info+0xa0/0xa0
> >> [  T292]  pcie_do_recovery+0x22f/0x380
> >> [  T292]  aer_process_err_devices+0x110/0x160
> >> [  T292]  aer_isr+0x1c1/0x1e0
> >> [  T292]  ? disable_irq_nosync+0x10/0x10
> >> [  T292]  irq_thread_fn+0x1a/0x60
> >> [  T292]  irq_thread+0xe3/0x1a0
> >> [  T292]  ? irq_set_affinity_notifier+0x120/0x120
> >> [  T292]  ? irq_affinity_notify+0x100/0x100
> >> [  T292]  kthread+0xe2/0x110
> >> [  T292]  ? kthread_complete_and_exit+0x20/0x20
> >> [  T292]  ret_from_fork+0x2d/0x50
> >> [  T292]  ? kthread_complete_and_exit+0x20/0x20
> >> [  T292]  ret_from_fork_asm+0x11/0x20
> >> [  T292]  </TASK>
> >>
> >> To fix this issue igb_io_resume() checks if the interface is running and
> >> the device is not down this means igb_io_error_detected() did not bring
> >> the device down and there is no need to bring it up.
> >>
> >> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >> Reviewed-by: Yuanyuan Zhong<yzhong@purestorage.com>
> >> Fixes: 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
> >> ---
> >>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> >> index 1ef4cb871452..8c6bc3db9a3d 100644
> >> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> >> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> >> @@ -9651,6 +9651,10 @@ static void igb_io_resume(struct pci_dev *pdev)
> >>  	struct igb_adapter *adapter = netdev_priv(netdev);
> >>  
> >>  	if (netif_running(netdev)) {
> >> +		if (!test_bit(__IGB_DOWN, &adapter->state)) {
> >> +			dev_info(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
> >> +			return;
> > 
> > I'm not sure this needs to be a dev_info.
> > 
> 
> I was thinking dev_dbg, because I don't really see why its relevant to
> inform the user we did nothing. Seems like its log spam to me.

Good point. I changed it to dev_dbg() in v2.

v2: https://lore.kernel.org/all/20240924210604.123175-1-mkhalfella@purestorage.com/

> 
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > 
> 

