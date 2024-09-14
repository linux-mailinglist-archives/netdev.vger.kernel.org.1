Return-Path: <netdev+bounces-128293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05DF978D60
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD8A2873B2
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124F17C98;
	Sat, 14 Sep 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/ZqmYqr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01A17BD6
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726289210; cv=none; b=r+bnUknprhVOZod01lFklaS+9VEBpbI6NyauAOrhg0yssGl4srvQVGNe2h0Q+DbFepMxjkw39jbFAl0XXhg1Znn3GcAoFguo8iKOEqFzCI5O95rkp48caT/4xD+zhZYMuQ5X/+9cG0wc/poOjQB6OeyP+zitdU2BrLofSJB8q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726289210; c=relaxed/simple;
	bh=DxOCVytdLMEnXu857G2sfLwqdHO7sOs5SvXmKgNNz5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCorn9vE7y8Ldn/u69tOUKet/AhbUv8qhZpUdgL2pJ3FSKBaAwm7HruAY+6qkc7Vgcg2YG3B6aIsIbYtSLNvkVXBBgjGgRNHX/YOghj/ZrYlWV8+mddNI4DABulNwRKfzzVYV5LtKAsOEzY7wKvZKxguYjVS+e5ItUuwW/GqX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/ZqmYqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8726AC4CEC0;
	Sat, 14 Sep 2024 04:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726289209;
	bh=DxOCVytdLMEnXu857G2sfLwqdHO7sOs5SvXmKgNNz5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t/ZqmYqrSeF/7YN+RHa7OYPQkvUaiN2ikUy+lDvxq/9L414GEFDGIoyxy5iMPwImX
	 ydzZI/GDeH6Wo4x/kxQLgVE4X8jD3dD6R5Ee0W0AJRylPCx4eRGFqdWZ5uNp7DwnKR
	 noAccK2WOcouZINgl3A7suQQY2k4vblpdPQjQdc3cwjaChQT/kL8fSV8HueBXK8rtw
	 jtD+bWmC9cFgagqyMqw9bDzupxAiF1W88oKqK1eHTwtTBhPn0136PPDzRxN1YjjRJJ
	 Tcil7G2i5Xe64Fc+YAPnEOJTpx+BP643HIkOD2wtGXzN9otQRkLJFHh+jDc+Eie15G
	 MqLlW8OAUEIlw==
Date: Fri, 13 Sep 2024 21:46:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn
 <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, Simon Horman
 <horms@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v5 0/3] Add option to provide OPT_ID value via
 cmsg
Message-ID: <20240913214648.5be02ed3@kernel.org>
In-Reply-To: <20240911091333.1870071-1-vadfed@meta.com>
References: <20240911091333.1870071-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 02:13:30 -0700 Vadim Fedorenko wrote:
> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> timestamps and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg. For UDP sockets it's impossible because of lockless
> nature of UDP transmit, several threads may send packets in parallel. In
> case of RAW sockets MSG_MORE option makes things complicated. More
> details are in the conversation [1].
> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg.

Does not apply to net-next any more, sorry :(
-- 
pw-bot: cr

