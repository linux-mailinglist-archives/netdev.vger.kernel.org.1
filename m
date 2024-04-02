Return-Path: <netdev+bounces-84078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF75895797
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8ED1C21A21
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF9126F16;
	Tue,  2 Apr 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAZsLfKd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213A138A
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069846; cv=none; b=DJ1vMiHS/9FJ9+iZKs5CgxxsHpmLySY2flHt+y2fD4HFXU6MCl7Gs1nvvMXxJY7wcd9j6QefW9xs3Oq0cbuO9fP6BJqoaRqRd8oZYuCWqz4JjdjQdHhHPa45kCEMIKtkDIffVVmbK/gLAhkk2kOZFOVmwGWg7aTYdpzYPu5ctOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069846; c=relaxed/simple;
	bh=jH8W3rNaCzzyywh+KEmos38PBmWwa8tmyPdVUI7pHTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH21qAJpAuyQaoZW3gpV0MsSDUMWfgkcLgjafSsmUN14FsI/27WzF7Kg7EjlSGhhpYjItn0VeclqKi6PTvdxCc821o5ipleKJV83QKTtx3xqgYf0MI1JQZbmRroOVdw8Q7KyJ93UwikVd4+RoI+9WMS9peA4J/VXX/Qg6lrakJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAZsLfKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E04C433F1;
	Tue,  2 Apr 2024 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712069845;
	bh=jH8W3rNaCzzyywh+KEmos38PBmWwa8tmyPdVUI7pHTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VAZsLfKdeRqVSfCsOyhS/9qr9mFIW+YK/4hwIgPDpRLBCjR9D2aYf+VftQRzZF7qw
	 /GQlUzpMBWKtcDTXWotimx8ge8ljLv7lROZ+LzhumLswZqopzXRqC+AE8Yrk+khs1D
	 /V/6uYBqlZgJsRHEZ5X0fR3oJlsb1R4Z6mTxPtQPxFoN5/xYQ4RxBuXMlJeTBT+gjA
	 1vwXH9K38fceIWvgup0XPAmUUCpgFVZu1fqg7JC261ftnHgoRAeqPr/yoUaHUPELyF
	 CO8rBZTvrM8Cz14fSlLNRviNkl7Mfa5aEXzwCi1PpL5BPfbT7v9BB/yuR7MsOJW2EP
	 iHwyaUkvhqw9w==
Date: Tue, 2 Apr 2024 07:57:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, idosch@nvidia.com,
 edumazet@google.com, marcin.szycik@linux.intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power
 support
Message-ID: <20240402075724.04e1a831@kernel.org>
In-Reply-To: <dc601a7c-7bb7-4857-8991-43357b15ed5a@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
	<38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
	<a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
	<dc601a7c-7bb7-4857-8991-43357b15ed5a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 16:46:54 +0200 Andrew Lunn wrote:
> Looking at
> https://www.optcore.net/wp-content/uploads/2017/04/QSFP-MSA.pdf table
> 7 it indicates different power budget classifications. Power level 1
> is a Maximum power of 1.5W. So does your parameter represent this?  It
> is the minimum maximum power? And your other parameter is the maximum
> maximum power?
> 
> I agree with Jakub here, there needs to be documentation added
> explaining in detail what these parameters mean, and ideally,
> references to the specification.
> 
> Does
> 
> $ ethtool --set-module enp1s0f0np0 power-max-set 4000
> 
> actually talk to the SFP module and tell it the maximum power it can
> consume. So in this case, it is not the cage, but the module?
> 
> Or is it talking to some entity which is managing the overall power
> consumption of a number of cages, and asking it to allocate a maximum
> of 4W to this cage. It might return an error message saying there is
> no power budget left?
> 
> Or is it doing both?
> 
> Sorry to be picky, but at some point, somebody is going to want to
> implement this in the Linux SFP driver, and we want a consistent
> implementation cross different implementations.

Or "guessing how things work" another way of putting this would be -
please go investigate what exactly the FW will do with these values.

