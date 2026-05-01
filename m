Return-Path: <netdev+bounces-283103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id J0QRMhI59Gl+/gEAu9opvQ
	(envelope-from <netdev+bounces-283103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 07:24:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A94AA775
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 07:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46A813015892
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 05:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B048342CB6;
	Fri,  1 May 2026 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKT87JOL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B13033CB
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777613070; cv=none; b=UAW2DuU/gI6ZgCts58SSDY1jhApHS4pJzTGW7g09oqDIEHd+TmfmL2zfJ7Sx7okfXUasT2hm3X7yJm5fTpaRDNLwRTECF6Vns2WtjH3fLcqbefMHdNSdclrUzeXZ9aI8AhViZpRS8h9HTAR4/Rco5IC4RpZQDiFhuVU2nv4v06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777613070; c=relaxed/simple;
	bh=Or+T3mRAtUtl+S7kam4QxQFXc7lvjnL7Un0fWGi4AHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZcuB/tMRiIoP9YdeZvAqvJon9yzQEjvW/jkN8hL5vvOrtNBnxM3HNvwj6CnIyKZERbfF2zwkBv4zPtXuBfvQ3o772gVqZFgYeXKrcpW+irC/7Nd7mk2sfm+vJbbaju+Sy+WYEtfLbpHIf9xfL4pCOElJZwpJejcBt1y8nSehNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKT87JOL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe608cb92so955350f8f.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 22:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777613067; x=1778217867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpBHdYGXANLSMLurCZHwQFZNIClhvUMcn3QtK6CuJrA=;
        b=QKT87JOLj+YDGrBelXvLZETDwad1NOFnZDS0t+uoo1Cr7ydpuCvYLVF44uu3egEiiM
         G8/y+7VnW3CuCMbUuJYqEeSNJOAFkPihnQLjCNOxx7y4VclQvcgHH930iKn97qXUECCm
         nlvHJe4FSLClkaCViPrKMzyiNOTIGzYp3E/VCDISAHUwT5zvVmcT/FpAAt0iOAHTL7qB
         7KimfAYRTHxTyQ77Q//u6JDypd687GGHqi1prZFp6c4rH+ScjR459vMxycWpsv89NTC9
         YXd8H98v5vY3Al8WLE3SfNvx/sl0hZJKNdtMZ9phVlsqKeKgBoGGL9zXm7WQ7rqmD1Ux
         nw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777613067; x=1778217867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpBHdYGXANLSMLurCZHwQFZNIClhvUMcn3QtK6CuJrA=;
        b=fp0+03DcrzoO0enVzT4UNJAO4VRLrATW2MhRWhqVudM5EL0DRmgkEIcewO+/JUUWvY
         r1QmCO/m3dzcnhX6A45/EB3ef3kybZo4kXtKghzmyNeCNPVn/4MSmiLoHISHRadkbUOP
         CTQyORz0YY7zEdB2K4iloch/iiu862LiR9o+NlzgQbfrt4guS+M4P+LPWTdjjcICCCeQ
         CRU64E7Thhvph12A2FLKfpX+X6+AaQ3iuvZOApnFQtpJ04qxEt6BPq2AWG+ym3wGIDmy
         soEyn6VwUNd0vgZXq/7Wi3BnV6cewVxflg43bWYM32wKRkMJHWuIMMzU5++NYNMnhxyl
         Hj4A==
X-Forwarded-Encrypted: i=1; AFNElJ9OaRc1hEiMDaA26YzMaHzxWOx/NQMsK8pHNN/4RMcDGlTULedIQyHK/5bXZmDZBwhDqJc6AHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCuhtIgA7+cCecBJ1wHdCREya8VKgukC6CaKnNlWKJtIo18hl3
	PfYc3J4DgImCpIqMA43VaIejoAOjX5BduC1SQnb2Z54GVPQRnxAZThx7
X-Gm-Gg: AeBDiesV3VaG5zt78GsJLBbPKOOtbpEp4N94a3jA4XJbDCRaLfRPGLGvycI82VjXKwh
	MOfuCR8mRBvKF5wN096g9jOXYB3x6WUuGXzB89ndSmzge8eXEwvPa9Z4hI3lOSfG8ITZFQTRXW6
	p4ynTSl2Cn14LnHWVOvQIuwFLHHcaEslldeIk7tgz8r74rWx2ScV4hbpWV0nBpf5fvvIH6PDdlz
	b3Zi6sh7vEKU/Jpw5pMjm5yhV60o9/Tn18LLUr7BayobyNUnX++Vnqc8s74NqqQrQiwltATKsiv
	clR6tCQEA3HFwgAsVY9d4eoOpHR3472RkeYZo32f026akLvs0sxxZNL+rd/nSak7b/SkmQqHqMG
	zN0cNw8UeYfviT0p3nFGyDNeXH/eBWqMl1Mgt5Cw3MjFFbnbF2ji+QGVxaeSWAOupGIRkPwjkbw
	hi85FAvfsGOcIyGENIujfb6f88HRvNErGBOCddXvgWWV8=
X-Received: by 2002:a05:6000:1786:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-4493ee4d4d0mr9516767f8f.38.1777613067093;
        Thu, 30 Apr 2026 22:24:27 -0700 (PDT)
Received: from foxbook (bfh75.neoplus.adsl.tpnet.pl. [83.28.45.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b7721fsm2576602f8f.36.2026.04.30.22.24.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Apr 2026 22:24:26 -0700 (PDT)
Date: Fri, 1 May 2026 07:24:23 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Birger Koblitz <mail@birger-koblitz.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chih Kai Hsu
 <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
Message-ID: <20260501072423.1bacdcac.michal.pecio@gmail.com>
In-Reply-To: <fac7da10-a2d3-4c14-9208-8762f38564cd@lunn.ch>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
	<20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
	<06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
	<9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
	<20260429200214.3e8dee67.michal.pecio@gmail.com>
	<4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
	<fac7da10-a2d3-4c14-9208-8762f38564cd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0D9A94AA775
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283103-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]

On Thu, 30 Apr 2026 16:19:30 +0200, Andrew Lunn wrote: 
> If you are getting interrupts after the device has been disabled, i
> guess it is because the timer for a delayed interrupt is not cancelled
> by the firmware. If so you might be able to work around this firmware
> bug. Disable the receiver, sleep for 10ms but keep processing
> interrupts, and then continue with the tear down.

If the device responded to this URB, it would complete with a normal
status (success or some USB error). ESHUTDOWN (and the debug log)
indicate that the URB was unlinked by USB core due to rmmod, before 
the driver knew that it's being unloaded and disabled anything.

Regards,
Michal

