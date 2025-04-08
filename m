Return-Path: <netdev+bounces-180452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64F8A815BC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267527B5C81
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549C22D793;
	Tue,  8 Apr 2025 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKq/TM1A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4742158DD8
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744140009; cv=none; b=a9XHU0c+N7wD94C6ZPBqoys95RU9g8ItOo58VIX9VgKF+UWAhyxt0X+Txo7O8gBbb4nCdwBD/VWtilzgp+VtP0Eeyi9FMEopTMbQ9HECvjf5Ja7z99S64BAeHi7sNw/gTe+pvw3qGe3R1kzPJGkJjZ0Pe181BcoFVgM9KdZcRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744140009; c=relaxed/simple;
	bh=T8eyKXRs9EehfeW9I4rbCsQBHdmjbWCOvz02xX3FzmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoSGN3IUy1FRACdUzhSjULgVu110Cw+RVwJZfDAjmyJ2vcZ7a4teFeWZurhPiSCeulehhxQKTZmW0o6HJSCzc5bs+An+e68Ls2Ylh89KpbGw7DZh7f62S/U1QC/upfiOe+1EodRCZmBN+IYMLEwcwBN4WhP8khmvjxHnucFLRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKq/TM1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC56C4CEE8;
	Tue,  8 Apr 2025 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744140008;
	bh=T8eyKXRs9EehfeW9I4rbCsQBHdmjbWCOvz02xX3FzmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UKq/TM1A6UW/kqBPjcHNu/k7B5ANNhkzPWgAdqhqRPAsGPFVAVs2gOKak7DUF6nUW
	 cW8XHbz3KCrP/fQOX79e19pY2HQWIK/KT7B6BLcmQXi4C2VT+9c0i9ZHf4TRUv2ej6
	 BxOZr0AsjdlN3Fo62PFeJd/gTMwknS9rsH13jfpBFD3rCjOphc/8El8bdFitw2WeF1
	 7jaZvioWoPaJlK5bL4QYuyP2u4zzMkn+X19crcZWNlm+PKVWpLk2mpIHP3qa2ikzrv
	 sfe9GMGYTDUSlbjBjgWRCjTUeRa65SXwiijZKlC2g4FAXMoDTS3PWt+asdeFC6FE/U
	 XYLuyO9ZZJjvA==
Date: Tue, 8 Apr 2025 12:20:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Ilya Maximets
 <i.maximets@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net] tc: Return an error if filters try to attach
 too many actions
Message-ID: <20250408122006.049cecd9@kernel.org>
In-Reply-To: <20250407112923.20029-1-toke@redhat.com>
References: <20250407112923.20029-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Apr 2025 13:29:23 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> While developing the fix for the buffer sizing issue in [0], I noticed
> that the kernel will happily accept a long list of actions for a filter,
> and then just silently truncate that list down to a maximum of 32
> actions.

FWIW I also vote "yes" for hard error, rather than warning.
But net-next, not net.

