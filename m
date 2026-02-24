Return-Path: <netdev+bounces-260295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLufG8oBnWkeMgQAu9opvQ
	(envelope-from <netdev+bounces-260295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:41:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 194F81809B9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E54C930634F3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000CC2135AD;
	Tue, 24 Feb 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="D0Q+N70w"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250181C5D59;
	Tue, 24 Feb 2026 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897280; cv=none; b=Oljq/wV3Kz23KyBcFBuWwKB66JN7ShHdydcRjVJCeinf7Cls6vwAPIC8CyDnah7URK5bYhN90hVN6QBubt/i/Fh+6YGksKDQVRvLC8s2BP5ZpbeXRjeneG9p0ClTiZYmGEuGqoHdX3NaqUidDo7wEqbETjdWgeW1tFcL8r9FkBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897280; c=relaxed/simple;
	bh=oNllo4YAwM9j6FVq1VjCwTXK8dhNnbE9oCe8LZNaw5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgSHhM6WUXijSyllCCA2ugaBruB7mYN8+4jTAOk1xk3eqoVzRk1COEahtuRfjQw/B7E+1UuxHH2kVw5YAVrWDY8cMhjqI8mp2MQlK8t3ohS0BCzPyfUNn5Th83Bmq6urGkB0FEjXSGfE0DlrRzGBVHUCnTBp5s2PXf7qr3BMvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=D0Q+N70w; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1771897271;
	bh=oNllo4YAwM9j6FVq1VjCwTXK8dhNnbE9oCe8LZNaw5g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D0Q+N70wj8swYw9qCGj4v3wqNDoeAwdiw3u5FwLzvOyCk+cGrnnZc/RyujCnYGhtN
	 bSQVCF9LaaGmDKy5gVTgicBcjwH+3bCqmufIZ1/3lECoYKKa2rVc2z1VEabZsFgINE
	 mbHJp9AZXuunLZLjTxqpw2h6385WB99xYP1yhz8OjOMak0C2i0VkKZqw6Nmgvu3s7h
	 Pk0+Q4v1aYzfzvwYNgIwe9t5/DCahJntF8AEoNrIhHaIDc2NUpJeKdwpjR3V004MLv
	 N0S7ekNtnAJuSQkkEEUV/dxVCwh54Ltv/YvMDQTmsm1UoTMf1NAxx8jjUld1lmvRsK
	 kLEX7BFL5sinQ==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5C3126015A;
	Tue, 24 Feb 2026 09:41:11 +0800 (AWST)
Message-ID: <51539ac8b47aa0418ce1050ae765329b0d11142b.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: usb: properly drop the usb interface on
 probe error
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>,
  stable <stable@kernel.org>
Date: Tue, 24 Feb 2026 09:41:11 +0800
In-Reply-To: <2026022319-turbofan-darkened-206d@gregkh>
References: <2026022319-turbofan-darkened-206d@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260295-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,codeconstruct.com.au:email]
X-Rspamd-Queue-Id: 194F81809B9
X-Rspamd-Action: no action

Hi Greg,

> When an error happens in mctp_usb_probe() the reference count on the usb
> interface structure needs to be properly dropped as it was incremented
> earlier in the function.

Looks good, thanks for the fix.

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

