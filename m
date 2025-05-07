Return-Path: <netdev+bounces-188734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A4AAE65B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141D0524D55
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422628D8DE;
	Wed,  7 May 2025 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU1N0ClI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7B28B401;
	Wed,  7 May 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634450; cv=none; b=ZdqyKcBOHVQMy2yhFbOvtG5JeO59u63+bzYEPXA8VJt1ag8vbxvs9hMukjYjBsvsJahIoFHTnhS7bj5lja747oG580K8T2EinufuUnVpDMmCfPhtqfkZ06muien86SjssJpxHYc2ZRBck4FkET16e/25lw9neIukut3b3o9NBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634450; c=relaxed/simple;
	bh=2MVV8xINyxCNm/DS575JJnXRJ+nCXL26E2Elr/M0Iw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fS4OvXUGnwh68q7vIO5p4QHSvcIb5xXvIKNdNxZFGTtD0A8fv579W8eHgnRGgNA0qThqGLJ59m+RjomK5MIBvEqOsT2HFnNHTaaW4AIoPIxhdsq3zGUM5y+q8tgyB1G+gEUk73jvk83wx080HOtcCMzb0lpk4ndx1UFZpsIy5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU1N0ClI; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e78e3200bb2so47052276.3;
        Wed, 07 May 2025 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746634447; x=1747239247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilTmrFewRq0VMvQLuBvVxexC2kYGKl/rJuTFHOR7rQk=;
        b=KU1N0ClIDQpVLhCsIRMLUafm2ej9SfQ/RlfWCCN5Q18406QJ9PJ/E6nNH1GApDuW88
         W1anXhwqi4yyPu+Qigb65jGOxqscp2QJmzti0iI2wCWHPHJv9pS/sRd9ix9hHgL4AQZX
         goZ3LRjZkVQS97BZzhPjhrNV64FaphPGcpL8u1wYNHeZ/VlEn3kThzvEVyOUCXSP6IcR
         YmrEItm7UZsEmSD0NPa7NWPStnZksXNy8qNlWN019Jlavdd7ncfV41QrkpxKp88gjayi
         6IzERaTV4AS5my12Knw0BDLtmt3YhX9/VebaWnWNlmvh1q/QQ6dNcjilHrIXdWNWO/sE
         6e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746634447; x=1747239247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilTmrFewRq0VMvQLuBvVxexC2kYGKl/rJuTFHOR7rQk=;
        b=RrrD85jL2/yqnWkmVjhbk65W+5G85LaXdySGEOLTvcGj/M59yVfJhLyXUZvDWjSbMZ
         nsv2HshAN210XQ1Jr+VE6pdIQZcMUujQdOUfWw173lheREKKZdK/LGA9Y/5XokwRvipW
         JUVcp5nfkURvIl1xi+PIPNtS3UnGmccEaJ8nollu+Fh96gMmfbYDOxscPQslXz6AFx5s
         p9omm0v6Qvt/hSpfSjKm+1EUitndwFQckaWPARDasOGsTF9aqWXZZYfzcNAGxRA1FZnp
         udXdWp0anFoc4HMyrRa71wqGV1lcA/8ft79baF4n4yJ4i+g50oeMzh/6zPx1RwBO71Rr
         etNw==
X-Forwarded-Encrypted: i=1; AJvYcCUg3oGO6RSFC1c8xNCk4YnTCdruYMQNdYrVYMAhP+kpMtV8+nZRtMkUxnxeM/fHn6u4p16V/IvM@vger.kernel.org, AJvYcCWh2eDO9pqJNzqIPomkhD978pvhKjoAgDr9N1FRDI46nqP9sgVO875wQOAZZV1FI/hoJPiNlznomRgD/Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQTmlxZ9T0m9b0l2jViTIETU3nCtg5IaqEBvj/vO5c3+ui19R
	vdFz0Zmtdinq/NVyE1isjWvPGF+H8Yt3F2Yx84CJDri10x0GQJkl08QZiB7sB2EzQkq1Tuvnmz2
	4dJdNJtazzdQXDIe+hxc6aNcnfA==
X-Gm-Gg: ASbGncsg+B3sKlzELgYhjeMuIAxOhguwQeJ0qaMrtMFHCzU9dHZhNE5tBg1r8v5I/qO
	ahzt/DrHAcAzVDQvxZIlhcWZIj7HxsNORV6TL0djZEhpwdOI8KSlPguLB3vlv0NPeAIJDJhLQrj
	oftmD9GGN65Y5Gbd3fMDfJ22rM0FcOQ89bmDoz266RR9k1u2WUsXPr41yricNUHqHECg==
X-Google-Smtp-Source: AGHT+IE8pK7i1kt1Hdo2bzTWVwb0MpJS9kz4YeaspNF3UemE633NGvAFwz2d2ctRmJQGwYBYHMhb8/QvfYDcrBVbAPo=
X-Received: by 2002:a05:6902:1882:b0:e72:eed4:ff91 with SMTP id
 3f1490d57ef6-e78810d203amr4707494276.24.1746634447424; Wed, 07 May 2025
 09:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjTZvYKHWrD5m+RXimjxODvpFPw7Cq_EOEuzRi1PZT9_JxF+g@mail.gmail.com>
 <CALs4sv2vN3+MOzRnK=nQ_uMXbR4Fi8xW9H8LdX79vYA7tHx+2g@mail.gmail.com>
In-Reply-To: <CALs4sv2vN3+MOzRnK=nQ_uMXbR4Fi8xW9H8LdX79vYA7tHx+2g@mail.gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Wed, 7 May 2025 17:13:56 +0100
X-Gm-Features: ATxdqUFB6URjFpy44M0SJum4t6pDOiD8FK8mxckY_gJ-grbPxIxF4oj0UAjwz6o
Message-ID: <CALjTZvbopTcm9P7Hp1ep54R3_7yODg7r4j=OR2y3WOA1X84e2Q@mail.gmail.com>
Subject: Re: [REGRESSION] tg3 is broken since 6.13-rc1
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: mchan@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Pavan,


On Mon, 9 Dec 2024 at 16:30, Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
>
> Thanks Rui for the report. Sorry, I did not expect this side effect.
> I will check and post a fix/revert patch.

Any news about this? The patch you sent me off-list is most definitely
required for my machine's tg3-supported Ethernet controller to work at
all. I reverted it and did a quick test build, the result being...

rui@happymeal:~$ uname -a
Linux happymeal 6.15.0-rc5+ #169 SMP PREEMPT Wed May  7 15:05:44 WEST
2025 x86_64 x86_64 x86_64 GNU/Linux
rui@happymeal:~$ dmesg | grep tg3
[    1.226623] tg3 0000:01:00.0: Unable to obtain 64 bit DMA for
consistent allocations
[    1.226718] tg3 0000:01:00.0: probe with driver tg3 failed with error -5
rui@happymeal:~$


Kind regards,

Rui Salvaterra

