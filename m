Return-Path: <netdev+bounces-110300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F292BC44
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FE0B27A8E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749B18EFCB;
	Tue,  9 Jul 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXZxmi7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4518E779;
	Tue,  9 Jul 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533498; cv=none; b=HubpQ6kRSnzN3TxW/JLIFQ8Cxw9YOno89s0CjMfb36FtueXt1sdR3niJ0oXwHA7oZpAOlu7+vVLRk+SAv9Y5t3xG/1kGgUedJRzTf46ZrP+GQzn5a7sYaHpNzsypkTAu4ORpXzoKJ873xqSxbLPgh2fvZSRRQ7Q7q5Oi120yfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533498; c=relaxed/simple;
	bh=O5vT/WAVEi3I/1zZ1e6X9bF4G+TvWPZVtYQUS4pdoF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJxpIAJsPhWW0yG3XVAb6iFAWcvIhiAF5LW62l65JUHPhu5/TVGRlpeSYKwZtJraS+hR9EJbVs8HuDgJ35FIAdbg7DTjFiMUjCRCEJf10YUSv6ltkIQ2qWO/5UFgfjSsPTVVTPyESfxJIH94CcXQlUwqqr4v+LNYDbVkE7XtVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXZxmi7+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367940c57ddso3401641f8f.3;
        Tue, 09 Jul 2024 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720533495; x=1721138295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbYmgVACDAtRDSTL3B4NejRqBxXknmHxVQadZf89uHw=;
        b=KXZxmi7+OTJN285NjyW0YP02AFRw6CHjcruRjCM5T95WKBeENgBH6i6/5Qvtok1sj6
         J7MtCvB5DYxDWcGfVOUIBqFFW34XhNXRUNh5EsESilpUbvbk8uyvke6PYUMTLulk9556
         AMY6848AtvhghX74MXEIfPq1mqCRHBWlW8q/6k2cUBFlcGl2OUF7R4+aDy7ivzy+ZzJw
         2FTUomNh5UCoO7j/0kB8cP26CBabUOIg+6KVj6KgTNEBqznuLdkNZSgKQ+cy5Uq6lXRR
         +MNtXUYE1dOpSkx1dr5/Ap3n5Wc34nXEapLzLAWRiJW184Vj1GJEMQXKw246tDbwljZX
         Bx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533495; x=1721138295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbYmgVACDAtRDSTL3B4NejRqBxXknmHxVQadZf89uHw=;
        b=wXSShomtjY9auuI3E4QHRcJ1zEc7ivys/Q6fZZnysxVrjuPIl5ZKKqryrAhvoYNgSA
         nQqkCMYU6iCTcQWZss31s1FZ3SWZg4koJVz/wZeShgXRMQeEYBEXSRPHZozyB6XZchPi
         j1P2cq88WB3rt/o4367E/BiPBnvKh8BjSWGAIEqpQRyLV7Ju8amDtyObEBjIa8dvT1Ig
         e1W4k71eUG+ru21eyH1+nBY7i8C5v1Tp2+CXenJJ2YcLtkfau/JPWcNu+usM6P+qsEFt
         RPYKW+1FZPz5ihwvddHhPpsv2oFEKjfLys7614+1x020KGbgqJYFw8KvP48wpRB6GQWv
         4oAg==
X-Forwarded-Encrypted: i=1; AJvYcCWvqaKdXsh4wAG+JtNEzPK4OCt8MeIyyJOSxZ7qYk7KNDXQqWhq4RJMBydi1gjIz0Y4gHGwm/lrsnjyrI/WqAglshrh7+0LfEqdI2o0z4IO/qLgvxf0Ew5GK/GByo4Q26qbYJHq
X-Gm-Message-State: AOJu0Yz7L0ZBjTrJ9fIbwjrqjxWM1sDUuKpNb7yLT/0ndnDS6GQUF6f0
	l1osy4Pl0HRW/9RsUVX0s2KXxwpffZlIv0V01xFoRk7DTgTem68DA0XYx9do
X-Google-Smtp-Source: AGHT+IFhR6wXKYVJPy9dz+zWqOXpE2lauzhnAJp1D41g6UvLG42BZPLhgq5ODjo9utaXK51miT15Dw==
X-Received: by 2002:adf:ffcd:0:b0:367:9791:2939 with SMTP id ffacd0b85a97d-367cea6b804mr1603691f8f.21.1720533494785;
        Tue, 09 Jul 2024 06:58:14 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d16b0sm206311405e9.7.2024.07.09.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:58:14 -0700 (PDT)
Date: Tue, 9 Jul 2024 16:58:11 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kuba@kernel.org, horms@kernel.org, Roy.Pledge@nxp.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <20240709135811.c7tqh3ocfumg6ctt@skbuf>
References: <20240624162128.1665620-1-leitao@debian.org>
 <202406261920.l5pzM1rj-lkp@intel.com>
 <20240626140623.7ebsspddqwc24ne4@skbuf>
 <Zn2yGBuwiW/BYvQ7@gmail.com>
 <20240708133746.ea62kkeq2inzcos5@skbuf>
 <Zow5FUmOADrqUpM9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hpogfizkbgtmf2d4"
Content-Disposition: inline
In-Reply-To: <Zow5FUmOADrqUpM9@gmail.com>


--hpogfizkbgtmf2d4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Breno,

On Mon, Jul 08, 2024 at 12:08:05PM -0700, Breno Leitao wrote:
> I thought about a patch like the following (compile tested only). What
> do you think?

To be honest, there are several things I don't really like about this
patch.

- I really struggled with applying it in the current format. Could you
  please post the output of git format-patch in the future?
- You addressed dpaa_set_coalesce() but not also dpaa_fq_setup()
- You misrepresented the patch content by saying you only allocate size
  for online CPUs in the commit message. But you allocate for all
  possible CPUs.
- You only kfree(needs_revert) in the error (revert_values) case, but
  not in the normal (return 0) case.
- The netdev coding style is to sort the lines with variable
  declarations in reverse order of line length (they call this "reverse
  Christmas tree"). Your patch broke that order.
- You should use kcalloc() instead of kmalloc_array() + memset()

I have prepared and tested the attached alternative patch on a board and
I am preparing to submit it myself, if you don't have any objection.

Thanks,
Vladimir

--hpogfizkbgtmf2d4
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dpaa-avoid-on-stack-arrays-of-NR_CPUS-elements.patch"

From 00b942829ee283baa602011a05b02d18c6988171 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 8 Jul 2024 11:57:33 -0700
Subject: [PATCH] net: dpaa: avoid on-stack arrays of NR_CPUS elements

The dpaa-eth driver is written for PowerPC and Arm SoCs which have 1-24
CPUs. It depends on CONFIG_NR_CPUS having a reasonably small value in
Kconfig. Otherwise, there are 2 functions which allocate on-stack arrays
of NR_CPUS elements, and these can quickly explode in size, leading to
warnings such as:

  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:3280:12: warning:
  stack frame size (16664) exceeds limit (2048) in 'dpaa_eth_probe' [-Wframe-larger-than]

The problem is twofold:
- Reducing the array size to the boot-time num_possible_cpus() (rather
  than the compile-time NR_CPUS) creates a variable-length array,
  avoidable in the Linux kernel.
- Using NR_CPUS as an array size makes the driver blow up in stack
  consumption with generic, as opposed to hand-crafted, .config files.

A simple solution is to use dynamic allocation for num_possible_cpus()
elements (aka a small number determined at runtime).

Link: https://lore.kernel.org/all/202406261920.l5pzM1rj-lkp@intel.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 20 ++++++++++++++-----
 .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 10 +++++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index ddeb0a5f2317..c856b556929d 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -931,14 +931,18 @@ static inline void dpaa_setup_egress(const struct dpaa_priv *priv,
 	}
 }
 
-static void dpaa_fq_setup(struct dpaa_priv *priv,
-			  const struct dpaa_fq_cbs *fq_cbs,
-			  struct fman_port *tx_port)
+static int dpaa_fq_setup(struct dpaa_priv *priv,
+			 const struct dpaa_fq_cbs *fq_cbs,
+			 struct fman_port *tx_port)
 {
 	int egress_cnt = 0, conf_cnt = 0, num_portals = 0, portal_cnt = 0, cpu;
 	const cpumask_t *affine_cpus = qman_affine_cpus();
-	u16 channels[NR_CPUS];
 	struct dpaa_fq *fq;
+	u16 *channels;
+
+	channels = kcalloc(num_possible_cpus(), sizeof(u16), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
 
 	for_each_cpu_and(cpu, affine_cpus, cpu_online_mask)
 		channels[num_portals++] = qman_affine_channel(cpu);
@@ -997,6 +1001,10 @@ static void dpaa_fq_setup(struct dpaa_priv *priv,
 				break;
 		}
 	}
+
+	kfree(channels);
+
+	return 0;
 }
 
 static inline int dpaa_tx_fq_to_id(const struct dpaa_priv *priv,
@@ -3416,7 +3424,9 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	 */
 	dpaa_eth_add_channel(priv->channel, &pdev->dev);
 
-	dpaa_fq_setup(priv, &dpaa_fq_cbs, priv->mac_dev->port[TX]);
+	err = dpaa_fq_setup(priv, &dpaa_fq_cbs, priv->mac_dev->port[TX]);
+	if (err)
+		goto free_dpaa_bps;
 
 	/* Create a congestion group for this netdev, with
 	 * dynamically-allocated CGR ID.
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 5bd0b36d1feb..3f8cd4a7d845 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -457,12 +457,16 @@ static int dpaa_set_coalesce(struct net_device *dev,
 			     struct netlink_ext_ack *extack)
 {
 	const cpumask_t *cpus = qman_affine_cpus();
-	bool needs_revert[NR_CPUS] = {false};
 	struct qman_portal *portal;
 	u32 period, prev_period;
 	u8 thresh, prev_thresh;
+	bool *needs_revert;
 	int cpu, res;
 
+	needs_revert = kcalloc(num_possible_cpus(), sizeof(bool), GFP_KERNEL);
+	if (!needs_revert)
+		return -ENOMEM;
+
 	period = c->rx_coalesce_usecs;
 	thresh = c->rx_max_coalesced_frames;
 
@@ -485,6 +489,8 @@ static int dpaa_set_coalesce(struct net_device *dev,
 		needs_revert[cpu] = true;
 	}
 
+	kfree(needs_revert);
+
 	return 0;
 
 revert_values:
@@ -498,6 +504,8 @@ static int dpaa_set_coalesce(struct net_device *dev,
 		qman_dqrr_set_ithresh(portal, prev_thresh);
 	}
 
+	kfree(needs_revert);
+
 	return res;
 }
 
-- 
2.34.1


--hpogfizkbgtmf2d4--

