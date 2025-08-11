Return-Path: <netdev+bounces-212405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B05B20035
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FEF1896DD7
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DB02D94B5;
	Mon, 11 Aug 2025 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpBs2TP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B62BB1D
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896982; cv=none; b=sGB46EwtUyRN3jP1X3FFhLD0TGNrQ3OjHm3gDgtDynD5qW0y3Z0y8uHh9jBfWNy7LxCMSq4x6PNVWtkWl8BZ1oVlYz4KvWAWeK25FGOWKHWcbHUFpqYVu/1DC7Nj7l9A/0xv01TAKf3J/eNsOlUeRSJtT9rzQNDZxQu1J1pnirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896982; c=relaxed/simple;
	bh=woCVrO6dhn36cDQiOC9fdB3hQgbbHDv9+bAvf2a9r+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=paZAwtmJo1FqOjo92F7T/LGm+nHx/SP8bFGDNkcBzUFe0y1TGN7Dqsb5A2NERq5T5CNDW1bdV8nqfFJ9MThbz/bNkDHAP2FugDJSB2CD27y4i3TlmevapGN82mEF++nrFE1/f/W/oqyG1bMNVa/EcgkDIsuDpDJzx/dvvYYzu98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JpBs2TP+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459e20ec1d9so40074895e9.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754896979; x=1755501779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+z/+R7oU33VDJzw/HRlzRxAxOu1KhJaIdsYxJlphmE=;
        b=JpBs2TP+UFVE1FGawBW0EVJe/26I7DbTrp74R3CyyOoom3mAeVotrPdCQR/YoPexba
         YHNrn+h3YElI1N7wQBvq5OLRKR/NsM5P1uZoecLm8LgGuU3ZJQ7zTFVc2By4Va2AKI1W
         klb0mAXjHZ83TUe5owE2XR6NjFhugHF+0Y63HsHUycLYVgcIYUczZ9Uuj2rSouACiNwr
         h0EtcWFYxCuPWISATPP3OvWCoExCBlER2pMtBJXgdjsAdyMXJb48dcD5tDj6gfBb5eLT
         WgKJ+S9YUWgsOc5lvwg/P6oKDMCxcz/z/26h4D4LBYx/jpRJWXf7ZRXSmr7B4alAAqlp
         StcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754896979; x=1755501779;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+z/+R7oU33VDJzw/HRlzRxAxOu1KhJaIdsYxJlphmE=;
        b=p17j/rsCq07EFIMnzZ1EmrWk07YI/D7PPGxemYX1nw0la7zcQ6Ns9sEwGQhsIWe96d
         Du+Lc0rEL7H601UgDxIDwqmvL4VVFhnXQ/VOdU9ScUoZSe6H/9a/miQ3g7j5pSk8Jt47
         s32kyb+OfzeNhUpsuotbkS+I9XkFdcQwrqRJXwF3obWAGS60DD8DahxKz9czGGUropNA
         tDKOED/W50Mk5U1R2/F2LZdrl4fBRnX2Lc6FJDdL1YTbWfucY/9ych8jVmQfibD1pEmn
         mv8YC7qilGltlx32/tUVdptNO5obiNEJA9S6qAXF0yNyBpdu82rPFKKigIro9YDaHEAd
         oGoA==
X-Forwarded-Encrypted: i=1; AJvYcCU5epy+AweRjp/w6obc9ayyZ4zvESOjQx04oD1GoFooUT7UXRIaXeDRs81hI4DKA/ojZihxV1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBm1B1SpZOuc5QbV4cO5NRShZeBwImfIBq41btPO9i8v/O7LRj
	IBfH5FUKIt8bw8ZvMG8OJGJYsrrHinNUDPmZd7v/CzoWduA4bgm8Hqc42OlBWJ1nR5I=
X-Gm-Gg: ASbGnctJ06yUxpHlxx8sZ1Hw/JnoJrqijzRTY7lbhQh9NUh02TMAUunVanQTO7MKWSy
	1iUndARv9vfwgnJQisZRAWW6Sjn9Tb0DhC3ohI4C2PqaCEfYFqER1ae3mdfOboihmD4GUqpT8KB
	u9HhhIYLyY0FMIg/EoytWkthVAPZuCcrFaDaNGvBkkPKcPjYiIXYud8N7hh8k/Au2q57hGiLb2y
	s0wYZ4Y9IchpOZoL239A0uI3YtOgbwylofduhRQlGQgv3xWbMUlHw+p1osr7lczvZP4mn4p6fWs
	WkgqXocmdO4CXvynExNNbJ4mb7klWbitiQ1+MVNa+3Q9ai8xoX3zcKjUjgK+dqJ9QR1JcQNcCpz
	ANSp1MGMc1VPborsPEkwOEPtPEak=
X-Google-Smtp-Source: AGHT+IGszvzzpERaF/8oDL3FMMeG6zVxZk3f09zF1ZZQb2aBJTeLaPBC4BxqvyU1hoPCSHv7KDXCMg==
X-Received: by 2002:a05:600c:1e8b:b0:456:f9f:657 with SMTP id 5b1f17b1804b1-459f4faccd5mr99727255e9.27.1754896978920;
        Mon, 11 Aug 2025 00:22:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e78a35cdsm118970895e9.3.2025.08.11.00.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:22:58 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:22:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	David Yang <mmyangfl@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: dsa: yt921x: Add support for Motorcomm YT921x
Message-ID: <202508110116.NWcO7Fju-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808173808.273774-3-mmyangfl@gmail.com>

Hi David,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/net-dsa-tag_yt921x-add-support-for-Motorcomm-YT921x-tags/20250809-014351
base:   net/main
patch link:    https://lore.kernel.org/r/20250808173808.273774-3-mmyangfl%40gmail.com
patch subject: [PATCH 2/2] net: dsa: yt921x: Add support for Motorcomm YT921x
config: um-randconfig-r072-20250810 (https://download.01.org/0day-ci/archive/20250811/202508110116.NWcO7Fju-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508110116.NWcO7Fju-lkp@intel.com/

smatch warnings:
drivers/net/dsa/yt921x.c:1090 yt921x_dsa_setup() error: uninitialized symbol 'val'.

vim +/val +1090 drivers/net/dsa/yt921x.c

77de450829a940 David Yang 2025-08-09  1061  static int yt921x_dsa_setup(struct dsa_switch *ds)
77de450829a940 David Yang 2025-08-09  1062  {
77de450829a940 David Yang 2025-08-09  1063  	struct yt921x_priv *priv = ds->priv;
77de450829a940 David Yang 2025-08-09  1064  	struct device *dev = priv->dev;
77de450829a940 David Yang 2025-08-09  1065  	struct device_node *np = dev->of_node;
77de450829a940 David Yang 2025-08-09  1066  
77de450829a940 David Yang 2025-08-09  1067  	struct device_node *child;
77de450829a940 David Yang 2025-08-09  1068  	int cpu_port;
77de450829a940 David Yang 2025-08-09  1069  	u32 val;
77de450829a940 David Yang 2025-08-09  1070  	int res;
77de450829a940 David Yang 2025-08-09  1071  
77de450829a940 David Yang 2025-08-09  1072  	res = yt921x_dsa_cpu_port(ds, &cpu_port);
77de450829a940 David Yang 2025-08-09  1073  	if (unlikely(res != 0))
77de450829a940 David Yang 2025-08-09  1074  		return res;
77de450829a940 David Yang 2025-08-09  1075  
77de450829a940 David Yang 2025-08-09  1076  	res = yt921x_detect(priv);
77de450829a940 David Yang 2025-08-09  1077  	if (unlikely(res != 0))
77de450829a940 David Yang 2025-08-09  1078  		return res;
77de450829a940 David Yang 2025-08-09  1079  
77de450829a940 David Yang 2025-08-09  1080  	/* Reset */
77de450829a940 David Yang 2025-08-09  1081  	res = yt921x_smi_write(priv, YT921X_RESETm, YT921X_RESET_HWf);
77de450829a940 David Yang 2025-08-09  1082  	if (unlikely(res != 0))
77de450829a940 David Yang 2025-08-09  1083  		return res;
77de450829a940 David Yang 2025-08-09  1084  
77de450829a940 David Yang 2025-08-09  1085  	/* YT921X_RESET_HWf is almost same as GPIO hard reset. So we need
77de450829a940 David Yang 2025-08-09  1086  	 * this delay.
77de450829a940 David Yang 2025-08-09  1087  	 */
77de450829a940 David Yang 2025-08-09  1088  	usleep_range(10000, 15000);
77de450829a940 David Yang 2025-08-09  1089  
77de450829a940 David Yang 2025-08-09 @1090  	res = read_poll_timeout(yt921x_smi_read, res, val == 0,
                                                                                              ^^^^^^^^
yt921x_smi_read() doesn't necessarily initialize *valp.

77de450829a940 David Yang 2025-08-09  1091  				YT921X_MDIO_SLEEP_US, YT921X_RESET_TIMEOUT_US,
77de450829a940 David Yang 2025-08-09  1092  				false, priv, YT921X_RESETm, &val);
77de450829a940 David Yang 2025-08-09  1093  	if (unlikely(res != 0)) {
77de450829a940 David Yang 2025-08-09  1094  		dev_err(dev, "Reset timeout\n");
77de450829a940 David Yang 2025-08-09  1095  		return res;
77de450829a940 David Yang 2025-08-09  1096  	}
77de450829a940 David Yang 2025-08-09  1097  
77de450829a940 David Yang 2025-08-09  1098  	/* Always register one mdio bus for the internal/default mdio bus. This
77de450829a940 David Yang 2025-08-09  1099  	 * maybe represented in the device tree, but is optional.
77de450829a940 David Yang 2025-08-09  1100  	 */

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


