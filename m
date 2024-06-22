Return-Path: <netdev+bounces-105861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDBF913503
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E46C1C21881
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D72170820;
	Sat, 22 Jun 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZKeJjRAP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DF2566
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072902; cv=none; b=GpaOJvzOaxetKXOCWbsyDrHqHlMCriI7OBmZxv5BIL2SRGZBlK7vfNZRJAi7ehaGkKkz88IVEH4nRsFZ85b93w709+xIwHQtvCOCvLGJ9yt4ug+hXBl2eaoyqK0roqztmKN62r+0SKpIlpwh6MigRdj3rycF7C0aIjk55TXiz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072902; c=relaxed/simple;
	bh=bZP+v/ejhsUnlO1AfFZ3rRUHYStZ+pj4sUGDFaIFe/8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rZHv01H8aTZC9c+KtMXNP+3dUkfU0ZdkHfOqyH1L80NAPCYfzJCP+ff1xTteFPXPSIqQuKJkTg6gObb/iQaSGvP31eTrJnLIMz8o/ZFTf5LzAZWZwPwX0335gIIUKEQLV5J9Xc/4Y/HZkgpQ4U9krl2Y7IkHHX9WRyjah7Hf+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZKeJjRAP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6fd513f18bso149440366b.3
        for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719072899; x=1719677699; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZloWYbSldMWF5FXJGR1MP0ZWNhXZKG9jQC2IitEAxBI=;
        b=ZKeJjRAPvwvlEpEkHJYBt8+vVSDT6plTVi1v147DMeEiVvIK0WCYaoSh9335PuwDKl
         qWCMzg57s9hwJCksUtDMPH5Q8gczzFspp+ViW29dAqQ0mmFclM3pDh4YYyIbfdaHbeVi
         /7A81s1ZkY7YRNvUBoZRSeiSQ/27yXNmn8JgylpccSjgVX+lKr/awh833ucjYpcPc8xu
         FweE3KL12aF8lYM6eZbQ936qdHanWETSr9wv2PaA7aRt2PXccbiZsRucY1SBfCcMloD7
         LusIfqXj7miYNnlxZQo5jXKsom4hF2qbYzYRYS6RpURbxP2JBY8nFoOYRA7d+bvJ463D
         620w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719072899; x=1719677699;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZloWYbSldMWF5FXJGR1MP0ZWNhXZKG9jQC2IitEAxBI=;
        b=Xio01VOpRHqDHpqNjPPBOZ79wMXJy8RxrSfbNTOno6l6cxfAfrhcehHemITpOiO7+p
         CXOpc08nAQWeNqihnjkmstfmOTTz3UmXXF7WfRpqWcEKUzquIuUfncoZ6yQqeQFnmO4G
         bqdupwC3jwpH7wZSML2/+GtPbew7L4jglXYThjT8SpTxQE2A8AK/tYFv5A8PFNPVDmmU
         bZMAKl4Ss5F9HUucBiVkDDI+++4aNZoTs9/QdaddSDHLUZiotz/6JXNnNddUcNnui0wn
         3DSDcbf0bwIy1vmpdSB3hm8t4p9oJLUkAcOPfM5raiH9dYoogv8rXFu0+NH8SWzbTnBZ
         54Vg==
X-Gm-Message-State: AOJu0YyBbqHmWz7twstR0AVgGBpCVwXsNKvoxpnyYR2m4BwgVobctxcB
	gyRD/2J3z3lo/FH5irN8kz6++I1oDszQjQHEuzKjuQmzG9zWkOjMjHzRzVP3p2Y=
X-Google-Smtp-Source: AGHT+IHujvFYLI4EDNLt40iwEimU+SLKzmEEtVO+BuCoFohhIqu7FJf1ZUBgRmiPtLS57P3FZGEctA==
X-Received: by 2002:a17:906:ba84:b0:a6f:467d:19ec with SMTP id a640c23a62f3a-a7245b56620mr10609466b.18.1719072898784;
        Sat, 22 Jun 2024 09:14:58 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428b36sm209850766b.45.2024.06.22.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 09:14:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net 0/2] Lift UDP_SEGMENT restriction for egress via device
 w/o csum offload
Date: Sat, 22 Jun 2024 18:14:42 +0200
Message-Id: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHL4dmYC/x3MMQqAMAxA0auUzAZqkA5eRRzURg1IKq1KoXh3i
 +Mb/i+QOAon6E2ByI8kCVrRNgaWfdKNUXw1kKXOOiI8RO+Mtz+3FLAlR55pdhNbqMkZeZX87wZ
 QvmB83w+dWZPgYwAAAA==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.13.0

This is a follow-up to an earlier question [1] if we can make UDP GSO work with
any egress device, even those with no checksum offload capability. That's the
default setup for TUN/TAP.

I leave it to the maintainers to decide if it qualifies as a fix. We plan to
backport it to our v6.6 either way, hence the submission to -net.

[1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (2):
      udp: Allow GSO transmit from devices with no checksum offload
      selftests/net: Add test coverage for UDP GSO software fallback

 net/ipv4/udp.c                        |  3 +--
 net/ipv4/udp_offload.c                |  8 +++++++
 net/ipv6/udp.c                        |  3 +--
 tools/testing/selftests/net/udpgso.c  | 15 +++++++++---
 tools/testing/selftests/net/udpgso.sh | 43 +++++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 7 deletions(-)


