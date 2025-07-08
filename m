Return-Path: <netdev+bounces-204856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1101AFC48C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A125C3B9322
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C7B29ACE5;
	Tue,  8 Jul 2025 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmKOdejG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342F429ACED;
	Tue,  8 Jul 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961012; cv=none; b=axRw49IAdNUu5SkHqT9khBk2XI4gRuBmioH4/UalTzZk1L4kx9ZU0vW0Ql7q5jh/zzsmRFd+pLw1s0X/mtDZxnMlU3djMyBuR4JtCgQlzf3OOS8zBRtLCpJWtCl/3d75ZNpba9XTRzRM3JOwWHi/xMCmkq+v5XKB1nsdqLqKhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961012; c=relaxed/simple;
	bh=HnGdA9rmUNMeqhHzuc3oI+jOUf+2CmsmtVhKZAqAw9U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j1zBuAS9BDpTHgg5X+7kLDqwX8cSBcjpgPVP+WDfum2bM1ge3u17zAdR/nTysPLS8o8r36tn7TkxoTUUrAQda0VM9sbKKNi6O+pQKZIqttIZ0ZNjz5CSxpewIcJ6lFHhEyCg6uzd42s/sFZKmBnh7oqyKarBmNpa4sw8Ovzo5cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmKOdejG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32f144d0db8so22250021fa.0;
        Tue, 08 Jul 2025 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751961009; x=1752565809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HnGdA9rmUNMeqhHzuc3oI+jOUf+2CmsmtVhKZAqAw9U=;
        b=mmKOdejGXhJBjyM6ohwswnRyijqH/BT+P9Jo4JWe4fkZLkxWatJvMtv17H2LPQdHJ8
         g3qVIrnNX8AYZoI852tdPr3DQ7Mkd1/Yym1iLX+8OEGPWlRZlVY+47d3XXpxDHFm2zkF
         DMHXQytQSvfkUJSHEBAU+MmX/hnrt6hLoqEz+5eJeq35UwTu0Kt1lTf0iXKkblXUmAKD
         q3C/qugkRw+YggwSBUNqaHS5Pq4Ulobhox/TCAnWOGpRiKYB6Ng62eTZv+INYAJfCHpr
         EwH9xjKycbNO5w7B5kZ8jqmNt37hT9LQLTazp4irxKcCBZLm+SY9qbwV+v5YpgPMFm38
         iNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961009; x=1752565809;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnGdA9rmUNMeqhHzuc3oI+jOUf+2CmsmtVhKZAqAw9U=;
        b=CoZ6Dgiaw9Jpgx8FNujljtkPb40DKlH5wWMcuVsb2AtHCvtoYWpgw7Au7hErKxeiVP
         T43KIHZ5H5Ezo+i9Edomyop0oa00C+UukTMBxPaJiFuGfP+xjqtyW83115BJ+nKoiO3N
         8+9YMsiH2j0y11tQR64SNtVmVb8a6OYJGU30M08894NEjBmrPWFEa6m+IQhEJ+ND6K+y
         TINvuKWqjAjWptr/BfUz67cYcVUbyVriAVRpfxiQxM6AKjxF4duyaBN6GFaWvEosyxxZ
         8nxZ7DSqHp/IRsFr+mdDCAiRto1oFxWSmlqWAk9nGUtzCpDMzrXt+qcZADmMvNvnEAuF
         Aeew==
X-Forwarded-Encrypted: i=1; AJvYcCUFc9y7PftF7cWfyH2F5EuQ0QbwzDK0Y6//SmgxZPYHFzQfjJoPZsnasbMks4YYme5D4lPE2e34@vger.kernel.org, AJvYcCXukVaiH7Dj+et1Xm9R+15gCT9MKhAWaQAq8voPbHcAGdXZEZQ5ZQpJIQu9gZv52eWujkYavt2l6m+d9g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfnpW8ljWz6izJg/U0UpgNInzpmw7cnLF1R6jWXqh3fuWNdaO
	LUtCww3EpFZchEj8x+Ep9Oz7Mh2RqUyNjQAOcucpbp75Kg/y85Ku1Lgass0o2KT/Qr6kN7HdPJy
	p++U2l+1B0GBBlD83k9t/C316oFrQMbA=
X-Gm-Gg: ASbGncvTSrMXhGeXM5gK/lq3trZOgePq7ggVUEr7l5rbMnV7au3Ld2dnm1IUrOLSjtX
	3ZMgchgn17ehyBgDk5wguyyhB1BjDxzE+gj/0pqgiZscMx5MxkhNwcyvpZcqC5ADg9bGnOdeHBM
	uVmMeqCdN5XgLNTQxxrxCOEbLXkJtNcByl/qOvMVYvHuby4E3yoLZxALSLQ1IY05L0HaJZ/t9gl
	gpX
X-Google-Smtp-Source: AGHT+IG2Wm6AmQWCYYUqcI01Vck/UA6n8whkclDuyJ52pUQ/P8XUD+RthwIWzxq+tcVTZuysM9pJssY2Nnjffth6Uuk=
X-Received: by 2002:a2e:bc18:0:b0:32b:7423:88b3 with SMTP id
 38308e7fff4ca-32f39f58826mr5327771fa.5.1751961009121; Tue, 08 Jul 2025
 00:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:49:57 +0800
X-Gm-Features: Ac12FXz8K146n5yLFjHHwH8kb3cbMN6gql5cJVJTWDEhcLqjGanIzNfGJsQTOPM
Message-ID: <CALm_T+2NP6RguKihvZbi_W61Yutup1ZcuNZBr950TJCGj-p8WQ@mail.gmail.com>
Subject: [Bug] soft lockup in sys_sendmmsg in Linux kernel v6.14
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.14.

Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)

Bug Location: __x64_sys_sendmmsg+0x9d/0x110 net/socket.c:2733

Bug report: https://pastebin.com/YrfrS22B

Entire kernel config: https://pastebin.com/MRWGr3nv

Root Cause Analysis:

A soft lockup occurs during invocation of the sys_sendmmsg() syscall
due to prolonged CPU occupation in packet transmission routines,
likely caused by excessive memory allocation or reclaim activity in
UDP socket send path. The issue involves __ip_append_data() and
udp_sendmsg() functions exhausting CPU cycles within the softirq
context, without yielding, which starves other kernel tasks and
triggers a watchdog timeout.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka

