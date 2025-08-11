Return-Path: <netdev+bounces-212403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45443B1FFD3
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F62165120
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0311BFE00;
	Mon, 11 Aug 2025 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YozL616g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710E4C92
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895793; cv=none; b=BICNY7Ttc8hSPz/evEml/6J7xJo+JmsBlV28Bb2XNEJYIoUwFIOOo5119K9haCG03vVp91xiGy3kndD3XWy/DR+TBvWmylELQP7h/+au6jC/TyQfjcyNwyLih/tcizcxjS0YoFf/iEUlITlv7DAceiFkrofqLOHFTPJJkd7JwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895793; c=relaxed/simple;
	bh=BX5838DpelIxiGvKYs8wdEE/cJfYCazI6NvQM514ZLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mkddy6IwcGamxhBYu8EEo4BqyK5s9pk4duF9jjaw61z1G72/1+LlpQtXAxkvxowivGL8AQt/XstccVLTvnc8WZ/70PozwOLQ+tN6vXd31y4pS7+GZOAuM+MX/fN67SMa6pJGpm7rzrKYBSifd/t2BncWy6l2pexFz8BTyX5WsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YozL616g; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-709287e8379so45364806d6.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754895789; x=1755500589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrCkfbsN/W6MAnejnv8wPEyUqB4MgR+M4GZN675Bris=;
        b=YozL616gVvjswitssrgmDyJ9+eSC5ZNld6pZwpqJ7hYUyNPgSxshZzwK/kRrshj5Sm
         7d/zPTD1hYedvBvyQyECnmIOpPNa7Q3oF+YqGP39EmHE6x14MnkPGRvGnGs1TRG4IpPX
         q21XsVzOEWJ+9x45zSgC7kgDGNMVDi1iC4z2UvbH2KEK2JjmwfD1qxoPfZXO4TM7TPt+
         j7hDxU9vldD5S95jBOtMRjA24GrND3jJDM6lcACxNYE4e4A/pc9siFH9sJfygSxLg4wt
         Um9ZaeiP6a/d8mQXFPK2jr2isuesO1ekpIUAEax8fR7Oyya9JUakpZNcfZk9N8FXxp1P
         9TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895789; x=1755500589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrCkfbsN/W6MAnejnv8wPEyUqB4MgR+M4GZN675Bris=;
        b=hB5fScitG29t6FWA704mW3XgqqQ8KWvEFhtD+WF/d2A7meh11NHLC7Nx5OWwU4wqZ6
         of3QcrKr9PPbhmgeijUkU1EgAUB7ihYnRFsn8eDisa8+vyDjo32kaB3DxTrJuJJRnHLO
         rN3hW913ge3MbahvvKYA8d4J5sBhHeckYIGEVSRK6oi3qb6GUtgpidyvUdSue670Agjj
         PCvAcFmoJ8enNi/0wpar3quV0G5mRyjBYkQeFIdtyOBKWFF2NWT4MN+yPJ3SuYe1mZyO
         ucYo0H/vzVBUbB5WKiL/4ELlHq6XmNYB9ljKEokcDvtZHvh4uB87gHoRcwI5VZNr5nNe
         O+Eg==
X-Gm-Message-State: AOJu0YydU0WB0VMIno0DRtKD853UAvQGRH4WepR+oA4masdbrdcBSRbL
	frtA5sZsttpTzw/u9cRg/8EV1m2nxSdfaUwc1L3F47gPlGdDDoomPnl9msFiqA==
X-Gm-Gg: ASbGncsSWfEJMGNiWePPveDyDuE4Y2d7o5DFB8sVC62aCseNazI7ARDeiDSHRmWqeNi
	Qqg42BY+Sjqb023WIzfc3xJI2P4yJdk5XCDToyPutbYZEtjMDfnSQDblxSy7CamF0UwbtUfKwEa
	PTEKFAXpG0mBIn2UYqExVo9qaouPGRNKcqnORR14rKfqNqQempL5P0CMFtRFxKI4kfu8cnm6bAW
	r1BagP9nVP0xX4hhwSLQJmIks0SugQn9E7nOQYAzL4HJ2jiCMRwl9QCCj0KwqN7667ioYXg9js/
	Yuz/Gs++SY99c34+tHf+n+jP5zR/a0uZd0Tp8K9G1XqaOV+YhQ7g+FWlSFFd16ahOtnQoZNTaKL
	JdJM8zsP7i03rniaavBQTEqC+zjr9zNOQBlEPZBWGXJXd2Hwvg7ZiSaw8Loh/5g==
X-Google-Smtp-Source: AGHT+IFtlIoVTNnvds/W4zMXwtZhFpPRbKjY5C55AyNzz1+zNfF6qsLTsYpV42IYmedcfG3RGjoQSw==
X-Received: by 2002:a05:6214:1d25:b0:709:6ed1:c3e9 with SMTP id 6a1803df08f44-7099b90dc25mr123566916d6.3.1754895788712;
        Mon, 11 Aug 2025 00:03:08 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d9b06sm151595946d6.6.2025.08.11.00.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:03:07 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	leitao@debian.org,
	syzbot+8aa80c6232008f7b957d@googlegroups.com
Subject: Re: [PATCH v1 net] netdevsim: Fix wild pointer access in nsim_queue_free().
Date: Mon, 11 Aug 2025 07:03:05 +0000
Message-Id: <20250811070305.691880-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731184829.1433735-1-kuniyu@google.com>
References: <20250731184829.1433735-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kuniyu,

Thanks for working on this fix.

Could you share the steps or setup you used to reproduce the issue?  
I’d like to replicate it locally to better understand the problem.

Thanks,
Vivek BalachandharTN


