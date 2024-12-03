Return-Path: <netdev+bounces-148318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C69E11A7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA73B22FE8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAFB13C918;
	Tue,  3 Dec 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHPVcotb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634D537FF
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195820; cv=none; b=nr0BqVF9Gso+3QvfRQpWe5DFvmOJBp8gsSp/FvQ6iDIs+rjyLukPNbhpmXLCgSQ3I8Z5Ue2hnlb+2zguP/8tsM2PJpZLsDCXO3GQx/32WbV9SDkCWCrqIdQWeVYdmlAp658oWVPs2/IOR7x+bZWuzMgV8Ppf9Iyo/fL5AZDXyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195820; c=relaxed/simple;
	bh=ISPROvKl8/9yxVhI5ASvuJLgm9kidhpnBdAOlxvshAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxUrLrPqROD8BHleIvr0BbIrWxATO2vjf9w5QDjOhooxjMxWHryXwJnpj+BE9qDpjLeXsJWP4ju1XQQE7ZcgHfFaekFaECyLWf3SY4j+Xps9CA4q4QKqrpyt3tDt4Y572lXShfdhBt+3cqcmeMDJ0FZ2T8iWExmbnOuQLSKAXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHPVcotb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43113C4CED1;
	Tue,  3 Dec 2024 03:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733195820;
	bh=ISPROvKl8/9yxVhI5ASvuJLgm9kidhpnBdAOlxvshAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHPVcotbs9Qb+OS9E/pU1tFx12+xlQQWJhppS/ABdVbcxeoU2y8+QTQeqiaIsMVCu
	 m+69EDhkuUiQMYr5OFaYen65HsqneHo8ryKJUb3KMX96HSF2yhq9cuE5zRGuby/puo
	 Z7Es3YVFsmKVveHPLCqjKRxi0rEmtzoOL+gUk6VS4X64IMnJsd0MphL5n7uE6eiLV8
	 EKLuuOa7B63IGuHYvi6YAKulqEU2LSCNtKOF5JtL7XA/s36Pw66f+WCL1c6odfFk6l
	 SPb7p47dapdZWVMN+JuFkDhfEXbubH9KrmMMU/UqIy98Ozc/3LCOtOhblpa/HWf4fW
	 JI4MKlAW8vbrA==
Date: Mon, 2 Dec 2024 19:16:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] mediathek: mtk_eth_soc: fix netdev inside
 xdp_rxq_info
Message-ID: <20241202191659.704d3b09@kernel.org>
In-Reply-To: <20241126134707.253572-2-mail@tk154.de>
References: <20241126134707.253572-1-mail@tk154.de>
	<20241126134707.253572-2-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 14:41:54 +0100 Til Kaiser wrote:
> [PATCH net] mediathek: mtk_eth_soc: fix netdev inside xdp_rxq_info

my $0.02:
 - not a fix, rxq is not a hard requirement for XDP support
 - if we want to do this we should record in the queue that
   netdev is "unstable" (new member?), it will make it easier
   to track the drivers with this behavior later on
-- 
pw-bot: cr

