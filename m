Return-Path: <netdev+bounces-181494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC8DA852EE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5AB3B56E8
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E227CB35;
	Fri, 11 Apr 2025 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kR1ygnB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288766FB9;
	Fri, 11 Apr 2025 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744348360; cv=none; b=W8sCpVpPVshpOytJv/wzBs7eE0nZAYm74TRdBzQRP78SXL+pXzfScFgSxxUkJIGdGnfuINpBPB1Hn5U76tfmtoKhOkKUWB/7ywtjleuFYNQgWJri49Cl+4cJcn2/HixS5bRcVnO2U5tc3bUwDkDrLT833Te6p+rF0rceMpKFHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744348360; c=relaxed/simple;
	bh=vo8r/Ou3ozFqcXy6Mh3RzCaqty4iUiS/E4l4z6f5pK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFxp9BlfPeISXssjddvIoZPTumvmQzXdtmOw8/88gO5YEC4oyRWwbc2w6Yj/xsCwn6PDcQawGWX0GbEJPwgoB71aMdCR22EG/dVDBNxl29osUF4u8QpgiUvyCK7Plw063vj5R6iUwJDino/pUWuTpna5YbU0rRuyBUa7j17rJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kR1ygnB+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301c4850194so1282292a91.2;
        Thu, 10 Apr 2025 22:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744348358; x=1744953158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo8r/Ou3ozFqcXy6Mh3RzCaqty4iUiS/E4l4z6f5pK8=;
        b=kR1ygnB+vqkoWxmWybcFlg/fldyAmHjx/FQRS25m/z4+42/6tRvvAJ0U/S7W4J9m0O
         CRI6aiVTg4s3C158Sg2Iu8lCcQFY9x1RaCI6wAD2L2IxSw6ZrVep9K3FUxKS0HE/nWs7
         cgl+sXGAQDDukA66pXwbvVRTL2Trz1zdJa6Jb5hOzTtBhIbzRIYv0KCNesNNxfkhusd0
         ul1+25auFFMuc3M9J8NU1FBP/jIj1vsyWw5foDlHZ31sVChyPlXKG/XWXMuNJIw/xE0H
         73sIILw21CH3uI74lxeu9cBoSZdokAELBOxr9+nb9pfWExGQYHgc90LT6VkFdRPUzdUL
         79Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744348358; x=1744953158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo8r/Ou3ozFqcXy6Mh3RzCaqty4iUiS/E4l4z6f5pK8=;
        b=e2QiRk9n8fg2CJjDu2mThUNBXFvO2PkqKQ8T+v/8lNBJIQr61Zttx6kPqQMYwh2aQZ
         OoKvGDgzx4w/vFkNrm+ZHa8Me0VdGWvS4b6B5kHT54qD9k66HTnthzimR8ZgLseSRZeo
         qGYJSvwBq8YUvcSK1WfJ8dUHokuNFNXsr6YravBZmmTebTrEbXOW7wWX4jxlXI8gvYiz
         wmtNFpXBGvgoVHiPpZsdnxyjWrV2gfP2ckvx98HEYgieSuFV7ichmqb+yy5TRRSfrcwB
         moUOJdUtWHC4wL2j3/i5r8RH3XEnFwSW0+ROhqpK5qqjEAxuaE/JCkY6vTA8Dll+q7kR
         Ty2w==
X-Forwarded-Encrypted: i=1; AJvYcCUc2ShjMPYZTleJKcFhh3XxIBOX6QQaBI8vgs9/C/5szCptKxz6z1aPqrxEq7SO3tHgbUMoVux4TkJrx9I=@vger.kernel.org, AJvYcCXWR8x+4rbCQWMDXMFHwqD9Nl3E5CpoiFJ6d7MCfVnbCHoDez7O5eMNPYtFIxFe06HC1o57yoLd@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFNp3QCsjZR6fEkpQFr2M1NshwBuvbS3EhAvv64xBpNN7njg8
	Dbuzalo+eJPBoj+BbI6mXTc5LEkVLS+e6kSP3lNNkEmxw708DwF8
X-Gm-Gg: ASbGncu2G4MFeXN4vEHjwnFTpXc5NlYxQV7G/o2zFxDq9jIsRiLVUMDj048rL4NjhZd
	es5rNQDlVl5HyxSyp4VAfrbQO8Cz7L74CSLEjjMA/BCdOzQ03cL+ydLIqfZWDpS5Rtf7BmbKbIB
	UvNRhO7OLPjbC0HR/C+yiLRLaJB+/kH/i7ll9xxuR58/GchdMlVovbGeQBESpgL/IWEY6/FGgV5
	uwjxwvOP4TZGwVhrlPP71ls6LgwQA90M9rh2UVYEVUEOpTIjM4jJ+mnTWLCGfMp3nMiPp+Nqlz+
	sDLWmhxC1JaFajhAfy9WSYFSbJ4RvSA2hlwArpBAmuSLFxsoDW+fK6RsmCg=
X-Google-Smtp-Source: AGHT+IGPuha9IEWXXQhYvGYvPGaGwx9cZ9ISMGBmaKa3UnwNPkt4D4uZlG6jSPVIF2+OYnHf7r2QFw==
X-Received: by 2002:a17:90b:380d:b0:2fe:9581:fbea with SMTP id 98e67ed59e1d1-308237c0d78mr2210311a91.29.1744348358151;
        Thu, 10 Apr 2025 22:12:38 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:4fe1:c798:5bf3:ef7a:ab5:388f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df082327sm4534805a91.15.2025.04.10.22.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 22:12:37 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: tung.quang.nguyen@est.tech
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jmaloy@redhat.com,
	kevinpaul468@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tipc-discussion@lists.sourceforge.net
Subject: replacement of strncpy in ticp_node_get_linkname()
Date: Fri, 11 Apr 2025 10:42:21 +0530
Message-Id: <20250411051221.13075-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <PRAP189MB1897ABBF1EB2124C3F4FD05BC6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
References: <PRAP189MB1897ABBF1EB2124C3F4FD05BC6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://lore.kernel.org/all/20250411050613.10550-1-kevinpaul468@gmail.com

Reguards
kevin

