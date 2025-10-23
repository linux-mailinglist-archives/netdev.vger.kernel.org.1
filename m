Return-Path: <netdev+bounces-232214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2279C02C2D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3C9C4EB7F4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A62D34B423;
	Thu, 23 Oct 2025 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQvTCQ2p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5034B407
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241094; cv=none; b=F2iB+AsrKBZKO51T1LOs0mSwEUhfxORtXY2W4O/xnTAEvyNUamG5K5OTFEIxQOAkGRN1r8n95Zt4dFBiECpG5BhMOpTR7k07un6UCKuCB7woFz+qhx6UC2iPfRaf/s4TylLdXYX7HDUC038oT0d1j180xUo+vtmCXRI8E8loSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241094; c=relaxed/simple;
	bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdusQRkgcKytzY6374jsM1U8ayQqgu4l3nsWW2WPuhokvi7PnyHjqBntPmZ3sfO+Hz5T3RFr38YNHm5WatQajhnFaKHrp/Hvq1TQdxJUg9KBpR9CfjvotD1LJLH9C2sTrNKCxB0Sq41vHHzO7ia8ZAKhi6J52Jxdw4ufVHhqtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQvTCQ2p; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29245cb814cso1846575ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241092; x=1761845892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=WQvTCQ2poQ0X9GhbZuZkC9Z4n1R0iEJDBtYFiyVZ3meO8N9uKX1HVXbvcP+9/b0DxG
         6iVcPY/brnKMN2r+VNHegV0SY4w/c6ERr5yDJq5z+SqusZUrRo/tJHIIHDADWh31qVxv
         BaezDXoL7fp30b8l+GXtAzWTsh7vo1rzve9hxJlJX+75aCa3w+8N6aBdQMg11AzaNurQ
         Ouk8ClgLzowIVgGb0ENVkbExGBkmKndvmmOBVhb0W75Haavx/RGKlx3b1ZAB9jxlXMoE
         d/70SFMOrYugIjnaWAsHqMQO5hlAF+TWX4CkFofAPO6rujT3LcUFI2vwJmMSK3Q7xMwM
         lmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241092; x=1761845892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=MloMNc3bakfpG10ybORzdWXmSIj2d9nLstp9pgSmDXEL0iclFlvPk8opN4oRkcrSKJ
         3NzQJZrtzZra62wDWAIx93tufeqYkiFSa3/j3k83t1xkiiYIL8IXpaZ6TSEg7Lr3WQsL
         FP+JF7PlRRuxeqhKwUgfkMArm6kgl/QkH29fsoRiH/rZuTGfTlghovL5a2fFQ0+jOs3z
         QJmgN4qYIF2XqNNRJwirk0Pwtzv6DtdHUKzOonF8gRDyHWuHUwdPttO8Tr/Nu2coX17t
         eR8mfBcxLmJ9xFv72R9+x0MI3wRxSylCT7u9mg2tUp0FudXx/qElATmIsmsrW/Of0DI+
         NDRg==
X-Forwarded-Encrypted: i=1; AJvYcCXHSxerFD5mTUZNwMdBRM/QRydNzzZ/qMBw9sF/97xQg7jVUD71JdEkqsc4BlmiaxZMMhKheqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRTPlo+iZvSW8SLxZckwM7EATd6DNtmwZCGwDZ1hX22zY46H9
	te5IK/OXAQNMIkFvrmVZymnXxkMJ31/6mELFYTEhTZM82kFuRbRdPGbp
X-Gm-Gg: ASbGncvloyae9h1/aglerCcTuJ9wVVyfdUSMd68627A/xeJ132rZ8ZgLnXs+mNEJgVf
	PLxll1fUEN9F4k6fcu05K/JGMAV9k2ESqYIkUJ5RlyPFOs69jp4XqvqYMCr9JldHc0nktAInCm0
	R1jUZWAS7/X7OrRlUtim7pcOaWXgcgZ3VLqXUYp5i3wiSa1Jp2/bppOhj9Eoe8wSxE7Diccspz/
	HRdIqkHZGsksNmy8TY49F1t4VbuDES4gHCkorBKNiaWezUrjTEMq2kznmDobqeG1gFeFeldR7xU
	p3eqB/VxLG3c6MW957THn8OycJAGxXKKy0bZMtzQZGQGd/tydF6TaeGHMIpdpkYPnsks+l45LZX
	2TXIRtz2I29XqJjKrkdgHSAb7A9/VW/ZZa7mW7XpXZODtUedKp8IX0SEqs5oy2RGtWc/BusYKAa
	9XryPG8RUYMCFIqQxiYPwzftXcPidbnDrTy8Uk4zFI2WT6i3tWdI7Q69VXRFgQJ6w=
X-Google-Smtp-Source: AGHT+IHS0h+JRFSFpKN3ABn8gJENaNAJSEiO+0aN8t2XO48O5XiQnQC/G+gPhMwXVqJDR85nhMuBag==
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id d9443c01a7336-292d3fb7f47mr76907185ad.7.1761241091900;
        Thu, 23 Oct 2025 10:38:11 -0700 (PDT)
Received: from ranganath.. ([2401:4900:c919:de72:5515:28c0:ad28:8093])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddea29csm29417515ad.30.2025.10.23.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:38:11 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vnranganath.20@gmail.com
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Date: Thu, 23 Oct 2025 23:08:01 +0530
Message-ID: <20251023173801.11428-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
References: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

Thank you for the feedback and response to the patch.
I would like to know that above analysis is valid or not.
And do you want me to test this suggestion with the syzbot?

regards,
Ranganath

