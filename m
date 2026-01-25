Return-Path: <netdev+bounces-253141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XlAcCmnVdWn0IwEAu9opvQ
	(envelope-from <netdev+bounces-253141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:33:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED0080033
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02933300823F
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D591E9906;
	Sun, 25 Jan 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHnk47Wd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC761A38F9
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769330020; cv=none; b=TIxSCbVa6JpbjnZh5+LXxG1k5nLCb8zoSbs9pMXbKvouIsFxUJJAatrXw+DwfP8wGfzR6mxxC3xEhCAd/M0CVvwZWYskimCKl1jYGh1qbluIDPHxNKOzloiQuv+EAse7ypNNJw/NW2+cbaZNturb5jw5sXdOyy4yV60lhosiftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769330020; c=relaxed/simple;
	bh=v3+fo5m9V3Ltpz5yMksV8V1zkJAkMqGyLTeEz/kS7Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkGnvb6Yv0ni4tTcun5CAQ3V7CFABWT6IEtnVKGDZk5mde0x6IHeI+3cvZKecuSBXNcYhpPymUHs+axg/P+33sFdBhuKTSr+m/UF4Ml4X0KAlVy07FI3XEJjOd7xrBExbLdm5V/Vx8n/GdwiMsS0nMoNc/RrjK6wgnTANawGPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHnk47Wd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359228b7c6so2200200f8f.2
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769330016; x=1769934816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxWAXtfLnpv4SZGjQ6Zp1OtCwAOJoIFNL96cLEFFl8E=;
        b=iHnk47WdD09s3SoMKncIlS6p3UVFyigVZZiGa4PCeu/ApLtGKv/jPzzP6dbFdogRGS
         AjtORypbrViTsgVDSIgHEmF9Xp384fx25vNM4KgbqQdDAWmEr8NeddCzICwDWwc0fUDC
         TyLy+/4UwJoMDe4Of55em3XxVuaigiYZgol8e2wSJDsiqdtC17gXklx0/Ng1XWC3EUIR
         x5gVxj1L/06j9LfxHDGo001yLKZDJ2EViofGBbYIQ/JAIGuCxJHEc7DJe31gD7ckIRjr
         EtSq/nweX29PBqaBV7HsqWdX32Z2De/WMGYeqg0ufbifNgmFSD16EIAbuTptPHc6k4Zq
         Ho8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769330016; x=1769934816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxWAXtfLnpv4SZGjQ6Zp1OtCwAOJoIFNL96cLEFFl8E=;
        b=SCmVJstyV2bVmD7xAvIg/yMEkJvwvCeLFLV3hDla3qHMKseb8iv0SBib+zHTNh8vDi
         RT6sbpq9bFJuQxNEooKODjCOJCxELhwQGIFs1iyjLy9/wJJZ7lsnG2VrBuadihMiyLNg
         yNIHI/17f7gy6a00KizbWoKMh665RQ29mTwlEkyXo3Uha7pABk+Cc8Cdcv/DrsmIzRBt
         PjdcrmFLFBe3afekEIJ+fo1XSA+k9okn7UtKB53hxppzS5nCh4HrYTeQWVT7e5prPKEz
         kP65Or1k01/Ivf+EELdyLW6poufaLHp5uWoQbCwIjAAAz4jscTCij7mA+6s68RgUBU3C
         +/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyBHe1Ul59NhQk4zDJzxlozET94+XQ+KLQOiQKQRK51gB9ryZqedEF0ljZh9piGiAU85pjj04=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqpdr0Ntmj5A7nL6UzvqdZxpyWtSgk6RF/tAnugWfZ/d1umxgX
	TNhZUIaZZxZGVnoOKu+GJbeY1StF4PYFvcQiJ+MWEvve2/b6t4RSQP+s
X-Gm-Gg: AZuq6aKMN2pEy1GEdzbh23pAYsSPoeXIdEONM6SqR1MRiYJ/yABbjcnxMC1lfT7++Ek
	xONh1Cu1qN0lY298uzFCRMNOY4Hn298NYv853Ca0vlLmu7xo8JET4z8wNw2FIXlTyNUDLLYc2aI
	tSquLFbipXTwwNcpwNUarOP2i0kS9lTghMWQoGa4ZSI1Lw4dGADyDjd3cunxsMRp4fCllOqsZHP
	yD9Curfa4NmsDGLJKygSE5qQGDvj06aLj3SDqyvXxqh7KvTACHlueBJm1EQwiZ2EpTIRt6U0F9I
	cs4pJN10UqWz7cKR4AQP9Ng4wPEbsTISdeLX273bCR+8/Uiy4jganqJU4WclZCefM8OSeG9XyJr
	GYC5t9afFx7EPRsnfDAXRKIlyqGS90kXPiImTlyYaIxhc+f7YainZ2UxgVbj0omk29XNvc+KOnx
	RRZFtV9FGac5Opz1dcV0st/ltALq+CozXENb8=
X-Received: by 2002:a05:600c:64cf:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-4805cf5f4aemr17135765e9.17.1769330016056;
        Sun, 25 Jan 2026 00:33:36 -0800 (PST)
Received: from [10.221.200.179] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d3fda30sm74264195e9.1.2026.01.25.00.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 00:33:35 -0800 (PST)
Message-ID: <85776531-d5fa-4762-90aa-74c8397dc09b@gmail.com>
Date: Sun, 25 Jan 2026 10:33:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Undo saving per-channel async ICOSQ
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: William Tu <witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Gal Pressman <gal@nvidia.com>
References: <20260123223916.361295-1-daniel@iogearbox.net>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260123223916.361295-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253141-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 3ED0080033
X-Rspamd-Action: no action



On 24/01/2026 0:39, Daniel Borkmann wrote:
> This reverts the following commits:
> 
>    - ea945f4f3991 ("net/mlx5e: Move async ICOSQ lock into ICOSQ struct")
>    - 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for triggering NAPI")
>    - 1b080bd74840 ("net/mlx5e: Move async ICOSQ to dynamic allocation")
>    - abed42f9cd80 ("net/mlx5e: Conditionally create async ICOSQ")
> 
> There are a couple of regressions on the xsk side I ran into:
> 
> Commit 56aca3e0f730 triggers an illegal synchronize_rcu() in an RCU read-
> side critical section via mlx5e_xsk_wakeup() -> mlx5e_trigger_napi_icosq()
> -> synchronize_net(). The stack holds RCU read-lock in xsk_poll().
> 
> Additionally, this also hits a NULL pointer dereference in mlx5e_xsk_wakeup():
> 
>    [  103.963735] BUG: kernel NULL pointer dereference, address: 0000000000000240
>    [  103.963743] #PF: supervisor read access in kernel mode
>    [  103.963746] #PF: error_code(0x0000) - not-present page
>    [  103.963749] PGD 0 P4D 0
>    [  103.963752] Oops: Oops: 0000 [#1] SMP
>    [  103.963756] CPU: 0 UID: 0 PID: 2255 Comm: qemu-system-x86 Not tainted 6.19.0-rc5+ #229 PREEMPT(none)
>    [  103.963761] Hardware name: [...]
>    [  103.963765] RIP: 0010:mlx5e_xsk_wakeup+0x53/0x90 [mlx5_core]
> 
> What happens is that c->async_icosq is NULL when in mlx5e_xsk_wakeup()
> and therefore access to c->async_icosq->state triggers it. (On the NIC
> there is an XDP program installed by the control plane where traffic
> gets redirected into an xsk map - there was no xsk pool set up yet.
> At some later time a xsk pool is set up and the related xsk socket is
> added to the xsk map of the XDP program.)
> 

Hi Daniel,

Thanks for your report.

> Reverting the series fixes the problems again.
> 

Revert is too aggressive here. A fix is preferable.
We're investigating the issue in order to fix it.
We'll update.

> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: William Tu <witu@nvidia.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: David Wei <dw@davidwei.uk>
> Cc: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |  26 +----
>   .../mellanox/mlx5/core/en/reporter_tx.c       |   1 -
>   .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |   3 -
>   .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |   6 +-
>   .../mellanox/mlx5/core/en_accel/ktls.c        |  10 +-
>   .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  26 ++---
>   .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |   3 +-
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 100 +++++-------------
>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 -
>   .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  37 +++----
>   10 files changed, 62 insertions(+), 154 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 19b9683f4622..ff4ab4691baf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -388,7 +388,6 @@ enum {
>   	MLX5E_SQ_STATE_DIM,
>   	MLX5E_SQ_STATE_PENDING_XSK_TX,
>   	MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
> -	MLX5E_SQ_STATE_LOCK_NEEDED,
>   	MLX5E_NUM_SQ_STATES, /* Must be kept last */
>   };
>   
> @@ -546,11 +545,6 @@ struct mlx5e_icosq {
>   	u32                        sqn;
>   	u16                        reserved_room;
>   	unsigned long              state;
> -	/* icosq can be accessed from any CPU and from different contexts
> -	 * (NAPI softirq or process/workqueue). Always use spin_lock_bh for
> -	 * simplicity and correctness across all contexts.
> -	 */
> -	spinlock_t                 lock;
>   	struct mlx5e_ktls_resync_resp *ktls_resync;
>   
>   	/* control path */
> @@ -782,7 +776,9 @@ struct mlx5e_channel {
>   	struct mlx5e_xdpsq         xsksq;
>   
>   	/* Async ICOSQ */
> -	struct mlx5e_icosq        *async_icosq;
> +	struct mlx5e_icosq         async_icosq;
> +	/* async_icosq can be accessed from any CPU - the spinlock protects it. */
> +	spinlock_t                 async_icosq_lock;
>   
>   	/* data path - accessed per napi poll */
>   	const struct cpumask	  *aff_mask;
> @@ -805,21 +801,6 @@ struct mlx5e_channel {
>   	struct dim_cq_moder        tx_cq_moder;
>   };
>   
> -static inline bool mlx5e_icosq_sync_lock(struct mlx5e_icosq *sq)
> -{
> -	if (likely(!test_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state)))
> -		return false;
> -
> -	spin_lock_bh(&sq->lock);
> -	return true;
> -}
> -
> -static inline void mlx5e_icosq_sync_unlock(struct mlx5e_icosq *sq, bool locked)
> -{
> -	if (unlikely(locked))
> -		spin_unlock_bh(&sq->lock);
> -}
> -
>   struct mlx5e_ptp;
>   
>   struct mlx5e_channels {
> @@ -939,7 +920,6 @@ struct mlx5e_priv {
>   	u8                         max_opened_tc;
>   	bool                       tx_ptp_opened;
>   	bool                       rx_ptp_opened;
> -	bool                       ktls_rx_was_enabled;
>   	struct kernel_hwtstamp_config hwtstamp_config;
>   	u16                        q_counter[MLX5_SD_MAX_GROUP_SZ];
>   	u16                        drop_rq_q_counter;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> index 4adc1adf9897..9e2cf191ed30 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> @@ -15,7 +15,6 @@ static const char * const sq_sw_state_type_name[] = {
>   	[MLX5E_SQ_STATE_DIM] = "dim",
>   	[MLX5E_SQ_STATE_PENDING_XSK_TX] = "pending_xsk_tx",
>   	[MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC] = "pending_tls_rx_resync",
> -	[MLX5E_SQ_STATE_LOCK_NEEDED] = "lock_needed",
>   };
>   
>   static int mlx5e_wait_for_sq_flush(struct mlx5e_txqsq *sq)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> index 4f984f6a2cb9..2b05536d564a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> @@ -23,7 +23,6 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>   	struct mlx5_wq_cyc *wq = &icosq->wq;
>   	struct mlx5e_umr_wqe *umr_wqe;
>   	struct xdp_buff **xsk_buffs;
> -	bool sync_locked;
>   	int batch, i;
>   	u32 offset; /* 17-bit value with MTT. */
>   	u16 pi;
> @@ -48,7 +47,6 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>   			goto err_reuse_batch;
>   	}
>   
> -	sync_locked = mlx5e_icosq_sync_lock(icosq);
>   	pi = mlx5e_icosq_get_next_pi(icosq, rq->mpwqe.umr_wqebbs);
>   	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
>   	memcpy(umr_wqe, &rq->mpwqe.umr_wqe, sizeof(struct mlx5e_umr_wqe));
> @@ -145,7 +143,6 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>   	};
>   
>   	icosq->pc += rq->mpwqe.umr_wqebbs;
> -	mlx5e_icosq_sync_unlock(icosq, sync_locked);
>   
>   	icosq->doorbell_cseg = &umr_wqe->hdr.ctrl;
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> index 9e33156fac8a..a59199ed590d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> @@ -26,12 +26,10 @@ int mlx5e_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>   		 * active and not polled by NAPI. Return 0, because the upcoming
>   		 * activate will trigger the IRQ for us.
>   		 */
> -		if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED,
> -				       &c->async_icosq->state)))
> +		if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &c->async_icosq.state)))
>   			return 0;
>   
> -		if (test_and_set_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
> -				     &c->async_icosq->state))
> +		if (test_and_set_bit(MLX5E_SQ_STATE_PENDING_XSK_TX, &c->async_icosq.state))
>   			return 0;
>   
>   		mlx5e_trigger_napi_icosq(c);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> index 1c2cc2aad2b0..e3e57c849436 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> @@ -135,15 +135,10 @@ int mlx5e_ktls_set_feature_rx(struct net_device *netdev, bool enable)
>   	int err = 0;
>   
>   	mutex_lock(&priv->state_lock);
> -	if (enable) {
> +	if (enable)
>   		err = mlx5e_accel_fs_tcp_create(priv->fs);
> -		if (!err && !priv->ktls_rx_was_enabled) {
> -			priv->ktls_rx_was_enabled = true;
> -			mlx5e_safe_reopen_channels(priv);
> -		}
> -	} else {
> +	else
>   		mlx5e_accel_fs_tcp_destroy(priv->fs);
> -	}
>   	mutex_unlock(&priv->state_lock);
>   
>   	return err;
> @@ -166,7 +161,6 @@ int mlx5e_ktls_init_rx(struct mlx5e_priv *priv)
>   			destroy_workqueue(priv->tls->rx_wq);
>   			return err;
>   		}
> -		priv->ktls_rx_was_enabled = true;
>   	}
>   
>   	return 0;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> index 5d8fe252799e..da2d1eb52c13 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> @@ -202,8 +202,8 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
>   	int err;
>   
>   	err = 0;
> -	sq = c->async_icosq;
> -	spin_lock_bh(&sq->lock);
> +	sq = &c->async_icosq;
> +	spin_lock_bh(&c->async_icosq_lock);
>   
>   	cseg = post_static_params(sq, priv_rx);
>   	if (IS_ERR(cseg))
> @@ -214,7 +214,7 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
>   
>   	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, cseg);
>   unlock:
> -	spin_unlock_bh(&sq->lock);
> +	spin_unlock_bh(&c->async_icosq_lock);
>   
>   	return err;
>   
> @@ -277,10 +277,10 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
>   
>   	buf->priv_rx = priv_rx;
>   
> -	spin_lock_bh(&sq->lock);
> +	spin_lock_bh(&sq->channel->async_icosq_lock);
>   
>   	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, MLX5E_KTLS_GET_PROGRESS_WQEBBS))) {
> -		spin_unlock_bh(&sq->lock);
> +		spin_unlock_bh(&sq->channel->async_icosq_lock);
>   		err = -ENOSPC;
>   		goto err_dma_unmap;
>   	}
> @@ -311,7 +311,7 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
>   	icosq_fill_wi(sq, pi, &wi);
>   	sq->pc++;
>   	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, cseg);
> -	spin_unlock_bh(&sq->lock);
> +	spin_unlock_bh(&sq->channel->async_icosq_lock);
>   
>   	return 0;
>   
> @@ -344,7 +344,7 @@ static void resync_handle_work(struct work_struct *work)
>   	}
>   
>   	c = resync->priv->channels.c[priv_rx->rxq];
> -	sq = c->async_icosq;
> +	sq = &c->async_icosq;
>   
>   	if (resync_post_get_progress_params(sq, priv_rx)) {
>   		priv_rx->rq_stats->tls_resync_req_skip++;
> @@ -371,7 +371,7 @@ static void resync_handle_seq_match(struct mlx5e_ktls_offload_context_rx *priv_r
>   	struct mlx5e_icosq *sq;
>   	bool trigger_poll;
>   
> -	sq = c->async_icosq;
> +	sq = &c->async_icosq;
>   	ktls_resync = sq->ktls_resync;
>   	trigger_poll = false;
>   
> @@ -413,9 +413,9 @@ static void resync_handle_seq_match(struct mlx5e_ktls_offload_context_rx *priv_r
>   		return;
>   
>   	if (!napi_if_scheduled_mark_missed(&c->napi)) {
> -		spin_lock_bh(&sq->lock);
> +		spin_lock_bh(&c->async_icosq_lock);
>   		mlx5e_trigger_irq(sq);
> -		spin_unlock_bh(&sq->lock);
> +		spin_unlock_bh(&c->async_icosq_lock);
>   	}
>   }
>   
> @@ -753,7 +753,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
>   	LIST_HEAD(local_list);
>   	int i, j;
>   
> -	sq = c->async_icosq;
> +	sq = &c->async_icosq;
>   
>   	if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state)))
>   		return false;
> @@ -772,7 +772,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
>   		clear_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &sq->state);
>   	spin_unlock(&ktls_resync->lock);
>   
> -	spin_lock(&sq->lock);
> +	spin_lock(&c->async_icosq_lock);
>   	for (j = 0; j < i; j++) {
>   		struct mlx5_wqe_ctrl_seg *cseg;
>   
> @@ -791,7 +791,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
>   	}
>   	if (db_cseg)
>   		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, db_cseg);
> -	spin_unlock(&sq->lock);
> +	spin_unlock(&c->async_icosq_lock);
>   
>   	priv_rx->rq_stats->tls_resync_res_ok += j;
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
> index 4022c7e78a2e..cb08799769ee 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
> @@ -50,8 +50,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget);
>   static inline bool
>   mlx5e_ktls_rx_pending_resync_list(struct mlx5e_channel *c, int budget)
>   {
> -	return budget && test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
> -				  &c->async_icosq->state);
> +	return budget && test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &c->async_icosq.state);
>   }
>   
>   static inline void
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index e1e05c9e7ebb..446510153e5e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2075,8 +2075,6 @@ static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params
>   	if (err)
>   		goto err_free_icosq;
>   
> -	spin_lock_init(&sq->lock);
> -
>   	if (param->is_tls) {
>   		sq->ktls_resync = mlx5e_ktls_rx_resync_create_resp_list();
>   		if (IS_ERR(sq->ktls_resync)) {
> @@ -2589,51 +2587,9 @@ static int mlx5e_open_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
>   	return mlx5e_open_rq(params, rq_params, NULL, cpu_to_node(c->cpu), q_counter, &c->rq);
>   }
>   
> -static struct mlx5e_icosq *
> -mlx5e_open_async_icosq(struct mlx5e_channel *c,
> -		       struct mlx5e_params *params,
> -		       struct mlx5e_channel_param *cparam,
> -		       struct mlx5e_create_cq_param *ccp)
> -{
> -	struct dim_cq_moder icocq_moder = {0, 0};
> -	struct mlx5e_icosq *async_icosq;
> -	int err;
> -
> -	async_icosq = kvzalloc_node(sizeof(*async_icosq), GFP_KERNEL,
> -				    cpu_to_node(c->cpu));
> -	if (!async_icosq)
> -		return ERR_PTR(-ENOMEM);
> -
> -	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->async_icosq.cqp, ccp,
> -			    &async_icosq->cq);
> -	if (err)
> -		goto err_free_async_icosq;
> -
> -	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, async_icosq,
> -			       mlx5e_async_icosq_err_cqe_work);
> -	if (err)
> -		goto err_close_async_icosq_cq;
> -
> -	return async_icosq;
> -
> -err_close_async_icosq_cq:
> -	mlx5e_close_cq(&async_icosq->cq);
> -err_free_async_icosq:
> -	kvfree(async_icosq);
> -	return ERR_PTR(err);
> -}
> -
> -static void mlx5e_close_async_icosq(struct mlx5e_icosq *async_icosq)
> -{
> -	mlx5e_close_icosq(async_icosq);
> -	mlx5e_close_cq(&async_icosq->cq);
> -	kvfree(async_icosq);
> -}
> -
>   static int mlx5e_open_queues(struct mlx5e_channel *c,
>   			     struct mlx5e_params *params,
> -			     struct mlx5e_channel_param *cparam,
> -			     bool async_icosq_needed)
> +			     struct mlx5e_channel_param *cparam)
>   {
>   	const struct net_device_ops *netdev_ops = c->netdev->netdev_ops;
>   	struct dim_cq_moder icocq_moder = {0, 0};
> @@ -2642,10 +2598,15 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>   
>   	mlx5e_build_create_cq_param(&ccp, c);
>   
> +	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->async_icosq.cqp, &ccp,
> +			    &c->async_icosq.cq);
> +	if (err)
> +		return err;
> +
>   	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->icosq.cqp, &ccp,
>   			    &c->icosq.cq);
>   	if (err)
> -		return err;
> +		goto err_close_async_icosq_cq;
>   
>   	err = mlx5e_open_tx_cqs(c, params, &ccp, cparam);
>   	if (err)
> @@ -2669,14 +2630,12 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>   	if (err)
>   		goto err_close_rx_cq;
>   
> -	if (async_icosq_needed) {
> -		c->async_icosq = mlx5e_open_async_icosq(c, params, cparam,
> -							&ccp);
> -		if (IS_ERR(c->async_icosq)) {
> -			err = PTR_ERR(c->async_icosq);
> -			goto err_close_rq_xdpsq_cq;
> -		}
> -	}
> +	spin_lock_init(&c->async_icosq_lock);
> +
> +	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, &c->async_icosq,
> +			       mlx5e_async_icosq_err_cqe_work);
> +	if (err)
> +		goto err_close_rq_xdpsq_cq;
>   
>   	mutex_init(&c->icosq_recovery_lock);
>   
> @@ -2712,8 +2671,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>   	mlx5e_close_icosq(&c->icosq);
>   
>   err_close_async_icosq:
> -	if (c->async_icosq)
> -		mlx5e_close_async_icosq(c->async_icosq);
> +	mlx5e_close_icosq(&c->async_icosq);
>   
>   err_close_rq_xdpsq_cq:
>   	if (c->xdp)
> @@ -2732,6 +2690,9 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>   err_close_icosq_cq:
>   	mlx5e_close_cq(&c->icosq.cq);
>   
> +err_close_async_icosq_cq:
> +	mlx5e_close_cq(&c->async_icosq.cq);
> +
>   	return err;
>   }
>   
> @@ -2745,8 +2706,7 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>   	mlx5e_close_sqs(c);
>   	mlx5e_close_icosq(&c->icosq);
>   	mutex_destroy(&c->icosq_recovery_lock);
> -	if (c->async_icosq)
> -		mlx5e_close_async_icosq(c->async_icosq);
> +	mlx5e_close_icosq(&c->async_icosq);
>   	if (c->xdp)
>   		mlx5e_close_cq(&c->rq_xdpsq.cq);
>   	mlx5e_close_cq(&c->rq.cq);
> @@ -2754,6 +2714,7 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>   		mlx5e_close_xdpredirect_sq(c->xdpsq);
>   	mlx5e_close_tx_cqs(c);
>   	mlx5e_close_cq(&c->icosq.cq);
> +	mlx5e_close_cq(&c->async_icosq.cq);
>   }
>   
>   static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> @@ -2789,16 +2750,9 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
>   
>   void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c)
>   {
> -	bool locked;
> -
> -	if (!test_and_set_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state))
> -		synchronize_net();
> -
> -	locked = mlx5e_icosq_sync_lock(&c->icosq);
> -	mlx5e_trigger_irq(&c->icosq);
> -	mlx5e_icosq_sync_unlock(&c->icosq, locked);
> -
> -	clear_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state);
> +	spin_lock_bh(&c->async_icosq_lock);
> +	mlx5e_trigger_irq(&c->async_icosq);
> +	spin_unlock_bh(&c->async_icosq_lock);
>   }
>   
>   void mlx5e_trigger_napi_sched(struct napi_struct *napi)
> @@ -2831,7 +2785,6 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>   	struct mlx5e_channel_param *cparam;
>   	struct mlx5_core_dev *mdev;
>   	struct mlx5e_xsk_param xsk;
> -	bool async_icosq_needed;
>   	struct mlx5e_channel *c;
>   	unsigned int irq;
>   	int vec_ix;
> @@ -2881,8 +2834,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>   	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
>   	netif_napi_set_irq_locked(&c->napi, irq);
>   
> -	async_icosq_needed = !!xsk_pool || priv->ktls_rx_was_enabled;
> -	err = mlx5e_open_queues(c, params, cparam, async_icosq_needed);
> +	err = mlx5e_open_queues(c, params, cparam);
>   	if (unlikely(err))
>   		goto err_napi_del;
>   
> @@ -2920,8 +2872,7 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>   	for (tc = 0; tc < c->num_tc; tc++)
>   		mlx5e_activate_txqsq(&c->sq[tc]);
>   	mlx5e_activate_icosq(&c->icosq);
> -	if (c->async_icosq)
> -		mlx5e_activate_icosq(c->async_icosq);
> +	mlx5e_activate_icosq(&c->async_icosq);
>   
>   	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
>   		mlx5e_activate_xsk(c);
> @@ -2942,8 +2893,7 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
>   	else
>   		mlx5e_deactivate_rq(&c->rq);
>   
> -	if (c->async_icosq)
> -		mlx5e_deactivate_icosq(c->async_icosq);
> +	mlx5e_deactivate_icosq(&c->async_icosq);
>   	mlx5e_deactivate_icosq(&c->icosq);
>   	for (tc = 0; tc < c->num_tc; tc++)
>   		mlx5e_deactivate_txqsq(&c->sq[tc]);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1fc3720d2201..1f6930c77437 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -778,7 +778,6 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>   	struct mlx5_wq_cyc *wq = &sq->wq;
>   	struct mlx5e_umr_wqe *umr_wqe;
>   	u32 offset; /* 17-bit value with MTT. */
> -	bool sync_locked;
>   	u16 pi;
>   	int err;
>   	int i;
> @@ -789,7 +788,6 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>   			goto err;
>   	}
>   
> -	sync_locked = mlx5e_icosq_sync_lock(sq);
>   	pi = mlx5e_icosq_get_next_pi(sq, rq->mpwqe.umr_wqebbs);
>   	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
>   	memcpy(umr_wqe, &rq->mpwqe.umr_wqe, sizeof(struct mlx5e_umr_wqe));
> @@ -837,14 +835,12 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>   	};
>   
>   	sq->pc += rq->mpwqe.umr_wqebbs;
> -	mlx5e_icosq_sync_unlock(sq, sync_locked);
>   
>   	sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
>   
>   	return 0;
>   
>   err_unmap:
> -	mlx5e_icosq_sync_unlock(sq, sync_locked);
>   	while (--i >= 0) {
>   		frag_page--;
>   		mlx5e_page_release_fragmented(rq->page_pool, frag_page);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> index b31f689fe271..76108299ea57 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> @@ -125,7 +125,6 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
>   {
>   	struct mlx5e_channel *c = container_of(napi, struct mlx5e_channel,
>   					       napi);
> -	struct mlx5e_icosq *aicosq = c->async_icosq;
>   	struct mlx5e_ch_stats *ch_stats = c->stats;
>   	struct mlx5e_xdpsq *xsksq = &c->xsksq;
>   	struct mlx5e_txqsq __rcu **qos_sqs;
> @@ -181,18 +180,15 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
>   	busy |= work_done == budget;
>   
>   	mlx5e_poll_ico_cq(&c->icosq.cq);
> -	if (aicosq) {
> -		if (mlx5e_poll_ico_cq(&aicosq->cq))
> -			/* Don't clear the flag if nothing was polled to prevent
> -			 * queueing more WQEs and overflowing the async ICOSQ.
> -			 */
> -			clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
> -				  &aicosq->state);
> -
> -		/* Keep after async ICOSQ CQ poll */
> -		if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
> -			busy |= mlx5e_ktls_rx_handle_resync_list(c, budget);
> -	}
> +	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
> +		/* Don't clear the flag if nothing was polled to prevent
> +		 * queueing more WQEs and overflowing the async ICOSQ.
> +		 */
> +		clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX, &c->async_icosq.state);
> +
> +	/* Keep after async ICOSQ CQ poll */
> +	if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
> +		busy |= mlx5e_ktls_rx_handle_resync_list(c, budget);
>   
>   	busy |= INDIRECT_CALL_2(rq->post_wqes,
>   				mlx5e_post_rx_mpwqes,
> @@ -240,17 +236,16 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
>   
>   	mlx5e_cq_arm(&rq->cq);
>   	mlx5e_cq_arm(&c->icosq.cq);
> -	if (aicosq) {
> -		mlx5e_cq_arm(&aicosq->cq);
> -		if (xsk_open) {
> -			mlx5e_handle_rx_dim(xskrq);
> -			mlx5e_cq_arm(&xsksq->cq);
> -			mlx5e_cq_arm(&xskrq->cq);
> -		}
> -	}
> +	mlx5e_cq_arm(&c->async_icosq.cq);
>   	if (c->xdpsq)
>   		mlx5e_cq_arm(&c->xdpsq->cq);
>   
> +	if (xsk_open) {
> +		mlx5e_handle_rx_dim(xskrq);
> +		mlx5e_cq_arm(&xsksq->cq);
> +		mlx5e_cq_arm(&xskrq->cq);
> +	}
> +
>   	if (unlikely(aff_change && busy_xsk)) {
>   		mlx5e_trigger_irq(&c->icosq);
>   		ch_stats->force_irq++;


