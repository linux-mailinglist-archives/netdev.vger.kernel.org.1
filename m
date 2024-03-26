Return-Path: <netdev+bounces-81871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE0C88B736
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACA81C27B05
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C794DA0E;
	Tue, 26 Mar 2024 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eznz2EgL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5751804F;
	Tue, 26 Mar 2024 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419275; cv=none; b=ZXosnZv3NK58u57NkeWDmz+8AHS5ofl29iJn1p+81ulWZ++zxN8G76KmDqo1LNdkdEstnNOGrQc1simTBhIu6Ao3McyOTgoKwxDWiJnS8dv3x/boxbu4kpEw5Xswi/4cUogL+zbSeS+hXJQ9pCZl1hMRf47iwtlnvcNgwxFPbu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419275; c=relaxed/simple;
	bh=pQWj4IDTv0Tzb16Gn0NHU5OIUmfcIXNQkGbwR7mW3p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXJxxWI7GpKedRtdbExyUOymmYaDS2uUSYc5cktXNVMvjWkjO2P5dEjwS1DCnlLCPD8b+aORamzzYzUQ/ZyrVnw0F6BDW+BHUWXw5biVLmdVUvTDtz0IRvj0B60tvevLPt4/7o9W6NlM/mswZ9Z7022yH92Ymne3LjbbgRtgyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eznz2EgL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-515a86daf09so2736400e87.3;
        Mon, 25 Mar 2024 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711419272; x=1712024072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQWj4IDTv0Tzb16Gn0NHU5OIUmfcIXNQkGbwR7mW3p4=;
        b=eznz2EgLIr0nX5LCwnvV+KrwBL/dohomgIP7p0bVOTLzING2RMrB6t2la6nTGz+eOL
         in7jjSVn1TWgKA6UbqzCXmxx6wiqVYmqzZP+P1Q0fpz0of2W00Dx6JuE6laPkPdEPhvH
         KAlUseCIKIZIpqdzGaWpj4vuvADQKnN9H2wseMhWZn6rlXhPBCvtWndUmBDiziTYLF1j
         CIGW5amTv7GhW7FdMIWsZyZx64r+sIrFdxYxcfcKUPVD8UVbqSUt5eaosKmVOEjh9+QT
         wwbIlIdv7yA6qki6hnLt9tp1l2CZOg95eZ5oa+W8i95gSEJ4JJ/CaMJxRyErnvdMEirY
         t5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711419272; x=1712024072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQWj4IDTv0Tzb16Gn0NHU5OIUmfcIXNQkGbwR7mW3p4=;
        b=BWEVbkMW/SUq4sry6xF9ijHGDz0KuVSlp2GsCU2Rrq7fSPbfK2UzkkUhLLEkmPf3jN
         s0iGq1IhzAvKiVyYTos+dQ8oBNPiRVs09MFgMXOSQSkKbnlPIq/SJwWIwTOFUE4TZkmi
         5Jszz+8cmaY5UHMFZ0gUExsbaTW8Og3ueYTBMKw/e9CVe0eHQSd3ObndJnDHrL2JsGv3
         oG1BUx99WMQ2b525eOTCPCeZesk6BP58HgxVzu5k2eFHk7X4d/L8UoRtl/UjZrSsaD/d
         XxAxwQzQ7ZymlOkRH7leSJeYSAauHq+ogdUhRS2B73iO0vB3eYpb7Yp+FsCrDXiXDSYh
         ITpg==
X-Forwarded-Encrypted: i=1; AJvYcCXJu419WMJirJXR3DyCT1OeVlBSbFd0hR5gf0fZZqUS07lQjtKdfjnBN5+SKrO3EGl0MEmUQ/rjdwbHkRTDsQfYtsEkhPxOiCf9JNpGEfloauFq7tQOymZqtoKc7RrmlAik1465krTV8R4L
X-Gm-Message-State: AOJu0YzIlTg20ONFiFpiwyRk5ia7CT0ZFlkG53fMGzMNW5gEfv5ge+DB
	SzTvyA86krnrUVciYTcKHm7WLXa0y0otkyT+P8oBcqr7XfrbP/D3xVNwtzTuDknelAUEWA+rrHL
	SZGzc5A7t9PMfCs3TIOLB8A3yqbA=
X-Google-Smtp-Source: AGHT+IFSHRVh/TYgqUgrp3HlIvCxetPN4ZzL/ZlYxrXsjGMr51KACqt8b9HG2jqI+07FLNNBx5XY0iImkg90H13o+sM=
X-Received: by 2002:ac2:4c38:0:b0:513:2011:3d2f with SMTP id
 u24-20020ac24c38000000b0051320113d2fmr5618995lfq.9.1711419272383; Mon, 25 Mar
 2024 19:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325062831.48675-1-kerneljasonxing@gmail.com> <20240325183033.79107f1d@kernel.org>
In-Reply-To: <20240325183033.79107f1d@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Mar 2024 10:13:55 +0800
Message-ID: <CAL+tcoAXCagwnNNwcP95JcW3Wx-5Zzu87+YFOaaecH5XMS6sMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] tcp: make trace of reset logic complete
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 25 Mar 2024 14:28:28 +0800 Jason Xing wrote:
> > Before this, we miss some cases where the TCP layer could send rst but
> > we cannot trace it. So I decided to complete it :)
> >
> > v2
> > 1. fix spelling mistakes
>
> Not only do you post it before we "officially" open net-next but
> also ignoring the 24h wait period.
>
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
>
> The main goal of the 24h rule is to stop people from bombarding us with
> new versions for silly reasons.

Sorry, I don't understand what you mean. I definitely know the rules.
But the first version of this patch series was sent about two weeks
ago (see link [1])

Yesterday, I posted two series to do two kinds of things. They are not
the same. Maybe you get me wrong :S

link [1]: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D834=
178&state=3D*

Thanks,
Jason

>
> You show know better than this, it's hardly your first contribution :(
> --
> pv-bot: 24h

