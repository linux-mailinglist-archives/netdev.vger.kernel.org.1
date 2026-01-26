Return-Path: <netdev+bounces-253600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB/cHMfVd2mFlwEAu9opvQ
	(envelope-from <netdev+bounces-253600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:59:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F48D672
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE483032748
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B067A2D73AB;
	Mon, 26 Jan 2026 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4nB2EBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2694326B755
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460895; cv=none; b=fUmiug7Uh3Z3kDiIPWRcmuauptZRRmpcAaRkIRV9ad130Wra2ALnflewBg3tGeVEq80dOpOe60ViVa/q6sEL0qfjh6iqIg9S6Hna0ajOo7x6mqb3Ior4o787RSkQeg0Pi+XSKYokxsHMZd2pUiEt8DEML6xRGu1bw3NRG260TeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460895; c=relaxed/simple;
	bh=LUarMVp3A+DKtslQ6MDFZ/jqz5p7hyxjfyCoO/ISZg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryLHoQ2lwtaam4YANSXyg1Vj6/3uueGWoyXevJhI1J+C3rKlfR6OZnSrFe5A4ZuEAEZ4MGYY6ysMuzGy0ZGWEZmBg4umonqGaTNjzhqJRNLxbtmqD0VLqZUjYRTUCt+69D8rkRvwb+YF6TCb2XR6b3nQX2LTzpIvsYOLZYKWFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4nB2EBa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so56160645e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769460891; x=1770065691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hI2Oaa7DGTVrphNd9nJ03ev7Z0sk81WiqKgqE99uXsU=;
        b=V4nB2EBabwzQm7l8FJHL5pBDCYZTlbm2jUAVwagFI9+zjJAWtXddeHU456VnBNbV6q
         1DAW+LVQeJWnoKsbPacslG28Ym6s09hyfhoEfMriAyDLRMBDPsmglB1J52OJfn8+BLmT
         dajKNJofqM6kpkfD2QrPNryv1h9CGL6UT/4wNIJchntGPx6Id0Tz87BRmqgM7HDR20Mx
         4DUHMpE8KdZA8hExyXoYdhVwJ3Oe06+BswZWtdkrt8tARvnqjWjxZpWBGXvy0Z2c+QUq
         /DyoOW5kbph9AELIaR1rqfWrlppY2gz0hIt0v5xzwE/9pu1alU+tdUbtqPq6NACVmriR
         A3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769460891; x=1770065691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI2Oaa7DGTVrphNd9nJ03ev7Z0sk81WiqKgqE99uXsU=;
        b=X+5x0SkB3zIjCYU0aO/kEsxr1/z59RFxuvkzOf6jnsUkj94gxSAyAFpU975Ciwm2J1
         wrQ74bXL5Iq/5n48bURdxf4+BC7qekSPZ1/s6oFmb8hUW+zmzUDjLtJDXLl2zy5Jsu73
         MIDzV8CWoTZHvOp1JbxsGp0a0JErPfrzmf7h9+iN8FtoH+CP4kWkgViAOtIdNRIVxLY5
         ZlXwfB/fdsAnDv5muRzwOnU4U7KkfqIqnoCw5MAVcqIRtOALqby6LV7h0McbDX3aNeCV
         NXeDyYlmmSRl5dfnkDjjX+7GZcJghvxlJkhrx4SfGoB5Vc/+1lsKCdaHHBm1m/VCkBsA
         bqGA==
X-Forwarded-Encrypted: i=1; AJvYcCXzzRFS1sTqX1E+aKsRfhA9F4okSLoLYRmOJCmjxmbhnSamX9P3iAzfm7v2PwjGnvu9tBurKqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/LQtaGBsumQ1GUs+En1VFtqQY+9giYCAy6YkqafpaWe7Ttbi
	AGYG/fxJUhKF0RNJ6+Hp90w4uFwAxoz8TFEiCyxKVQM/zzuRXlH0c1Fh
X-Gm-Gg: AZuq6aLrlcIFHKdTzcmWHYaO3xC25NFkM0L/qq/u0I6LgjgQWmViuuzz2VLveqFbldY
	2HwAwSMGuGGXUiLhe6csB5PStWAoGDEKpgRvmiDWCCNtqf1O82gcmEWnhjmye6pomNIgmg4QEYR
	GSVGT59NthgiguDBOs9UDn7J5vD4hel0BBHbxkaPInLYOLZnoz4pykVTbivJWuTsBTgL3QVOiZj
	4d9A1x1LGthnESIOp0XLzNLEEAplFpMgdxliQnSQLxM/zhHwUAA18Bb6xJeHdaxrVpenP8FT4Cz
	LyAgrWS+OF/105WA1J5FS8robzTr2yAak7yf7I0+wuGkqVVNbc+3LWXBPpYnr6Auj45N+Nnxa62
	SY72gG/+YUqr4Yg4qL784dAAWgRpxCo1Qxhfb/qmKFxfIeVkyeeHdnsIA7Ja+ipEMI2q8eQ10LL
	+7Z//4/CUG8LWSlJAAZtNOD10Fk89JYVNh0+U=
X-Received: by 2002:a05:600c:1554:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-4805ce3f5dcmr89924175e9.7.1769460891164;
        Mon, 26 Jan 2026 12:54:51 -0800 (PST)
Received: from [10.221.205.245] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d63a6b6sm111949005e9.7.2026.01.26.12.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 12:54:50 -0800 (PST)
Message-ID: <e5b5c38f-d411-48e4-8c6a-a33783126d04@gmail.com>
Date: Mon, 26 Jan 2026 22:54:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Undo saving per-channel async ICOSQ
To: Alice Mikityanska <alice.kernel@fastmail.im>, William Tu
 <witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Gal Pressman <gal@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org
References: <20260123223916.361295-1-daniel@iogearbox.net>
 <85776531-d5fa-4762-90aa-74c8397dc09b@gmail.com>
 <c08623c8-6933-4b87-8cd0-f367d57b2b2e@app.fastmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <c08623c8-6933-4b87-8cd0-f367d57b2b2e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei.uk:email]
X-Rspamd-Queue-Id: 936F48D672
X-Rspamd-Action: no action



On 26/01/2026 18:06, Alice Mikityanska wrote:
> On Sun, Jan 25, 2026, at 10:33, Tariq Toukan wrote:
>> On 24/01/2026 0:39, Daniel Borkmann wrote:
>>> This reverts the following commits:
>>>
>>>     - ea945f4f3991 ("net/mlx5e: Move async ICOSQ lock into ICOSQ struct")
>>>     - 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for triggering NAPI")
> 
> Hi Tariq and William,
> 

Hi Alice,
Thanks for your valuable comments!

> A few comments on my side:
> 
> I think the second patch is wrong in how it repurposes the regular ICOSQ for XSK wakeups. mlx5e_xsk_wakeup() can be called on any CPU that doesn't necessarily match the channel's CPU. That's why the spinlock around async_icosq was needed. By replacing icosq with async_icosq in mlx5e_trigger_napi_icosq(), this patch also affects what's done in mlx5e_xsk_wakeup().

Accurate. We had no intention of moving XSK to use the "regular" ICOSQ. 
It was done by mistake.
As you can see, all checks in XSK are done against the async ICOSQ, and 
the conditional creation of async ICOSQ checks for xsk_pool.

I have WIP patches fixing this, moving the XSK nop posting back to the 
async ICOSQ.

> The consequences are:
> 
> 1. The checks in mlx5e_xsk_wakeup() are made on async_icosq, but the regular icosq is then used.
> 
> 2. As far as I understood the commit description, it's intended that mlx5e_trigger_napi_icosq() should use icosq unlocked most of the time, but the critical section is actually needed when it's called from mlx5e_xsk_wakeup(), because it can run on any CPU.
> 
> Looking at the code, though, I feel there is also some typo that defeats the purpose of this patch. Every mlx5e_trigger_napi_icosq() call will test_and_set_bit(), and the set bit means do the lock. As the bit is always being set right before calling mlx5e_icosq_sync_lock(), it will lock on icosq at all times 

The MLX5E_SQ_STATE_LOCK_NEEDED bit is used to sync against the RX 
fast-path flow in napi that posts UMR WQEs to the icosq.
This is an optimization, as the lock is not needed in the napi flow once 
the activation stage completes.

I think you're right about mlx5e_trigger_napi_icosq:
The "test" part seems redundant, as it's the only place where the bit is 
set. (In earlier internal versions that was not the case, and this is 
some kind of a leftover).

I'd still prefer using the API (mlx5e_icosq_sync_lock) to obtain the 
lock though.

> (well, unless a racy other thread calls clear_bit() in between of test_and_set_bit() and mlx5e_icosq_sync_lock()). Moreover, the way it's implemented now, synchronize_net() will also be called on each post of WQEs, causing a severe slowdown in datapath.
> 

No, why?
mlx5e_trigger_napi_icosq is a slow-path function (after the XSK issue 
gets fixed).

> One more thing that needs to be taken into account if you find a way to post XSK wakeups to the regular ICOSQ: you should reserve +1 WQE (for XSK NOP) when allocating the ICOSQ, and also use the MLX5E_SQ_STATE_PENDING_XSK_TX flag correctly (to avoid unnecessarily posting many NOPs and risking overflowing the queue).
> 

Right, but won't be relevant after the fix.

>>>     - 1b080bd74840 ("net/mlx5e: Move async ICOSQ to dynamic allocation")
>>>     - abed42f9cd80 ("net/mlx5e: Conditionally create async ICOSQ")
>>>
>>> There are a couple of regressions on the xsk side I ran into:
>>>
>>> Commit 56aca3e0f730 triggers an illegal synchronize_rcu() in an RCU read-
>>> side critical section via mlx5e_xsk_wakeup() -> mlx5e_trigger_napi_icosq()
>>> -> synchronize_net(). The stack holds RCU read-lock in xsk_poll().
>>>
>>> Additionally, this also hits a NULL pointer dereference in mlx5e_xsk_wakeup():
>>>
>>>     [  103.963735] BUG: kernel NULL pointer dereference, address: 0000000000000240
>>>     [  103.963743] #PF: supervisor read access in kernel mode
>>>     [  103.963746] #PF: error_code(0x0000) - not-present page
>>>     [  103.963749] PGD 0 P4D 0
>>>     [  103.963752] Oops: Oops: 0000 [#1] SMP
>>>     [  103.963756] CPU: 0 UID: 0 PID: 2255 Comm: qemu-system-x86 Not tainted 6.19.0-rc5+ #229 PREEMPT(none)
>>>     [  103.963761] Hardware name: [...]
>>>     [  103.963765] RIP: 0010:mlx5e_xsk_wakeup+0x53/0x90 [mlx5_core]
>>>
>>> What happens is that c->async_icosq is NULL when in mlx5e_xsk_wakeup()
>>> and therefore access to c->async_icosq->state triggers it. (On the NIC
>>> there is an XDP program installed by the control plane where traffic
>>> gets redirected into an xsk map - there was no xsk pool set up yet.
>>> At some later time a xsk pool is set up and the related xsk socket is
>>> added to the xsk map of the XDP program.)
>>>
>>
>> Hi Daniel,
>>
>> Thanks for your report.
>>
>>> Reverting the series fixes the problems again.
>>>
>>
>> Revert is too aggressive here. A fix is preferable.
>> We're investigating the issue in order to fix it.
>> We'll update.
>>
>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: William Tu <witu@nvidia.com>
>>> Cc: Tariq Toukan <tariqt@nvidia.com>
>>> Cc: David Wei <dw@davidwei.uk>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> ---
>>>    drivers/net/ethernet/mellanox/mlx5/core/en.h  |  26 +----
>>>    .../mellanox/mlx5/core/en/reporter_tx.c       |   1 -
>>>    .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |   3 -
>>>    .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |   6 +-
>>>    .../mellanox/mlx5/core/en_accel/ktls.c        |  10 +-
>>>    .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  26 ++---
>>>    .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |   3 +-
>>>    .../net/ethernet/mellanox/mlx5/core/en_main.c | 100 +++++-------------
>>>    .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 -
>>>    .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  37 +++----
>>>    10 files changed, 62 insertions(+), 154 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>>> index 19b9683f4622..ff4ab4691baf 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>>> @@ -388,7 +388,6 @@ enum {
>>>    	MLX5E_SQ_STATE_DIM,
>>>    	MLX5E_SQ_STATE_PENDING_XSK_TX,
>>>    	MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
>>> -	MLX5E_SQ_STATE_LOCK_NEEDED,
>>>    	MLX5E_NUM_SQ_STATES, /* Must be kept last */
>>>    };
>>>    
>>> @@ -546,11 +545,6 @@ struct mlx5e_icosq {
>>>    	u32                        sqn;
>>>    	u16                        reserved_room;
>>>    	unsigned long              state;
>>> -	/* icosq can be accessed from any CPU and from different contexts
>>> -	 * (NAPI softirq or process/workqueue). Always use spin_lock_bh for
>>> -	 * simplicity and correctness across all contexts.
>>> -	 */
>>> -	spinlock_t                 lock;
>>>    	struct mlx5e_ktls_resync_resp *ktls_resync;
>>>    
>>>    	/* control path */
>>> @@ -782,7 +776,9 @@ struct mlx5e_channel {
>>>    	struct mlx5e_xdpsq         xsksq;
>>>    
>>>    	/* Async ICOSQ */
>>> -	struct mlx5e_icosq        *async_icosq;
>>> +	struct mlx5e_icosq         async_icosq;
>>> +	/* async_icosq can be accessed from any CPU - the spinlock protects it. */
>>> +	spinlock_t                 async_icosq_lock;
>>>    
>>>    	/* data path - accessed per napi poll */
>>>    	const struct cpumask	  *aff_mask;
>>> @@ -805,21 +801,6 @@ struct mlx5e_channel {
>>>    	struct dim_cq_moder        tx_cq_moder;
>>>    };
>>>    
>>> -static inline bool mlx5e_icosq_sync_lock(struct mlx5e_icosq *sq)
>>> -{
>>> -	if (likely(!test_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state)))
>>> -		return false;
>>> -
>>> -	spin_lock_bh(&sq->lock);
>>> -	return true;
>>> -}
>>> -
>>> -static inline void mlx5e_icosq_sync_unlock(struct mlx5e_icosq *sq, bool locked)
>>> -{
>>> -	if (unlikely(locked))
>>> -		spin_unlock_bh(&sq->lock);
>>> -}
>>> -
>>>    struct mlx5e_ptp;
>>>    
>>>    struct mlx5e_channels {
>>> @@ -939,7 +920,6 @@ struct mlx5e_priv {
>>>    	u8                         max_opened_tc;
>>>    	bool                       tx_ptp_opened;
>>>    	bool                       rx_ptp_opened;
>>> -	bool                       ktls_rx_was_enabled;
>>>    	struct kernel_hwtstamp_config hwtstamp_config;
>>>    	u16                        q_counter[MLX5_SD_MAX_GROUP_SZ];
>>>    	u16                        drop_rq_q_counter;
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
>>> index 4adc1adf9897..9e2cf191ed30 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
>>> @@ -15,7 +15,6 @@ static const char * const sq_sw_state_type_name[] = {
>>>    	[MLX5E_SQ_STATE_DIM] = "dim",
>>>    	[MLX5E_SQ_STATE_PENDING_XSK_TX] = "pending_xsk_tx",
>>>    	[MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC] = "pending_tls_rx_resync",
>>> -	[MLX5E_SQ_STATE_LOCK_NEEDED] = "lock_needed",
>>>    };
>>>    
>>>    static int mlx5e_wait_for_sq_flush(struct mlx5e_txqsq *sq)
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>>> index 4f984f6a2cb9..2b05536d564a 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>>> @@ -23,7 +23,6 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>>>    	struct mlx5_wq_cyc *wq = &icosq->wq;
>>>    	struct mlx5e_umr_wqe *umr_wqe;
>>>    	struct xdp_buff **xsk_buffs;
>>> -	bool sync_locked;
>>>    	int batch, i;
>>>    	u32 offset; /* 17-bit value with MTT. */
>>>    	u16 pi;
>>> @@ -48,7 +47,6 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>>>    			goto err_reuse_batch;
>>>    	}
>>>    
>>> -	sync_locked = mlx5e_icosq_sync_lock(icosq);
>>>    	pi = mlx5e_icosq_get_next_pi(icosq, rq->mpwqe.umr_wqebbs);
>>>    	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
>>>    	memcpy(umr_wqe, &rq->mpwqe.umr_wqe, sizeof(struct mlx5e_umr_wqe));
>>> @@ -145,7 +143,6 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>>>    	};
>>>    
>>>    	icosq->pc += rq->mpwqe.umr_wqebbs;
>>> -	mlx5e_icosq_sync_unlock(icosq, sync_locked);
>>>    
>>>    	icosq->doorbell_cseg = &umr_wqe->hdr.ctrl;
>>>    
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
>>> index 9e33156fac8a..a59199ed590d 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
>>> @@ -26,12 +26,10 @@ int mlx5e_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>>>    		 * active and not polled by NAPI. Return 0, because the upcoming
>>>    		 * activate will trigger the IRQ for us.
>>>    		 */
>>> -		if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED,
>>> -				       &c->async_icosq->state)))
>>> +		if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &c->async_icosq.state)))
>>>    			return 0;
>>>    
>>> -		if (test_and_set_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
>>> -				     &c->async_icosq->state))
>>> +		if (test_and_set_bit(MLX5E_SQ_STATE_PENDING_XSK_TX, &c->async_icosq.state))
>>>    			return 0;
>>>    
>>>    		mlx5e_trigger_napi_icosq(c);
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
>>> index 1c2cc2aad2b0..e3e57c849436 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
>>> @@ -135,15 +135,10 @@ int mlx5e_ktls_set_feature_rx(struct net_device *netdev, bool enable)
>>>    	int err = 0;
>>>    
>>>    	mutex_lock(&priv->state_lock);
>>> -	if (enable) {
>>> +	if (enable)
>>>    		err = mlx5e_accel_fs_tcp_create(priv->fs);
>>> -		if (!err && !priv->ktls_rx_was_enabled) {
>>> -			priv->ktls_rx_was_enabled = true;
>>> -			mlx5e_safe_reopen_channels(priv);
>>> -		}
>>> -	} else {
>>> +	else
>>>    		mlx5e_accel_fs_tcp_destroy(priv->fs);
>>> -	}
>>>    	mutex_unlock(&priv->state_lock);
>>>    
>>>    	return err;
>>> @@ -166,7 +161,6 @@ int mlx5e_ktls_init_rx(struct mlx5e_priv *priv)
>>>    			destroy_workqueue(priv->tls->rx_wq);
>>>    			return err;
>>>    		}
>>> -		priv->ktls_rx_was_enabled = true;
>>>    	}
>>>    
>>>    	return 0;
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>>> index 5d8fe252799e..da2d1eb52c13 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>>> @@ -202,8 +202,8 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
>>>    	int err;
>>>    
>>>    	err = 0;
>>> -	sq = c->async_icosq;
>>> -	spin_lock_bh(&sq->lock);
>>> +	sq = &c->async_icosq;
>>> +	spin_lock_bh(&c->async_icosq_lock);
>>>    
>>>    	cseg = post_static_params(sq, priv_rx);
>>>    	if (IS_ERR(cseg))
>>> @@ -214,7 +214,7 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
>>>    
>>>    	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, cseg);
>>>    unlock:
>>> -	spin_unlock_bh(&sq->lock);
>>> +	spin_unlock_bh(&c->async_icosq_lock);
>>>    
>>>    	return err;
>>>    
>>> @@ -277,10 +277,10 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
>>>    
>>>    	buf->priv_rx = priv_rx;
>>>    
>>> -	spin_lock_bh(&sq->lock);
>>> +	spin_lock_bh(&sq->channel->async_icosq_lock);
>>>    
>>>    	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, MLX5E_KTLS_GET_PROGRESS_WQEBBS))) {
>>> -		spin_unlock_bh(&sq->lock);
>>> +		spin_unlock_bh(&sq->channel->async_icosq_lock);
>>>    		err = -ENOSPC;
>>>    		goto err_dma_unmap;
>>>    	}
>>> @@ -311,7 +311,7 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
>>>    	icosq_fill_wi(sq, pi, &wi);
>>>    	sq->pc++;
>>>    	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, cseg);
>>> -	spin_unlock_bh(&sq->lock);
>>> +	spin_unlock_bh(&sq->channel->async_icosq_lock);
>>>    
>>>    	return 0;
>>>    
>>> @@ -344,7 +344,7 @@ static void resync_handle_work(struct work_struct *work)
>>>    	}
>>>    
>>>    	c = resync->priv->channels.c[priv_rx->rxq];
>>> -	sq = c->async_icosq;
>>> +	sq = &c->async_icosq;
>>>    
>>>    	if (resync_post_get_progress_params(sq, priv_rx)) {
>>>    		priv_rx->rq_stats->tls_resync_req_skip++;
>>> @@ -371,7 +371,7 @@ static void resync_handle_seq_match(struct mlx5e_ktls_offload_context_rx *priv_r
>>>    	struct mlx5e_icosq *sq;
>>>    	bool trigger_poll;
>>>    
>>> -	sq = c->async_icosq;
>>> +	sq = &c->async_icosq;
>>>    	ktls_resync = sq->ktls_resync;
>>>    	trigger_poll = false;
>>>    
>>> @@ -413,9 +413,9 @@ static void resync_handle_seq_match(struct mlx5e_ktls_offload_context_rx *priv_r
>>>    		return;
>>>    
>>>    	if (!napi_if_scheduled_mark_missed(&c->napi)) {
>>> -		spin_lock_bh(&sq->lock);
>>> +		spin_lock_bh(&c->async_icosq_lock);
>>>    		mlx5e_trigger_irq(sq);
>>> -		spin_unlock_bh(&sq->lock);
>>> +		spin_unlock_bh(&c->async_icosq_lock);
>>>    	}
>>>    }
>>>    
>>> @@ -753,7 +753,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
>>>    	LIST_HEAD(local_list);
>>>    	int i, j;
>>>    
>>> -	sq = c->async_icosq;
>>> +	sq = &c->async_icosq;
>>>    
>>>    	if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state)))
>>>    		return false;
>>> @@ -772,7 +772,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
>>>    		clear_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &sq->state);
>>>    	spin_unlock(&ktls_resync->lock);
>>>    
>>> -	spin_lock(&sq->lock);
>>> +	spin_lock(&c->async_icosq_lock);
>>>    	for (j = 0; j < i; j++) {
>>>    		struct mlx5_wqe_ctrl_seg *cseg;
>>>    
>>> @@ -791,7 +791,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
>>>    	}
>>>    	if (db_cseg)
>>>    		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, db_cseg);
>>> -	spin_unlock(&sq->lock);
>>> +	spin_unlock(&c->async_icosq_lock);
>>>    
>>>    	priv_rx->rq_stats->tls_resync_res_ok += j;
>>>    
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
>>> index 4022c7e78a2e..cb08799769ee 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
>>> @@ -50,8 +50,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget);
>>>    static inline bool
>>>    mlx5e_ktls_rx_pending_resync_list(struct mlx5e_channel *c, int budget)
>>>    {
>>> -	return budget && test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
>>> -				  &c->async_icosq->state);
>>> +	return budget && test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &c->async_icosq.state);
>>>    }
>>>    
>>>    static inline void
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> index e1e05c9e7ebb..446510153e5e 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> @@ -2075,8 +2075,6 @@ static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params
>>>    	if (err)
>>>    		goto err_free_icosq;
>>>    
>>> -	spin_lock_init(&sq->lock);
>>> -
>>>    	if (param->is_tls) {
>>>    		sq->ktls_resync = mlx5e_ktls_rx_resync_create_resp_list();
>>>    		if (IS_ERR(sq->ktls_resync)) {
>>> @@ -2589,51 +2587,9 @@ static int mlx5e_open_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
>>>    	return mlx5e_open_rq(params, rq_params, NULL, cpu_to_node(c->cpu), q_counter, &c->rq);
>>>    }
>>>    
>>> -static struct mlx5e_icosq *
>>> -mlx5e_open_async_icosq(struct mlx5e_channel *c,
>>> -		       struct mlx5e_params *params,
>>> -		       struct mlx5e_channel_param *cparam,
>>> -		       struct mlx5e_create_cq_param *ccp)
>>> -{
>>> -	struct dim_cq_moder icocq_moder = {0, 0};
>>> -	struct mlx5e_icosq *async_icosq;
>>> -	int err;
>>> -
>>> -	async_icosq = kvzalloc_node(sizeof(*async_icosq), GFP_KERNEL,
>>> -				    cpu_to_node(c->cpu));
>>> -	if (!async_icosq)
>>> -		return ERR_PTR(-ENOMEM);
>>> -
>>> -	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->async_icosq.cqp, ccp,
>>> -			    &async_icosq->cq);
>>> -	if (err)
>>> -		goto err_free_async_icosq;
>>> -
>>> -	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, async_icosq,
>>> -			       mlx5e_async_icosq_err_cqe_work);
>>> -	if (err)
>>> -		goto err_close_async_icosq_cq;
>>> -
>>> -	return async_icosq;
>>> -
>>> -err_close_async_icosq_cq:
>>> -	mlx5e_close_cq(&async_icosq->cq);
>>> -err_free_async_icosq:
>>> -	kvfree(async_icosq);
>>> -	return ERR_PTR(err);
>>> -}
>>> -
>>> -static void mlx5e_close_async_icosq(struct mlx5e_icosq *async_icosq)
>>> -{
>>> -	mlx5e_close_icosq(async_icosq);
>>> -	mlx5e_close_cq(&async_icosq->cq);
>>> -	kvfree(async_icosq);
>>> -}
>>> -
>>>    static int mlx5e_open_queues(struct mlx5e_channel *c,
>>>    			     struct mlx5e_params *params,
>>> -			     struct mlx5e_channel_param *cparam,
>>> -			     bool async_icosq_needed)
>>> +			     struct mlx5e_channel_param *cparam)
>>>    {
>>>    	const struct net_device_ops *netdev_ops = c->netdev->netdev_ops;
>>>    	struct dim_cq_moder icocq_moder = {0, 0};
>>> @@ -2642,10 +2598,15 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>>>    
>>>    	mlx5e_build_create_cq_param(&ccp, c);
>>>    
>>> +	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->async_icosq.cqp, &ccp,
>>> +			    &c->async_icosq.cq);
>>> +	if (err)
>>> +		return err;
>>> +
>>>    	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->icosq.cqp, &ccp,
>>>    			    &c->icosq.cq);
>>>    	if (err)
>>> -		return err;
>>> +		goto err_close_async_icosq_cq;
>>>    
>>>    	err = mlx5e_open_tx_cqs(c, params, &ccp, cparam);
>>>    	if (err)
>>> @@ -2669,14 +2630,12 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>>>    	if (err)
>>>    		goto err_close_rx_cq;
>>>    
>>> -	if (async_icosq_needed) {
>>> -		c->async_icosq = mlx5e_open_async_icosq(c, params, cparam,
>>> -							&ccp);
>>> -		if (IS_ERR(c->async_icosq)) {
>>> -			err = PTR_ERR(c->async_icosq);
>>> -			goto err_close_rq_xdpsq_cq;
>>> -		}
>>> -	}
>>> +	spin_lock_init(&c->async_icosq_lock);
>>> +
>>> +	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, &c->async_icosq,
>>> +			       mlx5e_async_icosq_err_cqe_work);
>>> +	if (err)
>>> +		goto err_close_rq_xdpsq_cq;
>>>    
>>>    	mutex_init(&c->icosq_recovery_lock);
>>>    
>>> @@ -2712,8 +2671,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>>>    	mlx5e_close_icosq(&c->icosq);
>>>    
>>>    err_close_async_icosq:
>>> -	if (c->async_icosq)
>>> -		mlx5e_close_async_icosq(c->async_icosq);
>>> +	mlx5e_close_icosq(&c->async_icosq);
>>>    
>>>    err_close_rq_xdpsq_cq:
>>>    	if (c->xdp)
>>> @@ -2732,6 +2690,9 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>>>    err_close_icosq_cq:
>>>    	mlx5e_close_cq(&c->icosq.cq);
>>>    
>>> +err_close_async_icosq_cq:
>>> +	mlx5e_close_cq(&c->async_icosq.cq);
>>> +
>>>    	return err;
>>>    }
>>>    
>>> @@ -2745,8 +2706,7 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>>>    	mlx5e_close_sqs(c);
>>>    	mlx5e_close_icosq(&c->icosq);
>>>    	mutex_destroy(&c->icosq_recovery_lock);
>>> -	if (c->async_icosq)
>>> -		mlx5e_close_async_icosq(c->async_icosq);
>>> +	mlx5e_close_icosq(&c->async_icosq);
>>>    	if (c->xdp)
>>>    		mlx5e_close_cq(&c->rq_xdpsq.cq);
>>>    	mlx5e_close_cq(&c->rq.cq);
>>> @@ -2754,6 +2714,7 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>>>    		mlx5e_close_xdpredirect_sq(c->xdpsq);
>>>    	mlx5e_close_tx_cqs(c);
>>>    	mlx5e_close_cq(&c->icosq.cq);
>>> +	mlx5e_close_cq(&c->async_icosq.cq);
>>>    }
>>>    
>>>    static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
>>> @@ -2789,16 +2750,9 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
>>>    
>>>    void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c)
>>>    {
>>> -	bool locked;
>>> -
>>> -	if (!test_and_set_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state))
>>> -		synchronize_net();
>>> -
>>> -	locked = mlx5e_icosq_sync_lock(&c->icosq);
>>> -	mlx5e_trigger_irq(&c->icosq);
>>> -	mlx5e_icosq_sync_unlock(&c->icosq, locked);
>>> -
>>> -	clear_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state);
>>> +	spin_lock_bh(&c->async_icosq_lock);
>>> +	mlx5e_trigger_irq(&c->async_icosq);
>>> +	spin_unlock_bh(&c->async_icosq_lock);
>>>    }
>>>    
>>>    void mlx5e_trigger_napi_sched(struct napi_struct *napi)
>>> @@ -2831,7 +2785,6 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>>>    	struct mlx5e_channel_param *cparam;
>>>    	struct mlx5_core_dev *mdev;
>>>    	struct mlx5e_xsk_param xsk;
>>> -	bool async_icosq_needed;
>>>    	struct mlx5e_channel *c;
>>>    	unsigned int irq;
>>>    	int vec_ix;
>>> @@ -2881,8 +2834,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>>>    	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
>>>    	netif_napi_set_irq_locked(&c->napi, irq);
>>>    
>>> -	async_icosq_needed = !!xsk_pool || priv->ktls_rx_was_enabled;
>>> -	err = mlx5e_open_queues(c, params, cparam, async_icosq_needed);
>>> +	err = mlx5e_open_queues(c, params, cparam);
>>>    	if (unlikely(err))
>>>    		goto err_napi_del;
>>>    
>>> @@ -2920,8 +2872,7 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>>>    	for (tc = 0; tc < c->num_tc; tc++)
>>>    		mlx5e_activate_txqsq(&c->sq[tc]);
>>>    	mlx5e_activate_icosq(&c->icosq);
>>> -	if (c->async_icosq)
>>> -		mlx5e_activate_icosq(c->async_icosq);
>>> +	mlx5e_activate_icosq(&c->async_icosq);
>>>    
>>>    	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
>>>    		mlx5e_activate_xsk(c);
>>> @@ -2942,8 +2893,7 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
>>>    	else
>>>    		mlx5e_deactivate_rq(&c->rq);
>>>    
>>> -	if (c->async_icosq)
>>> -		mlx5e_deactivate_icosq(c->async_icosq);
>>> +	mlx5e_deactivate_icosq(&c->async_icosq);
>>>    	mlx5e_deactivate_icosq(&c->icosq);
>>>    	for (tc = 0; tc < c->num_tc; tc++)
>>>    		mlx5e_deactivate_txqsq(&c->sq[tc]);
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> index 1fc3720d2201..1f6930c77437 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> @@ -778,7 +778,6 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>>>    	struct mlx5_wq_cyc *wq = &sq->wq;
>>>    	struct mlx5e_umr_wqe *umr_wqe;
>>>    	u32 offset; /* 17-bit value with MTT. */
>>> -	bool sync_locked;
>>>    	u16 pi;
>>>    	int err;
>>>    	int i;
>>> @@ -789,7 +788,6 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>>>    			goto err;
>>>    	}
>>>    
>>> -	sync_locked = mlx5e_icosq_sync_lock(sq);
>>>    	pi = mlx5e_icosq_get_next_pi(sq, rq->mpwqe.umr_wqebbs);
>>>    	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
>>>    	memcpy(umr_wqe, &rq->mpwqe.umr_wqe, sizeof(struct mlx5e_umr_wqe));
>>> @@ -837,14 +835,12 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>>>    	};
>>>    
>>>    	sq->pc += rq->mpwqe.umr_wqebbs;
>>> -	mlx5e_icosq_sync_unlock(sq, sync_locked);
>>>    
>>>    	sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
>>>    
>>>    	return 0;
>>>    
>>>    err_unmap:
>>> -	mlx5e_icosq_sync_unlock(sq, sync_locked);
>>>    	while (--i >= 0) {
>>>    		frag_page--;
>>>    		mlx5e_page_release_fragmented(rq->page_pool, frag_page);
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
>>> index b31f689fe271..76108299ea57 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
>>> @@ -125,7 +125,6 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
>>>    {
>>>    	struct mlx5e_channel *c = container_of(napi, struct mlx5e_channel,
>>>    					       napi);
>>> -	struct mlx5e_icosq *aicosq = c->async_icosq;
>>>    	struct mlx5e_ch_stats *ch_stats = c->stats;
>>>    	struct mlx5e_xdpsq *xsksq = &c->xsksq;
>>>    	struct mlx5e_txqsq __rcu **qos_sqs;
>>> @@ -181,18 +180,15 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
>>>    	busy |= work_done == budget;
>>>    
>>>    	mlx5e_poll_ico_cq(&c->icosq.cq);
>>> -	if (aicosq) {
>>> -		if (mlx5e_poll_ico_cq(&aicosq->cq))
>>> -			/* Don't clear the flag if nothing was polled to prevent
>>> -			 * queueing more WQEs and overflowing the async ICOSQ.
>>> -			 */
>>> -			clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
>>> -				  &aicosq->state);
>>> -
>>> -		/* Keep after async ICOSQ CQ poll */
>>> -		if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
>>> -			busy |= mlx5e_ktls_rx_handle_resync_list(c, budget);
>>> -	}
>>> +	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
>>> +		/* Don't clear the flag if nothing was polled to prevent
>>> +		 * queueing more WQEs and overflowing the async ICOSQ.
>>> +		 */
>>> +		clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX, &c->async_icosq.state);
>>> +
>>> +	/* Keep after async ICOSQ CQ poll */
>>> +	if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
>>> +		busy |= mlx5e_ktls_rx_handle_resync_list(c, budget);
>>>    
>>>    	busy |= INDIRECT_CALL_2(rq->post_wqes,
>>>    				mlx5e_post_rx_mpwqes,
>>> @@ -240,17 +236,16 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
>>>    
>>>    	mlx5e_cq_arm(&rq->cq);
>>>    	mlx5e_cq_arm(&c->icosq.cq);
>>> -	if (aicosq) {
>>> -		mlx5e_cq_arm(&aicosq->cq);
>>> -		if (xsk_open) {
>>> -			mlx5e_handle_rx_dim(xskrq);
>>> -			mlx5e_cq_arm(&xsksq->cq);
>>> -			mlx5e_cq_arm(&xskrq->cq);
>>> -		}
>>> -	}
>>> +	mlx5e_cq_arm(&c->async_icosq.cq);
>>>    	if (c->xdpsq)
>>>    		mlx5e_cq_arm(&c->xdpsq->cq);
>>>    
>>> +	if (xsk_open) {
>>> +		mlx5e_handle_rx_dim(xskrq);
>>> +		mlx5e_cq_arm(&xsksq->cq);
>>> +		mlx5e_cq_arm(&xskrq->cq);
>>> +	}
>>> +
>>>    	if (unlikely(aff_change && busy_xsk)) {
>>>    		mlx5e_trigger_irq(&c->icosq);
>>>    		ch_stats->force_irq++;


