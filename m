Return-Path: <netdev+bounces-193722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE367AC5328
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 18:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A58D3BF07E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751C27F16D;
	Tue, 27 May 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="nZZyqVxr"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05327B500
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364018; cv=none; b=uzUGjs8Lby5vuJuuAn1BMElbfAFVnM2Z64hiPJmBBgHpMnBZU5Zbwb6BBNPzUWkhUFdEwcHapISW9hFg+a0wbPA99UMEGqSJPVjZxS0cLFyGByHTbn0rV4v4+4kqn38gi8e49H7ukHB6X6DXVn9p+RtTTQpEJOmWl46PkV7oIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364018; c=relaxed/simple;
	bh=3ExNkL/IaWnQvBBtgbCkjJkvpSG51Wx9bzuEyOsS+WQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=AUHGmHQGCG5upbvcQC5CUBPf/7B62kYZWpqpRL2iMHyrlBBRt6b+b/++G/9qspKAt+Tlq5sdu5RiY0mL1j9rOkKAedfT6KSj68xK3JR9BTKBfRenaKp9rNkPIfjQ6sqxVeBaOM7LQ7baYuk0T+vK85jhLcfRCHXYeQCLJeswemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=nZZyqVxr; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D24F1240028
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 18:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1748364014; bh=3ExNkL/IaWnQvBBtgbCkjJkvpSG51Wx9bzuEyOsS+WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=nZZyqVxrULYSRwEkT9s1dorbl8COMIUXokg1sVD0S380UWyE00y0AafdztBpxZu7H
	 J3p+qkif/u/AQ5C2ER6Cf6C8GpmhUiH4SpI3HVpPQWATWQJs+jR07b1NxmmYn0ykcU
	 cMKYlAYR/QWmAw3zbVHn9t2e9YIix/pXheUMTPohv3fOf6M7Anoa79WMCimL43INdV
	 WxPwO/px3UVR2M8JT8GZbs9POViesHKCj+GE0jpvYRJ84ZzSNnZP4vYWthYqaSWPlj
	 J7h7E1Rsf4BajmRLXZP1MqMTVFoLMPqqmBbYKHjw9uGKRNW6pjYHKSRh9Mhcp7Zdu0
	 az2xPuv3ItUtw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4b6JJr55R9z9rxF;
	Tue, 27 May 2025 18:40:12 +0200 (CEST)
References: <20250526-net-tipc-warning-v1-1-472f3aa9dd9f@posteo.net>
 <DBBP189MB13234B89CBA74E8127527051C664A@DBBP189MB1323.EURP189.PROD.OUTLOOK.COM>
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Wang
 Liang <wangliang74@huawei.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com"
 <syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net: tipc: fix refcount warning in tipc_aead_encrypt
Date: Tue, 27 May 2025 16:39:22 +0000
In-reply-to: <DBBP189MB13234B89CBA74E8127527051C664A@DBBP189MB1323.EURP189.PROD.OUTLOOK.COM>
Message-ID: <87bjreuhw8.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Tung Quang Nguyen <tung.quang.nguyen@est.tech> writes:

>>Subject: [PATCH net] net: tipc: fix refcount warning in tipc_aead_encrypt
>>
>>syzbot reported a refcount warning [1] caused by calling get_net() on a
>>network namespace that is being destroyed (refcount=0). This happens when a
>>TIPC discovery timer fires during network namespace cleanup.
>>
>>The recently added get_net() call in commit e279024617134 ("net/tipc:
>>fix slab-use-after-free Read in tipc_aead_encrypt_done") attempts to hold a
>>reference to the network namespace. However, if the namespace is already
>>being destroyed, its refcount might be zero, leading to the use-after-free
>>warning.
>>
>>Replace get_net() with maybe_get_net(), which safely checks if the refcount is
>>non-zero before incrementing it. If the namespace is being destroyed, return -
>>ENXIO early, after releasing the bearer reference.
>>
>>[1]:
>>https://lore.kernel.org/all/68342b55.a70a0220.253bc2.0091.GAE@google.com
>>/T/#m12019cf9ae77e1954f666914640efa36d52704a2
>>
>>Reported-by: syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com
>>Closes:
>>https://lore.kernel.org/all/68342b55.a70a0220.253bc2.0091.GAE@google.com
>>/T/#m12019cf9ae77e1954f666914640efa36d52704a2
>>Fixes: e27902461713 ("net/tipc: fix slab-use-after-free Read in
>>tipc_aead_encrypt_done")
>>Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>>---
>> net/tipc/crypto.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>>8584893b478510dc1ddda321ed06054de327609b..49916f983fe5e1d484779451
>>04fe5fc589257533 100644
>>--- a/net/tipc/crypto.c
>>+++ b/net/tipc/crypto.c
>>@@ -818,7 +818,11 @@ static int tipc_aead_encrypt(struct tipc_aead *aead,
>>struct sk_buff *skb,
>> 	}
>>
>> 	/* Get net to avoid freed tipc_crypto when delete namespace */
>>-	get_net(aead->crypto->net);
>>+	if (!maybe_get_net(aead->crypto->net)) {
>>+		tipc_bearer_put(b);
>>+		rc = -ENXIO;
> -ENODEV should be used instead as we also use it for bearer ref count. Thus, caller of tipc_aead_encrypt() does not need to care about handling new error code.

Hi,

Thanks for the review!

Addressed in v2.

C. Mitrodimas

>>+		goto exit;
>>+	}
>>
>> 	/* Now, do encrypt */
>> 	rc = crypto_aead_encrypt(req);


