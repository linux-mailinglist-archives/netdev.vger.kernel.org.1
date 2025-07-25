Return-Path: <netdev+bounces-210246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6423B127AF
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85591CC05FB
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A902620C6;
	Fri, 25 Jul 2025 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG2xZG8x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3A26059B;
	Fri, 25 Jul 2025 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487688; cv=none; b=CMccKZsnai4Ij4rCM/d8PSb2YakUipJ12+/2M1UY+vh/6J1oqFr5fSN1S4eUjEuu6uISimTthIMiS2wbMeogje3qZ+75CRG7/4e1TsE5EX2PfCDoaUSsoJX25hNyv3kI0oaKkTx/he/6qqXkf4SUXTAmcKN5qjq7nE8npW83Qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487688; c=relaxed/simple;
	bh=3YPwVG9DsCCU8B/MUswrf6lLUp5y/h0OkLU7cojJUjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/wZXNtZo5UhHLj/9c9faVZR0Pudm8ZzqECdOps6VBH7aC7fMHyE2c4BR8brYvu3PpFaYArWcjEgBeD+0d7xkye9o4E6/wrvXVowH1hgL4bqC9aHUXIrJGTdQVsrDuLc0LNlXcWvtX0/VpUu1J9apN870FcV2s6jR1xwlAZxwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG2xZG8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BDAC4CEF4;
	Fri, 25 Jul 2025 23:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753487687;
	bh=3YPwVG9DsCCU8B/MUswrf6lLUp5y/h0OkLU7cojJUjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kG2xZG8xmY5T6tosR/CYN7WhJUEfxn5eAsMSlTDip4hTD7Nug1atygzf6FQ8PCMi0
	 7mFKsFhmfzJ+0WD+cFGI7t0IcxkMIfZikGvUW66LiuU31Ca6rqfUYs4mHq7v7ejxTY
	 rIK5ce2SKbZkIP1mA+9dkIhbYVSFxHTukoGeuY2f5aOTqimJwe+KM8Au09z1XtjbYZ
	 fEungdqd2JeYKCt67oi2y80aMGJnb+fxx5Py3KeTYhkemqmKqXPZJt31NzlGr/yMJe
	 UgSLtzNSZTaLX8SpUiwyNJT4Nmx59JPl3IUZKaFigw8g3ijF2pmLfZl2whS/T8L/NT
	 aNfJKxstvNB6A==
Date: Fri, 25 Jul 2025 16:54:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengtao He <hept.hept.hept@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Jason Xing <kerneljasonxing@gmail.com>, Michal
 Luczaj <mhal@rbox.co>, Eric Biggers <ebiggers@google.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/core: fix wrong return value in
 __splice_segment
Message-ID: <20250725165446.7e90ba04@kernel.org>
In-Reply-To: <20250724121921.1796-1-hept.hept.hept@gmail.com>
References: <20250724121921.1796-1-hept.hept.hept@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 20:19:21 +0800 Pengtao He wrote:
> Return true immediately when the last segment is processed,
> avoid to walking once more in the frags loop.

The merge window is about to begin so we're switching to "fixes only"
mode of operation. Please repost this patch in ~2 weeks (you can use
this page to check status: https://netdev.bots.linux.dev/net-next.html
-- 
pw-bot: defer

