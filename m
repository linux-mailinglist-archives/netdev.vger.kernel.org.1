Return-Path: <netdev+bounces-53901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9D8052B6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC1F1C20BB1
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C40697B8;
	Tue,  5 Dec 2023 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JyX8IGgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F774698
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:23:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1b7b6bf098so342945866b.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701775370; x=1702380170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yqpkJ+ET/6lBT751aykeaMtjcvTMdn/A7pNY83siyc=;
        b=JyX8IGgQrzOYRZnsM7jtpEj33UtuZDkftkF5WNbmxDch4FqTL+ghcQrJTmRlJX6QtM
         8UPvyiVUOzysgBVVGx8MxIpl3Cdc5X35I9jC1EH28mG5yBBbjraPWOa8Pn35/be/vebA
         IEpZSMvJr+QxTjoYdoQW3NgfyLzbVDQ0ms8Q1a+kdFjx/Hcxgo5a95X32LuInfpMKuyt
         t9PADL3DE+9FTTaka53stPsXfnvY61y/P4PJET1969fXrUQftDNHJ2z2ByRkSxRHcyFq
         a1E4Nk7aOfvXvBmEGQYBR+rrmRgrYlVS92MENCA9RkgR+q1A4FUF0J6uLeF4X7IRm4A0
         s86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775370; x=1702380170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yqpkJ+ET/6lBT751aykeaMtjcvTMdn/A7pNY83siyc=;
        b=H5ofPD7+FwLMUN1p1tUJlM5L3cEE/6fjV/9AmQp9t/QCvv+hU1Y84TVA1QHXkl6Xyy
         kGcA9p6uCob5KZAkQAdlzlDK+EVXXSp2vwrNp3fOV1JOaq+1aHspzlUnI3WDCnZL5+Lm
         8n+h2sd2qGYn9qnfboRBtx+0ftYN06f2AHsC29vMufCbcBeKankE1YypIKnd0bJ9znbK
         XWPqeXnpiFYF7BPk0H0y9uH5mxs4k2s63AnaGmPDdcxvtYhtXpxrRdu8BxHkHd+A2Nkx
         5vGVzeO2Z/Sv2Kn+xP4BslLuDBUvBORMmAwWSq2ESiWQTEfwBPWrFog2HQR94KUpJcBh
         mvRQ==
X-Gm-Message-State: AOJu0YyNTi6Mnp2yNtqV+/7jJexa75sChTm4TfxLtLmSSZXaTitXj3d+
	QxaQl6P6DVZInVGYN8hKMSWUWA==
X-Google-Smtp-Source: AGHT+IHrKClQ7/RhLOCPOXXIuBCSxhhbCc98n00YruPaVJrGWXKgTadBACQeaFW0QTdVYKHrQZFubA==
X-Received: by 2002:a17:907:1b10:b0:9ee:295:5693 with SMTP id mp16-20020a1709071b1000b009ee02955693mr1196298ejc.7.1701775370568;
        Tue, 05 Dec 2023 03:22:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m18-20020a17090607d200b00a1ce58e9fc7sm197095ejc.64.2023.12.05.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:22:50 -0800 (PST)
Date: Tue, 5 Dec 2023 12:22:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH] net: rtnetlink: remove local list in
 __linkwatch_run_queue()
Message-ID: <ZW8ICbik45ODsRUW@nanopsycho>
References: <20231204211952.01b2d4ff587d.I698b72219d9f6ce789bd209b8f6dffd0ca32a8f2@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204211952.01b2d4ff587d.I698b72219d9f6ce789bd209b8f6dffd0ca32a8f2@changeid>

Mon, Dec 04, 2023 at 09:19:53PM CET, johannes@sipsolutions.net wrote:
>From: Johannes Berg <johannes.berg@intel.com>

Why rfc?


>
>Due to linkwatch_forget_dev() (and perhaps others?) checking for
>list_empty(&dev->link_watch_list), we must have all manipulations
>of even the local on-stack list 'wrk' here under spinlock, since
>even that list can be reached otherwise via dev->link_watch_list.
>
>This is already the case, but makes this a bit counter-intuitive,
>often local lists are used to _not_ have to use locking for their
>local use.
>
>Remove the local list as it doesn't seem to serve any purpose.
>While at it, move a variable declaration into the loop using it.
>
>Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

