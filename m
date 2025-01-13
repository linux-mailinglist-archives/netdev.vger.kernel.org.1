Return-Path: <netdev+bounces-157915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6F0A0C4BE
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE543A03D5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844DC1F9EB1;
	Mon, 13 Jan 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1c0zmYR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE4C1F9A99
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807471; cv=none; b=bQ0mCRATadXf07A+DvGt4gu4tmp9ToYEJ3hV4/VyHCBR/ZKM9CNFzCoxiM3UwE3RTaVMJ4GobnJ+2L5mmHNPxOIDYdFighXP2cOGcS0PoIzR9dBi+VAmrePNgtGrEXmKcZn84RvMn15SULSxmVJLbpRazDqWSN57KZnSllGVzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807471; c=relaxed/simple;
	bh=ZoyhcsQSNG2iZ4cJCQWBrGW910aG8i/VIOGSCcDNJVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8PepaUyg1K13YDZV5gnV91kJat9CbvdRXvqjJHCJ0Il0Zc5RI2241sW+NsiQYWVoQFYNtJ71pbmHQUI658y/Ui5L/jkAveTV+6obbqa6sUcTZ3nZkh3hHiR0xfEAmAEy4CIUHDyNRR4xF/JnS2/C/fv7LTf5klXrXUDXnWHkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1c0zmYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E462C4CEE4;
	Mon, 13 Jan 2025 22:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736807470;
	bh=ZoyhcsQSNG2iZ4cJCQWBrGW910aG8i/VIOGSCcDNJVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b1c0zmYRvTCRLXsnj01USHS5UzmQJMyoSZLkCBVYndtlfPGH6Q1K/hTwFEU3jS3Gb
	 VALEtiPRY9HzLOpigcJJZNcuHyFuKoefDc6/APjdMgfZYVfDE8B6tD5wRBcip3BTPe
	 j2sLMcZFnwS1xZkFinnDC/6QGwqlj1Z1xekLTYDtlWScpfvWV6iw7akd4ZCCzEFVxe
	 CZ0iFGVmjuo/7mVD5vC0fmaUehxXaMfgp7nbTXHSm6hqffnI1eW2XkuBnWA/VMtxna
	 UosKqaAKErcrkFJi1U1l+ODPUEjOmU3JABDsskB13IwNLc2a12m/u+xZB+nYfiG+ds
	 TRueDQqSBseQQ==
Date: Mon, 13 Jan 2025 14:31:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>,
 magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
Message-ID: <20250113143109.60afa59a@kernel.org>
In-Reply-To: <Z4WRyI-_f9J4wPVL@LQ3V64L9R2>
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
	<Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
	<91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>
	<Z4WKHnDG9VSMe5OD@LQ3V64L9R2>
	<20250113135609.13883897@kernel.org>
	<Z4WRyI-_f9J4wPVL@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 14:20:56 -0800 Joe Damato wrote:
> > XDP and AF_XDP are different things. The XDP part of AF_XDP is to some
> > extent for advertising purposes :) If memory serves me well:
> > 
> > XDP Tx -> these are additional queues automatically allocated for
> >           in-kernel XDP, allocated when XDP is attached on Rx.
> >           These should _not_ be listed in netlink queue, or NAPI;
> >           IOW should not be linked to NAPI instances.
> > XDP Rx -> is not a thing, XDP attaches to stack queues, there are no
> >           dedicated XDP Rx queues
> > AF_XDP -> AF_XDP "takes over" stack queues. It's a bit of a gray area.
> >           I don't recall if we made a call on these being linked, but
> >           they could probably be listed like devmem as a queue with
> >           an extra attribute, not a completely separate queue type.  
> 
> Sorry to be an annoyance, but could this be added to docs somewhere?
> 
> I think I did the AF_XDP case I did two different ways; exported for
> mlx5, but (iiuc) not exporter for igc.

Yes, I think netdev.yaml is the best place to document the meaning of
rx and tx queue type. Are you going to take a stab at it?

> I don't want to hijack Gerhard's thread; maybe I should start a new
> thread to double check that the drivers I modified are right?

Ideally we'd have a test for this. How is your Python?
tools/testing/selftests/drivers/net/queues.py

