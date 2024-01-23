Return-Path: <netdev+bounces-65134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F183954C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEAB1C26581
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C548381AB5;
	Tue, 23 Jan 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S21ogV+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959D1272DB
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028343; cv=none; b=ZfKvGP1gq6uwW/kcPh1Z4B/p+fDI1S7Xrs+YdcjHV2fdSWLROTWxEMpSAiXfq18KZ67snn/Z0CLPCsUL2p2rPtMoiqcFj9LNNIAes6mwSb6YmuqA1ti/r5O7Fq4OwCWQZkVdm8Y7e+D6ASfzqrETgb2nKYZdbaezFXdUnz0nvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028343; c=relaxed/simple;
	bh=8glYEFO2KCeCoRInfM55+HZR/QdQa24y8nxhcaSthFo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=OOHz8JI2nMPJxhrNtZsrgLqxmx3QeF3cZ+vDPbNoHq1WrvaIUQ9DooFbalLUP+A0TYsnN88Wa7pnRJv9XU+hzPKkRcP69j7u27Umammfgar7UIDSdmWlprYY2UfpFjEJpzdrMtyrdNFo9YD5oWn7YWu4UqbehQMxPNSJmHh7few=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S21ogV+y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso58593085e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706028340; x=1706633140; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5HYCDGPA6L8424YcfBt7tLpkm78FTAX+//4QrJa2v9A=;
        b=S21ogV+yz2VeNeZy3p19HQylRiAqsGagiZb2cQChf5krMn5Dhv0A2RDmgNDCz3E+IZ
         w0wvdoPqBlZZln1I1lmpTG9d+OdBpBIJZfiTadIsCENAvf2fBBGFsR+IPACaHStBs8+1
         6G6HFz1LjJCrwINMa4E88ukPd/MdJDROW6lSHLaHSx/Vi6BB+Gg6JP1ZNV2Skl+64BoL
         Tz5C4LKhOzZL3tlKz6a051P7U2DyqySkhaWQ5TAq/Tj/wwSSZEE3fC0mbAs8akyjdr1p
         g3/oTBz7X850N/9aF86of1i2uF4+raOEL4wyNlYZUO94SIhEVHi0vz+mY/AhTtlgLW2s
         DnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028340; x=1706633140;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HYCDGPA6L8424YcfBt7tLpkm78FTAX+//4QrJa2v9A=;
        b=mdpwJ13CDPoqEyNZfzNmwE+JB+yKWFsJF5l/vvAYi9nA/0UVN5DpFhSSpqjXvlHpIz
         +mg5Qg+gT2UqRMQzngthsjRSjTN9PCKd1h/B7TfEcoG+aFwFG3582lxyRvblCjPy0q9M
         exe/yz/XEBqZYpwjzAxb/v20Imt1U3W3UZ85775ZyPbbzbCq8uCF9D35TQSBuT27oOfs
         GxjhmG6ipm5m+4E8Zmz5xADjCZLAAZyWoEef4DraxxzaQKKLmNfKTL7As6gyWj7cOXNL
         SciBxo5XCl6DzXdkZouNnHBMz8yi0PGso5ZhUkm7ol8RaWIyc8I9i2u36AVqMWN2YqQL
         SmUw==
X-Gm-Message-State: AOJu0YyWCCjbgc7DoyOfz7efW4ioowQXuacw2jgGievJAB2A//x6y5z/
	Ay/ZHwZwo8yhkcZ6kNE7slqnmeW6GfxUkBpQQxVH8zZczUWmD0jgRsH42NeAh1k8apzb
X-Google-Smtp-Source: AGHT+IFAGDf7Fxh52HemzmF68ys4dDVNvWn34RbloovT3oGb8i2t4MBzd0fQXJlMLt+8yBkgkBV+4g==
X-Received: by 2002:a05:600c:4515:b0:40e:b313:b8db with SMTP id t21-20020a05600c451500b0040eb313b8dbmr315899wmo.28.1706028339637;
        Tue, 23 Jan 2024 08:45:39 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id n4-20020adffe04000000b00339272c885csm9553797wrr.87.2024.01.23.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:45:39 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  sdf@google.com,  chuck.lever@oracle.com,
  lorenzo@kernel.org,  jacob.e.keller@intel.com,  jiri@resnulli.us,
  netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] doc: netlink: specs: tc: add multi-attr to
 tc-taprio-sched-entry
In-Reply-To: <068dee6ab2c16a539b67ea04751aac8d096da95a.1705950652.git.alessandromarcolini99@gmail.com>
	(Alessandro Marcolini's message of "Mon, 22 Jan 2024 20:19:40 +0100")
Date: Tue, 23 Jan 2024 16:35:41 +0000
Message-ID: <m2zfwwxb1e.fsf@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
	<068dee6ab2c16a539b67ea04751aac8d096da95a.1705950652.git.alessandromarcolini99@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> Add multi-attr attribute to tc-taprio-sched-entry to specify multiple
> entries.
> Also remove the TODO that will be fixed by the next commit.
>
> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
> ---
>  Documentation/netlink/specs/tc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
> index 4346fa402fc9..5e520d3125b6 100644
> --- a/Documentation/netlink/specs/tc.yaml
> +++ b/Documentation/netlink/specs/tc.yaml
> @@ -1573,6 +1573,7 @@ attribute-sets:
>          name: entry
>          type: nest
>          nested-attributes: tc-taprio-sched-entry
> +        multi-attr: true

Good catch for the mulit-attr. I don't have this in my tc patch.

>    -
>      name: tc-taprio-sched-entry
>      attributes:
> @@ -1667,7 +1668,7 @@ attribute-sets:
>          type: binary
>        -
>          name: app
> -        type: binary # TODO sub-message needs 2+ level deep lookup
> +        type: binary
>          sub-message: tca-stats-app-msg
>          selector: kind
>        -

I have this in my tc patch. It should be 'type: sub-message'.

https://lore.kernel.org/netdev/20240123160538.172-13-donald.hunter@gmail.com/T/#u

