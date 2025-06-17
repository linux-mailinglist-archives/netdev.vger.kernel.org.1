Return-Path: <netdev+bounces-198771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7BAADDB92
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0275B1676DE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8D2EF9AB;
	Tue, 17 Jun 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJz4ERqY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BCE2EF9A0;
	Tue, 17 Jun 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185770; cv=none; b=lWVuQASn/VQrkHabneDvSnlU2JF8BAATwpYGQTaTegyJHEZe3Oaj1lDBmXQ3NvULEbsMfpYyp4ibA/tAgSJIFg4XsAQwqaa+jCVBQmccUlCH3pTzZ+TP4UAS4bypmbip+VmwhUxP5F9tdkSc1FrcPMA0Cyh2gJY2J2kjlcs/GVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185770; c=relaxed/simple;
	bh=8S2U9qHLvtURdDB1hnc3jx1OaEuFXQrxVY9sKdqwrm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFLNMWUypmXmIE1VBpGB89omPctAQtVsIST4ye+gbUsz5AtLGXUpCaeJhtJAmpxkmLTvufWjZ7TUurmQ48UsGYm/NrBcdyJqh9Qs/3otaS26DNhw7AkaoYwfEaC+ocotvb8JIQ7iCjrweHcPNQ7ocMIDttsZlQ6PGzXmwsKy7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJz4ERqY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2fc93728b2so5074158a12.0;
        Tue, 17 Jun 2025 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750185769; x=1750790569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54YceHIrKZZVlUR0dFkqL6sInfVu/iYSsjlmqLJUSpA=;
        b=kJz4ERqYohD1qaD9xd2TF3ZbPn0rtZwrClao7VceoUYMbzwaNpSDGDXfuoBhE7Kd0e
         RnBABb89RcK67OdZaXdGBgZkrUFISvimHx/7YYO8tat1JTyVGeUE1v4385lULIWIR6h6
         yRrczMPQEftzyS0o3FIfEFWfMUtSdIavhtDf4zV5TFd+kGwiRzgWgkvNA+kITQxkFGQd
         LeqWIdYWpVwWY9gkzjCGwwzBqv0tsOO5lBbMOWXTqEGKhU4914oAnmZbPHWUVSjFlzoM
         LQl45M4IaHKYM2K+sFstk2/LRDwWfTjZi2D6K6Wb+gYQbtUlF/K1BrkRyxpYsNHzYSQh
         qClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750185769; x=1750790569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54YceHIrKZZVlUR0dFkqL6sInfVu/iYSsjlmqLJUSpA=;
        b=SMkF25cR9lL89wIxSSAbIrbxZWk4+CWz0x5VdQYr1u5nUMSqviiwvtLq6y7UnDUP79
         +rJW3Bt5oL/8wY4ewBcTUZTM30NlVul3McsjW1713ODXJMHsKY8pv0AgMdptPopudq3a
         jfuM7oI3XcXp/rCvxFoHu6VLgkekCLgSx1ctSZefahIkAjHq30uiam6W4l/BPUbIsn6l
         hXIEG3N9TMnEUzm73ogyLb4iGVoWR0JfxYpqUp99y2lSzMipZ6k2kyImBlMp013CU9Vp
         WG/vzLkapfCyFZhjolzltWejHew9ilMMbN50uKl2eIl9P58AcX6p0C6tY4W+8DQnRtyx
         5Huw==
X-Forwarded-Encrypted: i=1; AJvYcCU6xdVOn1EqKSC13GFyaiGItbjczonq94RRrzDMfyzLBYFYRXRPleIkNROXf8EQtweqO5Y65yyT@vger.kernel.org, AJvYcCVUUZzkfGPbzZMerjfXTP3rSQ7H0DBQxdyo99dgFDTi493/ACkektYLSiTcaoUO2Gme9ANY8QIgR3IfaIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWz5MQveId1fig0MN7qwXnq8Gf3BqzSbVcVsyIaZHnAyZc81/K
	sGtScscApDyfEKh0YSiPeM3Tv9Z2EUJWpSLGSL/Dw0eQLpxD2KyIE/w=
X-Gm-Gg: ASbGncsfag55GNxoYz7FvkAyE1L6zvsFBE2vvHXDmXU+Rr4mAdOfOi5wSj2vWByBZxO
	f6O4kRbwR8IPVYgQ47eCejzt8+VU3t9eTGO79Ic7YtKCC48Jw/3i+v5/YCzvnCkzR2uWFgduCTw
	W1pP4U01TijNLnQtInYfDVvIh88yFS7agjRSKjElUrl1tP8FyYd8wg6TR2zbbz1eRNh4yjj51ur
	zhnTxnPFC0FknszjTpRjjMnLBp2U4s/UsRzFlxv9wiSEX3+6jX3PGVdTWVp3Ni8qMHy8aibuBY8
	ivfPJXoG5T0p3ELA/JOGRpwhKXjbEjw6OPBOOpw=
X-Google-Smtp-Source: AGHT+IHGDC/lrSSRe9clXHUODDRbrxI1IEfIhRoCtqWaFoCqNO8Lj53w+wtRZo2FEQPFAKRgzG+xNg==
X-Received: by 2002:a05:6a21:330b:b0:21f:5674:3dd8 with SMTP id adf61e73a8af0-21fbd63161cmr20230668637.26.1750185768627;
        Tue, 17 Jun 2025 11:42:48 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d255fsm9547149b3a.172.2025.06.17.11.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 11:42:48 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: yuehaibing@huawei.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next] tcp: Remove inet_hashinfo2_free_mod()
Date: Tue, 17 Jun 2025 11:42:41 -0700
Message-ID: <20250617184245.1816150-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617130613.498659-1-yuehaibing@huawei.com>
References: <20250617130613.498659-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>
Date: Tue, 17 Jun 2025 21:06:13 +0800
> DCCP was removed, inet_hashinfo2_free_mod() is unused now.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


