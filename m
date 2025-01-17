Return-Path: <netdev+bounces-159461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB675A158F1
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E960D165754
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 21:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D141A8F84;
	Fri, 17 Jan 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr3l9tOS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C71A83F1
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148930; cv=none; b=C4RRSblwi76hVAHoiOKkC49isnzIkgljgkUk+XUTz4YOMyARQZotMCoA9D4fbgMytNdujrhjqFFhcWx8lUYGpvl7Sg+ZhFUb9kQ/UZfFVj4Nns09w7I2X8JDanJRHrwy5RciFvmrsWjUr9GnDmLTLvxGD6SkAG3ysEsOuoX4uZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148930; c=relaxed/simple;
	bh=/2ljQ+ToC/Mrn+hGDWBUtW5XHRW1AEb66dvHNcMn+xM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRBszVnzlncT+D1tL+443HWOTBv6SaeW2zFVSUt5hEIvz/XSpC61Kcf/IQqDFyTHXGZwCnDFiIfrXoDaoYW7s0822oKwPB0YVEzi/TRC2YfR2Kc+kvCNCpPwJE6wrAbQ02LRHQLb6TNHAhDJv+rk2vYoh083240+FkkFD1XsA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr3l9tOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E5DC4CEDD;
	Fri, 17 Jan 2025 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737148929;
	bh=/2ljQ+ToC/Mrn+hGDWBUtW5XHRW1AEb66dvHNcMn+xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tr3l9tOS3s2mvzS//wIP0Ls4aiih6Av+C7PouZnPdEcqVTmg2raxbf2c0e6EfH5QE
	 dOJFORRk4FCt/U8apwR4lbhwc/VFBi8RFqgCvbu7ZlUPlFITLEV9kzyxWtw2TjQBsu
	 4kzzhBwlkyiqjbD3GB9gTqGp0mDbKWmlwQ/hOrlEHspXwsKHxvFKDReG02rhZjPvlV
	 k1t2qwX6Y+vrY1PJlVoTsh3Rg/Z+GIRO6V/r32WV1XSepMVZ/BfdGfQBWLHlp23Tx1
	 i89RWI/DdpFVT+XaFMGhB5belCXfx45zn64M08Fws+WGR9zCVIWtav15hhMBbaEtaU
	 gtstHBxA/VtcA==
Date: Fri, 17 Jan 2025 13:22:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
 jacob.e.keller@intel.com, xudu@redhat.com, mschmidt@redhat.com,
 jmaxwell@redhat.com, poros@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v2 intel-net 0/3] ice: fix Rx data path for heavy 9k MTU
 traffic
Message-ID: <20250117132208.1f87a2dc@kernel.org>
In-Reply-To: <20250117151900.525509-1-maciej.fijalkowski@intel.com>
References: <20250117151900.525509-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 16:18:57 +0100 Maciej Fijalkowski wrote:
> Subject: [PATCH v2 intel-net 0/3] ice: fix Rx data path for heavy 9k MTU traffic

nit: could you use iwl-net and iwl-next as the tree names?
That's what we match on in NIPA to categorize Intel patches.

