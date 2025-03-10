Return-Path: <netdev+bounces-173573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA9A598F1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8153A462F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6422D7A4;
	Mon, 10 Mar 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPC9LmCl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A722D79D
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618638; cv=none; b=eTCpZ7nCjUQMu3y0ipQElS4WCiyrpmONEZkzYPat8dLm8yz1M4ZgSIPtTFLeE3GU2Ez45Cp2s8mUdBYnvZhRXGEo/DTnL6wa8FeaJ7TI3zVrQTsTFsTzl/DGokUb8YjXKzz+8tpfcer2idwSn6HUbNyJGHoktgXIfM0o4iuF2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618638; c=relaxed/simple;
	bh=DDFSBY+EihpyeoK5HiOTV5WFyxGVogpelwrvov4Lxpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpeOyacIZMIY/Tx4ycljXXhFFa9Q+2pMaBfOvYy5XzfiT+EwJ60j8T2G/DIzYV8eNBYQ3bIKJwwoVv8iQFltz0AtOWImcoCoflhFrqWrXPNvYsyXSyQ8Wo0E859v7kJRQUm/MLigm9P0wX3b36OTH6eCJPSYCbxw0FWFXYMc6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPC9LmCl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741618635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jWNWb95iV+mWVJ+4wh8JfosTFPQltaYwNbslh/GR93Q=;
	b=GPC9LmClCAJ+SsZyXWsSX6/4fABWSekeZujXVedQIjq9/aER2bv4ouz7Ax8MkFxRHxaUsr
	LuQNZna/ZLblHRTmNnhOM0FHBZ3mJwxVJjPMgcRrsmXDxVSMNHjUTBYk4+TsjZLTHEoEmP
	u2ZP4b9EKKqYte19DLvB75EIHBtPYTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-QKlP1qfjO4u4rd2y1EPNVw-1; Mon, 10 Mar 2025 10:57:14 -0400
X-MC-Unique: QKlP1qfjO4u4rd2y1EPNVw-1
X-Mimecast-MFC-AGG-ID: QKlP1qfjO4u4rd2y1EPNVw_1741618633
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394040fea1so20869305e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618633; x=1742223433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWNWb95iV+mWVJ+4wh8JfosTFPQltaYwNbslh/GR93Q=;
        b=iUnAsW+UyJ3V0bkgLXTfRvyU0gCX8ZGmFwxGkw8z1bDstLLuAihWpydfQ2NTGZuL5u
         giXae7B1re3pLRxkG1pKUzFm535hGA33Ao1fjXpMtGCIeW8yv8YL16L59N7EsBDGhm6q
         3SIEYkj5L45BbKngwYXKzaYHvceT+XouinIIVk/VcAmJSu6gAVSx6AeyXpu4T7yHpGSE
         E1CscIb47810yGU6cDKQZ38M+z7a5B4GRep4yQ0AsPgY+6cPKkyFl4ddU0AGFv76SXqg
         kJEfDs2/f/jRrp8IcnSYRMEQNNpi4GAmxFARKeY3c3P/J9Jgl292cT+WUAPJC08GGIcd
         ss3w==
X-Forwarded-Encrypted: i=1; AJvYcCW1zzwJ15lbL7YnA3mOPXYkp6vgbz7wX28aIm81vXG1iCOaXfd1goRn0bQV1VXa+xDxWw/kK/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpiS5KHy9RTZE40oyAvK3Pf5pBIl1kvO3d4Dw3nxGWBPl06uM2
	Z4QZRi61kPRy5h67YssuOo9ENYtJgEq+502jf52NfM1JEQ+7tvq9GFPeOQGKbcQ6M9HrLC+X+MW
	XjKegMTZJx6UJG26NKUnYe6DSX6S2How35aZCJonBrmoUbdvpqkD6eg==
X-Gm-Gg: ASbGncvAHUUFIUBqWNTwfHPZPm26Me7mutFyHSwirv4EkpQjNRFiG0mMbYbli0B292x
	meIU/hv5V4hTf0JMMZhI2RKssREx/gHsnxD5pQmvIxeCAUfe7U7jQqG/LVHNMwfHu/wmaaSOjMa
	FsyuHfM8RFAhIGV3ljA5+9WiY4Jn8LT+A/T61ui4pt8n6ibwqSbeanMJGc14itzJzgAeULVl1zv
	CJrXObSGmgEjrblTR7aNkCPuRmcbbmJhnq4ugkGPRgZ9LA9GzZ1Jeqfk8RWwLEysiw4+4HzOLp6
	LmO4k/yarlE9RREDvQj/BXwDDw42ERO8i83fcRxHtM5yXBeiG5vaW4fGgaYVTgYf
X-Received: by 2002:a05:600c:a297:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-43cf3e1aba4mr29889555e9.12.1741618633102;
        Mon, 10 Mar 2025 07:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzpkMUlLsha9DGTnq1BtbAasQwodmyA9Pe+3Lsyz/kRmAtG7EMWFM+0qhRV1W1xI6hJpv6iw==
X-Received: by 2002:a05:600c:a297:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-43cf3e1aba4mr29889105e9.12.1741618632510;
        Mon, 10 Mar 2025 07:57:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d017a9fa2sm901115e9.1.2025.03.10.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:57:12 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:57:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <d7xxfu4af2wafmlj73ffhvmncg6zfuhc5cacezijddshbgmicx@37acg47rvclu>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <wt72yg4zs5zqubpyrgccibuo5zpfwjlm5t2bnmfd4j3z2k5lio@3qqnuqs7loet>
 <96121a41-20b4-4659-84d1-281b2b1ad710@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <96121a41-20b4-4659-84d1-281b2b1ad710@rbox.co>

On Fri, Mar 07, 2025 at 05:00:08PM +0100, Michal Luczaj wrote:
>On 3/7/25 15:33, Stefano Garzarella wrote:
>> On Fri, Mar 07, 2025 at 10:27:50AM +0100, Michal Luczaj wrote:
>>> Signal delivered during connect() may result in a disconnect of an already
>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>> been placed in a sockmap before the connection was closed. We end up with a
>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>> contract. As manifested by WARN_ON_ONCE.
>>>
>>> Ensure the socket does not stay in sockmap.
>>>
>>> WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
>>> CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
>>> sock_recvmsg+0x1b2/0x220
>>> __sys_recvfrom+0x190/0x270
>>> __x64_sys_recvfrom+0xdc/0x1b0
>>> do_syscall_64+0x93/0x1b0
>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c  | 10 +++++++++-
>>> net/vmw_vsock/vsock_bpf.c |  1 +
>>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> I can't see this patch on the virtualization ML, are you using
>> get_maintainer.pl?
>
>My bad, sorry. In fact, what's the acceptable strategy for bouncing addresses?

I usually use --nogit so I put in CC pretty much just what's in 
MAINTAINERS (there I hope there are no bouncing addresses).

Thanks,
Stefano

>
>> BTW the patch LGTM, thanks for the fix!
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Thanks!
>
>One question for BPF maintainers: sock_map_unhash() does _not_ call
>`sk_psock_stop(psock)` nor `cancel_delayed_work_sync(&psock->work)`. Is
>this intended?
>


