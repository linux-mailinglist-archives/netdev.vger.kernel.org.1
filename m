Return-Path: <netdev+bounces-111587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC5931A0A
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B203D281DFE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B3261FCA;
	Mon, 15 Jul 2024 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="BRdh+pa0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AE47A6A
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067235; cv=none; b=sXkzcXJUAv/m4XuIA6X8a1vO57JVpKw6Tq5GJRQy5/5hXnZvA9kvc+L7odV32ByR+OrGHD0qERdmYy7p7167NHtiWrKKTZ9O9GvpootGvCl484khZcWxJzGeYr0eDywL12HmlDzBUt2XM2tTD5S+tKGXspQxmxNRY3T2zHeCzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067235; c=relaxed/simple;
	bh=OyQaX13g6fZ3FDV981yg9TF3NDb99brhg0jmaNA/pjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMiOlbiGVg0Y//64M+1j4upeYJnGimMn/5wAM4VpjPwYLCWyouNYaJF6GSlAjo+vn3CQ92VU5fg4zE8hXdb/UqtXMFPcMLXMloCTBezWDGziTfKkdf2I6R/W7oy2oB2o0ebi6QoSiyhtcmBfD6uFtVhVilqUHlU0oAI81pUgy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=BRdh+pa0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so61512631fa.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1721067232; x=1721672032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyQaX13g6fZ3FDV981yg9TF3NDb99brhg0jmaNA/pjY=;
        b=BRdh+pa0OsyE2yBtoBIidRTp2QIbcoO19nmriZMFiRTrpf4s1YZ6GJVTC1h8rqN6lG
         w3uTNFkNxyNxuG8d6uKUci1LB+sKrxQsDY0x6LG0874EDgEwbIffSSWVLikK5vsF0eRW
         xi03xJlZYN6FH/3D2QSU9gKOl/BTrV4MuIdXyCLJpqth2lfTQhuDr8N/tFyR9Orc86Wo
         PUqlU1Aa/7bPlH/f+bCUPa6eTx7sbPpraUgR6E7i9N7kFzON/v4aaCGC8Lj1tLAnJi5B
         lhtMzlkC7DWgAjiEoeUSHyMkJIA5gZDYuuSGVzSojyWbGx1mYUgW108qjv0VkbVOb+jA
         bN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721067232; x=1721672032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyQaX13g6fZ3FDV981yg9TF3NDb99brhg0jmaNA/pjY=;
        b=AAMI5QnHLYdd6nkHN45zuYeiToMdkuxcqrlsLFYP1pSuGswGwNftdxFwTejiRHvpYI
         6p0nRVMJsbo1tDER5LS5LRKpSepZaKtOgAQyMJkiTABoJkOI5PcFB7uUV4hCE3YdDihM
         wMvrfwuL6VB3vaVTQTTx17Zvh4xETV5nQVT6u4eOtvoA3vrv8i18zdzbfp9pkJUnm+fl
         hOzSdyGOMFbJ8ZDeLBIGRD/nrew3JPlKBEm53zCMO/SPr3+pSslnm47YqRxVfDtm9Qy9
         S9l/3O71L3HDDNz6cLyfTrTJ2Tfbl9fU1EB34GQaN1byIjJpbjkMMgd2GzeAE+cYlEnR
         PX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRynjgArj1EDzj2upp1U2GUSWWvJaI+Lm28148tbUSPf32Zeyz0v5KkSUoEcER4HZDEiYlpPk/jOd4pMZVlaytHBjCJBE6
X-Gm-Message-State: AOJu0Yw91CXIcGcL2fAn9uXiIyNENw2XsS74so3d4+67L8LugAozGDI1
	bCyYDEmnt9HWocL+6RyEaQFV65xDYb8uC0cGIkA/v4GsINnjnLkQyVdAKsogPAlVIA1MvfSxvWA
	y
X-Google-Smtp-Source: AGHT+IE1MCT5csLVEkXxcIBInrcBdilpkD9uUM3tli3sVFKAV0RAXWlmm+TCms6tyOMqacFDj1F5vw==
X-Received: by 2002:a05:6512:400d:b0:52c:9421:2739 with SMTP id 2adb3069b0e04-52ede1a2ecamr225521e87.9.1721067231626;
        Mon, 15 Jul 2024 11:13:51 -0700 (PDT)
Received: from michal-Latitude-5420.. ([178.217.115.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm3660649a12.41.2024.07.15.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 11:13:51 -0700 (PDT)
From: Michal Switala <michal.switala@infogain.com>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michal.switala@infogain.com,
	netdev@vger.kernel.org,
	revest@google.com,
	syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: Ensure BPF programs testing skb context initialization
Date: Mon, 15 Jul 2024 20:13:39 +0200
Message-ID: <20240715181339.2489649-1-michal.switala@infogain.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAADnVQJPzya3VkAajv02yMEnQLWtXKsHuzjZ1vQ6R19N_BZkTQ@mail.gmail.com>
References: <CAADnVQJPzya3VkAajv02yMEnQLWtXKsHuzjZ1vQ6R19N_BZkTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The reproducer calls the methods bpf_prog_test_run_xdp and
bpf_prog_test_run_skb. Both lead to the invocation of dev_map_enqueue, in the
case of the former, the backtrace is recorded in its entirety, whereas for the
latter it is not. I think the bug might be incorrectly reported on syzkaller, as
during GDB debugging, the problem occurred in functions called from
bpf_prog_test_run_skb. I also ran testing of my patch on syzkaller and the tests
passed.

Regards
Michal

