Return-Path: <netdev+bounces-228897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A263BD5AA2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44A7E4EADC7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427382D249E;
	Mon, 13 Oct 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFpXHkGg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB322D248E;
	Mon, 13 Oct 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379235; cv=none; b=Snvb0pXoAX8PH3GEk1WDN0ZvjdL9OakbmJASUZoeMHyshyA8GVCRw0Tptybbxg811ynlwkBsJx/AhnzRGs3RCzSB/SpBduaV1LQLhnzjK+zCyzEw0Sr1DQorg3+n3EMj8tFT4snryDj2n46XF4vudTJJyLhalUJmJ7MKVNHI250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379235; c=relaxed/simple;
	bh=g4WnPcnLhgZQ/erChASVCwhFQpMXdwHyKkLDVD94r5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZ6JtizcRs5xUPgy0dgHdBvzHb1XIEym+vq5M2RGEHoorL8aUSoqu93pVHuHRPEtucI5CMpFyqoqOn/YE7gGtHLuY9L2+fbZVJbWJ4acNO4Qx6GfSAVFij2uLm4zClP4i7Me/fyWht8DR+JT4hau2WA0e8PIbCUKN48SG9ww+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFpXHkGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B0C4CEE7;
	Mon, 13 Oct 2025 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760379234;
	bh=g4WnPcnLhgZQ/erChASVCwhFQpMXdwHyKkLDVD94r5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WFpXHkGgxGXRMgDhHUvjYBUhbwHGFgxqcs7WvklyHmqeUKOrZ9gJGJNSC+w1mUAJO
	 RdzC01G51KeYC5noPWX3U0+xn4kUGR4BxDudHRTpHZc+YAC07p0WZmm4/BZRmOupuJ
	 IG2NuFmrPxFrnfuDIfLjwvYK4oOJGi4qf4puDdyH5YkjT3P1l+s46zkqK8DZFGXj9z
	 51U/j3H/oaVNHGH3oFCFH2DtvUk1/iJaswXphz/Fg5vGKohivO2j/QyddL5hMSmwns
	 7C6mLF1BB1eZX7xE5kdSFNdk1snwgGeuJWtiRdmFaoW1IlMbY9ph9jK6VfskzhVSbB
	 tsP3toNytftvA==
Date: Mon, 13 Oct 2025 11:13:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Tantilov, Emil S" <emil.s.tantilov@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Pavan Kumar Linga"
 <pavan.kumar.linga@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
 <phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, Anton Nadezhdin
 <anton.nadezhdin@intel.com>, Konstantin Ilichev
 <konstantin.ilichev@intel.com>, Milena Olech <milena.olech@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Joshua Hay
 <joshua.a.hay@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Chittim Madhu <madhu.chittim@intel.com>,
 Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
Message-ID: <20251013111352.5ff15ec3@kernel.org>
In-Reply-To: <ae493f48-ae07-4091-98dd-db254f2ee12f@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
	<20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
	<20251003104332.40581946@kernel.org>
	<4a128348-48f9-40d7-b5bf-c3f1af27679c@intel.com>
	<20251006102659.595825fe@kernel.org>
	<048833d9-01f5-438d-a3fa-354a008ebbd3@intel.com>
	<ae493f48-ae07-4091-98dd-db254f2ee12f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Oct 2025 14:41:40 -0700 Jacob Keller wrote:
> Jakub, from this thread it still seems like you won't accept this patch
> as-is?

I haven't analyzed Emil's response. I hope my concern is clear enough
(at least to you). If the code is provably safe I think the patch itself
can go in, we just need a much better commit msg.

