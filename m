Return-Path: <netdev+bounces-183352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE52A907BB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F206116333C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11491F8AC0;
	Wed, 16 Apr 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1valj4+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128541C63
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817330; cv=none; b=kPt+BoBFhpKVmy1bmvYMamGE4OdmxSV16LZqWBCvIAy2Z2SSdhBuufiyQqxQQaY88JS+b3MZToR2M2xYYOVxDbjjdwvIQCoNovcdC7/he3B+YRAINndPSuh9EIeMcv0UkE2nY8ehDy0FfyINgKc00Hsr52ErrKY++YoKu/LzsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817330; c=relaxed/simple;
	bh=XJ/Jz7m4PRfLUXTnvb4/GuAc/9PCPZ/n4ol2idNLDfw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=RX68mN8hP27Z7HKcw+lzSAmzyzEvUH04jV5LvbJIyzw6ER9K0x+p6QDmTOV0MAydUiuE5Y8XYPIQs3pqv6SX3z+EgPHm88Vxd5yOEf6/9aCzIJUAr3EDhjEFzjzpIP8B/1EcQyGEBHZLPTPi5gP6zSJg6+7KRs1G6CNmcLWPlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1valj4+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736a72220edso7191959b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744817328; x=1745422128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=WTjf9h2DB3BsakmTabRIBThNzQxsQO2xnwajDteROwA=;
        b=U1valj4+JXBNsoLJO14Hnja7DnPfbhDmmXiNDgSzcbn40zxxSPa3C+1ogMqkGZ9tm9
         Clj2rMT/voqTWkJnB/9JoWpuKF/cVZyqt4cyUXoQ0Pw3pNmhrvucONIfiWHB1J1kNU3P
         nWfLV8BFGkue+PEu4Ftx6pC/Auum9xSCkIK3+TWezjNtmRqR9KNCID3IRWIPuOdFEAR1
         U8/OGqTA8fth+vm02p9Ruu8oPae5LdcivMRKd1CxsDHvcuik1EsGNUN4sN5BSEDw7sDz
         cdN3YD/7pAWmaFFJQDlPkUMTHMqT7rFKN5MfQ1fzDUcnyZwIgt70hM9+8PNLtP9guelN
         BVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817328; x=1745422128;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTjf9h2DB3BsakmTabRIBThNzQxsQO2xnwajDteROwA=;
        b=g3leWZ6Qwkdhwbfwb4kRGj0NRiKxZCIdJk5s3VhWvZVXO1C7xGADkDWh5Y4vGI0zrs
         /zvScs0Y0FNzCP+lD4dBBSoQNYG5+aQZmfp/ge1CzfejSC6pJQv+e6uEw4oj9uz3xXIY
         GUqUuOdR7MxmqZTbSQEAoXFIqKD2wIX/xMsR0yM98r0pikcy+hWKInSm3py2nkJ25GUR
         iuw+PFfn8T5wTbJLBxsxIxur/OZcPB5tboMnz3okzHJOF5zVEBVSBNQtc6i1eIGT/07O
         G+K43d5W4fgHqk/aX5yI2u0CjgYMdbCFb2Eh0a1auda6e3nqnJS6gIcT3ICTboannRLQ
         IvSg==
X-Gm-Message-State: AOJu0YyBeDEg4jOfolO9EqxzFCOgz5u9xGFVOUcEuNV9V8tymN5oye5d
	1h6lKTiHp5VkE5rcGK2MfWp7zA2tBhPKrbYo3GbVCW88Izh1P8i1
X-Gm-Gg: ASbGncsvZVSRYdWj8Rr560SmER3ex7zndr4lwe7GJr7Ki0NRFKuMCf8rJxEORyhAZj5
	wr6wnzS0lK4N99rNLbGiuK5XHkaDHl6ic+yAgobwJHXN4410V9LD00zudMqVml0d7H78EH18zQh
	IRyw8oVi8sk+ma2r/nwB+va1SWGWz8BEH/BgUVp5PkpQAtYQiGzEDn/LsYbrLojQkIE2mdvQc1g
	3sXNo/MDzA9c4h6zdUZT2IbY6C9Rxfm+tokI+EcEF5EXsu+1z2dEs1HSIYMQrFrkLGPgQh2FYqF
	UouaiYDYyoCeb81yDgwwqq1XAdW6kn3cmBL9p9EwseNqhdHp4AyRLg2oAYFSsSEr7bovxcHcxdX
	Fgy9FOgwURw==
X-Google-Smtp-Source: AGHT+IG7Z6cCWqXmLMRt3cKv4wlt9dTxKJ7UDXDdQEtQY2l0wb1wMtwHIZ0cZqd4MyZ97TuV6HZFmg==
X-Received: by 2002:a05:6a00:3d09:b0:736:4b08:cc0e with SMTP id d2e1a72fcca58-73c267e39edmr3265924b3a.17.1744817328315;
        Wed, 16 Apr 2025 08:28:48 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198a89sm10575812b3a.5.2025.04.16.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 08:28:47 -0700 (PDT)
Subject: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 16 Apr 2025 08:28:46 -0700
Message-ID: 
 <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Address two issues found in the phylink code.

The first issue is the fact that there were unused defines that were
referencing deprecated macros themselves. Since they aren't used we might
as well drop them.

The second issue which is more the main reason for this submission is the
fact that the BMC was losing link when we would call phylink_resume. This
is fixed by adding a new boolean value link_balanced which will allow us
to avoid doing an immediate force of the link up/down and instead defer it
until after we have checked the actual link state.

---

Alexander Duyck (2):
      net: phylink: Drop unused defines for SUPPORTED/ADVERTISED_INTERFACES
      net: phylink: Fix issues with link balancing w/ BMC present


 drivers/net/phy/phylink.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

--


