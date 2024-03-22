Return-Path: <netdev+bounces-81208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842A8868DB
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D16A1F25844
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA01B5BB;
	Fri, 22 Mar 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HfHNi1dM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA41AAD4
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098668; cv=none; b=WMdvG9qOhclTyQaCxDuwxufR0cnCRRB6A2C7oaaQmBi3xEJgxEJ3FFyXC7uln/K0XC5rpByUgX9MFOPMWbaK4k5Tt/X/fm0g7dIUP7Nebe+6zdDdWIE5PWQzG8elwBmRFXs+3nZ0BstknTIolpFgr/2MQPz4tod/LYJ2E+L9gz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098668; c=relaxed/simple;
	bh=Mb1ZauZFe7jCpzQCZgjVxe6QmNZmGavD3J+Ae78MB+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbfy6ugTT3WH9LtavmZiOTM5ytMLAHpQkLlqMGZS9wlnJ4LSo7IhnKBqh9J8HsspunEhBTeyKjZETHOxYYlxwCmA/v+v15I0tTnGFNNSTqnSgTl0pTzLmA1Esmq9F9kjoLShP6x8HfWYppGb1LLyOM+xVWmUAJVnhOgKc62qs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HfHNi1dM; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EFE453F118
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711098663;
	bh=Mb1ZauZFe7jCpzQCZgjVxe6QmNZmGavD3J+Ae78MB+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=HfHNi1dMsFvn+5dO1S6NEBPqaY1D0H75ryP+vQRZmzs+YVdJn6LukAFi0W8wwSZHE
	 M+Os/VP8hgtcuRBuAJfGCU5nk2CjFcz6n/aOwyssVFhlO3BZ4a6wy8rreVEjc9oR8g
	 J3LwPwma6AjT+WpzC/oxCaU14sKYA+LIktfcxDqZVaU0EWWeHNsa55zCnXqhdlClrw
	 t1RkEVOEfaK/YpFbkjTRcqKGfH86fbPSlpbumx20WH1/EVZRSqhai1lVZliozLnYog
	 BsA726uBKlhGUdWt4pUO/vblRS6kqomSonidf0oRBaiZy6S0Rawlr3EwJYNHUkvh4D
	 NCHpHNBqczvPA==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e6b285aaa4so1535965b3a.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 02:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711098662; x=1711703462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb1ZauZFe7jCpzQCZgjVxe6QmNZmGavD3J+Ae78MB+Q=;
        b=aSfkobB0/IKdzDiXdsGXlJRtm7baC8BbBrx93foX7Zc2gmCcE1Oev4jPPEhMaqi87f
         5N7BQDjKPD95QusjgEvjQblrxDJD59g3shmLOKmR4HfVWQxAOv8sFIp7D1Necu8rKvRi
         qFL8CKWQ4/fdFSQj9y8JprIwmxsIyDXFE5twxFPlW8DJZfhzWshzgCnvnOZl2KPHUJ65
         ENwz4AQo2fBm80a47s/BeMH762nAa1QmUBGtk0FnT8nqd16zYwjAIxRIZgF9JbTVQYUe
         tEFg3kL2iun8TQaNMMSHaO6dBkc1/n2w6tfMHZlh2SG1F7BFS6Iah+zs8omvLko5SYgm
         r4oA==
X-Forwarded-Encrypted: i=1; AJvYcCWqDImaVmuumaCBHxnNP7u/cR24txdib7TEnBHkAASxrCD7h8W0X44uDD05R1ak+2lFVQxAOxCpfiHdFj9b+FA6K9KETRDA
X-Gm-Message-State: AOJu0Yw0tfQxMX22nIIeR7q4Ih3/MeXG1XW7PUswDukFZOBTQ3QVGTfB
	3i08vhkTwCslJJwmf2umtJFfEA2VzrmHkbVt1U6iw+QE17PYGEhro54fGlvxMWMU0Xdf4KPhJYt
	eFpiqZBu7XsgtNSOUqxaiqT6RtUsTNKBZOc3CuUQMo6+BYN3Pm86OIgBPhjfzkwOnb3+uqA==
X-Received: by 2002:a05:6a00:2d95:b0:6ea:6ffa:7f0b with SMTP id fb21-20020a056a002d9500b006ea6ffa7f0bmr2082456pfb.7.1711098662579;
        Fri, 22 Mar 2024 02:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO0DKhCnmdfcJ4yQhU5R1mlfF4rPQ/ybybew1bwGzM9EDULkfsZ59mFxekK7L+UM2QRKNC7g==
X-Received: by 2002:a05:6a00:2d95:b0:6ea:6ffa:7f0b with SMTP id fb21-20020a056a002d9500b006ea6ffa7f0bmr2082439pfb.7.1711098662328;
        Fri, 22 Mar 2024 02:11:02 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id i6-20020a056a00004600b006e5dc1b4861sm1193916pfk.64.2024.03.22.02.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 02:11:02 -0700 (PDT)
From: pseudoc <atlas.yu@canonical.com>
To: atlas.yu@canonical.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	hau@realtek.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com
Subject: Sorry for the spam, ignore the previous email please
Date: Fri, 22 Mar 2024 17:10:41 +0800
Message-Id: <20240322091040.51953-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240322082628.46272-1-atlas.yu@canonical.com>
References: <20240322082628.46272-1-atlas.yu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bear with me, I'm new to git send-email and linux kernel development in general.

