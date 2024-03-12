Return-Path: <netdev+bounces-79578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80494879F21
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27651C21E4A
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A340BE1;
	Tue, 12 Mar 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZpAaUSoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571602E41A
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284110; cv=none; b=AZ3t6clchcFg2iR+XkNCShMpyGEPra7Kk/dMidDPcoTo569cogQCQIC7GIBQR9i/wTuAHZIyH77TTdAIOmpX/sxKn1lIsYqZfI+LRZ95lwpvXiRbkehQl1mge5xzUq9/dliaGvfhpNkhIaMHpayshk9gD19RhxURHtLjc/fh2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284110; c=relaxed/simple;
	bh=39RRfqgMLeZYg0ZW+kNWd5tYfFckssYC0rGgnCr6lsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mur2ljJbk5wfQIHwo0o2vZ8mKnzLrMHSqQpA4FSn0wXsvwGf8IoZAHUp1/uHujYVXFYLHhuJ29WhEtSHjPiqvSErZTsoLWhixQ//FPX1yI1skmrFnEpZ+Xzu9vguoiCbJ+bBZH2/BOxDg/+RK5mnJnThjMUy+hneDdeh9q2DFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ZpAaUSoX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3100005a12.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710284107; x=1710888907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loW8beBfYpw+JBNitxFB4W2XmqM5hYVgSxYhpCG5shA=;
        b=ZpAaUSoXXB7XJ/6WflswmZTw4gjv5xGuZZcnTi66kW0Dh8dMI8xwJI/gS4jaT0GrNG
         b2zxGx9YWIUB+loLTVVNStUInbH/HawtdrMVO601v7W7kRXd5S/+K2ESLv6P2XchFX5j
         cEpOG/F08XZJPiYJThUofqGGcnXRzaCGw6C0TnEIO+WOsiHMLvUfl4UfL5KfbXvleuGA
         jb29/26S8reMmS3IvMmYg7Yu+ER/poyB5XE0xgL05a+Aisw/lpJNBw1Dgc5FCrM4HTNH
         fDndKhCjCkc8E/X/rMcwSAKxUZLgrNYZVo8B1Uzkbi+zNl91tfJ4G7sUs6UiYt1alzib
         4jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284107; x=1710888907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loW8beBfYpw+JBNitxFB4W2XmqM5hYVgSxYhpCG5shA=;
        b=hjzGO1ryEB59h2KD4grnEeL028U8VSj5rM2wOnuRpw7z53AY2NnJ1ANRm6oSoG01Ig
         Ba3N/cw3/BdxDgqCppCcp3f20rzYqxjd0fIlqg/i9leCFEe2q2W6XehbcS87r/0Y3p08
         c6okm5xqS4Ppuks2e7raPkUodQqZzPl9deLJZ4T/neQbzhCM7UNmsqMltxfZbtn6L9rV
         9zEDiPab/eDuhk+wrFY3/Ml/Zdrw3+xP7vGQnvEXWxLACLdPgZy5ggA3ROk+pR+WAhKV
         rkWNbzU5PMh68pnGPNc7Mb+TyKTO/rOHS3mTfzYxIaTTWPMwvuiul5ehTm8Cm4dW9BQt
         bT9A==
X-Gm-Message-State: AOJu0YzZ8a8OAFsA8EEsbrGaT1d1Tr5oNdHd93L8LL2rfWc8Kx+K8259
	KeGnrdBtms5BqdlazYJOGU5FUybT9WjWO3HCJNBdI6uYU7rgAmujtnA33H6EcxcTAjJPvKlsKoh
	Z
X-Google-Smtp-Source: AGHT+IFZryQu9zdnC3myVX8W3DxCksm+844PkPplNuPc+cZpckGH0f0nHE2WFTZv3/yd1u8P/bK0nA==
X-Received: by 2002:a17:90a:b392:b0:29b:22f9:c8e6 with SMTP id e18-20020a17090ab39200b0029b22f9c8e6mr7642778pjr.19.1710284107703;
        Tue, 12 Mar 2024 15:55:07 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a8b0800b0029bb8ebdc23sm98947pjn.37.2024.03.12.15.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:55:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/5] pedit: log errors to stderr
Date: Tue, 12 Mar 2024 15:53:29 -0700
Message-ID: <20240312225456.87937-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312225456.87937-1-stephen@networkplumber.org>
References: <20240312225456.87937-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The errors should bo to stderr, not to stdout.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_pedit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tc/m_pedit.c b/tc/m_pedit.c
index 32f03415d61c..f954221da393 100644
--- a/tc/m_pedit.c
+++ b/tc/m_pedit.c
@@ -771,20 +771,20 @@ static int print_pedit(struct action_util *au, FILE *f, struct rtattr *arg)
 		sel = RTA_DATA(tb[TCA_PEDIT_PARMS_EX]);
 
 		if (!tb[TCA_PEDIT_KEYS_EX]) {
-			fprintf(f, "Netlink error\n");
+			fprintf(stderr, "Netlink error\n");
 			return -1;
 		}
 
 		keys_ex = calloc(sel->nkeys, sizeof(*keys_ex));
 		if (!keys_ex) {
-			fprintf(f, "Out of memory\n");
+			fprintf(stderr, "Out of memory\n");
 			return -1;
 		}
 
 		err = pedit_keys_ex_getattr(tb[TCA_PEDIT_KEYS_EX], keys_ex,
 					    sel->nkeys);
 		if (err) {
-			fprintf(f, "Netlink error\n");
+			fprintf(stderr, "Netlink error\n");
 
 			free(keys_ex);
 			return -1;
-- 
2.43.0


