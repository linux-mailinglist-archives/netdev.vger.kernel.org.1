Return-Path: <netdev+bounces-206751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43683B044A2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD73A8007
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693F23D280;
	Mon, 14 Jul 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db+7UqAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9711DF985;
	Mon, 14 Jul 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507973; cv=none; b=FafTEpVegq1rczPVT4LnzTF+bniNIc8KDODiu9kY/hlAKNmYR2rqclZNmnr7eMS9ByZH6c7J11iDVqO2SZa7S1m2WK8w6SFw3MWwN4SdMNiaybguIubAr1YZwq3liQHmHrSHWvcs+4f3R5oGljXQMawNdiUucJvO0k4wXfbB33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507973; c=relaxed/simple;
	bh=lGlHwINKmDtZDP+RNzG1kSdCoH7nf9v7DpZThUTtKcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+Jsmi4L/DP6hi23AveEB/hfoRClI3wMfyHsxjpi3Co7HyjcbtkKnxStdnZRvdjnug2XvkEVaFf/37Sx9H9kA1sTDueSigyDeaXS1EKze7SFcjoeAusK1DE46yRGF6fr8UTwB23zyvTWhKmJEwhYGn9kZs/NsKkJ2Ii5KDMDlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db+7UqAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA17C4CEED;
	Mon, 14 Jul 2025 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752507972;
	bh=lGlHwINKmDtZDP+RNzG1kSdCoH7nf9v7DpZThUTtKcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Db+7UqAd1KorwPuzo+Nu5KYrt4KyNnRuAlZqv7mmhA/obONsmroNk5f+SQ9RiaiH7
	 jLtSs/TYS/FZfAwf8TmzE06dpcN73uT0i/tiTskzWdJwexXF7fHgmhDopwxp+u2rCd
	 jAbBzSMFYKqy/MyN9mB2MkapxxzjHSgvqFVjH3V7Gk8ReiKxNUnhqRwgQv6tdlvzbe
	 CyRJTv6ymIRDDWFIkcSWZkboEPDGZzYv4zd32eR8rGGZ2E1BuyHVUZWgqbEm+dA/OY
	 goh4I0+JuoM+A+u3exfqIA1czLoRlzv/IiGNGfeszHBEk3uvo2pID3qd3LKvOoIyY/
	 /a4izg/4OZn6w==
Date: Mon, 14 Jul 2025 16:46:08 +0100
From: Simon Horman <horms@kernel.org>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: ISO: add socket option to report packet
 seqnum via CMSG
Message-ID: <20250714154608.GP721198@horms.kernel.org>
References: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>

On Mon, Jul 14, 2025 at 05:02:57PM +0300, Pauli Virtanen wrote:
> User applications need a way to track which ISO interval a given SDU
> belongs to, to properly detect packet loss. All controllers do not set
> timestamps, and it's not guaranteed user application receives all packet
> reports (small socket buffer, or controller doesn't send all reports
> like Intel AX210 is doing).
> 
> Add socket option BT_PKT_SEQNUM that enables reporting of received
> packet ISO sequence number in BT_SCM_PKT_SEQNUM CMSG.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

Hi Pauli,

Some minor feedback from my side.

The byte order annotations around the sequence number seem inconsistent.
And my guess is that __le16 should be consistently used to hold the sequence
number.

Sparse says:

  net/bluetooth/iso.c:2322:28: warning: incorrect type in assignment (different base types)
  net/bluetooth/iso.c:2322:28:    expected unsigned short [usertype] sn
  net/bluetooth/iso.c:2322:28:    got restricted __le16 [usertype] sn
  net/bluetooth/iso.c:2333:28: warning: incorrect type in assignment (different base types)
  net/bluetooth/iso.c:2333:28:    expected unsigned short [usertype] sn
  net/bluetooth/iso.c:2333:28:    got restricted __le16 [usertype] sn

