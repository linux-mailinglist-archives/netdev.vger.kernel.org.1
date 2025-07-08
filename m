Return-Path: <netdev+bounces-204741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A546AFBF2F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBC2171B1D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE4273FE;
	Tue,  8 Jul 2025 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvnORj7R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E91758B
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934049; cv=none; b=eTvZ+MQ2+MHTvEvO4D88PkmD2sTh5DgMdNsnB7iHJDN0OoOHvVB1zay1Zdkbg397RhpIhc0ro/J8/tAPo6NNr9VeADwUSN4p+35F6Bp85JfjSX9tqujlzRvSD+FCQ0xa45ghukOB+EJZto9RZEWme0Xwk6zBGR6hSEqqptQvK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934049; c=relaxed/simple;
	bh=3rfnde9VeIQkvGh5l0YHlERpcU0aH1nKVK3KkvjMh6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQuGSYZDBZyOz2nE0BTz9kfLLWablr0I7HaEcnV+QrhJhf0gIOZsUT1DQ0t444hK/zQ3ciUI22LnigZbdwCihAVKUt4yFMc1mQcWefbxWT+mu2+Rymh2i7tLsfUDPvXRvH3Ki8eRtRtuHwTb0ko4sdXycGD3JY6ZkFkiYs3ZIVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvnORj7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDC7C4CEE3;
	Tue,  8 Jul 2025 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751934049;
	bh=3rfnde9VeIQkvGh5l0YHlERpcU0aH1nKVK3KkvjMh6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvnORj7RmlnzDFFZdzDae6YdBI47P+IAj6Rxbl6ptjf5iHGTVITbQ+AL/NnuVB1dz
	 xUfSMcfGkcKBul6mPjn9ETJJMgeDet8mHoEFEaR6OlI2AyLcIpVkAAgWU8fPyOmdHt
	 NBTocinse3DNd9yLimAK3t3IUQE2OVFtf+2HjrPd3isTTMFIuP18ck5RTALgZCAVLV
	 P//GDb8jyaQkN5y/8WsWJ12jSJRvWp1IlCFz20VkkNNY3NP5b2r0AaezicEW6W11gd
	 X/XauxQnD2BT+ayKGFR0yOf8/vrMHwF99hcvYf0upASHHMGPVUThqOKyHgsePM9Ds8
	 TnEvMwhaYhAzw==
Date: Mon, 7 Jul 2025 17:20:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
 security@kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <20250707172048.164d978a@kernel.org>
In-Reply-To: <aGxbckKft4_VxmMe@xps>
References: <aGdevOopELhzlJvf@pop-os.localdomain>
	<20250705223958.4079242-1-xmei5@asu.edu>
	<20250707105833.0c6926dc@kernel.org>
	<aGxbckKft4_VxmMe@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 16:42:42 -0700 Xiang Mei wrote:
> I read some documents introducing the Fixes tag, but I find it 
> hard to find a Fixes commit since it's a design issue 
> (lack of lock implementation on agg).

Provide the most accurate tag you can find. Often, for old code,
it's the first tag in the commit history -- 1da177e4c3f4

