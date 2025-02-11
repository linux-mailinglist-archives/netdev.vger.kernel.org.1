Return-Path: <netdev+bounces-165163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B44A30C0F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081B2164A02
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEE2204873;
	Tue, 11 Feb 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GVRUpMHr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA91320F
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278339; cv=none; b=k/w9X/uC73YPzhowJT6IC0AeUDFjewmnwJhFCQAs97bImdE+drocdi6NB2XvqNE8xSMt74I0o5XR5NUFqN1eAxUwYQaxjnhMd7MoGrGoY2XhuaXXu4RLw6If1p4C3Fzu5NU8ueSs6aguZjGGkLWQFfSHUC4mje+b7W12S7JeBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278339; c=relaxed/simple;
	bh=WqLOLy5mUvobhRzKx4TPnxznJ4033QIMQHZPrhg77mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF5sx3xPPClDlho9MqeVvqb8VVkxGfeAugv8I1UVoqRdUyJd65Vzk2NfC0Nu9lu1KBjaJ8PQuKvwHaAbl1EU2J8C+Q9hS524/RR1bvy4UO8scdQbClbWdVlfSdLSOrqFHlwvjkmF1xEIqG/8iBetA0trdvcCZZz7XpDg2l+rWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GVRUpMHr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7c81b8681so302604666b.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739278335; x=1739883135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCr8lXF/hbS3Bl/Vc5QzdufqxupTokIoSkungD9SWpM=;
        b=GVRUpMHrOzmKc68aMewCzctvcJaBvORN+kvpmOdqi19fn1kM7zFKQk51pKxZuUVhS5
         un5Ptx5MZuzZ0mUiYJojQbopgjespzmPk3ixZyqPEI6wjNNttXzXao1YPLuYIjPpte49
         yrfqBOkTAiXMaINhwack6FDVvTfycS65C/TL4CZl43m2OeRkEJQ17GMW5vMTHlFcDXRr
         AAEAdRqL3yVC6Kjx7Xoh0Zz1PD5Kwhevv1jEqeDfGFwiq8UQ5BDwFADyaoXNJJXDyyJT
         QpuOkXh4mP4pGAlJHQceQ2VxyV2RifHcm1YFGPwqZ1wIOYRpbrZU/93eTO9eXBSdFwT+
         N/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739278335; x=1739883135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCr8lXF/hbS3Bl/Vc5QzdufqxupTokIoSkungD9SWpM=;
        b=swUeyH9MD0etr8t5LlPqSzz0e+sprLXbZfONwVRndwCCQxW6EqmbRDEMsPSGUi77BJ
         Z64oBlQaLdrhYmtvF17LETP3+e0TOsUp4l7cPI99ABS++pyYr+Xu0/JY0m2WihQ4jvjt
         PAfJoQrwB2XTZY4PrGDso3r+J8i8fA6yQwGOjVdYAYYSY5N3YAMIT+BqtkZeue1VxFFy
         dS+fBgNT6pqSO0G9t6FE8JYkC0uTVE1Iq8kj4gkvMrOfJolH60Wq/CgDZmoC/Cq8b0RI
         lMpM89g/Nab7THg2ojs0vD/bkEBNn7taaoGW/1wCqdmSkEkzRdI4iPeMJCuKWoPU27oj
         QadA==
X-Forwarded-Encrypted: i=1; AJvYcCVOybjZaY6FuyoG7SyK5YWRHzOpyIaD4gQ/iIwpZvElZ7qLh5rlDpZ0KoIQGDZKF6Ey7feZspQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGPvS6DpSM3laXmjhgKEmmD9UT+PS8tbyEbkI7hUTs85wQ3hx
	8erSjTRxYpx5WbHeg6dvOPjWQygCRTgno2NvV+X7q9zASQ0/5O6fwONb+/Puz0I=
X-Gm-Gg: ASbGncugHwGU435xvIOPS8ZfTypi+gab2esB8tszvMB0SWzP35nMVjQp50fhlL39h27
	nRcYORGLjLHAfBdmEu0ozrKbs6+FwjT21SMaLGfl2lpn9fH0faA+PD0cpOGz6w4Vq6vLJ+JGvIl
	EgvafK1EPeuCqDwg6UVCwRMp3kEwD1uRST0XrrzfXHOKwk3hW3ote6r1RxLz9HexKSjCCtJBTDS
	C+xgoYy1II4ebvxTEBnSSUaFJw2njDFGCb87yoom5U8NDsvi/sNx3r31eS/KHBIPX764TP5vVBv
	a5Y7tClXoNRYD1vZDg==
X-Google-Smtp-Source: AGHT+IE4VyuPVp0UmYtC0pWJM7Vcx/DWM3Q0lMkR7wfSfq/0GBBnfO4yFhMT4NUzE/bzg6LlMtcFDQ==
X-Received: by 2002:a17:906:c109:b0:ab7:4262:686b with SMTP id a640c23a62f3a-ab7da4be58dmr352557666b.40.1739278334563;
        Tue, 11 Feb 2025 04:52:14 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b5d8d4a0sm508918466b.159.2025.02.11.04.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:52:14 -0800 (PST)
Date: Tue, 11 Feb 2025 13:52:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"horms@kernel.org" <horms@kernel.org>, "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 02/13] ixgbe: add handler for devlink
 .info_get()
Message-ID: <qmjitflm2k3zo5yiym74c6okjg5skzhb46evfhn6qpzkwch3uc@epvkzeg37n3f>
References: <20250210135639.68674-1-jedrzej.jagielski@intel.com>
 <20250210135639.68674-3-jedrzej.jagielski@intel.com>
 <bxi2icjzf37njzl4q5euu6bbrvbfu2c557dksqtigtegxcnowo@yyfke6ocrtpf>
 <DS0PR11MB7785B1EF702ED5536D4B4CCBF0FD2@DS0PR11MB7785.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7785B1EF702ED5536D4B4CCBF0FD2@DS0PR11MB7785.namprd11.prod.outlook.com>

Tue, Feb 11, 2025 at 01:12:12PM +0100, jedrzej.jagielski@intel.com wrote:
>From: Jiri Pirko <jiri@resnulli.us> 
>Sent: Monday, February 10, 2025 5:26 PM
>>Mon, Feb 10, 2025 at 02:56:28PM +0100, jedrzej.jagielski@intel.com wrote:
>>
>>[...]
>>
>>>+enum ixgbe_devlink_version_type {
>>>+	IXGBE_DL_VERSION_FIXED,
>>>+	IXGBE_DL_VERSION_RUNNING,
>>>+};
>>>+
>>>+static int ixgbe_devlink_info_put(struct devlink_info_req *req,
>>>+				  enum ixgbe_devlink_version_type type,
>>>+				  const char *key, const char *value)
>>
>>I may be missing something, but what's the benefit of having this helper
>>instead of calling directly devlink_info_version_*_put()?
>
>ixgbe devlink .info_get() supports various adapters across ixgbe portfolio which
>have various sets of version types - some version types are not applicable
>for some of the adapters - so we want just to check if it's *not empty.*
>
>If so then we don't want to create such entry at all so avoid calling
>devlink_info_version_*_put() in this case.
>Putting value check prior each calling of devlink_info_version_*_put()
>would provide quite a code redundancy and would look not so good imho.
>
>Me and Przemek are not fully convinced by adding such additional
>layer of abstraction but we defineltly need this value check to not
>print empty type or get error and return from the function.
>
>Another solution would be to add such check to devlink function.

That sounds fine to me. Someone else may find this handy as well.


>
>>
>>
>>
>>>+{
>>>+	if (!*value)
>>>+		return 0;
>>>+
>>>+	switch (type) {
>>>+	case IXGBE_DL_VERSION_FIXED:
>>>+		return devlink_info_version_fixed_put(req, key, value);
>>>+	case IXGBE_DL_VERSION_RUNNING:
>>>+		return devlink_info_version_running_put(req, key, value);
>>>+	}
>>>+
>>>+	return 0;
>>>+}
>>>+
>>
>>[...]
>>
>>
>>>+static int ixgbe_devlink_info_get(struct devlink *devlink,
>>>+				  struct devlink_info_req *req,
>>>+				  struct netlink_ext_ack *extack)
>>>+{
>>>+	struct ixgbe_devlink_priv *devlink_private = devlink_priv(devlink);
>>>+	struct ixgbe_adapter *adapter = devlink_private->adapter;
>>>+	struct ixgbe_hw *hw = &adapter->hw;
>>>+	struct ixgbe_info_ctx *ctx;
>>>+	int err;
>>>+
>>>+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
>>>+	if (!ctx)
>>>+		return -ENOMEM;
>>>+
>>>+	ixgbe_info_get_dsn(adapter, ctx);
>>>+	err = devlink_info_serial_number_put(req, ctx->buf);
>>>+	if (err)
>>>+		goto free_ctx;
>>>+
>>>+	ixgbe_info_nvm_ver(adapter, ctx);
>>>+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
>>>+				     DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
>>>+				     ctx->buf);
>>>+	if (err)
>>>+		goto free_ctx;
>>>+
>>>+	ixgbe_info_eetrack(adapter, ctx);
>>>+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
>>>+				     DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
>>>+				     ctx->buf);
>>>+	if (err)
>>>+		goto free_ctx;
>>>+
>>>+	err = ixgbe_read_pba_string_generic(hw, ctx->buf, sizeof(ctx->buf));
>>>+	if (err)
>>>+		goto free_ctx;
>>>+
>>>+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_FIXED,
>>>+				     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
>>>+				     ctx->buf);
>>>+free_ctx:
>>>+	kfree(ctx);
>>>+	return err;
>>>+}
>>>+
>>> static const struct devlink_ops ixgbe_devlink_ops = {
>>>+	.info_get = ixgbe_devlink_info_get,
>>> };
>>> 
>>> /**
>>>-- 
>>>2.31.1
>>>
>>>

