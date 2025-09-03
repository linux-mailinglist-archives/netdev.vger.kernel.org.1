Return-Path: <netdev+bounces-219731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80947B42CFF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F292067FF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9A02EBDFD;
	Wed,  3 Sep 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK/cN8af"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29602E7BAE;
	Wed,  3 Sep 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939891; cv=none; b=N8hjTt5QJIUKfbSpfcjgULLC8ZbgZd1kS/Nhd0KegVI5+zZL7XC95mZ4RoGg4YyQTc1/woElC7zzmprXUH4uz1mhXmuaMS7/Yb3529kKD31jng6mkVWt2LX87Q16Oj8LxrfvqnQ0fni6COZjFqOPFiX5CCbmL5XfEHj0lL8BBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939891; c=relaxed/simple;
	bh=nuLAQXUJOzgMOKAOlWlPexVEsUs3b+Bdwfmn9KR08I4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBy8iGC5Bf3XfgPsEinlfvq0/CN7oU0qdBM4Ck0gOJ6Mzix0N5vzJdsj7U25HUjbL1abceKJVxrxdwPHOGCE51IRNY4yFESzp0LnH2PulymfWK0HE4gg7sQwMA+NHVdf9vGm4AY/wXlcOJdVRBNoWOSKHpMw5MdQf1wSPVbwoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK/cN8af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB6BC4CEE7;
	Wed,  3 Sep 2025 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756939891;
	bh=nuLAQXUJOzgMOKAOlWlPexVEsUs3b+Bdwfmn9KR08I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XK/cN8afZn60GsrJNNrLbXqm96rIPnpewnrYPSr+JwWF8vVRKxchCFbS72dQ2pI8u
	 mOjcZzxfxwji+jXo5K9ecGZdRc9I4PTgzEJ5uJyY8t4eXmvxEhOlMjcZvabUk5YLfp
	 rB+tH/7BCXUGe0AsQPCGte2Qxy7+0rjqOpSz0lvNR95hfzdsgVvx2J46C+PC0xUoKu
	 Uc8BA/cAt6YEUF2PaWNf4APHeWiFrx99MW2ibdvPlyvPApourbzPk86KaIqWUJyUC6
	 yLArVq4IBex1sThHeRGqOa015IoDD/lnxYTi3CjPwlrMhFCb6EUUKbt8CoEx8bmI4M
	 l06szAPH3fVWA==
Date: Wed, 3 Sep 2025 15:51:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, alistair.francis@wdc.com, dlemoal@kernel.org,
 sd@queasysnail.net, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
Message-ID: <20250903155130.3ce51167@kernel.org>
In-Reply-To: <20250903014756.247106-2-wilfred.opensource@gmail.com>
References: <20250903014756.247106-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Sep 2025 11:47:57 +1000 Wilfred Mallawa wrote:
> Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
> support. For these devices, supporting TLS record size negotiation is
> necessary because the maximum TLS record size supported by the controller
> is less than the default 16KB currently used by the kernel.

Just to be clear -- the device does not require that the records align
with TCP segments, right?

