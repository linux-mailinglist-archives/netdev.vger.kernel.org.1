Return-Path: <netdev+bounces-244050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C63CAE93A
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 02:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF5C3033DD0
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 01:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A67255E53;
	Tue,  9 Dec 2025 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPBLqesM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7D1EFF93
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242395; cv=none; b=WNILT8xv8lZwtjTZhhyLhX/3fX/P538PKHFYYYwhMTJJ9hJtr38U5gMwdwn1Or8IAFTSMiEHEIFFL3PLHyfd/QlTRo4LZ39+xFsqcnahdH4TjaMGjZQMQam29UXD+EmuU29GduXPz3hp+7zRKTBGcNVHWYkjZSD/8W7DXwnffZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242395; c=relaxed/simple;
	bh=+snQBG7CbmrfNDlhb75QHY3hvT5yBZoez4IFQwYK420=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDBznKR21ar/05aolrdZIJ4ZTHHNj0C/YUnLEXFlShiRC+lB+WP5lzGzyLBllj1HB9PTDDCvJYXjG2x772K63zN+nLXDEbvVZMTt4Jfc/vBR91SHO6uCPwTzopjnFdKfcAl18tHYhm8ItdMAsxFmt++SflmzOFwqSpn0MZ2SjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPBLqesM; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34a4079cfaeso595135a91.0
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 17:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765242393; x=1765847193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ozqCtn6sHiDj5BY/ISqjH/nU8F0CWU/yCHS8wMGPQU=;
        b=jPBLqesMYS2jw6ibnqs3HxAVazYQAN/zGda4WN1EnDziFkhup2KlmHWPOw5mxII65j
         MWx8iXXwmO3EYfwZ/slNG7b2/Ec8E1LQ+WzAKTMXDXASp0ZSk8Pj7O/xD+CHn9Xwl74W
         pcCpUC46Gr9TTfh975PpzW9oQEg8ebBtBlRbK+7qSjk0j74BiJ2IHb+jsst+heK17CBd
         cep61gz5iX8dSg5bwhpLrISaBl8H6n3m9zgVxcvsfoRSJnuvx0kGGiri1ADohYO8rm4i
         iOfC4ewbzipISlb4msC88DK5cEY+SPxMaKY0DKE2pjbgKHJUAQ4jVTRO5PPhIWxVFhcK
         nSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765242393; x=1765847193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ozqCtn6sHiDj5BY/ISqjH/nU8F0CWU/yCHS8wMGPQU=;
        b=gFtS1XxkU2TL3Qv/5d1RIsLAZKd0i/g1aMp7MUkQA8H5CyX/oxtoG96tTwVSaqKWws
         dbGBxdbPPsKKTWg9NbWsq8g00QI5e6VHrOLNl3m0XiHQcSKXi2L3YyVGYAEAnzcCFrV/
         awpzAv4oS9P2PuwFEpq8NKcFYrHAuZ4hD14VSnqeVrd8zV1seQ59R2OGgrdH3ClziJqa
         2ggmF5NcFt1G9g/Ki7FIMbZqDtYfVJ8Cr47EHOLgSybl2MiBHPL+T2Sb47dAGGDU4zs/
         xvfF+w6cduXUxSqU8YLSq6pzjCLiauPFchTmiG4fEtiIH/y8is0xcL+hc/gIvkcmqHNW
         sC3A==
X-Forwarded-Encrypted: i=1; AJvYcCVEUEFaiCYtWbcZMm86fpiagQqClMdXPGdOzR386Q1V/MDOj3zjy/I3QPOQHy/BzvsP/5DMwtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7JnhinjtfVyquaN9XXhLQ9rQO6GlOE1WqlHZmS2MrgnoMNepp
	ND4uSESIs9PaIa1vbRFt0elRGPVVSJrjklRkHU5Yrn9wzH70Lp8MjlYZQJbo9fe2Zww=
X-Gm-Gg: ASbGncvpOzBKwKK/GXrvEpO+Fr6MY+iUZ3kEhoVhV06NqOXmNQmMwb89eOHMYWofd6N
	ctwzOSq71hJmZSmDzxdxCd1iWS30YFj4tGADwBCYckbFy4YryXZMSZc/om3/bfvtGIETEHQxq3t
	rWemkHiCorbsFme1OTm5vasDDeqcjMZGnRKMMsvJr6Jg8r0Vr8CWNstMHytktSdWI2yWum2XcIj
	kUxHM6JpXWQehwY2e9ZBbCyQKW1sVhPScXx26BW6+MCBdkSSHesCiNIWVFDdLn8MOF0yPIKmfuj
	0aRX0A/XwSkqiYsUtrTgW9a0s8RIu4jexYtRJ2IuGGBqUyc4vcArxbAKe6aSKAsHhk0oaGCl0Xc
	x/mUsl5+6dGwkwON//xA1vk5bE9DfVIAO5GsrOzI1AZy1GinAsb9P+e8bhMvDS4H4EESu2GdQAr
	qimc0iMdg0ese8jePQuME+b2nELM2zzRw=
X-Google-Smtp-Source: AGHT+IEZZ3GvrJg5xqvHNrqBFG7XdQNQXgOkKotztjE06kjRiztG71gYUs0kxY3kgvlFfpicRcW6vA==
X-Received: by 2002:a17:90b:562d:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-349a24f21f1mr7533005a91.10.1765242393269;
        Mon, 08 Dec 2025 17:06:33 -0800 (PST)
Received: from LAPTOP-PN4ROLEJ.localdomain ([223.160.153.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a47aa570fsm339440a91.0.2025.12.08.17.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 17:06:32 -0800 (PST)
From: Slavin Liu <slavin452@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: stable@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [BUG] Missing backport for commit b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")
Date: Tue,  9 Dec 2025 09:06:26 +0800
Message-Id: <20251209010626.1080-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aS14lT5jZKpwAg4N@secunet.com>
References: <aS14lT5jZKpwAg4N@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the clarification.

In that case, I would like to request backporting both of the following 
commits to the LTS kernels to resolve the UAF issue:

Commit b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")
Commit 10deb6986484 ("xfrm: also call xfrm_state_delete_tunnel at destroy 
time for states that were never added")

Please consider queuing them up together.

Thanks, 
Slavin

