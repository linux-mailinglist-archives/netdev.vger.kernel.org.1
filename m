Return-Path: <netdev+bounces-217310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09446B384CC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED21A4E3892
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1B2116E7;
	Wed, 27 Aug 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBRwCZz8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BEA1E008B
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304410; cv=none; b=pCCWAm4P4ctCI58FZZQW0PCBfEg5EUnznNm6F9dwxJWWa/bY5AoI0onzG7zzECEKA9YijzKDHXg0Zaiihb8B/YL68fPU2xClaeF8i1BqxjRT14wNDDp3gMpW+yQOlIXduEX3/6C8uspzNyNnxUFEgIR2w0PG9hWXyin5Ns+Yymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304410; c=relaxed/simple;
	bh=j8jreN6sAvwodO50Sc+7P1ozZcsLStyigxq9QYLMboM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoQMmNh6sT/xDnjC+kqnU5Ore3dOTl950UjpDXLP5tTOYrMA/9cJBObY2Ag63HkUTFX3F5sugwAgVCbKXVEedSWXGjebTddU5pw84CaQGO2C6Hwowlr/37KIXXRJkJmRZh1MewYVdFcDWPZ5cnevZzNlFEw59HYb27mI2EBaRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBRwCZz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD2BC4CEEB;
	Wed, 27 Aug 2025 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756304409;
	bh=j8jreN6sAvwodO50Sc+7P1ozZcsLStyigxq9QYLMboM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBRwCZz8RdD0l6XUhKuo8UkCZkVHFnX88xxBIilcvGkf2y5NUI897x9H1f1xF98Ok
	 uNBPvtixK1xheTAOcFjUhsnB7R+tSbufC3zs9VwpGmcE3O6u1AURmHLzoxtwnUBGt2
	 fBQAAlYZIV18HIT5urr0gnZPQ6DNumyDafhCHrMt2kPi9Vpls3iECs30c4ITgWyTJn
	 Re7NfK1HBC3k9Y6E3j6OC/oYq6HIxG2ieD6O9NRcwKK4VgtoY01LTwtkl2SWKlBmuC
	 w2p6017bp2GhtKLQhEI+EQF6brxEiuhUqz857LB5eKVGMkdXteW6c2Z3lfOcwQ5aZz
	 8cIOzBf4iDz8g==
Date: Wed, 27 Aug 2025 15:20:04 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, decot@google.com, willemb@google.com,
	joshua.a.hay@intel.com, madhu.chittim@intel.com
Subject: Re: [PATCH iwl-net 2/2] idpf: fix possible race in idpf_vport_stop()
Message-ID: <20250827142004.GD5652@horms.kernel.org>
References: <20250822035248.22969-1-emil.s.tantilov@intel.com>
 <20250822035248.22969-3-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822035248.22969-3-emil.s.tantilov@intel.com>

On Thu, Aug 21, 2025 at 08:52:48PM -0700, Emil Tantilov wrote:
> Make sure to clear the IDPF_VPORT_UP bit on entry. The idpf_vport_stop()
> function is void and once called, the vport teardown is guaranteed to
> happen. Previously the bit was cleared at the end of the function, which
> opened it up to possible races with all instances in the driver where
> operations were conditional on this bit being set. For example, on rmmod
> callbacks in the middle of idpf_vport_stop() end up attempting to remove
> MAC address filter already removed by the function:
> idpf 0000:83:00.0: Received invalid MAC filter payload (op 536) (len 0)
> 
> Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


