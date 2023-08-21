Return-Path: <netdev+bounces-29428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80CE783392
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4571C209C4
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D089E1172F;
	Mon, 21 Aug 2023 20:25:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3E11710
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:25:37 +0000 (UTC)
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095EA10D
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:25:35 -0700 (PDT)
Message-ID: <6ae89b3a-b53d-dd2c-ecc6-1094f9b95586@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692649534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJAWYPnodYoeBpKkUTCQlu4SlvDmRYHPhXTtqm0naOM=;
	b=ZFDUkMqFhwu5CLHg1A++Nw4In7Ml6vzH6SjQLIEzLB1KKROG/TGkUa7NMrGVrgGHQLyleh
	NDpX51ZLNWZAeHEH16mJ/zSNZLMqzOMpyYESBcYVVIIJY/vmP/yT6VTZ6T6s538gXxaAsw
	bSPSAFYLmk8mIqJFSkSlDdHHfM3Gsso=
Date: Mon, 21 Aug 2023 13:25:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 8/9] io_uring/cmd: BPF hook for getsockopt cmd
Content-Language: en-US
To: Gabriel Krisman Bertazi <krisman@suse.de>,
 Breno Leitao <leitao@debian.org>
Cc: sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 io-uring@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
References: <20230817145554.892543-1-leitao@debian.org>
 <20230817145554.892543-9-leitao@debian.org> <87pm3l32rk.fsf@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87pm3l32rk.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 12:08 PM, Gabriel Krisman Bertazi wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
>> Add BPF hook support for getsockopts io_uring command. So, BPF cgroups
>> programs can run when SOCKET_URING_OP_GETSOCKOPT command is executed
>> through io_uring.
>>
>> This implementation follows a similar approach to what
>> __sys_getsockopt() does, but, using USER_SOCKPTR() for optval instead of
>> kernel pointer.
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>   io_uring/uring_cmd.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>> index a567dd32df00..9e08a14760c3 100644
>> --- a/io_uring/uring_cmd.c
>> +++ b/io_uring/uring_cmd.c
>> @@ -5,6 +5,8 @@
>>   #include <linux/io_uring.h>
>>   #include <linux/security.h>
>>   #include <linux/nospec.h>
>> +#include <linux/compat.h>
>> +#include <linux/bpf-cgroup.h>
>>   
>>   #include <uapi/linux/io_uring.h>
>>   #include <uapi/asm-generic/ioctls.h>
>> @@ -184,17 +186,23 @@ static inline int io_uring_cmd_getsockopt(struct socket *sock,
>>   	if (err)
>>   		return err;
>>   
>> -	if (level == SOL_SOCKET) {
>> +	err = -EOPNOTSUPP;
>> +	if (level == SOL_SOCKET)
>>   		err = sk_getsockopt(sock->sk, level, optname,
>>   				    USER_SOCKPTR(optval),
>>   				    KERNEL_SOCKPTR(&optlen));
>> -		if (err)
>> -			return err;
>>   
>> +	if (!(issue_flags & IO_URING_F_COMPAT))
>> +		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level,
>> +						     optname,
>> +						     USER_SOCKPTR(optval),
>> +						     KERNEL_SOCKPTR(&optlen),
>> +						     optlen, err);
>> +
>> +	if (!err)
>>   		return optlen;
>> -	}
> 
> Shouldn't you call sock->ops->getsockopt for level!=SOL_SOCKET prior to
> running the hook?  Before this patch, it would bail out with EOPNOTSUPP,
> but now the bpf hook gets called even for level!=SOL_SOCKET, which
> doesn't fit __sys_getsockopt. Am I misreading the code?
I agree it should not call into bpf if the io_uring cannot support non 
SOL_SOCKET optnames. Otherwise, the bpf prog will get different optval and 
optlen when running in _sys_getsockopt vs io_uring getsockopt (e.g. in regular 
_sys_getsockopt(SOL_TCP), bpf expects the optval returned from tcp_getsockopt).

I think __sys_getsockopt can also be refactored similar to __sys_setsockopt in 
patch 3. Yes, for non SOL_SOCKET it only supports __user *optval and __user 
*optlen but may be a WARN_ON_ONCE/BUG_ON(sockpt_is_kernel(optval)) can be added 
before calling ops->getsockopt()? Then this details can be hidden away from the 
io_uring.


