Return-Path: <netdev+bounces-231251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6ABF6A3C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E791A353CE7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D7E337BA0;
	Tue, 21 Oct 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWNjZXq8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E5337B9A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051716; cv=none; b=bu3XC+vsmG9s5NuBGD36SEaaUWZKBygEeHLiTsvjn3PemAfUuoXlaKyPIhUcJ5C283v2n4RXvo5TzSU8ccD1WiwCVJfFXP1jUiIZ9skrwPq/MlL+3Thc0dydcXwnz/8vHz2QBQ1gIl2iTe0pwJIoW8m36vDk8hJu4rwWED4AZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051716; c=relaxed/simple;
	bh=/6e4Ptuqnezl7IG4EEoTOuL0lZT0IuoppTJCNRC7C4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aDiEOKtjikNcpmZ4E7iNc2pqbDXBRGTvRUlU3z0BEdmZxjhffBZF5hFdu5AePoXLVg+R7FoGwVNANjOgf689mycAvzLZDiB/XUNSOyaz7rj26Fv3S1nmcnyLzcXEqASkMFLoAF5rocnKicp1vXbjULPHBLKs74W79Xi4+j//gkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWNjZXq8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-579363a4602so5611958e87.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761051712; x=1761656512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyY2Eyt9nzPKJbJW/4VOy5YSdTPy2ZRF5S/Kzk7Ode8=;
        b=kWNjZXq80o/qoZVI+9DD+JK1Oet5mMlhG9MQTquN/CWrh42hu7s5/uZQlXgMh1tznv
         0P+ObtgxnXWVARYezIInwqP0Zw2wOf1wnHux69aTuSVHZuiJHgf91wwnCLBAJN50gVPy
         FbyXgd2E8iZFwJleCe/C8r5pgnQE6XiCK5dA9vaAG3n54MvCJj5M2NcgyWCLAXb3Uw1a
         1ZPPel6rCtDKrMrpvyAfJNS1ZuFS5E4UIrMPyRNatK0dS0fNiVUrnAh6FiKD0j7buKtW
         /KDgltGDwivQNyKhGv7TEsbI/ccSMF84JagS2h/nOAh1aAv2otJqAMZajQHvLWFVZDDR
         3yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051712; x=1761656512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyY2Eyt9nzPKJbJW/4VOy5YSdTPy2ZRF5S/Kzk7Ode8=;
        b=DHjSIakDFgbIZ6Sp9TXxg5pYN1x44MqWx86MJrVlGsBlJAwNSxJboKiJRgzVjxFr4m
         teWYumCLqFgYExpu5ku+o7dDh0RZXhqqKEsbX+wXpichFiL3YqOI1xXz0mmQWUMHDvDP
         Xq/QyLA/1HF1LCg+g3V1oEoXgG6K1Wt0C9JCpGCDBmkEkxn06Z3Qe7l2opIia+3SR59e
         /fKZt0DEWuk/xRGrA8fQBCsJaSdmKPNKWvmMYB7ySZ2GxtzzFJAfGIWhb/k9j/4R4IRm
         zCyyQxHrHskYhEgSF+u9MHage0h/uogctxomCc8b9SmoIejecIZwAxlQ8ODPBLe+Nvg9
         OMng==
X-Forwarded-Encrypted: i=1; AJvYcCX4BcsDNKka+ucVxfFWuDAkFyakSZQ1BR0EaADt9DmD8xKPSURix/uL+ssHKprDyk/JP+NUndI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnxzSIJftAx1+Y//Vez3nLqDA+yPvFMdiHo3TouEpIuIve5P8f
	He6dH2vQP9C4DDi8w7Hi5x/ZWrcsIrw/AxCgibhqhhp1nSPFVHTU7qEe
X-Gm-Gg: ASbGncvL/v60Dl3/e0qplkcJk15SzQV4NAynMInE+CJ4szG9GJZOf4+kD03Y2dw91QP
	Ax/kefRYbHw7za3IdpPZfeUpEtZZm1AoS6gX4lcAyWr1t5K/09EQbxR2UP5fAX4+m+Fz/8VXqCA
	wS7FIB2CO98bycKRuncHt+Mxb6KLlMUhGsT2VlOAGfXTDr7ZTrDtvheJSx6aKhWCAnfde+XcJth
	a6TGNGuXtKWAJfskh8EpUWdvqwQ9S7t/YPD5JrQ07Zr5OO3o6KkLwmqn95pqcl4CTbJVDAPsGNo
	ysx7kDp5YapKXV/1XBM/w7S0MJ6HcsnMMRJZesCXewKDy32gH1nhKY6+ObhuXeer3i3NNG3+sj8
	d4Nn24uoFMrcQnF4E9gWc4rMoFnMRolluc1HaZRbrmQl/RxJQBnYVsJ5U4xOV2iU7xQzSjZCkn5
	uZbLahg5w5I+zynjHyO+EipkQr8Ew=
X-Google-Smtp-Source: AGHT+IGS9wuVDvvevxvg8K71lROg6rYpbM4tkxXD2Kfjl5l0kw3W7LqaDVVdOT+MS4gADMX6EMuH1A==
X-Received: by 2002:a05:6512:e8b:b0:57c:2474:372b with SMTP id 2adb3069b0e04-591d8584a95mr5461765e87.49.1761051711762;
        Tue, 21 Oct 2025 06:01:51 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1b37dsm3624098e87.87.2025.10.21.06.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:01:50 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 net] sctp: avoid NULL dereference when chunk data buffer is missing
Date: Tue, 21 Oct 2025 16:00:36 +0300
Message-Id: <20251021130034.6333-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chunk->skb pointer is dereferenced in the if-block where it's supposed
to be NULL only.

chunk->skb can only be NULL if chunk->head_skb is not. Check for frag_list
instead and do it just before replacing chunk->skb. We're sure that
otherwise chunk->skb is non-NULL because of outer if() condition.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 90017accff61 ("sctp: Add GSO support")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---

v2 - change the condition in if-block and update
its location for preventing potential memory leak
per Marcelo Ricardo Leitner's suggestion.

link to v1: https://lore.kernel.org/lkml/20251015184510.6547-1-bigalex934@gmail.com/

 net/sctp/inqueue.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..f5a7d5a38755 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -169,13 +169,14 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				chunk->head_skb = chunk->skb;
 
 			/* skbs with "cover letter" */
-			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
+			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len) {
+				if (WARN_ON(!skb_shinfo(chunk->skb)->frag_list)) {
+					__SCTP_INC_STATS(dev_net(chunk->skb->dev),
+							 SCTP_MIB_IN_PKT_DISCARDS);
+					sctp_chunk_free(chunk);
+					goto next_chunk;
+				}
 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
-
-			if (WARN_ON(!chunk->skb)) {
-				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
-				sctp_chunk_free(chunk);
-				goto next_chunk;
 			}
 		}
 
-- 
2.34.1


