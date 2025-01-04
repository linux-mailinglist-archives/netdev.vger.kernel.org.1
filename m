Return-Path: <netdev+bounces-155173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4EAA015A9
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D703A3EE0
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D71C5F0D;
	Sat,  4 Jan 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJlIS+nV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E41BD9D0;
	Sat,  4 Jan 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005883; cv=none; b=gipOtMJwkjjezdMBN64GPm8SCUK5DVGnxm2strt/d56tN2M6odzUwiWEaCOj1Cy8UsMwN2ojAd08nGhHuwKUWluzf8nS5FDsvpL5K9cDf+fbP2GYpmNXIX9mA6FOL4LeDcD0HWoVINk1mgZxYLLzH5rAvK6V6R8w6UGCO28CNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005883; c=relaxed/simple;
	bh=It380Mks6V/DCwFFzYpAvM3nnZRcp+sKju14z+bLOZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSR9zP1wusAG1Wyh1wrmThX2iR0zUoun+hzFlQ+JKjItbeoM1dLhW0LdcxEbzpKQdudWz7eZTlla/OuUM5iV7xBz4N87evu+cty+e9vfE3V0r0i6uFYvPw+G3XlXwjm/WXeVE3HpfETvFqVeR7V328v/Afxo8az9f8fQoYC2Ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJlIS+nV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01928C4CED1;
	Sat,  4 Jan 2025 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736005882;
	bh=It380Mks6V/DCwFFzYpAvM3nnZRcp+sKju14z+bLOZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rJlIS+nV7gOv/Jka7mG+Fk241wSz/0FSug7cCwDR5J74+85VNRZFdSQe1cgUv/Xnx
	 GxoFuZ4HWEMJqZEhw1FBTcQrTzQgO5lQ6OumYeDMa4mAbtVHU4PsIdVnVjKQ/f7QHV
	 WbHO69qdPZGRHlt4qSwdTixPhrGGAPIqk30razuHL36ny6lAQcTMtL83Q7Jb/use+5
	 A8dEAePsSemKCOFSNsvUTiZEpW7K949T/DfTroRK06ZUr6z9u57v+rwRFwGfRnO6SC
	 8xDrFMbuw0eJxf1wib84OjfCFyXxzS8onZoJHU52Z+8BVxMepGuMZi9ZElHuNG0T7q
	 a1jl0ucu+woOA==
Date: Sat, 4 Jan 2025 07:51:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v2] page_pool: check for dma_sync_size earlier
Message-ID: <20250104075121.393adef7@kernel.org>
In-Reply-To: <20250103082814.3850096-1-0x1207@gmail.com>
References: <20250103082814.3850096-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 16:28:14 +0800 Furong Xu wrote:
> This is a micro optimization, about 0.6% overall performance improvement
> has been observed on a Cortex-A53 platform.

You need to say more about how you measured this improvement.
Is it PPS improvement in a traffic test?
Measured using a micro-benchmark?
Based on first order metric or by comparing perf output?
-- 
pw-bot: cr

