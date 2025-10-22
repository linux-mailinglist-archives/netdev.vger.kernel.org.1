Return-Path: <netdev+bounces-231798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23799BFD73D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF1F19A5F4C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8F25E824;
	Wed, 22 Oct 2025 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qc/EHNnA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735222638B2
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152764; cv=none; b=WmscsjQog4oeplFfG7uUNY5w7w5mWqOi+hhCTiyi41xPGWlxq7v/E1cfsHgFmyjhdZPfy9XiFQFwtu+05mUDmjcMlC3Ooi8sDy1dFKCrzW96l1gQQuEoVfoRrW3SvsZKa+zC95+s+X4I6QImvl3y1OveMTHEdFE6Wfjosy0vKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152764; c=relaxed/simple;
	bh=NgBRi8tUVN5yYh7DPI/U4uS3U973lRB0/wcmFBtzgUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kjdfUabjPAlLteKUnY0REXkTtjV2Ipx46DNHwm859joHZ0dlht294wwFrxXwxhxCRCLO8GY1oFmnI+g+q/iViF6u0HWK2aVg+JtAiNreZLYYHPJosUZUMFYPYJnaMyegAy7TgeKZfnaKL/9GmqZ/ksXQyI6v3soGy1OFS4tvGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qc/EHNnA; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430b6a0eaeaso56477605ab.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761152761; x=1761757561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsD28wm3nsAnGm5Ka75ENH+2h7LDrDV5IjCCCq827ng=;
        b=qc/EHNnAuDZhoj3m+FmjAyUm/IyLGcvd3/LTaZUMbYOkpcdwaKoRMRsV9czkIpzmJy
         EITLN2tTzU7QGvaFi9sCBHhr8BqfehZY7OpXbtGf/Khw99RqPjMluzW1lw2Xa/wQDxN1
         Fu5WKAch1OqWpySXd1mmjEKwvMXVj346LDr3aCiZXLy8uWIrkG28HNkcuGG3zp0IJep+
         ebjHHwBlOFhgggOI44DHXvWB/aOOqjBSh9/eiu6gPmeiTyZ2EksXALI8sHYSkQlfXPWK
         f1ryYxV4kGli0f12PZpr9+u0ygbvTU7TNuIza1h1YhpN/aHcpasLf+cihEIiMzw4ZX4J
         1RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152761; x=1761757561;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsD28wm3nsAnGm5Ka75ENH+2h7LDrDV5IjCCCq827ng=;
        b=lu5mdj98cB/TVZanPDVOO/syV40C2c/M743d6SXyOKri7Hu7E3qJcPgaNVzjS72hur
         S0pb9djF4mG31CgX82CNci+tMwiAb2RDdJGf+nJJrs+pe49PWYIbMfu9UIxNviooIhUr
         ILsTcIZ/N4zkM5R/Xsu2zNCLGIttf5MGcJ0VfHLdKLY5JxEVThFyS3oWaUhwVeqRTrwG
         stOZ5+auu+33qDmmhNZL+tBbQfGrQy2xxE1x2yqmTDFr6pPtmuEpbnerxuKyD8nVGlOi
         QNnedTKWHM68nQmwRkhJXxs2C6H1jHVdSjOQzA/1LTS8oAmappyg0p+DBYC0/NghbQrM
         A6zw==
X-Forwarded-Encrypted: i=1; AJvYcCUDUsVaf3I5NoDEqQvtTllqBqimMLSo5A1sTeQYD4FRTgtFUvH+SIQqVD1RAeBljKbtQF/yEf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSfZ7ixYzs+abHgZSG61C5aNdM5GKNdC2+6C35+a9eIhxFA2T
	B+5AShPn8JbEXRRiwCIjpiA9Ve4DqMbRMSV+FMc3j59Qset1YNnRJ1T4i2UWUSp7eC4=
X-Gm-Gg: ASbGncvj0PP1Wj5JTWbPkBIxDurpc7b98/JwQbYeC1wNfBJ+CRlrlhGmuRAm0LmeZOJ
	yZuGator0ce9DGWNIt4vHF8BSAVO6dcwLs39uwnqmMKGGOav1r6oKB33QgvWSxmIO77elo72ui+
	FEAQmPfGicYopXs3AtwETuiAGHGPrJQ1QzE0ZbTV1Zcokeni5vsJeicJXhNfABkbAXnMxxePAkt
	TCyOb+0ZTQQ9ie7Uf0ixkZaDT3Ac3hIUgKJArWBXUurKDv1CpAhD7xkLZekpSgj/X6fj8xjgvZC
	dl427/1MqnZDmMzxsAoTX5zv/cG6rYMNn5QIZGw+FjVKw2qot0nVsItEtSOIVwP2+WlA5kzHavc
	d7givMlXXuP2S/IiIWH05/o0F4L5gQ7Lku1jVc4TTW3KFy4Ih4io7uyduk/ORNhcZeMJlyof3Rm
	3fyw==
X-Google-Smtp-Source: AGHT+IGzRtJE9jnwV9ZF0g1PKAzX6y/BSm0gYBqpWRIwH+Lt9MCz+RMkrUYLZZb8PO74y1TH49X5Xw==
X-Received: by 2002:a92:c265:0:b0:430:af8f:1d28 with SMTP id e9e14a558f8ab-430c5223e4cmr339162185ab.11.1761152761353;
        Wed, 22 Oct 2025 10:06:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9770b1asm5278156173.54.2025.10.22.10.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:06:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 David Wei <dw@davidwei.uk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
In-Reply-To: <20251021202944.3877502-1-dw@davidwei.uk>
References: <20251021202944.3877502-1-dw@davidwei.uk>
Subject: Re: [PATCH 1/1] io_uring zcrx: add MAINTAINERS entry
Message-Id: <176115276062.117701.12360717585804633704.b4-ty@kernel.dk>
Date: Wed, 22 Oct 2025 11:06:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 21 Oct 2025 13:29:44 -0700, David Wei wrote:
> Same as [1] but also with netdev@ as an additional mailing list.
> io_uring zero copy receive is of particular interest to netdev
> participants too, given its tight integration to netdev core.
> 
> With this updated entry, folks running get_maintainer.pl on patches that
> touch io_uring/zcrx.* will know to send it to netdev@ as well.
> 
> [...]

Applied, thanks!

[1/1] io_uring zcrx: add MAINTAINERS entry
      commit: 060aa0b0c26c9e88cfc1433fab3d0145700e8247

Best regards,
-- 
Jens Axboe




