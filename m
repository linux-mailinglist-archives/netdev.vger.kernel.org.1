Return-Path: <netdev+bounces-192333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C7ABF85E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E519E68FA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E6A214225;
	Wed, 21 May 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHki9TFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9A221710;
	Wed, 21 May 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839054; cv=none; b=UtRXOwJfUj0iZkEYiI2H3gohCww5grB/MlAW1eAXkgk6QMdhxAR47zEUXRxYPoT9PJeh60zI2uEwb1NoC6p6qqPUplAPeAeb6DDc1doQHPFomJhuquaDJrUS3nWZGylSs8wXd2G8NqpXOVomNZyTGlmyWGGgWZ4jBzK1k2huZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839054; c=relaxed/simple;
	bh=QxneKmmr3mJI+3YYUP0u3PQHesj8NFPMVLk5slN/ZNM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lquwxuFrpP6FbG92S82xIWMb60HsOZ3F8rNsoRIG4AeF464V/iY/K4x9/CLSvDQP6RY+fHzMkiDLY4TS3SMtxKNm/Hst239XoibbSuT0SaDiWV08JjjRcMW6fhZX4/hLqlGQij+m+2J2InQPGBDiApxKBGFAJTafhFTi8HWwS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHki9TFk; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso65140181fa.0;
        Wed, 21 May 2025 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747839051; x=1748443851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxneKmmr3mJI+3YYUP0u3PQHesj8NFPMVLk5slN/ZNM=;
        b=lHki9TFkCaLnxyqmiua8fpSnEf/gVtPPtfzNgHao9BcIl0kESQIX3Ij3eM0PgQamhT
         QH38nAARU4GcRf5Cxd4H84H9uO9XXSDAr1S/QN8Mqws4KC6nuORxu6RRr8F4iQjPUfhR
         W1GqcdJjnu1udw/jV7c7zNr0hYy+7cr1v30i4cFq+hdBAvZLe+WyUeRXkBJG4rESyC7Z
         NpArZf3wjIdvJmvs5K0ETN8r8DVlDuCNa9TSnlT8ARwlO4HOwiEz2vximluQZwqNbQWo
         /lHKvR/TZdfPKZcX6/VNFacIsPhA7rc+eeeT74hqi26JXEuTmBKT3qDXfqRytIN/agxG
         63gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839051; x=1748443851;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxneKmmr3mJI+3YYUP0u3PQHesj8NFPMVLk5slN/ZNM=;
        b=nHqAtShy9lzOBzD+VHv4MhOhZli1MuxRUkf2DQsdFmwhXyi1u9OVJwQm4tH6MZz+3F
         3OD/azCMaMWxO9m756hYPe6JqgyOemDRRP8Ch1oqennwk3DJBa8dZCZi0uY5+Cb61eZW
         4JmboF63UtWhPoLaebMHR7NSumvRJNlotlBd0dMYFrQsOEEBidd8Sr0BDPqdNHfl9PKR
         MAXBRuvDyeXkCKVd2FiP1gUUkoyf7E93IKU+uygGtgL6UFgN7Rx+XxKfGTpUczMEH1k2
         mduuVUKlBKeaJeaSn5r8NDTeuuwIiZ38znxfjWxqc/yjnMxnGcysBxERff1Vur/XkjPd
         yPkw==
X-Forwarded-Encrypted: i=1; AJvYcCVfAOic3iKkDATYq1eqSf3vF4GWPQSaseUK8Te2U0r4+kiWCduVSzhPEzyAInIfGn6eM/CuFpPUoONnPGs=@vger.kernel.org, AJvYcCVnS4+yaRVuUo8B26EFYRzLtcTj6I5SpcgQx2SCYXYVw16+0JBLyvCSwksMh4rXQ8NyZ2s0lfHi@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBp7bfAHp7SOBfouVtVB9ezonykcKMiMdHhOVjHIIU/FAthGA
	zyJqSHgsii1sV20w/O5BkxPtHqEfMvBpji5+68XRg9cleNeSFLaPqchDiIAT7czwGU6mmSRbuVl
	6KwuHQ4+9l/1Ose8K4/0mdEnAMd2BjzeSdYpLpg==
X-Gm-Gg: ASbGncvFdCGcl6FwmlROxjuWbTdkXiJ2+A8EPIr0HNEJmg+TgKy4OGRHw15WU+ZVQEv
	YJrYqujqdI6bQh2rk//Mi+50MgL1yLTLTNPsMDICpcDfznNLQjjVlFAzlEG1mdh9HA2/h9MYMOc
	cONHNsvuPP5Drwyk6imOJ9qI1EVp/A7uBMSiwt65u4angJQJzSqqPaNQ==
X-Google-Smtp-Source: AGHT+IGXeK2bJRSHq9+X9/weSD2S5DZ8I+axVPCz9+wAKg8SVazBUsA9ngz7AgsmmG9o6rp80Q5eMh9W5Cb2/VPt5ng=
X-Received: by 2002:a2e:bcc1:0:b0:31f:8659:dc23 with SMTP id
 38308e7fff4ca-32809780216mr94716521fa.33.1747839050704; Wed, 21 May 2025
 07:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Wed, 21 May 2025 22:50:38 +0800
X-Gm-Features: AX0GCFvNK6mL5qUAhg-uU6jliFdjaxqXLBL71sgv5-Tzci-EyZvQHvg1ssoNlxw
Message-ID: <CAP=Rh=M1LzunrcQB1fSGauMrJrhL6GGps5cPAKzHJXj6GQV+-g@mail.gmail.com>
Subject: [Bug] "general protection fault in calipso_sock_setattr" in Linux
 kernel v6.12
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.12.

Git Commit: adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

Bug Location: calipso_sock_setattr+0xf6/0x380 net/ipv6/calipso.c:1128

Bug report: https://hastebin.com/share/iredodibar.yaml

Complete log: https://hastebin.com/share/biqowozonu.perl

Entire kernel config: https://hastebin.com/share/huqucavidu.ini

Root Cause Analysis:
The crash is caused by a NULL pointer dereference in txopt_get() (at
include/net/ipv6.h:390) due to an uninitialized struct inet6_opt *opt
field.
The function is indirectly invoked during an SELinux policy
enforcement path via calipso_sock_setattr(), which expects an
initialized inet6_sk(sk)->opt structure.
However, the socket in question does not have IPv6 tx options set up
at the time of the call, likely due to missing or out-of-order
initialization during socket creation or connection setup.
This leads to an invalid access at offset +0x70, detected by KASAN,
and results in a general protection fault.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

