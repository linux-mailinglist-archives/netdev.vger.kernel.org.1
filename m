Return-Path: <netdev+bounces-145584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 985519CFFDC
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3221F22AF0
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E37385270;
	Sat, 16 Nov 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="JlipyMBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3B29415;
	Sat, 16 Nov 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774750; cv=none; b=COmMIgEPbandrpSBlPB3fi7kGJ3YBinxwFWOjQcMqDW9mVdsk2izVb1JxXjo2Q6Zvesdwk8vrNebKCHTtLDjPSOLj2DWq6AtbVDE3tTGnXJ8UIv8DD9QZuiiULfWK+TKyzDXV9eqhgwARoryyfb59NQTdLzaZGlCOUyw2uaTws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774750; c=relaxed/simple;
	bh=EWz/ho3oL/rauhXIWw9/SpKSBe9pOKdD5AUwHhdsPow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kELNgkPjsj0cNABShv8YjGxcZ7cnypbV86i4AHdRIVbJ2p1Tfa7XO+h0tl6RivvLPBPH592z8lJAHcuSwgPPEToyIu9n5hhcc8OmE17VlJdjQu0Jymlx9Smob64OZiMLUAoSEhGzhCQbAQeCNPxrfNrcx2IUtYwKz96kh6ZZ/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=JlipyMBL; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 65C2B240127;
	Sat, 16 Nov 2024 17:32:22 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 9EC932405BB;
	Sat, 16 Nov 2024 17:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1731774740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWz/ho3oL/rauhXIWw9/SpKSBe9pOKdD5AUwHhdsPow=;
	b=JlipyMBL6hHfJ7MTRzCxLQr8acYd151yqMIevoeTIZsxQCR/9c17ERa8q2cJgu6ZgoUKNW
	Kbuteh5NpIX7thuw52JLrT7UTDGHqJP6FAJInYv4FVTYHAX5z+9CSg0Pofwh47q1+E8wPd
	5lOCf0kX8BPjdZ51t6tc0M1FngWOG1OBdUOonK7imU9ETDd6NQ06KhiDGjNHsFDFHoJYoa
	+V1QToET9NOJhvY5K9iSoLJRxLC7dtVLW6NU6/lgjMSXa8xGkZjIVflCO3nvjGhaSdGcFj
	VDoIAxbSPJGEHcMAAhLgGBeZ7ZgjA+L1pS+m1GpOr3KErZdLq3lGdGVTvy6tEg==
Received: from Til-Desktop.lan (unknown [IPv6:2a00:1f:5742:5f00::754])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 5C1042404BC;
	Sat, 16 Nov 2024 17:32:20 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: uevent: also pass network device driver
Date: Sat, 16 Nov 2024 17:30:29 +0100
Message-ID: <20241116163206.7585-1-mail@tk154.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115140621.45c39269@kernel.org>
References: <20241115140621.45c39269@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: b7746f
X-Rspamd-UID: 821965

Hi, thanks for the response.

I have added a short explanation to the commit message.

I aim to retrieve the network interface's driver when it
gets created on the Linux OpenWrt OS. OpenWrt doesn't use
udev but uses its own hotplug implementation where the driver
name isn't available per a shell variable.

As I mentioned in my commit message, I could add the driver
query to the hotplug implementation. But I think it might also
be beneficial for other Linux OS that the driver name comes
directly from the Linux Kernel.

Furthermore, I think it's more comfortable for a user that he
can directly check the driver name through the sysfs uevent file.

Kind regards
Til

Changes in v2:
 - Updated the commit message to clarify the purpose of the patch.


