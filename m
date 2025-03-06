Return-Path: <netdev+bounces-172677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27424A55AF0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F1E3AD36D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4227CB33;
	Thu,  6 Mar 2025 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnyfkgQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2809203709
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304170; cv=none; b=D6qqJ1/akDdZXA7z8FEMl/fRgFIanmDW4jVAHf1+yNQbLUz6mgu9NylGq4At4Ab5Dt7/LdAnbqILo/Q0qL8XO4E3g1XO6B0fHaMFaRYI29/rRDR060G64CEhGKT7Zz/WCVaEp2o4pldu66Zi8IpHCCaYFOlbwRF1Kc10gkw24yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304170; c=relaxed/simple;
	bh=IX382TCXeQPzbLf3FFkDdMwcJzFNpGNgc/cIKnnf+H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPPgm6OFvFiA/NJEksnDWyBFNe8XXW9LxlCeuRbpYdTmBciYlEYDzsTqN6ddZ5ox1IWXw1WqXpz3/DZa4Zrj6sJvaiEaW9E8Qa6CFD7eP0ake0HmNFqRo5yb5s0n5PBaiKJ37xxGUDh3pOm+HqCeKepNcN99HNqVB/lzty/NYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnyfkgQS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403cbb47fso23950845ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 15:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741304168; x=1741908968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SL+2ytUKb46heIU3P2MoTLyyCniDPCc4uhnTC1W9yeU=;
        b=hnyfkgQSjfbro2zRXh6366yDSDkAO9eGGuCbWDpBUyj1/kWMbQV8/xKI5FU+G+vvus
         QvA+jWhUbSYe3wWDGjqs5VuMG8ozX4ibuihp5oEyR4ZHgkCtZN/eBtcEFsAHNeNKbjNs
         Qi+KU3IOjfeBOufgjR5AafWr27LltfBiOQNLxTCmnUNYpwdeheLWa5db9BpoyK5oz/AA
         dEX7gd8tIB6/xWGIXKe+ItkKI/Flc1gjfwWFlDxaM1WOgNtSvYYnPgMJsQ1xqpf4oWzr
         IILuCTkVAWP/XkaOuW/737/UT1poMUarNhDnJNPOWP85O+4RmqaoFDbctR9/pRdk4xet
         3Veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741304168; x=1741908968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL+2ytUKb46heIU3P2MoTLyyCniDPCc4uhnTC1W9yeU=;
        b=Zb+iwLXOcQrsUCIH4J16UyUEn5U2BpRstuoevyq/h3p5aebprT+f/KrrSb0rpbJ85t
         3RI2St4bmfRx5KRI2vTzl+zqs8WxK8TjGn5fYxxLqDVGmHdItMumIjk+19fCHZ9KdCTt
         bQzxx0zYx7UzUWNPLi0mRUjkga4f4IpZ5Q6wM11WabHe6AkgnjNmQk+BdGOMdWeh8MFq
         apEbqdDPNSOyXNDGeclDNoZRWD5CARLmG0VwoXK3Rg6RBNwyPdqeCGXSV1YyKgpnyb+S
         V7oEbXqzsoCjUcbbl/ErwCOIBe7RKga9lW7Xda8+biMqxdpJ+aYsdT5HJIuIANplryg+
         y31w==
X-Gm-Message-State: AOJu0YwtRjDoU1hixyESoQArYw5QFzs+W6RhSkcFke16GEKW1Q4yVQwK
	12+eUS6rTXrONKOGeAlJbavlwTNUqbK1SNeA4Fvgz275mpW5/t3H
X-Gm-Gg: ASbGncttvK2Zzk/ZE3/Ffe/RZkqGJPKdRHrUDPR8U6CTmTdmrojKKJHhnyyE5enGbwM
	jSVZOnKHoE1xMw8dGuDQjE1TmbKBEoHI3Z2FlGlQYlfNu7J1pt3zy7pGyMDBBkfcbaynq5m0vr1
	raiZcHLTOzA9fxv04tcf8/Ulx9VKjQzlKIpogeCNTJtZh+WLIbN/Q+Hrl2zrVvXPtx5q6zVxcga
	W76x8EJ753+sUvcHchdS7q+KLPGjdzf0TQQDNg91U+CEgrghXiXZNbG4vL5iZ+J+A4kjS+d4m/f
	DaXR1SX+vNRpvaMTKPgUDRXkvaJ+8UDPoXUrCAUdXIcILibF
X-Google-Smtp-Source: AGHT+IHVPmBDPiJCuFauJG+OsBaWU19ZIEp/ftPCC6m2QWVXE9h1ir8RfUFG9/41DBHiP9SpxqQQpg==
X-Received: by 2002:a05:6a20:430a:b0:1f3:4667:7293 with SMTP id adf61e73a8af0-1f544af0b80mr2130162637.10.1741304167917;
        Thu, 06 Mar 2025 15:36:07 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736abe02bdasm249973b3a.31.2025.03.06.15.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:36:07 -0800 (PST)
Date: Thu, 6 Mar 2025 15:36:06 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, andrew+netdev@lunn.ch, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com,
	Olga Albisser <olga@albisser.org>,
	Olivier Tilmans <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>,
	Bob Briscoe <research@bobbriscoe.net>
Subject: Re: [PATCH v6 net-next 1/1] sched: Add dualpi2 qdisc
Message-ID: <Z8oxZk3yqiYxXJ6C@pop-os.localdomain>
References: <20250304151503.77919-1-chia-yu.chang@nokia-bell-labs.com>
 <20250304151503.77919-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304151503.77919-2-chia-yu.chang@nokia-bell-labs.com>

On Tue, Mar 04, 2025 at 04:15:03PM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
>  Documentation/netlink/specs/tc.yaml           |  140 +++
>  include/linux/netdevice.h                     |    1 +
>  include/uapi/linux/pkt_sched.h                |   38 +
>  net/sched/Kconfig                             |   12 +
>  net/sched/Makefile                            |    1 +
>  net/sched/sch_dualpi2.c                       | 1081 +++++++++++++++++
>  tools/testing/selftests/tc-testing/config     |    1 +
>  .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
>  tools/testing/selftests/tc-testing/tdc.sh     |    1 +

Please split this big patch into 3 patches:
1. Documentation, changes in Documentation/netlink/specs/tc.yaml
2. Selftest, changes under tools/testing/selftests/tc-testing/
3. The rest, which is the actual dualpi2 qdisc code

As Jakub mentioned, "mixing code changes and test changes in a
single commit is discouraged."

Also, this would give reviewers a break between reviewing smaller
patches.

Thanks!

