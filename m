Return-Path: <netdev+bounces-283690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id idC1OiX092nEogIAu9opvQ
	(envelope-from <netdev+bounces-283690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 03:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3934B7F14
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 03:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754873012C4C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 01:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B148CFC;
	Mon,  4 May 2026 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpViutNT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B32F851
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777857570; cv=none; b=sF5ZN8A5vMwwn8GawkA78Y0Lwll1HWci+j9m9Hk5+93xGW2YODI3g4i8IAYTlwetQoLISNN+/5wa/ZwKmdYssB5m1obu7KNfKCsTTMHy/xF/PVN9Eoay6D8Kne4+8xsN/VYkCD2OoEISqxKnwFEZ0E/C6y9UANUOLHyeXqJf830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777857570; c=relaxed/simple;
	bh=/6GeH97feJB5NM/bbu0Eh5+QmZex7BARo1AL5xNchU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT3LU8Ec7qU+SOH0UrbhVpEhqpBiPcT3afPIAoWXy756V4XAc0wRsEWBkkqEEbDaEN8PfnkKKy0kNCxa1CWUXhEc4Rs5hTHU2rwLWn581mkR6Q1JbCrGa3/YqcQ1+w2jo6R4G4fPTsh9ALO7Q/nY8i0cA2qASsJPslU0W3PK4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpViutNT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba21d32776so3090045ad.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777857569; x=1778462369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6GeH97feJB5NM/bbu0Eh5+QmZex7BARo1AL5xNchU8=;
        b=KpViutNTjpO/DjIaTrciLXZyHJAKXOh50eVqaAWcO3fa42VLQrRGicSfNuJinAj3yV
         OZb+T29ejXHUdEA6HJizx5/ZlRd7TmmfyEAVrT4/AunjxHs2PKeo3+IoRQ+FwMsnSdIj
         6vTLmfzCS6G5pokS9R1wbpfZwlLIdiyyCL0Brc2G003hP8P5p/sXiCXTnyeN44cQPJ4y
         Fi7M4lhVtzghaNBLs24Gg/3o4NnM7vzboDHFbntCl7Nnc1/vSemZuFFvvyU8rSin+50l
         idh0150914jVLCbXwEDh8aldpEZhi7Ep74vT41lYOB1cOY6cpXSMMNJ2nSbpd/nSWzp0
         tCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777857569; x=1778462369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6GeH97feJB5NM/bbu0Eh5+QmZex7BARo1AL5xNchU8=;
        b=JpMJe0ckzLZ3A/ZzR934xNnpNLcfAnuKgwtkSjw7jjrPPkIF8+PBQXO6IFdHYM0oY6
         sjC+fhDmO0e4nL8o1UAZpTHWBy+VntoWU6CKY7UbNT9PXZmOlV5f2usptHHT7Kaew0Cc
         V1pvN0gJOrUI+03efSyl3G7CLkBix1K4gccD6yp5OBYauDbEiLEm9YY0SrTqOEui6kAU
         iKoKNoRjD8iJSoHm4hv8Nx9G1jQsPtycJM5LaJpshP+vcR0cSLv0M1i8oxYo2w4Vle4H
         zHXNQOTDPTNjqPae6DDPOUyW+kAFip+S8N/j0Whd5Sx364EmuFxWIlVTJ5Ls4NZf6ENK
         Nzvg==
X-Forwarded-Encrypted: i=1; AFNElJ9quMRM4nGUM7q5dmd2lXEGEJihFLwhJS3FqDr2HOgV1b29XdIJbzi5mAZsoTD9tjXfYLcK/hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTIKhuIQLiwtlFUfphIMssW3ucZldbbBSnOsWMa1Byppbeudz
	JNmzY4PNQ5GslcBHdcwJab24WxZVDmATp7QLPrenH46f7G1es06p2kAmac0eH90m
X-Gm-Gg: AeBDiesfwj6NtVBAcZRu5SgB2zQLle/H6Fk5VHQGPOHOOMlrPpi/KldOKXwd/Rq5cV0
	IwmxNj84jg9D8OMFXS6nB0eBEUa4zSzyJGr2qHcryM092CHFV+BsAv2kDhyc58efvxnNwkh0se2
	gqS/RjB5PKsE4PSSI9TZy0C52hDvSSQdzNguB4N9bhao9NF0dTIYQP+VcKHAvcDlR8c+K84QUyL
	0h2/Syyp88VCf3rFDwGAdVgKmLSxa4HZsMQ5qy30QC18uwhYs8X/eNR682Czvi0aWeWhGM/T0wM
	1m0ZTM2kr5PtsAHSZ/V09qBhdyPOnRCf19QlQMdiQC1BU7Vxr6ghFETk3+nHcZ6fYVbyShNiP87
	mxrzdL88ITYJXvNwaf0D7gPwc3xEdN+zq9ZXxff9SpxNp+FeKtAmOiuTYYW8o7itrws5I/lfSgU
	qNJlDo/YAmc9Yi+qty5/c1BRJcMH4=
X-Received: by 2002:a17:903:9cc:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2b9f25df47dmr69840285ad.20.1777857568992;
        Sun, 03 May 2026 18:19:28 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6ac32sm87651795ad.83.2026.05.03.18.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 18:19:28 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next 0/6] seg6: SRv6 Mobile User Plane (RFC 9433)
Date: Mon,  4 May 2026 10:19:18 +0900
Message-ID: <20260504011918.1320307-1-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503140547.6d732f4b@phoenix.local>
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net> <20260503140547.6d732f4b@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B3934B7F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283690-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, 03 May 2026 14:05:47 -0700, Stephen Hemminger wrote:
> Automated AI review of iproute2 is not setup yet, but manual run showed:
> ...
> Please fix the invarg() usage throughout the series.

Thanks for running the AI review against this series.

v2 will drop the seg6local_action_check_attrs() helper entirely
instead of fixing the invarg() call sites, matching how every other
seg6local action lets the kernel return EINVAL via netlink extack.
v2 will be posted once the 24-hour repost window has elapsed.

Thanks,
Yuya

