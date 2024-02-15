Return-Path: <netdev+bounces-72127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDD856AD2
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE42285FDF
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9DB13666F;
	Thu, 15 Feb 2024 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoujuFNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF62136659
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017674; cv=none; b=c7mCv1zWb3zId+Tk1/S/FQJ/3zyDhus5eK0qUjYXlwqyatpCZ+eEj7tJsP8d7pp0qg34oW5FlAN/RM3O1y+ZRf4mnxSQ3dNM200fsAO4PwMA/3DCk5kwK/OLI0jHq7c3V/rdqk+ND6WqArA+fn31dtZdd6LjGXkE9bKe5BWJxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017674; c=relaxed/simple;
	bh=S1c8EFNKCsKtHCTJ9gf1NF6jibwkZ28JrnLWadHW15w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aRk1g8KbUzGOkV++8liI6f6riLfXUG/I2RFmrVN+WRgese9fRhFTIAxtgz3WLd+FfnSnX+7tkynSXc240syOQ2xcA7yPi1fubJfYV0T+vMdeJX0XqsJY7eoPYRUiLOdOqVtVS4Tgt4JIBclBrRu9UFgjDAH7CLQHZmNOTw25Jds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoujuFNV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1646714276.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708017672; x=1708622472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JZhoW6LMXXsZ2r+G3uqe/yz5XwkpeYcPohX7Gpa2vVw=;
        b=BoujuFNVB5zy3UXPiztSWMiEPFaAMU7FvYqUunnb+19DdfiIw2f4C/8kpP9ARo1zur
         Gy5igcywSquP4GgKuRM32nYHv+VsJzvoA0CSZVStdPOQ3vYsNhc5dFW3o1iWaZzXatvY
         bNf7KdtB8SQ9kVpBT2dwWRJh9eNW+nwolqVEuDf8nmuCrUhcRzOY43U8gmPhcUmHS4KP
         o89dJ8ezTGMHm5OHrW6mK2un7coCS0ExD5IQTDI6nRVoXqAxPbJBBYVPZXmM+6+LAXvj
         GhQzZYvmto97DXKMUgLEqoMx2B10RFmau9p8p4VQiuqKyd2Xmm2YPlBDkUVUws3MQtem
         XpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017672; x=1708622472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZhoW6LMXXsZ2r+G3uqe/yz5XwkpeYcPohX7Gpa2vVw=;
        b=eXISh8XKsaT7ATeI+8wGBZszqYptWP9ZEg3nyKNX7qbtHR7GW+QONIQvNBII6kMWnD
         vMeIzv/sbj2TCDAaNM/0p8HsAe/Zd05SQmOsLTgfLCM091upqOyu1+JABs2iADl8OrI8
         uEI8PlG9R8chjY8wPPR00JG3nE7s82D5QS4k5EZVfDxw/iiRE26LMXzlEd+M1YvXcr/h
         plPes2+6J2AtzPzIKm5shwnurVMVMzHH1zfzGAd5Izk5/CnmmlZFGb1Vb3URkuc5AN/W
         ZSfUGjG6yP1VsTmdYzP7R/z4rpSaicErTK490Nw9IpZuhbgPIrQFn3xEycebRa4LO+AW
         krGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXDwHpIMbTM0ssIO2/brA3Zu66QWxLQ6NNnqO+9pVTWXehYQKtBPbwP/DmmtCVa/TNAqZzIGNT4+ep3zFHEK4vNE+D2zbw
X-Gm-Message-State: AOJu0YymiQ+6Of1W7XZitrmIN2689TLJNk62pBWYlTLYbi+til5oGuTj
	5vUWYXD0iYsDTpZKcOl6DF/AN5JSZ9k0NmOrM9i+k75aNT4A/b7f8qbmyvCrWQdzFpL+g84tDij
	7JUn5YAVthw==
X-Google-Smtp-Source: AGHT+IF6PMk6mhWMmUlR5BGceRpGN7hC7vOQyAiuf1w4GSiwkHiIC+oq9J3Fz8Xi3L7cAtAWqEOGmE7DQgI6pw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP
 id w1-20020a056902100100b00dcc79abe522mr87032ybt.11.1708017671961; Thu, 15
 Feb 2024 09:21:11 -0800 (PST)
Date: Thu, 15 Feb 2024 17:21:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215172107.3461054-1-edumazet@google.com>
Subject: [PATCH net 0/2] inet: fix NLM_F_DUMP_INTR logic
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure NLM_F_DUMP_INTR is generated if dev_base_seq and
dev_addr_genid are changed by the same amount.

Eric Dumazet (2):
  ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
  ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid

 net/ipv4/devinet.c  | 21 +++++++++++++++++----
 net/ipv6/addrconf.c | 21 ++++++++++++++++++---
 2 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


