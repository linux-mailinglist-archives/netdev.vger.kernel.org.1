Return-Path: <netdev+bounces-164811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE31A2F367
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5021881725
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409A62580E0;
	Mon, 10 Feb 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IfB83f2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5B22580C8
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204773; cv=none; b=gYCtdRPb/X4uSJEOXZsI1asoXQUTHuUjY/fVXyaFguWtkq4gVJBlslModZ5C70uEsphwMuqnBs9GQk7lam8D61Wd4beQHucaBj29SuNuN+T58V14zDptyUyxaU5P7HDet/tAFuLnVkAodTlpvOxvdlUHoxeQ2iXbFeKc7jTEi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204773; c=relaxed/simple;
	bh=NL0DVKSH5yWp4vGYT3/3vIVUBK/XtKpwy5kbyvNhHAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPwFKQoq95WRMHFB350Vytqi4XEeEaw01CqlVi7hR6i2gY7wiWf9mmUhIbaUek6glyF/xXuH5O8YFEJMX7pXFf3N6wTix5tG5Hp2S7DmaA7qDsX5tXPui/wayKqRJz0yBFLa6EA7pPS9JZrzZkCBISA1oKnDWJ1lz8M/vqLXWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IfB83f2v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4393f6a2c1bso8539515e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739204769; x=1739809569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+X7ZGXGJrlpJ8WltnoHRQdxOU9YpHfT8O3Sz64MlsdI=;
        b=IfB83f2vLnA+71X4W9FTC1jmUS/liTExkGfl0GzSoZ++G2TjRD/VuRiTXitNnqwfss
         pKSRpi+tpcq3ZuH9rqBgIYuw1YBsTJygw3r/aa/WJoEkXoYtDj+/lLYY8yefVnBDoyDP
         TQlqq3iVnkHr9gnsnI/QsVRf2BU6zffyGfs4Tei1V+crkXf85seSgdnSzr02NIBQru8o
         4mNQk6rSQmuN9E5YiOXRLhs+uqgvxISSljdnUZWdrh3GWuF0QZlmxYnyqlxRbzPBoGpO
         gSfkPv6D0gilNCM7HhyikTVsXYBuHEFnaYa7GtFraWBVDbhhlcwKVOqGBHQvHEUz3pgA
         bBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204769; x=1739809569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X7ZGXGJrlpJ8WltnoHRQdxOU9YpHfT8O3Sz64MlsdI=;
        b=aOdWa9cAy1kQcPk8rAZEA1jjs1Jkv94hIBhkiBbsS7Z5KsgCt7b0hYYP0RcOf18maz
         mHtUjSvkRSnVOh4+0C/ByzPKKxAFNQkxqw+skAuQazeRt1Plv/Nsurzm9N1g2qqMYano
         FOBHiRnRq1VBZUBrirlxLc4Av677LBEa+NdaSf8qTSRJ9Uzgsqe1DwgGutdYq2jaNxxL
         ZVbjf6oIWblh+XJksrl8rr9+CdRDRzTjHYTflT5k3LKWpSxthLwSQw5jZIGWhK4hE81y
         tMVc8/RWLhQ7jXulblMif15e5DQlMS/4Jl/vZgFo1EivAqZcFJbI6T0+ofTUybbLTFJF
         6qBg==
X-Forwarded-Encrypted: i=1; AJvYcCXcBerh4Sb0xC5wOO3HuzcKurgxlZ6ts/ZCyn1eBv+5Gi5sgv9hgMVg2Z0m5s1k2ZrgCCnZiLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5pJSf1hbcDzYT30a36QvHutWzU4+N6FKH0hMhC+8Hpu6wnJ+
	EVL6yNpcZu1TG5vtbB8fI3e/2C69RVRXI5c6ldinVk+sa+7picCnvPKcUSBh3Wk=
X-Gm-Gg: ASbGnctMtp6vZ1Ne/RsSaKlRGenrIG4jTmFY0XptcZMAbDDIjzu8pzLgaBibrtENUKg
	Ql0SiHrsQxgzMrv3OBk0zWTgIWUtt8OCodVCEoK1yUatTtrqsZRCURw4VGLt4gbPrSz+0vuLTgZ
	hhvDJWuyw/oT6ezY4Q02vqx0YLSCz+kVpaMCiAo7Tyopo4Yv1LUKA/yDRfftQuyH4E3h7q1EU53
	mm4JjoP2Sz1AzLAWtlYkTjXtV4J7xH5rADGXvuUlRfHieBBljiXAGQpCh9OcaUr690LstYHLpDf
	zLLbcvdZC5Y7FBFo2aEG2K8=
X-Google-Smtp-Source: AGHT+IHRDxNCbQj43cKRpu4vnQK3m/lk4rd2euiC+kdgvVEN30tlHtPWOFuoJ9lKVnMxytY4+hv9zA==
X-Received: by 2002:a05:600c:3c96:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-439255b81e1mr106884955e9.11.1739204769357;
        Mon, 10 Feb 2025 08:26:09 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf2ed900sm12548261f8f.53.2025.02.10.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:26:08 -0800 (PST)
Date: Mon, 10 Feb 2025 17:26:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, horms@kernel.org, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v2 02/13] ixgbe: add handler for devlink
 .info_get()
Message-ID: <bxi2icjzf37njzl4q5euu6bbrvbfu2c557dksqtigtegxcnowo@yyfke6ocrtpf>
References: <20250210135639.68674-1-jedrzej.jagielski@intel.com>
 <20250210135639.68674-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210135639.68674-3-jedrzej.jagielski@intel.com>

Mon, Feb 10, 2025 at 02:56:28PM +0100, jedrzej.jagielski@intel.com wrote:

[...]

>+enum ixgbe_devlink_version_type {
>+	IXGBE_DL_VERSION_FIXED,
>+	IXGBE_DL_VERSION_RUNNING,
>+};
>+
>+static int ixgbe_devlink_info_put(struct devlink_info_req *req,
>+				  enum ixgbe_devlink_version_type type,
>+				  const char *key, const char *value)

I may be missing something, but what's the benefit of having this helper
instead of calling directly devlink_info_version_*_put()?



>+{
>+	if (!*value)
>+		return 0;
>+
>+	switch (type) {
>+	case IXGBE_DL_VERSION_FIXED:
>+		return devlink_info_version_fixed_put(req, key, value);
>+	case IXGBE_DL_VERSION_RUNNING:
>+		return devlink_info_version_running_put(req, key, value);
>+	}
>+
>+	return 0;
>+}
>+

[...]


>+static int ixgbe_devlink_info_get(struct devlink *devlink,
>+				  struct devlink_info_req *req,
>+				  struct netlink_ext_ack *extack)
>+{
>+	struct ixgbe_devlink_priv *devlink_private = devlink_priv(devlink);
>+	struct ixgbe_adapter *adapter = devlink_private->adapter;
>+	struct ixgbe_hw *hw = &adapter->hw;
>+	struct ixgbe_info_ctx *ctx;
>+	int err;
>+
>+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
>+	if (!ctx)
>+		return -ENOMEM;
>+
>+	ixgbe_info_get_dsn(adapter, ctx);
>+	err = devlink_info_serial_number_put(req, ctx->buf);
>+	if (err)
>+		goto free_ctx;
>+
>+	ixgbe_info_nvm_ver(adapter, ctx);
>+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
>+				     DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
>+				     ctx->buf);
>+	if (err)
>+		goto free_ctx;
>+
>+	ixgbe_info_eetrack(adapter, ctx);
>+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
>+				     DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
>+				     ctx->buf);
>+	if (err)
>+		goto free_ctx;
>+
>+	err = ixgbe_read_pba_string_generic(hw, ctx->buf, sizeof(ctx->buf));
>+	if (err)
>+		goto free_ctx;
>+
>+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_FIXED,
>+				     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
>+				     ctx->buf);
>+free_ctx:
>+	kfree(ctx);
>+	return err;
>+}
>+
> static const struct devlink_ops ixgbe_devlink_ops = {
>+	.info_get = ixgbe_devlink_info_get,
> };
> 
> /**
>-- 
>2.31.1
>
>

