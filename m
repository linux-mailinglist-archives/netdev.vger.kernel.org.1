Return-Path: <netdev+bounces-75295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7C486909D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E06FB27EC0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BC1E86F;
	Tue, 27 Feb 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jH+ZojHV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB83846C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037114; cv=none; b=PkID3U7SQ+DfFbLdik6Y2VEpAKrxP81gUVL+2Gd+TdMfQaZh5PCU8/j2V2j3L9BQWCCjEad2DdF0/MvMoJub6rinLX6T7cTPMt7n8M+S33NcFtQIeuU6UKJG9tuhdeceq8gS3U9bb3mQUT5Ujr606eVxOwbFQDKv4BRK3sGVha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037114; c=relaxed/simple;
	bh=K9jTK+gwFpZ/t9tw/H/cLQ7Nt7k0xy/cWsiM567IxjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDgL+nHJPqnEf1fQrL1rACkP8Ko037zr3Agjd8pxHHPNxL8jeYth7eegeds4VN6NJLFrsjyTXsVRrDxl7ohYl5Nt9SwC+4xppCoW9xZsa9NjyRWkky2daGQigKZid79ur+A/QInWj41f+wJ0K5m/qCSVdinLUQ9Zz7jz4DSdlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jH+ZojHV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a588c8b4so13615885e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709037110; x=1709641910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RI6P42SnA/6FSWlxUyOirpdPJCoQ4PZGDfL1s46uPEI=;
        b=jH+ZojHVgjUzQWk3VNLlxxOTyJdYF42IyvUfvcblT3ZPU8x23OOQod3uexlDepT20A
         2Mv81RYZAtRRbXwuoImKTmGJXSit8Tesh8NM4kuv2P9CwOIRMq5UpGoI8lPcdGGZi3Xy
         ehYxbwL9e1V6pwC8TaW4E9EGRE9RKQfsrTcdEnOQm9XYrGvOrHl+WtzT9zYx2MYsPqpH
         ZlOnQ+nSn/JI0ho2wuY19/x42MOIeNKtouvuDe4+t3EF8Q8DAyi4DkRI4OuW6X0Uuy/f
         aYe2SPohY+l8QAzaM1rKgI7JGNdR5pqxaWq9PJ7RE3j4y+dooL97QhZg7XcTRR3iJR6h
         8DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037110; x=1709641910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI6P42SnA/6FSWlxUyOirpdPJCoQ4PZGDfL1s46uPEI=;
        b=W01+A/LWPbQ1HdPgmAO1YOKcRFauvo9JUMet25Io87XFY0NBaz/Xg8or3dAmGFYSbT
         xXTaJvdG+ggC07zvvF2+RkivmWg//XoefKab2WxvcadI37V5nWJCC2vDoRcCT3tS51iz
         kpI2yd7qB3N7Ldl7NebhWQ2EanfY1lXOjRwD2ID6t0mlHJI//dksIQE9IMP2IQe1LJhv
         Ec9qJtYcP3HWl6UR3x6jQnOT41sRXJvP5J2GlGIKvxLtMrJlkjL0plcCcoIq+Fn3ml1i
         QcCSQrHKQ2CclxnTBckcDvtz8vW++3VoeXuQ8xwls5+k3VdshhU1Xw05FptWSZxKrwjX
         PX/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJo8KUb3J8NnPoFMO26p5be2G2uBNgtNMW6pxkAzMW9iSdgT09MsazsK6fvPoX9RRiHz41SXd4w3Ff0+v6hhinzuKDTUAw
X-Gm-Message-State: AOJu0YwVFGyftW6JiUcifCCde8Db9AlLA3lpqRCBNLfUxBYogUNUOqng
	gJ12sPlzqWOlThkhS2iVCLUxBURk56qwGYjlNsF+88HocyjE7Ie6zUpwRQEuoKc=
X-Google-Smtp-Source: AGHT+IGNzpLnKWp27jVkI9Glbfnbr7HsiylOooIbx/lqyk+RI/FV6UbgzDzdxfN0AqM5ed+nPK2ccA==
X-Received: by 2002:a05:600c:4f95:b0:412:8fef:7f with SMTP id n21-20020a05600c4f9500b004128fef007fmr7840108wmq.1.1709037110120;
        Tue, 27 Feb 2024 04:31:50 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a9-20020a05600c348900b00412ada8a4ccsm1584923wmq.14.2024.02.27.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:31:49 -0800 (PST)
Date: Tue, 27 Feb 2024 13:31:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
	lucien.xin@gmail.com, edwin.peer@broadcom.com, amcohen@nvidia.com,
	pctammela@mojatatu.com, liuhangbin@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS
 writing back
Message-ID: <Zd3WMs8-nw5SPTZE@nanopsycho>
References: <20240227121128.608110-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227121128.608110-1-linma@zju.edu.cn>

Tue, Feb 27, 2024 at 01:11:28PM CET, linma@zju.edu.cn wrote:
>In the commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
>IFLA_BRIDGE_MODE length"), an adjustment was made to the old loop logic
>in the function `rtnl_bridge_setlink` to enable the loop to also check
>the length of the IFLA_BRIDGE_MODE attribute. However, this adjustment
>removed the `break` statement and led to an error logic of the flags
>writing back at the end of this function.
>
>if (have_flags)
>    memcpy(nla_data(attr), &flags, sizeof(flags));
>    // attr should point to IFLA_BRIDGE_FLAGS NLA !!!
>
>Before the mentioned commit, the `attr` is granted to be IFLA_BRIDGE_FLAGS.
>However, this is not necessarily true fow now as the updated loop will let
>the attr point to the last NLA, even an invalid NLA which could cause
>overflow writes.
>
>This patch introduces a new variable `br_flag` to save the NLA pointer
>that points to IFLA_BRIDGE_FLAGS and uses it to resolve the mentioned
>error logic.
>
>Fixes: d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length")
>Signed-off-by: Lin Ma <linma@zju.edu.cn>
>---
>v1 -> v2: rename the br_flag to br_flags_attr which offers better
>          description suggested by Nikolay.

https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html?highlight=network#tl-dr

"don't repost your patches within one 24h period"

