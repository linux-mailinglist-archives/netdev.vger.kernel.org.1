Return-Path: <netdev+bounces-242428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22885C90582
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 00:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CE454E045A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 23:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D9298CC4;
	Thu, 27 Nov 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM7O+sLH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A94A0C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764286606; cv=none; b=un0vCoXKFD4csPJB83FIeUaNzjF2+2HTuEosSc0qPLxB10SKIE6z16oewdP4x4OkUvfz5EgQfeJK8tZGJG/6RjvC9adhr7zMbOcbH+3NzFqoI/vAEcFOL1csLf/SUmZzRAy10Z0ZhfRnKzZSIDGOcTj0GMekHrajBlYWBPnnhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764286606; c=relaxed/simple;
	bh=34KozKoOVCmT+6fnS1OOQMxNpW5m8bk9dYmhP2vKwYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQH0s/kuIe1fqGMuM1ZqtW/Io2Wnb0JexAdq8YWbJfmeVXUbDzVL+zzZrcgTBvb1QwAynS1eE247zJoHkfImf5SdPIBi0t50uGIg4dhiF7dG9vnEOg9XOOwBmmJWNSOG45pv8gaBPPvnpleJWagQDBJnp85lN75gl5qCVSNOYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM7O+sLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52D5C4CEF8;
	Thu, 27 Nov 2025 23:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764286606;
	bh=34KozKoOVCmT+6fnS1OOQMxNpW5m8bk9dYmhP2vKwYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GM7O+sLHQe2TWcnufenIMMz9qPJHizbr/IzJAQqhFAVwpfiUENzpz/7cZs2iH94FZ
	 9B1nMlScIz9crUcUbv4MLW0yJynaZS7PRPc1RR9gmnioyBA4aLBZGKy+IuGj8zaraC
	 ct/0Nh4Rj+5t+JtrFX8mBWHLeLLnRNTKu//9+Gd3iRcsAh5V99TrBuBMF2tjPqzAxb
	 RzAXfdQ982OYeAptmqCV7gC/TsASXjZz9mfF9AwEkkKVOwFoKjXpmvvbxvvXd2VcpS
	 c2tFw0oSGv+32usdJKwUqpCBe7Osux7Z1mDSPDstuDbr/1x4OwCduqPSDgv0F08iHC
	 g6H/CteAL7q+Q==
Date: Thu, 27 Nov 2025 15:36:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, toke@toke.dk,
 xiyou.wangcong@gmail.com, cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v7 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
Message-ID: <20251127153644.55ef4796@kernel.org>
In-Reply-To: <20251126194513.3984722-1-xmei5@asu.edu>
References: <20251126194513.3984722-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 12:45:12 -0700 Xiang Mei wrote:
> In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> that the parent qdisc will enqueue the current packet. However, this
> assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> accounting inconsistent. This mismatch can lead to a NULL dereference
> (e.g., when the parent Qdisc is qfq_qdisc).

This series does not apply, please rebase on netdev/net/main.
-- 
pw-bot: cr

