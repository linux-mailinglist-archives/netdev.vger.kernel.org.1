Return-Path: <netdev+bounces-63551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425982DE23
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6F31F225EB
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946E817C63;
	Mon, 15 Jan 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZcUbZVmq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1677617C61
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da9c834646so7832299b3a.3
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 09:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705338432; x=1705943232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDhVLjlqTyP406tP+dliApqiFJM528hJ38o9vUbw/ak=;
        b=ZcUbZVmqpeiK4kPaxgTCwYzTonpOLdv47cDkDx8CsG410B3550DV6Hv/nHsSMO8yWd
         wEl8DZ25P4TUUBEniL6uvk5Q4pWFWdpVTd7t5JBlZY8uk9JAKptRpAgkhO4n5s0QqgUH
         vvfgbJrgn9XHIw6d5my7tgr8Ed34DV1pm7R71VxjW8lOur3Z2UcJdUMuStyIj06oJRiu
         udkTzRWoltyoPiZmA2MrH1ijNV/BeUpe7l5O+MYG1fWUBJWBcJevN0CRq3EDhgm+U32n
         gkaV8SSoNXxypPmTHL4kZKGexXQLcXAM/iGhKDL1Z9RO+skOh3X0isz4ckXI8ZvEDPHV
         y4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338432; x=1705943232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDhVLjlqTyP406tP+dliApqiFJM528hJ38o9vUbw/ak=;
        b=Rqiv50rVQKNK4C/qAIbcsIYXpMl12ggNYcEV5NelijxCaoV226KwWVSKwntBukfFSz
         gv4d5CsUBJtQvcnn17Zva2l8XJZ+aOrvOqNiusnV9GDvubTw3e0S+bbgYogj3NturX87
         O2besix6+ef0m+10qJUNf/E8nTrwv3O92Oqzzw/kmE/7tZeMA+8hK5YoegpKpP+KvkEH
         rExw8FL0iyPgne1snbubxxVRKIffpfFh5ZwTyaQaPajVQ8agD5JptVVLbzqiM94sv49F
         wO811DJ8PQbBcLGZkzR5UP3pVkYMYOrIFkWYpaX9ycK5LDDeaxKqqohaaIj4pfTwBZ1M
         Bqnw==
X-Gm-Message-State: AOJu0YzqQ6cNrLL28io2RidQBhrZuAkrxKdXpVYE8K5M2dg3PveY0qeS
	GBagx8ZwhXrA+OO20/8+Yj4lSvpyDZDvXQ==
X-Google-Smtp-Source: AGHT+IGNkGzGNBqQlg18mQSnspfFF5RtkGYzd43fvm1fcXg2IMcGksdtb5Wdl2okwSeYa8LNWryT+Q==
X-Received: by 2002:aa7:88c6:0:b0:6d9:aaef:89a7 with SMTP id k6-20020aa788c6000000b006d9aaef89a7mr7067155pff.10.1705338432288;
        Mon, 15 Jan 2024 09:07:12 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id fi19-20020a056a00399300b006d9af59eecesm7761157pfb.20.2024.01.15.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:07:12 -0800 (PST)
Date: Mon, 15 Jan 2024 09:07:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, Quentin Deslandes <qde@naccy.de>
Subject: Re: [PATCH iproute2] ss: show extra info when '--processes' is not
 used
Message-ID: <20240115090710.1c57762f@hermes.local>
In-Reply-To: <20240113-ss-fix-ext-col-disabled-v1-1-cf99a7381dec@kernel.org>
References: <20240113-ss-fix-ext-col-disabled-v1-1-cf99a7381dec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jan 2024 18:10:21 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> A recent modification broke "extra" options for all protocols showing
> info about the processes when '-p' / '--processes' option was not used
> as well. In other words, all the additional bits displayed at the end or
> at the next line were no longer printed if the user didn't ask to show
> info about processes as well.
> 
> The reason is that, the "current_field" pointer never switched to the
> "Ext" column. If the user didn't ask to display the processes, nothing
> happened when trying to print extra bits using the "out()" function,
> because the current field was still pointing to the "Process" one, now
> marked as disabled.
> 
> Before the commit mentioned below, it was not an issue not to switch to
> the "Ext" or "Process" columns because they were never marked as
> "disabled".
> 
> Here is a quick list of options that were no longer displayed if '-p' /
> '--processes' was not set:
> 
> - AF_INET(6):
>   -o, --options
>   -e, --extended
>   --tos
>   --cgroup
>   --inet-sockopt
>   -m, --memory
>   -i, --info
> 
> - AF_PACKET:
>   -e, --extended
> 
> - AF_XDP:
>   -e, --extended
> 
> - AF_UNIX:
>   -m, --memory
>   -e, --extended
> 
> - TIPC:
>   --tipcinfo
> 
> That was just by quickly reading the code, I probably missed some. But
> this shows that the impact can be quite important for all scripts using
> 'ss' to monitor connections or to report info.
> 
> Fixes: 1607bf53 ("ss: prevent "Process" column from being printed unless requested")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

This needs more review and testing before being merged.
"once burned, twice shy"

