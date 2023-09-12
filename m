Return-Path: <netdev+bounces-33253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216CE79D377
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5761828193F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B818AFA;
	Tue, 12 Sep 2023 14:22:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9318AF6
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:22:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541FD115
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RGx3n5pWYoigL/Q2qlBUaHExYRdpT8ahkEen8lFKeU0=; b=rHovh34XenARTsPdaoTi0ai9EU
	ZA81XFL/pF8EPgAr45TFZ2SspZ4NZGIlMLRe1C6Wj2asPb/FxMxC8OQfyb7E8Pqe5u7e8SHgP4lw1
	Wb/x0534Gd/OLnLNDTsGx0bmj9501T/1WnzHSq+msqN8stlWDzU7NDpusIMjxZldRW+o5fv7dm4Fk
	UzSYK7cpA8K5JMbYD/b+malbqv0xaVlwcR6p4ICSuqlu0HQhsHoyrYftkSzHzOtiUEndQemARpwgN
	4APN7c3bs6MAtEWKliG5Es1L6v1AueN/4NMlB4alXkGD4FGt9FjEPIkZR4/R+4R+SNBF2siq8xxsi
	o/GC5GiQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qg4HN-000AV8-PF; Tue, 12 Sep 2023 16:22:13 +0200
Received: from [194.230.160.47] (helo=localhost.localdomain)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qg4HN-00042Q-8k; Tue, 12 Sep 2023 16:22:13 +0200
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and
 sendmsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jordan Rife <jrife@google.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org
References: <20230912013332.2048422-1-jrife@google.com>
 <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net>
Date: Tue, 12 Sep 2023 16:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27029/Tue Sep 12 09:38:51 2023)

On 9/12/23 3:33 PM, Willem de Bruijn wrote:
> Jordan Rife wrote:
>> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
>> ensured that kernel_connect() will not overwrite the address parameter
>> in cases where BPF connect hooks perform an address rewrite. However,
>> there remain other cases where BPF hooks can overwrite an address held
>> by a kernel client.
>>
>> ==Scenarios Tested==
>>
>> * Code in the SMB and Ceph modules calls sock->ops->connect() directly,
>>    allowing the address overwrite to occur. In the case of SMB, this can
>>    lead to broken mounts.
> 
> These should probably call kernel_connect instead.
> 
>> * NFS v3 mounts with proto=udp call sock_sendmsg() for each RPC call,
>>    passing a pointer to the mount address in msg->msg_name which is
>>    later overwritten by a BPF sendmsg hook. This can lead to broken NFS
>>    mounts.
> 
> Similarly, this could call kernel_sendmsg, and the extra copy handled
> in that wrapper. The arguments are not exacty the same, so not 100%
> this is feasible.
> 
> But it's preferable if in-kernel callers use the kernel_.. API rather
> than bypass it. Exactly for issues like the one you report.

Fully agree, if it's feasible it would be better to convert them over to
in-kernel API.

>> In order to more comprehensively fix this class of problems, this patch
>> pushes the address copy deeper into the stack and introduces an address
>> copy to both udp_sendmsg() and udpv6_sendmsg() to insulate all callers
>> from address rewrites.
>>
>> Signed-off-by: Jordan Rife <jrife@google.com>

