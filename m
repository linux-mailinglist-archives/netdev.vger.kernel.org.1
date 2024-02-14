Return-Path: <netdev+bounces-71652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C87854771
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 11:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85A41C21EA3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C7C17541;
	Wed, 14 Feb 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsQBFktF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3018C3B
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907428; cv=none; b=LWqTwP/Se2giE6+nbKLpmv9X2hAa7JOfsAoOap3ZbudlZZ9D+AqpuMCztouCCz5nC6g3DTdb3EqolYwqYv9bYyxw5tSyacrFujgngDAJXaZIeTdXRl5ZiJC6+Bb+t9T8PSgVZpxthOaMNRMhu8KzcU8xosxHzqM74w2JTpgGRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907428; c=relaxed/simple;
	bh=AcGZCOvlb45VIQnaaZpzTD3vsn7OICGc6903iqrS5uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aineaVcPSRlcSpW6FgmlHhJNcQWVQj6GXGbaZIocktKP2XbkQBsvidsXEkW443RypTcumdR1VbE80Ry2zBgKAAKY19MUF+XBz5CuoF3awaj72wbDkmkBwW7wtFCpDw/JwuVZRIBt0wPybJ4lmeIj/5ogP8YOceLWSlMW5heENvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsQBFktF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-410cf70a057so120005e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 02:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707907425; x=1708512225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGa8s8kshOzGZJdfRc65h29p+oNNQfUfKoLhkZBXFbk=;
        b=OsQBFktFZnClpgO8h076E+MshKXcXxOUSzS/Fcj3qO4dPJ5zxGaQCDZ/nRtL1PtBRO
         Tp5ewagqlNT7rEgVmCMxTRzM5KFV0fZcndNFebN7YTtVSROy8g/7UK0k0vU2OB8IBylc
         mMN549NRXgCZkRV2YLpx8Q+whPOOyt6ya1ec1Y9Rs81Wzb73SSoNnAHJzGu3g3DDeaUE
         30aYdymC3zbTM4i0aapq3WsICGEF4Ebt+q1WVDCFU1FYNyt3V6RultMaAZmXJddpBwNG
         FrFro2gNnR/uXkyCcX0yz/qd0R6J7AizZywJujcVWOt2VLfytRgBFFE1zwwjWAe63s97
         hE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707907425; x=1708512225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGa8s8kshOzGZJdfRc65h29p+oNNQfUfKoLhkZBXFbk=;
        b=bkBJJUgEAH07gtI7tYB/JrDvqFxjFYXEGt13Y8EkkspkfpotAxAr6PCmZ6Hhy8EyP3
         NZf/gMIx+daWdougfTRZVDtYP9TMOSrjv0QUhHBv3j+MRs7CO2XpfUo9xSrDmcoRuFib
         UynA5U5yLdGHPEFcN9NTwrqpLL7fZ2r8UU+2HVqF/JE7qjPlTPQUH8cMN5KpzFDN1Bot
         WmUM6JLXcIDsjtt/JMqliklb+329fJPb/IpbNvRVQSqK3V3wmYvccGxx75yTxcL47rPy
         EhxahVS4lv8fUJA1WMb1jNP1Ws1KiqGSp0WR1Gwg7MaSIMHhU8nhxQ7MCjHszGCjcpjr
         oUZg==
X-Forwarded-Encrypted: i=1; AJvYcCUhcZlwpP0PNWh4pQCLjokq74cd6i3kM8zwxqEEdihbr1b3r20WtvxTttkF2L7IN5w59l+Z3g4hNlSPU2hHUbmwjY+8Fw+f
X-Gm-Message-State: AOJu0YzvOD7FeSUda390LRXn1Be0vlLnlJh99VzeFnOEI1se1b3lKffT
	4AUmXsun0QAXxiFpV+9G6/YnGZ8NLkkl+8xjjijiLyOl2pHu0m2ZLMp6l8Wj7ZLy+/b6Q/fjEMI
	iaAgLhfcW4ZKbEhvK+QrYNA2E1H0kcFBvph8D
X-Google-Smtp-Source: AGHT+IHnEj6DTgEs8k9eQkmDziRn7CpQe2dx+LWYoVgCYnC31F0gHuyhclq5nHYTEctCkY0/UA6ff7ygWAcf/IwqnHw=
X-Received: by 2002:a05:600c:b92:b0:411:f8a5:f55e with SMTP id
 fl18-20020a05600c0b9200b00411f8a5f55emr19683wmb.6.1707907424629; Wed, 14 Feb
 2024 02:43:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214084829.684541-1-edumazet@google.com> <2024021444-getaway-partly-e055@gregkh>
In-Reply-To: <2024021444-getaway-partly-e055@gregkh>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Feb 2024 11:43:30 +0100
Message-ID: <CANn89iLaXntR3Qtsg_b_FH1CeQ9TDDFQO19OiDDB_sxWfDiSLg@mail.gmail.com>
Subject: Re: [PATCH 0/2] kobject: reduce uevent_sock_mutex contention
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 14, 2024 at 08:48:27AM +0000, Eric Dumazet wrote:
> > This series reduces the (small ?) contention over uevent_sock_mutex,
> > noticed when creating/deleting many network namespaces/devices.
> >
> > 1) uevent_seqnum becomes an atomic64_t
> >
> > 2) Only acquire uevent_sock_mutex whenever using uevent_sock_list
>
> Cool, any boot-time measured speedups from this?  Or is this just tiny
> optimizations that you noticed doing reviews?

No impressive nice numbers yet, the main bottleneck is still rtnl,
which I am working on net-next tree.

Other candidates are : rdma_nets_rwsem, proc_subdir_lock, pcpu_alloc_mutex,=
 ...

Christian made the much needed changes [1], since the last time I took
a look at kobject (this was in 2017 !)

[1]
commit a3498436b3a0f8ec289e6847e1de40b4123e1639
Author: Christian Brauner <brauner@kernel.org>
Date:   Sun Apr 29 12:44:12 2018 +0200

    netns: restrict uevents

