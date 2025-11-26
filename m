Return-Path: <netdev+bounces-241723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E9CC87AB7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 426404E1019
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A870D1D6187;
	Wed, 26 Nov 2025 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTicfsId"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEA79DA;
	Wed, 26 Nov 2025 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119877; cv=none; b=lwB1KjcQNkDFE//CnIOfQAmAy/oYFhrXGoTLgYdeIX7zel+ph5/OdHPMjWIS6DsRbqKI2Y+g0Wa6cwZJsjjyMBvGnlNLGkbT0dpVFpb3fQWZR9TrgTzCZcq/KHx2KMT0nENAVn8mhgfhyWnrijTwNhyYloZBC+3U+sfjAAq/1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119877; c=relaxed/simple;
	bh=A1zp/tNgcevUOsF4/Fzw/zEGfXvydnGYMyNQEludDz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh9rH0AA5FSuE4C55i49JDmzSoYNYPq4j+ITAOyq7LYZ8xZpMZQIanoKo2vizEdcAPT7XH1rd3Z5Z5I2sS9OVICGbLbbRno0GP8okV1+m5kYBm4kMht76T1e5RGsnyLpotMLqpipFRnw1jKbwsMkU8EaQu8ulr8j7uc97AS6FOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTicfsId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F5CC4CEF1;
	Wed, 26 Nov 2025 01:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764119877;
	bh=A1zp/tNgcevUOsF4/Fzw/zEGfXvydnGYMyNQEludDz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gTicfsId2p6hyNGm8M3CmNLz2634yx3UKDmy48Z3qSnLxMRc+5m08CWrcr98KtP2q
	 TRW+gjdOxpHyhE5+8lhIrrSDl8Ru8DQZjh9iJSfE/LJMIIwQJ4aMc/zfxPIobTytGa
	 EfqzN72UslAPV27pKBqFI//QnaXQQTWobqEHs2D9BaSI2xhh3hbNv02tKAdIfEII05
	 Ugp4GynLDLVB9k9TkqOOvTKRF+6/WfsuRUaZGNYusmt9rMnhAVyCAiBpRttwOA18p8
	 n8mIcDqyJKp4WsheQUjS0gWIYArXET6qWXV2iH3hLAdosIZ9oTX/W2JWeCVdWejl+D
	 ZafS6b5opiY3g==
Date: Tue, 25 Nov 2025 17:17:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Bauer <mail@david-bauer.net>, James Chapman
 <jchapman@katalix.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next v4] l2tp: fix double dst_release() on
 sk_dst_cache race
Message-ID: <20251125171755.4df43c16@kernel.org>
In-Reply-To: <20251114032414.524965-1-m.lobanov@rosa.ru>
References: <20251114032414.524965-1-m.lobanov@rosa.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 06:24:08 +0300 Mikhail Lobanov wrote:
> Date: Fri, 14 Nov 2025 06:24:08 +0300

Please fix the date on this submission repost (after 24h wait period)
-- 
pw-bot: cr

