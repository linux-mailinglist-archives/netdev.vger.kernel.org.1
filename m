Return-Path: <netdev+bounces-247097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B66CF48AB
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E520031304EE
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222BB31B13B;
	Mon,  5 Jan 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzZiw38U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A83081B0;
	Mon,  5 Jan 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627699; cv=none; b=swG38uHqw1vojYL6OeQr64L7c1C7IPEBM79G4u5qRiOi+Z7V1cPBYQsKPulvNBIA9/yucuAejYBdo6H7V5L39BB3X3bemuK96di0W4+c/qB0QtxA5O7VHG2YNz9eP3w2ApUC21NKty2LcDf+LQKCr2YzSd/YoiGSk6QcW66XoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627699; c=relaxed/simple;
	bh=1Ijh46HRsW1cKwv45Sx0QnTqscqwwIKQh4+5jy8NEkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApE+OJvYGgTC2M6rMAk0jFrB46sowmV8SiA7VtzOAkRH2U5yqaWQP39RM1NgIt38QclkoWgzGxg2OomK4tS0mLHvr6h5UpMujsdAM3MnDAcW/jAMhfwdZU48Rwjg5ancm99mBcBVaJR2RzZpDk1XsfsDksZmBNYwmCGHnMpOnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzZiw38U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F806C116D0;
	Mon,  5 Jan 2026 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627698;
	bh=1Ijh46HRsW1cKwv45Sx0QnTqscqwwIKQh4+5jy8NEkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzZiw38UuwmMhLxZZ53n8lbsIco8flDvmO4L5OqtSGq70TPDPSxntzwOMoDp5m0vS
	 uXDuIcGPep9BGyG35OK83IWn94qrnjcPkNTHi4BhoRxkDUEoebQ0Ch9aP/n/pf0rNl
	 H1DN1JD/b60T91cwwptfaRYXUNOgajdaG9ceokmwKzKby7c22x7d9UOXCvdkNCpuId
	 2/Y9FN2JOPU2oDNwIU0vIIKxsrswodcq6nKQeeXzKv07RTjzFFffCCWUWvKnCcvJYj
	 flI6iW+RryGiqaPdIcLkKjvModZDmJC4NkaFgOzcEU7VJQfWyisilu7dbQHqcCWOZ5
	 XY9jCQ6kxicfQ==
Date: Mon, 5 Jan 2026 15:41:33 +0000
From: Simon Horman <horms@kernel.org>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2] i40e: drop useless bitmap_weight() call in
 i40e_set_rxfh_fields()
Message-ID: <aVvbrXplVVKWQL3F@horms.kernel.org>
References: <20251218015758.682498-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218015758.682498-1-yury.norov@gmail.com>

On Wed, Dec 17, 2025 at 08:57:57PM -0500, Yury Norov (NVIDIA) wrote:
> bitmap_weight() is O(N) and useless here, because the following
> for_each_set_bit() returns immediately in case of empty flow_pctypes.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20251216002852.334561-1-yury.norov@gmail.com/
> v2: don't drop flow_id (Aleksandr).

Reviewed-by: Simon Horman <horms@kernel.org>


