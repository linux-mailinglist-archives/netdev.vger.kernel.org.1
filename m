Return-Path: <netdev+bounces-82665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CAA88F009
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 21:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11AD1F2F600
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C2914F13F;
	Wed, 27 Mar 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BitdxUkR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223A1EA95
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571194; cv=none; b=H5MXxsel1JgD7h16T83u9J0kJsCuFB5bB15QkyGahD/6Wi6WKfQmDnGEk1VmIwa14gw4YE/I6YFNtykS/ef+6nKIWndYUJGc1eAsQ51XyE+70lAZx/ZwOMjeYn9Xg5zVDldrJF40pcWDTLMpme1BoQSguV2qnRam3XnsgnqO2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571194; c=relaxed/simple;
	bh=bLG9VeyvVNGnJqtNYSCHif2KvKFQcLbPVwcRnQ1xnQ8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=JPjQfNLT/zylEBm3c8kjV/NVytxDUeIl4jJLuOwvET3cYc8GCQicx9iVg0GATGRhdTXUYODM9AILDoCLIL+EY3HuTb4Fe1p93uA+56XD6VYSvXVetaPZqar+C8zI4gfpHfweP91hpUYH9PvcTQrVPL4avyq+jxXd13gUQnrnv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BitdxUkR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c36f8f932so2385249a12.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711571191; x=1712175991; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=bLG9VeyvVNGnJqtNYSCHif2KvKFQcLbPVwcRnQ1xnQ8=;
        b=BitdxUkR0VAs7tZY3WDJz1w19176XZrSRFOsUFaDma1+47ApXweebvwZxCOp4KxJ81
         VjFtVDPWDPlxnyRqronWrs+wSCgFgDuiB7vks/mI6PbGUvZBIFp4TDkNDyp32Wz/Ea0t
         G5q1mk8PGbBVdbzlQHY6rlDBGS8pxsDH4gdL3QEnJ2+8rQ2GltcuT6L8q8ruN89ckJ4J
         5NxO7vScCmmaqEREHMMj4zx0LEDRUNkMkG2eBZEOxZAtoJ7Mu5JQMuuZwoEd3OpGlnyc
         /p863LUJzsSaNDhB7qPSXfY0lTmVopNayQ5cXkwd9nxmuvujODJT86oWQjzyPmQluJQU
         0ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571191; x=1712175991;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLG9VeyvVNGnJqtNYSCHif2KvKFQcLbPVwcRnQ1xnQ8=;
        b=HEFhQDBpfPN7VZWy68Od89DQWQ1u4cBANas4zo3v+Giy9CifDO9lfKmfcFHV33nG6v
         F0F0Z7HNHU+ycm+x/+K1JJqd24DwNdBCNpYQYZImUmEhwwTjUIdsFYGe8lwIXUbqXtf8
         j+/DG2Yi8zWXsjI9B9sskiPSQLPfft39evq6rZbvfBnbAlZRNLAHnVdyFYtetFl6OBO5
         ePM7ARK0z6fNm5r3JCdPjT0zmkf9o1PirtyiVzqBZZTRAixVQeu4XDs8N6QxKkfnPiCH
         Y3XflEl3IVQ9pZxA2R4W/OrFwwQUDRst+Wk5DFaE62VjiutVoP4HHAz5d+NfDPkHCkD4
         /B7w==
X-Forwarded-Encrypted: i=1; AJvYcCXisMBWfkXtO8NY9oqgLksTXfukXjyTTVn+LIXc5p8DjzaShyimoZSbinXIXVzmv9LYPuh6x22GQOxJP8KvxPRv4D8TMSS7
X-Gm-Message-State: AOJu0YzcOSI5zzjtHtjhBcu9ORhh4+vo+1QkknqAsa/NJkfyg0lRZcFw
	2IQmBjE8eYCNBOMgTgOzb2nA6kNVh3mxHWALiQN7/sYKs2ih72FffcSdqxCMhcI=
X-Google-Smtp-Source: AGHT+IENUoAEF16NAf5vS/425PRYUQHt5RNabK9zmWvd+HEO2gHJDsMCvv5ag/FfG8zcqaiByoRI1w==
X-Received: by 2002:a17:906:b7d7:b0:a47:48d7:d393 with SMTP id fy23-20020a170906b7d700b00a4748d7d393mr303063ejb.33.1711571190765;
        Wed, 27 Mar 2024 13:26:30 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:159])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709060cb200b00a455d78be5bsm5821054ejh.9.2024.03.27.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:26:30 -0700 (PDT)
References: <20240325223905.100979-5-johannes@sipsolutions.net>
 <20240325190957.02d74258@kernel.org>
 <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
 <20240326073722.637e8504@kernel.org>
 <0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] using guard/__free in networking
Date: Wed, 27 Mar 2024 21:25:01 +0100
In-reply-to: <0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
Message-ID: <87h6grbevf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 26, 2024 at 04:33 PM +01, Johannes Berg wrote:
>> Is it also present in Rust or some such?
>
> I have no idea. I _think_ Rust actually ties the data and the locks
> together more?

That is right. Nicely explained here:

https://marabos.nl/atomics/basics.html#rusts-mutex

