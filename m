Return-Path: <netdev+bounces-151801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F2B9F0F15
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C1B18840FD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0471E1A33;
	Fri, 13 Dec 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PECn86gG"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F31AAC9
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100089; cv=none; b=HoADKz7KfyONj96f6wZ39aikgNBVVt1VeuJdHKAXMT9cq+pqPcy0lbS6dF8E1PP5z8EabPrAfGXT2Jfxj+7Q/mIms+MBMZIUwe2u1No/2cJPBs55XhZOnOK5iCKb+OsbQX3oWon4HtgJrHzMA+OJ0ztFBGxkQFavKJXHQqkJFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100089; c=relaxed/simple;
	bh=c4F15RG2d0j9QeZacEl5svIgURF7DXTWdHgj+hwj2Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiSmQCQgrb/A9/SV81u989scUd5JSr8ABTXX6GB2ts//riSNqOI8DX3l8/Ck2pGOJBaJx8b8C6L40YN5EsNrSHpRxWJ0uqS9Aqttkk1BqHexliGuGZBU3chSoIqtgQmxCtQHe935LAsaj4ThMa6orV0dGy89BrlBhZLSd2O2OrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PECn86gG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tM6e6-007Qkm-Bh
	for netdev@vger.kernel.org; Fri, 13 Dec 2024 15:27:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=KjC3Gut4LxlqzDuEl3SWFc4rKnvzybsZ7ql36yugD3E=; b=PECn86gGiSmCDHatmLBeXFnY1w
	m5v4Exhw+bA3uCKrT4yRWrd2fYZQgc+b2ejVZsS7g44tFTde5MAzgkZLtyBTc/y9N9o6jVIjBysea
	zU0wtkcqj+22NMPG+RRbMy3ZU5gel172v28NKHTu1N1yihDfG2YR4NClmwDk2MNgIK8dGz0KkWx6a
	TZz9X1KEL+/sPACLfaqX87412FfnD3DVyOiAYYA+GaTod9cOqjqP/W3SU+JxbJZlDfpQHLDSR3k/y
	xoejEqs776/w7ILs6AaJltT+WIFiahNl2GCnSBfNDSZiNdkZNF9O7H92F2iyr6p/qdhiGiM9VhpWu
	h2Kl5uqw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tM6e5-0001TN-QI; Fri, 13 Dec 2024 15:27:58 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tM6e2-00Czns-JF; Fri, 13 Dec 2024 15:27:54 +0100
Message-ID: <0bf61281-b82c-4699-9209-bf88ea9fdec5@rbox.co>
Date: Fri, 13 Dec 2024 15:27:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] vsock/test: Add test for accept_queue memory
 leak
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co>
 <uyzzicjukysdqzf5ls5s5qp26hfqgrwjz4ahbnb6jp36lzazck@67p3eejksk56>
 <a8fa27ad-b1f5-4565-a3db-672f5b8a119a@rbox.co>
 <jep457tawmephttltjbohtqx57z63auoshgeolzhacz7j7rwra@z2uqfegja6dm>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <jep457tawmephttltjbohtqx57z63auoshgeolzhacz7j7rwra@z2uqfegja6dm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 12:55, Stefano Garzarella wrote:
> On Thu, Dec 12, 2024 at 11:12:19PM +0100, Michal Luczaj wrote:
>> On 12/10/24 17:18, Stefano Garzarella wrote:
>>> [...]
>>> What about using `vsock_stream_connect` so you can remove a lot of
>>> code from this function (e.g. sockaddr_vm, socket(), etc.)
>>>
>>> We only need to add `control_expectln("LISTENING")` in the server which
>>> should also fix my previous comment.
>>
>> Sure, I followed your suggestion with
>>
>> 	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>> 	do {
>> 		control_writeulong(RACE_CONTINUE);
>> 		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>> 		if (fd >= 0)
>> 			close(fd);
> 
> I'd do
> 		if (fd < 0) {
> 			perror("connect");
> 			exit(EXIT_FAILURE);
> 		}
> 		close(fd);

I think that won't fly. We're racing here with close(listener), so a
failing connect() is expected.

Michal


