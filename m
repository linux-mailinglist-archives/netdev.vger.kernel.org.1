Return-Path: <netdev+bounces-121980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2093F95F759
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF741F2286C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0C197A6C;
	Mon, 26 Aug 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjDwwswv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF819580A;
	Mon, 26 Aug 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691693; cv=none; b=gYGqKCPpQekXFqSSPRUPJnSys0AgtqvcikeNA2BKk+VM0yOUw7IOdIQQCgdzt4HtMBiLrqow5Z+3uyy6+Bgha+CaR8ow9VZOTw+zwikQdGeS6pTdNKNMFfdj1dANN7vQPpDav3TMJV8Lkzigos1E/BncN7ue9MP+glttM25fXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691693; c=relaxed/simple;
	bh=DhQINy8emuwiNbgzqbyi9KMPvIIeKyYfqlD4bGge5ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfAydhTs7oE4G1eXOqbxktvf8DTiyGCeYabXSBqpQwpaGZ0L1/6ZA2Nuh7vvziudlSb8NlsCBWiEgvp0Zb1e7HdttCr5b+KDC9409HeqKTBBEbAy3zTqlK8g4SJT1y2+tx2usKOCU2MhG7+Dd/nQAEnd2tNELAFk795kSF30tmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjDwwswv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so3719888b3a.3;
        Mon, 26 Aug 2024 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724691690; x=1725296490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPffXakIfFxMCJEVPsrLtw6qgc9Sab4DCyzTcF3zkWE=;
        b=mjDwwswvSfPpcWv0fT/PY/eDvHEJ+z0x5Q4eTthDWgomjmrofHy7Ckf4ReG8VU40Rn
         Mdjqt3tEGwiILjObKHGGhviUdCj3g2jzkokJRoTeYqNUogiil3v45aj4ivbY9KlHpezq
         J+3qHBNSt9CzPQGfEYZtSsFqC15S/8myjB7LlydGXMBL0JQKImOf4mblqGOSvmksioib
         lAlYn8pEZEzv5sk0qX7Ljp2fDQyoBosrw4iETDPEULLYSIRF9kJlsGDO6RhZPHvbnWP6
         BwxFZcs3+rYxX+JCeROIT5JBbt86s5YCaEtWkAcu8k+uyhvlPYyCHxTzzpPf3UN2SHuJ
         mCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691690; x=1725296490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPffXakIfFxMCJEVPsrLtw6qgc9Sab4DCyzTcF3zkWE=;
        b=ewINEI0xQvwIY10Z+MYbpKwMyvP5Q7H8QbTzwxc0HBT0Cw/DSi4bmN21iwp9utSFNV
         PEbv6iAvAeN8uP9dg+8l2DjsMPqAeSMjZavY6xw083n9bmjspC2JuFSAhbysqKvqrJVb
         BOh1uozx+IIiK1TPzXATgXgm7VZhRR+syGdPSuJr5srPTC9owsJATDUhHoW4s68mlZrR
         wOycNkyh/O5REsKYYXtx/Hj0fGZ/+9RdIarSZTdMSPMP32sP95ODLUDzezMauQziWGxu
         1KkMJdq9AkMKNrWpwkDPEBG2DSaDVF0FfKVCAdi7Bi7KWsTeoJg0rM+nu9hl7+yQx9/3
         7tzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOGYI/KptvWOCmguMZ3nmIW/DeAqD+8vyCYfACerVic1ke7a1SAKBhRKfAd7Lh1S9DvmnPFe9f@vger.kernel.org, AJvYcCWaOTk11baVlEBKm35a2fFpxgLvEBUVqTOwAsrbUVN6K8KGgUSkRs8eC20k7U6aehhawFryi6Kd5GkZ+w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAKUGvyeZ6tb+a4+QqjpaNv13iaJBHup9g/O9BgcpaEOUrEAd5
	szjhL2qZ1IU1feOk9RMihRplnva12njxm6PjFgHMlN3hSu8qaRcR
X-Google-Smtp-Source: AGHT+IEYhl7qHWc4kHuzZ3cJHyhnGGEKioVWRxd85GeB82xZQk++GESnyZUf9pej0b5PlSJuJlZuPQ==
X-Received: by 2002:a05:6a00:a13:b0:705:6a0a:de14 with SMTP id d2e1a72fcca58-7144573cd1fmr14632944b3a.1.1724691689285;
        Mon, 26 Aug 2024 10:01:29 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143433cdb7sm7223324b3a.203.2024.08.26.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:01:28 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v2] net: ethtool: fix unheld rtnl lock
Date: Mon, 26 Aug 2024 14:00:41 -0300
Message-ID: <20240826170105.5544-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826180922.730a19ea@fedora-3.home>
References: <20240826180922.730a19ea@fedora-3.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maxime

Thanks for the clarification, I missed that. Should I resend my first patch
or should I release the lock before every return (tbh, I feel like that may
lead to a lot of repeated code) and send a new patch?

Thanks,
	Diogo Jahchan Koike

