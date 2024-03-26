Return-Path: <netdev+bounces-81962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1588BEEA
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044791C3CFAC
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41265B208;
	Tue, 26 Mar 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DN+4xh8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D754916
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447774; cv=none; b=BIYnZhNRs67LY17jpefgvautJwNrJlO5DuPB0BkPqCsL+7cKnGoQjiyrsCa+u7+Kt7GSkfK6tQZzkW7rl9HcGJ/FzlpdpLj4Y9UqhPcqRqtrKqVXdCfneig0farWaHGcp9wxCD81brYvL0/+B+jDtxQfZP4XnGNV/1Q4B87yuHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447774; c=relaxed/simple;
	bh=sPRMdzA0/luYwpYQ+t5SitI43KODkM/+VZrv4i/srQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4Re1S19Y+QXZxpK8j0JAhAp80D9jxasZGTGYydcct5XRNAbAhBNvvX8Yssf9smbNp1y3JTMG5YiVm2apXk+LKaraQa6EbP9OAS9UaQBk3CYDcv+nLIS8EwM1RLMW2jms7gSSsutOfmXdHhSfF4wHIwX1yzahA2e3WZUzkJKS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DN+4xh8f; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso5908a12.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447771; x=1712052571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPRMdzA0/luYwpYQ+t5SitI43KODkM/+VZrv4i/srQQ=;
        b=DN+4xh8frdyAiEnVwfuinp82pltvxQlVw9XhAML7PoAKV6C1fWD9uAjFFAGBqpglCO
         9sot3FI9CZUm3XszHjBnNKuKc3X0Xm8XZe8weIANEBJhDl+RpwRSXvIRJ7Knjxi+yStn
         QNMp+AUehd+8D6KG6XbZFyv1G8KYlLZl59eMcMFD5pNhqIEK5xitJlnEvZP1LCkq/eNz
         6CFWCsHYSlTFM+jMSLhctbAQOYIVAePeTkAMaxfSnMg1ZFYNMnaJIwhp33UQQjJg+7kn
         EYAJi5qfuOY80+/OHgnmVAMpGdSUIOe4JNq2H5yJNRir7ktw6Dfkw81R7Hgg7HHHz28Q
         Q34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447771; x=1712052571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPRMdzA0/luYwpYQ+t5SitI43KODkM/+VZrv4i/srQQ=;
        b=B0eAOGEZcmTWerYkTq3SX3qIrGqOl2/ga5BrhpnlLdqa3F0I2i4cztFtqEpEKeHGRB
         UHzlmnTCurQY96CM1ymrPzsnmj3NxQ2/dFeUP3AWo123CvSVY2sN8HaNfA5oWzyfSmFY
         0rECvoANo2vMdcrpb5RPKQy5UMQlBomahEzGzI5rjNPC/liAY9ZDucdTUUE6/WP8SjFL
         FKpR58F02J/UEfTcPWl0Yl8feMn85HF+d4jenxqoDqGSJf8JmZ+MpnMbAgxEc44YJMJ/
         Z6x+uFTx7XvECXIEviqu+sBWRB/U5AYe16noS7v1m9K90UcY9mNlQRdbHLh6EEbROQY/
         CRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw99DBePIuuSvbpUekfVDWSd08em9lYT73FrzO1e9YXj0XmOEc5XswtVqhKqYFpgrZrxcCpeIO7izKo5EtWRtnBeYuKcis
X-Gm-Message-State: AOJu0YxX0XDjhDREUFl184aM6Ff1iSP50Z2FCjQXB0z0afbu0CM22A7a
	O8JRp/JZxsdACmHykvWJ0plGBQWvAIGpEmGiVQzwQ2DsaK9BHqkSmXpLkiAANpONIxRL24G6i8a
	FtGt+wGprlsTAiPA+XzJZQ2ia+QRPtRQvUIC2
X-Google-Smtp-Source: AGHT+IFsdAQAH3RTB6NNO1lM6vBlfeh66lb6zcjOza4ii2Pdb3Ksm7rfchw4e7cN0A62WHXsMB1XpXXLh6TwvmgAmHM=
X-Received: by 2002:a05:6402:7c2:b0:56c:9ae:274a with SMTP id
 u2-20020a05640207c200b0056c09ae274amr73795edy.7.1711447771060; Tue, 26 Mar
 2024 03:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
 <20240325185235.2f704004@kernel.org> <33670310a2b84d1a650b2aa087ac9657fa4abf84.camel@sipsolutions.net>
In-Reply-To: <33670310a2b84d1a650b2aa087ac9657fa4abf84.camel@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Tue, 26 Mar 2024 18:09:17 +0800
Message-ID: <CABVgOS=F0uFA=6+cab56a_-bS1p79BrpF6zJco7j+W74Z4BR5A@mail.gmail.com>
Subject: Re: kunit alltests runs broken in mainline
To: Johannes Berg <johannes@sipsolutions.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	SeongJae Park <sj@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 15:55, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2024-03-26 at 01:52 +0000, Jakub Kicinski wrote:
> >
> > I'm late to the party, but FWIW I had to toss this into netdev testing
> > tree as a local patch:
> >
> > CONFIG_NETDEVICES=y
> > CONFIG_WLAN=y
>
> I'll send this in the next wireless pull, soon.
>
> > CONFIG_DAMON_DBGFS_DEPRECATED=y
>
> > The DAMON config was also breaking UML for us, BTW, and I don't see
> > any fix for that in Linus's tree. Strangeness.
>
> I noticed that too (though didn't actually find the fix) against net-
> next, wireless trees are still a bit behind. I guess it'll get fixed
> eventually.
>

+ Shuah, sj

Thanks for fixing this. I've sent out a fix (though I'm not 100% sure
it's the right one) to the DAMON issue here:
https://lore.kernel.org/linux-kselftest/20240326100740.178594-1-davidgow@google.com/

I don't think it'd conflict with the wireless fix, but if so, I'm
happy for them both to go in via KUnit if that's easier.

Sorry for the breakage!
-- David

