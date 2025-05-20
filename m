Return-Path: <netdev+bounces-191905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41BBABDD92
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC93BCB7C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A71DA63D;
	Tue, 20 May 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeCb+Ssj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A318DB2A
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752124; cv=none; b=HbvdBLRmPDC0q3qT76ECB6l3z9WlDKMe/drOTqznzvobXvCxsAQ7qFiGOk5Q4jUmsCjgn5S6/lJadPv2Bt0PYsBCB8ayCyHgykm5OSIOCwU0CDGhUugHoQINv3UIwsHKSQ+uqEJs72zq29l0U4QQ17TZ0D9S/rAOIeTVlDh/R+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752124; c=relaxed/simple;
	bh=puCK081m6gtDaZGtoDupNAkqW1v/7cVBWe0zSO4mero=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xxr8917Fooro8SA2LMLnRf4iYXtrH0BALUCKTTGNqR3gNp+6xqM63MxBMwoIyi+eHQ0P8AFu22SnRwdzwnXPWrUHHN5yFVL3/ed6m91nmEnrw6bcRZnYAUnRgxH0+9ECR8MG81DjxDD+uXBoqFFzYjN4V3s1eZnpxvHP6hZdsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeCb+Ssj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEA1C4CEE9;
	Tue, 20 May 2025 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747752123;
	bh=puCK081m6gtDaZGtoDupNAkqW1v/7cVBWe0zSO4mero=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeCb+SsjW6oPYnm+WoVOO0wVu3fUN7OA+9l0cgSUP4/JZcAD+kMYgGZDwWTWwAskP
	 O8zSSCaaVpQxEnEMBdbPqApANhQDthcHKLBb/6Pey84zyb3xzCzmzgMrm/daVGfPtu
	 AhpuoDaSEnCHYRGc5SbTgqT0PtdcC9BbY6sv1FPTTC4hTO2Lkr73l+km/Pz5oOnNxm
	 VEbXwARTlPJH27wCWH8VvVEIUTOuURk3IlgLPjdzTS1Oii02rtc0kC2x3wXo69RaB/
	 400UnogctHUy+xwyU9MkUeGBgYqbeP1AsqBZqLjyJeznmZ3LNfrbnTy78H021Sls5e
	 mcFtnwWfjoAHA==
Date: Tue, 20 May 2025 15:41:59 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net 2/3] bnxt_en: Add a helper function to configure MRU
 and RSS
Message-ID: <20250520144159.GW365796@horms.kernel.org>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519204130.3097027-3-michael.chan@broadcom.com>

On Mon, May 19, 2025 at 01:41:29PM -0700, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Add a new helper function that will configure MRU and RSS table
> of a VNIC. This will be useful when we configure both on a VNIC
> when resetting an RX ring.  This function will be used again in
> the next bug fix patch where we have to reconfigure VNICs for RSS
> contexts.
> 
> Suggested-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


