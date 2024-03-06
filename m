Return-Path: <netdev+bounces-77984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA08873B2C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99341F217D5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02813175F;
	Wed,  6 Mar 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlkHDQ2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE121353F2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740308; cv=none; b=Y6fiiCpGTXOCA4XcDMpx/FFa1hoQz2nVwO0MAqaW5o5ynY44BafOGns8nrVRQBYSmh6x9E8YIuwwstllJb5y31Fak7OTPfL/FrzgSTccyPM7wwW2GDl+zU9IQAXhfKsZnK03qrKyTOapysCvBlyNC3bPL3SMlMZI1sFt3or060g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740308; c=relaxed/simple;
	bh=cwbmj7CV2KdO91C8oMQjM4dxoqo6PHXhs54GIyOeVk4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A/QZa/nN1eCRw1vKefZGyitT+nrYRgKDgPQtxVHIpJW4heYfcIE1GKl4M+aQ94+Eu4lPaqWLZx3lJOcT2snXaPUDBOF8tpl7be2gxghcHGSl371gNxtUQvvqusbSpD1Z3XuWy9q6iRRpepOqH/ObC0pM+arhlfXImkRts8p6zeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WlkHDQ2o; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso10543587276.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740306; x=1710345106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qcl7RXkDOE6cLB6HbRfNrbcLe/Cl+NEaXl7ho93MHzE=;
        b=WlkHDQ2omQ+4QnggTNFXZb7PLC6AAPSXFbr/8LLxKTSb2FLO7QCOO+bbdVZuUfPC+b
         jieDDDmhVzNQHH1MRNPEWr/KELxvcrvBROCVdiqeOgawDBv69Q/ufxpksg+dWSy8fZvl
         33ByXCxwasMvH+YeM+w0RvYx4gq5AorC3PeEQvrMsN06HzyyAA8noEo2hqgqMzxCTdhc
         PK41WqrdkfLZjs+sfRFeHIB9VkoDXrqMx5mRNJVj9wmPTqh2iTGGpMzn7Rh5Kt/ceoTP
         Ykc4z1OAYOEPLFfbMepEQnHADZm1A1RZV4K3vXXK3UTlJ3Wew+5KWxjEJSiWAMlYOsBM
         4ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740306; x=1710345106;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcl7RXkDOE6cLB6HbRfNrbcLe/Cl+NEaXl7ho93MHzE=;
        b=VdN6LGgofnG6nVzLFZY4NmZiTYEFIREBk7BY1y5lkkoX7/EfTSNk1hS3KIEud5KwGq
         6LxlZSLALxqKc6gvFjahcc0NL3dpb+FKzROuqYISGXB+BEqrF6ogy/3G+TGFuw1E3xk/
         zhdhRjdmP56R0vp/N+jlAlTmEtf4/oJ8VXSpT5sq1ssD0Si7ZlelXIG3hMiL3zj0PQBQ
         ie8KPrPwOi7yN7g1hj64qLfZw0h/+uF4HxtcghurMZWyO+fL/f4soxjFUXf2ABs9vJDr
         ORkjS0Wbim8RZighGeXO6aJ3NUQyoZTiEgMOVnPUSsoy3cQaKaqJkQUQM20EOqJaTayG
         s3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWtWU3s32VXZ0bmsDgE3zNd6YIT+Tzm7Gc3i6za+q/mGTtJmPjAI/uk3XsVMMglDYZI8iyuv6gZQXgMLyfFu+GQAWSaV+s/
X-Gm-Message-State: AOJu0YxCRGbi/MGFQOtVo8Feo8KzIWHkalXPYr5s8LpN1xy310kYYKqH
	7uvT4zz9n0Lm+rCcSZglrXVQuqmQ0A5hYKm7Sq4A2ixH9goAsDESHZ6T6PIhG7JXY5wFXU9Vapq
	ujX8Z/MHE8A==
X-Google-Smtp-Source: AGHT+IHruR9sOiEN1Puis2xs/LlPy9GvSsim5MPW+MZiVlJGbkJ3LCJYG7aCAxApJokeOd+4ZpA3XS1d3MVTBA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1249:b0:dbe:d0a9:2be8 with SMTP
 id t9-20020a056902124900b00dbed0a92be8mr606090ybu.0.1709740306410; Wed, 06
 Mar 2024 07:51:46 -0800 (PST)
Date: Wed,  6 Mar 2024 15:51:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306155144.870421-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] ipv6: lockless inet6_dump_addr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series removes RTNL locking to dump ipv6 addresses.

Eric Dumazet (4):
  ipv6: make inet6_fill_ifaddr() lockless
  ipv6: make in6_dump_addrs() lockless
  ipv6: use xa_array iterator to implement inet6_dump_addr()
  ipv6: remove RTNL protection from inet6_dump_addr()

 net/ipv6/addrconf.c | 168 ++++++++++++++++++++------------------------
 1 file changed, 78 insertions(+), 90 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


