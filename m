Return-Path: <netdev+bounces-148933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF50D9E381F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC47169979
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD04C1AF0A1;
	Wed,  4 Dec 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCXHpEJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578418CC08;
	Wed,  4 Dec 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310031; cv=none; b=RoHJKDo6F4fjpCXfj0F63kUuCtmqfNlljXHQa4/1Ydc5ogJKyd3ubMu2DQMF2s/Lu0Collk/wgHm0inoo2JZLoBw4IMVC/DQLRy5iAcTlSMwhZfyBHCeFSA6FTNTzFBoabxZuQFkeLn/WsmdM51N8JLDCaaEtepj0Ei7bs8XG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310031; c=relaxed/simple;
	bh=vye+kzWlLrb1WScCKtaKco87epqAQvilhSvbtspV+SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZVUttE+M/LocyMI8V+2gf4RSd7xUH+ukuRlR0I/2h7bjLrO8h5eZFv2Ck5qcOjzIHSod5m4/Ajp06oFIZF4ZektBtErCN2x4fLJwQFW9WBfkxQTChzV6RZeU32oHcsUCj0CELTb8dnWMNTp5uix8+OlDW5RYKonlfaoz9JwaWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCXHpEJ+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2153e642114so50434895ad.0;
        Wed, 04 Dec 2024 03:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733310029; x=1733914829; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vye+kzWlLrb1WScCKtaKco87epqAQvilhSvbtspV+SA=;
        b=jCXHpEJ+PRsyNEq6qmXTXjrs6UivdBZrJxfkhk64loBvmXKqXoefO3B2xBLuFrOzBA
         F/jsb+C/YPiWltzLE74Gxeen8i/CzBxGGenzBweUnhK/v4DfMj65v7iUSNGMlD/AQu2J
         CmXsQj+wUAOzYTeGnIKgV5FVU+F2kOgKjcvdPpa0TZ8iC7BHxg2I3abvir2mkINaVtRE
         wHhRzn0uE6MezFpT7yypul0TY6GOT6vjJl5qqqbWQ+Z+1p9DxuCIv0XVCy5rwjGMQe7q
         1CxUB26ZM29dTfIhcsCCFjfqHCF4HtJru+J1s/1L4C2jk5H6s4nWVRWyPqavklWONr00
         WGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310029; x=1733914829;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vye+kzWlLrb1WScCKtaKco87epqAQvilhSvbtspV+SA=;
        b=c5k9DGcVPdNNS+ttooqv+OFytvE5Xmt+M8eOcIfMgw1GsuhsiPVJUYw1flO+8Q2Z0i
         p5oFQSN0ZAFOM/dfJT8Q6XhwthKIj7IN0qyK1Af5vZyPtJ/N3eltNk0ZQHGdPHp9mnUl
         lpx2Rtqdc0Pgy6I9PDusQAEXoplYQVn2tP0BWdRQEDP2+xBVHuLBclHY1xeUJW++1C4p
         p6dIsuq2m9GMJGYq2IYX/F9Rojqx4EGDRCaeyEvyrVmu+3PkSbv9JJGmHaC4KQV5XkOc
         mMUDudQREBXXg0fXx7bt1SOuV3xG74KDOMgjHzyvamzYJUCePPJOt1eCPbwnR/+ABa2e
         oGOw==
X-Forwarded-Encrypted: i=1; AJvYcCUgSqwR6ZRFu/GmGLz+oCgb3iVXmbgYDrmMgkZZfUDZDaRl3wrQ6u/OcmKRx60hRF5ddme8W6RDeUJE0Kk=@vger.kernel.org, AJvYcCXmiJdPZ1kg/xt1x3KZtVz2S/1uVjt22aCFbtxeQ1c0/SQMkBa6wzU6MgYTG6PlwvgFQ4DxySN8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LnWrRzuIviRZobnvTPjTc7bxKhaiUkhEyFCimLllNhcn5qRL
	4r+Vsg1FVMEmFWSFe3jzVWK4tD2xGVY8Ntk/vAXH17wyBOPseckGAQytO5Kn
X-Gm-Gg: ASbGncsqNQT72CYodzM/ztvlQGUDcpIRxdEshu+82wQm/9yne34VuwjoOkUkjnelzZ2
	50gd3JE4vrZMKe4lWb2bzHf7j8ZVhd7ZILfvqXRt8VcLrMYI7u2V1nXna6K5qnEJyFDOgSTpwDX
	T7zVcL5aTfUm++4irWeB/Wn51Keh6R42jj1QkdcuJMalo/Y6PEXFuf86VU+rfSHv5novZWukiR8
	kPf/WECHgvLLHp9FRwrDlmxqP4c16eWBkqpSzdctFc9Ck1aFBhagqrVyRY=
X-Google-Smtp-Source: AGHT+IHRM9BHZCTScIYsJoW44b0kDkiSlBlPTy+yZNqZ+tb0WFx65rdgZr2EusC3tlsMSbPi5gjIdg==
X-Received: by 2002:a17:902:e745:b0:215:75ca:6a0 with SMTP id d9443c01a7336-215bd200b1emr76670645ad.29.1733310029493;
        Wed, 04 Dec 2024 03:00:29 -0800 (PST)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154a368611sm87089505ad.26.2024.12.04.03.00.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:00:29 -0800 (PST)
From: MengEn Sun <mengensun88@gmail.com>
X-Google-Original-From: MengEn Sun <mengensun@tencent.com>
To: edumazet@google.com
Cc: dsahern@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mengensun88@gmail.com,
	mengensun@tencent.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yuehongwu@tencent.com
Subject: Re: [PATCH] tcp: replace head->tstamp with head->skb_mstamp_ns in tcp_tso_should_defer()
Date: Wed,  4 Dec 2024 19:00:27 +0800
Message-Id: <1733310027-29602-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <CANn89i+ZtxW1HoiZaA2hB4r4+QBbif=biG6tQ1Fc2jHFPWH8Sw@mail.gmail.com>
References: <CANn89i+ZtxW1HoiZaA2hB4r4+QBbif=biG6tQ1Fc2jHFPWH8Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Thank you very much for your reply!

There is no functional issue with using tstamp here.

TCP does indeed use tstamp in many places, but it seems that most of
them are related to SO_TIMESTAMP*. The main interface functions that
set tstamp in the code include the following:
- __net_timestamp
- net_timestamp_set
- __skb_tstamp_tx
The points where this tstamp is modified are documented in the kernel
documentation: Documentation/networking/timestamping.txt.


The functions that mainly modify skb_mstamp_ns include the following:
- tcp_add_tx_delay
- __tcp_transmit_skb
- tcp_write_xmit
- tcp_make_synack
- tcp_send_syn_data
The tstamp in an skb on the RTX queue has indeed not been modified by
the first group of functions mentioned above; instead, it is set by
the second group of functions before cloning the skb using skb_mstamp_ns.

I spent quite a bit of time reading the code before realizing that
the use of tstamp here is actually intended to retrieve the meaning of
skb_mstamp_ns. Therefore, I think if skb_mstamp_ns is used here, it
might give newcomers reading the TCP code a hint that this is actually
the value set by the second group of functions.

Best regards
MengEn

