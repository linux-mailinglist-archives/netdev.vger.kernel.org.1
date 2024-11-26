Return-Path: <netdev+bounces-147350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110A9D93CE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D89166E62
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C0187FE0;
	Tue, 26 Nov 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xdkjzLvO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78628FF
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612119; cv=none; b=i05l49y4s7JSzxNBshilmENvBggrkh/0Cndb6ddoGEUknHg8/7AOHX5FKZsTbnSDDNta6pdRRArEYA9XUcDTt7LNRhNRnKvf40cLlGUZO1jzAglb0qf+K51vrLpuUQAHW/tDk9VZdeogasMGO0pIQ9WHhRIsB3bqMtdFZZldfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612119; c=relaxed/simple;
	bh=4+cgyBGFPbEZWnjsSmTi0sNtUKHA3szk/VTMgvLvnOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KqrEN+OrlIu9hbbUOVRqQeySt6JYzlIOlDHeOvrEwMf8FPHmzvmpfnxRE99Xjh8mziE2cZ7wXaJ4lEfrXPdipYEwhmS7jdmwiV7w7wgLH+4vKOXtxEj+FKRq90srTyJvWqAJSKyHuGlMba76ziNFjHNs2azcex4jB1xo8LV3+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xdkjzLvO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d86a3085so49467845e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 01:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1732612114; x=1733216914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKfjtGBED33nJo2tNEZhjas7KRgoaQcaUB4EGci3Dmo=;
        b=xdkjzLvON0NdXc9emKhCtGwZo9E5KxqR0SSkjnEksZqnmYonEFudSYBjOouxzLxU3K
         ouhvNFFgCffURY8EYRHoRxLlofmxBcGNIrFgZAQV0tdzkE51gjKRIgXMyu2qg0ewo95X
         ix9t8LEcX/jui+G2FZ51hjIjkuR87xVUUxZuW+zLEj/BJjllhDP+BwOcWfEtKtuOpXRZ
         Y1h2IlmTvBzbzciprxP9Uvn+Jb7589M4bJzcTvZ5wFqbO0UDH/59YkP3bcKKjtZ5JNjx
         W7zjRnz1/a4h3BPgPGbru2rtcHIMhgOJ2+pDXi5RmBz85gC5IfztnrhXnvlsKjLft8W6
         mkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612114; x=1733216914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKfjtGBED33nJo2tNEZhjas7KRgoaQcaUB4EGci3Dmo=;
        b=obKcVH7vttHUgAl9GVIHYx021VeEyVD2IW/fRIV/tuWU+YPtQHOUPXM7j1iYPQfleX
         GSl6IQR1sqERPJlYPLmqxqJg/d/BuXOxGjepl3HOsIV/cqCd1V3elBVeFtsZBabng7n2
         MVFbeujYpECM0jmncMoNsmDPhB9LDLiyk1qNb91G71Kr4kik5Xx2uxbS6+p0TWspUNCF
         lBbuyTQYt6PlKfCC6ofTwoQPeT5diGwhWC8s/QJ5IP6m1s7GD5w+7w7v/VORQEQT8heS
         UUP84GTtjWXLMTHp22FQLkBch0G9cCbY0h672mIGyZ5xgPGkBqyRR0vUPDHKubM4oQye
         Rdyw==
X-Gm-Message-State: AOJu0Ywi+bJ5gPN+tPgR680S7VJRgoTa6R/9KasB7QV8wykFIE629YNZ
	E4u9D72OnpOZJOWHtKhyUR+4Fxi2DPgAcnlQdMtAzrxByWtnDwV2n6U14OlyV35e1pngEa1zbkx
	B
X-Gm-Gg: ASbGncua1rgn7JCMxQqQKMnHMTOz31x6tAouqsUNqMHgOuWt4/7EA1ZZ33yRz5koEc/
	UAcQLVj007ksCKfL+K6mGu3j+t68lqBuzjOwe6q/KkKRMuPfBLUj9aax18CZYI7eRO8x599jlld
	70civzE71gf+5y+BGaxLA+keVJSkpNgfM2nt8+r3VaZrNFGhrLu8WYl4CFJdgd1rXz0alIGPrhq
	v1jMGh+7fOaxLUTQmBGNpb7d9ly0htscGV2k9zjlM4=
X-Google-Smtp-Source: AGHT+IF9ouVCRsMlb7BI6jU9cFWflazEGsiRlXynu/uk9/qU6jfGw31TpMXcgUA2UlBSOmwT7tRjUg==
X-Received: by 2002:a05:6000:178d:b0:382:4f80:1359 with SMTP id ffacd0b85a97d-38260b5a888mr11857853f8f.20.1732612114235;
        Tue, 26 Nov 2024 01:08:34 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe901esm12889488f8f.87.2024.11.26.01.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:08:33 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	saeedm@nvidia.com
Subject: [PATCH iproute2 0/2] devlink: fix couple of bugs in parsing port params show command line
Date: Tue, 26 Nov 2024 10:08:26 +0100
Message-ID: <20241126090828.3185365-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

When port selector was introduced by 70faecdca8f5 ("devlink: implement
dump selector for devlink objects show commands"), the port params code
was left more or less untested. Two bugs were found working on kernel
implementation, which this patchset addresses.

Jiri Pirko (1):
  devlink: do dry parse for extended handle with selector

Saeed Mahameed (1):
  devlink: use the correct handle flag for port param show

 devlink/devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.0


