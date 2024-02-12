Return-Path: <netdev+bounces-71035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46AF851BF1
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0EB282C11
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773E43EA78;
	Mon, 12 Feb 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LKRZMBUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D53F9D8
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760046; cv=none; b=CSg2Lb9q6XzEOFuR37G/+9dF60W0g0YmnuS9OuhyTWbqN3JAAI62TE4iYiU2vGc2WfNusnGhu1w63hxw/n1dquxRVkcMvsViWokxMy6UcZtbjsRCYuu7A1Gw0NbrMEapYWecazCVltroLK/j+CvwYZM50nPsZvYBVhKwnuKhmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760046; c=relaxed/simple;
	bh=46yU4a7L4h8ek655E6b8Cytdl/t4fwnw3o7H73Bnn84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZvlRuOLo6cyLxC3jPFm0XXOouhZINPMoHgl1UhbKZ3+uiODt16eOMssbA+m49Vg4m32zmc3elIKZLPyNppFjH2x7ccZAMPOJchBSiRl4bKpkXtmtHc0/VDKqNlqp+42wQsCZ3gsni8qJ4x1QrlzljAA7pSbfGHdWiODGQBa6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LKRZMBUW; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso68886039f.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707760042; x=1708364842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aJkuyZg/VkUjodqHytg8HlYFy9yBPrSCmPQ2Yp8LZ8=;
        b=LKRZMBUWIaIwcCfM9dR6yyVdxDM571a+rVR0EAtMBuzs6FUOxb7tFG7muMDlN1D53S
         l6Ll8r3bsmW3h785ewONsu8ETc6Zen2TmzS65dlH/FyWVKqppf2LFYyBR5GI2ucTG0NJ
         smza92CGhsQjM02v5Vifulf0xXRjOq3GS/ORqtTfk/Neb0c6X3oL6KoIsYFYv8La1vwW
         NnNALRKjQ3QCdJ8GaUqZ3d5ENWSPKDnl8sXOgaZO269h3rrQN3YPUgJo6kYP8Zj2We2g
         Q1IRYmXIO+ETHmorNnANZYZf2f3uPRUZXA0IhOblYxsNF+cqjVwXiVBHRfj8diEzmq3N
         BNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760042; x=1708364842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aJkuyZg/VkUjodqHytg8HlYFy9yBPrSCmPQ2Yp8LZ8=;
        b=JGV5DKZQ1LtC573Gf/X9MtB/bzWDAoaORlBKOFHniikw5tNx7jv1jnMyyLDhXOU5b0
         PUvKLcKiYIa5ZVIKY6dkza9lXssYJdSEzgXd04FaZaTGzIgpKupPMIWDsrBxYHLzj0+y
         /p0dquH+4me0W2ysyVYrVtwfCGDSqpm1u5FzsEIuVmzD0HdiiWZHC/5UuTMqmqzJuyiz
         eL/ngDENMMJVVo6z1/++Uok9+Peg+4q93evZz1Jjbn948hyMFOFWgq/xrY04aTsOsw5V
         Wba1fzW/6w3Wuaob5rRXFOC57YiyHVjw9r++IltdOvdyQ42C0xED3NP4TLU/9SqD8syp
         q6YA==
X-Forwarded-Encrypted: i=1; AJvYcCUXpV5WJRihgwvckJ4TIEd83+ig8aQrYaEADnRbZsOAQfOQaeLlw9vaA6cioO19KwYJH983mCq90NiVYYtd3uF4f13ykwrc
X-Gm-Message-State: AOJu0YzSREtzWm8E2ziqF2uWXOoPsjtebaJ6Am0c7FqoIA9bHnzOGxIP
	/Kd8VDbaPDnVuHK7YnPRo4U7EvhW30hnwskq9cnwoRYBA4AwPSEpSZpMthrxOBU=
X-Google-Smtp-Source: AGHT+IGzRQvdCCWlAh5S/oFloB7p6fUbu6qbWoc7fl58CSnhyOhP/hJc8q6i2zH8pg/iKM/U05kLrg==
X-Received: by 2002:a05:6602:15c9:b0:7c4:5a72:3838 with SMTP id f9-20020a05660215c900b007c45a723838mr5521937iow.0.1707760042300;
        Mon, 12 Feb 2024 09:47:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrOFlasD1NVbVxNcBvVZ7U/H8xSTGuj2kpN0aniUSAtbbrlJszpZ1M3BJLIf7uqUv4UOk6fKLYYIUnWOYd/R7B7oivu7yjmQ50/CrEKv6M8rCETB9Mfhit2WBS8vB/wMDlru77TNbiCHKmhXvq7+UqLcjEpFUfoNiwMANorRRamnns68kGFBeypMa5thjWEbOV3t1j7cDfsPN8GHg9y1bNKn2P/Xzpoy+CK3I4fNRFrp8Ov1HNKJ5dUqkk7rAw
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id da2-20020a0566384a4200b00472c62c7d74sm1495863jab.149.2024.02.12.09.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:47:21 -0800 (PST)
Message-ID: <8eb7c0b3-afc7-4dca-b614-397514a1994b@kernel.dk>
Date: Mon, 12 Feb 2024 10:47:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 2/3] af_unix: Remove io_uring code for GC.
Content-Language: en-US
To: Pengfei Xu <pengfei.xu@intel.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20240129190435.57228-1-kuniyu@amazon.com>
 <20240129190435.57228-3-kuniyu@amazon.com>
 <Zcl/vQnHoKhZ7m0+@xpf.sh.intel.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zcl/vQnHoKhZ7m0+@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/24 7:17 PM, Pengfei Xu wrote:
> Hi,
> 
> On 2024-01-29 at 11:04:34 -0800, Kuniyuki Iwashima wrote:
>> Since commit 705318a99a13 ("io_uring/af_unix: disable sending
>> io_uring over sockets"), io_uring's unix socket cannot be passed
>> via SCM_RIGHTS, so it does not contribute to cyclic reference and
>> no longer be candidate for garbage collection.
>>
>> Also, commit 6e5e6d274956 ("io_uring: drop any code related to
>> SCM_RIGHTS") cleaned up SCM_RIGHTS code in io_uring.
>>
>> Let's do it in AF_UNIX as well by reverting commit 0091bfc81741
>> ("io_uring/af_unix: defer registered files gc to io_uring release")
>> and commit 10369080454d ("net: reclaim skb->scm_io_uring bit").
>>
>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> ---
>>  include/net/af_unix.h |  1 -
>>  net/unix/garbage.c    | 25 ++-----------------------
>>  net/unix/scm.c        |  6 ------
>>  3 files changed, 2 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
>> index f045bbd9017d..9e39b2ec4524 100644
>> --- a/include/net/af_unix.h
>> +++ b/include/net/af_unix.h
>> @@ -20,7 +20,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
>>  void unix_inflight(struct user_struct *user, struct file *fp);
>>  void unix_notinflight(struct user_struct *user, struct file *fp);
>>  void unix_destruct_scm(struct sk_buff *skb);
>> -void io_uring_destruct_scm(struct sk_buff *skb);
>>  void unix_gc(void);
>>  void wait_for_unix_gc(struct scm_fp_list *fpl);
>>  struct sock *unix_peer_get(struct sock *sk);
>> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
>> index af676bb8fb67..ce5b5f87b16e 100644
>> --- a/net/unix/garbage.c
>> +++ b/net/unix/garbage.c
>> @@ -184,12 +184,10 @@ static bool gc_in_progress;
>>  
>>  static void __unix_gc(struct work_struct *work)
>>  {
>> -	struct sk_buff *next_skb, *skb;
>> -	struct unix_sock *u;
>> -	struct unix_sock *next;
>>  	struct sk_buff_head hitlist;
>> -	struct list_head cursor;
>> +	struct unix_sock *u, *next;
>>  	LIST_HEAD(not_cycle_list);
>> +	struct list_head cursor;
>>  
>>  	spin_lock(&unix_gc_lock);
>>  
>> @@ -269,30 +267,11 @@ static void __unix_gc(struct work_struct *work)
>>  
>>  	spin_unlock(&unix_gc_lock);
>>  
>> -	/* We need io_uring to clean its registered files, ignore all io_uring
>> -	 * originated skbs. It's fine as io_uring doesn't keep references to
>> -	 * other io_uring instances and so killing all other files in the cycle
>> -	 * will put all io_uring references forcing it to go through normal
>> -	 * release.path eventually putting registered files.
>> -	 */
>> -	skb_queue_walk_safe(&hitlist, skb, next_skb) {
>> -		if (skb->destructor == io_uring_destruct_scm) {
>> -			__skb_unlink(skb, &hitlist);
>> -			skb_queue_tail(&skb->sk->sk_receive_queue, skb);
>> -		}
>> -	}
>> -
>>  	/* Here we are. Hitlist is filled. Die. */
>>  	__skb_queue_purge(&hitlist);
>>  
>>  	spin_lock(&unix_gc_lock);
>>  
>> -	/* There could be io_uring registered files, just push them back to
>> -	 * the inflight list
>> -	 */
>> -	list_for_each_entry_safe(u, next, &gc_candidates, link)
>> -		list_move_tail(&u->link, &gc_inflight_list);
>> -
>>  	/* All candidates should have been detached by now. */
>>  	WARN_ON_ONCE(!list_empty(&gc_candidates));
>>  
>> diff --git a/net/unix/scm.c b/net/unix/scm.c
>> index 505e56cf02a2..db65b0ab5947 100644
>> --- a/net/unix/scm.c
>> +++ b/net/unix/scm.c
>> @@ -148,9 +148,3 @@ void unix_destruct_scm(struct sk_buff *skb)
>>  	sock_wfree(skb);
>>  }
>>  EXPORT_SYMBOL(unix_destruct_scm);
>> -
>> -void io_uring_destruct_scm(struct sk_buff *skb)
>> -{
>> -	unix_destruct_scm(skb);
>> -}
>> -EXPORT_SYMBOL(io_uring_destruct_scm);
> 
> Syzkaller found below issue.
> There is WARNING in __unix_gc in v6.8-rc3_internal-devel_hourly-20240205-094544,
> the kernel contains kernel-next patches.
> 
> Bisected and found first bad commit:
> "
> 11498715f266 af_unix: Remove io_uring code for GC.
> "
> It's the same patch as above.

It should be fixed by:

commit 1279f9d9dec2d7462823a18c29ad61359e0a007d
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Sat Feb 3 10:31:49 2024 -0800

    af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

which is in Linus's tree.

-- 
Jens Axboe


