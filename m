Return-Path: <netdev+bounces-103086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D22906375
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED851C21786
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AF444C86;
	Thu, 13 Jun 2024 05:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KOM80aa8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233703BBF2
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718256919; cv=none; b=juEN93/kfFBr33B2NUfFBdq4Tr2zz5JCY2nnrit6azBGgfqc0pt1yqlOdejN8GwD7iK233aIxYWOYAUg8OxVZtNynRtQuSs98W0t4NAZ0PzF8fiv6unKZaqWKw7ipkKIIlgfMf4Ab/N+bsP1juRsgaNYKdkRR7SuaHSGWw3vTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718256919; c=relaxed/simple;
	bh=E1SEYSrQSIycZM+pCnRW1mV/aM8+qGJQO3xFHHyc2kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzZQFUjU7fDZeE4sqqV1Fl9RCimYrYsi/Uv4+ox9uew55BdIuj/SRyMXylRaSct2AdOCFn3FnU35raOe+tdl4vt2NBTKALEYKzEwnss7pGXdSz86QLTkjWciLiw/ko8cN3iGPY8HMgwakG468ARmUDvlil8rd270yku5ahpg3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KOM80aa8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c83100bd6so476243a12.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 22:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718256915; x=1718861715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1SEYSrQSIycZM+pCnRW1mV/aM8+qGJQO3xFHHyc2kc=;
        b=KOM80aa8fQio+sni1z6Wfu8kY1WP0ePrf9NDc41lB2fjDHbAhEGheUc5tPqt5ZU+zO
         wkfH1Dbja2Xj8HgMr9dnSMTMMpQjaiUEaR1n9o5EMthZx3QtNIkIS8uIn0NFJYLprsb8
         PBjHFjZcRsSw6hEyK+2zfGZODcWE4dpm2DtcICcgKhXMhwAckugafoEpqgMzSobzCEXW
         3HdgYaCmm8JilkTTL8DUtM1/dpZCyjgdynQECMoAZN5yA81yERBP7l3kPfu4bNkClm+W
         3NhWedt/3g/tauVTNa/XPvZSvvPNwKl4DeDAaqyjVlTocS+l8LB9frSQM4KwDFZg+3ij
         qNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718256915; x=1718861715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1SEYSrQSIycZM+pCnRW1mV/aM8+qGJQO3xFHHyc2kc=;
        b=uXa1SnvRV3l0ycHb8i1kyt1jPseDhs9DHUphsZxi0NY+rfj+o0+prmtuBzgmZBOQDL
         bvvgvhpdm5vEuw319nVxYE6SV/LppwH+MXkLvaSIjt/dRmUasGCrlLJezmD2Eb+oSnUK
         pKnf5VTWc1BsQfIz597aC5l6NOrkdhlDeEqNrL0U9wLUdoeJ8Q7l58DiDoKACXlDZWy4
         4cPtDrYgX+8oSsV241iKiql4e+O8ZY0w5x4kpP9dmXWuzao544mtC6UptUpLrmTm2sfM
         dEeiJr7zv1v9Uhsm3I1y99r8i45xHsfytEVdsORwq+6pCBbSdBXtErjadkV/Wp3W3ua2
         achA==
X-Forwarded-Encrypted: i=1; AJvYcCUOpGzl8sun+Fx8JpsQ7TgrnhZFumepmX3SQn5kIdQj1qz1PfPv97DIOqTLw4G2E1Kxm4n50n6XsrYzjzGl3DiZGhrqFmrG
X-Gm-Message-State: AOJu0YwPHlF0baac9f1Il+sZHTXKquy95er1tF3IAfKmhdhgU1sZZs6D
	Xf4WX0llL9MKv2Ri3vMhdpOypiETK36jjIwJD9ZMvy+7PKO8Pl2aePYnNnFyp2I=
X-Google-Smtp-Source: AGHT+IFMGiVZKPCDC0K7HAihtcWQfuT7TlmUGY8uHdcynmK2cq7X652T9mXLzQHzLbxdRQIHpTEihA==
X-Received: by 2002:a50:d514:0:b0:57c:6efa:8381 with SMTP id 4fb4d7f45d1cf-57caaaf235cmr1882217a12.42.1718256914935;
        Wed, 12 Jun 2024 22:35:14 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e6bdsm428357a12.67.2024.06.12.22.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:35:14 -0700 (PDT)
Date: Thu, 13 Jun 2024 07:35:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ruth <druth@chromium.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Subject: Re: [Patch net-next] net/sched: cls_api: fix possible infinite loop
 in tcf_idr_check_alloc()
Message-ID: <ZmqFEJBn3WECZlsl@nanopsycho.orion>
References: <20240612204610.4137697-1-druth@chromium.org>
 <5fdae342-05b5-481b-894d-3f296e8ea189@mojatatu.com>
 <CAKHmtrTkTJPHS1ken=ecx+C4z-LcG0OW62hoE6pAX3FUeX_c8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHmtrTkTJPHS1ken=ecx+C4z-LcG0OW62hoE6pAX3FUeX_c8w@mail.gmail.com>

Thu, Jun 13, 2024 at 07:25:32AM CEST, druth@chromium.org wrote:
>> Hi,
>>
>> Thanks for fixing it.
>>
>> Syzbot is reproducing in net, so the patch should target the net tree.
>
>Ack. Will resend to net.
>
>> Also missing the following tag:
>> Fixes: 4b55e86736d5 ("net/sched: act_api: rely on rcu in
>> tcf_idr_check_alloc")
>
>My understanding is that this issue is significantly older than that
>change, and therefore does not fix that change. Should I still apply
>that fixes tag?

So find the right commit that intruduced the issue.

