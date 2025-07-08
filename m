Return-Path: <netdev+bounces-204864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE73AFC538
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AE9189F6D5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE621A428;
	Tue,  8 Jul 2025 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="OAc8y+KB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B73267B07
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962581; cv=none; b=sBLb7WznOvXD6NAnOs8zR+lsaViRhDyMgM0y1jzjIE+gTk1pR6dPeSabXOln71ZS5DiBcFyx0LClzafhBWGaSqnUwGwlhgY1cCsk3Oa6AeTGAoGl+ERZN21utjcfHdAJSQMOpeas/dIkDWl86dinB6leTUaZREbycxJKzbe7r/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962581; c=relaxed/simple;
	bh=UO2Z/bTfKTqIs3KiTBzGr2WQH493d/AThkPY1/9jAvc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=PG1zUSNRNZEO0DSbokJmgeyZP5vg4fJ+V3hLwGRq+0iIlDAzNph2ZBesmK1Ii6jp5q5xJldIO8EP0WNgoR0goE9Dg5ijY7wdVBtxhFxDpOydNYw6+cIBgXV0jBegKMmw2VGW5JkKUA8rsRSRXG5nc095NdmT4ZhmgsxHtYCTLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=OAc8y+KB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae361e8ec32so810618166b.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751962576; x=1752567376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX0N14y+ivi1tBXRE49xrBFjeTOrZmJtWYI5xIIo6pc=;
        b=OAc8y+KBRmwi4bF8dxAUHEumEyEjB9FFiYpvyhGqYgLi73Emwp8ZLkniazCCfPj9Mi
         pJYA247MjD3y8vTq8t683Ja6LIXoDWL9jEIkdd+Aaltb7JXNzQ47nR2+e7ehJxg6lDGW
         jLNeoA5wEFuRryP6Q7iNPawLiQ0HvUUNJyLn0zihRn02QHhxcCpiiAD2ytiNlox6w9q+
         +GQZN6xtIkVYYs2adI45L1MvP3ECgR5KpTuKnEQb34etafvQtVm4md26LpDxc3G4ImCq
         JsZvHcYwl62JlRn3KgN6EHbkNGm3VOO8ekJQ40dF4ChdTVp9UvP9GHMh+9oQQx7dwwIJ
         Rb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962576; x=1752567376;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX0N14y+ivi1tBXRE49xrBFjeTOrZmJtWYI5xIIo6pc=;
        b=JBt6qCARaw/mfFGK7SBu8hIA/YYWycNlbsR/z+/HUw8eP7kPa8+um0xiNGPIsR3ZW6
         ofhDf6gEeoZAK+NvX3PbXXy4rUWidlS4Mqjn6TIWA24efpFQ08ZaryeSzSQMg0rwz6mP
         M2jXxYOaeH4GrSXEKbYY3hI9LofC7mza6lS0WCki0dNsqsHPcqhws7UnyqahEkwFoFcQ
         2j9xCvAMwskR+/v2CfBLBqVtHr7OSFqNjr75HvZ0AlpEea9CL/eM/2D6nS9RDXgJBM3T
         rSxfRiWrYivKhCaVNGdSYFWeFda+yCWQq/RImqNNPPfgL87/b4oF9XK2d9Y1YQ8S3Jz9
         3Vng==
X-Forwarded-Encrypted: i=1; AJvYcCVlePMDwt/mRo9IWZBtJLWLdL92vvJVzmYHwpqmZnI/6TETvDDWo/U928a2FHKu4X/Oq/XTM3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zjlF5zmxpHbEOB0BHWTi/T+lQs2/r7vmPo7bBdCuTClNFY8I
	wPbngJwPFmMPuYSge+nuoN4NjzGFwzWRIGAbmIC0mjHALRTH6BjB/QvqMhvnWBjtLg==
X-Gm-Gg: ASbGncvkHk7x6XV5W5LqDxPhalDevdMUwRE9SpeWLM4lazdRlDdNMXqrXMvfeegVuTu
	+Q+ltNtXs2nJ9F5ccc671O5wFqsfYCV1pMOw1K3OEYP3z86JnjmYy6rv+efFhufLEJU0UxNyzoT
	r0iHPcb+fsWRJ9u4O4RBLlS8DEJ2B8D/oTO6600NGOgE6ZXHmkCy40/vZJE02fik3C2SgZr0tk/
	i67GyoqN02xC3yKjday3Bd7NXrs0OdCM0ukXRQ2IGqQjfqACTQMgryY0VXdQ4lFyXiIPEhyG1/l
	0z+/LGi8aWlSHW5zq9diLQnsfqAUG8Olr/PrlyZ6SG6Xd8c/Ed8vP+xqwBpN1ulI
X-Google-Smtp-Source: AGHT+IEEfsdJuAwx2RBd/D25PHj+3LLnLlD9Rv5k7fwF6VFsK1BsqBstgUYy7xzOJP6DzbbwMbM8CQ==
X-Received: by 2002:a17:907:3f87:b0:ad5:7bc4:84be with SMTP id a640c23a62f3a-ae6b0eaf680mr201405766b.52.1751962576253;
        Tue, 08 Jul 2025 01:16:16 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6929ab5sm834750566b.46.2025.07.08.01.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:16:15 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
Date: Tue, 8 Jul 2025 10:16:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v2 0/5] drop unnecessary constant casts to u16
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As requested by Simon Horman, here's the patch set to drop casts of
constants to u16 in comparisons and subtractions.

Changes are applied across all Intel wired drivers.

No behavioural changes intended.
Compile tested only.

v1 -> v2: drop casts in subtractions as well

Jacek Kowalski (5):
  e1000: drop unnecessary constant casts to u16
  e1000e: drop unnecessary constant casts to u16
  igb: drop unnecessary constant casts to u16
  igc: drop unnecessary constant casts to u16
  ixgbe: drop unnecessary constant casts to u16

 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c      | 4 ++--
 drivers/net/ethernet/intel/e1000/e1000_main.c    | 2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c      | 2 +-
 drivers/net/ethernet/intel/e1000e/nvm.c          | 4 ++--
 drivers/net/ethernet/intel/igb/e1000_82575.c     | 4 ++--
 drivers/net/ethernet/intel/igb/e1000_i210.c      | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c       | 4 ++--
 drivers/net/ethernet/intel/igc/igc_i225.c        | 2 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c         | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c    | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    | 2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.47.2


