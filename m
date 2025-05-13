Return-Path: <netdev+bounces-189930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366BAAB4888
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22727AEC23
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E9B84D34;
	Tue, 13 May 2025 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqyT30OJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD22AE68
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747097084; cv=none; b=XhIFuU/IPhH/uUy8siAdzghViwawLPLMdjEaq+tN84EwQDvvha9Qfb5WKxc8C60vJOIHvVjVvuDFmzUFQDvCoxL4bH5Z3ty2Uzyg2NPudcZQj9iiB6KKphdXHgl9Gp1D+rmXMurtkHU6zvb+Mh5aguRanlJIauRvYmtSx6O15ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747097084; c=relaxed/simple;
	bh=9HM0aFa6/rF5+ax2jUKIoTv7IXz4VhnWmng2lAGV6lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcCYwOX/r2SxL+bCmA15VxiUwm5xBryW07VKo+Owbh1rFMmF60bNN8PASl3GdScCxVhDY1dosMxkkl89sqAn6fehFgk4DplCScAbJ/xwsIzjgHl9bK+b0j1y7KOJ3Py55g1Z2dFnIfQNPqvbCItQRkh0MhdEMAk8udbdi/smUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqyT30OJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D78CC4CEE7;
	Tue, 13 May 2025 00:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747097083;
	bh=9HM0aFa6/rF5+ax2jUKIoTv7IXz4VhnWmng2lAGV6lQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YqyT30OJ+ltwXLJpPGubCuZ0jTld8JwRxgZ/jTZoD5R6GeJmm9JUJhw+V7+yRRfS/
	 HAJ6nN+D3zjt99b4r9ok5ig2MYdVLIhuah9fd5ztM1ounEsgdy7/MTukfp8oKkPtOx
	 rOwNudYPkR8j5+mtrA9wak+6XfAuVQXE39diz90IqXXt4aoQ5HnxUbnBo9JwiR7/5K
	 /i33mApurzPd2DoAsWbyue4L0R7VyCgIvwB6uwS8Cx9Dwj9g1NMn/HmYPZ1ry9jNt6
	 QYIsQjdcTRa1pG1rH42XYw07NV9wuUOCkkuNSImZhUwJ3MvNVv0uaR1RdL7SuVroud
	 IMbvvQaeqBznQ==
Date: Mon, 12 May 2025 17:44:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, almasrymina@google.com, sdf@fomichev.me,
 netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
 skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Subject: Re: [PATCH net v4] net: devmem: fix kernel panic when netlink
 socket close after module unload
Message-ID: <20250512174442.28e6f7f6@kernel.org>
In-Reply-To: <20250512084059.711037-1-ap420073@gmail.com>
References: <20250512084059.711037-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 08:40:59 +0000 Taehee Yoo wrote:
> @@ -943,8 +943,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  			goto err_unbind;
>  	}
>  
> -	list_add(&binding->list, &priv->bindings);

Please leave this list_add() where it was.
-- 
pw-bot: cr

