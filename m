Return-Path: <netdev+bounces-153275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D909F783D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE52188FCC4
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C86221D9E;
	Thu, 19 Dec 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oqWp2kWB"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D122145A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600023; cv=none; b=si1oo1Nnodtm2wcEBc2McR8vOs+opqJ6zJ90WfmKd9kYFrf9hM+SJJtSdYwoaTwPPbCyg6UAXZMJ8wh3BbPoItGg8BWqDyngJ50MkOnsezLpafa2RLHxzN0dq3mT1p1Foyhovf6zE9TgapBMj5d+yRFeo0NHwk77qwfHxW2J7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600023; c=relaxed/simple;
	bh=UlSWE8fX06M1+RSUEnkhQX+4j05uejMM0frc5t8Ptcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mbmlkn8733EOws4YqLBozj7mz6/TQ5onZUWIWhww+I81fJT+A0IHONPJ4TXbw0H6lVPQs25GpDTBL4wRFsodycj8odjiAeNzkrMselC42lsih7iGM6ANGECddABSnLwzbfOPAP82kH7ltR1Rq8vDwtlhURIHYFr9QJk9RtABwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oqWp2kWB; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tOChX-0075gl-H9
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 10:20:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=S6HWm0rFp/6uSBK3d/wgDlAauikks3ydhOi9uHCFSr0=; b=oqWp2kWB8Cp18HNDxe2uvCnqqT
	YUiihs7LL32EL1VzPWdX2cnVJAmGfQRZDvkg9/yjCXFIpt8ttBLQXZX/SuhrdPmQovDfFsu57O50F
	IctYcODkQB4LuRjM31yVbdd+9x9O+U8qqvRfsI3DcSGkexxdUKceUSQHvlP1zsl3eCVkiKA3P2oWt
	QmaMIh67XW1C4P5smKXJwt+fbB2T945q8RdxlYGLAHYQJWKJbZvCFcRQnVUcvbDgLpachoANL/e4Y
	nMZ+2Ngqsd1JjKKctTPBux4S6r7HUpAgqln/5GT0gPKzgN93R+Yl1HXge32QBtTBEZHDJrdPIobbq
	Thq6z2kg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tOChX-0000If-3O; Thu, 19 Dec 2024 10:20:11 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tOChJ-00CwjX-9i; Thu, 19 Dec 2024 10:19:57 +0100
Message-ID: <8f1536c6-480d-4973-8fa8-ad94e6cb15dd@rbox.co>
Date: Thu, 19 Dec 2024 10:19:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/7] vsock/test: Adapt send_byte()/recv_byte()
 to handle MSG_ZEROCOPY
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
 <20241218-test-vsock-leaks-v3-4-f1a4dcef9228@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20241218-test-vsock-leaks-v3-4-f1a4dcef9228@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 15:32, Michal Luczaj wrote:
> For a zercopy send(), buffer (always byte 'A') needs to be preserved (thus
        ^^^^^^^

And this is how I've learnt how checkpatch's spellcheck works.
Should I resend with this typo fixed?

My bad, sorry,
Michal


