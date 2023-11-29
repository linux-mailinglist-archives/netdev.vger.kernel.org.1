Return-Path: <netdev+bounces-52152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F47FDA37
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A943D28270E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307332C87;
	Wed, 29 Nov 2023 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SOG6x1sX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09579D66
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:46:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3331974c2ceso432258f8f.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701269177; x=1701873977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd+VQEsmPtHaYSb1sOLGm0Al9pG0egJ+AOLDXMlu3rM=;
        b=SOG6x1sXBHI7S26lZAOMg6nVsU+SNfUGavs60TcLCSw6TFwePtnZ0dpLTFBqzCDy/9
         gG9RkmYEFv4LUkfSB7NLOd1M75xlpIPNXI1YkaYTst4UouyuLZ2q99tMwiWGd+L3EE5b
         Q2Qr/3+pLxmKh32gVIYYDxlwGpsEK4OHxgqKGZUrkKQrLfaQuUjRNc1ilSOZXfdvoYUb
         WmZSyau02fKoYW/qqmxurd04yu8j/b8OPLaa8fBkA/7B39vnXvAlJcIwJASvQehHsLB7
         28vcL5V+ZaifJLDUXCDeRp0HGVa2XPEkYY0EFCALdwtThhvoKmIu6gJ5di60m/S6fdOY
         kwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269177; x=1701873977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd+VQEsmPtHaYSb1sOLGm0Al9pG0egJ+AOLDXMlu3rM=;
        b=qyP6IQ4pnyF+24Qw/c3TmTO+L0vVcITxbvfSJ2tAInLBHNFNTPIj7Azgs84zd4wsDW
         y9N/5p/R+WXzbpOjbCqc4wnEeKdpFaYGskCdWG9g3U+ffRKV6d925k1WPxB+9xky5rAT
         zoFAXx3Qqb1tAb7gbKDHC1Qz39nm2M0p7J9DlzN9O7GfHen5+c/HokR1z4uPzAG+G3Yy
         41X8AJjgvXnI3059r1uzIq06sjIkW1WDpXwOm98lYtCzqOeuss4iELjVWUz8wsOriEf7
         LKnQFHQlxfqY4reLPZ7Q/1Blu2rq+CeZq1vzuPyhsPg69eD7IF2UEm4Z3W8DJ6idjV3B
         2I4w==
X-Gm-Message-State: AOJu0YxEPcWEjb6z9tgUXeTinMh5ZxHzEJFHeVfB+A3Yt15PkjTUFT1H
	mvCpnBNRLoLpS/MTSdmkdXPjnA==
X-Google-Smtp-Source: AGHT+IHMfC/TMg42FfmkshICRVT1hjVwYATg+xYlrzW0rfu23OrjUared67K3VuHF8exg5tGm7Dj2w==
X-Received: by 2002:a5d:4b83:0:b0:332:eeba:ee8b with SMTP id b3-20020a5d4b83000000b00332eebaee8bmr9123355wrt.24.1701269177321;
        Wed, 29 Nov 2023 06:46:17 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j15-20020adfff8f000000b00332f02123d2sm13085865wrr.54.2023.11.29.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:46:16 -0800 (PST)
Date: Wed, 29 Nov 2023 15:46:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <ZWdOtzoBHiRY53y9@nanopsycho>
References: <20231128151916.780588-1-jiri@resnulli.us>
 <20231128073059.314ed76b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128073059.314ed76b@kernel.org>

Tue, Nov 28, 2023 at 04:30:59PM CET, kuba@kernel.org wrote:
>On Tue, 28 Nov 2023 16:19:16 +0100 Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> In case NLMSG_DONE message is sent as a reply to doit action, multiple
>> kernel implementation do not send anything else than struct nlmsghdr.
>> Add this note to the Netlink intro documentation.
>
>You mean when the reply has F_MULTI set, correct?

Well, that would be ideal. However, that flag is parallel to NLMSG_DONE.
I see that at least drivers/connector/connector.c does not set this flag
when sending NLMSG_DONE type.


