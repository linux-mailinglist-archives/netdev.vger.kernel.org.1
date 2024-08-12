Return-Path: <netdev+bounces-117854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69AD94F8F2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D35281411
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EEA19415D;
	Mon, 12 Aug 2024 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuRxgifO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD818E022;
	Mon, 12 Aug 2024 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497949; cv=none; b=lVfOogDh8z+1ntCpOK+LgTqexaxC3NMZ9+S0L9yX8OHzMAgdCceGZfaQrHJBGD0q+TiuYHlwAFd6K/eOitQj+syMQeM3IrIzw4su6GGPZYIvclVPrMzoOLXty6j2N3N+lNxykQjAwidnY7VkveCezA9eXdjFmm0k9mcFNUFdv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497949; c=relaxed/simple;
	bh=rexy9WaQivYqfca+PSQ3sVR2zFfBAUQ1jd1nluQT6Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjH+5TWb4Qv3XiDJt3odZQoHmCBF28hd8W5TqSmTpj0gWc2bC2dbNLefxOEYOkxs1E7Qi73IrFPHarpOKEJD2v4RJ1dh2gxy3m8cvMoZQlT9HgnmUlnP6yhji+nd0BJBANIMs7T547zjAdeS93jgrwf/b+iBszxUfoxkx2z6/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuRxgifO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D64FC32782;
	Mon, 12 Aug 2024 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723497949;
	bh=rexy9WaQivYqfca+PSQ3sVR2zFfBAUQ1jd1nluQT6Ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FuRxgifOjQRM3G5TvBXagL1MdqFA64iuHzAS7Jvw0l9N7koqMdfDJrUWjaCY7aJe7
	 af0ejeHaKn/8Hk7+01ZOvJ0Czx5oj87RHHRvR9iJUx/+YqoQSM9qCvl307MKCVNjY+
	 8RAz4HLe3CS66ezfEhlYkEFLf6GTdPtIBtBjdVw56eP8OXuC3gAGrkyDKPwSP5fvMD
	 ZqP72kT6hsoe+oFU4SBcs+sluehzIOaANe0xXRkAjpshmA4yPUdtHPb5fOfSlrkOZc
	 2tZLHuo3HQIg/YmlVK4yU2mmG35PMyXWok/kQgREMHVX4hTx74DAqJydAyz2P0Rajd
	 Ewde6fJ0xmF/w==
Date: Mon, 12 Aug 2024 14:25:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>, mptcp@lists.linux.dev, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] mptcp: correct
 MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size
Message-ID: <20240812142547.7c048af7@kernel.org>
In-Reply-To: <df52ac23-5eee-4d17-9e74-237cf49fe4d7@kernel.org>
References: <20240812065024.GA19719@asgard.redhat.com>
	<df52ac23-5eee-4d17-9e74-237cf49fe4d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 09:43:29 +0200 Matthieu Baerts wrote:
> @Network maintainers: is it OK for you to apply this v2 in "net", not
> "net-next"? Or is it easier for you to have a v3 with a different prefix?
> 
> (No conflicts to apply this patch on -net, the code didn't change for 4
> years.)

Looks trivial, should be safe to cross-apply, no need for v3.

