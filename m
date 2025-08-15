Return-Path: <netdev+bounces-214150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 224EFB285E4
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916D91CE4A29
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCC621421D;
	Fri, 15 Aug 2025 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhEjmdbF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16A31771D;
	Fri, 15 Aug 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283096; cv=none; b=SVJftEEHnec3luLo+gXRdPGvDsAf4uiuAkPgvjh53rEcAD0zgWq47Qzwqr8O5mGaBRU9Gnp7bSW95PQPgwQYmjfWBQxbRzUXSvG86g8DyiZlwqOuMdoRuH1Vj8WwYbnNquARbNKfwsg6Mxtdr4a6NBtCMMKMDiaKA/8RN5tHd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283096; c=relaxed/simple;
	bh=Fq+JsG/X8ICLODlEHQqKZ5Wu3dHnMuRLkTFb7+Cn2cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNHmLREyxjp2Huf/aH8uZMaZProxB5t35E1lmnbUaLbEI5KixbGiPsuh04l/XiW1P03trlFKZ4RFiYhhUDwq7KL9zd6L7m2v3WiPDdRYWwG37Ctyuk2Ru+sLJd6g2lOdtO7HUlJ3UhIhNjmYWyvZoeJQLx7OjK+3MIkmuKKw17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhEjmdbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C23CC4CEEB;
	Fri, 15 Aug 2025 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755283095;
	bh=Fq+JsG/X8ICLODlEHQqKZ5Wu3dHnMuRLkTFb7+Cn2cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GhEjmdbF6Zd106+cxr7uY5xJes0Qf5HxZKekIArM2tF0mGkF0ZZ0VHJStCm0VMFBM
	 PaSZ6a4e+9+xu9JP3PiDbEAPb6pjwC6Na/+HOF/I1mHHyiX25hE34hqKO1nlmQ1fIH
	 U/jffc74kYo9ZrYSa3Gi79Bi36F2roWokgPy25bK9K8pcL7cA9it3XTiixjuX1PbOn
	 uvfReK9hlqa2ubLWt/h21Em181/f7UY6eSeERigpzgzbDe3nSu8CAqdP8FwMtffupt
	 p4bIw6gWkAqQ8pFSxzs8p4uYsaK7egKqQMNiujGCl/bJPyhwxAIm++FrG3/Zt+/r0Q
	 aPWxuLnp1nnhQ==
Date: Fri, 15 Aug 2025 11:38:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, David
 Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <20250815113814.5e135318@kernel.org>
In-Reply-To: <20250812115321.9179-1-guwen@linux.alibaba.com>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 19:53:21 +0800 Wen Gu wrote:
> This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
> infrastructure of Alibaba Cloud, synchronizes time with reference clocks
> continuously and provides PTP clocks for VMs and bare metals in cloud.

> +static struct attribute *ptp_cipu_attrs[] = {
> +	&dev_attr_reg_dev_feat.attr,
> +	&dev_attr_reg_gst_feat.attr,
> +	&dev_attr_reg_drv_ver.attr,
> +	&dev_attr_reg_env_ver.attr,
> +	&dev_attr_reg_dev_stat.attr,
> +	&dev_attr_reg_sync_stat.attr,
> +	&dev_attr_reg_tm_prec_ns.attr,
> +	&dev_attr_reg_epo_base_yr.attr,
> +	&dev_attr_reg_leap_sec.attr,
> +	&dev_attr_reg_max_lat_ns.attr,
> +	&dev_attr_reg_mt_tout_us.attr,
> +	&dev_attr_reg_thresh_us.attr,
> +
> +	&dev_attr_ptp_gettm.attr,
> +	&dev_attr_ptp_gettm_inval_err.attr,
> +	&dev_attr_ptp_gettm_tout_err.attr,
> +	&dev_attr_ptp_gettm_excd_thresh.attr,
> +
> +	&dev_attr_dev_clk_abn.attr,
> +	&dev_attr_dev_clk_abn_rec.attr,
> +	&dev_attr_dev_maint.attr,
> +	&dev_attr_dev_maint_rec.attr,
> +	&dev_attr_dev_maint_tout.attr,
> +	&dev_attr_dev_busy.attr,
> +	&dev_attr_dev_busy_rec.attr,
> +	&dev_attr_dev_err.attr,
> +	&dev_attr_dev_err_rec.attr,

This driver is lacking documentation. You need to describe how the user
is expected to interact with the device and document all these sysfs
attributes.

Maybe it's just me, but in general I really wish someone stepped up
and created a separate subsystem for all these cloud / vm clocks.
They have nothing to do with PTP. In my mind PTP clocks are simple HW
tickers on which we build all the time related stuff. While this driver
reports the base year for the epoch and leap second status via sysfs.

