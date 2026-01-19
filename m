Return-Path: <netdev+bounces-250939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A4D39C0B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A4A93001809
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADFC20E03F;
	Mon, 19 Jan 2026 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx1naJSu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7821200110
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787096; cv=none; b=QqQB5QnKi32miFf/9gF1KJ8T/IhT+WquN2zYWe28um6iHW0pSfTFSwNU5YwROSMvuRoM7gPVQtUJyhuBph5f1UZ9z48i3p8dLPxloD7JNHpiEQm/oxuiq54LU8FVaLsDOexo2rOQxD550LwJAvYep17lvxYCerQwxmdk7lv2QEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787096; c=relaxed/simple;
	bh=9KuyTObjMPUykUaijAfpeU0sbbAFV7MUsPQFsaCvLys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvxg/ypq4uGHdNzqMw5OXyooxk5QPd14T02VvZoRGtSjt038YHOcCbjzLjt1OOn5Hse3NoJyUWcb7LOo2uLNaA+icJPzOCQtebvAZhezv8XfjbblinfpTixHjkTgSBFf4a9MuIGivM7BCCl8Ai+EL+znGK3ETotNXEtCOGZ9kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx1naJSu; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso4461477eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787094; x=1769391894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gf0NuXC7tbrAN9iSYdLmm85bPv740bmc8OaGtqxfNCs=;
        b=Mx1naJSunypotkc/nAceFO2IY69dXBzKzOaOLRAAoUT03LVsUbiWLipLFUD2VgdIUQ
         oreL+W+9K377GmSeyJNP1fqqnfSHbm3aIXYY9EeX3qYcHJhk6SFn1libhKZkh3+gkZ1A
         cMS2f+kE+KPcU0LPLsV9Aw/3pQczJ/0W5EuyKfVq8qBag+yzKkJjiZ/AL+6WpDNCn3Rj
         UWStYLsDcZGRk6iKJEcvzvj6hTXv0CoREsvYzQUIipNerGycnX4kHjuQLB0u2OqiUk4y
         OePlDi2cFJdPffD+EOYc/U4Au4E5D+5biVE6E7gPsuU5ngPlE6L/pz9vTWoRIx2L997r
         3EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787094; x=1769391894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf0NuXC7tbrAN9iSYdLmm85bPv740bmc8OaGtqxfNCs=;
        b=LiWrEMr7u7uoAZVBUpe0s2ZWjTbT6dnkTP/g4wkkMfEFzGXIWXJWD0pVaKb+HD1ixN
         wxZvcYV5CPfgCl6srIrAx6dphIDCOSqlUECZNaDacJNh8L297kURe/jqn6RIAA9fBOGY
         +ybmtrJhYluMDC2lfp/Zl2qSCGMykiK6Lz6Vq5a7/tx2WVsR4BMdCbKGFQfP9CQna9y0
         9euZ5kB+wT3r9G3/jXPVg/JUOaP5jgZtSUdbisF6sISF1LWLDJdv0iuny0MifwdNUEQv
         P8rJ1mWhuLXkrFRQVWlXYgTTo7faCnGFyCEywyb+4OUyqOSAbCEcjBZeok+bMWKOxuJZ
         Sc1w==
X-Gm-Message-State: AOJu0YzkI7Ntv13nwlA7AjuwCzxcZvsTshIAnAYwLSQWp0f0SzooBMyF
	DqI8FrePFcSvLWa97DhsEMHJYvkdPOidD3iEts1zRGXMmzC9VUqp03g=
X-Gm-Gg: AY/fxX7z4gYllhlRzKjqM7zZBETqCqOrFK03M26P4vS2xpGGszZPwLdysBIn7V4wzK9
	Dlzsdhk3C4NOJVLEAeceCtcbtiJZFMPGOYmOVo5RG/NYRxic30k81Dyv4jufLqX92YROvZkJxjH
	GKKHxSzcQ74vs1A9GNNllkdj0POIyneQDrRyg5Hs7DMmgkfSUCdiAyBiIDMKLbQeiXp08zsg6DR
	xLscbY0uBSS2PmQZXhSHtWHE1E4C2JKreovUxThnZCfz+pibiaGi2unsZwGj0ZxyGuTHWxmCNhB
	O2ziw8f62U+RYhLcJD7OL6WLULGRbWx+AcVmAbaoZ4mIBlO1mJbOXed739WBCx337HcTL/ZECrm
	H1cgYZ6BwZ8yCzzK9XL5VS78EUTb93eHINDY6b9yLFSr8XPhcywBIO9hvtJFsC/gAgk37ATCjrq
	KPdCuiKVD+02dcKflrIeTl4rM3eIXpSff+pWl6fLVcnPdOhgdSNTPRKfCdXBYdqakg2kJQ3scrk
	/i0krimeICSJuyf
X-Received: by 2002:a05:693c:2c94:b0:2b0:5bce:2f38 with SMTP id 5a478bee46e88-2b6b3f2a461mr8971501eec.13.1768787093656;
        Sun, 18 Jan 2026 17:44:53 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c0e22sm10795194eec.6.2026.01.18.17.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:44:53 -0800 (PST)
Date: Sun, 18 Jan 2026 17:44:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 05/16] net: Proxy net_mp_{open,close}_rxq for
 leased queues
Message-ID: <aW2MlAF8Y2XFai8R@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-6-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-6-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a leased rxq, and call net_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

