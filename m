Return-Path: <netdev+bounces-51297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7494A7FA01A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301B7280FDF
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEB01E503;
	Mon, 27 Nov 2023 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="S1DniDLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD9D5D
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:56:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332e40315bdso2606686f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701089808; x=1701694608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEf2W9HVAu8+hPgepU8QEn+aP0YP/hRRlau1psXDcOQ=;
        b=S1DniDLTlznKlWxXR9kvxbUlfT78OF7PNZbTxEOvCtTq9MR25lXASv5K3UUJnf1x21
         6CO/imCJOdTrLptscDoIHWJ9llVMctqxttXk91F7nT1VxenRcoyeAf3pV7IVhcXdt36r
         T/pz9X3XJrM1fQgbjLscz7bjEfmhCpZa9CVee8mSnEJynv3vMjOov217uPkCsyHtMaF5
         oK3JKUKBxLSr/4BpUpM/Fqr13zPoLqA5RjnhI8l5BI5HJRTuATCAKUJQyU126xxuUAwl
         +Ax7W+ESt0MXVkpr53+UCMeUPEP2gdOjIZ/s7A7ydKSPj7a2WWcv8nviacq5N9LIz7YW
         mL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089808; x=1701694608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEf2W9HVAu8+hPgepU8QEn+aP0YP/hRRlau1psXDcOQ=;
        b=GYBY2Jw8971P1V4IEORyEf00nMWILqcXjxVPP8TxJXDUpfsR14smCOry0T4PpoYMp0
         KnyAd7XfVHLkpRw0H+E4hlh2MhzNUrT6tadgIAEIIKpaHzfbvAmaG0at56aG2YnS5gxU
         RAjq3o8qQC/dpBObZYfEuGc8Jpwj/0XFNOB+C1l71bGakQitasv+E4CVWcfbC7GlIzR6
         Wq5Ki2/1EZwv8E1ewd7nE2W6MX5EKrQlUhGfLP8vqZxH1LzHIT/8Yt/XJ4QaoUjwUApr
         x9Mjy9rCjjelLBzJ77OwoNDGhcNjCxPdeFrVAW36K44wXCfWRxzYyfclbhUU+SfN64tr
         EyHQ==
X-Gm-Message-State: AOJu0Ywm8trv1ZOepGMS6O/kT1eaXT4QcuQe9fgWr+b1lKqfRKVlC8Pi
	C3ZW/RlUrD7WBxaY+WOv3MVFUA==
X-Google-Smtp-Source: AGHT+IGeza9G0oQaRe8nmCceRda38iPpvvBPTLUQZ4XMi+Il200hIV9lwPpzcanGu5Mw9LfQVIG8Lw==
X-Received: by 2002:adf:fc4f:0:b0:332:ec48:a132 with SMTP id e15-20020adffc4f000000b00332ec48a132mr6262001wrs.53.1701089807885;
        Mon, 27 Nov 2023 04:56:47 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b00332c6a52040sm11878612wrt.100.2023.11.27.04.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:56:47 -0800 (PST)
Date: Mon, 27 Nov 2023 13:56:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com, amritha.nambiar@intel.com,
	sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <ZWSSDpE9QtJmx1Nj@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
 <98ece061-f21d-bc21-815a-19f34584f268@intel.com>
 <ZWSQtw/w7HvK4wzx@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWSQtw/w7HvK4wzx@nanopsycho>

Mon, Nov 27, 2023 at 01:51:03PM CET, jiri@resnulli.us wrote:
>Mon, Nov 27, 2023 at 01:30:04PM CET, przemyslaw.kitszel@intel.com wrote:
>>On 11/23/23 19:15, Jiri Pirko wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>

[...]


>>>   static inline void devlink_nl_notify_send(struct devlink *devlink,
>>>   					  struct sk_buff *msg)
>>>   {
>>> -	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
>>> -				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
>>> +	struct devlink_obj_desc desc;
>>
>>`= {};` would wipe out the need for memset().
>
>True. If there is going to be a respin, I'll change this.

On a second thought, since the next patch adds couple more users of
devlink_nl_obj_desc_init(), I prefer to leave the zeroing there.


>
>
>>
>>> +
>>> +	devlink_nl_obj_desc_init(&desc, devlink);
>>> +	devlink_nl_notify_send_desc(devlink, msg, &desc);
>>>   }
>>>   /* Notify */
>>
>>[snip]

