Return-Path: <netdev+bounces-208957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B7B0DAF0
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3085F562633
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF212E9728;
	Tue, 22 Jul 2025 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcAs1mxG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7954288CA7;
	Tue, 22 Jul 2025 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191421; cv=none; b=DPp8bB18OyzJimP00hnZa7qwydwx257hdZS6NYCMnGLXe31nZMzqbN2NngKbvADEXtyEzS8w3V/2VkjvrrJb/XzpILHE75CPXAqjUEtzG7LbOZfYwLmyROjhAR7iUUMG9EXbeAIXib8WyZ0FlPEctviW2u+5NrfwkwYcfngLFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191421; c=relaxed/simple;
	bh=OLtsNCN/mVtmIDBr0zUT/Ud+gMxwwxwZFvH9g9qFLc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0aV+MXOzdjTTIhyCRaAWgn46ry/BS64hFZZ4mOmN3mn2fiKlPtP3+W8poBSXeQUhhHPE2tkL7exzEYXijzRBjyP9pYL97ymJnCrw9VsJfJWA1fUnhQOYh13WiZrUFf2EEOXLzp7Tpx/E9ebxD2/kdiTVYCaxKaJ10KHAW20R8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcAs1mxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC080C4CEEB;
	Tue, 22 Jul 2025 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191421;
	bh=OLtsNCN/mVtmIDBr0zUT/Ud+gMxwwxwZFvH9g9qFLc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QcAs1mxGN2ObuMekwZxCHspOj0Z5RhcFmPsSVE2wpvwXSSDmrDx47IsQPZ8U8WNkL
	 wg8S0fsZALh8kNSq1Cy7RRp3CLV+NNIoUT8P/uReK73adR8a1LygqX7GGkdsEz45QX
	 wqbFZZ1DIN+Wgise7Vk0Nb3OwFqhVCBq4QaqXy3atqSmqHSNxAw5aIQEfg3X6NpjAE
	 r6twe88SZqPu0nS/87ZspWLi/0VoLzv8QJejSuPcwI1XIg1N6yvVE68uzfEvjSWz/x
	 Cx8RPX1DiewS3cgXjp/s2zxrZ+ZghvS6ycJyERJZaq/mXDY718aWOpZW9HED0fMtzz
	 cc7UaNq48E8Lg==
Date: Tue, 22 Jul 2025 06:36:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, sdf@fomichev.me, kuniyu@google.com,
 aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in
 dev_qdisc_change_tx_queue_len()
Message-ID: <20250722063659.3a439879@kernel.org>
In-Reply-To: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 12:45:08 +0530 Suchit Karunakaran wrote:
> +		while (i >= 0) {
> +			qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> +			i--;

i is unsigned, this loop will never end
-- 
pw-bot: cr

