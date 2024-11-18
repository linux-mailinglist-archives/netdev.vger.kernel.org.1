Return-Path: <netdev+bounces-145910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024399D14D0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25EB1F236C7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC591A0718;
	Mon, 18 Nov 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o2BM5QHw"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AE448CFC;
	Mon, 18 Nov 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945299; cv=none; b=M8K9CXIjGmtZ+II2o1MkRlLAlUZKAX63nUbNVN/lt+ZUo/wgWaLfSQUn/a/OVJg0RKt5Ga7wngclf9wsS0NtuB+AC2NOi7I3aFhtI3EvK/JgJImih2YhTuqXq/ec06FK8KF90RO89/otgnWbxAB1hQVY7ZSCmwPWVOFHMr3ytug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945299; c=relaxed/simple;
	bh=KWjaldySSsYfQCb+Fv1nXh6FZAdhvSHeg1RBQdsBVf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+WHy5WptAm/kDP4eDf2929Mk0Q/CmSyrpf3yryiwHl+SLAkFnm2dy4XX9hYQYUdWTBfvHEMRzWQkzoV439Wcv9lP5+2QK4GSXKWsAnscCIqW3HyIbqJAYDfPOjG7DR6e/xRWXuYqd24lYvCE/AG+ZSG4uYs8doH/S63llf02EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o2BM5QHw; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CF4F20005;
	Mon, 18 Nov 2024 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731945293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWjaldySSsYfQCb+Fv1nXh6FZAdhvSHeg1RBQdsBVf8=;
	b=o2BM5QHwOM9jIig3NLGd5FDgFvDpNzcM36wQa5NARzekPb/pj7gB0mOSC9JaANGhYCcY9q
	qpM/6ojDZQaViCYcreN+FL/vQO4v8MTzQXp35MtLGOpKh5zGVCm6MMnhZ6FOH7/1ZyY/Mh
	zberEPyKb2XCgNUmA4SPa3Xd9Vj7+avL4asbVL2OdGT7rOTl/H2POaDseg6ktW5mG1w6C7
	PbpQKkKU44v1Ms8pA5luj0l1q4IxcJmYGQiQDpYpNFHR97HeM0x7qOO2ixZ2z+iwedaBcA
	lXKynAIpWHh1at+lCyTcWXnpIWC3ERtrHrDusEfmGaRnNdrQrMlO6eycPqTOLA==
Date: Mon, 18 Nov 2024 16:54:51 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
 <sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, <harini.katakam@amd.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Add
 bindings for AXI 2.5G MAC
Message-ID: <20241118165451.6a8b53ed@fedora.home>
In-Reply-To: <20241118081822.19383-2-suraj.gupta2@amd.com>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
	<20241118081822.19383-2-suraj.gupta2@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Mon, 18 Nov 2024 13:48:21 +0530
Suraj Gupta <suraj.gupta2@amd.com> wrote:

> AXI 1G/2.5G Ethernet subsystem supports 1G and 2.5G speeds. "max-speed"
> property is used to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> max-speed is made a required property, and it breaks DT ABI but driver
> implementation ensures backward compatibility and assumes 1G when this
> property is absent.
> Modify existing bindings description for 2.5G MAC.

That may be a silly question, but as this is another version of the IP
that behaves differently than the 1G version, could you use instead a
dedicated compatible string for the 2.5G variant ?

As the current one is :

compatible = "xlnx,axi-ethernet-1.00.a";

it seems to already contain some version information.

But I might also be missing something :)

Best regards,

Maxime


