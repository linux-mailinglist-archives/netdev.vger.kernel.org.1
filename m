Return-Path: <netdev+bounces-108578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7C924703
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D689B20F8D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86661C230E;
	Tue,  2 Jul 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irwf2CJv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A6178381;
	Tue,  2 Jul 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943607; cv=none; b=Gsb/GEc3YyZ3xdsI2MMFb0fkN0vYKOMgf5FAZ7kJ4aXrZMURW38+GSKVjvtqjv48q2K044WHzJOKqpCdX2JmZYpOcdjQJhf0qMkGh8iKLEPbaLQhOLln6uyWPiTy5LFcpRvIx75F0r2KITbZfJZLj11T7ZXgLDBiMO+FGVWi564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943607; c=relaxed/simple;
	bh=Ne0NSttj7t3Hp93EH82O5N+/hEdc+xkhwhi+sUxMP3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFvFAPLmX9qPfgp+ZUCl0UVTh9AHmYgv0LhllY+YXg1/HIIjid/iepgZApgScbgDof0Io6QydGQ2wUFhDPBd679VwixycBWN2GoAaRKhbkTUBfavZ5tv84Oi+W18u4zLWl7iEz0r8HIe8qA8nInQqOupWuv8KVgtEn58IjFAIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irwf2CJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2404C116B1;
	Tue,  2 Jul 2024 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719943607;
	bh=Ne0NSttj7t3Hp93EH82O5N+/hEdc+xkhwhi+sUxMP3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=irwf2CJvh6kyedYtXGb35tE6yWjNX13hRk9BqS2joLpGc01hRzZpj8LOOg/nNErbL
	 hC3ErIvtn7a+oKiDxT9CyRs+9DNR0Jxsyoez1Hip1mM4jT3Nk14m08kgZn/R9PqG8l
	 q/IjjW8E93ASc0ACkchu7QK5SS1VJFuirngNjn5EPg0vCOCQDIaALyDk6WZw12wpyp
	 m2295k5CUMTXRdXdEjGV+urXVC11zHWYeAXFtFaBR7kwYfXNrki9iza6JYG0DEvs1G
	 dMnihmsHAtjSO7OgXw8nZpaRkDEGLUt3LZktr1Q65FwsPCGowrvVdYfGOsMbaAZjP/
	 N/fCDl9bC51Ew==
Date: Tue, 2 Jul 2024 11:06:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Simon Horman <horms@kernel.org>, =?UTF-8?B?QWRyacOhbg==?= Moreno
 <amorenoz@redhat.com>, Aaron Conole <aconole@redhat.com>,
 netdev@vger.kernel.org, echaudro@redhat.com, dev@openvswitch.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pravin
 B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
Message-ID: <20240702110645.1c6b5b1a@kernel.org>
In-Reply-To: <447c0d2a-f7cf-4c34-b5d5-96ca6fffa6b0@ovn.org>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
	<20240630195740.1469727-6-amorenoz@redhat.com>
	<f7to77hvunj.fsf@redhat.com>
	<CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
	<20240702093726.GD598357@kernel.org>
	<447c0d2a-f7cf-4c34-b5d5-96ca6fffa6b0@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 11:53:01 +0200 Ilya Maximets wrote:
> Or create a simple static function and mark all the arguments as unused,
> which kind of compliant to the coding style, but the least pretty.

To be clear - kernel explicitly disables warnings about unused
arguments. Unused arguments are not a concern.

