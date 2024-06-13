Return-Path: <netdev+bounces-103283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4134C9075EB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50D8B23825
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA191494AD;
	Thu, 13 Jun 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIe5FPxB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A284A41
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290956; cv=none; b=hmtelIBrY1GUEaxHRV5yAcs79NMYRaJYCb7ylsp65bSDSImC4qtxLsYMyS+cGhzlX+F88C9iM64jCSux2s5pg84ngde43H6biybY6i7NnrXc8ZG8sDm1f5WKjS9VIORBhd0z440rUl412xWWE/p+2B8has8qApaDU2TpUjBCLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290956; c=relaxed/simple;
	bh=UqJ6h5x3NPp0wWba9rvV3TGYGP4vN2cl7sKOZ8FFtpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alWui4++Ea1ahVcFXuGuVPK37obaHPHzmTUasoeuPf8uqGLcppKJZEsGZbaKqCngabDBYpidyWhWsiUXuFFGgU7POBWp4Xjj+xTwFE+njK/LIx63KUvOPqJN61++RlpqsXk8iEkAPNqtUmteArR87xsfXsTMmIQ1si80YBkd6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIe5FPxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0149C4AF4D;
	Thu, 13 Jun 2024 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718290956;
	bh=UqJ6h5x3NPp0wWba9rvV3TGYGP4vN2cl7sKOZ8FFtpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tIe5FPxB7+yRUu5TR/u5qcG61CRS6QUvdyzaFfKpiYMr7KdemmYr3C6s45XO5moKN
	 z0L4eqMesV/fHfShdu35akk49oXXo2N9d/jPRFppGJxX80zwh2YIBufDlP3GrDzL8a
	 HAkeAE5dhz9nUdk4nsK+HjwM9KpH+YGoOu/1p4UD98DERQV00WwV2/xIIyA+AL8MOx
	 6xhTgEtG9ZJ/smbOV55+1W1BPSj7l9JRstFAV6H/8p5KdQlIP3hZ3SdxiHT2Q00Y7O
	 jUY1GxpNE8jOkx9X5g5vjL/EazXJhc74FNmQ3YXFEmWmj3gc8482+LgBf4amuYBQuJ
	 U8Dyd/vQB74mg==
Date: Thu, 13 Jun 2024 08:02:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
 dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
Message-ID: <20240613080234.36d61880@kernel.org>
In-Reply-To: <CAL+tcoAP=Jg3pXO-_46w5CbrGnGVzHf4woqg3bQNCrb8SMhnrw@mail.gmail.com>
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
	<CAL+tcoAP=Jg3pXO-_46w5CbrGnGVzHf4woqg3bQNCrb8SMhnrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 22:55:16 +0800 Jason Xing wrote:
> I wonder why the status of this patch was changed to 'Changes
> Requested'? Is there anything else I should adjust?

Sorry to flip the question on you, but do you think the patch should 
be merged as is? Given Jiri is adding BQL support to virtio?

