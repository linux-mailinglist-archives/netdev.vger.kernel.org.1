Return-Path: <netdev+bounces-87596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD678A3A7E
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BE9B2199C
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97DD14290;
	Sat, 13 Apr 2024 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lfl/93c2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BC4C65;
	Sat, 13 Apr 2024 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975224; cv=none; b=t+njJGL1lhVLoq80LFBu0/kqQOlZs/5aOJJymfQ1aFVxzeIwz7tOZSHbzcXT+NFNGHkTQ0EkggCPKk25MyXKo6TPZeXJ8kGKYruxr3GFghXsIgHvA0GlyHGefndLI/cUvASf3KvRMnZw7iMWPboOmMzmEd2j/ZonaFgIw4W5rtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975224; c=relaxed/simple;
	bh=GU/vpeY5PN7AliAZGVA+8BhSlpf7NHeL/GAof0xFq8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgjusXbVds54w0Hgtl5a2WbTN5P7+5wj28jubTsrF7piwt5MKSnYMI4rJfhnMbqxj5+sCv7nvpDIfduo+mxy2tKbocpNOTSNVgObXNEsGHDglAPOUiGyrutH0rhpnZr1Pr1I/UKVjhmN+i2Y0FG2qyq8E2w6B9/DzzP4KJXuwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lfl/93c2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C867AC113CC;
	Sat, 13 Apr 2024 02:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712975224;
	bh=GU/vpeY5PN7AliAZGVA+8BhSlpf7NHeL/GAof0xFq8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lfl/93c2UvJwfRTChP6ghJm5xRZAALPVmqrJp+/RcVkhqL3bgxYqKxnhWZYVpQ7Rt
	 /6RoS+L4DqwvfVpI5ObPZk9vSDO6mb/8CAerjKhFBE71keXhogxuVfjhu8SfOrc8I0
	 N2vdRdhtI8Dv0CkviBrQ8mzOYanvz8OScU0h5yZLWynR8QtW5xLd01znAiLoP2d4+D
	 oTrufb8Md0omdWyjhsyGQa+uh0362A7LKJh+MALe/uagqIybphJe0uDpVbq5wAaqSL
	 Wmcv6AsUCesjg0fwUhvKRxTyNXXz2xfQ42yEJLSBjss5WvIZxuJh71/5FJhiAWJmHE
	 DOpndUfzf0QtA==
Date: Fri, 12 Apr 2024 19:27:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240412192702.6fd4f1c0@kernel.org>
In-Reply-To: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
	<1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 22:12:29 +0800 Heng Qi wrote:
> +        name: usec
> +        type: u16
> +      -
> +        name: pkts
> +        type: u16
> +      -
> +        name: comps
> +        type: u16

I think I mentioned already - u32 please.

