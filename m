Return-Path: <netdev+bounces-103789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4209097F5
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 13:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C49BB21981
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0626374F1;
	Sat, 15 Jun 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBvQnjhp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB13C28
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718451152; cv=none; b=oV1+dK6oMZ0PQIafSjPfyEq4z/ID/svO43esXgtQGWU27kBnu8eoE6OdG4vDVCZHs63hUK8wLHZ63h6Pja1tyZ10tAR+x34AiYMlETAfYjDIF/gHyfdv7nE9Hp1bP3mGwOJ0Nbhe98kgV3iCsZzSwljsoK8Fc878bdH8MMpo9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718451152; c=relaxed/simple;
	bh=ZIQw9BrTXL/1TEAVyi8BFHqs2IiEAx/lShMaOhW7Lnk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RfGC0pRNZzDnNg37Y9mb8V3fgwnInd5+j2HTVFVFpcfgDXPCYyTGY503MYEmajzSaEFFKqJSq/tAAWIO4VJ5YdXvUxRS11iZygnQWYTeH9g6paXsoODpftbf0P73BUNA0JAjcgueZzcK8FQbqKsE7u/VGgC9GUmP8oMg4qJpAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBvQnjhp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627f43bec13so52040877b3.0
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718451150; x=1719055950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkPFO4DspVYJP9hXZj780mJn9jxD1kyS+gntxG+lanA=;
        b=BBvQnjhp4DLPN93KU5blwF14WHPkamfGTA87KGsH4tNutdqqoUQojbuPbPocmcPl02
         idU9qlSz06c14dKVX3cPYVgpqhmhacuIyJETcE8FtFL8AqrsijyWTCcmCW3hRUvOKtxr
         Nn9VHrJdrZwQLHLm+3We8iWEISnm3XnUgooTrdn/eln7RcQQkR52Hx3MRS6oyaRWLAUY
         gKhcIvWRSAx/RM+AERFWFulU09iCPh5ez/qwLdgMqu+FNtNXOZ6LckirNwisbOq2sLSV
         ZJj62Sia16oN8wDF3wZx1+UI/Ag8kmSb0b4j7zeMuVz41csqev7a+AaDi92oKijPwyIs
         Ro5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718451150; x=1719055950;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkPFO4DspVYJP9hXZj780mJn9jxD1kyS+gntxG+lanA=;
        b=V/hxmx1MSICq09UwKBdSNW5cgSDswytDzzDFK+nVs1lx/5Ypxn3+CHKLYAY03AC+PI
         DaMOJJImRXTMJ05Z70Lls5cZSRwkLQGKLFwfLgTEoMpgabUOTdmNHkVOJSTANGZf9ZYo
         LOBYO6Sv1NouZZvnmlLekFpODHHYPB+1DQAMZtP5sRn9UYLEwYzccHpRmY+mv3dbD4Lo
         mBYf9o2jyI5VSvvbjZj2GRuFeamRiVlr/VQTxoc8qDSygVptzIMKCAGH7IlKME+DQzWO
         kokkbCCZcBo0JKkA1hrxmjJAZMaeyH4HOO5lk4ocMbWWhl1grEkRFELPBSYYL5BnQaJl
         qBNw==
X-Gm-Message-State: AOJu0YwC7sFtTnFpUXLwSxr62k91cZFtZpSQLS2o5KJ7V7XPmwATb9vN
	ngJzqt5WhU/eFy9tL/sa1olczp2Drbd6k+6Ki6hS7QcohpDHCCrTRfDOSEJ+01A1dkoJvQ==
X-Google-Smtp-Source: AGHT+IHWJtIHul3Rb31JKNxnaMw8ySU+Tk7gW7pRvwEy3mLKltAbeyNne5VSCMNBgPiDVCoV0ZrfOPY4
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:356:abd4:799f:1ac0])
 (user=maze job=sendgmr) by 2002:a25:6b49:0:b0:dff:348f:25d7 with SMTP id
 3f1490d57ef6-dff348f285bmr100744276.6.1718451150202; Sat, 15 Jun 2024
 04:32:30 -0700 (PDT)
Date: Sat, 15 Jun 2024 04:32:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240615113224.4141608-1-maze@google.com>
Subject: [PATCH net v2] neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GETNEIGH
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

without this Android's net test, available at:
  https://cs.android.com/android/platform/superproject/main/+/main:kernel/t=
ests/net/test/
run via:
  /...aosp-tests.../net/test/run_net_test.sh --builder neighbour_test.py
fails with:
  TypeError: NLMsgHdr requires a bytes object of length 16, got 4

Fixes: 7e4975f7e7fb ("neighbour: fix neigh_dump_info() return value")
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 45fd88405b6b..e1d12c6ac5b6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3892,7 +3892,7 @@ static int __init neigh_init(void)
 	rtnl_register(PF_UNSPEC, RTM_NEWNEIGH, neigh_add, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_DELNEIGH, neigh_delete, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info,
-		      RTNL_FLAG_DUMP_UNLOCKED);
+		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
=20
 	rtnl_register(PF_UNSPEC, RTM_GETNEIGHTBL, NULL, neightbl_dump_info,
 		      0);
--=20
2.45.2.627.g7a2c4fd464-goog


