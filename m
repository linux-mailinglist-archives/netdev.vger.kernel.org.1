Return-Path: <netdev+bounces-220303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FAFB45563
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0725D4E0552
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9BF321459;
	Fri,  5 Sep 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiaNPqZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B13203A5;
	Fri,  5 Sep 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069651; cv=none; b=bxX0aZGqOOHgc/AKKlragagWkd8/D8UBiyZTTkOSbYr3g87LxEOJgJYkHGq+Ms6noPG31o0ZVvdVrGRR/nUh/19K5kLNck1N2U3RuQmG4wKyOhYxtPN8jAitLIEL3qUt1a3JKHaQwLX3/VGJbhIG1ZoAYyNQmyEGf63NJJitYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069651; c=relaxed/simple;
	bh=7tPnz7ssRCFXwwpDsxLmPm7tdmZ+Zo7pD+rEuTZds6k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CiQtWwavSgkRbAc43KO4+aoG+XxyZ337Cuc/7APSlOBFAJTXIw2KIaKz4Z7nEUkECB2Hnicdz2p5ygKRjAGgwTmHxs2T4rpQAk6S5ebRGaOYlHKulYMqDrNFWZJ/v9B/C50Y2AcS9SPypnYAkMLTmE/H4oOLVLlCq+mNlp5KDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiaNPqZA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so13206125e9.0;
        Fri, 05 Sep 2025 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069648; x=1757674448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QF5aHDOe/RINI2mjAwVr/DvcIRAlm1Z12kISJhmvEiM=;
        b=iiaNPqZAwCPOVrZNv/yrAZoNy/8fleeXaHZqytZDAIIoZJBontrVMeLiioNR6ppWG0
         ctlP2qok6Rh34E871agk2zr3gwUXn3hWnh97RL9tZHem8EzijKoM9ZjSVkzdyoQc3tYT
         bg8MMEEjqcpJRBt+Ob5Q9O7J9DNKOIqVGxozr1TKjCfVJeyQ3Q7LmFdvZwtHP83zFu8u
         En83mo1oFshLdCwY7bRPn9aXgwEPvvqOSsyZSsVbcTlXZoeRQzYMCe2uy778tmez1NeQ
         LIk1uwgcr3ah8Hjf4bMtWma0SQ52JtKNxvLt8Rgka+rkcrwoasrDPOji4vmGH3TznFab
         1nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069648; x=1757674448;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QF5aHDOe/RINI2mjAwVr/DvcIRAlm1Z12kISJhmvEiM=;
        b=RlNEwUEat4gqzUx1t4TgPDTMIKPNqiZjIyVYiCYfMqtKA6ztd+gN5/FHNqfO/8+Vu2
         VsfBr294Y/S+ZfENe8FBdTCu68/On/cG2Nk2yaEcr0Ui5NkvvAyf9GBybsd8bZLA0ROu
         YjLIyxA3Fp1mmD+PVelIVb8iGOIEVyMR5Fueh53S7g3ckY4v8E6QJbtR6ALjBLsPGueF
         3txX6kSzVhPu4lqVbFzAyP7xOYZLYgM2ado0+0iiqj5uWekgUx6IkuxNJwFPQuic73nv
         dl7KNg/TajJRzrbkQYJeMNEp6PAVZlW22KkcTKoHiunlRTpI0xlEnUewb+DFXCfLeiKC
         Nvug==
X-Forwarded-Encrypted: i=1; AJvYcCW8+0lzQZqWjreEkKMqBxGwaok653xq0qX2kaBAmkDPDEAycW8c3FT0twsYO2FN/eAGdVug7aTx@vger.kernel.org, AJvYcCWpD4p+D36+JcJCdiVJEqBhtn8aOcUBKlx3L2i8Zni7eXY3Zunv0yyFuU7jSnar7E30oaQOtAdi1cV5KA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1gkSoz5fYeUZLZiAlErRijqYiRRmXT5sIAsk37F02xPgnTHhs
	ZuWkxx2pTrDYL40l8SZkx9oBhztHeiwfwxwCDs54lkbixeZJW8GhFFwPx8gaYOmt
X-Gm-Gg: ASbGncu0I3k+n46PyzH1xyG1R8nLWT45Gx4HNsEVIzB7MGfj7zvfRvsBh1x2x7XEcVf
	XOZZbiONhAThn/mKktN6OzBJRly+aAzndqpIEPdKO5O7ftqkXz2UR7NSSyTqbwNesbA28dMCntJ
	IS9/6nLeC6ZRpmewdLp2ea6mGgWGhuldbnAt5ZidMZ/W5Rxl9injNEN8zGhClU28pqVvOTQ+UI6
	DUWXWSxlmAxY1bSqlvtYBz8cTceepDlr48IKxj+qrzVbFPE2+afbr0K9ALgMilsbgX7JP57xpdo
	hx3WXGc9QqruWvSGPg3GqceWwX65AMfY4RxdIP0xC1uW7zena+nQVARNvEDn04dW1RlMFvQaL+J
	4WGB9ys5wO4PnE+ahjrdDmlv2A3sFr/8eO8NsM4XAv3Fytg==
X-Google-Smtp-Source: AGHT+IE4h9xaKFFB+jg6jXUNHyf7TN+VxDEKHWg97267A3zCXVPEAozhpOfzu1jpwOA1O/9P9hllMg==
X-Received: by 2002:a05:600c:8b2a:b0:45b:8600:2be1 with SMTP id 5b1f17b1804b1-45b86002e27mr192622385e9.7.1757069647630;
        Fri, 05 Sep 2025 03:54:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm17288345e9.7.2025.09.05.03.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:54:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/11] tools: ynl: decode hex input
In-Reply-To: <20250904220156.1006541-10-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:51:34 +0100
Message-ID: <m2h5xhxjd5.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-10-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> This patch add support for decoding hex input, so
> that binary attributes can be read through --json.
>
> Example (using future wireguard.yaml):
>  $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
>    --do set-device --json '{"ifindex":3,
>      "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

FWIW, the hex can include spaces or not when using bytes.fromhex(). When
formatting hex for output, I chose to include spaces, but I don't really
know if that was a good choice or not.

