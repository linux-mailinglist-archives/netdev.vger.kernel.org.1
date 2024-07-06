Return-Path: <netdev+bounces-109611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B364D929207
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E9BB22099
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9122EF2;
	Sat,  6 Jul 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2hnr8+B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D41B963
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720255885; cv=none; b=sANdBwycGUjymKm3BGbXM1apxCKw7P1osUzIkCRcxdDFZ3qRmS9D1yFBkmhLsG70CEXuzSP+mEOPuGF8/qgurhi69ihzAexWDYDJSDafuYz+GHykGB7KE+bOHZQkkqdzdw9ch4EVtxIk+RbTmMrbbpv3XKF8KpLueX5s2DhNf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720255885; c=relaxed/simple;
	bh=nD8wIhpV99v/o/yaBVZkA+OhRX9XKbTQk8wls5O7J3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VNSmJIEnJIdwwE+X89EGLXuIkR8018dzw6hy+poH/q0Us+2a065j9aAW5/GOtA8Zp5dwWyZjSx606cPpptQgbY99uvPawcSCrqNS1+ouMU030fAosxVxN4hRZy2ajN3I5D+5L5NZRwvzDnsPZzTtIU8MOpOVql6+rGDoi42omUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y2hnr8+B; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70afe18837cso1567695b3a.3
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720255882; x=1720860682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvr1Xt3+1htJpKQNeg4Qn5gKCppFGEBYjqSgQqzCPxE=;
        b=Y2hnr8+BVX4rTj+bZnT9ADQor+0r4ccSfvdwjfs5Uxb7+oGJEomhtd4nE5Gm8H+YOx
         dJJTOlZvddV7FwIBCMkl7lt2/TzRj+6cFnG6kOKeUv63V3D4pPAIhcUUdc+Q/gpbVS/X
         9bWCU3DHgziBTtEMkdvSQ+993fQC87/mz9XCil381uI/SLxDDCeKwPX1611ghQFdfqq4
         lZ611pEqZNi0hcw9g/PvJURIYv/YcLs16kYwK92YSPxUG6vvs1m5OUYX/+V8i1tsCuik
         4VYsYsbN/DlebTPR3FbNnmvOCQNvjDy/pK0H0HmEypY4DjgygDETg4DXjxYnHicEFQbt
         61Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720255882; x=1720860682;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvr1Xt3+1htJpKQNeg4Qn5gKCppFGEBYjqSgQqzCPxE=;
        b=PcDjFl1IHGqLvV8csNpgoe/ONnO+hzwc4L9c23E/reRe7R67utY4qgCq4gSYumRS2C
         o2IYZh/kL0P/t5E2PRvVnjqItJlcScnJD7viqhywdCC2TOCQz1jEJ1x4DSwRBf0vGGcH
         yaRQkw+yff6ONcssrqCX6GIfMK1Wnn3UUUFYTmCYZbmB2sS2KYawgWjPVL46D85MCc5m
         MWd2wZ7X21CGxtCZArhs6Z+r1piFRu4KwhtB10styxCO0Yl+1pXcD5oDPjo+LU5k4Hnd
         Rv9pDJURXan/TcwrwElV7CMhBaXUajvDJ5MSu6AFi42DCTlpbdLnJ9xqCZMd5S7I8IM3
         Wytw==
X-Forwarded-Encrypted: i=1; AJvYcCWpl7VqyJdtJp5Q226S0gqsquyABxVAzTMY8jL/FYXbt3u75J8Df9ar62ZxT93cPiuMJT5+YZqSdZ0ZmC24dMeFVF8V/5pn
X-Gm-Message-State: AOJu0YzcxmLmshjJt734IODeQiFMQk1paRac/ftcMjGEfGBDi7BuFRbz
	bZZHKg9jIyS7tJjf4Ttvkek+DmAGguHcRZqBmnxSWbINaPLYwRcnoq4hbpfMa7xAzdZH9x8vwvA
	=
X-Google-Smtp-Source: AGHT+IFhZwtScp0M/onD7yeasvT+zwB0nO0kE8wWwQvmHMwxoUCu0unZ+oan7LLGD7aF1aEsm/DBJQ==
X-Received: by 2002:a05:6a21:6da9:b0:1b8:d79:55f3 with SMTP id adf61e73a8af0-1c0cc8ec43bmr7314658637.54.1720255881978;
        Sat, 06 Jul 2024 01:51:21 -0700 (PDT)
Received: from thinkpad ([2409:40f4:301b:2f0f:39:4d50:dece:e7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb261ddf1fsm53455505ad.212.2024.07.06.01.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:51:21 -0700 (PDT)
Date: Sat, 6 Jul 2024 14:21:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: gregkh@linuxfoundation.org
Cc: mhi@lists.linux.dev, netdev@vger.kernel.org, slark_xiao@163.com
Subject: [GIT PULL] MHI changes for v6.11
Message-ID: <20240706085117.GA3954@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git tags/mhi-for-v6.11

for you to fetch changes up to 65bc58c3dcad0d9bd17762e22603894a2d2880d6:

  net: wwan: mhi: make default data link id configurable (2024-07-03 19:11:01 +0530)

----------------------------------------------------------------
MHI Host
========

- Used unique 'mhi_pci_dev_info' struct for product families instead of reusing
  a shared struct. This allows displaying the actual product name for the MHI
  devices during driver probe.

- Added support for Foxconn SDX72 based modems, T99W515 and DW5934E.

- Added a 'name' field to 'struct mhi_controller' for allowing the MHI client
  drivers to uniquely identify each MHI device based on its product/device name.
  This is useful in applying any device specific quirks in the client drivers.

WWAN MHI Client driver
======================

- Due to the build dependency with the MHI patch exposing 'name' field to client
  drivers, the WWAN MHI client driver patch that is making use of the 'name'
  field to apply custom data mux id for Foxconn modems is also included.
  Collected Ack from Networking maintainer for this patch.

MHI EP
======

- Fixed the MHI EP stack to not allocate memory for MHI objects from DMA zone.
  This was done accidentally while adding the slab cache support and causes the
  MHI EP stack to run out of memory while doing high bandwidth transfers.

----------------------------------------------------------------
Manivannan Sadhasivam (2):
      bus: mhi: ep: Do not allocate memory for MHI objects from DMA zone
      bus: mhi: host: pci_generic: Use unique 'mhi_pci_dev_info' for product families

Slark Xiao (3):
      bus: mhi: host: Add support for Foxconn SDX72 modems
      bus: mhi: host: Allow controller drivers to specify name for the MHI controller
      net: wwan: mhi: make default data link id configurable

 drivers/bus/mhi/ep/main.c          |  14 +++++++-------
 drivers/bus/mhi/host/pci_generic.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 drivers/net/wwan/mhi_wwan_mbim.c   |  18 ++++++++++++++++--
 include/linux/mhi.h                |   2 ++
 4 files changed, 128 insertions(+), 28 deletions(-)

-- 
மணிவண்ணன் சதாசிவம்

