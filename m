Return-Path: <netdev+bounces-184156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DEA93832
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C309465FDF
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64587B676;
	Fri, 18 Apr 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W6P7/rLf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B2171A1
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984890; cv=none; b=qGeIcvr07IaDBuvV1UhCKxw5F3/b3OuiUXZYIl910mBi+KXqG64Q4XZ/Y54qmU6yspVJeMXoUNZ/hmsL8rpW0v8cRTAXy7VCa5Pgrjbq+AFWdR/7yQBOHuz6iaUUqkOnWlLWhR3lKoGdIOUYSeNgmG0iSWe+W96v0aKkj8dIRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984890; c=relaxed/simple;
	bh=PQJhYQhsMv0MpbePzzjBsZ++F0flYM/PygLw6HSKZcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WlV6DCY+v2ihMW65PcLQl/TXIVkMQR29JNgucYxhctpk3RrQb1okvpYFKejSGLSeAa91HaYdx4bSkmTGwq5HwWkwDcUCiaUOM6yLVSrnP0eKXf3Eiw0E4ZF08sU8kCRfNemtLRyXUIayXW0ypWBlFgB5KbC1eKkrUrwDEFsCV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W6P7/rLf; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85d9a87660fso169406739f.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744984887; x=1745589687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC/BqjM5mkoHmF0ZEZAC3mR2mFzpKmqw2rLh58Lnr/M=;
        b=W6P7/rLf4zuGzWdA7fyiwkikjTJpR/Qsqsc/hqa2BSxttkvLdpWkNddulz9J1eikah
         0fwK7gOvLTDlSgFYpxJBcfFHRehzrdhDYT7q0EoeqShm5dlZ4pD3X1Jxk8OA2n5DFWLS
         XnkID9dMdpXaKpZHQFhZ1NANqs/mKj0nVk0A3uw96WSzhHnGhX/LsmUfIHKMX3bfKmN9
         wIwVXCkEMhps/y9S12IHXAqBjTUZbkPpciI5PC3mNonIdf5YcR2KKNp4F0cBEz0csBfe
         ogNMAccLPBRr7MHcpxLcu+0b49mCiwBEJkjtLIYih0iWxOvAsEw7qeiT0VOgMt7kshgr
         ENeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744984887; x=1745589687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC/BqjM5mkoHmF0ZEZAC3mR2mFzpKmqw2rLh58Lnr/M=;
        b=w+gA/zcrA/6Xzefj1+obLr4QAWC961aLKSY8RkkDAFk5ECBnSZcXgK6IHIEFlNuvvr
         Z6v2lTzjUMagoI95Oto3GOND1yYKDr62bGCOtc1f5mamxo0OfiMqCFy5APbFJSJWFd0d
         nGJNyYdIRJ1oV57UpxhleRjLB1tyouP3FOZa5yloi4+pNk9GRiwH70walvS78piC5CBM
         sXrcF54+hv+VJkYtfFeXS8FvmkI3llneTp7wqAVW7LGb1TW2ad5eyVTpMVt8o4mK0L41
         sxeWEJYqjPBOnPuRHamakWAuYDucwxfqLKZBCmojn/zc3T44vei9g7I5JSac0orFw1CJ
         02+g==
X-Forwarded-Encrypted: i=1; AJvYcCUNBbXsAEfz6dGXhC9Vi89LhiJiwv7WscjzKpKLcqJOQXs0/LtfyrjT4q3LyeOzTG0If7vfD40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxfIqDXWmA5Lfaacn8vs/Oy8IU6ZangJ+A8zxaYDJGYNMEarx
	/UNmxDV7IO/HB2s/nuafqxh6AU4kvkFwxXpkvXiQK8DggQzw88jdokr+G9nctC8=
X-Gm-Gg: ASbGncvIaGRU3jwaVLbGaEWrmihTKOygJNAQ4QKJsqnLWZa3xzOd9aKlKW2jrCcKR64
	Hqp0dVByr0fZJ92mU0gBGrWBZ3/AIWVnw+RhtWImy8VOsZA0f6Jl3v5V8OhFzNEaD2+N4kGeT57
	zLtcw3fY0yPRp1rdMB0WW3zsJ440FDPCHw1Jax9cdvaJsKfAsSVur/GzrpONZ+tWCzYbV7gaq1+
	EhjUTnNDUzNaPsdADTPmhr7CEuqyiwf+KmwSeNqaqIhc0PObo4/Ii2rhYlKBsG1PpkTPzHWAaJg
	e5qUoj+Gb/r2IYDJRGKJf/1G94tDo+U=
X-Google-Smtp-Source: AGHT+IGxSs5KjMlhBU5ReFue9k/mK/MwbQI1TY+914sEhLQKUPzGe8W+IItktORYdswpMLQPVCp3Fg==
X-Received: by 2002:a05:6602:370a:b0:85b:43a3:66ad with SMTP id ca18e2360f4ac-861dbe3b67bmr227329539f.8.1744984886849;
        Fri, 18 Apr 2025 07:01:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a37fb41dsm463105173.38.2025.04.18.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 07:01:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org
In-Reply-To: <ef9b7db249b14f6e0b570a1bb77ff177389f881c.1744965853.git.asml.silence@gmail.com>
References: <ef9b7db249b14f6e0b570a1bb77ff177389f881c.1744965853.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring-6.15] io_uring/zcrx: fix late dma unmap for a
 dead dev
Message-Id: <174498488589.689807.7439507318071758979.b4-ty@kernel.dk>
Date: Fri, 18 Apr 2025 08:01:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 18 Apr 2025 13:02:27 +0100, Pavel Begunkov wrote:
> There is a problem with page pools not dma-unmapping immediately
> when the device is going down, and delaying it until the page pool is
> destroyed, which is not allowed (see links). That just got fixed for
> normal page pools, and we need to address memory providers as well.
> 
> Unmap pages in the memory provider uninstall callback, and protect it
> with a new lock. There is also a gap between a dma mapping is created
> and the mp is installed, so if the device is killed in between,
> io_uring would be hodling dma mapping to a dead device with no one to
> call ->uninstall. Move it to page pool init and rely on ->is_mapped to
> make sure it's only done once.
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: fix late dma unmap for a dead dev
      commit: f12ecf5e1c5eca48b8652e893afcdb730384a6aa

Best regards,
-- 
Jens Axboe




