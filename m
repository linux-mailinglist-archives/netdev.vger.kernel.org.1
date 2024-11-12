Return-Path: <netdev+bounces-143937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103239C4CA7
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B52283D74
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3488204924;
	Tue, 12 Nov 2024 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQIOmalU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFB4500E;
	Tue, 12 Nov 2024 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378951; cv=none; b=Z8xrdfmRTNk44cMxCehe6feNJw2+zZbVbKsp1ZkRw2i/KskfBLNdP7pfsAr+QJeEcKepJ7KgvVg4RxTDuR36HFxY8voYAVe3W3tQuCGeC9AzafdmFowVuyGOqWQJGb6c804WuYznqtIVJ2LOSjJUoY8w4iFCHjzTIe+FvWqs9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378951; c=relaxed/simple;
	bh=n6krzlp3piTmoir/fi8G3c4W6bWmm9yZyqRfZbhMICQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8eitGPmfool7qAnIktdwo8d9tUup27V7yDKTr3Ysx/DEPjSzngFZ7wuAJ6pVxKDsV4Awp5+ve3XdHORIwdjPLaQFDNnkILQpJrLtaXGpjpKrEzz59RTAzkuQmClHm8Rb5CJTBGrg2E48F/JeMX9yX920vdd0DgxXyle2jYtJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQIOmalU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E724C4CECF;
	Tue, 12 Nov 2024 02:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731378951;
	bh=n6krzlp3piTmoir/fi8G3c4W6bWmm9yZyqRfZbhMICQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQIOmalU+PyFeus2wpfjOoYc1usY/5ZslowouYPPF3yRxfON/Ke0RUG+Nl02alnOQ
	 eGd6hH5SuYdEJ//cS/IZQuimzAl8VE+iqexfMyRP96aiSPVd6TtF4HO5VAd+edGvdK
	 waJVSvLyWjVMVosdx2KW0JKFqX30X8RmIYEOowXzuNfObQGlyYnun7z2b4O47yg/us
	 RfOeUVmdftgMXk/urO2yQpizU3r+UA3+8lR2t8d6zNi0qnZ2jta4j/OIT0bjYnHbOO
	 y9N9RMlSFPBsBd7hXIi1hN5I/1gOmjVc4sIJjVJnHQJl6XxIAqYvObsoj15py+lYES
	 hBO7YqnKsYaQw==
Date: Mon, 11 Nov 2024 18:35:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Willem
 de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 5/5] netmem: add netmem_prefetch
Message-ID: <20241111183549.48497b86@kernel.org>
In-Reply-To: <20241107212309.3097362-6-almasrymina@google.com>
References: <20241107212309.3097362-1-almasrymina@google.com>
	<20241107212309.3097362-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 21:23:09 +0000 Mina Almasry wrote:
> prefect(page) is a common thing to be called from drivers. Add
> netmem_prefetch that can be called on generic netmem. Skips the prefetch
> for net_iovs.

Why would you ever need to prefetch a payload buffer?
Looks wrong..

