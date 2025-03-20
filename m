Return-Path: <netdev+bounces-176608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01D7A6B148
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE44668C1
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7F22A1CB;
	Thu, 20 Mar 2025 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe64bTBe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E9221F02
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742511366; cv=none; b=J+d5GPiESr/FwPPGNHvQv9Y409K93/D6VHYTw4kG/2QzHVPn8009mHFP2GZeX8xgg+U16O4/8HyCu7LeqMftzEPnoJCKCAm69MVMFxx1W+Sj6NVtjqQ5fbOsfwhzso3w5sE7d1fjsMkxfW638rcQemS69VS3AnQTDjaHsowyutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742511366; c=relaxed/simple;
	bh=rt7KPiSP5k8CujiU9tZ5jq2EDEzn+S2Hgqwoh3sT+gw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OwC8xScJpuaYO+/xFNRoVvZzkm5+XxkrTpE756iDDi6SmxHWoxxxg4fcx7oIdfWUrDjrpDWISKV+PLGStIyqXLRyPwaxfIwTqm0wUF8BRs1OE9LhUwwyvzObs0zdsudz40uq86LUNFOZfeTcgarT1XBknzuPnIGbjTeM9u7wrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe64bTBe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so2530409a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742511363; x=1743116163; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rt7KPiSP5k8CujiU9tZ5jq2EDEzn+S2Hgqwoh3sT+gw=;
        b=Xe64bTBeWs24fJwai6DNSoimXcxuRxCwt8Xm29OUWXw4YnTAmq1HNkrxuHtj9Rh/qq
         CbMZa92g56+Nbl+OSb8avOgZYjjsYU3U+XIxsXoU3o/54gCqcRwSvZXyJ4ELX0Df/wRi
         MGKOPU9GC+Dk3tKvjsUrd8hOUVx9JqHcF+8G/7VibRUrNA9KI6+2ZCGbXI+9RgscR03Y
         GNuLr6jXbSkdS9xgqjVWjmbx7MJIcgPr4nVikefiLl5OL5sqRdYhUXhzP5gmNYfBzPWL
         KxZLQJJ1Dm4T8xs3tlzc7PZDkI2wxhyXjYkZzY2gwSInTyTk9GkzjNeFOfvZ3VrpHiu6
         NQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742511363; x=1743116163;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rt7KPiSP5k8CujiU9tZ5jq2EDEzn+S2Hgqwoh3sT+gw=;
        b=Q7t+W8EVyHG+vanjib2IfA/aAFmqQg/Fvp7RvIBHpXkYtdNLjSmfzQBNpmIX6MjRN7
         8daICEQByVRGiApPFufQRxU3ef2MR6TLUa7aMxwmcjIQXIrqf6nJJzBvqZfYdDHuScUf
         QZJoqNkVoIapx3ddeiBSXB4pCEb3Y4oTxe8v6OY2Kz9km2RmGgrp4ofqek8x6Xegauds
         0ov6cbEV4xZJtJ4rpFcn9y7m3mXMDVnudh5nmVnK5wAR8Of/9IxjlVz8f/JNaOwL2Aor
         f5j8mDsmpIvbOrKJRsPHwSC2g5Ts2iVJqcYmavbEr9JDcZGlzJo+MUW4v1bWAQtq57dD
         IJqQ==
X-Gm-Message-State: AOJu0YzE0lVmcx6oSGxrdAAQJEufW5N5BCXtSYgXvbNo7rVyrsIB2+ZQ
	UuWsHp7kY/tVgRwaZ2ydW3nzxSO2i6b20vmIDHRqpEjif4eKH49RcGAJ1NXx/1VJP5KFOsNhl5d
	l7m1/4PoWzmdfCF6FKdnPzIQ7+1Q6gBCSQo0=
X-Gm-Gg: ASbGncuTW6hpiTIyJ/KbqhBK56F1G6AoJex46ygdC7so62+GL6wgu8M9x9AaDOqkEXM
	VXH37h4QqoV7RQafoVDPr0MW+8sqGDBFvUsJlpAZYfn9nfxtPbDrGlFmdE4rVJcZodcsSSrUmkG
	eQ8JF0IrkX9NEF5/6zQmq2yemMDA==
X-Google-Smtp-Source: AGHT+IGb4Pk/C5JxVNesfAZu1gjBOjCRIxVoDIPD2fnpi+FpuTs69hqFU+FA+UX1DUswRIC/+xClmL6Cj2lXMG8Ellk=
X-Received: by 2002:a05:6402:274c:b0:5e0:6e6c:e2b5 with SMTP id
 4fb4d7f45d1cf-5eb99740e1amr5875693a12.9.1742511363074; Thu, 20 Mar 2025
 15:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Antti Savolainen <antti.savo@gmail.com>
Date: Fri, 21 Mar 2025 00:55:52 +0200
X-Gm-Features: AQ5f1Jrh2TTckJkpbWU_9SpIdeQpo90wd9rHPV9gtyp2MGI1nh-CZr_SflRZbDE
Message-ID: <CA+Z9nRedV6VrCPjbrvb3yDwTBqbOK1fAic-b8Q4W9xJHT2cCUw@mail.gmail.com>
Subject: [Feature request] List all defined ip routing tables
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I would like to see `ip route show tables` as a command to list all
currently defined tables in the system. I can kind of get hints of
what exists through `ip rule`, but if I delete a rule, the table still
lingers.

I don't mean listing the contents of all tables like `ip route show
table all` does but instead just list the table id, its alias and
maybe an integer of how many entries it contains

