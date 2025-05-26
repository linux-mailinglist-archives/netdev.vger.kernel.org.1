Return-Path: <netdev+bounces-193372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A56EAC3A63
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A870B1891E1A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8511DD9AD;
	Mon, 26 May 2025 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtJeO9/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37F19B5B1;
	Mon, 26 May 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748243489; cv=none; b=WsALZoXPsRV+KXx75Cp4siEoOgPuXWNAChgQKhpDmyueG2XxAwPXc+iz3SpOq9dTI+pbXHHCOjFwR55VY0tOq3xMp9iHmmpxKFywsX43Ct+n9uQ3+vsEx39ZAUQ9z7D3c9rnXk+X2P+83eQHDHdkI6pYn4EXM3j1bOuo/Wzac3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748243489; c=relaxed/simple;
	bh=j9vcmJ4bsZVYfNqI2zJH02TBZ9pju+nhGbTNH9bRCyM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dKV/wTmyATyxpGZ1r3nUAGvZzqOFVaDgKzXayx8XUGMdCLbadwIgP++7RQnquabq/6bgWc6c/mfThITVJLL9OaVNPdX9e6RiEZ/+q2LTQW8C3nSilxL1f04mXl8KkwDjNjX7jFkaBG2//71DrdELyPuoL7g9IqySoRxeH+o+u0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtJeO9/N; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553245cad29so277979e87.1;
        Mon, 26 May 2025 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748243486; x=1748848286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cBY907wiCnUkLWJScXJ1dfdiQqTjZmqM/QrU/G8NFQg=;
        b=XtJeO9/NJ8cYStzn51OCEVJt48Vx881oHgdKJ+JlocS43LMULxQYzMc5PRIq09Vl+m
         Ul+80b2/8jIQTggmWp4XwVrzZ6nhRAH56Zyu+maJjen5sDtbRD1d53GX7dQK9TC1pD2r
         DyS0Ow9TwQnkFUv0nBoesJLwczmYyUJI8V0VbHBF/4ybj4KuO09SxUNa9bgpOp+uYN10
         lBDM1NlS0K9rA9WH5WNu9xHKQzE8Ph8zUJxTlGDXNyLWdSI3mTqNf0Ia4g2Sq1P8wPog
         mdHe3ID/LYylvY3Ifg40ZTBPavRcRHTPllfrmtTzlqaE8lKzYIwRzNYuHfYzyxMK4UBy
         W+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748243486; x=1748848286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBY907wiCnUkLWJScXJ1dfdiQqTjZmqM/QrU/G8NFQg=;
        b=KdXLv3a4cvV0lL94Bk8yluvET8GyZNUgPQPQwMLMMJ5aqzc7sIFJIcDTZnaChBsazy
         cA2gUMe1Yq07m5cRKN0nTttLnuZtxC/6Egt1C4o2m9DlIOZRsmKVhI0tMhLt/kPGDDir
         mSROJSKKXnk+O2o+cZZ3kqg0blvOyT+k1CzfAJeHVLx93n37U9qNurxzvuOPGfndIKuw
         hkW0BHqA4NDsnPziwLHcIY7xBbHd9Ne8I/gzRJQpEdhArvQ7HUiQ4RCOTDsNxa+wrfhE
         eWaRzsOwN71aNAvhVgu64eRLi2e6M7zGqp9/W/ZBumugkfQKcj6PqmgBOAvybsdB07H/
         l4SA==
X-Forwarded-Encrypted: i=1; AJvYcCUcGSmYPjCqfTw83nDVYkmlT3xCcoSZLOSUkusgt7svdwwGP2kpahWfVMSYdSl2jvjmLXKYCI/h@vger.kernel.org, AJvYcCXaFvPWGNkoUta+/2GJgPIhtbcNOuisNq65zWnJ/ycZbcbHR95KDeIRxLCGGPnECgeZsNQFtPjw2Q9LaJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7l4MUpuruLXpQOrcn4TOlUheuedTRhrcdZH01aFTH2U7Sih3Q
	UfVaZPpzOgBDjKdsZMo/G+jXnlsrjUtyIklEt6EA6iQaGEGd9YyU+y8YgXTrtYNI3LQguGvA2OF
	4SKSksdFjvPAIB2Ks9Avehdlt2SoUyA==
X-Gm-Gg: ASbGncvWyYTI9eyUp81xM4jvzGjb2T52J+T+UJMMVTOMG/JoHLZFaFQuPJWL6hzko1A
	pgMyLSO2MbLbWiq+lsqdXbGuhW8uagEI4ODkRjLPoW2ewrrx1IpdDmcXJmpsDxvgm7wCCGb4NPy
	0xHat2GC21ULBJA9HDihVOet2lPVLOWBJwBA==
X-Google-Smtp-Source: AGHT+IFDrcQK3O9mjDh0NUrjn5bbVXF7lgII1LyYTyZlH1zUdfBqg5XfANH+K2Bre26zHgfOTxSALvBFJZX3MqJ7PWk=
X-Received: by 2002:a05:6512:3c8e:b0:54f:c4e0:e147 with SMTP id
 2adb3069b0e04-5521c7ba2f0mr1848364e87.34.1748243485302; Mon, 26 May 2025
 00:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Mon, 26 May 2025 15:11:13 +0800
X-Gm-Features: AX0GCFsUEWv4bUdJ_o3X0732kjLFE8YPM6w_Hf9J5wloJw-OHOmaPZcJDYFpBPI
Message-ID: <CAP=Rh=MXN2U7ydg2f9k1cywF8Q1qpizXmcBg6mmzwpt86=PaWw@mail.gmail.com>
Subject: [Bug] "WARNING in corrupted" in Linux Kernel v6.15-rc5
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15-rc5.

Git Commit: 92a09c47464d040866cf2b4cd052bc60555185fb (tag: v6.15-rc5)

Bug Location: 20628 at net/ipv4/ipmr.c:440 ipmr_free_table
net/ipv4/ipmr.c:440 [inline]

Bug report: https://hastebin.com/share/idudaveten.yaml

Complete log: https://hastebin.com/share/ojonatucos.perl

Entire kernel config:  https://hastebin.com/share/padecilimo.ini

Root Cause Analysis:
A kernel warning is triggered during the execution of
ipmr_rules_exit() at line 440 of net/ipv4/ipmr.c, when attempting to
free a multicast routing (mr) table that may have already been
released or was never correctly initialized.
This function is called as part of the ipmr_net_exit_batch() logic
when a network namespace is being torn down (copy_net_ns() =E2=86=92
create_new_namespaces() =E2=86=92 unshare() syscall).
The crash is accompanied by a FAULT_INJECTION trace involving
copy_from_user_iter, suggesting this might be a fuzzing-induced fault
where the data passed via netlink_sendmsg() is malformed.
However, the primary issue lies in ipmr_free_table() dereferencing a
potentially invalid pointer=E2=80=94either due to a race condition during
namespace teardown or improper error handling during netns
initialization.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

