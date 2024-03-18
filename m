Return-Path: <netdev+bounces-80307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B801F87E486
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BB3281B08
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A0250F8;
	Mon, 18 Mar 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1suSZoZv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF524205
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748713; cv=none; b=r2ld2IJpDQHM5sO0VSYFPrK6hnUC0SmALcX4EQp7skP+LhT07grlDoxSoQnQpS0A9cnziQclZsKdYKtGfxN/w7JV8vLNZcxfxR9X8fJ7yM57ug+oKfkPFoJNADfE3Lqot+sz7pH5Ov1aPo/HdPjZBsWyCfp47E8IykO3bgmaUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748713; c=relaxed/simple;
	bh=Rwbfbr4xpCzbJo5lfXzHH+e0tkxmDYO339WGIBLlf8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or6HcY8kIigl6kAy/Ccpt/53uG43DRBTUBygK41NX1HPFW8r3+cO9R/sWDNlu27zeeEu9S+6y84+IwTU1cJwS3JjzpOkmmGBF6kps64IfI9RK68tlYyeZ6TEk/0xgx9TlilxUUpq6l8VE+nfOFqGAZs+DPfIghfNwzGYQS9BcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1suSZoZv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4140816539fso12117265e9.3
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710748709; x=1711353509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GwzYgLHWUfhc1x+WR7je+vcMavz3AUg10dsKbhVc4bM=;
        b=1suSZoZvk54EFK21P7rVyTSAjnUwOIU3AgHbvpG5nCq5PAOPNicRLcs2llU9v/Zq7N
         wj7/IbUPM3dd+0MfF1cVgrTb6cCcAyMspqkM0TFEbQrDoj6ZFfpixFCagYpZ24Ujr9WP
         veb3m1LD5qpuToLO/8rxbgSqyOzIgJW53Co1e4m6QCW97E4a1e0uf+I5bN/oxw0pO6Z5
         6NDvcQPHUk8mfAc5g9NgTPTa6WAkucWf4foDcmCZm713tZqrVoTu3b2mLHyYKcryiNSd
         BBB+AdYnMS0cgfmakI/3qElHmGprhWpWsCucrYlpcd0Nb3shkwo/ul/n+Wy1g9bs9Bxy
         ctSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748709; x=1711353509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwzYgLHWUfhc1x+WR7je+vcMavz3AUg10dsKbhVc4bM=;
        b=PMQPfyA31sxx1JNIB21iub9t0xfl1GU0WZQA6qfwoptZ2IO3R3+IxcHtc3EEqt/huS
         h0t4AJTsMdKigu5ZsmRjY1JI3oCipyP8IF1O+mXkMytAsLfeRDGmn+b8rdXiCIjloMwo
         95sR+v8c23xNl4G3QrC6GgP2d9qfC2uyTPj3tmsmc7yejrgAPG3y2umQ8BM4MqOZDHfo
         kfen0lptZQxexTixr7jm3buhlUoY8FuPGpfXz4HGmk1LjT4dm1xwl9pjUzeggpzwnUPh
         xcbWiqhLmLO5BX/ruGYpdoU8IlLKDej9Nv7JrnOMkQvRJg8NhIp5HnUY6NmiSZuhleDH
         h4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVby/8zSx1srq17DMTBwFJoFsbPk91dzSGY3raaZCIlWkARPhkC+9fQ/Ul58wBeUsLaGvLfCIyaEN9+iljlPu2R6vvj/x5K
X-Gm-Message-State: AOJu0YyVwMd9KLb5prMVgqxb3e4TberpOAHNLGaR4SGlF/M2B1KS+/jw
	HZOVFhZDMK8rZeebKWSCnHjR+92w0YWxc+Te11hzjS/n0BQGSRtrv1xCtluZorQ=
X-Google-Smtp-Source: AGHT+IGP63gK84RwsrLYUjc1GyJx9V566JyM8XZbpPWkA0VR1WtYdjl0H6jWrjiu2X2wyPbyn8sBsQ==
X-Received: by 2002:a05:600c:19c7:b0:413:f034:a4ae with SMTP id u7-20020a05600c19c700b00413f034a4aemr9076763wmq.4.1710748708639;
        Mon, 18 Mar 2024 00:58:28 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00413f3b16a26sm13358369wmq.35.2024.03.18.00.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 00:58:28 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:58:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <Zff0IO6nqpMiGXl5@nanopsycho>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>

Sat, Mar 16, 2024 at 10:44:40AM CET, dan.carpenter@linaro.org wrote:
>Automatically cleaned up pointers need to be initialized before exiting
>their scope.  In this case, they need to be initialized to NULL before
>any return statement.
>
>Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>---
> drivers/net/ethernet/intel/ice/ice_common.c  | 4 ++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>index 4d8111aeb0ff..4b27d2bc2912 100644
>--- a/drivers/net/ethernet/intel/ice/ice_common.c
>+++ b/drivers/net/ethernet/intel/ice/ice_common.c
>@@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
>  */
> int ice_init_hw(struct ice_hw *hw)
> {
>-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
>-	void *mac_buf __free(kfree);
>+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
>+	void *mac_buf __free(kfree) = NULL;
> 	u16 mac_buf_len;
> 	int status;
> 

How about similar issues in:
ice_set_fc()
ice_cfg_phy_fec()
?


>diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>index 255a9c8151b4..78b833b3e1d7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>@@ -941,11 +941,11 @@ static u64 ice_loopback_test(struct net_device *netdev)
> 	struct ice_netdev_priv *np = netdev_priv(netdev);
> 	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
> 	struct ice_pf *pf = orig_vsi->back;
>+	u8 *tx_frame __free(kfree) = NULL;
> 	u8 broadcast[ETH_ALEN], ret = 0;
> 	int num_frames, valid_frames;
> 	struct ice_tx_ring *tx_ring;
> 	struct ice_rx_ring *rx_ring;
>-	u8 *tx_frame __free(kfree);
> 	int i;
> 
> 	netdev_info(netdev, "loopback test\n");
>-- 
>2.43.0
>
>

