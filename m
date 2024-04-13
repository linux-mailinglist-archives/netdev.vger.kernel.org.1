Return-Path: <netdev+bounces-87643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C28A3F51
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 00:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD6D1C20BD4
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 22:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFB58106;
	Sat, 13 Apr 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="akHAcN9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36225732E
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045935; cv=none; b=tWzjmJ2BkqKJBKOfPnXHymT25DAYTPpkUi7FSQrivslrl/dfoB+iR6oQXcIsjeu6igxGChuVj/aMrw6d+5MJWEeiHX+Kd/mRuPUlXLT/NS9WSLpgCb1euflTtV2idxL2VwgUln9dTGDbS8FOBP+pqY25v2LaRpDiTdf48dkrI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045935; c=relaxed/simple;
	bh=sSLSq+Dg/7uZyw/218CptWM0h5jkmmvgwD6P0Dthcg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czFEgZ0b6S3oHmeiCsK7Fb+UlBODJmSmJ9ay3ZuuSqdSE/5hPV8Tp5LlxxfEkhLJMJ2wLq+UDPpnt/WYFR2Vsf3A46r3lgsCFi5Eaj0hazb27prhmRImzztypdjcmD4NaV0WJLhPrzoAGPPX83neJLKBN8E6N/fwgE1TJo4KU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=akHAcN9n; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa27dba8a1so1358974eaf.0
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713045933; x=1713650733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0bov/MreT9q7kvyM9v8P5W49GmdWTipQ6PC8aRlAhk=;
        b=akHAcN9nPv0pkAs4bFmaZAC3iSUycpDmbM8CyeojFyWxEkPwNQiDsRjxBcs4KbDyrm
         RqHgPYKSqfe2SZQbgdQbzY7YEUNrp2wGwV2ILVuss6YibjzIAZ8ceZ73RUzuAsDtFDt/
         fLKWL0WOkg00A2yX+WwpUEQO5Dn6OwWEdjouBkzuRWgdL1ZO/CY250rY52ewPAVJpHYw
         MqUZsJC6GXYR53rqNqVWwOxCGM0Xx2VzGDEOAm2DAvANZsZhWqn0tdDAVLLiqkbSuplf
         9yYlL0cAokh5ILj+wDN746DGy1uEql9jbkWr8gS8bMKOIlKURwHV2gDok82Gza0TMfXu
         UUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045933; x=1713650733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0bov/MreT9q7kvyM9v8P5W49GmdWTipQ6PC8aRlAhk=;
        b=Ejt2nlj8MQPKq4Yt16cwhmVmLET3jlnT8TymKqDg9kFcMG9hIyVna/N5piTA0IpxzO
         lbaoSSDEdocgZ7ZympPohnJMInFiPDJtWbNu0Ng+LKmgwNi94VdEK09viiPZbBPbvdqa
         A3B6mHzYnoeCuOZqs2q636hN1Z7iirf7L/29GwiT9mlOfXE/nSN9Q7EJfHhhn63DMcfj
         EM3Rhu8KZX6I7WMtmItH0VXUEnvemlR0aXxtNvFFJ/PhxNLsY0kXK1FJk0na8/kkCKC7
         y2adUXtL1r2dH6Y/rN+PmwMcQfyN+qImDvKiXRLQI6MihEODB1NbZERkBfcqYF7N3m7c
         Fq9w==
X-Gm-Message-State: AOJu0YxaKWpPduVwWRT0Av4O7+hhS5C9FkaYhWZgj0b8Rnmm2NkH8KDH
	d8fX6M0ySN00t003Lf+iIp49mVQEdu0MQlysr3OxyoGd5D5WX4CeCdKpTJ6+ozt3EcW6hlHF2/n
	d
X-Google-Smtp-Source: AGHT+IHjTD4xXi5fV1k+1Bgh0atU71gXawbhSrYDW3mzNOMNE1nMCnmWfZRxpd65PZ5fSYmDWmf1uw==
X-Received: by 2002:a05:6359:4902:b0:183:676f:c751 with SMTP id mt2-20020a056359490200b00183676fc751mr9292403rwb.27.1713045932602;
        Sat, 13 Apr 2024 15:05:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm5008082plg.138.2024.04.13.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:05:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 7/7] tc/police: remove unused prototype police_print_xstats
Date: Sat, 13 Apr 2024 15:04:08 -0700
Message-ID: <20240413220516.7235-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240413220516.7235-1-stephen@networkplumber.org>
References: <20240413220516.7235-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/tc_util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tc/tc_util.h b/tc/tc_util.h
index a1137bc2..86200f1e 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -109,7 +109,6 @@ void parse_action_control_dflt(int *argc_p, char ***argv_p,
 int parse_action_control_slash(int *argc_p, char ***argv_p,
 			       int *result1_p, int *result2_p, bool allow_num);
 void print_action_control(const char *prefix, int action, const char *suffix);
-int police_print_xstats(struct action_util *a, FILE *f, struct rtattr *tb);
 int tc_print_action(const struct rtattr *tb);
 int parse_action(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n);
 void print_tm(const struct tcf_t *tm);
-- 
2.43.0


