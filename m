Return-Path: <netdev+bounces-145005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED99C9151
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942A5B28FD2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890EB185B78;
	Thu, 14 Nov 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5GRYKqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0131C683
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605336; cv=none; b=DmbVJPCnctfmCAmRX0X1Kzk4HBrhx9w1YFnlah2PGs/yOfNsLD2bXfQ3oCeHIA1IgTQECdcyBrqEK1PcJDpDEN1OukssLwFC7fCALvRWVi42zSTmkAZDxqCyop6Gipm4DBHX5mXHp2KsfnFNq0FxBO7Q3k0Z2cl11j5dZrfEUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605336; c=relaxed/simple;
	bh=hetvMReEb2DzX2icclrVitYiumtitx8D/W+eGD9a9LE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wm2QpXYiaQajQqwNv4t+/gs5S+3YFbkyr6x0YlrtTle+9gy9vhOCmKHVi6gZYN8AfFoIiPZTBrsvk3Y/+S3e1u2dyjYFxfDig0Ys2BCB+1Kl1UTL3qLoxpRvJvroDr4hsDVe3ErlbcbovkE1YrCMYQresst51VpQrXaZb9nMfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5GRYKqO; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ee9e209bb6so450055eaf.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731605334; x=1732210134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEF9eU09+Qb6BvC7qtMI4fadvfmR1JOTug6j8w0vouk=;
        b=g5GRYKqO1YKAchSkZ9NeWi4z+qsPogAG6lohJZsgo/KTENh9NvqFvsn577DiJ1nQu1
         ms18vEyldBSLnKaolf8LWu82hzPS4tLNJ2iPeHJSZXhqg2sJHNrGjRe65vmv2plUcr+S
         EqJYZArUEuyEVZDa1NiH9+M9q9hyTkSQnFkh6O3bnPpdEdZRdOBm1SELL/DjYmXymh+r
         R3OB8fV8qLtRcrfhwiDTw6WrNdjOrb7TXTzAz/9wzZNzgDt3QV1fWUGmH4X8w+OwiWK2
         19pcSv6c4E4Kf8U0PZWqq/StDrAMpn87LPbQf2fRIToCy4nAywiUQMtCyOeXld0Tw9MI
         vSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731605334; x=1732210134;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EEF9eU09+Qb6BvC7qtMI4fadvfmR1JOTug6j8w0vouk=;
        b=KLlEeTuPH0l3MxkyJahkstsf0lNwGywojWhBPZCqFUYMqJr4RkV/tI+dG2r02HTm+O
         b+HebcQgphPqvjuBkf8vbLdLiYRdo+Us24az51dIqM8zUkya4vbhGonV8wc0O/6fd8dK
         X4NuwrEtU0vjd09HihNwH2NuOwZ2QywFO1MFlUSTN4+H5Jdj/StS4ulJROlGk4oRPkBn
         rxHaEyzJ5+n0YDXYNu/QuJsnl5JDC45MHMLYwxxgxhuosMAb1q78AeFFovJfHx7449eq
         fBQJo1Tn8IH5Aa7PSzaTTLed6ZgoFyk63ipnTM/Z9SBBTzYYcFmOwLOetdfx8S0QTtvk
         gLcA==
X-Gm-Message-State: AOJu0YzSKr4QyUwJR7I/4AP6JZw2Q5ud+FOqwkAhFCZJFOtWYCzuwzG9
	3OwCAxcjIm3MZMPFnZHZWVWsO/a7woE3BtXjUfNbfxNxsRkJauRm
X-Google-Smtp-Source: AGHT+IEO+viR92ZpwLR8rpkElqcZ3pZfjGvNKa05dgUWoumsIJYl0GTK81WtP6mzGleOLzmwUIWJMg==
X-Received: by 2002:a05:6358:5bc9:b0:1c6:99d:b832 with SMTP id e5c5f4694b2df-1c641ea6f9emr1347568655d.8.1731605333726;
        Thu, 14 Nov 2024 09:28:53 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee8c3d25sm7734416d6.74.2024.11.14.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:28:53 -0800 (PST)
Date: Thu, 14 Nov 2024 12:28:52 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <67363354c7ade_3244ed2943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-3-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-3-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 02/10] virtchnl: add PTP virtchnl definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> PTP capabilities are negotiated using virtchnl commands. There are two
> available modes of the PTP support: direct and mailbox. When the direct
> access to PTP resources is negotiated, virtchnl messages returns a set
> of registers that allow read/write directly. When the mailbox access to
> PTP resources is negotiated, virtchnl messages are used to access
> PTP clock and to read the timestamp values.
> 
> Virtchnl API covers both modes and exposes a set of PTP capabilities.
> 
> Using virtchnl API, the driver recognizes also HW abilities - maximum
> adjustment of the clock and the basic increment value.
> 
> Additionally, API allows to configure the secondary mailbox, dedicated
> exclusively for PTP purposes.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

minor issue, with that addressed

Reviewed-by: Willem de Bruijn <willemb@google.com>


> +/**
> + * struct virtchnl2_ptp_set_dev_clk_time: Associated with message
> + *					  VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME.
> + * @dev_time_ns: Device time value expressed in nanoseconds to set
> + *
> + * PF/VF sends this message to set the time of the main timer.
> + */
> +struct virtchnl2_ptp_set_dev_clk_time {
> +	__le64 dev_time_ns;
> +};
> +VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_set_dev_clk_time);
> +
> +/**
> + * struct virtchnl2_ptp_set_dev_clk_time: Associated with message
> + *					  VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE.

minor: virtchnl2_ptp_adj_dev_clk_fine

> + * @incval: Source timer increment value per clock cycle
> + *
> + * PF/VF sends this message to adjust the frequency of the main timer by the
> + * indicated scaled ppm.
> + */
> +struct virtchnl2_ptp_adj_dev_clk_fine {
> +	__le64 incval;
> +};
> +VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_adj_dev_clk_fine);

