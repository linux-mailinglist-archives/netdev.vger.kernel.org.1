Return-Path: <netdev+bounces-166631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D384DA36A8A
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 02:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134951897279
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66033151985;
	Sat, 15 Feb 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRAff6Hu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5174BE1
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581077; cv=none; b=E1bagaqgHmO+FP3GUt7Nb/e4BI0wl5X3Cd4J33CB6QndgF9CsQ7NAQkEbaw3l+jxCQJRtyreGz/S+gPSTjTN4U+GwBQyCR68XOdg46tmagkn2HR6UxlD3xF3QA4mZwUfg7mdiPS9bWkP8677vawKSd3Ko7//wqZNjop3Eh8kd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581077; c=relaxed/simple;
	bh=sfhQiMAeKtuufJrG3n8kCaXeWpnueswcdP/MMKSaXM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cS8fmvIPdAJnzT5PGL7HQU8RV34Ivzq+bROjnfjZupdS/ZW82xJXTDuum9gMfQfVCUoHp8gRQJ8d7V+yIxiZvc+3VSRL32W7MuVEPVqSYFpmjm2yU58kSzkHyPCrtz0duGHUOgwDjy8cOOBlf65IYBkr1WzzmI6bKAX1Or3LBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRAff6Hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B49C4CED1;
	Sat, 15 Feb 2025 00:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739581076;
	bh=sfhQiMAeKtuufJrG3n8kCaXeWpnueswcdP/MMKSaXM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rRAff6HuWbiH6XdRW0paRH6V1JsM9JCauBTis8e4HRtpwYamLeN9Gv7YqjgorDgsq
	 WOWjr0kHrr6ieljmHiDJbHjeeEI380ijy0HX5gtOQ+cF2C+WYZPK7/niV6ooFcdoNc
	 uL1a5G0gub/L2Z+qOiGvgT6bmZciLfHlWbYGuX6A3wctyS689BgWLDaPP7bcDzLzzU
	 F2SocViNIEQBgBGR1QXUt1pmOb8E048Xc+E/nqo1TLvV4wMPoC7OvGE3pEi918WYob
	 8EMkHJomZsRwhI2CoNCAKjDU2WkNymaUXyl+pt/6RhkjNLIhznyG4QYxXFMr4ebo0h
	 tCUjdUHN6xXXw==
Date: Fri, 14 Feb 2025 16:57:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: skb: do not assume that ktime_t is equal
 to s64
Message-ID: <20250214165755.1f1ecc36@kernel.org>
In-Reply-To: <20250213101658.1349753-1-dmantipov@yandex.ru>
References: <20250213101658.1349753-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 13:16:58 +0300 Dmitry Antipov wrote:
> In 'skb_get_timestamp()', do not assume that 'tstamp' of 'struct
> sk_buff' (which is 'ktime_t') may be implicitly converted to 's64'
> (which is expected by 'ns_to_kernel_old_timeval()') but use
> the convenient 'ktime_to_ns()' instead. Compile tested only.

Is there a real bug here or you just run a scanner which checks 
if types match? As is the commit message doesn't really explain
what the potential problem is.

Also please run get_maintainer.pl on the patch, you missed two people.
-- 
pw-bot: cr

