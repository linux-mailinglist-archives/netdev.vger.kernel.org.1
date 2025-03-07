Return-Path: <netdev+bounces-173001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A9A56CF1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E90417A9F6
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CDF221D9A;
	Fri,  7 Mar 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QuRXrV/l"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F3221DAE
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363226; cv=none; b=enS15mh3WF96K9uS6wCnuQ+1LzYDTra6jiKvQHCCZ6ZxhQz+JZu21aJ8QC6T68JUTjJ9wbv4GO+jeLtX/U8uPaAS92xQQ4NU/WpHhY3jj8wegSqx9POIjKO0LPLyYVNlT0PEi6fijIEXdHn5sgTJDlgewtq6LoGxjodXlaCgoYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363226; c=relaxed/simple;
	bh=oIXfFrGLxAwZEMNjRP+9OyETjkmshbUJaAPAd1s1+7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux+g18COYIQ4fQe60YTo6jbSpZLUVhCblhJUC1XY9plQfl6HPPRW3WRooDz2+5JRJTV6ZsJQh7JQ7pfK3DzYEgTh3Alw4pN+79kDI07BpRHN0P9gY2kBM3oVn5XtNdGBP25nU8lBG2kbHHdjq6ACq+ueAgbezcCv/Y/TEzSPD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QuRXrV/l; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqa7U-003tQ8-AY; Fri, 07 Mar 2025 17:00:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=e4VGqN7zO0GTuXkAoLE7gbKJJZJGZ1XOfunSgGWuxv4=; b=QuRXrV/lL52Agxz0k+atzLiuzW
	EuDj8mWhE4crHWKObKZLVI3vsMf/L0ZTmdT54tVecYZno0fTfhxT3GwE+ozPHzcAKlJoP9WFrEYHa
	Ch+7IXZ2uQDGP/U3vMp4vxwhhZx/7a43TzIFHgApNytdKRye/IYHDcdWpdRsNHi7Y+dtWs4LmqzPC
	/yPFKuXhWaPQxS+mFxsCHZ6jF0WI0JZnZX+jtjeB6PFjoGgAm0cz45MrFqT71wjVRewLMwPzaent7
	arHYWULU72IL8ChLS5X//AoBnT7v9c32kvSqueID8xSmnbgKV1yQJZVqBHmWYBfWLD1fFpkPWr10Q
	dOA4tq/w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqa7T-00022d-J3; Fri, 07 Mar 2025 17:00:15 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqa7O-008KK4-VW; Fri, 07 Mar 2025 17:00:11 +0100
Message-ID: <96121a41-20b4-4659-84d1-281b2b1ad710@rbox.co>
Date: Fri, 7 Mar 2025 17:00:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <wt72yg4zs5zqubpyrgccibuo5zpfwjlm5t2bnmfd4j3z2k5lio@3qqnuqs7loet>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <wt72yg4zs5zqubpyrgccibuo5zpfwjlm5t2bnmfd4j3z2k5lio@3qqnuqs7loet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 15:33, Stefano Garzarella wrote:
> On Fri, Mar 07, 2025 at 10:27:50AM +0100, Michal Luczaj wrote:
>> Signal delivered during connect() may result in a disconnect of an already
>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>> been placed in a sockmap before the connection was closed. We end up with a
>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>> contract. As manifested by WARN_ON_ONCE.
>>
>> Ensure the socket does not stay in sockmap.
>>
>> WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
>> CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
>> sock_recvmsg+0x1b2/0x220
>> __sys_recvfrom+0x190/0x270
>> __x64_sys_recvfrom+0xdc/0x1b0
>> do_syscall_64+0x93/0x1b0
>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c  | 10 +++++++++-
>> net/vmw_vsock/vsock_bpf.c |  1 +
>> 2 files changed, 10 insertions(+), 1 deletion(-)
> 
> I can't see this patch on the virtualization ML, are you using 
> get_maintainer.pl?

My bad, sorry. In fact, what's the acceptable strategy for bouncing addresses?

> BTW the patch LGTM, thanks for the fix!
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!

One question for BPF maintainers: sock_map_unhash() does _not_ call
`sk_psock_stop(psock)` nor `cancel_delayed_work_sync(&psock->work)`. Is
this intended?


