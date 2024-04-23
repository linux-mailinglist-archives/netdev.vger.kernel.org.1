Return-Path: <netdev+bounces-90485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE238AE3D5
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD9F1C2266E
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5007D3E3;
	Tue, 23 Apr 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OJ2hfuTy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0597C6DF
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871585; cv=none; b=Vd0f/Ok9SMlywBLEsq3O2IC3S75lNdUSm2DwLUs0BR3ReWEoglkQB9wKTrUE77VqrlgN/PEjtmjL40SsJ2ULaIWgaWn7APcCV6sc3X0nvGwn1iq6LkINev/yVZWLVfmmnyklwSpJoQK2fIOkP+EKopMmPqKBsIzVdsjnIX4os7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871585; c=relaxed/simple;
	bh=Y0wUJW0t6Ie4ZK0bmyTUKRo4VgTIuEz9KZzwLq9XTZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGONWQNXpq+Wv9eYvc10FtCcNCtV95RL+BLFkgfZgcv8aj+f3W7yrIHScQ8jH3YgBaYKy5I0BJWp5dgB/OVTAwKIARwBJB9e14+qIYEOeXSwCUhS64PmsdAlJH0r662nvbL3UZ5PVMjU411Byy32oyuzYMBvpHdenIavWG1TqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OJ2hfuTy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so41177015e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713871582; x=1714476382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0wUJW0t6Ie4ZK0bmyTUKRo4VgTIuEz9KZzwLq9XTZM=;
        b=OJ2hfuTyLnO5aQSm8rTPz6CSduBcFi50Gl5NSKaCqT5Wtri0FZvGtXfuTFgbAu1JM9
         WosJj+SdsFdGZK5P79MzAmlm1nti6d28sUAF1jsyLpfe+8CjCMtA3R4koj5g+kA75rye
         ildwS+lBbebjwhpxgzA6T1FrQz9bdksuKicCgRpYrOtNU14+JLs1NAhEraMeAyc6P1Xd
         IjgOENA9zgkhsXRhb7VkoLtHXtT0vtmird/QVy3oQ+w2o5KUMJURdPnUdjc3UDJG/e1V
         fF2H8zAkTwaA5FfcwKRM1zoQDJvzxkV0tMOyK6fKbMwO5a+s+XtXADFE+E+WDMZrFhxl
         nN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871582; x=1714476382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0wUJW0t6Ie4ZK0bmyTUKRo4VgTIuEz9KZzwLq9XTZM=;
        b=n7rCZGImSikfwbk3J9ZNTQrPQPOWvsvW+7xrPOQWCmdq/z2G20DNKzi6kADx3BIKSg
         8ek7ZNCPME5ISYPVlUnwvhi/ub7uu+8OV8mYpw6S0cwD2U9TStF6HpKo9X8+TjTw47TC
         5C+P51eyYPuut2KLxzaHGfRYAlSCSNo9vWu3gqNimkeqtiNfPf+IfLjNV2HZJF9sTjI8
         JeMP9xdi67RDXOYe1//atwy89lkSPhHx0ti0cx4zifqYYTynF/RbAQCVhsEwgdGGMfe9
         jAzYlCMrV3npwtsew4jIa4JPcpVYrQJew6WOiFNyX04PybceXO9kHrbZD2Rgc4IM9ZnF
         foPQ==
X-Gm-Message-State: AOJu0YzX6qoKFT7FqOFYaNlfbCXyMHJ4JmcjowezM2UQPUHLe3rLnrNy
	XIowmLhGy8O95F9hIsgjiLpUqLw31ovF0Ah9DYzVRPTZShL6pqf8pIv1RjRpzAIv9xfM00YIA+V
	a
X-Google-Smtp-Source: AGHT+IEL990kAWyCPGWXzBuPt4RPV0UvlCNhSrRIU+jNVPPZYnALcPpTfBXbWu210DM4jNC0DttzhA==
X-Received: by 2002:a05:600c:46cc:b0:418:676d:2a51 with SMTP id q12-20020a05600c46cc00b00418676d2a51mr8451881wmo.15.1713871581962;
        Tue, 23 Apr 2024 04:26:21 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id d1-20020adfef81000000b0034a7a95c8cfsm10480609wro.9.2024.04.23.04.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:26:21 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:26:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <Ziea2_SRYoGcy9Sw@nanopsycho>
References: <20240423102446.901450-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423102446.901450-1-vinschen@redhat.com>

Tue, Apr 23, 2024 at 12:24:46PM CEST, vinschen@redhat.com wrote:
>From: Paolo Abeni <pabeni@redhat.com>
>
>Sabrina reports that the igb driver does not cope well with large
>MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
>corruption on TX.
>
>The root cause of the issue is that the driver does not take into
>account properly the (possibly large) shared info size when selecting
>the ring layout, and will try to fit two packets inside the same 4K
>page even when the 1st fraglist will trump over the 2nd head.
>
>Address the issue forcing the driver to fit a single packet per page,
>leaving there enough room to store the (currently) largest possible
>skb_shared_info.
>
>Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
>Reported-by: Jan Tluka <jtluka@redhat.com>
>Reported-by: Jirka Hladky <jhladky@redhat.com>
>Reported-by: Sabrina Dubroca <sd@queasysnail.net>
>Tested-by: Sabrina Dubroca <sd@queasysnail.net>
>Tested-by: Corinna Vinschen <vinschen@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
> drivers/net/ethernet/intel/igb/igb_main.c | 1 +

Also, please use get_maintainer.pl script to get cclist.

