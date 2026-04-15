Return-Path: <netdev+bounces-278674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJV0Ouwu32ltPwAAu9opvQ
	(envelope-from <netdev+bounces-278674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:23:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E945400D32
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0C99306FC32
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545338AC61;
	Wed, 15 Apr 2026 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRhoyAMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20695389459
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776234218; cv=none; b=JN8kGol5hs3VDYPDFlGLwARoKKtU2ITSjEo65nctm+9xuFE8UuOSfJELk3nBCuaqKqv6w0gT/+7ZBOgVxgSbk3PCiIowqBZH4oyzG7D2DFS19obw5TPc9piQgZeicesog69s1zNhmv3iPufheodO+q1f/gtGzvPYkew0BeD+QZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776234218; c=relaxed/simple;
	bh=bzg8UlHlDpqU532oEMpWVWFE0qEJX/ePADf6/HnEJBg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kOsYt9TzPNZ5sjSIF9t2kI5HzmN/+A4OaUs6A7oDPUcivRJyBLAf24h2l7zR75BF+NiM8gVvRmN2u9kk7DyZeOK8GVJvE4Tx3zt+jMl0Bl4KWuuvWydUeg+U9wrGEAgLiNOvGcM2mpgxCwY6cETaPKM3zRGI0fgv15B4ASxkhxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRhoyAMU; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c156c4a9efso8709783eec.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776234215; x=1776839015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kyDCDq+xj0T36t0a7ptWt0LlwL0iMlbx+XZcrvB4sc=;
        b=kRhoyAMU+VQagwUDe/1/fAwdGWcp5hxjy1/SgYmxLqufBXnXelfKYKWhsYc2KfxVuI
         Ra90BqYAIlArA5ZkSPUrYE6sJYBgC3QXni7/v6Z50xQOSyGl2DwJjeBfu5OA88RXadM2
         /NjKR6LCKucgW02SHRC0rflUjOhNWFgAWXs5MgR0uCuOYzke+vUBt/ZmGU0MoydGLIy5
         TZ2NYcWEOUnzlP1vdszPk+hK3+vQ7JdPOw0JwUe2frkiV5YVllzTVvbLCcdavDOql/6N
         Snvyjc9UnjejJZlBpuumsGm3w8mtYQQlhQzg9Nn+6kbTmpj2U13njscZW8MUEuNyumb1
         M7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776234215; x=1776839015;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kyDCDq+xj0T36t0a7ptWt0LlwL0iMlbx+XZcrvB4sc=;
        b=oN9azWY/3cmNxf0uBVs55kv5r6B2rdFgC8MC6Hqv9H8qjwIEypEDCffBV4AXLBYi5T
         MCp73TBB1PtyUVhh285zhdOEbTJ2HLFcXe28pfILy2a+KOLcKyqdYkH6PAM+4cK2TI85
         ugCRpdhyIB7yjdDNc+KCuC5EEoXdLEqpaTLYN9w4X4khn29JGly4ti3xRAcSfkaVmacU
         6HdfirsOVjRWtQ/b3ZDZo4H2cWducTBe7XgtPXVaP7OpRvP9u+GhTi3r/kNRosEk/3jB
         l04Mbxf+cGUHDcFAPIcWtTHpdx9tOb4jyZ1NVvp61tBY/v5cae0PHM9B3PU3fUJrl2vf
         +Mjg==
X-Forwarded-Encrypted: i=1; AFNElJ/gjLCdqWEbkTFfuVh5sqDuLYqYY52ABUwcKP6V78aTxBVMsT5oAm2XvdWQN2EuMT7akuHg4Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyveFdVjzpnHSoMnSRmcOhlQJZ6SbrYnOiNby+xnvlMuWpaPQ2x
	9bNjYDymOPCjZpVXdq4teMIdIz6kSjHRCs7bhtPUM2ueyvQ45UZ9QMOt
X-Gm-Gg: AeBDiethkPkw8le75K+uWrcsVwDgMJkNJCTFZYQqGwN0tiGOtDvGdlYlhj0DIdAnGu/
	2pbgBZM28v6GFAZc5gQ1X9JckiNqJW0omtioPYq+A6rLJV8k6MTY99Y6QRKiGvbadc2OjpF/bGU
	w5EFfV1k79U0bZyg9jEhHmeSpP4i23K94MvHsDOyn4HeBi7MO5BaVtgOtOi0wOlhAr2laFna1YO
	yeAFWITwlGnbSnd0gtpI2UrWnHSYwwfPg+4+JvKnm1wgL4L56Wmd0OiE2IA1Q8Uczw1pxOl8Qir
	TY8hGhzCS+QwB9LQ/2VlPNqyFgM8M/yReMkRzUodkn2RTEi4FcooUbDX1LviD/UelAYmwN0s2u3
	+Ln9HdsYnOaDD/4wj/wR3dXBjRhqfG0fwOr9J4O7wTSIOghtJlDDcC72RBPqxYf5MEu9SX/S/tc
	/pxaMbJaTuLhcc/W4qWCM1eldrAIGDfLri3J+9
X-Received: by 2002:a05:7301:fa0d:b0:2be:7885:31df with SMTP id 5a478bee46e88-2d5890793d5mr11667244eec.17.1776234214996;
        Tue, 14 Apr 2026 23:23:34 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb8482asm1339808eec.15.2026.04.14.23.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 23:23:34 -0700 (PDT)
Message-ID: <ac6677a2-6cef-4c18-bb19-dcae8800a19e@gmail.com>
Date: Tue, 14 Apr 2026 23:23:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 rao.shoaib@oracle.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, enjou1224z@gmail.com, wangjiexun2025@gmail.com
Subject: Re: [PATCH net v2 1/1] af_unix: Reject SIOCATMARK on non-stream
 sockets
To: Kuniyuki Iwashima <kuniyu@google.com>, Ren Wei <n05ec@lzu.edu.cn>
References: <20260413122916.1479959-1-n05ec@lzu.edu.cn>
 <CAAVpQUC--TT0M1+xd096CPw881tzHX-MddmT8sZs4sjoatVeLQ@mail.gmail.com>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <CAAVpQUC--TT0M1+xd096CPw881tzHX-MddmT8sZs4sjoatVeLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,oracle.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-278674-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E945400D32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/13/2026 10:33 PM, Kuniyuki Iwashima wrote:
> On Mon, Apr 13, 2026 at 5:29 AM Ren Wei <n05ec@lzu.edu.cn> wrote:
>> From: Jiexun Wang <wangjiexun2025@gmail.com>
>>
>> SIOCATMARK reports whether the receive queue is at the urgent mark for
>> MSG_OOB.
>>
>> In AF_UNIX, MSG_OOB is supported only for SOCK_STREAM sockets.
>> SOCK_DGRAM and SOCK_SEQPACKET reject MSG_OOB in sendmsg() and recvmsg(),
>> so they should not support SIOCATMARK either.
>>
>> Return -EOPNOTSUPP for non-stream sockets before checking the receive
>> queue.
>>
>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Please read this guideline again.
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>
> Co-developed-by is not where you mention someone who
> developed a tool to find a bug, and Suggested-by is not where
> you mention someone who funds your research.
> https://lore.kernel.org/netdev/7c26a74d-90c5-4520-a10a-22f06e098b86@gmail.com/
>
> When you just copy my fix and modify the commit message,
> the two tags are inappropriate.
>
We sincerely apologize for the misuse of the tags and the incorrect
crediting in our previous submission. We are still learning the
community's process and appreciate your patience.

Would you allow us to add:
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Or
Co-developed-by: Kumiki Iwashima <kuniyu@google.com>
in this patch?

In future patches, if a maintainer provides specific code suggestions,
we will first ask if a Suggested-by or Co-developed-by tag is needed
before sending a new version.

If a maintainer doesn't provide specific code, but points out errors in
our patch, explains how to fix the bug correctly, or mentions similar
paths that could be fixed together, I am not quite sure if a
Suggested-by tag is required. Maybe we can send an email first when we
are uncertain to avoid this happening again.

If the following tags are the correct way, we will update the v3 patch
like this:

Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yihan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by or Suggested-by? : Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>


One more thing: my understanding is that non-maintainers can also
provide Reviewed-by tags, right? While I will be less involved in direct
development and mentoring, I will still review every report and patch
from our team before submission to ensure quality.


>> Tested-by: Ren Wei <enjou1224z@gmail.com>
>> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>> Changes in v2:
>> - Rework the fix based on maintainer feedback.
>> - Drop the receive-queue locking approach and reject SIOCATMARK on
>>   non-stream sockets instead, since it is only meaningful for MSG_OOB.
>> - V1 link: https://lore.kernel.org/netdev/f6cbbc8da90e95584847b5ceb60aae830d1631c2.1775731983.git.wangjiexun2025@gmail.com/
>>
>>  net/unix/af_unix.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index b23c33df8b46..09d43b4813b1 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -3300,6 +3300,9 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>>                         struct sk_buff *skb;
>>                         int answ = 0;
>>
>> +                       if (sk->sk_type != SOCK_STREAM)
>> +                               return -EOPNOTSUPP;
>> +
>>                         mutex_lock(&u->iolock);
>>
>>                         skb = skb_peek(&sk->sk_receive_queue);
>> --
>> 2.34.1
>>

