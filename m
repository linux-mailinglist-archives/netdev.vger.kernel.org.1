Return-Path: <netdev+bounces-250779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C7D3922F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F00C830124D1
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7BC1E572F;
	Sun, 18 Jan 2026 02:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1xtPa8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04F2BB13
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703286; cv=none; b=kcr0LG3Il1vLASONJmdrL9edxvP+sh97/xdk+vpx/IqwSDI3O5vP7SYvnZ5B1bp583ydXmd+3c6dRCoBQ3WxvtYscJJPIBbeWzK4EhjKRqiF0ff3VIqLMAC24XEYBjZh8R/AYUC9HpgOSWt9vhe21ghAEFYsw9qTBzvi3RJd4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703286; c=relaxed/simple;
	bh=1cgLjfvlmtdv4SdvdMhNGERMr9/C1l/7hoJchVHggRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC/vaKYx6dfFx/Iy8lj7WK6DkiSkCHIDRCl/0AtVoS36Wrb5qm2Ue35kzxvpl0KovX8BZQGKQM9BEye3TlMJLs57zIud4pPRcWgR9iJq50PT7ToHD10H66Cu4MS0b4H/9LAXVZzki7UMcuIzO79+HTFLjlV/qh5XbbJpwjELO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1xtPa8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A74C19422;
	Sun, 18 Jan 2026 02:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768703285;
	bh=1cgLjfvlmtdv4SdvdMhNGERMr9/C1l/7hoJchVHggRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1xtPa8hiQHdYfdFNi8CVwyMDA4lPlJhF6DJi0noNAERnwZTxzjYkgKAqFAjbFizK
	 5PPCUOBNrW2jcodE1C21s2ptwXmBUtXJx6EX9V/gHQ9wUcoyvNpJ97Urb/VJqlF4zd
	 o8M5vk7fGw8+uba9+f2mh+4IJWfyHQt0sHOxzuRPBZgQOKxljVXCIGmHgoGM60TyRn
	 TUtzxLJBufgJCNUJd5xCngU/GG0IdIkxLPHNkz4cn2rs0+Bya/JQhc8xbvWWR7ipb5
	 yTLcHX7WJqe8Yf21yCcZJW/syuT5XIWd6cm3JMx8vLAnR+mZeE7msftCNWmW5kbE8S
	 5d0/FeeFx+d8w==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	davem@davemloft.net,
	aleksandr.loktionov@intel.com,
	netdev@vger.kernel.org,
	Samuel.salin@intel.com,
	pabeni@redhat.com,
	madhu.chittim@intel.com,
	andrew+netdev@lunn.ch,
	milena.olech@intel.com,
	joshua.a.hay@intel.com
Subject: Re: [net-next,08/10] idpf: generalize send virtchnl message API
Date: Sat, 17 Jan 2026 18:28:03 -0800
Message-ID: <20260118022803.1106110-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115234749.2365504-9-anthony.l.nguyen@intel.com>
References: <20260115234749.2365504-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
idpf: generalize send virtchnl message API

This patch changes virtchnl send message functions to take adapter and
vport_id instead of vport pointer, allowing these functions to be used
for configuring vport independent queues.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index b937d93117c0..eb4654d3a1ff 100644

[ ... ]

> @@ -2831,8 +2844,9 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
>
>  /**
>   * idpf_send_get_set_rss_lut_msg - Send virtchnl get or set RSS lut message
> - * @vport: virtual port data structure
> + * @adapter: adapter pointer used to send virtchnl message
>   * @rss_data: pointer to RSS key and lut info
> + * @vport_id: vport identifier used while preparing the virtchnl message
>   * @get: flag to set or get RSS look up table
>   *
>   * When rxhash is disabled, RSS LUT will be configured with zeros.  If rxhash
> @@ -2841,18 +2855,20 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
>   *
>   * Return: 0 on success, negative on failure.
>   */
> -int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
> +int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
>  				  struct idpf_rss_data *rss_data,
> -				  bool get)
> +				  u32 vport_id, bool get)
>  {
>  	struct virtchnl2_rss_lut *recv_rl __free(kfree) = NULL;
>  	struct virtchnl2_rss_lut *rl __free(kfree) = NULL;
>  	struct idpf_vc_xn_params xn_params = {};
>  	int buf_size, lut_buf_size;
> +	struct idpf_vport *vport;
>  	ssize_t reply_sz;
>  	bool rxhash_ena;
>  	int i;
>
> +	vport = idpf_vid_to_vport(adapter, vport_id);
>  	rxhash_ena = idpf_is_feature_ena(vport, NETIF_F_RXHASH);

Can vport be NULL here? idpf_vid_to_vport() returns NULL if it cannot
find a matching vport_id, but idpf_is_feature_ena() dereferences
vport->netdev without a NULL check.

Other callers of idpf_vid_to_vport() in this file do check for NULL:

  idpf_mac_filter_async_handler():
      vport = idpf_vid_to_vport(adapter, le32_to_cpu(ma_list->vport_id));
      if (!vport)
          goto invalid_payload;

  idpf_handle_event_link():
      vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
      if (!vport) {
          dev_err_ratelimited(...);
          return;
      }

Should there be a similar NULL check before calling idpf_is_feature_ena()?

