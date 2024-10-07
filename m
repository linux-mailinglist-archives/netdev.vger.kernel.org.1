Return-Path: <netdev+bounces-132764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE2E9930FC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D68EB2665C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E11D88CD;
	Mon,  7 Oct 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fi/OzdFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344461D88B3
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314434; cv=none; b=MyL1vXDpRl4hYX44lgbobolipVKn6DpgfSZ6pZLvc46p05a4gcmzIyAUSJjToLeT4nnEFJRvrU670RqOVkNUYbqV1VdXhPw7FmbHrqMfUlA9toKZbL8XEkuwkKDH7fcJxk9LYczqn1AuHsZ9hUfkjNTtB6ru3J5CRuopMhkaTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314434; c=relaxed/simple;
	bh=pPxzdbrBTki/yDMf9zuDFMMZBiHu7JxpPiSGspfiGJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKaI57w585Scze+iRnrHuAFkkzpzBddShichw4QWXXXDVjXf/Bb2FkrsN+0ENHucOBleomCW2lvgBu5HpB8i0/3Kyml0OHhNBX27Zg93ybKbUn+wYKCmU3EjO1EANJxDtNDVCGYxEqDYhJuGNYLMf4yyLMkoxNcNRNHvYId7h3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fi/OzdFw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9957588566so143555566b.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728314430; x=1728919230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPxzdbrBTki/yDMf9zuDFMMZBiHu7JxpPiSGspfiGJ8=;
        b=fi/OzdFwd111+oMG7Ac4KEDiJrI+6yqra+oB9R1LLla1xsiXL37oO5QzK9uVL8Ykup
         x8Jn/FHcL2RvlULgmOVr57V3wSRT4m2uq563SBuWM4W4gmkwVeK6Vp+sFdE6HxnPQDPc
         haXPi78auDxuzsq4czOE/ndsGTsZLaLpXrUTtjESrHWLD+QgRGiyDXDbGI5MKmfW/DB4
         Hz5qgAPHCPieYBxblc7eDN976eGdDqEnHSD5y+ajTz7hKvD8H7p1urESOwCZDsX6xMNA
         mu+R4QhBPZSJzheoMPfaKtssCxdtxRDe6MPwRTN5oxvfPM9lh+lrWcsIDp+tXYeWOZre
         Cb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314430; x=1728919230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPxzdbrBTki/yDMf9zuDFMMZBiHu7JxpPiSGspfiGJ8=;
        b=SqPPNCUTLbPda9580GgvHh1wgx8CNHoxqr6tra5iSv0VUqGeB/vK+Man7YXGvdKssx
         NwTadJAmDnq4/+x8zih3+xR/JMANLdm2BWR5lOhmqppqM916TSxjO7lLtaY1YZmZ6O4n
         +WR37ARvxPSXydaAHwUZZdrCbLjrm0H33D+MKeC+LOmaULZ0MUguhloB1/T3JThO31rs
         FyhFmyHAJY4YW3qoSRqdjxHkRmhTYlgazvKPRtugTFw880WOmDWCg2x698KI+DnN8jBj
         xkqpey3s1O6rFFiu2vHXOujtvJR1Yuay76GZA1p1V/a9iF3wZnernAJ000cmSMJ9+tu/
         t+ew==
X-Gm-Message-State: AOJu0YzaYjllAuS1KFSsuDOztstSiClEqCtXHr3L1LJ9rEVXqq/flSjc
	u4cGH+rr+mt192sfZoFT588Ztirgk0qghndWBEnLqUT9bIVQDe9PUYW3Tas6AEA=
X-Google-Smtp-Source: AGHT+IGFPlkUrUyWa4Kqksj7oKkVWDH7XjJailgRfGtZS5xJypLhfrZ5Hyr0z5iyK1N2zJalyOYRIg==
X-Received: by 2002:a17:907:6d17:b0:a8d:2d2e:90e6 with SMTP id a640c23a62f3a-a991c00fb55mr1357264166b.60.1728314430225;
        Mon, 07 Oct 2024 08:20:30 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99429c8bb9sm293586966b.196.2024.10.07.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:20:29 -0700 (PDT)
Date: Mon, 7 Oct 2024 17:20:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	edumazet@google.com, Stanislav Fomichev <stfomichev@gmail.com>
Subject: Re: [PATCH v8 net-next 00/15] net: introduce TX H/W shaping API
Message-ID: <ZwP8OWtMfCH0_ikc@nanopsycho.orion>
References: <cover.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727704215.git.pabeni@redhat.com>

Mon, Sep 30, 2024 at 03:53:47PM CEST, pabeni@redhat.com wrote:
>We have a plurality of shaping-related drivers API, but none flexible
>enough to meet existing demand from vendors[1].
>
>This series introduces new device APIs to configure in a flexible way
>TX H/W shaping. The new functionalities are exposed via a newly
>defined generic netlink interface and include introspection
>capabilities. Some self-tests are included, on top of a dummy
>netdevsim implementation. Finally a basic implementation for the iavf
>driver is provided.
>

[...]


>---
>Changes from v7:
> - fixed uninit error and related ST failures
> - dev lock cleanup
> - fixed a bunch of typos


Was out of the loop for last couple of iterations for personal reasons,
sorry for getting to this after such while!

Overall, I like very much how the patchset looks right now. I reviewed
it, didn't find anything noteworthy.

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks for the work Paolo!

I will try to convert devlink rate to this api soon, I promise.

