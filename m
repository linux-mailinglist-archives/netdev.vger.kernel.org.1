Return-Path: <netdev+bounces-166285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65EA3558F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C91890433
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 04:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC361547D8;
	Fri, 14 Feb 2025 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsw0VNqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E532753E4;
	Fri, 14 Feb 2025 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505943; cv=none; b=icPfb5Owkxqdxf8DpV/HamMWiaLW2JtAOa/1HmHExt3n1SsHsp1kHw3HSz7Ra/TFJDal5C3g5WecmbwE1zvYZgVZaLTm1CvRY+yEjo1/eW37K9iksu2icfNzS4ZAJ1vKgimci4IO+wPHJkbNPWZprzpiRwHs3qLGBElZ6QMd840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505943; c=relaxed/simple;
	bh=c3BgKJxEx8TWtxiTJZidpJXtjr85Bk8psUOyafxaNPE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mMVaitJ/xBYqkEtEon6VXj6JJVAcP4+ifVduVFrIBosxAgLi3upqtGiL9bT/cLVLlngnvqOeT/cefd6PKFwi9npxpbZaZO0YoAnVRn+HwAnKfitIx4AiBZowxtR5VmWAi/dyTVVAEHl9mmfM+XTIUzWFVAQOoU7R6OMx7YHxa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsw0VNqV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so2968267a91.0;
        Thu, 13 Feb 2025 20:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739505940; x=1740110740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXObaPOwBzdR39AvlOz+qHq1Yn+96zXqSvT5rc48WGw=;
        b=lsw0VNqVh95nKa4YCXWESC83eVTumhN6CJaCuUjrFh6QJexuZo2M/xb/cZczxdnKVT
         aTlwMwWp2LGXq+dm6QwmkD8bw6CGTGsx8idAr8+C8WLkX/N7nk3YeEvpgScaGfGVbbxY
         caBtq3WCQDAg9TVOeRaxY8UH61pG4L8e+OavTUCMKbFV6A1VIkpjRjC/UrETM8t+SjTn
         W6bo62o6qu6mceZB3jwdgnv3r1ex4sO+TFD1wLUvbo5mNkAm0Ktf6ONpgejUdQ058/zh
         iv7JP0Wj9kiO+QT3Soygeas3X6o7adNxGRfvMjPWFaSp4LzR/j6nrq3H7xTF6nSI0+q8
         lWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739505940; x=1740110740;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cXObaPOwBzdR39AvlOz+qHq1Yn+96zXqSvT5rc48WGw=;
        b=BxC5k+DOJhsMBUSZofX0EG56W7kgskLdOxhpHEtwLBeTiQ8ttS3jjKggCanByBFUxG
         PXbpbSuL2UO9xAecwzPlSmV9zk+1O+aokdp+8XnSfUKxO7wzwC/g35sVjlxMKaEZZKUN
         f+GyJcb1UOldLIoaMRSteVZfAa6EP42cQqRPMVBzwHeMaLWNSQhMRo1GVCjBEaIh7TH/
         FLCNcqn4+glf4Y6mQ6U6ERpt6LelK8vHpoSx4h/UUGamU6EVaJRvQHxhQKJwnpDBrexI
         t+T7M8HZJlyODCMhz7c/Iv5I6W4xk7w4CFz/rLfYQpY7DbfW6OyWbg+cJj1xyM2AsUbI
         Ifeg==
X-Forwarded-Encrypted: i=1; AJvYcCV65WJASQYrNq5iWnalQtUNJTjqHdUhD2MYD+WWGDAAldwFV3iuHH0dKgcvQxI5LchYLvlEW0m4XjuXYBvNTnc=@vger.kernel.org, AJvYcCV9gHv20p8jPTZoj+4yPLtyghT5D9i39SP1P9WgMNt1WEjQVIagOBH5EVTi+C2qcygaO48t+Mxj@vger.kernel.org, AJvYcCX4HgNhXIaOzJetVpk4BKdXNhESsqnmtgjVE+vI4iy4GDpS4fIVa7NrO75p269vEmarvjXeNeKMw9hM178=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSmPKgnqiPW+cJh449h/SJhD6iHD8lLMiSkgHaQ+MaqHurmTY
	zIgcJj3UplvAmRYvotjbmIjCzcmrn13xjmwiOsfhA/dXJZonpeOr
X-Gm-Gg: ASbGncuMYH4cpIaCrq5v1RQPiRws7VUmsiiR6zkmngEoD2PfxHh/frs04RWmMaN2JiH
	vqzk7NwkUEtSXsJgHZ3Rpp9D9hccWo+gi78dqqlhkjjLy7DqXBN5+qBwo+MLSc+7L4MXwV+qo4l
	5h3eF1L1vhL2RJ1anl9crE/Y4nR55dYJ+m5KRD4AnyOH699x5PeSse2mzohAjSeiQO9vCfACjir
	e8vNwlb0HLYzHY8TOfWbTEruVhw5lePBhJ+jit4RNrVj+ftUFBJnXEjBs/WTRqH+RMDXeRIYnHz
	jVL+q/WBTDWZvU+1VjuXETv10o4qitCcKeOTYaKCQU5JAIne2DhIf83tqQJVgyOZtRqSyrff
X-Google-Smtp-Source: AGHT+IEhWsGDncS57E8nNrhShQYX6mQbMVVUTVtGZ/iv4TUPUJHb7sZabPE8epMZzY1QQHtITKEBgQ==
X-Received: by 2002:a17:90b:544f:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2fbf5c0f653mr16933042a91.14.1739505940248;
        Thu, 13 Feb 2025 20:05:40 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13aafa44sm2097846a91.5.2025.02.13.20.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:05:39 -0800 (PST)
Date: Fri, 14 Feb 2025 13:05:30 +0900 (JST)
Message-Id: <20250214.130530.335441284525755047.fujita.tomonori@gmail.com>
To: gary@garyguo.net
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250209162048.3f18eebd.gary@garyguo.net>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
	<20250207132623.168854-8-fujita.tomonori@gmail.com>
	<20250209162048.3f18eebd.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 16:20:48 +0000
Gary Guo <gary@garyguo.net> wrote:

>> +fn might_sleep(loc: &Location<'_>) {
>> +    // SAFETY: FFI call.
>> +    unsafe {
>> +        crate::bindings::__might_sleep_precision(
>> +            loc.file().as_ptr().cast(),
>> +            loc.file().len() as i32,
>> +            loc.line() as i32,
>> +        )
>> +    }
>> +}
> 
> One last Q: why isn't `might_sleep` marked as `track_caller` and then
> have `Location::caller` be called internally?
>
> It would make the API same as the C macro.

Equivalent to the C side __might_sleep(), not might_sleep(). To avoid
confusion, it might be better to change the name of this function.

The reason why __might_sleep() is used instead of might_sleep() is
might_sleep() can't always be called. It was discussed in v2:

https://lore.kernel.org/all/ZwPT7HZvG1aYONkQ@boqun-archlinux/

> Also -- perhaps this function can be public (though I guess you'd need
> to put it in a new module).

Wouldn't it be better to keep it private until actual users appear?

