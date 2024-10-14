Return-Path: <netdev+bounces-135370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E099DA07
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3DA1F232BE
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E0158D87;
	Mon, 14 Oct 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts21/p3x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB920323;
	Mon, 14 Oct 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728947793; cv=none; b=eSIJdgZzZk0XtTXOoLwIZlJtShc06Op5/54CYgowaaMv8Nn4oSk9oUUa6Y64SlFKYQ8ApYMj2d2kzSZTQgYdhaKrBMeI/o5uaZCC94M+qaywzAtHUhZ7Iv6ZAx1M3K2x7mAmD7pddSO3lnaVoMTUmJ+0OuI/M3LoGtjUe1H8ubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728947793; c=relaxed/simple;
	bh=XsyRd9j07T8HoPKbHrQZGPgE/ewJ2mD/zTuF8VZMJx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c/BUzzKyz9LlqesD0kOlhBI3Qz3uWAjmHZEBLiIqzZJ7UD+EyL3s284d44yyAc7DZOFGEsRMZp4JrIMvogCIK5bXRwTp4BqdKoUNQFAbFT5SNWwvBjK3kYuXDB18D+De8XTZA1NQkpPXkv2JJOH7qziX425m80mYJutuzOUvkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts21/p3x; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e6f085715so858110b3a.2;
        Mon, 14 Oct 2024 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728947791; x=1729552591; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2B0FW8ZH5nWjEg/AXzAlnKbTbSdi9xuM3Vgwwr8KQQ=;
        b=Ts21/p3xtUe/yGgLhR5mdvWeEFdE16M98z5iWEhYriI1hTYOy8Vf6HmLjf4oo0hT7J
         qJT1UPvfJYrqFiMcapFtwOsSnkgrNY88UvShNKSrzMN6rr1CJ24jrDFQpXIxGhvMsTnK
         dvIIuF7OlaASwsydYm5sjBN6+uHRRJN7hRlAdTksaJYoBK/NZwkBZMzn3fh3YTYPpJB/
         NoGb/tk1Cfs7QFDlgTHoX1JuKqNjPNPwzyvV9uAnUcBieErLEuwOu76hucEEuQSF5vGr
         ViF0J2Ksx1uj3UHSQvOtYeeM5aqqgpMZvxebmhZI+9x7Qjkv3CUuFOeQBXAsmxzWcmdH
         WfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728947791; x=1729552591;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2B0FW8ZH5nWjEg/AXzAlnKbTbSdi9xuM3Vgwwr8KQQ=;
        b=IFlUN7O8yShBZuWJlBFGRXRy4yPHRiA4dAY0Sor2RleI8zjJhK6Vxg62JLz+JMo1x1
         mqYNAOu5yDika5iFIfhuQS6baSsI3+0xEAYsP5ojokTlwEtCeKQJtp9z9owdYbAWw6im
         RF/wtC2x8LIeipx2W/OMgpG/B0c+zfNaAFErMvA1YdHsYMWGCEFvORF3AHHxljr7SHZ8
         1mfpb+7BSpeL86hYyubWw93q09OKVplZxPHwuCp4FaOfbGh3ySIW45rcwbiA+reTKguk
         B/czxnqli0fmGnxpzWz0hvbNb6ZvgqikkK51fCyITlWLxY/XtdFdxoGloUWGDFFY8E1Y
         wzZg==
X-Forwarded-Encrypted: i=1; AJvYcCU1WsiwYBW2Wg5pJhSJDUe7NTknqtNdQOGQu0rM24ivSguT3CoJSTdqNf7NcXeGPQJCfC76bvsAvxhzWEE=@vger.kernel.org, AJvYcCURXRDMcYJeYTayb5NHYnbc2yhF/gD3r3o4i1YiWDIlekYDAsAuP3xxyvtqCHag2bddszqkr1FF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jL/LaU5o2WhBtY0VMQy+qeOdEe63nGk1FUbjJjDr2gu3uXA8
	7jHZBya76qZkGi6cCwM2Vb63CRrkFyUZ0y1xi0y00+Gdegc0jdho7vITWCEESZw=
X-Google-Smtp-Source: AGHT+IGIPxJJ9r2kB4BtcvYdvYR1x/+1ppYNz4QAE9m866VfOGdYSYuQYWDJmxVzEMp3VVIrPaFjEg==
X-Received: by 2002:a05:6a00:a93:b0:71e:b8:1930 with SMTP id d2e1a72fcca58-71e4c17bb0dmr16083237b3a.16.1728947790938;
        Mon, 14 Oct 2024 16:16:30 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:f281:80d8:4268:4a6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6c1948sm82872a12.27.2024.10.14.16.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 16:16:30 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:16:29 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] igb: Fix styling in enable/disable SR-IOV
Message-ID: <Zw2mTeDYEkWnh36A@Fantasy-Ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes the checks and warnings for igb_enable_sriov and
igb_disable_sriov function reported by checkpatch.pl

Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ef4cb871452..5a3b10b81848 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3703,10 +3703,10 @@ static int igb_disable_sriov(struct pci_dev *pdev, bool reinit)
 			dev_warn(&pdev->dev,
 				 "Cannot deallocate SR-IOV virtual functions while they are assigned - VFs will not be deallocated\n");
 			return -EPERM;
-		} else {
-			pci_disable_sriov(pdev);
-			msleep(500);
 		}
+
+		pci_disable_sriov(pdev);
+		msleep(500);
 		spin_lock_irqsave(&adapter->vfs_lock, flags);
 		kfree(adapter->vf_mac_list);
 		adapter->vf_mac_list = NULL;
@@ -3739,6 +3739,7 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 		err = -EPERM;
 		goto out;
 	}
+
 	if (!num_vfs)
 		goto out;
 
@@ -3746,11 +3747,13 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 		dev_info(&pdev->dev, "%d pre-allocated VFs found - override max_vfs setting of %d\n",
 			 old_vfs, max_vfs);
 		adapter->vfs_allocated_count = old_vfs;
-	} else
+	} else {
 		adapter->vfs_allocated_count = num_vfs;
+	}
 
 	adapter->vf_data = kcalloc(adapter->vfs_allocated_count,
-				sizeof(struct vf_data_storage), GFP_KERNEL);
+				   sizeof(struct vf_data_storage),
+				   GFP_KERNEL);
 
 	/* if allocation failed then we do not support SR-IOV */
 	if (!adapter->vf_data) {
-- 
2.43.0


