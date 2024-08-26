Return-Path: <netdev+bounces-121996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D0595F822
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F852B20521
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28285198830;
	Mon, 26 Aug 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWLt4rII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA824D8BB;
	Mon, 26 Aug 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693475; cv=none; b=hNmalxEbGHHSG5XJF3ca3AnehE4V4hi+AXPkPPWheZZcgwlSOnlI3pB5O6QqIi+6+Uy5AeKswCD+zgDt8RzlG1wMbaX5bfJboYToibnUhDW057gASVBXKLweMQI/7GoWLZytv6reN9mFVHE2HLaQdAF3Up+QB+CKwzsKFFZszpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693475; c=relaxed/simple;
	bh=+8a9naazCZDm22LSLmOmiaFoRZvfwasS9DI2aQyKk7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2KI0hAGaIHkfrXfcTPul/dAtA0PStsO2Dsd75vb0MeWQJ8ryY0z5cTRo8ZeTMVKO8h0hdPEdwjoMymc4dekzYp+JGqL3ApRckEK1qfXSGKLNk6Fi410CEXnb1AASalHML/pFn5sb7+f/tzXD866SeuDCV+jFl0chkP8QtP0C4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWLt4rII; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fec34f94abso44315665ad.2;
        Mon, 26 Aug 2024 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724693473; x=1725298273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqlUt7gGSpHehh2MHipdQIiey6iWi6VCFKaC87yAJDo=;
        b=IWLt4rIIn8/MThWevEIhgSFos8bVXKCpScCWgkclw/4TmGJr+Iv6TZudhg+LjWJqrY
         JL38qcCyYiI2Zw+DuZHMVl6OA3uAsHqbx7vMPZd34ZTIUWRR9KsQAw4cvdPSIP82hExA
         EGcMRNl4Wxu5p56vlrYEnYY9wyug3f7i0xk/N4AmB3aeTjoO+pMpoy8UDisPa3BeYo+W
         HAoBcVILMwxYkCQ9qUAlCtPcIk1b9ajQpoUTIP5fbtOrwlW1XFUZNZ/TOooxm/onvE+8
         ngUybjWFxB8uLFJvExJOgsxcTXovS+kvRxIwKI8Z0GuQaq4wIT7MYdxJp+Ph6INZfCdE
         KapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693473; x=1725298273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqlUt7gGSpHehh2MHipdQIiey6iWi6VCFKaC87yAJDo=;
        b=Jw+XCsoVZSD3Rt8ucsbbJjnyu2TaG+cQmCSAQV+ipPafBtMEU8DvlpygjDgv+1sBE6
         Hx8Z9lz1JZTJ2fX5962GhR+JLg5rYQC6W7U8cfBw8CqsDPyfR/kMqO6bjOS/7K3eepsL
         AtS5UjvGXCqYZzaoYcy8N9ew9gpyi7qYqs2/fQ8z+tUzkVKR7YinmiHlujVrd9rlxn3K
         6XJaiL9lYM3LJjZFv7KpWJENK8QYUSciIdDQmS752+3vHIjIMReey6Q+KFSfVb7K2Gkt
         oUZTPQDPk0tN8DEcflLjvFiXahpDuOSrxtNCFyTtZvo3g0LrkSBYsXLjk7EJqrZifTuA
         mdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfd8ZeKszQ0Zg3icDSl1tX5h5viH/yfqHfaY6vxKcpsm1BRlWdWXn3p2t41R9mRValLQM2MuuqjbZyNdQ=@vger.kernel.org, AJvYcCXy9EHt0MXl7VaslhaYQHfykxCxbKGDkraVCKVh5126/cbF5G+MtPMPlk/CmEITJCuqVOi2dSL1@vger.kernel.org
X-Gm-Message-State: AOJu0YythD7BiZey1jy970dBXIlj23TsE/YJ+oKs8pkvdbnkuppfs5el
	Iwstv5YyrVnkNbYXCHzMGYvHrn/OxhKSh+pvsXdSH6fgcEcKdten
X-Google-Smtp-Source: AGHT+IFX3Uu2OtBgEj55T4avcTD9RQFlpAXuoYEL2eDm6MWCyQmNpaNn2UcMF/C8VklyKEdAWs8+Rg==
X-Received: by 2002:a17:902:d2c9:b0:202:f8e:7749 with SMTP id d9443c01a7336-2039e4b7201mr94287425ad.34.1724693472808;
        Mon, 26 Aug 2024 10:31:12 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbf41sm69447515ad.134.2024.08.26.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:31:12 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v2] net: ethtool: fix unheld rtnl lock
Date: Mon, 26 Aug 2024 14:30:55 -0300
Message-ID: <20240826173105.6705-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c14bc7fa-5692-4952-ac83-ed14c65ed821@csgroup.eu>
References: <c14bc7fa-5692-4952-ac83-ed14c65ed821@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Cristophe

Yes, thanks for reviewing, I will just resend my first patch that used the out
label now that I am aware that the lock has to be held during all interactions
with the device.

Thanks,
	Diogo Jahchan Koike

