Return-Path: <netdev+bounces-184952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C197A97C85
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17637AB806
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C81263898;
	Wed, 23 Apr 2025 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucamzGIj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F62638B5
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745373071; cv=none; b=elk3VWZzNE+Z5xMXbsSc0vLDF4CIKWNOakG6QzZV26caYrS4WgzMESKLNpIxiAfvJ395oadeovYZYDurXF6trb1Q2q5zGRpC66qNotNXTZ5QZp4u3IdsV9EB9uTawnc0mzP/a+QOZTPzaEHEWVmwQiNGvBnNuPeDp9Y4QWkmftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745373071; c=relaxed/simple;
	bh=m9fotEzMbtcauOy4uTRg+1Bk1aZ1d6D1D62upUlof8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/m4PND1wXER8qEeswbhhyei0ZZuXCLCYn2UN19Ew1SjS2EZrA4rsJCkOx8pSfXRY30QjZ9zIXstgC9rjAK7gHyMd1+sxhXMj0aoFEGcvA5YVzvD2RFFWCtWcotJN42LO8oD210azw/lFjcD7rbHKvor1gtXapvnc7QuGJc2L6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucamzGIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6925DC4CEE9;
	Wed, 23 Apr 2025 01:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745373070;
	bh=m9fotEzMbtcauOy4uTRg+1Bk1aZ1d6D1D62upUlof8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ucamzGIjXxleCU8PgLZzb4MSWYe+Ja9cvbQe31sVjAOBXfN5HzWWn8Ne7hlu2qT1p
	 +m8gpu54/lL0RMSdxP9kv2nXdjFQU9NpUw4aBWPPhLKUmwvMCw5WRgp1jtnt7ttTHl
	 A5z6rZz+GPkTzTdCBtfN6knQMrAJnw+4ual4RlJgaZIhSXyzpKGhEC3QgDuwLF7spi
	 UqwMYEvRaCRqYd8Eykzhz9hIQ8YL7ZTol1GJkqV4mvZFKxe8TorKHv4jRjLpsUOXV/
	 oLDLS5odr4RKC7Jj1XYSJKklENyO+/cr72W6UjBX7BZphqeO7rHQlvnSZ9eL2NNS47
	 StihSbKeMkBwQ==
Date: Tue, 22 Apr 2025 18:51:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] bnxt_en: improve TX timestamping FIFO
 configuration
Message-ID: <20250422185109.0813346f@kernel.org>
In-Reply-To: <20250417160141.4091537-1-vadfed@meta.com>
References: <20250417160141.4091537-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 09:01:41 -0700 Vadim Fedorenko wrote:
> @@ -1117,12 +1138,5 @@ void bnxt_ptp_clear(struct bnxt *bp)
>  	kfree(ptp->ptp_info.pin_config);
>  	ptp->ptp_info.pin_config = NULL;
>  
> -	for (i = 0; i < BNXT_MAX_TX_TS; i++) {
> -		if (ptp->txts_req[i].tx_skb) {
> -			dev_kfree_skb_any(ptp->txts_req[i].tx_skb);
> -			ptp->txts_req[i].tx_skb = NULL;
> -		}
> -	}
> -
>  	bnxt_unmap_ptp_regs(bp);

drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1129:6: warning: unused variable 'i' [-Wunused-variable]
 1129 |         int i;
      |             ^
-- 
pw-bot: cr

