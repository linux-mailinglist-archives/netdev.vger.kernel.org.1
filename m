Return-Path: <netdev+bounces-163801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B2A2B98A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE106188976A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198F1799F;
	Fri,  7 Feb 2025 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0VBBgxg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A7EC2
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898142; cv=none; b=YBa3lNE38zzx9rR6QPuDM1c5tIdh0aSlolWOf/ajFALA/+dB4xcP2EVhzry9fHC4tJ9SFh6e1e0lohkqMOWoBZSrqikVH59p9DX1HZ71iFGqtRByIjYal2W5/TUWKzMKXLEriV761QhjaUWjKAbOBTqBN2Z/+cTO+SXWh47q8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898142; c=relaxed/simple;
	bh=OyJkv55OowGdyjQ5JpyZuk75bLMiBRhazgWXDVnS6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol3u6Lx06Q928puC2uHQtVgcql6pkG0qGqVs0X7Y+lyyXmYkU4+MMj1O+2N4rAsfxjaDIGMNKl3u/t/l/HDaxc+rxlr5y/RSJ/IXRTk6ixtjEXv3rwuUgkM7fzHGAXVAcufIs2mLv8Lg7DJExbTmOUVtmlAGaXuD1Um07QUM/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0VBBgxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5712EC4CED1;
	Fri,  7 Feb 2025 03:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738898141;
	bh=OyJkv55OowGdyjQ5JpyZuk75bLMiBRhazgWXDVnS6ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0VBBgxg8QRbcRHBP5gmckYSUrsRqO9LlTxEAQizD7esjsnCeSImSxnDd3TxRN+1W
	 uuzBMnoazU6bRJMVizTUSRKrvEFwXmgEJvyL8ZCly/a2ssO8odluCoFpzME5tT7mk/
	 MIA1OK8xUZo9XN3hIW+AxHNA4IcPTXMUxFgeNCcFapex87tB2+I9N+iasnd5mgPKAV
	 9CxAO7sAN8paFffehp0zSoI2iYG0Xgm0XDh7JOBLxY1NkDdeZECXg28GBqhPz+aQPB
	 LfRWZUBMxByf6AnYA01Z1+hrzTFbGiRgOfeoo7jnxZ9p2nSMWioVAABNZK33A3kKiT
	 pRGN3+uVYmhdQ==
Date: Thu, 6 Feb 2025 19:15:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, Alexander Duyck
 <alexanderduyck@meta.com>
Subject: Re: [PATCH net-next 7/7] eth: fbnic: support listing tcam content
 via debugfs
Message-ID: <20250206191540.1f9f7664@kernel.org>
In-Reply-To: <CAH-L+nPhLzOyJnCRs9mQb=C4D8KF2oHk6uObYhLLg-aEFiGqhQ@mail.gmail.com>
References: <20250206235334.1425329-1-kuba@kernel.org>
	<20250206235334.1425329-8-kuba@kernel.org>
	<CAH-L+nPhLzOyJnCRs9mQb=C4D8KF2oHk6uObYhLLg-aEFiGqhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 08:16:18 +0530 Kalesh Anakkur Purayil wrote:
> > +       char hdr[80];  
> This magic number, 80 is used at multiple places. Can you have a macro for this?

Can do, tho, it doesn't have any particular meaning.
It's just the default terminal width.

