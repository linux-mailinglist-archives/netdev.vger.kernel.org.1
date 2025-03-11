Return-Path: <netdev+bounces-174040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719ADA5D263
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 23:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32839189CE35
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E91DA0E1;
	Tue, 11 Mar 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/6Rezwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C92F28;
	Tue, 11 Mar 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731389; cv=none; b=cSM5s9E9juMLgFMPfkHjxA/7ahF0JKc5tfoRjksfSE0pVzeF2N/WQb+M2PLZDl61STGJ07ejloDM/f5TwJBwACEBuIgbO94ZMY7Riq/9x/lgseYlO9dVRoRoV+Ju2JrtFHoe8PUsmaLqhgdHIn6mIvzg9IHUSD2ZAhEXcPIJOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731389; c=relaxed/simple;
	bh=iuiqi9e3e8PTnvOuSOCH00S3bhZKN6Wl9Ex5eOpNe3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZzS0rWaSd92zEiAkjEWu4gqqACVzo/+SrwSMlAVOZfNIpZ6UVk1lSlhJ09XhcbbAzJszU2asTrWOzADNIKR9bzxYAx85NxOYn65FLIdG5yA7aW2TPwztkgbQIe1UrGpN7Tdr6NKBX6Y8v2DFChK84Fzrp6Xs+BpDqDvuWp69Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/6Rezwg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f42992f608so10168993a91.0;
        Tue, 11 Mar 2025 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741731387; x=1742336187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iuiqi9e3e8PTnvOuSOCH00S3bhZKN6Wl9Ex5eOpNe3E=;
        b=C/6RezwgZdoX2qwTituYZT4P+9JTWJ0J7Ydq7NK/ICdGxV2+D/OO0t7vKwHarGVNzp
         oZ3pF0fnre2jeJOvpqxg3OCnCb+5AgMcKkYJWM1k/5xrDKkH+jz7y2epIWa4vraW55Wo
         Dr83w1z/mmbpQ1Twg1WImDYQ8cdpuROGM2EkF2PimMRR0DxcOC4v7ngSWtoeDewVseO5
         GQuVZidIKjcRRwt4radBvx4Ur5lICW/TKCH7Ov+kuym8nxSeJJFTPhiJW0ctVbLkqXOi
         OjK18fSEs1VARfRj3vE9AU/hyhDalWH9itebUEX7c3bBoJWnIP0p+91vz6AxDXr8r10q
         kMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741731387; x=1742336187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuiqi9e3e8PTnvOuSOCH00S3bhZKN6Wl9Ex5eOpNe3E=;
        b=vHwndDxenl1yQbQKOJPEsKVDas8/uBBeRbWLXTPh3y6GGrvTnGSOoVC0mWIEBoD0VW
         mVczYtGa/U0TCw6HjSandFQNBKAVd6DDFoneIIkoUSo4YG1iBrrTQae7X3hd1Ys1F27K
         G+244jPup2o4CGPLQwzc3Sj1epNOZLwU56fFNf90Xap84pDeroIEwUG7VHJH+9yMlAN0
         oJHP2cT/iZ8j5olfT0ljHW1KgDRlxKx2IrxV6N8mMa6f1PySRtt6RKi3gd0wbXgbE5Ad
         lLIHrAjVRlKXMhLLnaVwPsXJoYFO3KXWOVp3CduIzmEbPXojS4txQivz8jMJrjKvTvaP
         DVUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaPi598UJe8/xMvGBneSvGhfDufwW/SfvpFJBMTX01PiOHCmWqxAG+6CQOUYwZfxWHl+Ut5VxD@vger.kernel.org, AJvYcCWVur8lOnEmXXAtecOWz69bDZesiaYbvMO+pPblHVxsoHLi0RqlIRn7j2ye0iBw3LyKptApmnnWYF5xwUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoak4cmnCcuK7Sqh/uYjzpsaVyS4D1bEnv+vrM4qXsSTnHmGu+
	ShCbwp4WzXrKz/JspysceOtIKl+gu8PV+MENGZFB9dW6cjf/ADJU8tpUXXTjiHY=
X-Gm-Gg: ASbGncv9qaiCpe7kayAjtTjVcIfihP5/7CWaeVID/Agy46tg+5olQ/OW6pnfWP2zSoN
	zki4AjCHm1InpdJLSrhuI6ExJ0G+lgs5tX91kIc5IRCeShHObu6y1TjKAqnv9V4mFZaDb6Xy7w3
	N9T9fkGK5DuXl4vZDa9YXlBGduK7WSSLRvnZc4XOzqqfax1/3YyqVB1x5AMoTj9c7K+GUUtuSrc
	DoO+euCHpZ3T0AlxC6Dg/j53onHsJ0XpMAc0D5uMzOxSApUt/SnWJCHFQJeRXJZRhbDbxRxV3TV
	kugP/z+9ccrRMcQ/Qb34r3Re2JsfXGh37HIT8L01hw==
X-Google-Smtp-Source: AGHT+IHx77KmhClE9y0RHz3VSR7AoYY9YnSFnXUMXC59jH0tGBzghTeYuIgmk5Bdd4EbtttJn1ID6g==
X-Received: by 2002:a17:90b:17c3:b0:2fe:a742:51b0 with SMTP id 98e67ed59e1d1-2ff7cf26dfemr26096359a91.31.1741731387229;
        Tue, 11 Mar 2025 15:16:27 -0700 (PDT)
Received: from fedora.. ([186.220.38.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm113364a91.32.2025.03.11.15.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 15:16:26 -0700 (PDT)
From: Joao Bonifacio <joaoboni017@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Tue, 11 Mar 2025 19:15:13 -0300
Message-ID: <20250311221604.92767-1-joaoboni017@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The following is a small change made to the file removing the zero values from the initializations.

