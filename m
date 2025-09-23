Return-Path: <netdev+bounces-225513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068A6B94FA2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A68166DED
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2712E31A053;
	Tue, 23 Sep 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4VNFD/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF562E92BC
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615890; cv=none; b=W/U8DRTlE+CT/3LUZE++11wuUh+JBsCt6N0c5jw/QoYQbHgpWUEE9EDm39ivyg1e0K79RkbGArpdxWFQZAENYcGFXUCwEddcXVSHoLFXVt1SRbIz4xxg81ny8Vr9yTyr47D930alC8aPQhkNFhzg8g/Le+MK1LzN0vVEXDgc900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615890; c=relaxed/simple;
	bh=dxCnlkJxXq2EGJPZ1tZ94V08MX2xLllvGQdXxEda/2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLL20GsQv0DrIxaxMseyrPwLAtM5dhTqmvOtVUvP12Nr2nQCeqM+WREW9EjVzLpdRHsfY5viiw6dkxU7uLNP65/eMwOgQWBP8HWh4MK81HLGVHFTHzorrZW5AzTm53rMCAzQ+UPY+5cgkymOkm7eCZ78W6NZlQCZxIGur2Ivp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4VNFD/i; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so31642645e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758615886; x=1759220686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZxNhYZvdVjbbAA7O2nlWpIW8uXfLnzpFm+bfSFng/Xs=;
        b=z4VNFD/iCANumGus/QVtgCGUHwfTIapzG0+MDEMXczLkJbRXhGvfrV+Z5TJQiSosP2
         ohkFe1kqjlIxLfYPI68ZqaDBLO1AU3/U+xySWq33PF912I4w5+2yLPfmg5yxsGnz9/Oz
         +q7S0NTox7WOR7JeUbQxI5TG/iY33j2HfcfjbBShYwLzPOprnvYTO7HcXuvKHFN0oH5D
         7lQYYpzYCgl0fHZpS00MfCCJip9p0wI3ApAFAGZ3FshAMjVyPfeFhGV98xyfQzsinOQz
         pEU4kjmuiJGfIFJlF33pl6kOT22yTVvBpFXKa4pO4DL2RIkz9XKs2CSAcBHXMgS+Rtkn
         8XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615886; x=1759220686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxNhYZvdVjbbAA7O2nlWpIW8uXfLnzpFm+bfSFng/Xs=;
        b=gLBUprtY9j1sOORrLHPV9hzw3aPhngKaUtbmrMJ8whGIe8WMwOqk7e5Ya9aBIB+Fa2
         jEJ5O1l9145by7dUFBP1u55YMQu6S8/BV/ngUexDM6rUQqX8YmnadxhHqzjmaWhAXBRw
         tf5qy8B7T4q/gIqxLIph4soK7AxxHmg4bv/QeSSCIDxWAEOm1eI6xuY0Wqx9n5Tl6dCe
         LA8Ec4ccNYmZ2iM8KsEtTrzfWaxZ4GfpOmbhSfo2RXZkI2TWf3blVW9jushakiotxb5y
         iXte0DyiSnjfkPKLx/hUAEwxWrX+mbwOWYhsa6TdyBY8QXCurhz+ch08dYZ4atyoJBDs
         ZRWA==
X-Forwarded-Encrypted: i=1; AJvYcCUf0z0VMxkh5OZ4IuYKkhIX1QTQwtmH9PTJtJHmnV+qMHLoSI6fflqlxgk+Aq+wICSiXqWxUDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6EpIHKjgxU27A0Oh23exHMZHkuMmluzEmmjIOThVkfd0XtKv9
	jvu/Wfkm/EuaYEcUHV00R9/OOTqd3fu6L8fy53ggCPX81ti0d97EkxzbDK0gHu+IgsU=
X-Gm-Gg: ASbGncvK3X/5fItt21Y+Meg5SrIuZzFnuMdsIzw3v6an3CwcUfxtluWUbnosjUuRzD8
	4F1m0Yu/x+ZU+t0cH5xQH3C1ZEb619V8iO8utTAPVNC/Vcmr6BIiU5ThW2n5cqQlkxeZ0CpV3qd
	fLz9M/1lWDIHFpPywVPcaNgW5DRiHGLIh1pQwbLJ3HQNl4frLjgnqhTR6hsf5U8PCO6H2uHSKdS
	m3CMSf6BzaqIENKIvo1nw4zUqZtAv/ngxuDT/Work9lpaE/EL4gF0HY9U7eRXvlweXxmiNAYIfv
	IBkXpPRHFuYrb6NSBOOpSBWjDcEk6rOuX7OkY3giL2czJwMO0ApJjFVBSLfoEMX0G6N0t5UUvUf
	ucMhmPIDwRkx/O85vU5ejZqEpMbr75yPKe4GRQs0=
X-Google-Smtp-Source: AGHT+IFU+sjP7a8s/NZmPKRBLF84hn5GUX0iuTuvGDJtszkIku+WbxTqwewJG5TmfqMf4a997/HbmA==
X-Received: by 2002:a05:6000:200e:b0:3ee:b126:6bd with SMTP id ffacd0b85a97d-405cb7bbd33mr1319369f8f.50.1758615886417;
        Tue, 23 Sep 2025 01:24:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee073f3d68sm23104079f8f.10.2025.09.23.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:24:45 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:24:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] 6pack: drop redundant locking and refcounting
Message-ID: <aNJZSugLwx-ZkbAj@stanley.mountain>
References: <20250923060706.10232-1-dqfext@gmail.com>
 <aNJINihPJop9s7IR@stanley.mountain>
 <CALW65jbwmP+Lms7x2w5BDjFdg_d2ainorAMTWmR_6NJmjV3JmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jbwmP+Lms7x2w5BDjFdg_d2ainorAMTWmR_6NJmjV3JmA@mail.gmail.com>

On Tue, Sep 23, 2025 at 04:10:07PM +0800, Qingfang Deng wrote:
> On Tue, Sep 23, 2025 at 3:11 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > checkpatch says:
> >
> > WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> >
> > Which is relevant here because Google has apparently deleted their
> > search button and is only displaying the AI button.  "The email address
> > syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com is an automated
> > sender used by ..."  Thanks, AI!  I can still press enter to do a Google
> > search but there are no results with syzbot ID.
> >
> > I can't find a search button on the syzbot website.
> >
> > Ah.  Let's check lore.  Hooray!  How did we ever survive before lore?
> > https://lore.kernel.org/all/000000000000e8231f0601095c8e@google.com/
> >
> > Please add the Closes tag and resend.  Otherwise it looks good.  Thanks!
> 
> checkpatch also says:
> WARNING: The commit message has 'syzkaller', perhaps it also needs a
> 'Fixes:' tag?
> 
> Should I add a Fixes tag, even though this is not a bug in the code?
> 

I don't have strong feelings about this since it doesn't affect real
life users.  Some people would say yes, other people would say no.
Probably you should since it technically is a bug.

regards,
dan carpenter


