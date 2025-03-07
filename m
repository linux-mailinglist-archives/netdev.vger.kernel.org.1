Return-Path: <netdev+bounces-172943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C45A5691A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29CF17302C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C5A219EAB;
	Fri,  7 Mar 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EatyBqzE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB9187872;
	Fri,  7 Mar 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354813; cv=none; b=sZYkktxoDpizkomA1kD0c/+BtxcE0MVCbancHoNAxdh1VrSeqG3y1HbyHFBayCBP7MoWtAlP7QivdMirT3xck5teXHSQ8jEqae8p/pdzwzIAHw0l/hrHIJLDjKkPaCx85Xf2WSO/tHmYFcrvsIdj0rcM83Y++MFb5mqQJXkTPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354813; c=relaxed/simple;
	bh=Ccf6WOnqeVtaEX17aLvzSPY3yDwittu0de2hVcdK2lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXbkR8NPpzwGYtBFxOZ2nPB+bUxoTcwIoYgn4xEtmqvArz55r7vNh/iohf9P1eFnufPScUvlzKmgzCLuXKPNY9uWIe2Ur4ikP+pUpvp6vXJNAChcYgIFiYKDCmW4XXO5Y51c51b/5qYKYY8GZZH14fKDkFXX19jZKroXwoBIZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EatyBqzE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so3324235ad.1;
        Fri, 07 Mar 2025 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741354811; x=1741959611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAJK/MSGv6f6CCqFqHOXxbXoSD7hyktOLg63JkHcDxs=;
        b=EatyBqzEP8HIF9Okzew3Q13sq8LUJaxNFngeFeuhzDcKKkpFoFZ1RNhrPKyTi6+uMo
         mHktnCm4Z/f1/Moht1Gu2l3I/8op8+EF+PX6p0elht25gzCT7pqxJabuGISGLVxkPdkC
         tHkFfOynUaLQZuBBf4v+NCAK9dZxuGCBfST4bSstanSyW24tahP64rHamajEEbR15seP
         EOfXVHiCVWXDgHs55tZmaSFOvTIAChtIOIgToHFv/XmlWuBf00QWa1t6hOOCOgDfOWuj
         Iz8OvJlvLvXebckeoyUR/7S2JIDWgm4BXV39n8Dlx5EyN06TXcy1OzsjEFRyAp/mRvTf
         q7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354811; x=1741959611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAJK/MSGv6f6CCqFqHOXxbXoSD7hyktOLg63JkHcDxs=;
        b=v0EXm4yETAR07qWClTpg8W0AT1g3xpgarcZHjjTvkfEpTbcnyhuDe76DPc0KohH/d2
         50uqqnbo9/ifxOnvGQjtKXf4zLuZYquUX6SljmidzsKsTYfGJAudluKtOEScCkRaJ40J
         GoJjJClZO0JGw6yPUcuqxEhb0bZBn7bgQRWvXDhTyfCm9Hk2UKl/3Q+de/n7ZrDs6a52
         Y/hxo7oveYLeY0FLsDEK9o7QFXQcO1J9AW9e8rxcRLg87dZALg+H0epIMi32kzx72sdX
         2WGhPBeXTPBCZA22YgWo2E2ILmWdvYShd6hAuSzphXiU7efRP8mAzJLhc5ucxmyAXWr9
         vb2w==
X-Forwarded-Encrypted: i=1; AJvYcCW6+Ddqtr6PgreBoBjEs6EAu+pVQ+CrhAMD0xSxj0ano/NZIz8xgXUjzJ2uW4jeGcxs0XhkJK1wn+l3NnY=@vger.kernel.org, AJvYcCWYk+5FW0LVOyyhYc0HzIjmwAeS35ZRuYnA1Zkgd+l+Z8Dg6OZ9e27KzaRU6nfMPLmYnsRFgwM0@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2/jEtnd99U9NVaCOfj5zSaGxLldovpgSEDDZpCVGvrk6xV3w
	yGZ+cER9lWAXMuTPtKJwaQNe5cDsneTrNfU+37buxSixBbJlunwo
X-Gm-Gg: ASbGncv/rXw0o9SUy7UhixbtQ3nEx76+CWA6nqlwwoZjvrd+JNr3GSqIVcxoSslIkmE
	4vu27ML2CHMV7g8ra9ljZp/R84uL53YBzoBHmI/JYM/1KJNK98QyGbQzlVG7BEdMoBgnLFvQ/GO
	C8n4UpljHSZDT7LSlA0RsPrdicjLtBDQNqa7EaooGjBlE+SkbpJB77EEmC/k1gqIalTSJPIMSXh
	V586YEsx+9eMExWa9OQ3IxcU9PY6P3f6QsNYpJc8qeZbKs41Czg2ah5G9JZDzEao56LqUlzhDIr
	UkGMaTDQERxXTHjkO79ZYvQvns8ljsn7fzcAMpEpq6o/pcFK2fcGxO7vTmNrv1//uBzjkPLJ8bu
	DBkZCy8SJl3gEccojb8PEdfGwxj3C410=
X-Google-Smtp-Source: AGHT+IHl6IfqevUsZeQEG4TtH8KemZ5d37OBc5VdLaT2oePHHn/W2OqKnmnlRSgCD+xni+a1HkPRrg==
X-Received: by 2002:a17:903:4407:b0:224:721:ed9 with SMTP id d9443c01a7336-22428c12cfdmr67227535ad.44.1741354811502;
        Fri, 07 Mar 2025 05:40:11 -0800 (PST)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd60esm29710425ad.17.2025.03.07.05.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:40:11 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: bp@alien8.de
Cc: boqun.feng@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peterz@infradead.org,
	ryotkkr98@gmail.com,
	x86@kernel.org
Subject: Re: request_irq() with local bh disabled
Date: Fri,  7 Mar 2025 22:39:46 +0900
Message-Id: <20250307133946.64685-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307131319.GBZ8rw74dL4xQXxW-O@fat_crate.local>
References: <20250307131319.GBZ8rw74dL4xQXxW-O@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Boris,

On Fri, 7 Mar 2025 14:13:19 +0100, Borislav Petkov wrote:
>On Fri, Mar 07, 2025 at 09:58:51PM +0900, Ryo Takakura wrote:
>> I'm so sorry that the commit caused this problem...
>> Please let me know if there is anything that I should do.
>
>It is gone from the tip tree so you can take your time and try to do it right.
>
>Peter and/or I could help you reproduce the issue and try to figure out what
>needs to change there.
>
>HTH.

Thank you so much for this. I really appreciate it.
I'll once again take a look and try to fix the problem.

Sincerely,
Ryo Takakura

>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

