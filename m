Return-Path: <netdev+bounces-79580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068E0879F23
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E8C2833E6
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBC43AAF;
	Tue, 12 Mar 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="zGXkfY7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3603FE46
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284111; cv=none; b=kZHXXEogkEOgSwDl58qDac7sZ3Kt2JUM2gUf9xBrUQRfOLT+EZCwPy39+KgWcLaAhvqp7DNzXFjqCVoiREzk8ApWtl4k2DSP/DDhZmbw6rkhnj019xIWFoQNK1+pCQNuknQ+DYVTpSLUwWdff1pTPl2PmoRwqDRwFozDG0kMpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284111; c=relaxed/simple;
	bh=mab3TgW/hRTopZU2/0VsNLwuHEF/5We932m7lu+Uiac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lyr+fGafTTEVgcnIYCdKvtUvU+0PRpal7eEhvIymoHLJrgvdhjCICz9ZO3MxU+H2HNv4piUByUSkiI6kMULKs1Rf83JC++myHj1nkXBXT7+irL2/R7YDOeVMCG08Pt3hgGnYuLZwlkMhXanxYZX3oDFWRo4DH1DU2aWDawmgCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=zGXkfY7w; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29c16b324ecso1810235a91.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710284109; x=1710888909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMQfhWOplgYjPLGoDX87ljiu23hmeS533ddimQcO6Po=;
        b=zGXkfY7wE+AmqKYB7PU5Eu5Ogzgru71/UJKujgXD/DfE6wQqGFswMNOYDZiqtQKOhd
         e+DqLl4xih70NNh6/mIsZoGDRkyhlQZ8XY7RGW1JGsjLRIadasRwBLAEE9XnWshGZ++7
         2GHGw//MXUgh/Hr5gg9BCjSEhS6Tziqfnfd8GGVuC13yvxRTtNknBg+aQgYr33JaTJ8j
         QZaTg0QhHnbuP5WV1NKNPuPEQGgnQPGosUSgzP3EM3S6wfGlmS7XfaDrbSRMlpPpaVSU
         GfH/9DJJpZIZ/hZXvmDRn91P7dN1fzRMK9oZdO77Jpf0IvekDkmZa2eui1j/YN33uc0y
         ogmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284109; x=1710888909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMQfhWOplgYjPLGoDX87ljiu23hmeS533ddimQcO6Po=;
        b=IxMFd+RZ9IhG1K6l8cM2nxDAxlBGt6M3up3Zw4jzJbOrR4JOKFcSWhCjbUzsVlSmxe
         5X+xVSvn2kummALrp1A+J8Op2CjtJO2yulbS9C1NGpuoSLFBK4Kx4NDQKwfVthH9bNfu
         2XseVcoOTVrkDxVj/0BDSTCNnIFhI9iQ/fOL/rBuhduedvNFRb7sW4nWGVhQXfzyIvzq
         wSkfgUSMblGeT4D6aJGotxM3s+V247Sawmlubm0awuSKdnjQMr06CCdR96+CT0gBS3kC
         pCH1/l3ulDiJVK4veDTV5vfRSDB1f7Be7YcX0pJsoxyGtzb+Nf5P6+260o8RUJJ7KK1k
         c/SQ==
X-Gm-Message-State: AOJu0YyR7vBEou4WtnGVs9FTRDjSdBMNiSur6QaRUrNFe5mapP2ygysr
	egpwbXpi/Z+B+Jy1ru73zn7k88IfGqwckgTdVbOKUBkZoV3zeyYltP9TaSlEm9VSXAiq5gORoHo
	+
X-Google-Smtp-Source: AGHT+IEj5b54g9Jef50ylNe5CagmnL4WcXXK4+cLnt5wRWAIbfrYvcMCD17m46GVPHD3vV2wRN0onw==
X-Received: by 2002:a17:90b:4d90:b0:29c:3af5:e274 with SMTP id oj16-20020a17090b4d9000b0029c3af5e274mr2710948pjb.28.1710284109139;
        Tue, 12 Mar 2024 15:55:09 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a8b0800b0029bb8ebdc23sm98947pjn.37.2024.03.12.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:55:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 4/5] simple: support json output
Date: Tue, 12 Mar 2024 15:53:31 -0700
Message-ID: <20240312225456.87937-5-stephen@networkplumber.org>
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

Last action that never got JSON support.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_simple.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tc/m_simple.c b/tc/m_simple.c
index fe2bca21ae46..6eb60bd8a924 100644
--- a/tc/m_simple.c
+++ b/tc/m_simple.c
@@ -179,9 +179,11 @@ static int print_simple(struct action_util *au, FILE *f, struct rtattr *arg)
 
 	simpdata = RTA_DATA(tb[TCA_DEF_DATA]);
 
-	fprintf(f, "Simple <%s>\n", simpdata);
-	fprintf(f, "\t index %u ref %d bind %d", sel->index,
-		sel->refcnt, sel->bindcnt);
+	print_string(PRINT_ANY, "simple", "Simple <%s>", simpdata);
+	print_nl();
+	print_uint(PRINT_ANY, "index", "\t index %u ", sel->index);
+	print_int(PRINT_ANY, "ref", "ref %d ", sel->refcnt);
+	print_int(PRINT_ANY, "bind","bind %d", sel->bindcnt);
 
 	if (show_stats) {
 		if (tb[TCA_DEF_TM]) {
-- 
2.43.0


