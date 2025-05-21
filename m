Return-Path: <netdev+bounces-192115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67508ABE918
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286D54A79A5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C7199FB2;
	Wed, 21 May 2025 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6XE+Oxt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5D199EAD
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790920; cv=none; b=MBizdQCS7UrpxZCPCpaooOZ4Zu3DT/8F9UFdy9H3Dc8IL2Zf+uHtndPDcEs475q5pQ7t93eKPcz+6UzKZJdiN0JhLV8jcNMXzh+1uPBzFmu/faUln2jCCjfwz7CC7U5XoIVB1DkZuBQdPPUAWb2ELKrBTQjnF9iFIwpztvEvO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790920; c=relaxed/simple;
	bh=YEwfLrwE+rYyH5nlEO96E6eB8ywT+6cMvBxfLWdLptQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTsEz91DY7AJ+5aqUJcvv9W/3GDumtNAhrvaWOFKRwtDgv+Rd2Gpw2uLiVuIq4hNfTUVWNdPLPQRP/4t+qEefz++XNtqKePdj9Npor4nDqM/N7lo0Vvfkv3vJMqAnyezm0TonnZiDw2np0vhjdCCGJxgzuM9BTQLbVVU4ql7Ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6XE+Oxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CD2C4CEE9;
	Wed, 21 May 2025 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790919;
	bh=YEwfLrwE+rYyH5nlEO96E6eB8ywT+6cMvBxfLWdLptQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D6XE+Oxtv2tidgWxbrHJE3EEQSZ3wgntEL+7kU8mXHLccs2I0l5PRn20cnr4wtU+Z
	 iswQhLiomiY1MS4VbIZEdc/n7IhQOK20k2gcEQfecfrrxLRkbBF74Wsl0mNA2IsF4b
	 VNq5Cf7/upDKiRLTXKj9xOMAGZs9DZsorMCuoAmKbAsLbMPZHRwkRekhR3wUtt3p7e
	 uUTM8aoXqO6ZdP75pefS9cmy3DFsA/PWbDK3tfrm4mhxU0uW/co89WlPJd/mzpB7PA
	 Jq5cNJU8+4fvg3+ijzmA7ZVePBWdA2nbaH1nOAh3tTI0EK7Qt5/DdKEOfTns/oENBh
	 zZidsmAPoO9CA==
Date: Tue, 20 May 2025 18:28:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS
 contexts on queue reset
Message-ID: <20250520182838.3f083f34@kernel.org>
In-Reply-To: <20250519204130.3097027-4-michael.chan@broadcom.com>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
	<20250519204130.3097027-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 13:41:30 -0700 Michael Chan wrote:
> @@ -15987,6 +16005,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  
>  		bnxt_set_vnic_mru_p5(bp, vnic, 0);
>  	}
> +	bnxt_set_rss_ctx_vnic_mru(bp, 0);
>  	/* Make sure NAPI sees that the VNIC is disabled */
>  	synchronize_net();
>  	rxr = &bp->rx_ring[idx];

What does setting MRU to zero do? All traffic will be dropped?
Traffic will no longer be filtered based on MRU?  Or.. ?

