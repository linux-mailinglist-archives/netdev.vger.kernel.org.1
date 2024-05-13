Return-Path: <netdev+bounces-96004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAA8C3F6D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5E71F222CD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D614AD29;
	Mon, 13 May 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="W3j0vRPo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F2149E16
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715598271; cv=none; b=S3UNwEfrOG/bJJEdwc3u4Wvzu7T3gLYgj0Pug4H4LV+9o2iHGTuGWLmqUxHPTIWlk1oZqAtSilBIp076D4HqnVpdLuQkmtqWSkk6L9RrPfdDT7+aj/An8LdGkqUSBDeC+tl3IC8hjKOgMIxfUwS/gTDNvKJommFF2VJj2svO6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715598271; c=relaxed/simple;
	bh=6sflrIW2DOF1nngOqLp1MiKnqffXHsIxBQFFzLXQ2ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdIA9DucyO5nGW8iQ0pk6ujCU73qbDCl9sDhe2nGacPaQLP+ezPX7iC3eESqO1St2MCb1WAG4Tx8YqyHi1pY33O9qPYOLYD5TYrrWKcKOu0Fx2pHVxvc3Pv5fIt0ryfAI3eOfpceWb8zZtpz+0FQ9qZl3/i1WUfCaeofKSDcxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=W3j0vRPo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42011507a54so8899805e9.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715598268; x=1716203068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bm6vy9KiQiBlLAf59ubxl1yGSDCVBhjcvi/qZljDQ=;
        b=W3j0vRPo659KfQS+/QXCILnhFMn7QiR+ptBDpoPeD2Qb7rzfl/QSJZNliQPPIBr3CY
         GmIaRM6QdzPuNSQLi9EmEzj0TH4N5pj3BkztXUSgJw82YM7AN1rDr4qJg04DIjDYvHEq
         phL3rozbESes05TOInGMQ5q+ehXW6vMkAbOIdgCWz4y/fk2ZD/ynM8s1XP1PG3dbb6Z0
         9x9u2XQF3kf776UQzcZO+xoHO0Kv86LFVRLhIOeCLL97LGAdU3zd3HdLE1hBvQSYLSCQ
         Bg6CPqqdTyrDxOO1w5BTrHqSlEzU8N7FyBOdf5uDeIvbq62c78xo/E2XRzs/5ffB4je3
         dKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715598268; x=1716203068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0bm6vy9KiQiBlLAf59ubxl1yGSDCVBhjcvi/qZljDQ=;
        b=giT9DDFDNwSQo7JLYBYl+OY1UwJH68Um0vt+iBOJeuVFCiw+GgbPiKb3e5tbmPeBdE
         eUhN+TxsaSniJmQv6M5Jk5bnkueJ2JoiuWJZLyA63fTp13JskQa63VGA4M2Mu46y18Gc
         kJkYk2gDVBAOUOVCjo9Y3k6W8qE/oyQMmiffCoBQcRsbGev/9ZclZAnVh3/DUKM9hJ7j
         ZTKMZYI8kDjA9bUhBHAvknwrfcow6MR+IX1AVzbrRLW5Y/T9fJh938GS8bNklWKPEwXD
         0mZzNmaw9MTCKflWwcpw9F8D1+oAtmphbtbDxs0RdJpLMkxcGSsKvjka3XGTlR0tUBF8
         sHDA==
X-Forwarded-Encrypted: i=1; AJvYcCXM12OO5RQ1TzbO3JzNIt0OEFOVHSNMKxipC2TZYpx4U2S/vCnvPsmgiYPqr04Y5hS+jU5dD1LzhWyG+XeRGpQavvtmrQvO
X-Gm-Message-State: AOJu0YyousS58fQ0CXCEnGy8SQC07gUjTJKdrhXkst4cjxyF61YLYFpF
	9Mh5fe84o7AvyVN/WUpacCYTm5xXWZYDII0Zg4YY3vSLKnOVTbQ0YBnD8GrWx6E=
X-Google-Smtp-Source: AGHT+IGh+nnOrinrAFzjJIujBcWff2faYDloYS25IU6qR7fu8kaTwICIdLurnZDSTqfqVw3Y31/dJA==
X-Received: by 2002:a05:600c:4a98:b0:41b:9427:562e with SMTP id 5b1f17b1804b1-41feaa427f0mr83228235e9.12.1715598267583;
        Mon, 13 May 2024 04:04:27 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42014c21260sm41954465e9.3.2024.05.13.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 04:04:27 -0700 (PDT)
Date: Mon, 13 May 2024 13:04:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v2 03/15] ice: add basic devlink subfunctions support
Message-ID: <ZkHztwMeJFU73WQm@nanopsycho.orion>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>

Mon, May 13, 2024 at 10:37:23AM CEST, michal.swiatkowski@linux.intel.com wrote:

[...]



>+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
>+{
>+	struct devlink_port_attrs attrs = {};
>+	struct devlink_port *devlink_port;
>+	struct devlink *devlink;
>+	struct ice_vsi *vsi;
>+	struct device *dev;
>+	struct ice_pf *pf;
>+	int err;
>+
>+	vsi = dyn_port->vsi;
>+	pf = dyn_port->pf;
>+	dev = ice_pf_to_dev(pf);
>+
>+	devlink_port = &dyn_port->devlink_port;
>+
>+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
>+	attrs.pci_sf.pf = pf->hw.bus.func;
>+	attrs.pci_sf.sf = dyn_port->sfnum;
>+
>+	devlink_port_attrs_set(devlink_port, &attrs);
>+	devlink = priv_to_devlink(pf);
>+
>+	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
>+					  &ice_devlink_port_sf_ops);
>+	if (err) {
>+		dev_err(dev, "Failed to create devlink port for Subfunction %d",
>+			vsi->idx);

Either use extack or avoid this error message entirely. Could you please
double you don't write dmesg error messages in case you have extack
available in the rest of this patchset?


>+		return err;
>+	}
>+
>+	return 0;
>+}
>+

[...]

