Return-Path: <netdev+bounces-209282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12426B0EE34
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC813B8AA7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA94286D4C;
	Wed, 23 Jul 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai2CO8Vc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926C28640F
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262215; cv=none; b=MkoXLbot7PGG6GIcqY1j+kQp6zZ9VI1+Afj3lSJFlQb8xHkxEX9PhyhoPFuXNUSUwZg/7vO3DEVVW6Td1iiVOuYV1zr1PInpl5D/sZYGU6Pr/5D+hfkfh+9JNdXP1SIgznRYF8Hh3aPrmhBupBnRnEU1PgckmCrhoZHEwvvCP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262215; c=relaxed/simple;
	bh=WNEdK+X8/H3Jn6TQsrOBAz3zjhUyJZ8L61bmgaGSpKE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=DGE5Qx8jjyIq0tR2sFJgkS8+Givor5dCp6g49MNfcSBgdiGhoC9PIjk28c1nudNvxW8rW6gv9cT7AlA9/vlm/YHNo2yjYG5f+731bjS5BSQa59dAcbNh/6+yJU3VTcLChCj0fQIYkm9nQCquuwdPXdb2olteHomnZ3ye9GBA1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai2CO8Vc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3652500f8f.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753262212; x=1753867012; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNEdK+X8/H3Jn6TQsrOBAz3zjhUyJZ8L61bmgaGSpKE=;
        b=ai2CO8Vcp9DQKDMtqddj7VoE2zPmr4ckwJM3L8/lShI3WfLzut1tPcnDTIK468n2pW
         Qph5sw4bbLWmpTNe43s4xE4InQfsQm08XU4VVe7vGvrYat/iHkOXCRj35EmDIDgxOoUP
         CgYDwsYxXhor6fH5pXI6U4iTyQc4Va74vIa4I7T/8L7esJvTWpY12nwwC7566DdQ3ahv
         4v/NhPU0QZJXmLi/4cHoEpyA6gZRD2z7/PFNXT6DWKDVuRBSlEzwZTqAC9gvG3Tuj83t
         NC/cTLGsRtniGgXNJgakqnHknYyAZJAvNpzZUEjajdBcaBo/Yk3HHsFOhOyWb7UPOTmC
         n4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262212; x=1753867012;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNEdK+X8/H3Jn6TQsrOBAz3zjhUyJZ8L61bmgaGSpKE=;
        b=xM8nfWvybWQaYtAPa2babqc0Y6Rg5zBmOju882smS8G0FPQs8cd0xuKOusozhvMH5H
         1aYu7feddxO+bvAjAtlouCrXLnMoYF9S/8fJrhQ180/ns7N1Xnkb1XExDCQopXMDN/YZ
         3Y7SQtvEIAN381Y60uR38dUCd1s2FTCJyr586pB9UB3/5BNW00tMeJHfXYKmSCdhq371
         20jRUj31vvcYKbrvmuBLzJzpUIS5RXVKt0aSANU2GAb/SKssfcdSlr7jd8TJ0yfYJtmn
         SLE0eUEW+guaQwe1E1sLhOtzrjgeguHW+K0fSh/7vVTEGlhAaH7xGrx0qvboaK1PbCOJ
         9/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOVXG8ksdeejzuYpCpbUi2OuCOxuzmndzkxvxamyhehQyhXKOr/c31nYU9Wf+axnr4IvD622M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEfteUUY9T8kMF54qvHBpvBSOkxLbdhCr3PYz1NeocuW5I+Wc
	xm06xgjWWTP1Ztu1YYLX8O7FzFlce1F8w9avbNOx/LR2M9wFzgY8F1zW
X-Gm-Gg: ASbGncsvcCiPzOttAaqMMRRR/I0894w1hJ/FdtWPhgrh0o5NyIswXOy+IolVf7+8LHL
	w2UXk/BotN/VdWUa+3GHMJ3B3KsiPomOQ0oP0ATWXr0xHtnDHPPghw9ES6KWMp8pIM/EmgJV4LM
	VPbnc/gCSPlemaZJDSVov9Lh2sGttrVDcGKwaGxmzU7m64pOFTfWny9w+1yL75JQqAD14uPNRAt
	bEJzW9Ye+mmo4l9Di1drF051Dcmkwog+bigjAp8ZJE5NyRk7HV0JS512bsEGbmK7e9SUcezwO6K
	5Cj6UK4YfjcdhqO7drhRpkH6H1zGOJyz9uGJ3dthe51g/gc6HNRP5LVvufR+0rMbHfFKclTbWl8
	uykoKwQGD/15Tw7ZIzWM8nkl4NK3dlBK9nQ==
X-Google-Smtp-Source: AGHT+IFaO7ZqlFTQWT3p5Ftv+EtT1W7F2/CzLZlZbN7Ml1L8eu00BAZY1qQMNFqDprK62vVVqiXubQ==
X-Received: by 2002:a05:6000:26cd:b0:3a5:2208:41d9 with SMTP id ffacd0b85a97d-3b768f23081mr1570838f8f.40.1753262211748;
        Wed, 23 Jul 2025 02:16:51 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b8c1:6477:3a30:7fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d807sm15943766f8f.73.2025.07.23.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:16:51 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  almasrymina@google.com,  sdf@fomichev.me
Subject: Re: [PATCH net-next 5/5] selftests: drv-net: devmem: use new mattr
 ynl helpers
In-Reply-To: <20250722161927.3489203-6-kuba@kernel.org>
Date: Wed, 23 Jul 2025 10:15:58 +0100
Message-ID: <m2cy9r9sj5.fsf@gmail.com>
References: <20250722161927.3489203-1-kuba@kernel.org>
	<20250722161927.3489203-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Use the just-added YNL helpers instead of manually setting
> "_present" bits in the queue attrs. Compile tested only.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

