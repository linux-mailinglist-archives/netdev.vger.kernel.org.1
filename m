Return-Path: <netdev+bounces-148443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F09E1A1C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB46166F79
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110F41E32BE;
	Tue,  3 Dec 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzcN27zg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535421E32C5
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223563; cv=none; b=UJBmIdMza3Vj/xJ5NNzv/sMLbL2+p5k4ir6gU2fGcB9EoJGDKwStRV+wB/YdbXkXhs1gXtnL08TUQ8TjN86hP6i7US1qIlRogJeJkn61I69Q+7HHITIwKy5IZQehpK6q9R5mTj8p7alrO07CKUcX1l1cBzkDq553HlqChfPDz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223563; c=relaxed/simple;
	bh=EDHzjBUASVzIv5XHo01cPBl/mjuy/KS3wSX1QX8rkwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Laf2W0Pah71gAo+m8bAw4gbRbBKdgT0RusQBpAoU2+pHMTTWTaZPiayrVfRITSmMC5hVXR3qviD2TLjBVEmtQ7CCzwG6H3gmY9Ea/qKSYrGPVkG8d52xjbzLCQsLxCm5XODhCoTdlFvKupR15UcX5HyDRFF/Bkd+reqaLOUkh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzcN27zg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0e75335e3so2805828a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 02:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733223559; x=1733828359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDHzjBUASVzIv5XHo01cPBl/mjuy/KS3wSX1QX8rkwk=;
        b=JzcN27zgMQ9tGrH2ZpBU8MZd1l3R/oXDkVtXcv/k0mNWc4yRGNJqcZNjz31z17+oEz
         JvEZkQDrMZ48DefOiw2605jG6NGiSshNAQlB43aCUwvLyPoqadl+ghIm6093x3DWpF0H
         tuJCTSgjY8LW6+kknbtzC48ZsKbHHpXkFldDQkcIuASWsAz0a/mrXu+0ijeE7A9h85NU
         45CBDY28YLUElxDhwL6JflYcZsrqLKMb1JLPklTtxtmWnwlWGvjAuJRZH5A+1F1ZoMDS
         bbbIIgqSIAGvRyCvBBfD2ErrY/Tpm7kSE5F6u96omcsOplNdTDw5ZWW5iSqgf6+cqP91
         nZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223559; x=1733828359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDHzjBUASVzIv5XHo01cPBl/mjuy/KS3wSX1QX8rkwk=;
        b=iboNZMcQP+9MsPNoz/F8fV02eSDtjnaJQHCkiKtkSDp6nID8iTVkADUSTfVRJsw+oC
         s7gmIAMfnhPU35ouh/BnbXmoybU5pdcPRg/cTw2BctRkzdQ2VkJSR+yvlCthRCGgN14T
         I02NAEciDdVwiNhgJO3XaKkwQwv6WOgu56nZk+vJvMC//H0xwyF6ulWw6OtBFyHp7lc2
         ZUWYl3q2I1fB11VoSSRSLhMJigbQBQjX0Fuq0M10Sv8505sANiCLs/FzqJ1PTawuaNCI
         pmjpPh3uPuClBWbk1KI+vczYMaGFKMA/2zT00ljFDWu2EIeq/MAwKWlEcKwOGC7Mtiit
         gFKQ==
X-Gm-Message-State: AOJu0YyEAbo6ORaqk7oUy6GZKSk5jyWTzM4syJlxI9ABv5CLoUJ7Au5K
	ANEDHvv+8nnT93pP3lIBhgwpuHCH/ODNoQ/D3X75xxzLpD1j2kBbZuvUETm4AiHb21x2j3wdhCv
	lP3S/Wuc7qDTV9J2Bwh579R2KPMh5U5IQfxIp71AYwe2tq1Ft48yN
X-Gm-Gg: ASbGncv+Am+Z8xJMRxx2yCqo8wLn/MjiKwOON3kwnQNbd/b44C6y2Oz+Z5yBF+/+Abw
	k9uvhW0BWrTFQwotIIN7+DVUpNRe/4yQ=
X-Google-Smtp-Source: AGHT+IGyc5NU8ysDL4mfaFsYQbnblxssdT1Yh2ADh4vlkpK2qkF1Pi+zaG1B36thMUxeh7Nb/SoABC0icuY7VRRNpnA=
X-Received: by 2002:a17:906:2932:b0:aa5:3d3d:f959 with SMTP id
 a640c23a62f3a-aa5f7dbd388mr142684566b.29.1733223559461; Tue, 03 Dec 2024
 02:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8bde975e21bbca9d9c27e36209b2dd4f1d7a3f00.1733212078.git.pabeni@redhat.com>
In-Reply-To: <8bde975e21bbca9d9c27e36209b2dd4f1d7a3f00.1733212078.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Dec 2024 11:59:08 +0100
Message-ID: <CANn89iLoQhK36PV6-2iizyK+LnawKaPdqOsXzHCSPt36=Xeacw@mail.gmail.com>
Subject: Re: [PATCH v3 net] ipmr: tune the ipmr_can_free_table() checks.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:48=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Eric reported a syzkaller-triggered splat caused by recent ipmr changes:
>
>
> The root cause is a network namespace creation failing after successful
> initialization of the ipmr subsystem. Such a case is not currently
> matched by the ipmr_can_free_table() helper.
>
> New namespaces are zeroed on allocation and inserted into net ns list
> only after successful creation; when deleting an ipmr table, the list
> next pointer can be NULL only on netns initialization failure.
>
> Update the ipmr_can_free_table() checks leveraging such condition.
>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+6e8cb445d4b43d006e0c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6e8cb445d4b43d006e0c
> Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

