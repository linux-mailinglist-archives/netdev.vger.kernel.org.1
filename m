Return-Path: <netdev+bounces-109933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146D592A503
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457ED1C212D3
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6745613FD84;
	Mon,  8 Jul 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xgZ0EFau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7761411D7
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449973; cv=none; b=Amrx184Nb/ZF1lC8FoNMyWLO+JDTjoB8ygV2RXKYOkT0xWXIylyKbMUbIBfvvhHWNcgJYXrhL4e9C3jGAKTtQWSddL1Mbef6V5/4JJ6y2Z/0zeUCPowyxg1dColLsLfTKxMSi/VA0bis45uppRodVScn6zRvGDWiMLKpZvYiFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449973; c=relaxed/simple;
	bh=vxyvFviWFMzdQXkmA/FIp3YzReSch2WXezG5G5z+UXc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YbmPf5x20ehFsMZ2nWj4dlvJoQ3vlEcEU9aS092wX2ObEFpd/r3FCig5ynVmnpXO1k1dUlLmgZ9Kk786fhRimKx7artywmTF/QueucG4ErkrPnIqp+U4J9o+A4Vn9mRxoSyoKXTE2RE62i0jRdr0Qi7cvML+EAQf5pu1vLfV7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xgZ0EFau; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-703626a0704so1005985a34.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720449971; x=1721054771; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjwJEbtyvDrUjV2HV+RIgx9GLehaO/ifBmLUE3mP+44=;
        b=xgZ0EFauDk5iDoIr/NYfW/VNRXYoOjkZOoFFRV2J096U7J+TnagGGFzhKu/0RihNyE
         5pKz6quKNQv9mzXXmGvCkCfSyXJHJP2USx+3U5G4buJbf+dDC0ohUv4az216S0g8AigM
         alFLRlyJv7rn+jG5CMQBdxlytgqnPb673r+xcNlLif84OM1wGSCnIvFw0NNDM+SDRqPB
         yiCrFqscnk+kWhSkctStZS5aFXQlnSi6r2j/H8RwsDEwEv4oyweBGP2vonbGVxpjhdPI
         qGiSArKBEVwoGD5H89cYFh9XSKxXiYblchOn1DKwubJy9YUFxvtg6OOtEsO+mjE9GYPd
         33iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449971; x=1721054771;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjwJEbtyvDrUjV2HV+RIgx9GLehaO/ifBmLUE3mP+44=;
        b=txyxrtU1uKG6Fl5THRlOKD5XPE56LIFhq+LFrtOqzdMY/9UvlewAe+AyO97uFXyITw
         p8pvpj2BmZ2Z69fEAAo7ylyneSp2MS6IWDbYAshis/rSvYK4Z9hPX/0x5341kx51woKK
         A0hod7KrFbsURCYdpyVZxU/sGsNgQR+1jaGSX3amm11QTVm2q2gCuwfST8XSZ7ud6Fbd
         13cUXEMmN31qz64FSoar/srmirAkd56wQYnsuq9jSOQlsfl/+kt0edLKXirL953RAGBb
         wAgMx8nAdHcUwg17VxoBKUb6tEJ3qW88ua1BjHJ03GpCQIjJg8oyyiVq0xWjMo+ix2Pz
         MbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFKuG/3WJAnzARS9kyTAttwT5wBl7cQWiFBe0xqsVQLD2oujeFYFmfBDDCHwMTCq6F25FiFG/n+XGKCJ3WEFG1+BQ39yJt
X-Gm-Message-State: AOJu0YxMto5Tre6y6CdNhhC/T/n62on8eoVaTgnNCRYkvgXTJ+WsPOv0
	6MgD379LxcHwogaOZSAeToXguK7RDCQAMcn1KAy8WNLz6svlIXyMwHqwpSbpYg==
X-Google-Smtp-Source: AGHT+IGMCL1iRgwqXTdZTTit88ovRe9lrZHPjnWJmD37C9x+zcdkRU7GOewgdpnAIWilaxW6DcEicg==
X-Received: by 2002:a9d:7f0d:0:b0:703:668f:321c with SMTP id 46e09a7af769-703668f3360mr6007303a34.20.1720449970807;
        Mon, 08 Jul 2024 07:46:10 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f88ef8sm16133a34.46.2024.07.08.07.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:46:10 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:46:00 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sagi Grimberg <sagi@grimberg.me>
cc: Hugh Dickins <hughd@google.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: fix rc7's __skb_datagram_iter()
In-Reply-To: <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me>
Message-ID: <fef352e8-b89a-da51-f8ce-04bc39ee6481@google.com>
References: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com> <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

X would not start in my old 32-bit partition (and the "n"-handling looks
just as wrong on 64-bit, but for whatever reason did not show up there):
"n" must be accumulated over all pages before it's added to "offset" and
compared with "copy", immediately after the skb_frag_foreach_page() loop.

Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any context")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: moved the "n = 0" down, per Sagi: no functional change.

 net/core/datagram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index e9ba4c7b449d..e72dd78471a6 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -423,11 +423,12 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			if (copy > len)
 				copy = len;
 
+			n = 0;
 			skb_frag_foreach_page(frag,
 					      skb_frag_off(frag) + offset - start,
 					      copy, p, p_off, p_len, copied) {
 				vaddr = kmap_local_page(p);
-				n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+				n += INDIRECT_CALL_1(cb, simple_copy_to_iter,
 					vaddr + p_off, p_len, data, to);
 				kunmap_local(vaddr);
 			}
-- 
2.35.3

