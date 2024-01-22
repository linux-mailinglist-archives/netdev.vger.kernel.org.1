Return-Path: <netdev+bounces-64852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6128374D6
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1A31F28077
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA10347F51;
	Mon, 22 Jan 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LRAz0WtU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464A47A6D
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957585; cv=none; b=Wiqr8Vp2POlQHDhBWdRGvjzxvi3Hd4ZSxBCMoQX9VS2wRr5kJkhzMzoF/+KzU9Bkp+BdysSHUHhStlYk39utmbMtMvPMfx4i1N/z3nd7Dxd4RMbq4Zn58UJJd5wIkawVmzDvcm+lJ7zHrJpM5EaEOLzpX9JKllmkkhbMDHMoB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957585; c=relaxed/simple;
	bh=aCs6xZ7io6k23xvYEINaZLZhsHKRJayWapBNQtC1sQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fy4pFwawy9iXayTiCKV+MZE27yZ97e1PUB85zH8wp0lK/X461ivxIKd8oaBxC/nW/XTBLhrKw5/vDds1pajfPiDZ10nk0KxKFEgRoOMPjwehGg0FOd1K7jLGGdkiBu08msbjMw7wUXSSK8bKTP4AzuHDjDlWeYNB90MtpGzfWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LRAz0WtU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dbd2e435d9so1359339b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705957583; x=1706562383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WznYS3ekaQLBbh1QxiBqv2BassJWeck7jrnHfEWLJsA=;
        b=LRAz0WtUld6/vRCxQzlCNUbxBEP3qXsB/QSx8qacl5MgHdW06vHmpIJlpMNj0DuDal
         h/8wPhW7LHOWxWns878GQda41jozIOc9VPzB3zySrOjoOtHhg4WbBmbrg/6Ug1obiAc7
         fMtR32d1wj0m7hOO5WL9m0WWiPNTdvkiTohzrDqGrO1b3vVzc25sPYxCHjK2VVOAjGry
         7iZsFQ4oHRe0clKUr1cEjFk5zeJse1t4ozT8DDwTVUhwhUuc7/+B9iGkhFf038XzWY9D
         QFoXLR+POPKnVCuX6bKgMResj2z7JTnQsFDjhVmco9Zv+GnvwKcJnILCPPhHraKMvWvS
         lJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705957583; x=1706562383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WznYS3ekaQLBbh1QxiBqv2BassJWeck7jrnHfEWLJsA=;
        b=c39j5HNJ2FO42fOs5ncdouysBe/eiU4cVf2f7te/WhbgFY+wI/vsc0+/tvuVhjDrr3
         IpiXg0vOLo9XtHJujpYo8q2BZiA/i0XSbObm/O91TW86rU6Q8Xsqr3fojELrL7zGGxGf
         42v5Q0/yNUCwXiX7ULlYbi9yNv2xLNlo3Nka2FZMcwj0LsVT0GPI3FvNcFFmCIm6ePvZ
         by2pPqQ8FhMxyIDSg4ljA/jxBWJqXFSeuXEGn88kEej3OSjimJoJrCKtbfXXZtdAjWSX
         5tgIFH06kMuQS8C6f2omnPQCe84YMnokjNK107LNfC80sFBkhhpZ7q8DlhP6264eFFpm
         bs4w==
X-Gm-Message-State: AOJu0YwoVUKInoz+jHLot5sDrooj/zjd82cQEQCSccPySyzeJ8iLIa0M
	XMKgyLyCOLtjje40+8YEAvihNssT+31unvo4scZPWO+ry9Cran4CLKJB1cPp6yQEbYwa4bntPNG
	Yjw==
X-Google-Smtp-Source: AGHT+IFOZrPMCXkB6IsNkOo/v+aQlU7WCYqj2ZSFL5ecML6TWl0NoAHDy+ahR76X0YOO0E/1dIzRfw==
X-Received: by 2002:a05:6a20:43a1:b0:19a:5ced:3c22 with SMTP id i33-20020a056a2043a100b0019a5ced3c22mr2601009pzl.21.1705957583487;
        Mon, 22 Jan 2024 13:06:23 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id r11-20020a056a00216b00b006dbce4a2136sm4559306pff.142.2024.01.22.13.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:06:23 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH iproute2 1/2] color: use empty format string instead of NULL in vfprintf
Date: Mon, 22 Jan 2024 18:05:45 -0300
Message-Id: <20240122210546.3423784-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122210546.3423784-1-pctammela@mojatatu.com>
References: <20240122210546.3423784-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NULL is passed in the format string when nothing is to be printed.
This is commonly done in the print_bool function when a flag is false.
Glibc seems to handle this case nicely but for musl it will cause a
segmentation fault.

The following is an example of one crash in musl based systems/containers:
   tc qdisc add dev dummy0 handle 1: root choke limit 1000 bandwidth 10000
   tc qdisc replace dev dummy0 handle 1: root choke limit 1000 bandwidth 10000 min 100
   tc qdisc show dev dummy0

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 lib/color.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/color.c b/lib/color.c
index 59976847..027e1703 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -143,7 +143,7 @@ int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...)
 	va_start(args, fmt);
 
 	if (!color_is_enabled || attr == COLOR_NONE) {
-		ret = vfprintf(fp, fmt, args);
+		ret = vfprintf(fp, fmt ?: "", args);
 		goto end;
 	}
 
-- 
2.40.1


