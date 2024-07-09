Return-Path: <netdev+bounces-110332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685392BF01
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777481C21625
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE93158A1F;
	Tue,  9 Jul 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N66StOfR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E604A02;
	Tue,  9 Jul 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540927; cv=none; b=gr8pLgoQT4Tb/CCzU6sJEwBegAUlHg28SCZ9AFttvUJXwhVnrckihXVanDybFvw3lAsuzkBm2icGqvH8LuFCFcER8H8sEEl2r+F1X7QWG1YUS4XQm5cSTAIS5wiGeI7Kt1qY9yLvoOwjE4d0AdsSUZP05DZ+6bS1ZoDbNyOprSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540927; c=relaxed/simple;
	bh=YCKBBYVsIHcTkdtiBwBR6ruMedkW8+2rASFqlHoUWps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6a6C+W2y8x40P/5RWE1w3CDpouvMhqeuWz6Hz/RmeLF/k/rZMsqBj3aMWDPR807Vi0IFp62oHv8n8DSRKcpoQtUKkDUb4JWKIYsPcCrdQRvEaqL35eoAt3NO0SPRf/Ad5hhCJvrh53X7jGWfytGzqxWqxD+h0p4ekQYbeKi53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N66StOfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A41EC3277B;
	Tue,  9 Jul 2024 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720540926;
	bh=YCKBBYVsIHcTkdtiBwBR6ruMedkW8+2rASFqlHoUWps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N66StOfRXQM00eyQGy0mXXR793rtlAfha4/tlPybSzvOMOvS85VSU25MRjIkuIAIK
	 nDOHTrkt3y22hZhLhHPmuGkcVCBUwidK15l/SxsByYfGV6MtNBhjNV1U2dN5dRiuhw
	 tWFLOLP/17U7Oessaq0vYmy60VYYK0dxI1UpjLAKo2zimSzK1ownJu+yfmsqRFzsqb
	 23UPMRKFlv1sJqeZME5HtBqisJKdg/q52Nmbh1AifXkjgJ6JYwC2epD+o5htitqMgN
	 M+PI/xNfpsVLYQAPexlRnAw4QO1GaZdux1lGM6yTaUebxwGNbdjtFHLh0q3nPHeGdV
	 T/BYHSekk3KAg==
Date: Tue, 9 Jul 2024 09:02:05 -0700
From: Kees Cook <kees@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, horms@kernel.org,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device
 _properly_
Message-ID: <202407090900.BD88B67AC5@keescook>
References: <20240709125433.4026177-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709125433.4026177-1-leitao@debian.org>

On Tue, Jul 09, 2024 at 05:54:25AM -0700, Breno Leitao wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
> 
> bloat-o-meter for vmlinux:
> 
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
> 
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Nice! I'm glad the refactoring in other drivers got tackled so this
could happen. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

