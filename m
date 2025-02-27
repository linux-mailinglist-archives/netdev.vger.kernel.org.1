Return-Path: <netdev+bounces-170068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FCFA471F0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB611645C5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7449620;
	Thu, 27 Feb 2025 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0jGS07n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C64683
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622082; cv=none; b=UtA/5HFFFzolqAcrEAYhbL+L9Q8H+UbNt+DHCRs3aLA26odBkzqyZ5TDtmbijIAPcB1Vf2N1ITLxNynpAJS5fLGqnNLbDc0ocTtohek1C0rOv8HuKAqfywGVG6OBODzQAuSyHblaPW8f5eeGl1/lkMozVdRqmLUlKaXUyP7Uv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622082; c=relaxed/simple;
	bh=DPwcmo8P5AeXhQc8vwCT3neEqOkRVZZrfxxHJBAMoTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0k7dsBwF7TJa8KyCrqFNcBN/kJZ3jSVjP1lNldCHhD3iaCnKcasnmM3hycBGawOvUgbd1e8Vziw5Nw6h+23woZg4/aKLdaq606DQvp+CuKVyscrbynKDp92xvIdbaI9fxAr4Tscne+MAXN6zfWv5J5xlkm9XE3ZE+h8cxszfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0jGS07n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738B1C4CED6;
	Thu, 27 Feb 2025 02:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740622081;
	bh=DPwcmo8P5AeXhQc8vwCT3neEqOkRVZZrfxxHJBAMoTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0jGS07nKA26i2hun7/vaDiUqXbYODWTR7mcpAbM4nowV0FQlZEp3BfGYNp4lU2dR
	 qhNK4CikgiSmYyKFR/fur5IYPmYR8PfgnLdOojQR0aT0PB+O/fem19erSRDhOVVkAC
	 ET6OQPhLqZIZzCPFFkffiH4OBLjd8xjceJrXi9AcUBIn+94Uq9RKTjYHczgJpGMue5
	 oEFHNQKI/ClFz81dPVqysdRFvBS+TK54l6AGB3ryTEgWpajbY6rgHdhR3g4JUOS+Ne
	 Xh2xECDJw33h2howVesWLDDdKgembVb+j6epnGhtckqIobyUrdykthiMSYs5ylUGKG
	 RWuCjzhAKwkZw==
Date: Wed, 26 Feb 2025 18:08:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, gospo@broadcom.com,
 somnath.kotur@broadcom.com, dw@davidwei.uk, horms@kernel.org
Subject: Re: [PATCH net 2/3] eth: bnxt: return fail if interface is down in
 bnxt_queue_mem_alloc()
Message-ID: <20250226180800.7c0bfd38@kernel.org>
In-Reply-To: <20250226061837.1435731-3-ap420073@gmail.com>
References: <20250226061837.1435731-1-ap420073@gmail.com>
	<20250226061837.1435731-3-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 06:18:36 +0000 Taehee Yoo wrote:
> The bnxt_queue_mem_alloc() is called to allocate new queue memory when
> a queue is restarted.
> It internally accesses rx buffer descriptor corresponding to the index.
> The rx buffer descriptor is allocated and set when the interface is up
> and it's freed when the interface is down.
> So, if queue is restarted if interface is down, kernel panic occurs.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

