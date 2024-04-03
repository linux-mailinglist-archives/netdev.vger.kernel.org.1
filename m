Return-Path: <netdev+bounces-84656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D48897C0A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B30289721
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 23:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777B156991;
	Wed,  3 Apr 2024 23:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHO2cLHC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A522156227
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712186900; cv=none; b=LoxocruKB+mV7YJYlzG9SFmt26Z50bB5PZgfKWcQ4wEkoBDgzEXgdZkox2Q4TtHGBujdNetcWdTq02a/G1HwR/0y1wVoTtlpQRMXycP//sI9IsDnnIhmQouUHLi8HEvJuJyJaWVdZLQNJF7xq0dZQuU4O0OM7Pc8fa6ZkOB7lHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712186900; c=relaxed/simple;
	bh=AlKgmupit+xsDzdQo/IKMY4f8l9iIwu9v+1SC0EGo9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRAt6zNmEN0IQR9gZz0dYLl+Ljc9J4RgPWp9ZKuBF1yXnyPPo0f122L8QCL08JWlgcqqrSxQqaX7StJqG61g/T66Vws6xP39PSaA9orBubpqMKn77MU9QXk0qXPQ1F38Kmh0K6WHK2ea/4KS2pzCgkTo+f1JR+/wcYfRvyv843M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHO2cLHC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33edbc5932bso257148f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712186897; x=1712791697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl8y+FFPCPA+MkGLA0mGvjwGJkU/CALoZPZaShK0Vys=;
        b=HHO2cLHCk2vYilrmWew8FmU/X31/cqgQN9UIBZLQZ0TdK4OBUCTuaOhUNK8hd3bzph
         6i5EfkkifDTNzfD9KxcgnQKqagTIuQWww5lOYsrCblhI7LGM8Bf8HbiJ92U6ASvuKGEp
         xMmBOlk6edfQel+WXivp4XU/y+WZDKHtRkdOMlwMZWgOZqbbCw+Nmbyamt0l3VLELxZd
         TJ/wLUQsWFuOP7C9JZZnaniIrJM5id90vLZgb7GMlU5SGPR6KM1nBdBJAaxDAIRym7xx
         x3bLRExCFAdM9HZHIoplztHbit0cORYG4OENN0YPJEg6l02lpbhXPTP9HrgK5i916ofQ
         yw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712186897; x=1712791697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl8y+FFPCPA+MkGLA0mGvjwGJkU/CALoZPZaShK0Vys=;
        b=kVODUW5PwR8r9ln0Fskc0/mGwXRyTg5wYMxdTxeLsj4WwUWo0lZTT12HvsIbikHfWx
         H9foFkUPeiaFxhhCbHfbhlSB42ftZn99u/TyiSEw6mci+HdhRbGi9JV2TY8OcimdVwat
         g84O07PENbNKQ9/EnsqpCggEoBOI3m/7YYGv3SCebhPKxY2nm9s2eMr+9DAQRCUqtqso
         7bY5MMJR7yqlq7vldGeapUzF+pJKQzyaXJzLQpYNWsXBDMLERxlewfU5wtrElnNFW6O2
         UJVf121zYOKavdgS2FnhQs9/zPJvJxe+Lm1gu4vPbhPHBNTEGNG7rXgk6NjohHui4ibQ
         9OmA==
X-Gm-Message-State: AOJu0YyiEBIrk1/nDIxxZ74Sx/J9yczncrC/mVKuGEiQZOuGN1+wfWc8
	sDysc/5zTvkQvrlcsdx3jueGKM743M/L59AN9QOTUGKAiOtGzHYjmBMalzGQjuMujk9ObFzeWZh
	V17FqJ+bpL3x67FPkyEul8Y/V4lM=
X-Google-Smtp-Source: AGHT+IHBqRkcp76PTLszEUh58NtYfOol+YPoG4ZI+RvTHs0mxB7AMN7e9xgpJyXFyOJxAmXjhf+aryH5OcjtTzdLepM=
X-Received: by 2002:a5d:55c1:0:b0:33e:9b42:ba5 with SMTP id
 i1-20020a5d55c1000000b0033e9b420ba5mr598799wrw.17.1712186896289; Wed, 03 Apr
 2024 16:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217491384.1598374.15535514527169847181.stgit@ahduyck-xeon-server.home.arpa>
 <7b4e73da-6dd7-4240-9e87-157832986dc0@lunn.ch> <CAKgT0UeBva+gCVHbqS2DL-0dUMSmq883cE6C1JqnehgCUUDBTQ@mail.gmail.com>
 <19c2a4be-428f-4fc6-b344-704f314aee95@lunn.ch> <CAKgT0UeZ1zzJNOcTbiJYzG0_HeDW2jFKkSSSogR-gU+-mRZhYQ@mail.gmail.com>
 <9992d028-c51a-4086-9c98-006d980dd508@lunn.ch>
In-Reply-To: <9992d028-c51a-4086-9c98-006d980dd508@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 3 Apr 2024 16:27:39 -0700
Message-ID: <CAKgT0UfWO2kC8CiwbifxAqAW9kMtWpObJ6_OyN0780WwNEA-FA@mail.gmail.com>
Subject: Re: [net-next PATCH 02/15] eth: fbnic: add scaffolding for Meta's NIC driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:20=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I would say it depends. Are you trying to boot off of all 167 devices?
>
> If i'm doing some sort of odd boot setup, i generally TFTP boot the
> kernel, and then use NFS root. And i have everything built in. It not
> finding the root fs because networking is FUBAR is pretty obvious. Bin
> there, done that.
>
> Please keep in mind the users here. This is a data centre NIC, not a
> 'grandma and grandpa' device which as the designated IT expert of the
> family i need to help make work. Can the operators of Meta data
> centres really not understand lsmod? Cannot look in /sys?
>
>        Andrew

At datacenter scales stopping to triage individual issues becomes
quite expensive. It implies that you are leaving the device in the
failed state while you take the time to come back around and figure
out what is going on. That is why in many cases we are not able to
stop and run an lsmod. Usually the error is recorded, the system
reset, and nothing comes of it unless it is a repeated issue.

Also it seems like this messaging is still being added for new
drivers. A quick search through the code for an example comes up with
cb7dd712189f ("octeon_ep_vf: Add driver framework and device
initialization") which is doing the same exact thing and is even a bit
noisier.

Anyway I partially agree that we do need to reduce the noise scope of
it so I will update so we only print the message if we actually
register the driver. We can probably discuss this further for v2 when
I get it submitted.

Thanks,

- Alex

