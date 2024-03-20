Return-Path: <netdev+bounces-80799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C16FE8811C4
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3BB21296
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13C3BBC8;
	Wed, 20 Mar 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TFTPBjkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC21DFD9
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938406; cv=none; b=Iz7VwxvnzWObUadvTNnMc8YMqMJbo3ohIFJnRm3wy5HybNb0FSiixvz8B7LRaDv5kyk5DOgLpy1MpwlLuPsFiClmhl0zLLWm/jbNBOyekvM1XTlNII77p+jpMtIbYlYVH1w+t9PbhaudiAjwUi0dvzMZ9/dGjkicTzW0jYHjFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938406; c=relaxed/simple;
	bh=VPTB02eUHcf6amZ8zAAObXu+TD5PCWzhQS/wvYo6jTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiTk7A7pkUf/Vok51qzvgVuWsJgXygT7RtbyshyGiLI7tebgzGWoJcjC00j/kNCxBjDEBUjcbYBiORSTfvB7I/wXcsRXXFBAvDeQceKlvJcgNW0dvMhl3E0yRx1AhDXpnzX2MrWcvqlv67nqVDFe5gHqjB4NNq+HMhdEIy4a5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TFTPBjkV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46f79f60afso67374866b.2
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710938401; x=1711543201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4u0IMn0rzxmgFh4QmFwfGq97t80c3tYp2T28y44KFi8=;
        b=TFTPBjkVsq7LYwKvmKFNaq/ZX5ItiJ9tgFxqkb0IKIn37/jyrWs8QPh+ipzke+E5fY
         YLY4pUEkaUhYsmP/OHqF3cFikzOjvqZM21CKKZ8iuKre9TBy1R8X0V6qMtTdTfMtXSYY
         pcghNXJonpgziDaVIFZkp/rBbCko25qLTlvxLb8F9gTG6pDNYK7KYmapcd2XJzTiaIIX
         2qUP3v9K0jM/kIBWId/42/1MPpmkVfAgAe5nx/qb6t2W+3FTV+G7douqy5LRlHOLft4z
         gk3dvBJTfH0DnON2VIGwEo3B5vZUYCjCQDOyDZ/NJTe/QzUin2QOwMHYP3XeTxs0j8Ju
         VO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938401; x=1711543201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4u0IMn0rzxmgFh4QmFwfGq97t80c3tYp2T28y44KFi8=;
        b=bntoawlwH+b1xYgYF1bAF0EftHzMdSKSNdZQTLDk11wov/94Hy5srqsHyZQCtPzsOS
         LezHYf658WF/xNKNUkn9JLR53yKoTJc00DRUJ/O2m5fVgbMfkhnjEk8zzHcbBq5B/FZ+
         YyGupHo3knQUQ7miguMtVumuNyXNuyXOpmWKLFboGSqxW1ZSBQLKAQ4TlZaC7U73OyDe
         MjYGyScGhA3YLdiKbXK0PvzbNU7ccCgl1vodry63CC4k4NQ4gkJ1Tzh25RmHnxaZvt/B
         HkGklRMYKDetutdb9ME9bZkh2XlzXShRJP26lhzc+o2p+smw+eVr7v5BohtWIUkFe4HO
         xHdw==
X-Gm-Message-State: AOJu0YzHoSwUbocg1WchwoOAphHEhztCe3CY1zBRB+z2Y9+ibRCm09Wh
	2w8g2LTgRciiv/QNQpU0e/J6pBHYy1a8POxwJC7ikZdV/YeyO7IBk0lTIIxd2ko=
X-Google-Smtp-Source: AGHT+IF49P8lbqFW3OO1t/QptwHBl+tdDfzeat3GyEz6znZwt3j7+rKy9LpsBqC3Fwm9y2lV3uwVoA==
X-Received: by 2002:a17:906:a1da:b0:a46:e81e:5294 with SMTP id bx26-20020a170906a1da00b00a46e81e5294mr2887184ejb.27.1710938400670;
        Wed, 20 Mar 2024 05:40:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id kh18-20020a170906f81200b00a46e56c8764sm1657203ejb.114.2024.03.20.05.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:40:00 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:39:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jordan Crouse <jorcrous@amazon.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] devlink: Fixup port identifiers for 'port param show'
Message-ID: <ZfrZHAmJEf-frH5R@nanopsycho>
References: <20240319220953.46573-1-jorcrous@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319220953.46573-1-jorcrous@amazon.com>

Regarding subject, please put "iproute2" alongside with "patch" into the
brackets.


Tue, Mar 19, 2024 at 11:09:53PM CET, jorcrous@amazon.com wrote:
>Commit 70faecdca8f5 ("devlink: implement dump selector for devlink objects show commands")
>inadvertently removed DL_OP_HANDLEP from the required flags so that
>port definitions no longer worked:
>
>  $ devlink port param show pci/0000:01:00.0/52 name bc_kbyte_per_sec_rate
>  Devlink identification ("bus_name/dev_name") expected

Yeah, nobody should care as there is no in-tree kernel implementation of
this :)


>
>Return DL_OP_HANDLEP to the mask so the code correctly goes down the
>dl_argv_handle_both() path and handles both types of identifiers.
>


Provide proper fixes tag please.

>Signed-off-by: Jordan Crouse <jorcrous@amazon.com>

>---
> devlink/devlink.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/devlink/devlink.c b/devlink/devlink.c
>index dbeb6e39..355e521c 100644
>--- a/devlink/devlink.c
>+++ b/devlink/devlink.c
>@@ -5050,7 +5050,8 @@ static int cmd_port_param_show(struct dl *dl)
> 
> 	err = dl_argv_parse_with_selector(dl, &flags,
> 					  DEVLINK_CMD_PORT_PARAM_GET,
>-					  DL_OPT_HANDLE | DL_OPT_PARAM_NAME, 0,
>+					  DL_OPT_HANDLE | DL_OPT_HANDLEP |
>+					  DL_OPT_PARAM_NAME, 0,

Should be only: DL_OPT_HANDLEP | DL_OPT_PARAM_NAME, Remove
DL_OPT_HANDLE.


pw-bot: cr

> 					  DL_OPT_HANDLE | DL_OPT_HANDLEP, 0);
> 	if (err)
> 		return err;
>-- 
>2.40.1
>
>

