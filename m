Return-Path: <netdev+bounces-140525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9379B6C58
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 19:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3DD1C20F95
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C861CBE89;
	Wed, 30 Oct 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCgyjlFg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD01C460A;
	Wed, 30 Oct 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730314601; cv=none; b=ccSDFFRgIYQ+RzclxVM0HgpKhMenLzPkQV9KfETktyOqIpgCOKiz4GBOIZkVyez+vXVG/VZ4DlOGdxMP1LbhYSzp6ZGQ2pHrewt3qBmGtwGnqayxoSL2jeSLQVIUfZh/5zYMzphDxvJocpS/mxKyEjBqotj0aMWA8q95XAYbeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730314601; c=relaxed/simple;
	bh=20YiWshwGqPi6EqRGa2V2wZdThZPQZc7P9R2zk6JTDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8rphdKImRu1HAhIvtvy3wWm36H8iRtUWNvH+qjwxal3cKxzRtm+b50jj00TrX5yhxzbygesSypaTWu3Nm3jPtAwQOi6lq1TzVUIww5VOD1BLf72ugt3WypDq7b+t0A7ErqBepDwkbDRv27kDuhxxh5M1XwYbLCZ2yVAg8ChTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCgyjlFg; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47ec4ef2cso24703137.1;
        Wed, 30 Oct 2024 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730314599; x=1730919399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KtXB2ifDIWOa6mGWGS93FJVDdAa3M1hw2PYhtDXBHw=;
        b=FCgyjlFgSVS2Y8CzfOc6LCGWmSZV0FFvaNsN5CTjcn0HRg5yXTm7WzniitbPPrrW/J
         V3XaFJjzY9jxwHuQVu9o9sdhcwfgN+1uk3NnfclNqlc9NS2sYzsGCxUE4O3giU+C82q0
         7g8maVn3PkH6c7wPRcSlJapwGRPF7yDSvRH+ARtuypr6ojvO8tLJctMEH6WKWasvlgTy
         PtIwNgidAksfvCOb3DIczG09ypvMTTT1JDbVz7RtIalmki8Qsn9JHXLedhdxs2tVDbNa
         ZAINCV5cGwgAKwFsBx9XHQxmEj8FaY1TRfRPHTcxVJkjEkxak1KX3zFi87ePkXRNMLSI
         5pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730314599; x=1730919399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KtXB2ifDIWOa6mGWGS93FJVDdAa3M1hw2PYhtDXBHw=;
        b=g+Ig86LXI9DPHjMiYL4ES7a7JqiTE7uaeIvq1xa+nzqHN66Ilfg1lOotq2nXtl6wlK
         gV7k3BMVjNTj9yW3oYA/j14Ea2xmQORrWnYDUcLKYdw7zMCAOfu1KE7MEk5Y8J/NHA6z
         vVCYtbaSOkEgl771JsFwwvfntes81LhEAv6QkKPUxpHqD8Eb3tzhqFdr9RKDOni6+GTU
         3H7VZO8U7ANID2j0BkAd92WQHi6KyUZUJgDZdscK45sU7WvDpVdMpZAP//0s4eRcveJK
         4JH2pR7ouYIjFIZEm4NDh46MO/E1qAxdUbEtzXMhSiABXtF8tQgJM7avgdQTKgqLkC0T
         0B6g==
X-Forwarded-Encrypted: i=1; AJvYcCWVBNoXQFOsnqTMKJaCtxEG8XnoQedimRw3LPCD/8ax55Kpuz1SGeuAXK7M7Mzk+Ci4ZN45CBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7nLOdyxLvcPRiLNtP09sciWnW2dQdEmVt38baTWKT6IluFPp
	Px5624zoSM32/5Qm0qtJPslhNsCAoFKwdmLqH1hQcQhpSkel+3HO
X-Google-Smtp-Source: AGHT+IHd3Q5gpXEAvr5BZqPhq5nt9L5gENtg+LTIa7H0ixSlfohoq3X2s0C5ogxXoJmFCj48m5W4ow==
X-Received: by 2002:a05:6102:390d:b0:493:de37:b3ef with SMTP id ada2fe7eead31-4a8cfb82763mr15445500137.13.1730314598731;
        Wed, 30 Oct 2024 11:56:38 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85580b38f23sm1569007241.33.2024.10.30.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:56:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-10-23
Date: Wed, 30 Oct 2024 14:56:33 -0400
Message-ID: <20241030185633.34818-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:

  Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30

for you to fetch changes up to 1e67d8641813f1876a42eeb4f532487b8a7fb0a8:

  Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs (2024-10-30 14:49:09 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci: fix null-ptr-deref in hci_read_supported_codecs

----------------------------------------------------------------
Sungwoo Kim (1):
      Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

 net/bluetooth/hci_sync.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

