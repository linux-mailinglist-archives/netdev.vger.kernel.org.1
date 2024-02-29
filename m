Return-Path: <netdev+bounces-76143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9F86C82F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069B528AADC
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22AA7C0A2;
	Thu, 29 Feb 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3gb96ck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F1651A1
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206820; cv=none; b=LiowRk6kIS8FYYbDvmwj0VsRkRhGTz7DhtLd42VIM3QYCgG7M0sSCthcl5gKaBVm6cFsHSbDr1umlPQwDoA42D7ZGzq2MBRQM1/jH5AMp8VqmJg5QX5juMUqH8kCZkKlQkJvsptN7fjxBNx83Uoc5T6hEBiNkw/MwBZ/sJlvjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206820; c=relaxed/simple;
	bh=LYZZF1AuWqs2joaKzwLcEsZqCdiNOWjpON9KDM12dTk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QbjzicquATnZGBx2BjX954ynNtqpEELnwB1gh6YJPIU1ghmrLBwuEQhhGBS6pZy1F9L70209gWCwte91800xmYVddR9lm8CEQ941PjOw/LVf159BTGLu5j9eiRWj/jIrlwLTQgPXFXZLPgmDnvm7lu/xEazl4wHWLqshVmpG66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3gb96ck; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60948e99cd4so12489097b3.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709206818; x=1709811618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uun5fms6gziBOF3b+n/YdKOLEOXAceOdj9PS0exN1lQ=;
        b=s3gb96ckozXFtKrjR7eYYzdUUW490+auU+liw9BAwxa/Xl8Lfiv09nxE2ZiC37OPJf
         ULnYI9PNvtKznpvPnA6cuvtTRC4d+zjOcLnk4y+vhuH5pySyXN8jncho13eNEHg9oiDJ
         4HMcEO8AB2FsbYTGKwK+6Kjt1XJh+AkG8ht51564ALdbUda/nYUMS3jvAck9ab3QviHv
         fCsZMEky+7+E5AcreafwGg+UY0x9clCev+7i9KhXqwNORx595pPtyS5j7gzAfMen1O15
         pfo+G9a4ErERCRCqe0J2gpc7Doyg/3RRvhxsLd4SSh29OhQMPPEkUpfWVY2/EArpSSmX
         fNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206818; x=1709811618;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uun5fms6gziBOF3b+n/YdKOLEOXAceOdj9PS0exN1lQ=;
        b=snVaP+gcf9PQr6gEX4PoHWG7MxcYF57n2A6HS2cUkW/j923keJeqwOZg2XxLIVprBF
         4KmW0cJ6qpySKszXJtke1yVGE93aPvNaumBfpVCJIqNs0bNwDkdM3cgcwIVXJO98zURj
         NdQX2QWsDUIO96R5gigDHYYylDmdDYHtXBMjEU3/TT4Sy01rsT3iHbb2ioLKBX63bmPd
         2CMtJswNu5PGeOEjjQzeXZKY6JFnQ1gswIZ+fF+DnUZ7FDJ6aSfKUOlScZ3F2TbYSZLO
         VSuwYDj7ue19yCwOLGHwVamUqgm/TQc+Zpp+BiqhkcA8a3ZtpybLsY8PhAWlFAizHbvX
         T2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUfYjr+tSRUOODTBdMbWyqK319fF7Dor2QCDN1Tfsh8/QJDlASh/k3AuVegqZlox+SYy/QePvwOSe5nBFwBltXTMy0/y0pW
X-Gm-Message-State: AOJu0YzJvBc+eSl67LaqWBcA2/93wpFp+tA6QaTE/VhHcjfoDHqv4W2a
	oCVwPP29VtWbrP6j86OU10cMro5Az5ke8yZT8llI8wu1VOiM+rRsC2RqXKJ4A+1fQbZjwsik25T
	41gL4co7m8g==
X-Google-Smtp-Source: AGHT+IEmsSTuuPIvmqiRGc7YoHJQP0Xl9K2gqN8oJa6jtdGXKztI5d5viIz4jmWUT9vYzw1zrW0QOHyxQnbfjA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:c08:b0:602:b7ce:f382 with SMTP
 id cl8-20020a05690c0c0800b00602b7cef382mr391593ywb.7.1709206818503; Thu, 29
 Feb 2024 03:40:18 -0800 (PST)
Date: Thu, 29 Feb 2024 11:40:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229114016.2995906-1-edumazet@google.com>
Subject: [PATCH net-next 0/6] inet: no longer use RTNL to protect inet_dump_ifaddr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series convert inet so that a dump of addresses (ip -4 addr)
no longer requires RTNL.

Eric Dumazet (6):
  inet: annotate data-races around ifa->ifa_tstamp and ifa->ifa_cstamp
  inet: annotate data-races around ifa->ifa_valid_lft
  inet: annotate data-races around ifa->ifa_preferred_lft
  inet: annotate data-races around ifa->ifa_flags
  inet: prepare inet_base_seq() to run without RTNL
  inet: use xa_array iterator to implement inet_dump_ifaddr()

 net/core/dev.c     |   5 +-
 net/ipv4/devinet.c | 166 +++++++++++++++++++++------------------------
 2 files changed, 79 insertions(+), 92 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


