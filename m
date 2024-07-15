Return-Path: <netdev+bounces-111603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A741931C1E
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 22:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98002B23341
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49F13D262;
	Mon, 15 Jul 2024 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byu1ma0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4F13D250;
	Mon, 15 Jul 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075988; cv=none; b=U+dQMubK3FjiRAyMtt07jc8KSTu7e1v3jDmsyQ96QZQ5o52R5QzBVn5nAAz/m/jrPa5HKlmyXoNjFWDaZGlvx4CsWjok11Hq6IzQChMk7LKROXUblz+GvU/z9TMzAzMzeal64nhj9QnBGEbJT65eRNygqygPrU9wdgG2bBpY4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075988; c=relaxed/simple;
	bh=kKaLSwVabRDdDlLt0slI1jlhl9ANHI8aEIY1Kw5DTBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWFyJnLuaY4wZASivr6fK2O8hqeyAKFFBfCV4NtvM7L+DhouDF/o+8+JlOxyxNVgDJbOnuBs+V3NVnxYCDUSNywcI5YEhnSPuLKF1uV8tIOyfSG7g3cEsnjWU2mD39CqVf/S2vU89PhqIXIPHUGk6CzUZZoMUk+2042hbBdVc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byu1ma0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984E2C4AF0E;
	Mon, 15 Jul 2024 20:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075987;
	bh=kKaLSwVabRDdDlLt0slI1jlhl9ANHI8aEIY1Kw5DTBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=byu1ma0qe96Pr2RZ7ZtXjLtwI+Xj1+rDG5J96UErpKH0n3gzdE/CldPAzap4U27lT
	 Oy70dkekPynFTqihT8JJfQ/FGg0+GQoeaCBjaV8qQ7BQLaPUnn+b3dKmX/UDzTJEDO
	 sOXSh2TPe9BQovUKYf9nfBV40h7xXskDHH+ze2aoevaN59Nw3GZ2Pv2ViuqlHr0JfD
	 AlV7g1MwK7Vu45UWMos+H6QwSBv57HCBbTYTqWWLFiPwbozzgYZkHxyQieLDO3BT32
	 yQLx80rZTI+mSk0vy2ljLswCYr6vwnIZ7ghVuPI62i3nfchLUlNMOsNImXWkRJsPig
	 uuQFetvjAa1og==
Date: Mon, 15 Jul 2024 13:39:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Paul
 Durrant <paul@xen.org>, Wei Liu <wei.liu@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] xen-netback: Use seq_putc() in xenvif_dump_hash_info()
Message-ID: <20240715133945.165d8098@kernel.org>
In-Reply-To: <b3fa592d-91d7-45f0-9ca2-824feb610df8@wanadoo.fr>
References: <add2bb00-4ac1-485d-839a-55670e2c7915@web.de>
	<20240715090143.6b6303a2@kernel.org>
	<b3fa592d-91d7-45f0-9ca2-824feb610df8@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 22:24:39 +0200 Christophe JAILLET wrote:
> Most of the time, this kind of modification is useless because it is 
> already done by the compiler, see [1].

GTK, thanks!

