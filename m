Return-Path: <netdev+bounces-239618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 502DCC6A4CE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8260E4F1785
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A5363C50;
	Tue, 18 Nov 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F0W3gtgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9636357A3F;
	Tue, 18 Nov 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479263; cv=none; b=uTQS4ULkAgsAO3R99XhXw5F6LZaDQPQ9LbyxIwGWXY9CJG1fX3SYBaXehBge2kYNs/VnCfd6lmGz1IqwM7teh72DozCcRE0WhcW0vOryjaDE0fUkdZtU7/flHmCAa/sEV3SzAqUwWcpP+adjlnU6dilZjqqcOKyVg6RPDNWigaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479263; c=relaxed/simple;
	bh=nPgr4+YzNypu6q9lRljUKzy4BIV+buJoMMAOWipawLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqQpI7XaWlRLV5+0oEWIzaaYgLrI2HNQi5gOyT88nApU3kqVt7ulEn8KVoyDbTKPjjSsPgUyRfOAVR8y17K9A2aqLkZZlroKzYhMuvkFGukRff95e2ha+Y2OrdcoPW/ObJG/LRdv59yKfLCUay12z0xRQ29hrssQsydPAXHhGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=F0W3gtgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6A3C116B1;
	Tue, 18 Nov 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F0W3gtgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763479260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHsEEDamXTBjz7jsIIRcmnVyYCJKWmTea4vcDHn5vjg=;
	b=F0W3gtgk4ZMlnIpAOfJH68yLnOXi0WTTfKf/1oH0vCf50ebKE0cYxUwOjva03oEp2O8m+E
	P3EpspXuFBOS2Kp8O08KkYxetF7HBOmHrqGBl1wnPtmpkYimck88VwNtjlsVJPy5Zm7VKO
	q5uvLoxY2ZM02Xl8S4r5c7Iv4GTnH4o=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 54ba1b2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 15:21:00 +0000 (UTC)
Date: Tue, 18 Nov 2025 16:20:58 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 08/11] tools: ynl: add sample for wireguard
Message-ID: <aRyO2mvToYf4yuwY@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-9-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105183223.89913-9-ast@fiberby.net>

On Wed, Nov 05, 2025 at 06:32:17PM +0000, Asbjørn Sloth Tønnesen wrote:
> +CFLAGS_wireguard:=$(call get_hdr_inc,_LINUX_WIREGUARD_H,wireguard.h) \
> +	-D _WG_UAPI_WIREGUARD_H # alternate pre-YNL guard

I don't totally grok what's going on here. As I understand it, this
makefile creates `wireguard-user.h` in the generated/ include path,
which has all the various netlink wrapper declarations. And then this
also references, somehow, include/uapi/linux/wireguard.h, for the constants.
For some reason, you're then defining _WG_UAPI_WIREGUARD_H here, so that
wireguard.h from /usr/include doesn't clash. But also, why would it?
Isn't this just a matter of placing $(src)/include/uapi earlier in the
include file path?

Jason

