Return-Path: <netdev+bounces-224425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E3B84928
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967D8584179
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC42FC899;
	Thu, 18 Sep 2025 12:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB82FB63B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198367; cv=none; b=le9PbeBKzORLXtRVIqo9GbqyqBLbMb8799CFd3hizQ1AYqey2w4XVbSDRtJ/BXhz3OZIHjpW3ac5RabBnSD52nB/pzE9UzdYyUeX/mhsC6/c+Eh8bMJDD8OeQbx7P5/p2yjI8Z4h+Zzh+1djiepSRncQqX0qNNagLWnUJ41CffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198367; c=relaxed/simple;
	bh=BnrMrtsr2AwzNeynM+FwYe/VSFvzmFKnora+bM4/LaM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gn980O0BGPattdNmNwGAp5z09tcIKnyTh//VWSfGrU6IZtTKMnftidB7WOZuLG4SsBX/PWewqwAwcgN/XdTw75j98P4RpqCSrR5rjdY7aLbu7FK7DJif3CB13zT3fQNO+o8njnZymdWXQYMGbjwxEQGlU9tyto2xfGJQ6ZZ2/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0418f6fc27so148173266b.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198364; x=1758803164;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tb5jY5fs5C8DqAcfkDVhoy1uAvDHAU63YQhZVIzsa1c=;
        b=EtJsX9Z2wrnBXVJcylBQUBI3fgGquIphX5+W56s8kaSKOTCuqfy2wl695UFF5c2JPl
         Fuz9ZKFIwxC7Bo5AHrDhrFNz4XVk+AEwyi6ZhDAPh+oIRwN0GbXqOmf2FnuqAnNMNV0W
         Qw/GiLA76ks153SR+eLVXC40jDDLsvY4VYL0HahBP4LS7JCMRRgzWo/3nSYVMGvsvTW6
         OtsX3jfLyvftHS9nYUJzZEG/FnrucZ88K/Sasw2kiviOsN0+m1+NKZEUmvPRYN2hkp+2
         PrNuVsQMMtgh4ONO9R1ddYbsaUBH4OATPT1TGaZ8h8Sy95Ea44SqjnHe1hwH3nXWXcMC
         S1Og==
X-Gm-Message-State: AOJu0YyxZG4yOeitBfm3ccXfk36T1zJzClmlJ6z4z4u5B3AWOjIFKPeY
	sIxcTEFPU5oPf1XTeiOzg3lj/ofoJiTMXYKWSEfdre7RxSGjbC0SiDsD
X-Gm-Gg: ASbGncsYPZBIZVQx31YfZXZf0C/MhuqJFkDO4+8EGZLudC7j9bKP1iWHRvczUT3ZKpD
	byEPPT9M7hETZ/VD8VvpepRG7bEbVCGvNHsZJdqFKLePMy1RsIa+GrSHqx2Hv1nOdoe+u3NHt8i
	lhvPgvyZ7cjP1b1BKnZFC7Zn7DdC+mJp0o6kvAGRbaiKE7hESJ4qZb9gzzw4Q6kMDD9G8MKori/
	jmbWsmDDL27a3+a8dpr5djlKOGGKeq4nSSCcrXO1bz/Hk3gaFTI6ZcxJeYlGxDU9QJPIl3qx/V2
	3CVLzimwMrgq2LuJWxFJhPXQJ/txNQEAj/+DVW+BzqX3JI0OlGM5ul1tQX/W0IGFrCy9XsqYnHh
	GEgOG6AFM0R7D3GydjUp5fTp3hGyFcXLm
X-Google-Smtp-Source: AGHT+IGEfoHakw2xql8ZehfjfPaOLhWCCVd10JLLYxDRAxbcr0o84RQ34UJ57G2Uqs7u2S8lio3MaA==
X-Received: by 2002:a17:907:2d0f:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b1bb50c4172mr608468566b.9.1758198363665;
        Thu, 18 Sep 2025 05:26:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:44::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc73ba6c0sm187053166b.24.2025.09.18.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:26:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: netpoll: remove dead code and speed up
 rtnl-locked region
Date: Thu, 18 Sep 2025 05:25:56 -0700
Message-Id: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFT6y2gC/x3MUQqDMBAFwKss79tAtCqaq4iUWjftiqySBBFC7
 l7oHGAyIgfhCEcZgS+Jcigc1RXh/X3ph42scITGNp0d68Eop/PY9+d2mXHxve9b6x92QEU4A3u
 5/9kE5WSU74S5lB8mS6bBZgAAAA==
X-Change-ID: 20250918-netpoll_jv-9bf6f640f308
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, efault@gmx.de, jv@jvosburgh.net, 
 kernel-team@meta.com, calvin@wbinvd.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=leitao@debian.org;
 h=from:subject:message-id; bh=BnrMrtsr2AwzNeynM+FwYe/VSFvzmFKnora+bM4/LaM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy/paOttH6yMEPbyggzhbIa4szrf811dI+6EWz
 bNb4Neq3AiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMv6WgAKCRA1o5Of/Hh3
 bQaFD/0TW68QYyYiEtNVxKw5NsP5fz7z7VNSRNZT8Jvwg1rpeuAH9WhzkGyAy7V7h4Wlr3umEAU
 O7/1hnRmDEHTaePy7MuIYWKOVWq7rFTfW8aX5FYVDmB/mpqTs0uh1S6gxXidKW1vfqv/q5zfV9S
 1XtB0hyuLq+4PyZI503bfVan3lNpgqlfeRCNP+r519FU82XipJKjdhjO+hMxG/XPZw0Sz1bryqv
 fIDnuh0toMlrgilg0dRlJ6GALvzTIEPnqcgiacYBrzmiTHlcraoULnynitBERD8rEyVchgdT9fZ
 yPYmdDgl6oQO7yWDONKqPfijjsbAG+HFtk9agdHjVAMvvldXYQ0xRRCfqL4LmZaa6OaN5s2C7E8
 6QnlemA3YHpopUvTA/WExxTowzBn2DFAWYvNrgqqQFgQ6LxAoFZUR25aazVcEYTDSHJJka0Waen
 J8tu/P+7eziRCFkFwaHqAZRkadX5MsN4hODQYno0kYQrbYW2YFHb4JKUfZWTda1sJjuH5GKgF6Q
 Y+bjTcU7r+6OVSRcuT6mw983Nigcn7tmuOj94bWvIP4kpKyyuXZRwffVEVbhqKp5vOtRQSAVhGD
 cm+IX/IN3mFee+B5KiMa1lR6y9XqjQpbqypKgU/nXabmRrRO+Ubt78Bsgk1F/6s7msQRPHRsuXZ
 /oZTBHnjD5nactg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces two minor modernizations to the netpoll
infrastructure:

The first patch removes the unused netpoll pointer from the netpoll_info
structure. This member is redundant and its presence does not benefit
multi-instance setups, as reported by Jay Vosburgh. Eliminating it cleans up
the structure and removes unnecessary code.

The second patch updates the netpoll resource cleanup routine to use
synchronize_net() instead of synchronize_rcu(). As __netpoll_free() is always
called under the RTNL lock, using synchronize_net() leverages the more
efficient synchronize_rcu_expedited() in these contexts, reducing time spent in
critical sections and improving performance.

Both changes simplify maintenance and enhance efficiency without altering
netpoll behavior.

This is not expected to conflict with the other netpoll fix into `net`.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      net: netpoll: remove unused netpoll pointer from netpoll_info
      net: netpoll: use synchronize_net() instead of synchronize_rcu()

 include/linux/netpoll.h | 1 -
 net/core/netpoll.c      | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)
---
base-commit: 64d2616972b77506731fa0122d3c48cb04dbe21b
change-id: 20250918-netpoll_jv-9bf6f640f308

Best regards,
--  
Breno Leitao <leitao@debian.org>


