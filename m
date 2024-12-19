Return-Path: <netdev+bounces-153202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9699F7286
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B838E164BF6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F034154727;
	Thu, 19 Dec 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1rWt160"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573F1754B;
	Thu, 19 Dec 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734574563; cv=none; b=UdXYwUDxL+tRqy1C+ZKBPvXgru5DQxhiyfA8mE9/w58QD9SNDMy0DYkc0XsaGs89/Em7IRjL10pUpb0hmdgmPaiv2Yqp+pP8WHN6aVFAOKS7kJyNsKzfk/KI6GD1Yx5LT+C/U1DEbKNc6G4Pg5kijdcsP5XUk87o7InyNZOTzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734574563; c=relaxed/simple;
	bh=bLuyOdl5VDekWN399Y4B1zP27tyl5ytXESUZzoVP5F0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0Ee9d+5LsF4Nf83HsuT+VVSNBoS7gcMbVgt/ezfQ0ue1X7iHqDp9KgyDddMav21nni5CtQaJ0/wtbOSrE330rH8wvYgfgVzyk0pFKWWXO24k/rxkjnPjEio/Gp2jcduoDdQgCq48Ri9hC0Uq+X6nL6yJ10pTL2AAJLX7sKQGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1rWt160; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2E9C4CECD;
	Thu, 19 Dec 2024 02:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734574563;
	bh=bLuyOdl5VDekWN399Y4B1zP27tyl5ytXESUZzoVP5F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h1rWt1608d0wFw9yBeoWYCECgFj9mkFu7TF7y/TUuuvecPvf7gpHRZ5utA32CqnQW
	 2P6MFBSUKqp3qDiiGEtoq7bb6QFLppP5Gbb0cq3+nPG9yxpvpE6tUAkyBD0qRwcVCM
	 TnJvGzy0I2REcUEi3FX6gAuWN5GtCVjvqZqXRju9lLnGSGq55CZoTTWWdBFMErTCDa
	 JUC9Z96iHgtupfWL3vWeMkvtT4Y4q2PZAN9I3XXR75vRLpnNMS7mQ90AfX0yl8fnnT
	 CdYTBJycBQr403CUFSO8bsembesxpXJO+KpRlPouWLiNeRVWRKAL9DVsHzZ0NAUTGo
	 w8zCGfVE5Wedw==
Date: Wed, 18 Dec 2024 18:16:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v6 2/9] net: ethtool: add hds_config member in
 ethtool_netdev_state
Message-ID: <20241218181601.4c3c29f7@kernel.org>
In-Reply-To: <20241218144530.2963326-3-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-3-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 14:45:23 +0000 Taehee Yoo wrote:
> When tcp-data-split is UNKNOWN mode, drivers arbitrarily handle it.
> For example, bnxt_en driver automatically enables if at least one of
> LRO/GRO/JUMBO is enabled.
> If tcp-data-split is UNKNOWN and LRO is enabled, a driver returns
> ENABLES of tcp-data-split, not UNKNOWN.
> So, `ethtool -g eth0` shows tcp-data-split is enabled.
> 
> The problem is in the setting situation.
> In the ethnl_set_rings(), it first calls get_ringparam() to get the
> current driver's config.
> At that moment, if driver's tcp-data-split config is UNKNOWN, it returns
> ENABLE if LRO/GRO/JUMBO is enabled.
> Then, it sets values from the user and driver's current config to
> kernel_ethtool_ringparam.
> Last it calls .set_ringparam().
> The driver, especially bnxt_en driver receives
> ETHTOOL_TCP_DATA_SPLIT_ENABLED.
> But it can't distinguish whether it is set by the user or just the
> current config.
> 
> When user updates ring parameter, the new hds_config value is updated
> and current hds_config value is stored to old_hdsconfig.
> Driver's .set_ringparam() callback can distinguish a passed
> tcp-data-split value is came from user explicitly.
> If .set_ringparam() is failed, hds_config is rollbacked immediately.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

