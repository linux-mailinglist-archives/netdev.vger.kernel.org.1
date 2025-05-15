Return-Path: <netdev+bounces-190858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A019BAB91C7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35393AF07A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598922D4C6;
	Thu, 15 May 2025 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZAfrdmX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B1158DA3;
	Thu, 15 May 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344353; cv=none; b=gpH3DAHNNxmxW1RR7p2wO4c4lQXK3hR2XxGEnTlpO3pMhiGJ6wW0TsCU34lynJVxaIwz8aUoTum7sf2oOFGOK1AHiPxjQ+Cd2JriqZumTrQ+qm35Nn1jg6uoCJiB7EgHxmlVc9MhlEqxQfkvFJ+/ftUJ2Z/GEWh8uMhZZKRKW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344353; c=relaxed/simple;
	bh=z6S5X9MnnkOQohJSFOywHQYKdlN/N3s6Cmbdad8m31I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPa27WSi5wir3DzjAyA/AEdzH9R4MZFsoCiplKK1OruVr5Jx5Rn0Wipk1UziO/1FA0Bgf0uinwGN8rN0O9q0nNXaJM4yFv7594LYC4GxCB69cYGCI3bHTZhXwrVbtE65QhPaulj3iESLxhRpQ6L+3WPaWc2ybN3Ae708+bPZZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZAfrdmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F84C4CEE7;
	Thu, 15 May 2025 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344352;
	bh=z6S5X9MnnkOQohJSFOywHQYKdlN/N3s6Cmbdad8m31I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qZAfrdmX4b4LE4QTIhSyyg0vdCxc/bGV3nAADzgnBfgWlr4ZyAnpAkvDZBq0zio1h
	 EccF2nnQ5TMagEleE5W7XeKT+Tu+39GjmFMWoql+4zBe6FXL+m9kgIZcsM1yKKU50Q
	 3D6kQ46MSk5yIKKcdxUxBTFwKWtk8aIZu32U1AcVFFO5T0nOlU5upE9YB1Fm+IDCBD
	 aCmQKKufjHaDmSDIQBG5Mu0PG+Ll4mrbEQ3mD+clg/4n59hOC7xIcCp8FvQIokZPFk
	 5jUSFL8eKJL2sHuoJZM3fm+orFjiwKSg+WAMFS2V9ogjsHmHIhfhUIW4lQ/WNCowQ6
	 VZDtA1yDT/m9A==
Date: Thu, 15 May 2025 14:25:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Guolin Yang
 <guolin.yang@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
Message-ID: <20250515142551.1fee0440@kernel.org>
In-Reply-To: <CAP1Q3XQcPnjOYRb+G7hSDE6=GH=Yzat_oLM3PMREp-DWgfmT6w@mail.gmail.com>
References: <20250513210504.1866-1-ronak.doshi@broadcom.com>
	<20250515070250.7c277988@kernel.org>
	<CAP1Q3XQcPnjOYRb+G7hSDE6=GH=Yzat_oLM3PMREp-DWgfmT6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 13:38:49 -0700 Ronak Doshi wrote:
> > IIRC ->encapsulation means that ->inner.. fields are valid, no?
> > And I don't see you setting any of these.
> >
> > Paolo, please keep me honest, IIUC you have very recent and very
> > relevant experience with virtio.  
> 
> I did not hit any issues during Vxlan and Geneve tunnel testing. I did not find
> the code which validates inner fields being set. Maybe I missed something. If
> you and Paolo think inner fields are indeed required, then I will remove these
> lines.

Not sure if the stack itself cares, but drivers look at those 
fields for TSO. I see a call to skb_inner_transport_offset() 
in vmxnet3_parse_hdr(). One thing to try would be to configure
the machine for forwarding so that the packet comes via LRO
and leaves via TSO.

