Return-Path: <netdev+bounces-99451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3940E8D4F2B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABAF1C20A78
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF63182D0F;
	Thu, 30 May 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxQJxm4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED03182D0B
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083308; cv=none; b=Sg1Lg+AwX2VKipIpPNRS5nJgGmCMi8FpibiTb7DSF0S8Z60DUmSR0812526jv4gdw7tvVCCAp3g9475d/1EXkJSfqyTG4Hi/qP3TxwQotJ+kCT7+mDrIzKRRtsdtcBeAnAl5GlhPS1Po3jaMKQtctcmxufal9redX1ARtiXPxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083308; c=relaxed/simple;
	bh=NaQ5xKPuR7VYpNp+74ArNs/xSE6rSRfrC4s6/wDWvOk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CNmypwxgvVuHYYzoqG5MVrwkJrLyrAl49bXGPQQPF3JQxwdelaKSV+SN8C7CRDFjkOKZeW3/YPUQGVfjgWQSFEcqIxsw0UaH+GN1r0WZ5ln1cAUrI/429oXaW2oVgE0wAtunumB4WZIO96BRq22UiBLE6qTwQ/j8tcqyI6UkY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxQJxm4R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4d62ff39fso1827663276.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717083306; x=1717688106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=evO4Qb0QZF4LjU0jNgSSqw+W1ET4O9O/ESFe9syIN1A=;
        b=HxQJxm4R9vt4uDIsQlg9qckH0g03gctPaySikSlmc5YUF83qisKfySd9TObLkpDzZ1
         FR7M8kzkelTep9Pizo9nICxXCZhEGEuihzMTHfpYfReZKwJgvX8RxHKpj6VzjIgvIZHL
         UIJdXmmRRtKbEynQuZJvkTzzWjIiaqlTq8UcAWzSAiFfZtdwbmhNCBkolanXKDDwaPRE
         UDRyFk2qGTNl4W6Oo3UkCGkWIazvWpKZcYmXQ8ykv8sN23nGPQLwNQ5IRjamN/jJ4Cba
         NLmjhsbfo8m1ZSwpaSJb+Pka2MxhPNVJOosc+J1fgK7ffupcbnPX7P4iEVpSkHk4rIn0
         aFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083306; x=1717688106;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evO4Qb0QZF4LjU0jNgSSqw+W1ET4O9O/ESFe9syIN1A=;
        b=tG0uEoP/+W+dI22yAWr+LOY/rRruqwwW58sG6VJPIEFdPR2NuT7iz46nd5YnNl4KSf
         QqRfLsQXOACgkjd2K2KEAyOZrbsW/5M6+HO/qEZdR40C1vPbZwVelA5HBeBVzgiD3JTq
         QQWgZsPZy4LSQtrQjgGjVozrUpj1v4CgMPlkHjktFmNW9wRHG3NVlpSN0fJvJEED2flz
         kGjtwZ5gFHhyCHaWPakwvH5JJdpSDc2wH17bqdC0MtXIU5apIOCseLWosS7J8YMRvBp3
         wfcEGsw/pk9KjhOOuzHCD1SkP8+eVCCFS/WwQ7XDKzfTo5DoBrlDF9zFlBkWMEZqfjBo
         h+7Q==
X-Gm-Message-State: AOJu0YxyT9H5Qpi2eUXE2H0Jq/ZZ34GeH7ZO1PaNZsx2WwP9+Ro/Blea
	HlJM8iDKA13euwI+bELp0aQMsKUVLpAnKlSfcWby/ObLoMlSIE9lp5vvbzdFL5y6Bg==
X-Google-Smtp-Source: AGHT+IHHPkC3bE4qDXjRfQAiVFdgGPCTn5vgcox11LkRi+9Vc70yV+wVXnk2tH2VIVcK6UkxA/VQrmI=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a25:cec7:0:b0:df4:da46:75d6 with SMTP id
 3f1490d57ef6-dfa5a5d8d3bmr599026276.6.1717083306469; Thu, 30 May 2024
 08:35:06 -0700 (PDT)
Date: Thu, 30 May 2024 15:34:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240530153436.2202800-1-yyd@google.com>
Subject: [PATCH net-next v2 0/2] tcp: add sysctl_tcp_rto_min_us
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com, 
	kerneljasonxing@gmail.com, pabeni@redhat.com, tonylu@linux.alibaba.com, 
	Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"

Adding a sysctl knob to allow user to specify a default
rto_min at socket init time.

After this patch series, the rto_min will has multiple sources:
route option has the highest precedence, followed by the
TCP_BPF_RTO_MIN socket option, followed by this new
tcp_rto_min_us sysctl.

v2:
    fit line width to 80 column.

v1: https://lore.kernel.org/netdev/20240528171320.1332292-1-yyd@google.com/

Kevin Yang (2):
  tcp: derive delack_max with tcp_rto_min helper
  tcp: add sysctl_tcp_rto_min_us

 Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
 net/ipv4/tcp.c                         |  4 +++-
 net/ipv4/tcp_ipv4.c                    |  1 +
 net/ipv4/tcp_output.c                  | 11 ++---------
 6 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


