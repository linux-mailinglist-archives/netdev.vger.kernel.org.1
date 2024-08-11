Return-Path: <netdev+bounces-117443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236F194DF70
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 03:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C581F2168F
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E25522A;
	Sun, 11 Aug 2024 01:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452578F47
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723339753; cv=none; b=oSQInAtzcx1Ha3IHxsB+KTqQxu1eUlj37YrCvZ1brIOrHj3bBPegrgDW2Z9+mKDV9666vksiQUsgxd8oxui5vELYtiMIgd64EfBUZqlCy2tkcAwCoz3gQkq8HcZ6nb6FvoMDQ6AnR7oxpEp/L1lfxhx9g0zi8Lmj5UzSbCdMPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723339753; c=relaxed/simple;
	bh=PVTEAxVm0p2TCJn9bfarnX2DpggDhSS1pLi1OgMmIuc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hdm/k1cd1GjJzIphE93lOMBdUOUHXGSRVo0M6ZUX046l2bvhRiNhXbq4Et/H9KYRUnTc5G3o1u3egsVjs1LNJdelxPkZlPmgALD8ZRb5kU1VHNQiWWITt4y9JXU5xBiXsaMadnAu+iJJL45Ml2mGmgAfNgH9v1R0VW4FhSdm4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3b5858e6so39288185ab.3
        for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 18:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723339751; x=1723944551;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVTEAxVm0p2TCJn9bfarnX2DpggDhSS1pLi1OgMmIuc=;
        b=ECUDO8G51nkvzIbY8TH37Zbw3utGhDLG8A5SIdDqAx1qFhN6IXIHHqBlaowrSj2F1Y
         cCafuDQcNOxfnT/xQJXmkGhJta+dClyi19V1OtJcT96+w7q8GvHqpxYfvfKDa6NQTLS7
         qxZBbg893KDaSMyqfSdQ4yo2yO5p0u901AB2/hHSfvWNuVUlCSYE0U1c/f1fsOSJHfSN
         HOb1Azb3eYvV1iuoc/X20IblELTV6mgb47RT0WROiICtBrYIq9qg1zIkjPOKRiUPr6v8
         p3DquP3i8XG8HnvKXUFDn8Jb7Nc/jXwDAido06w89oDFXYYQAmjSKEBC3tknTNEKj3+b
         2ARA==
X-Forwarded-Encrypted: i=1; AJvYcCVVuYc2nRmMRnZ+W6FPC+EiHCUWVDtxNXlzV449iFbEZ12WLWqXfiFHFVyAdL2PrVQI1aoiMPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhHONxBdfFpJRyFL9doAJ7TX9ggV5mHqsUrSAslFACDxwgsSfz
	ITFYHPUQ09OFY1SGhx+gfosecBatFGmtfFTYCJEuJiF55s+DEE6MLJXDSx+fC6Fwk/dPhV9Da81
	0cNlrUak1gpHtWoT07U39u6EgW8nv2+u7cWTzHh+5uYDytemhQZlqSqM=
X-Google-Smtp-Source: AGHT+IH8hd8whFlEL9v/6x4e32jKgA+wEcUShKif7c8nobkGrc6IKbMdOQhSW1Csn8OOgLaz5qFGHULsIM3/PnBo2+RDB7XfKZAO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d12:b0:39a:e800:eec9 with SMTP id
 e9e14a558f8ab-39b7a47269emr4178375ab.4.1723339751349; Sat, 10 Aug 2024
 18:29:11 -0700 (PDT)
Date: Sat, 10 Aug 2024 18:29:11 -0700
In-Reply-To: <00000000000004e1640618d6298d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4ef40061f5e4da7@google.com>
Subject: Re: [moderation] WARNING: refcount bug in inet_twsk_kill
From: syzbot <syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kerneljasonxing@gmail.com, kernelxing@tencent.com, kuba@kernel.org, 
	kuniyu@amazon.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Sending this report to the next reporting stage.

