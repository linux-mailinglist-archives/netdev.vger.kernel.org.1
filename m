Return-Path: <netdev+bounces-129398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBBC983A6A
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 01:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3E5283D7C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8202126C0B;
	Mon, 23 Sep 2024 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L+923LCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5B78C73
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133834; cv=none; b=olXoAwlxBFHoFmmu6gFOLX6dwMgS53OMhnUVCAITBh4odno61esY2FSpJVDfmB5oH7h0HFRvc0GZsUtDiiJ+lCABsVj+zCgGD+3S1zDr7eSULtW4uwEwxGMSRGMqXT0Tdwrk4YlXDmeO0lFIeB5OARdO0p0CFyoroW4FxcsitIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133834; c=relaxed/simple;
	bh=CSbh7KAAmzaXebCELC0EAqeScZ3JtmXqYJ9duXYuLmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6X1LOj2prL8caCQ9s/nj+Pnb+hyllGW//LwLHOWk/jbRUMKnvNDKlnIBnGK8eoPFIrg8KA3DXavOaIav0IzV3uCm2u8bMXsEUAeYYAMfwsflGk/22ciTz9l6tVrRmSGnbuRJsY1bfhVrrf1qAxDoMJfh/tI+JC3EkyYU/vPhfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L+923LCp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2068bee21d8so48783235ad.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727133832; x=1727738632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxBI093a9aSk/5D0mfkUxCMUyakEBiULYIO2uu3ziqo=;
        b=L+923LCpKifP+Zoq/Ufhg9+GBDPQTYu6MqwxrumJMFwqq31NiWehcOQ9lTcProVwcN
         BIfXlS1rHIThzvSIm3FOEAsqz/lBRKEx6vxO4PbOVaVI6LTakNnX22JQi99BzEku9VCU
         ukgTQxM8Tin/GAF3Xm7t0/qdHDHMsUnds5QGPYdBAB/o1hwnb32nfMWs0Hi75aCY/fqF
         50gulCamkOYWdSzvEuZdE1z/4+g2QLVyGrsmQg9lxzExuWoaTMwPEeVcVi19qO4wPq8b
         cJqNae3BMzXbXGgkvyDXgOMdoe7SiNoq6lwzZ4CbcJojFjXEs3A8TliJv0M1shGvr6LV
         DIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727133832; x=1727738632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxBI093a9aSk/5D0mfkUxCMUyakEBiULYIO2uu3ziqo=;
        b=p6F1vuiHIk5+oFkxQnNd4saMoi46o1HBPvfuJqvaMrvoRpqDyierN8DuJeVVytnkpW
         EftlC6l2ZoHl3GTm5NPdGp2X3rJO5UwWD2NZGsNsJCD8IM1CBP7vzEsJP4nZnENuKGlU
         wNkgBS2kUFuSeXmzcBA2vmVetXPk3QD2MmVVrkb6XxSrZjb21MVXOI9DJGDZlHvshrjX
         geKiyMEuDAqYt0WXSsXp6OglW7zscCDnsUc3tSeyxDsIxF3XBvfor7NvXrdwi9256iX8
         FA3WTCqCksb7mTobXjGyy42qiXmScvQg1yGcM2ModcCe7yfKSa5/hhUM8wQFCrrlCYAq
         ANLg==
X-Forwarded-Encrypted: i=1; AJvYcCUnf9eLnQM/+VTKfpgXAqVPV/XfMOcwnetH0va6GCUcoWlPMzVKNpgCQGscL6AcZmEV0arZPgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSY05cWoaHlDDr1GN0Q5z9tbxNQMAuL6Xk/HUovX7EV+LJBNx
	QCPpGL9BHkGzM93YTCcLq//TZTIPG8nI7mRew6m4DVCXqefdm7uYeanf2+oaDGU=
X-Google-Smtp-Source: AGHT+IHq2YU/Xc8NCHkA+s4BXEcmCGU4qgTn8nMgXddFujLsE47Qx4kZ/JFI5d6x9CTQvQRAlTki0A==
X-Received: by 2002:a17:902:d2c1:b0:1fc:4940:d3ad with SMTP id d9443c01a7336-208d856abcfmr184409775ad.59.1727133832010;
        Mon, 23 Sep 2024 16:23:52 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20af17e0332sm852765ad.163.2024.09.23.16.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 16:23:51 -0700 (PDT)
Date: Mon, 23 Sep 2024 16:23:50 -0700
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
Message-ID: <ZvH4hp0DJRoWj-gD@apollo.purestorage.com>
References: <20240923212218.116979-1-mkhalfella@purestorage.com>
 <2c272599-6b25-4c93-86fa-ecfd8df024c1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c272599-6b25-4c93-86fa-ecfd8df024c1@intel.com>

On 2024-09-23 16:11:14 -0700, Jacob Keller wrote:
> 
> 
> On 9/23/2024 2:22 PM, Mohamed Khalfella wrote:
> > Commit 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
> > changed igb_io_error_detected() to ignore non-fatal pcie errors in order
> > to avoid hung task that can happen when igb_down() is called multiple
> > times. This caused an issue when processing transient non-fatal errors.
> > igb_io_resume(), which is called after igb_io_error_detected(), assumes
> > that device is brought down by igb_io_error_detected() if the interface
> > is up. This resulted in panic with stacktrace below.
> > 
> > [ T3256] igb 0000:09:00.0 haeth0: igb: haeth0 NIC Link is Down
> > [  T292] pcieport 0000:00:1c.5: AER: Uncorrected (Non-Fatal) error received: 0000:09:00.0
> > [  T292] igb 0000:09:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [  T292] igb 0000:09:00.0:   device [8086:1537] error status/mask=00004000/00000000
> > [  T292] igb 0000:09:00.0:    [14] CmpltTO [  200.105524,009][  T292] igb 0000:09:00.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
> > [  T292] pcieport 0000:00:1c.5: AER: broadcast error_detected message
> > [  T292] igb 0000:09:00.0: Non-correctable non-fatal error reported.
> > [  T292] pcieport 0000:00:1c.5: AER: broadcast mmio_enabled message
> > [  T292] pcieport 0000:00:1c.5: AER: broadcast resume message
> > [  T292] ------------[ cut here ]------------
> > [  T292] kernel BUG at net/core/dev.c:6539!
> > [  T292] invalid opcode: 0000 [#1] PREEMPT SMP
> > [  T292] RIP: 0010:napi_enable+0x37/0x40
> > [  T292] Call Trace:
> > [  T292]  <TASK>
> > [  T292]  ? die+0x33/0x90
> > [  T292]  ? do_trap+0xdc/0x110
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  ? do_error_trap+0x70/0xb0
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  ? exc_invalid_op+0x4e/0x70
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  ? asm_exc_invalid_op+0x16/0x20
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  igb_up+0x41/0x150
> > [  T292]  igb_io_resume+0x25/0x70
> > [  T292]  report_resume+0x54/0x70
> > [  T292]  ? report_frozen_detected+0x20/0x20
> > [  T292]  pci_walk_bus+0x6c/0x90
> > [  T292]  ? aer_print_port_info+0xa0/0xa0
> > [  T292]  pcie_do_recovery+0x22f/0x380
> > [  T292]  aer_process_err_devices+0x110/0x160
> > [  T292]  aer_isr+0x1c1/0x1e0
> > [  T292]  ? disable_irq_nosync+0x10/0x10
> > [  T292]  irq_thread_fn+0x1a/0x60
> > [  T292]  irq_thread+0xe3/0x1a0
> > [  T292]  ? irq_set_affinity_notifier+0x120/0x120
> > [  T292]  ? irq_affinity_notify+0x100/0x100
> > [  T292]  kthread+0xe2/0x110
> > [  T292]  ? kthread_complete_and_exit+0x20/0x20
> > [  T292]  ret_from_fork+0x2d/0x50
> > [  T292]  ? kthread_complete_and_exit+0x20/0x20
> > [  T292]  ret_from_fork_asm+0x11/0x20
> > [  T292]  </TASK>
> > 
> > To fix this issue igb_io_resume() checks if the interface is running and
> > the device is not down this means igb_io_error_detected() did not bring
> > the device down and there is no need to bring it up.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Reviewed-by: Yuanyuan Zhong<yzhong@purestorage.com>
> > Fixes: 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 1ef4cb871452..8c6bc3db9a3d 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -9651,6 +9651,10 @@ static void igb_io_resume(struct pci_dev *pdev)
> >  	struct igb_adapter *adapter = netdev_priv(netdev);
> >  
> >  	if (netif_running(netdev)) {
> > +		if (!test_bit(__IGB_DOWN, &adapter->state)) {
> > +			dev_info(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
> > +			return;
> 
> I'm not sure this needs to be a dev_info.

I am okay with changing it to dev_warn() to match 004d25060c78 ("igb:
Fix igb_down hung on surprise removal"). Is that okay?

> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

