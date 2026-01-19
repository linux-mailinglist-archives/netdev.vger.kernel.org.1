Return-Path: <netdev+bounces-251214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D3D3B52D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8D4930194C4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01201329376;
	Mon, 19 Jan 2026 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUqTYGxX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7A2F39D1;
	Mon, 19 Jan 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846023; cv=none; b=fyDvjDIGU7nrG7DitXDN0PDwAdu+2KApvCiuEyYCf10N1BgFnIBOKqh9O9vTZTThtL+lMGUnKMMD10hTfJUScyI4UI7zx7qM6sNcolZZQw0vq93DF6bUlRtAgNQYGqfyOf657BSL8KbG451dX/1ZiydUwqXXSfsl+pqKGFUe2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846023; c=relaxed/simple;
	bh=dkHAM2j1PY9MAFBtqdmCQ3avsCqzhl0vht6vgBpj4CI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViuJg/1Hv5sHhCefwnohEjuBPcMNlGERaeMxo8jtlc3OO7ik2SE9V7z9gI20mnafClwlkk5EBN5+rB+BzKlVc6q+YnSJPr4tHOiFL7hGK3VYHGAiIYXujS1NbGnMjR6d3pSHSsuJBYBbGRQ6o92TcYgohHa4V6pdFqEq+bBk5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUqTYGxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F04C116C6;
	Mon, 19 Jan 2026 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846023;
	bh=dkHAM2j1PY9MAFBtqdmCQ3avsCqzhl0vht6vgBpj4CI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUqTYGxX/khCrx4u0ncAc93TkzwnYHBdmYu5llApo+d3i7eviHodWi3XR6jCsTRO4
	 FEfFMyp+6YbmlzqeDJU7Jol2PiD3DYBJNEZHehDHuMkbvKHfIZNbzyNA5MJa3ncSB6
	 G5qHlUDlxeEVQkDSt94DhFVgOWyrCwhszIOcoM9oftY0pZHnd+ZhKVUmX6QN4fqfla
	 +qd2lzjfBIKHc22rs8I7Vp5zo1WSodpi97e/GGWhoAyKxqIRUkzpEqeQR8jLj+YVXr
	 T0QZUdBYrRmnur9bgq+/6rL1cv/rauu1WEBxbAIzAAGjd0Oy79IEZeNVqsvqPWwXOg
	 hi4nlgLlkJzPQ==
Date: Mon, 19 Jan 2026 10:07:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Faith <faith@zellic.io>, Pumpkin Chang
 <pumpkin@devco.re>, Marc Dionne <marc.dionne@auristor.com>, Nir Ohfeld
 <niro@wiz.io>, Willy Tarreau <w@1wt.eu>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, security@kernel.org, stable@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] rxrpc: Fix recvmsg() unconditional requeue
Message-ID: <20260119100701.1d3ce121@kernel.org>
In-Reply-To: <95163.1768428203@warthog.procyon.org.uk>
References: <95163.1768428203@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 22:03:23 +0000 David Howells wrote:
> cc: security@kernel.org

And I'ma drop this CC, I doubt security@ wants to get CCed as this
patch travels to stable.

