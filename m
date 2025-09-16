Return-Path: <netdev+bounces-223625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A9B59BA8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A177A5861
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109730C624;
	Tue, 16 Sep 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCz//RN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5BD23D7C7;
	Tue, 16 Sep 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035582; cv=none; b=n8aDAm4KJtA923nOFI9e7kauMuQAfz9laoZ6o8aBjoCvN3zVrgf+kXd3wJzvBu3EvsiGnNhqp6XMwpqClT6MNnRSOeBGhQf5XsHihKPFF3LnF77emL6T2rHWErZ0zi0APELEC69nW3dUILeMgDV0nmcDr4O4E7gkstYctxP8hRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035582; c=relaxed/simple;
	bh=2FZDkp0U408O78ydTVFiSxp7wUT3F2qU4yMPaoDfsgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZCiXmyBKFVSgSTrKgizePMzx/jt5z6MdEZsA6zDa7X8K1TOJyE8/htzCy6tPHytWdmq28nFxYBNLDZ5+ykVE9Jynoh1s8wnwpGvoU5D14VnIqRZ+OYGLww/CUCcWy4x0BmEekMEMxH9GTWiUIG79F1XNPPjHqDUFOMa6T+SRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCz//RN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21FAC4CEEB;
	Tue, 16 Sep 2025 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758035582;
	bh=2FZDkp0U408O78ydTVFiSxp7wUT3F2qU4yMPaoDfsgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCz//RN0LkHuFUivOXXPVaRj/8ft84O+/GeYjUptWCTFUTPIMOZNnTAMsS3nUgdPf
	 5cD8GgDQoJWVQA5IIiq68MW/zJsYBhoyQWeHHYpDtLJ7k+9/iy06mWFEYnRfhr6HkK
	 EzQS1jqwyoJKP9T7Jui4w47R4w9oMJhs1soixwZQWse+oAyGlbAFY0TsUDAyA0OXPD
	 NNJKZfiI+mjaBQVFl0rtilMiRUv1MUyzG2FUwPGn3TBkKkTBnL2kxa/dJrPlmeBpF9
	 nulfCvUpgm4hBj9+UbDCTyNI9AUfoju+jVhgcNzHs7lxQKkdBhgcwK90GLg11ULu0c
	 736R6LiVVzFeQ==
Date: Tue, 16 Sep 2025 16:12:57 +0100
From: Simon Horman <horms@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [v7, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind
 on failure
Message-ID: <20250916151257.GI224143@horms.kernel.org>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-2-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911193505.24068-2-bhargava.marreddy@broadcom.com>

On Fri, Sep 12, 2025 at 01:04:56AM +0530, Bhargava Marreddy wrote:
> Ensure bnge_alloc_ring() frees any intermediate allocations
> when it fails. This enables later patches to rely on this
> self-unwinding behavior.
> 
> Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>

Without this patch(set), does the code correctly release resources on error?

If not, I think this should be considered a fix for net with appropriate
Fixes tag(s).

...

