Return-Path: <netdev+bounces-207591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8CB07F86
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFDAA47881
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492228B3EF;
	Wed, 16 Jul 2025 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVUcSyiZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EEF289E3D;
	Wed, 16 Jul 2025 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701097; cv=none; b=gOPE3GpFsmy70g329kDIVbe7LGeKhvctfl+iq57IFnRJxXHKA1TpbErHouEi72nQ6cuIHBbMG6Mt0DQf4uqBWZGKWVU91NkSY0LsR0qIp6hUEHDnC+KIad4uEijsiqVKH8HYp0VkwruBbF+CLOg8A19ceS0BpwbSDhrJJwBdpE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701097; c=relaxed/simple;
	bh=2fZ39SZz8mlc4YI/aOzd9OhNDsBlj+8OWbDogwbqpIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arX2DtBkLw5Ch9QqOct5s+iu+/yCGDoW9AOG3bs83uXZWefl+nwFsCTfYzoOVZP4/m3pZkyoZn4w6zVuUZj/nlYApmgzhyItEclPGy4CYCfFy0uf9bE6tQxQfvc1ORr9L7pr9yTl5Sm5d22YCr7vNoo3isarBaS0M9lAiafNl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVUcSyiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BA7C4CEE7;
	Wed, 16 Jul 2025 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752701096;
	bh=2fZ39SZz8mlc4YI/aOzd9OhNDsBlj+8OWbDogwbqpIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VVUcSyiZBZMMzxDcZUoKJnOmTgZxi0ZkrxIzZ/PJ9dxQx3M9GINC0nw7814qEVnH7
	 Y84acnd1k8FFsgydsTCFBsapWV/W9vKbUHkFl4joyhOVAvaNaV1BgEmIi7cCEEntst
	 FuxcNMTsco6sK7XSIJcl2dL8ZGwDWGLzY3vw21hnkSoNun4QrHS6jykJi2qV/EVlcj
	 ClJMGlD/RxCEm8Xpn4S+14Xn7Gv/rf1ddLTTsxKWvBMj0Wd0URKGJr/rScp6KWf8MH
	 k9zm2RbBbgzhT2aDRUbW8A2g144UTg4MxmvxN6KmBqWquzPTWyV1OZxLZR4XwcWsv/
	 CRlUZjkj/UKCw==
Date: Wed, 16 Jul 2025 14:24:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, yangbo.lu@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ptp: prevent possible ABBA deadlock in
 ptp_clock_freerun()
Message-ID: <20250716142455.17883979@kernel.org>
In-Reply-To: <CAO9qdTHdZnD5fC-V8E2JqKiM+ijOj15GRZjfwO+aAg_CUhNDnw@mail.gmail.com>
References: <20250705145031.140571-1-aha310510@gmail.com>
	<20250707171118.55fc88cc@kernel.org>
	<CAO9qdTHdZnD5fC-V8E2JqKiM+ijOj15GRZjfwO+aAg_CUhNDnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 14:12:27 +0900 Jeongjun Park wrote:
> > Either way - you forgot to CC Vladimir, again.  
> 
> No need to reference Vladimir, as this bug is a structural issue that has
> been around since the n_vclocks feature was added, as indicated in the
> Fixes tag.

I'm asking you to CC him, so that he can help reviewing your code.

