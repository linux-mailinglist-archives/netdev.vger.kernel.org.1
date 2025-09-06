Return-Path: <netdev+bounces-220539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAEBB46822
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B8A5C632D
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A341A0BD6;
	Sat,  6 Sep 2025 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0BSwQ7k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6C186E40;
	Sat,  6 Sep 2025 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123399; cv=none; b=N5aObMfcFJeGrZ1YafOarIiZ6iuypjoW3z2e/aiZTwNcO8T0frX8r355bz46UR2Q+124sOGShLedyt1xhpygAC6g2OENCPhxPv23/21yO9lFOcfVqgvvikW9yw08LAUd4oFd2CRTnxbrJq8GqyGeClY7Vs4EyYeS1o9Wj710qyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123399; c=relaxed/simple;
	bh=4yvGYjIeGoljLrq+qIFp47+Cy+cgZ07oG+PKzuDNjdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpicI+1ByNcb4TLpidZt2qiz9eLUfUbXKoWgLCV6zoetHm4FA9T8mfWmOl75yaD1rQtJHvcn9DFtDAMrNSwj8RPcRcnY4VHHzPNJNrvfud4FOcilnR4RnrSo5t2w66WHpkvzH9heucqEo3Qt3s277Hrx8wJVz5v5kxzslX/w8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0BSwQ7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D79C4CEF1;
	Sat,  6 Sep 2025 01:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757123399;
	bh=4yvGYjIeGoljLrq+qIFp47+Cy+cgZ07oG+PKzuDNjdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O0BSwQ7k7BD95GD0CzJ5c8UAMG9OunE+H3YqGJIiMeicpugZkJq7hz9mMA4Pgs/X/
	 qgynLpq4FQBXYg49k/OqtgYg306ijaUTSLT+3YYvtgxCiIjEGkRstYoDvrS77kY8Gq
	 mfkFXD8vT6kR+jbBm1XneUuckK1v1VwctwQ6MJytutA84kRZp0rti/SPAIzOjhu0Hv
	 dZsRkbhy2xRaXNSFPEbrawN+ltaSLIxekF7oH3BupKdM5W68xTHPwKAP+Ged+LTV59
	 E6ZYEXSgwaf6UwBuKSZKvQ3HrgGmgWL0MdMZMIuCR7cdaXL0pARHmO7HYCXQo0Jxzf
	 enTN7A8DW1wJg==
Date: Fri, 5 Sep 2025 18:49:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Message-ID: <20250905184957.76eb37e4@kernel.org>
In-Reply-To: <20250904203502.403058-2-shenwei.wang@nxp.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
	<20250904203502.403058-2-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 15:34:58 -0500 Shenwei Wang wrote:
> -#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
> +#define	OPT_FRAME_SIZE	(fep->max_buf_size << 16)

Please don't implicitly depend on local variables with a certain name.
It's quite bad code hygiene. Looks like this define is only used once
so perhaps you should instead create a define like

#define OPT_ARCH_NEEDS_BUFSZ

And then use that in fec_restart() to either add

 (fep->max_buf_size << 16)

to rcntl or not?
-- 
pw-bot: cr

