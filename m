Return-Path: <netdev+bounces-166701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9035A36FE9
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214E07A2B46
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFFF1DC9BB;
	Sat, 15 Feb 2025 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwd0xdAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF0194C61
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641317; cv=none; b=k5cOzsL+V0/D5BfUHgTfUY9+y7Rdnkj9J9Qee23ik1oTMwR7DjaH6OM1/qviI1W7Fb/PYXFFDjT8ELhOGzRCpvcyeDvJUYOisCLxLdsjZKiiteqvC2SMYq8y18v1DGNE3CH7xhjr3SW+Gok7Oz7ukJBdkhC3b1Hg3fnbtSBwfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641317; c=relaxed/simple;
	bh=gt3eqv7a9kh+Gsq8p21OcFzGFMQTfelKF9D3p8oHFac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKHNJtXtD8LEMCNWdPmmEJH/jIJn5rbnaoq1vo8NL6TAlpltMwX735AOLI7XXjZQ68BSzT0QSP91fl330D4AEmgDBmECf+6oAyS9/X+hEBpedcNEoWE7Iwo5H+XiVhIwnN1c3JppEJfp9Ygj6qmUGuuGCRyYePNE19mq7OOrvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwd0xdAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23E0C4CEDF;
	Sat, 15 Feb 2025 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739641316;
	bh=gt3eqv7a9kh+Gsq8p21OcFzGFMQTfelKF9D3p8oHFac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nwd0xdANyClMZf1j7d0pTWwfvlg3U5aWW/ktc81K6HnqPLlddlucnBDDeaEXfcNsU
	 kjnjnpeOBYtt0vPbB1LAGQminCgT886gYY4it+qqK7AMM/O+Z20iuqVdusTD8Nhact
	 PAkQ7zEgnYrRberN4YdhkhisN4oNnhbjJu2FV9oA18l0wBdszrxgryU043UMsLNglV
	 QeJ7Ta4E1oeidKLxm79bmlFAlS17i7bvuQPwIpmyBo5W8RhuCcY9OQw8Nntx3hYNHx
	 MQudz75BP4lrXQsDBMD4s4h8s1f4/ugm++/H2qeHNwlPBj4qA6b342irI9FXPcKA61
	 bNanh8iNfoG/A==
Date: Sat, 15 Feb 2025 09:41:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v8 0/6] net: napi: add CPU affinity to
 napi->config
Message-ID: <20250215094154.1c83b224@kernel.org>
In-Reply-To: <20250211210657.428439-1-ahmed.zaki@intel.com>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 14:06:51 -0700 Ahmed Zaki wrote:
> Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
> after reset. However, since there can be only one IRQ affinity notifier
> for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
> management in the core (which also registers separate IRQ affinity
> notifiers).   

Could you extract all the core changes as a first patch of the series
(rmap and affinity together). And then have the driver conversion
patches follow? Obviously don't do it if it'd introduce transient
breakage. But I don't think it should, since core changes should
be a noop before any driver opts in.

The way it's split now makes the logic quite hard to review.

