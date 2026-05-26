Return-Path: <netdev+bounces-291600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PhNDlljFWprUwcAu9opvQ
	(envelope-from <netdev+bounces-291600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:09:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 347475D30B4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 001593021651
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6B3D3319;
	Tue, 26 May 2026 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ie+UgEBv"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB83D3326
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786491; cv=none; b=fnye0OiZhAII5vfEEg8TlfgdZPVvNPE7+ulmcoaTiU8G+yaM8KTF81jbEY4GM44PcVIKjSRvlSNZSnbsYVsh8eCBQHZUbb8PrTHWcqU89H4acAVQ8J4dkRzEZ7ojbbivRTPy0Jz6ZA8YYjZ07ZSTGDERtZ1RIMO8aDHk4SVWohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786491; c=relaxed/simple;
	bh=eEKpfvRxewZL1VrPPGVMaevl2+Bz+Ywj1s21XQBa1aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0jhEGWAWQqrIRSkOiE8xOc2c32KMUO8Fs+1evxowtPQNp4v4WEqZm34PKNjedYApmMbqxgsXMe7+DoVv1WE2fiyOyfRBMo+lqQoO4LL5iy78DBzLt0Uh91BKD/7Lml7GnxEl4YAXagZnjOQwP8lSYp1jNBvtnXSeteCFhERwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ie+UgEBv; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd98b90f-5a05-4420-a04c-bd60011e542c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779786487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTIzrx1pgu2SvCX6kFkUdyFX+shAmr0eN/UIvHMeLE4=;
	b=ie+UgEBv8W4Vy98srDMsYLT5jZcB/cHhrUXFTfBAK8xm4V0jq/Hk1KlvU9Z0qICEoUy8wx
	u0AKFbO9tsIGocmtehIhjVUkWCMduVQFqnm2SELjNJ+0j+qUTgT77viOVef60HoKTTsZWJ
	5ZtwMavKUeUeg4oGi3VVcYaLEZjypqo=
Date: Tue, 26 May 2026 17:07:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] net/core: use wake_up_interruptible_poll() in
 sock_def_readable()
To: Xuewen Yan <xuewen.yan@unisoc.com>, edumazet@google.com,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
 guohua.yan@unisoc.com, Wade.Shu@unisoc.com, xuewen.yan94@gmail.com,
 di.shen@unisoc.com
References: <20260526063650.952-1-xuewen.yan@unisoc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260526063650.952-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,vger.kernel.org,unisoc.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-291600-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 347475D30B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/26/26 2:36 PM, Xuewen Yan wrote:
> sock_def_readable() currently uses wake_up_interruptible_sync_poll() to
> wake up tasks waiting for readable data on a socket. The _sync variant
> sets the WF_SYNC flag, which tells the scheduler that the waker will
> schedule away soon, so the wakee should stay on the same CPU to avoid
> needless cache bouncing.
>
> However, we found that the following stack:
>   -vfs_write
>   -sock_write_iter
>   -unix_stream_sendmsg
>   -sock_def_readable
>   -__wake_up_sync_key
>
> In this process-context scenario, the waker does NOT go to sleep
> after the wakeup. With WF_SYNC, the scheduler is misled into placing
> the wakee on the waker's CPU (via wake_affine_idle()'s sync path when
> nr_running == 1), causing both the sender and receiver to contend for
> the same CPU. This may hurt throughput for IPC workloads on multi-core
> systems where the sender and receiver could otherwise run in parallel
> on different CPUs.


WF_SYNC isn't a hard binding.

What's your test environment and benchmark ?



