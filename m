Return-Path: <netdev+bounces-234399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB53C2014C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB7EB342D41
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12831062C;
	Thu, 30 Oct 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biz7aGwJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB954918
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828597; cv=none; b=Vl/YbZt4YlTgeV9lbY5rWuYkHc2D1rOu8OCizvsLVRlytdkNE4fQmdjmB3LYAVo1ocVQayMh1Eqt5+CdwwJVIIuOJRxkkFxHA2g+UJvXwqG2gH3khTltafUB0OoF5XYOclyk5QnW84MvhDCHFfd+T/xUfEppRFK/ZxypFU2+DDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828597; c=relaxed/simple;
	bh=pl2Dax7X8Q2Kn2J5L1Qv7Q75J13hklW936GDEM09W0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPVnQMNCAYBZBbQuiMgnXbZUCDbIaaRdVGsui8NeJ4NigDF1EAHuS5+Re3aBOM7ax8opV/rwVkFfdl8XNhyE8CgZsFVAI7dAEAv/stedZJIDoeyyv94QPQqbIeJA19I6LP/ghhoM2h/IUqrnKz27YdpKyJdYi9UQF/Tmo66IFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biz7aGwJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-269639879c3so8707385ad.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761828595; x=1762433395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wMUkyUpK3qsMRsq71Jgy8aRMQN0C5fUI1+KxForyRw=;
        b=biz7aGwJPjM/t9shv/+KlX2eHVgmkzw1NlWrPQEC3XwQkuwNCUvzrqb02qDuoDoJni
         LnXVEZ7fjxS9/jWHO9BvWH3j2O64exRqFnU+MjYoxYdtUfU6x+aK0aKhtG/NWXzl+EUj
         P3rzI+MKxkF4/jfu2XQ7I8lNH+AoP8stQuMNZPX2k7GcsPLtIhkPS6H66aUE0yD71GJH
         9kRRPOxzSwc5x+JoJKS7fnX+rI3oqonb1v8YkRoXGK5vXD3W14J/DcOgweNZeFHXya9p
         ZM+VnQHBlOhZs0hykKSEk2Sy4T5CYf9RaWAno8vC3m3mB3+ZRi+uUMdd1bRtOSDX2FiF
         PJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828595; x=1762433395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wMUkyUpK3qsMRsq71Jgy8aRMQN0C5fUI1+KxForyRw=;
        b=YGy1OYt8h15wrZP/9tYyvDOJn/PO/Zr2KeaxQTqTK3HFO6STYklecvurlWnORoPH/H
         odSXUU6oewfq9AO/LgFBX++FVeFVi7ku6vSSxoGduJngoWDxvmTOsmWx29wQ6+2qV9pD
         temxhkkZaGNDlwYfQ5bzbAS8lakxoySvrKl5hY5TAyZHQK0ssa/a4MUgtWcNVAhoKkUS
         HQPlx6msTqQODgcMhOrfbwckajl+181+1nraYohKMR7d+0RcDFOqGYqfmTOlsgylWCMV
         cLK8JrKYp8z+QDgNPnbE2ED5dTpag0yp+13lIck5/cFEdCW/sOYgWXixza7FIsVY/N9G
         dEsg==
X-Forwarded-Encrypted: i=1; AJvYcCWsOK5/5IGyKQaVSffHhviDJoEzFlh2H7Knyv+/HidMP8OtKTBn4OcucpWsjywhC+Y5i1lenm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/26tD8w60jPkx/+dI8+b+8LwP0Dr3fz9DUR0Mzrxpyt/Hu7A
	80cA3Gu7EbyyOZL04Bfh58uD6tQe7jhZEAF/hGlh3Ia9LrYmQ4X4bvDI
X-Gm-Gg: ASbGnctNtr4dRLWv68/WiJptO16rgtey7cwG63/Yit0GhrDa1tMY0/sI3LNhXpYONYl
	aLJ+mEtj1L5VIFCTwyd1DkIsFMXbo0u8L6E79nNHop2gZbMuCT+8Zne0iSKbOJf8tLksxofJSbY
	9o80EXmSwtJq6YyqJmN9k45U0YnOLinmjssxDPX7PFedyaKn9IDXWqbYbSkl58Af60KlP2uaJVH
	0uCaw22dorZQwXiZrpec752Fp9Kpgdtg3jj26K8pH4MNd03qJVlI+X5CQ2tCdPr7Nqo35lKbpaG
	1Nc3ev6XwEHFwtXeUgEOWPWmmPkc6cftI6y/+3zqSwD7jHFKfd92z5St7xIq5R9Bj7mVEbBDN6S
	CAc3yxeVbsq+VWBIaPXu7sgKF7XUt35aoMWTs5CfAaBEMpf/8aBvkjxpmBiRFVHA2uKxsPuxvjM
	qElFJcbiNkStg0
X-Google-Smtp-Source: AGHT+IFqMiF+448NAGIOILZt5S2gDNl6+/qjfqm3OgH1RKZRoe6AgVc3Kgh8Qko6BWtweiYRhF+MNw==
X-Received: by 2002:a17:902:f708:b0:290:a3b9:d4be with SMTP id d9443c01a7336-294dee128c3mr80435845ad.24.1761828594891;
        Thu, 30 Oct 2025 05:49:54 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([123.124.147.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf47a1sm16719123a12.10.2025.10.30.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:49:54 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: kory.maincent@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v3 0/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Thu, 30 Oct 2025 12:49:46 +0000
Message-Id: <20251030124947.34575-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
References: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kory,

Apologies for the resubmission (v3); I forgot to add Reviewed-by tag in
the v2 patch.

v3:
- Add Kory's Reviewed-by tag.

v2:
- Fix typo in comment ("driver" -> "lower driver")

Best Regards,
Jiaming Zhang

Jiaming Zhang (1):
  net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()

 net/core/dev_ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1


