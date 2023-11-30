Return-Path: <netdev+bounces-52519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C826F7FF025
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048561C20C49
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E04655C;
	Thu, 30 Nov 2023 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ns+uyV6h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4138D6C
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:30:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a187cd4eb91so99605266b.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701351038; x=1701955838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qf6bXC8FJ83lNGT9tjL04pdejgvn2dYx2KNvITvFIw=;
        b=ns+uyV6hSXKZbMv9yTEGc0OK5/k7lxEFUATE9Ur9BxolHGcH0X5HlHBgXUCz94OdC2
         SNZjKVyCKbS5uGsnrmzAoscdk/wMP1hMEqBAp2lHEm+W33U1Zo3KGn04ltIcYKEayP6D
         vftiWqGEj70cV+FfC10N3s4+b+nY2b/FZyC41xflX6FLGWvLOXRQwBgG6fW0meRod7hJ
         JTiYL8aGIxCy49cYd7jPaujbHKLfjzXR20YJA05ShsUwdq7JDHlQjoFEezkHzm6HyHnV
         X5KJeLDWgWl0PbCRM+XlT25oZlzO9SwzXMLsO4zRdYsyX7TML+7rrXij/8basIM//TIp
         7sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351038; x=1701955838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qf6bXC8FJ83lNGT9tjL04pdejgvn2dYx2KNvITvFIw=;
        b=SgBijvwqw9nXBGKigNBNsRCzJkzjzjHHfISSNw0arppmHznHHbSF5SHw8ISL9zdeQn
         AYeUqkdYsvsSvlNyPQgb++WIlH8TsviSouRJA+j0nqnYT/A897Sv35FY/eGjUp2bVYpL
         L66SQGqaG+xqWKFKc0GtvFjcjVUwXg9xiKLOTLFXjCsTVEqaS7gNjgC9LCzvwyVmPIBA
         vdUzMSMpfKZN3eNd4PXMtMqVYKOCsfLcUdRp/moCbdX+7btE5QrpbYkVVmP+Hb1tKmt5
         P8JoBY1/oBJQvBowTZKc5o8fFL1WAKRiaUkc05vC17I2aaxay48uvGtxHvZA5KOoxQZE
         G4yQ==
X-Gm-Message-State: AOJu0YzhovfooP7UPGOHlhKNkrGAoSF/YNDR3S6ij+LT/uTuxEQqzKZA
	yTXFtEvsX5oWObY2+kscIyAt1w==
X-Google-Smtp-Source: AGHT+IGo1DCMih+KavIBjFyiMqs/wxwUBKBsji+igq/OhlNLWdOzu+wtQ4oaIh/fpNgpljqnh2GrpA==
X-Received: by 2002:a17:907:6b88:b0:a11:adc9:d14e with SMTP id rg8-20020a1709076b8800b00a11adc9d14emr8759007ejc.71.1701351038029;
        Thu, 30 Nov 2023 05:30:38 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id jg41-20020a170907972900b00a046a773175sm670550ejc.122.2023.11.30.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:30:37 -0800 (PST)
Date: Thu, 30 Nov 2023 14:30:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <ZWiOfMs1PT14LLau@nanopsycho>
References: <20231128151916.780588-1-jiri@resnulli.us>
 <20231128073059.314ed76b@kernel.org>
 <ZWdOtzoBHiRY53y9@nanopsycho>
 <20231129071656.6de3f298@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129071656.6de3f298@kernel.org>

Wed, Nov 29, 2023 at 04:16:56PM CET, kuba@kernel.org wrote:
>On Wed, 29 Nov 2023 15:46:15 +0100 Jiri Pirko wrote:
>> >> In case NLMSG_DONE message is sent as a reply to doit action, multiple
>> >> kernel implementation do not send anything else than struct nlmsghdr.
>> >> Add this note to the Netlink intro documentation.  
>> >
>> >You mean when the reply has F_MULTI set, correct?  
>> 
>> Well, that would be ideal. However, that flag is parallel to NLMSG_DONE.
>> I see that at least drivers/connector/connector.c does not set this flag
>> when sending NLMSG_DONE type.
>
>connector is a really bad example, the doc would have to say "some
>families use NLMSG_DONE as an actual message type which may have pretty
>much anything attached to it". It's not worth it, sorry.

The existing documentation confuses uapi users (I have sample).
They expect error with NLMSG_DONE.


>-- 
>pw-bot: reject

