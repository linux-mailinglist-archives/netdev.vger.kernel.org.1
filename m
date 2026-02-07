Return-Path: <netdev+bounces-257727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOC+MlbAhmlUQgQAu9opvQ
	(envelope-from <netdev+bounces-257727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:32:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6BA104EA8
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79001300988E
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B22DB789;
	Sat,  7 Feb 2026 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoSpj/fW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1151D9346;
	Sat,  7 Feb 2026 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438734; cv=none; b=tihD+wZ8j51sJ8E5uYpbDTGuPJ8cR40isNbtzu9VKzEYDuiOz/Q4pcz1vmiGP6W0kn6OmoFvvRYs9d7+1DZmYEn+O5XCYcSx7wsdM+yNd7/JxFjpwbjEOL4fQsFQDbLY4MyjB5W/eFnRO5q66ljz1/oa69adXznF7SnXVC/DDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438734; c=relaxed/simple;
	bh=HUA0QVUzzO7Pq8PLZf2WwaJ+ETkfFU1eo/FLvlvBl7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjiIYq8wkYLffHCiObTO53Sb0frOy+CXVKeMEUQafv1zcLM8D8MKmTUCUIBDMioBSLYdR1o7Lgv0Sp/wN+poDIjPxtZsBUAiMGKvIoD+8RF6Fst1eeGZ2x1nN84v7WXSsEUenHpGRPEUrpU2XNqT0nPo5AkJpDJe8PJCz3mPSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoSpj/fW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFFCC116D0;
	Sat,  7 Feb 2026 04:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770438733;
	bh=HUA0QVUzzO7Pq8PLZf2WwaJ+ETkfFU1eo/FLvlvBl7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QoSpj/fWYlsAESHXHxxl68Gx2dha72VkAyrGsBKPh++jxOnpAq53W/JJjJJQFLHcV
	 +eV3SgndOwXP8TW49AFiE0TspP2/Ao7dMLrrbC8hlkWHPaBn1OoJmDOoRBhCuHfawl
	 22Y+KRhQBqTHPCb+Cmk2BpQb8jisPhs8n/Dpd3DTsRT/yR8S70FjVfvZhkgUnZpc2D
	 XJfSSGc4kh1nTNzALzjlagSNOpJJVM0XRZbFgJL1sJkutwGVzcu7ZRgv5YfmoMxKp2
	 /WXkxr2k2uZxWfbQBNJ0pAl9wudu1x7hoO4+iy3GjkLGtqvpM4tsj7wEy4IjgkRocd
	 EPs/r49ZzM2AQ==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.zahka@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	tariqt@nvidia.com,
	shuah@kernel.org,
	borisp@nvidia.com,
	leon@kernel.org,
	davem@davemloft.net,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	donald.hunter@gmail.com,
	pabeni@redhat.com,
	mbloch@nvidia.com
Subject: Re: [net-next,7/9] mlx5: psp: implement deferred tx key deletion
Date: Fri,  6 Feb 2026 20:32:12 -0800
Message-ID: <20260207043212.4129693-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204-psp-v1-7-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-7-5f034e2dfa36@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,davemloft.net,lunn.ch,google.com,gmail.com,redhat.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D6BA104EA8
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
mlx5: psp: implement deferred tx key deletion

This patch implements the deferred tx key deletion API for mlx5. The
mlx5e_psp_tx_grace_begin() function records WQE counts on each tx queue,
and mlx5e_psp_tx_grace_end() returns success only after all tx queues
have advanced a full ring cycle past the snapshot point.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
> @@ -22,10 +22,17 @@ struct mlx5e_psp_stats {
>  	u64 psp_tx_bytes_drop;
>  };
>
> +struct mlx5e_psp_tx_snapshot {
> +	int num_channels;
> +	int num_tc;
> +	u64 wqes[];
> +};
> +
>  struct mlx5e_psp {
>  	struct psp_dev *psp;
>  	struct psp_dev_caps caps;
>  	struct mlx5e_psp_fs *fs;
> +	struct mlx5e_psp_tx_snapshot *tx_snapshot;
>  	atomic_t tx_key_cnt;
>  	atomic_t tx_drop;
>  };

Can the tx_snapshot allocation be leaked during device teardown?

If mlx5e_psp_tx_grace_begin() is called and allocates tx_snapshot, but
mlx5e_psp_cleanup() runs before mlx5e_psp_tx_grace_end() frees it:

    mlx5e_psp_cleanup()
        kfree(psp);   // psp->tx_snapshot not freed

The tx_snapshot memory would be leaked. Should mlx5e_psp_cleanup() free
psp->tx_snapshot before freeing psp?

