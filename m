Return-Path: <netdev+bounces-111884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB50933E34
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBCC1C20EDB
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F918130A;
	Wed, 17 Jul 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFqyZjPy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA802181338
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225541; cv=none; b=Rv1vxzkyPe8EUfjrIh6xa0u8D5YmgMGePAYWL57zeXYrKML14MrZuBCfmc8+0wCOZK1txLn0KcK4W+Y6L9LdwgQ0ihIpR9gsJFIOCGj3KJUOoGQ0yvpC8Srg1wUl+dXB1SJ4dn38BmibCMGDsB2YSp35/9TRWisa8ifQmUtDIn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225541; c=relaxed/simple;
	bh=PWPniCQpe0kXe8JTaqgKeaoL+BOV9W+F0P0S7FKXTvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcYK4W+tucNPYIvxje3OotKppClfbsCj26t3DQ8n7Hnm6fBq5eT9gWiBOHQgf8LLKgJWX/8saE7ELVNZ5NFYM7rmv1JMCkcvP1Z/eEN9jzP9N1puznuFuoplYU/j+lT3bbEuPdlQezGMJpBNhdruwBBx1c+nGLQErJ/sbXUJo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFqyZjPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F47C2BD10;
	Wed, 17 Jul 2024 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721225540;
	bh=PWPniCQpe0kXe8JTaqgKeaoL+BOV9W+F0P0S7FKXTvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oFqyZjPyg7O3OuOw9N2b/hWG35d7S75e9y+Mhr7vfPSBRscQWUNlQutKmVf5UBpzo
	 zz7361bh1mlDC5WU961HRpVjEzSy6/kpZINafDgc7p2EqaR0r6TsdMefKCnBuMYg0h
	 JOiuGvo+9IF9bKFe/vzaqqVLf+36tFVXtYvXKcv+qyzHdwEFC9fP0X5UpPVgj4Csz+
	 XdtonzXT15eHHMTflxX9ImiltmPNHq/Dgxw9X8FSrGDl7medWEOjqXeZMA9tYmLaM6
	 C/QrV80O/yLOConhGEEKnI8JfYEfmN+zisS/832oLkQ1pkaGc9i19ae5RfYw/wMs5n
	 4WTOK2ewgL11g==
Date: Wed, 17 Jul 2024 07:12:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 alexanderduyck@fb.com, kernel-team@meta.com
Subject: Re: [PATCH net] eth: fbnic: don't build the driver when skb has
 more than 25 frags
Message-ID: <20240717071218.72ec1bc6@kernel.org>
In-Reply-To: <43bc03f0-5e5a-4265-898b-8ca526d6cc75@redhat.com>
References: <20240717133744.1239356-1-kuba@kernel.org>
	<43bc03f0-5e5a-4265-898b-8ca526d6cc75@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 15:44:09 +0200 Paolo Abeni wrote:
> I think that with aarch MAX_SKB_FRAGS should be max 21. Aarch cacheline 
> size is 128, right? The frag independent part of skb_shared_info takes 
> 48 bytes, and sizeof(skb_frag_t) == 16:
> 
> (512 - 128 - 48)/16 = 21

Hm, my grep foo must be low, I don't see aarch64 with 128B cache lines.
But I do see powerpc, so we can stick to 21 to be safe.

