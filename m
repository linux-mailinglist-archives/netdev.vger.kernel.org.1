Return-Path: <netdev+bounces-56174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9484F80E116
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 136BAB2078C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1684F81A;
	Tue, 12 Dec 2023 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV7vWYe+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED176EDC
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AD8C433C8;
	Tue, 12 Dec 2023 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702345817;
	bh=aEACnAx0dW+r4yPxCfeacKoyKPR/3sAEe5mRq6573xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VV7vWYe+q3Gl7u5Tx5beeqrbJad5CyPuYfpQcJAQ++E7/J+PILpkyRxF+u2P3gsnU
	 kTSd4Qhh68xO8CuSZH203It3E/cJ4rr/L2sATBB0McXSX/eav0KmDRmaDBwVll5hOs
	 YW6KcxRCf5wMn8hx0p+iYBrFeRw+UbiCexe/mQh8vRLSI5QWfRKZhSMZcx4yf9DVO/
	 4wy9WnX33Ht49liH88yMoe5VeFd6MFBW4kwu+w+h9zT5qNu2RW2FieAepfCwUe3E4e
	 a8FIB4FkJVK0e4UUe56AR52YG6H1Yda4r3Hr9hkDeLQlORs1Mj56MJVLAE7YRfIx0p
	 Y08ubX4OBof2w==
Date: Mon, 11 Dec 2023 17:50:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <mkubecek@suse.cz>, "Chittim, Madhu"
 <madhu.chittim@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>
Subject: Re: [RFC] ethtool: raw packet filtering
Message-ID: <20231211175016.461e2692@kernel.org>
In-Reply-To: <bc2cad6a-a456-4aa2-aeaa-157b3cd48b57@intel.com>
References: <459ef75b-69dc-4baa-b7e4-6393b0b358ce@intel.com>
	<20231206081605.0fad0f58@kernel.org>
	<bef1ce9b-25f0-4466-9669-5ea0397f2582@intel.com>
	<20231206182524.0dc8b680@kernel.org>
	<bc2cad6a-a456-4aa2-aeaa-157b3cd48b57@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 16:34:42 -0700 Ahmed Zaki wrote:
> I agree on the n-tuple hurdles, but is there a tc/nft API that you have 
> in mind? Not sure where are the overlaps/duplication.
> 
> I couldn't find anything that can be extended to offload RX packet 
> filtering/matching. Or did you mean __create__ new APIs?

Look at net/sched/cls_flower.c and grep around for struct flow_rule.
struct flow_rule was supposed to be the common representation for all
flows at driver level, ethtool, TC flower, nftables. Very limited
success on the ethtool side, but grepping for it should lead you to
the other two uAPIs.

