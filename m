Return-Path: <netdev+bounces-262987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAQ9HcI+pmkZNAAAu9opvQ
	(envelope-from <netdev+bounces-262987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:52:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5551E7D60
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBB9307A0BE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D571374199;
	Tue,  3 Mar 2026 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bm5NO3tr"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84325373C0A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502689; cv=none; b=CfW5xB6mIUjl474M88FRdaE70dnquDJy48bXaZlG3SwLvf2/Axwtb1dOvcsHxJp8yk5acs2x4+c0h8cHEHFCp/rXXn04v5xdRGPzLVSjtGOEpGd2ntl2HVCdTw/7Z/FDn7VTXsuJ7BvYZlM3rL8j34D8YWJDylUTCtNam+hd5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502689; c=relaxed/simple;
	bh=QR9xC+LbZjTEcw2B3g6RGPgRmzHv4fIjmH/+ye7UnDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IL6rykrnwNPmWo6z+BNN+URnoLUyjEH6dqxQSXBUnYkJAaVcFMMCJEc6sqC254/YMIkFiwA+1zEiyrwi/6/Ss0c6ljgu80X/dhIzkKDL/aQAKOYqe3iczqy/KVdgiqJcWilOkqQK4OVcGR6ShqQ6oNmZycdE3CmFVALe0Mz8Um4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bm5NO3tr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f38608e1-4e85-4bc4-8872-c9ecf38e5d7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772502686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6veD8qM4F+WyZg576UBUjZ2Qmn0u8K3QCi47PEsWrI=;
	b=Bm5NO3trAPfude3N6WDHXMoo5/emzVqA759MZb7U4Ltx4YakxOrYeuBn5F/zsr8qmw538h
	Pvgjz5Y+vsWw7ahEeJjuB+JU++N4PnCPLfZo55eb/ypkGWnJ5NWLnmfQsZcZ/A3leEt8Sw
	S83EC/8fTfoiwKGlHYh7+RS/u8VNsWY=
Date: Mon, 2 Mar 2026 17:51:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific
 lock
To: Michal Luczaj <mhal@rbox.co>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemb@google.com>, Cong Wang <cong.wang@bytedance.com>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
 <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
 <CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com>
 <c4eaead1-ad69-42f0-9699-5f2d555a7693@rbox.co>
 <a2f2c260-38e8-4ba3-8655-cffbee046259@linux.dev>
 <b75bbc3f-85fd-4209-9ce1-3bf685ba62ff@rbox.co>
 <d122ed8b-ebfb-4d59-96ce-10c361e76676@linux.dev>
 <1022fcaf-ca38-43d2-84cb-f66a504335e1@rbox.co>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <1022fcaf-ca38-43d2-84cb-f66a504335e1@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CE5551E7D60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262987-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,cloudflare.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,bytedance.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 2/24/26 7:28 AM, Michal Luczaj wrote:
> On 2/23/26 22:43, Martin KaFai Lau wrote:
>>
>> On 2/11/26 2:02 AM, Michal Luczaj wrote:
>>>> It should also be helpful to be consistent with tcp/udp iter and use
>>>> lock_sock() instead of lock_sock_fast() in bpf_iter_unix_seq_show().
>>> OK, I'll tweak that in v3.
>>
>> Hi, Michal. Are you planning to send v3 soon? I don't think the
>> sock_owned_by_user for the non-tracing prog needs to be addressed in the
>> same set.
> 
> Yes, I'm working on it. Sorry for the delay, I'm taking my sweet time to
> come up with a selftest.
> 
> I think I can neatly fit the sock_owned_by_user()-related stuff in this
> series, but let me know if you'd rather have it separately. Whichever way,
> I don't mind.

I think sock_owned_by_user() is not related to the AF_UNIX's sockmap 
fix. If it is not, it's better to separate it. I think one thing at a 
time is easier to review.

If they are related somewhat or it's easier to review them together, see 
if it makes sense to structure them in a way such that the AF_UNIX's 
sockmap-related fixes and tests are at the beginning of the patch set so 
that they can be applied first if others need more discussion.

Regarding the "Keeping sparse annotations in 
sock_map_sk_{acquire,release}() required some
hackery...". Maybe just remove the annotations?
[ btw, from commit 5b63d0ae94cc, the sparse support is removed and it
   depends solely on clang now (?). If it is the case, what does clang do
   on the "sock_or_unix_lock"? ]


