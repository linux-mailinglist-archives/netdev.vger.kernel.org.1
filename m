Return-Path: <netdev+bounces-80324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0D87E597
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AA41F21C7D
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F222C182;
	Mon, 18 Mar 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wcZUtXNS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E072C68D
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753687; cv=none; b=CQlhWulI9h8JpSrcAGm2Ep5ziY7W0sxioGKhnEzYMI+ppT7CzYscSM7CZVhr6At4znBUkgoj1f6jIMl6boLzgEI5NOju0jdU6k0hMvQSDMTrlw6PWUBErICnZDDVzmeQZbWgBMb7DJKo73Oq94EoywJZ+zPvM3ou6wqGjKD1LuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753687; c=relaxed/simple;
	bh=Ukkll2hBDpl50RxPeZBg9jCVxZBDqZvBYIhjpYqwd5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfOxEGszV1v8R0b1H1oWn06NYv9bnkIeAxnaVRU3cIUDnbnMO44t16JzNwxKxtpND+eFA/bRQgX6jr3lDH5U9whU9Vqcq4PBYlju8s5RNHPR4RwVB6gYR+HUFUytB7Cegho3eIe0wySf49Hf79PuZEXLSIqZcNCiEnuF9MqD36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wcZUtXNS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41410a6c6bdso4555515e9.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710753683; x=1711358483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+DwG6TkCP5nymho9IY4+dKzFTbkXk2btjF/JyJ20m4=;
        b=wcZUtXNS8DGu5fZD3RV6rbBW0antlzwxoVyMIIqBDShVGSpKVWVFpEBfn3NtmLAS7X
         Tp09oHbkvgasvm9X9kyiwlBX/dkrljPIXvmqHqz4ML2YD4Ysm8Eyg93/IE3ASEfzMBNT
         5y8k5Tst9anrXtcnyrCh9cKAsAtK9lBTDa6OWZNojwUFx5pcax98tXSFQWM0VM+3G2Wq
         5t7B0xEWeinllRCYigSKg9ZICU7k216rcXiIy0TgKNQln/FCazKpJW6IeAQo8LMp1u95
         FWWpfAlNmDlQBdZzvz8ybEmHeM92pMcH3nSkETBxrFe1YxIGNFQW8MHYQ7gfgBjdnlvp
         NhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753683; x=1711358483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+DwG6TkCP5nymho9IY4+dKzFTbkXk2btjF/JyJ20m4=;
        b=tfISliA7FEGhlMCNVXZyN/ThZjAEB8ktU9mUjC2XmNhKloroyNN+GesGSSHLFYkJtw
         bWwcoo95BKiDZqvPKS+n/TfhWsH07FnAzRlzINjh97mKBNBeqYei1teoVtekCYHVP0Bl
         K4HPifVE/+kvz3p8DpCZCag9Z+lR3ACUVH6PB30pTuuaFJtf5kboTQyzwXgGPvC+bHzz
         X9wllSYFpTuFIb8tQU0ohAtoAoJcphI+EaJhaIAJafiAa5PFH8igYo+ahDSihlInpZHi
         MQ14RO2N/ynLeoWHcC5jGFs/fEFu4Z0c3kbmhlQn0d5j70KEr6R7S3eaf7r2dXv3JkPQ
         kOXg==
X-Forwarded-Encrypted: i=1; AJvYcCXpRm6Ui+s7SoWwyrrAPhIJS73Sibr6BfRV5rN8fs8C21KxlADB+zZ2swxtJpjCKliO5icNKh/kkA1EKp+4kvpwtbejgAwD
X-Gm-Message-State: AOJu0YwFOqAdnPhpWrCxcXRDF3QE04pWIrA9oC/y/kahHVn2GhUkgtRr
	IxzZU5S4dk6Vle8nNIVD0NK8zXHEF9SWBiQGBXzfnipPWT27cqiLQFITN5XA4qw=
X-Google-Smtp-Source: AGHT+IGxKZYVXnYBGTRnb+JCyzw/ubBuJ/DX02fNRh5busxZNT1LYT0bVAuWIGUVm04CgpU6Od/kzw==
X-Received: by 2002:a05:600c:3ca8:b0:414:273:67b5 with SMTP id bg40-20020a05600c3ca800b00414027367b5mr5900321wmb.4.1710753683530;
        Mon, 18 Mar 2024 02:21:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b00412e3717ae6sm17687667wmo.36.2024.03.18.02.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:21:23 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:21:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, zzjas98@gmail.com
Subject: Re: [net/devlink] Question about possible CMD misuse in
 devlink_nl_port_new_doit()
Message-ID: <ZfgHkApgxX7DybHx@nanopsycho>
References: <ZfZcDxGV3tSy4qsV@cy-server>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfZcDxGV3tSy4qsV@cy-server>

Sun, Mar 17, 2024 at 03:57:19AM CET, chenyuan0y@gmail.com wrote:
>Dear Devlink Developers,
>
>We are curious whether the function `devlink_nl_port_new_doit()` might have a incorrect command value `DEVLINK_CMD_NEW`, which should be `DEVLINK_CMD_PORT_NEW`.
>
>The function is https://elixir.bootlin.com/linux/v6.8/source/net/devlink/port.c#L844
>and the relevant code is
>```
>int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
>{
>	...
>	err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
>				   info->snd_portid, info->snd_seq, 0, NULL);
>	if (WARN_ON_ONCE(err))
>		goto err_out_msg_free;
>	...
>}
>```
>
>In `devlink_nl_port_fill`, all other places use `DEVLINK_CMD_PORT_NEW` as the command value. However, in `devlink_nl_port_new_doit`, it uses `DEVLINK_CMD_NEW`. This might be a misuse, also according to https://lore.kernel.org/netdev/20240216113147.50797-1-jiri@resnulli.us/T/.
>
>Based on our understanding, a possible fix would be
>```
>-  err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
>+  err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_PORT_NEW,
>```
>
>Please kindly correct us if we missed any key information. Looking forward to your response!

You are correct, this is a bug. Thanks for report!
Here's the fix:
https://lore.kernel.org/netdev/20240318091908.2736542-1-jiri@resnulli.us/



