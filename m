Return-Path: <netdev+bounces-239742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A93ABC6BE73
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05B00365911
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514952C11C6;
	Tue, 18 Nov 2025 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SDuevgxm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27743370311;
	Tue, 18 Nov 2025 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506361; cv=none; b=sBHLrZKSZvfommU3hcrxk6nfmVniZ27jRn+kzL4jAkrEYDnDTtJCIMPRqiBUwujfoj5HuZsTb47Yv2yySFbrEhDvbIbA+m3fjukWXbnGjhPRLkvltQrnjGagSitzH4iQ5EybkxEywS6geOu2UsstZNLSHTr/+CJ+TqozoXJOgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506361; c=relaxed/simple;
	bh=rHlIN407Y6+U6sIUuWmuTUedBFH1snie3CloV5Jji8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boOwmH5NXcAwoFu1UtfkidDJv9KgxZUmGKl+kCCEu8otKwScmlYh4zryKrW2i1FElkoNVd9Fl3Ww6zPvmLDQSD3yCJRm15srLO7o+f0qVF4J1c+IElB89D8P3F666OC14Vsii7RrZcZkmgUSza5W6yQbebriqPHVlVdAq36yXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=SDuevgxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B5C4CEFB;
	Tue, 18 Nov 2025 22:52:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SDuevgxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763506357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHlIN407Y6+U6sIUuWmuTUedBFH1snie3CloV5Jji8w=;
	b=SDuevgxmS3hOec3uArK0GmWXRrF7F07PMB6jbOLKB56eNZjPrDaF22ETXamwoK4oUMUsLQ
	YH0kftGOE+hSacGcaQUu79sUnbAZ+vVc2SV15zCz8vHI1C/s140TZlNyKqcYtMIFLjylK0
	dJqpcluCN4iqR2dilba8u8cXVPW9P28=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ba56afb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 22:52:36 +0000 (UTC)
Date: Tue, 18 Nov 2025 23:52:30 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for
 wireguard
Message-ID: <aRz4rs1IpohQpgWf@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-5-ast@fiberby.net>
 <aRvWzC8qz3iXDAb3@zx2c4.com>
 <f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
 <aRyLoy2iqbkUipZW@zx2c4.com>
 <9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>

On Tue, Nov 18, 2025 at 09:59:45PM +0000, Asbjørn Sloth Tønnesen wrote:
> So "c-function-prefix" or something might work better.

Also fine with me. I'd just like consistent function naming, one way or
another.

