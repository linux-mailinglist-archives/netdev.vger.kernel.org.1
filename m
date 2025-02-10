Return-Path: <netdev+bounces-164715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4624A2ECC9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE11160D0F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6FF221D88;
	Mon, 10 Feb 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="FYmxuoaO"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4E17BB6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191448; cv=none; b=bKAQmIWEeAB/2wmKNaHxTk0gljc/oz5pkbuZ2nh4bDA9CFeMwlRv7vGKO/5UcD1A6VlGeZ4OlO0qANF/HzTJKuW/gUrIRA/0B6lUnhXr6g6uZUYjp1RoOw5I3fOlET6erJMfXXgU7JNZHfg4rjP6eOlxYTL6ujY4vl7YRYo6Hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191448; c=relaxed/simple;
	bh=wLXaWUduSKs261rv8e4jnzmmI79Sf/KqPFAOmNqHIyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK+rksGFYd8YuuVya1nP304jskQn83EkOGKzC9wqz4rwmp/4wjWqaOR/XlMvw0QRWAvG9OuYCjEZySusIxh1svnt8D6I9o7IG4H5YOhcLmWzeKw+1Os2JSURl+cUezfGnLVbmtI5EBNJCXYOJVzVexvTiSYnX3wf1W5IOItdEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=FYmxuoaO; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1thT8s-00BSQe-1x; Mon, 10 Feb 2025 13:44:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Cs8P/Xd2MuEmbYH3QRWV2bwKBSBIHj2Wm5m7LgYGROE=; b=FYmxuoaO/34wR2TgTRkknR4v6w
	rnSVj+Cl1Fwx3G7cyheCNZgOxo8eAGqIM+CqMm9fnBe03VdsARlD/6nHE/fbo09HgKe8zM8f9vFmD
	MOE1zxaI0aKkcn9w+CQTFCyFx8/UNUkmUzNd7VR9o7Cb8qBv9CHWiayDiFxV8XYJ4kJi9L3cMczP7
	Ke+KL2p9Q+S1Yvpr2auhEAGA9J+jIWh7T14j4L8DgS99WDoUATKDqE2cck0uP2zqvPc1sM8nkqohX
	Shm0ifOkO4epcvFila/T+WB/HlHII+TC0lHRQ0/dDaHc8WvEz3su/CVYlXZMcZ9z3zNcfXLcIpBSP
	jC70k9ZQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1thT8i-0002Cv-8d; Mon, 10 Feb 2025 13:43:56 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1thT8Y-007Rc6-2V; Mon, 10 Feb 2025 13:43:42 +0100
Message-ID: <6a181a14-a665-4796-bec7-d73dcc39a319@rbox.co>
Date: Mon, 10 Feb 2025 13:43:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] vsock: Orphan socket after transport release
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
References: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
 <20250206-vsock-linger-nullderef-v2-1-f8a1f19146f8@rbox.co>
 <3h4ju6opsomkttmppwvugofepnecqegdb52tsq7n5c5zrvan22@echiriqwccz7>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <3h4ju6opsomkttmppwvugofepnecqegdb52tsq7n5c5zrvan22@echiriqwccz7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 11:24, Luigi Leonardi wrote:
> Hi Michal,
> 
> On Thu, Feb 06, 2025 at 12:06:47AM +0100, Michal Luczaj wrote:
>> During socket release, sock_orphan() is called without considering that it
>> sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
>> null pointer dereferenced in virtio_transport_wait_close().
>>
>> Orphan the socket only after transport release.
>>
>> While there, reflow the other comment.
> May I ask you why?

For aesthetic purposes only :)

> ...
> Code LGTM!
> 
> I probably wouldn't have changed that comment because of possible 
> conflicts.
> 
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Got it, dropping the old comment reflow, thanks.

Michal


