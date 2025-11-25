Return-Path: <netdev+bounces-241536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C92C85666
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BA33A6768
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD0E324B1E;
	Tue, 25 Nov 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QF8YmHXR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D731C57B
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080640; cv=none; b=KpZjgS57EZzGgwMCAO9RMhZG2hCxvlJa1RbflH/r+kKHWpwad+hGRZ6M8ei0x2/1nNr+HAc6obVNyx6wEonobcq7mRRbr7l1l5WeyqENSiXBgApuR3h602FqM4qOyQbaGopxXr+4Ox7Hiu0IAKtL3zFy4NWXNFRYs7OrYwHFKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080640; c=relaxed/simple;
	bh=6LqfH0zJp1SrXC9x7HOD/hDkEmKu/xLJPb3kSuBSxAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KM3Dsuxnq/H2giIgvxb77hf/e3je3erQjr4UJiAGbt2sQRKVuV/HzizRyDVc7ORz9ZIiB6MAVRw84XfwscdcvdtPxQmsuCO0ysN4b6YWkhh/XCcYenhscW12cqef+nv4E6AF47jw6V5bLAlyhLDTLWn6Y9tRjwyMGsLDCgw+6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QF8YmHXR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so7883093a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764080637; x=1764685437; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LqfH0zJp1SrXC9x7HOD/hDkEmKu/xLJPb3kSuBSxAE=;
        b=QF8YmHXRAWwk0dH6yrLCnzq0GFv49raJy1vcOv1Blu+pbbXsfK/mgDx5z2QWsgBl6k
         7nfVdrhbGI/gH0u7iXWIFqb/WiwIrnJb5vcqLtrMKmWc4m694J2scWRECp8hgtwdmIet
         HpfkMusoKmG109uW7Ftg00rMvp6ZQaKhO7ithytjblJClmjtLIL7KF3yfZfOltHOgPAd
         eGgHFiIIat2/xdCdv7nkW1b6+YcHjHrc5llZYzanDfQtWmJC/QzVoNsuaydkdt2xgMQD
         Q4PQ/Syg9HAwRpFEBsAhSOiy69SVJTbBhNDx2IN0pBy5ndDUEAeK5uk+eHgEMVbYLY17
         9PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080637; x=1764685437;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LqfH0zJp1SrXC9x7HOD/hDkEmKu/xLJPb3kSuBSxAE=;
        b=uV8bqXFV01XT2KOHbirHbCptQb40FImhWCqPDOhjXjaG5Qe9YozSKGwpL40eYbWlRP
         Qm3suKH3IVul7tPZ+G4Q2yPLKhI2eLeaENxa7Jf0elWH9W2kCySxPO7zCzDlhLaRcTpO
         ImQxUqvnd/TXYTpqCn4JqNabGdae3XnRr60I123FxApsQGG/LigJmGmqsdd/TGvScRk7
         8hKM4pY/ul2GGXgVAuskcgkTt4FxhyjzQmf19ngWZAXW0QYqP2ywWWFTJgTMkJgBIXCG
         ofDtbMFF23LxAbSZX5IbiOy9/8ENg1XEHvlZtti6bDHPtGlfZ+Bo4rS9RFJHn5s9lmWp
         Frwg==
X-Forwarded-Encrypted: i=1; AJvYcCUeSCVljASeJXDnaieWcY3YcNg+1qLaPvD1krpWplWBpUwZBON8BdCDEHYZqFHJEej8J5BWReA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40ruKbn6EVmMtO9PJVSUI2D1c5Bla5yW1+pYmoqjgv+vcho6s
	phypU6IvZ/44AA0dZnnyAKu8stXIs3n29MspzEMuHksvztE9ji6vgLJ2pf+2Z6vKsaw=
X-Gm-Gg: ASbGnctjgf4+XEfE6rY2NyOEyPKaPenhkYUBbfpjjKcfFwvPL9YxrICb3TGz/viChGG
	EP/9ZW3UXmkEXChzPLXQPvZ0ZZJ2kZmBkOyWay95Zf8zhB2W7v4YeMKJ8DditdTHqHveI1eAKkn
	J9dqDOTf8QRFJg7Gj1EGJ597mSsdSPcSVqaM8AttPemWZjCxcc7/EIkqpIpci1TgSsGWQ3ni2VA
	YsV4PGGL72UYmXMk9RCBdwfirPneYYfe0/ZK0pWXZ3wIsr3vUsw1t0ckBSelgJ7ERXcmcJZt8hF
	9zwXJX6zAanEkUgGmmhaIGA9kaLmv44nIRDJ/xT1WybN2emRVnS6Wrg/ymcfryLC84ikgHKKoBq
	ii4z54MXb2uo3M0jHomHL380BQtIqZ6GjFgMH1jTuATesZVkDnBfbbTsRRPY4mHrhY7pSK14ZFq
	Snn7gsYAvCokaDgQ==
X-Google-Smtp-Source: AGHT+IGsyvKHdORKwFth+3NCAwQtMjuvaLmVXYSXCUsqAqneazOk5U0n4dygLYxdjqbi1pYRvYvXyw==
X-Received: by 2002:a17:906:b4a:b0:b73:53ab:cfa1 with SMTP id a640c23a62f3a-b76715ab9ebmr1277500966b.17.1764080636819;
        Tue, 25 Nov 2025 06:23:56 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ce15e7sm1627635166b.8.2025.11.25.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:23:56 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,
 kernel-team@cloudflare.com, martin.lau@linux.dev, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH RFC bpf-next 15/15] bpf: Realign skb metadata for TC
 progs using data_meta
In-Reply-To: <4d340abe294ac0290710c745f5f48bfb89b12ed3ac2be1c2df6d85848b45724f@mail.kernel.org>
	(bot's message of "Mon, 24 Nov 2025 16:58:04 +0000 (UTC)")
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-15-8978f5054417@cloudflare.com>
	<4d340abe294ac0290710c745f5f48bfb89b12ed3ac2be1c2df6d85848b45724f@mail.kernel.org>
Date: Tue, 25 Nov 2025 15:23:55 +0100
Message-ID: <87cy565gxw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 24, 2025 at 04:58 PM GMT, bot+bpf-ci@kernel.org wrote:
> This appears to fix the bug introduced by commit 016079023cef ("net:
> Track skb metadata end separately from MAC offset"). Should this include
> a Fixes: tag?
>
> The earlier commit message explicitly noted: "Note that this breaks BPF
> skb metadata access through skb->data_meta when there is a gap between
> meta_end and skb->data. Following BPF verifier changes address this."
>
> This commit is one of those follow-up changes that addresses the
> breakage.

False-positive feedback, naturally. Both breaking change and the fix
belong to the same patch series, so Fixes tagging rules don't apply.

