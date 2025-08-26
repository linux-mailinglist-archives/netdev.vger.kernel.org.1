Return-Path: <netdev+bounces-217008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDABB3707C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8437B429D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4033164B4;
	Tue, 26 Aug 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQRDt+WD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1772C3261
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226106; cv=none; b=qmPPWsItj/7S/v49EYC8gNqObPI0kCLKbOH16rIPu1cJyBl4u/zBU5QK2ebgmfJYU3OmZaY80RMpTI3X7OgGJABtuJkxAFB8otJxVzJXsrfyE7bgK2CrfYwr2R24hiwVVRZVxrhG1v1fB71WxJB5pSSISwIAfJ2ASVvR4xYTm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226106; c=relaxed/simple;
	bh=W1n1sAkc0JdMu9jx8ALDS1TpplDfSrk9aAQmda91AvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq2xua8STp1c0B9ScRMHzz4d4n8UU1mMgjcbLXqstz8oD5rFJJI+Vk9JMJ/9us3s9eOBhFTX+SZrrmdlfsbbVn8ep6IWOjXGQ09Ha2IBWHl8o8DMhPispqt0BdnmHVAyKb3q4xA5PQmwvtfVkHRHJvpAmD2EIOxZ+hmZ5I8rKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQRDt+WD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D65AC4CEF1;
	Tue, 26 Aug 2025 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226106;
	bh=W1n1sAkc0JdMu9jx8ALDS1TpplDfSrk9aAQmda91AvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQRDt+WDihtX4TcTVNG69PKKYdZvbWuk3GduAi+PG8mmnqkdY+I75+5WL3MLjqUXt
	 0uvdovT8cvi3c5dNJXc9UcAgWAN35sT9IyJMoDQRx0RFxID4fS+OP8yPVxJg3kfteN
	 cihs4iALoR1PVttxSqwgY7Vl+yjkBBFPDkMngA+latfzW1XpP8yrCDsPix1AaRkx1z
	 4aYi/jrj1M3AyWY2O0ALmVQMjFYVZzh8cU2E70ja+HySQgvfXwmEYaHma8BEd3g1a3
	 rsydI65KtNxkVjGzM/gIDz/mJJXBpZWMkxnmwhOqF4wgbMXC/KtK19EuVeFUHMqEvk
	 WirbedRT1fiaw==
Date: Tue, 26 Aug 2025 17:35:01 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 1/8] i40e: add validation for ring_len param
Message-ID: <20250826163501.GF5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-2-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:11PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> The `ring_len` parameter provided by the virtual function (VF)
> is assigned directly to the hardware memory context (HMC) without
> any validation.
> 
> To address this, introduce an upper boundary check for both Tx and Rx
> queue lengths. The maximum number of descriptors supported by the
> hardware is 8k-32.
> Additionally, enforce alignment constraints: Tx rings must be a multiple
> of 8, and Rx rings must be a multiple of 32.
> 
> Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


