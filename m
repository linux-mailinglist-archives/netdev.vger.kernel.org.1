Return-Path: <netdev+bounces-67189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E716A842480
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46BD2878F9
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715BF67E83;
	Tue, 30 Jan 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xXgJkNgr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915F679F1
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616518; cv=none; b=O2Y6+Ey43Yh5dN9Q5cS8ujJMkzVeJIs0swywD39UbGvccFdxHV1V/NCLzAmzSxPk8ZOEv2RG/zMSxcjX1rAQsID7UtEf7N3825P/Vm1yupfn6ezfMFYCg1LJhhIn7/7b0g8sN4aLOSyrNp+NNFzGfmiQMNPsFRmGwhLG48H+LkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616518; c=relaxed/simple;
	bh=dzNDL+qAo7D2KJYg1ireH3MtWbsttPVCj5Fm7HViC4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9r/rl1dovbC8O1DQZv9kdtT0a18ReKn/t+gZjU0rmqL79We6O87bRXTXzVXn8IDcCzKv8HH34UhlJaKU459j7tjzrHsMGCIhIIi59PyLSTgRdpH4gAl0iBAEcp2NBfNASCdMag/w9/diKTGJt2S/QNPir9dJPmDq3oljyPISAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xXgJkNgr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so41976345e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 04:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706616515; x=1707221315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2ZiOO1/c1M5r7o9ZTb7/4eFg1YbgJJlQjyOekNcGnM=;
        b=xXgJkNgrTKNq9PeAD29p43Hoob9sQWwgaSPhbtI9HYH4+16cPJOmIWiHLaynbygJxn
         Ks/ajjla80TBzv3FsZXjNtfa+FyJlOfkYV9rTRIOAkmn2Q05mXouA4D1AH9xMQvo3VO4
         sZWSGw9Rh3qtDMwQMMXXx8Ia+hNzuVcqG3C+NSMooPuqQp/X8J/Hs+4xs81hnWMvV4mj
         onBLbramuqDYTVwaI7hywFhsnrz0Qzull+XXY538Xtv6NlL+MevMjPgTyFAdgrRP+xyK
         OAT6dnXyOK2T3CxDH2vae/pAkfgZm1YSy4XjYqtXtf0G3I8XuoYOD2KpFnjbDVZN1Jqw
         LkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616515; x=1707221315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2ZiOO1/c1M5r7o9ZTb7/4eFg1YbgJJlQjyOekNcGnM=;
        b=eEQkPYSx99pi50X7etHOtscC+SU/b98CoWC87v+j+pfbP78N5ESLP2hTidFuZPf1sI
         2GJj4b5MKdX9uPgdNM6Tx7dIlQc2aSkebU+R2KDOJqZHvW7YyGaFhcO1FJpqm56Aw5uS
         ddyU+sa1S+azzcC6Tsqax/hAFRqbN1IyzXpsu7We0ViL4fzxoRL1DOMUdOhuXG0GaXjQ
         Emj8GCYSrErS6eVPH20pTxkpnBqUpX4JZt19JEy7QY/HxMeL9/Kk/MwDeWZTsMNYd0FQ
         VoMiewcvVKSYwdNEM3NCH1bmYk7hwRiCdCBCowlcOooU6BoAfruNLLshIDId+pxc2Q4U
         ZLwA==
X-Gm-Message-State: AOJu0YxvpQMwhdFbWzn17JWOQ8qOMpI06cgyj+HShz/c3o8TdVc/0HcN
	t5j+VBVBTwH0baRWeF9izhdKf9ZXEg8mVIQCuRQkmCWXB7kV6miyDQdB3FMsR2Zu3C/rJWSdEsT
	Ky+0=
X-Google-Smtp-Source: AGHT+IHcCovDnvIu7AAqjFxceQ+8xDcs1YbWJbSBlEkSRUjIU63weq7IzVBAcRBlQWWAadSs0jpAlg==
X-Received: by 2002:a5d:4fc4:0:b0:33a:e2d3:c3ec with SMTP id h4-20020a5d4fc4000000b0033ae2d3c3ecmr7306986wrw.60.1706616514773;
        Tue, 30 Jan 2024 04:08:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXffAC0gm7oT3z65QGX5y3LdNAysiRTwW7S7jGPDykfbAU35uj5vdlnCb1mHc7MozJD/NM4vBaA+/GzRVvgkXdj36/LZTnTYLwcP2OfL7WZNitoFXP06LEtqsodvc0QKUVf/v17MdrFTqnMksBO3m+o0wBVXAayxCmPxXHUtvMao0myEARkK0+8+3mrRjiwJH9Zms9DDH8hlIS0IJAJzYXUCFraugk2CFZkJZmACsNXcrMICUVAsCoF0ZjSHj2wk5Hn/YGRKV6PtOsV/k7fd0bQsw8qeSLfcIXkOxk7R5Y2rrBsCkxIceCsWriofiJfRJL1sr7maYTHE58OMw9yWSKox+fxjVash0jVrC3bDF1rVG1p6ULk+ijTS6GG8japdon7/gT5LWxEgAl5/GU=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s14-20020adfdb0e000000b0033afce63fd0sm1071636wri.53.2024.01.30.04.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:08:34 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: [patch net-next v2 0/3] dpll: expose lock status error value to user
Date: Tue, 30 Jan 2024 13:08:28 +0100
Message-ID: <20240130120831.261085-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Allow to expose lock status errort value over new DPLL generic netlink
attribute. Extend the lock_status_get() op by new argument to get the
value from the driver. Implement this new argument fill-up
in mlx5 driver.

Jiri Pirko (3):
  dpll: extend uapi by lock status error attribute
  dpll: extend lock_status_get() op by status error and expose to user
  net/mlx5: DPLL, Implement lock status error value

 Documentation/netlink/specs/dpll.yaml         | 39 +++++++++++++++++++
 drivers/dpll/dpll_netlink.c                   |  9 ++++-
 drivers/net/ethernet/intel/ice/ice_dpll.c     |  2 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 32 +++++++++++++--
 drivers/ptp/ptp_ocp.c                         |  9 +++--
 include/linux/dpll.h                          |  1 +
 include/linux/mlx5/mlx5_ifc.h                 |  8 ++++
 include/uapi/linux/dpll.h                     | 30 ++++++++++++++
 8 files changed, 121 insertions(+), 9 deletions(-)

-- 
2.43.0


