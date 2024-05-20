Return-Path: <netdev+bounces-97191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE988C9DA5
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5081F21621
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00F12838C;
	Mon, 20 May 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyQ19cKZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F4126F27;
	Mon, 20 May 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209156; cv=none; b=PDysRp6oPvz3OJ0rwIXvTPYJJJJ78UPVwQLnjpXBLiYmvAlmXLNI/J4MmHFlC+0/L50VXHxxsR7xz4CrVZZOtGtqbL1vwsBYfpu1nXLWo4R6c3IeST93bEUp/uTcxFLdsVp7EajEcN7E9MytFsJHjql9n08KQOK4rv7PA/QDmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209156; c=relaxed/simple;
	bh=3HjQhh0Jtri6JUoMltVGxCLwnItKnNtIYws6GMWQ/N0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gxtkMfnQzN2QbiLZo4jQ2MJh76dd3947r+hlK8YmevJ9dynZVpB45JztlwZdZhq04CKr7yv3oeeybumMYVSZGTXwWrLOoc4N78uoGrWNQITvNhg5ceMq5P4GtX///m6LkcrDqaCu5sKRjv4G/gSI1AlyFyDEJCpZcORU5D+ji2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyQ19cKZ; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-6a3652a732fso17773546d6.3;
        Mon, 20 May 2024 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716209154; x=1716813954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3HjQhh0Jtri6JUoMltVGxCLwnItKnNtIYws6GMWQ/N0=;
        b=iyQ19cKZ4XCLD7UQrmX5uTW7BmF3r+NM9yiAQQeRf/6f+zkAUn5lwS4z4WtPwn9tOg
         czl3Vm8xLh0vVW68QE99eWVwcFfb1Z8JX4yu/Ypdr6DNp69pjduMQr7H1TRg4xzhelLL
         eNHB6I+p3PQVm+4DucEXoUjAe7AJbsNXIL06zE+HxzscnIg2UUksEP/ImzyjIi8OKsbg
         +KwM8v4/JhwZD86jebcmsCBTTsJNwxU4cARkZPI23b+4iwomAc/IxyJA4m1+XgJmxiRl
         WX1f+qmxZYBA1ZhC5u+UcxzmK9zOl+3E4x1gcnb1e1Hwt5ZW9JNeFjooEdeMBMCd+BgE
         fAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716209154; x=1716813954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HjQhh0Jtri6JUoMltVGxCLwnItKnNtIYws6GMWQ/N0=;
        b=WmkPZdqjRiFgMNS6ooRr133kKYW0ol0f6oNxbbuBvYq2JUxbGkyWfnWoPfdeexFr+m
         PAwF/HS3ck9aOFCXn9MZ23xxygJwgm/Bydokw5jSjp1CCySIaQ9fc+XJNbdUW+kI3jlB
         avsS7HXfpKq0JvpuTxXwyUVQ9iUQU5bbqxk8Kthx2wUkFJEcMKV7c3mHq6BZLHMfXxIu
         mhL7BeoLJMmxyqUOp0mXzNP7xGWNv7RZ7V2LugO7fZJsGRSjelrzvtterO3rgY90xZPf
         LDj4U8z4lX1C5i2eS8owoQJV5LnOMEv7dc/BSdSpEt11TNW7wxN61els0g5hsXRxQVek
         HVXw==
X-Forwarded-Encrypted: i=1; AJvYcCXJiMb56fdft77I54bldB/F/BRAm8wkwRY9HOjt2IY24U7OhsS0ijuKO6qlqW+DrEz/y45XD1wMXi7spW719bfhhThYxwyntfkUZb2nhWfduXz8d5HYj1Twh3Qa5fF9iCXzkGJ2
X-Gm-Message-State: AOJu0Ywoodin99KJoTtSfVut6irYY6FVNRi+d5zl/RUev4QkzMl8Kmas
	kgr3ABnwKTDrdJbnyhhU/oxg/qTo32sOi1Vve0V1bAuMLiSK9NKRQHVKW12RgLNrBuqkTXzQeRD
	26ONnufUXhYA/tB8h6JPze8vPwoE=
X-Google-Smtp-Source: AGHT+IF0qaoN3yqiHqdPwQhgfUIl8S0A9cRaiI0qlNOuUJ+71GlWUCw59X79d1FgV0mwfBLZhG2MpI4NcEDFO1JUdxw=
X-Received: by 2002:a05:6214:4b08:b0:6a9:8226:2672 with SMTP id
 6a1803df08f44-6a98226284amr47095956d6.18.1716209154439; Mon, 20 May 2024
 05:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tao <wjd491281@gmail.com>
Date: Mon, 20 May 2024 20:45:43 +0800
Message-ID: <CAHQ2MOD+3Xz5iwGXnnTU41GbtJXhD7jNpeSvm_KW0_dJBx=scw@mail.gmail.com>
Subject: net: wwan: t7xx: bug: mtk_t7xx not working on my arm development
 version works stably
To: angelogioacchino.delregno@collabora.com, chandrashekar.devegowda@intel.com, 
	ricardo.martinez@linux.intel.com
Cc: johannes@sipsolutions.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chiranjeevi.rapolu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm going to start by putting out two reports from dmesg's journal.

This is the complete log of the first boot up of the ARM platform
development board.
=EF=BC=9Ahttps://paste.ubuntu.com/p/H4Wf88tb6r/
The main problem with this log is that when I just connect to the
internet the kernel log shows =E2=80=98[ 145.531887] mtk_t7xx 0000:01:00.0:
CLDMA0 queue 5 is not empty
[ 273.561922] NOHZ tick-stop error: local softirq work is pending,
handler #08!!!=E2=80=99 and the speed is unstable

This log is after the development board performs a reboot.
=EF=BC=9A https://paste.ubuntu.com/p/CwVVMwkcqD/

The main problem is that wwan0at0 and wwan0mbim0 cannot be generated proper=
ly.

This email has been translated from Chinese to English using a
translation tool, and I apologise for any semantic differences.

