Return-Path: <netdev+bounces-102025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D105D9011B3
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700F5281C43
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09602178384;
	Sat,  8 Jun 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYzKbCCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13129CF7
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717853847; cv=none; b=O2/DuWR2LQa1/H73+fKoyAYzIuCImVQpRJu5VBxDwefmhAOTKOzTN3nceSd4M+JC6hINbToLTTlPDMurTZOnZjaHbcZ0W3vHtenLFSjYQRNn5U5wp26a9cO1frw4K/eHwFbi+mjITwHu9iyBVZRUv9AjpwmrK3Tcn7uaGCGNoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717853847; c=relaxed/simple;
	bh=MFmVgjqkSi+wQ339l3N4kmKyilqV2bUpY4XkM7arNFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8lJmYWiy6jHhMDAH8iYwhaAaGHJbf8tDFs48sW8Qu5P0HPF/19giteTQrQVyCqFgljJ6ztVOfrJy42m6iFlzeWkUoAv9zgMargbxmGpo4Ul9loamrNpjH8T3FH70VaXVOlZT0lHSH5F/okVHDv8q081742Q5Rnqmm7fniTyU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYzKbCCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3248C2BD11;
	Sat,  8 Jun 2024 13:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717853847;
	bh=MFmVgjqkSi+wQ339l3N4kmKyilqV2bUpY4XkM7arNFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYzKbCCanZ4+sAraTt6tCFZ4DRdPHxlxuSo5LexkmAHh5lREuCcgtwnOG12cjMc0j
	 N/D+PCo8TXyri3HclUzsOSt+xwcXHOnmSSdzHNOh8xsXm6uW1btMQV9cfEIBQbE+xt
	 z4MLgQOdAySOkLkqCtDaoaH9FTNfiOcjBNmlWgtucJLcXNOJxOkIrpnlpHj+JBIhgx
	 WoxZopjh3SJU7ZXGYP6htocJgjJaK8ncSRojR2pKiDxKXHizxOQ42/fsdy43fybMu+
	 JB+BcwxVaktV/VTG9vaZBb8LHLtKaX7umzm1+vjd4QRzSWgR7Uz01fg92G5vMFZoOk
	 5GSfwVEJN9ivQ==
Date: Sat, 8 Jun 2024 14:37:23 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: core: Implement dstats-type stats
 collections
Message-ID: <20240608133723.GH27689@kernel.org>
References: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
 <20240607-dstats-v3-2-cc781fe116f7@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-dstats-v3-2-cc781fe116f7@codeconstruct.com.au>

On Fri, Jun 07, 2024 at 06:25:25PM +0800, Jeremy Kerr wrote:
> We currently have dev_get_tstats64() for collecting per-cpu stats of
> type pcpu_sw_netstats ("tstats"). However, tstats doesn't allow for
> accounting tx/rx drops. We do have a stats variant that does have stats
> for dropped packets: struct pcpu_dstats, but there are no core helpers
> for using those stats.
> 
> The VRF driver uses dstats, by providing its own collation/fetch
> functions to do so.
> 
> This change adds a common implementation for dstats-type collection,
> used when pcpu_stat_type == NETDEV_PCPU_STAT_DSTAT. This is based on the
> VRF driver's existing stats collator (plus the unused tx_drops stat from
> there). We will switch the VRF driver to use this in the next change.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>


