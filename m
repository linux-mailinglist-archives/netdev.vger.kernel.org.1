Return-Path: <netdev+bounces-131857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19E698FBA7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05641C2236D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894317FE;
	Fri,  4 Oct 2024 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJrlB7ow"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B517C9;
	Fri,  4 Oct 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002442; cv=none; b=BSQ6gWGsTpZnaQc7uigRcxzSmPncjAj6GAlP//ItCl8fEvS7b4R/Qb5tTiKXyJjfcQAyBsN8MYAgzLfR9jbUWJWJfCOG3DGMjr/WqtHKWLfENZeusk9dEqDBgUHv9GyVrD6emnNX2HqdfDOveOeTFalxbP4XRIeBCoHUXU9GUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002442; c=relaxed/simple;
	bh=9uRLFxdti3g7bCIL+0m4CwFKM+d5QyiiCmoorhDKUOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFt4PnGxemzH+O2ydsnG8HK2KvWBkMBxI/ns18uF7LOonS+q/EoiHd9f9OqIVuGquUlEzIauCZXsUSU8ah6f5w3Ovfpt2FvMquhOATIIQtTQFWfbDqSo9LLwMSCB45PyxJQML4szgGBoiCykMuqReOcHYWd3KpbW047YpfvPS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJrlB7ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83418C4CEC5;
	Fri,  4 Oct 2024 00:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728002441;
	bh=9uRLFxdti3g7bCIL+0m4CwFKM+d5QyiiCmoorhDKUOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bJrlB7owk9ChK4ILf28pCw56/V4cCPyiwpBNbJIooTnQYvHD3FPWGnR6b18aNC11B
	 nlKkqVmPokfCcSsz3KcWLiShqzIFBZPscO/e26uROBoU6/LpgQMZ+hLJUrHa1rIrz/
	 K6GVo0qSMLWwMxtNSuiZOipqqqNGcj9Ifi/giGfgp1r3cf9RdjEjCh1KgMhpCcUJ/6
	 gu2Wrn5GTkYO5MJIuVsCBZc3XgyOYt963nWdKDZWKLBembRrxD7Iq4vUXg2me0JE8m
	 P6OmlEJR0FKKiYwBjCTxWmBtAt3O8JkIua+RIspkLeHO6wQ4Rw3R8XAO++/oVG66hL
	 3R7KWD+IJv/4A==
Date: Thu, 3 Oct 2024 17:40:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
Message-ID: <20241003174040.5987bb4a@kernel.org>
In-Reply-To: <20241003172105.2712027-3-nico@fluxnic.net>
References: <20241003172105.2712027-1-nico@fluxnic.net>
	<20241003172105.2712027-3-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 13:07:13 -0400 Nicolas Pitre wrote:
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")

Please make sure you CC the people involved in the blamed commit.
Run get_maintainers.pl on the patch not the file path.
Please put your SoB after the Fixes tag (last).
-- 
pw-bot: cr

