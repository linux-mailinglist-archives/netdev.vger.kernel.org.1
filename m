Return-Path: <netdev+bounces-67501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC3843B2B
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341A028E5D5
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3862A09;
	Wed, 31 Jan 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JqAaibI3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D61633E9
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693518; cv=none; b=cqlKzwF5M8uWIXrnN+N2QOfJY3dMlgi1qMQAFjrYgAqZlxEVS9J6hh0ED79lJWWgM000RAt8UJKFK2J4gLxP3i+Nba9wpryVMLFSKSYpWLa7Q79JZoy686q3YSX9WiR9znhVh0oQv1eBOou/ktBbSMKDMCgjRwz/E5Me0I1zwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693518; c=relaxed/simple;
	bh=R+9kjDdASJlQiUSaJ1qtqMMPuVnse3AC3yDqnG52E+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8W1zWAXmWMFhF/U7sAraVW9N1FHuwSPI5HQlmW4k0xU+T+mI3CTRDjGN2FnlCW7VQMav07w1JWmPpw/u79AlSpGQVte6P/urj3Z2A2evB5aAjC/GKLgR89k0ARjCjGkz5MsZNV6ypGrNB+pxMHCkTxCGXXNOIIOVMFKdo/eJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JqAaibI3; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-40efcb37373so17927325e9.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706693515; x=1707298315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/00Ol+KVe/HYhM8hY+AqjesmG2oIaFGx+gxSe+RPhQ=;
        b=JqAaibI3lYwZOmwGljfFkTaEe+O4grKOUcyRGWFYyb2mijPb7eOMXLHhMcd6KqLbQl
         V4KYfyRfSybplScdU2ncZRi4ow66MbZEAl2ymZ9RnGsb9Zylqexw77wzCnGjfO9TOeId
         5PIvvboEOTq09iaGWVPxsdENBVf80qxzXi2bV6+u/hUL1QP4L1wZh98As4q52plPFocn
         HhCk0+pVHgEil5/xKEyhyBJPTOADz+/KkLipiky6DR7e3yvux371FTP1U6eicS6LEnwe
         Ck+8/XN/1A2szWUcVxo2S0iwIklagkSh34oXt3hHQmnebztGH+a9IfL6NSqzj+VkyUCH
         Ze8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693515; x=1707298315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/00Ol+KVe/HYhM8hY+AqjesmG2oIaFGx+gxSe+RPhQ=;
        b=NXfhRHH7q0qMMeGpN+9e6HprcsQNQXp1ZgdTYqYBcinvMLfch+M5iz+ot9eUN/DOM2
         U7uQugRhlvznxvvdA4xgYBtaU9k6FgfHqM+F5YwrKU1NqEv0H1yNk7fj4oOpO0ujeCI3
         Dazv5bhMDg4jpZ99/0rNmxStn+sxzpdova9gsKOLTacmwrcItoLxl/RctRmWAGbLYO9/
         yekiRebrpll5KYiGge8F4O7j/+DH+U4IoDrH5Q3OEaHWQQcTd+reC/Fm6MSaPfWHnJJc
         wOoyllWp6XDJdJN4XvbN2Ea2uVylxzDV+JJ16NAfejVuNx8dPkjcOcMs8CwnM6xYgGQf
         LPDQ==
X-Gm-Message-State: AOJu0YwmIOMQroyMpjQAKBohThFxG65oYl5d+MOePSLMRuiezgmriSsY
	Ddzeg5YlVobfhUcggvqBsyuy9V9MOjXNTXJQu0uSFBgvuLcyupJU1MQ4hcrAo6E=
X-Google-Smtp-Source: AGHT+IGNUpeG+f2vgskrSoofSqjsat9imE1etgV34L2fVpSbchE86eue2duMmyGqYK/gN2juFr1++A==
X-Received: by 2002:a05:600c:558a:b0:40f:5c3a:bbb0 with SMTP id jp10-20020a05600c558a00b0040f5c3abbb0mr765461wmb.23.1706693515220;
        Wed, 31 Jan 2024 01:31:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXEAnJM6944cn5EwQjdQQqfDs0bmeUh2q6eV7jvdccrd7VHRuwCwTXh+myOqrd68Nn0cgj0iL+8Qf1LhCTPpSCBRFJRYRpLR8usqCuYMjOF5TyWBGbZBRomyTT/Mu0+nDQF68d6cW0tF40lzF41IVMTFBbeQQHShGSmafM8kA/ZT0rfaCpg4MUyslBMa8ZjekYvp7HEg785BaX/RntWcJKJm1SVtxWaWBi4lmyE
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c2d0300b0040fb0c84c64sm1004733wmf.14.2024.01.31.01.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:31:54 -0800 (PST)
Date: Wed, 31 Jan 2024 10:31:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next 1/2] nfp: update devlink device info output
Message-ID: <ZboThy4CrJRAITED@nanopsycho>
References: <20240131085426.45374-1-louis.peens@corigine.com>
 <20240131085426.45374-2-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131085426.45374-2-louis.peens@corigine.com>

Wed, Jan 31, 2024 at 09:54:25AM CET, louis.peens@corigine.com wrote:
>From: Fei Qin <fei.qin@corigine.com>
>
>Newer NIC will introduce a new part number field, add it to devlink
>device info.
>
>Signed-off-by: Fei Qin <fei.qin@corigine.com>
>Signed-off-by: Louis Peens <louis.peens@corigine.com>
>---
> drivers/net/ethernet/netronome/nfp/nfp_devlink.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
>index 635d33c0d6d3..91563b705639 100644
>--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
>+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
>@@ -160,6 +160,7 @@ static const struct nfp_devlink_versions_simple {
> 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,	"assembly.revision", },
> 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE, "assembly.vendor", },
> 	{ "board.model", /* code name */		"assembly.model", },
>+	{ "board.pn",					"pn", },

This looks quite generic. Could you please introduce:
DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL
DEVLINK_INFO_VERSION_GENERIC_BOARD_PN
and use those while you are at it?

Thanks!

pw-bot: cr

