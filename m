Return-Path: <netdev+bounces-125940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0596F551
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2372F1F2496E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C41CE6FF;
	Fri,  6 Sep 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovUNNCh7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScrwLiIi"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591C1CDFA8
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629301; cv=none; b=S+1iKk+Cz5LFuDo3jJ6W+TWpa07Kjxe5Xxb3h79lrnB6z8V1Q6rbeEOo8q+RLg0wkYgEobjMlw8kB+CluOECuc9imudECyjUikTfES8xgto8wMzIgCajvSHL6i5eOpZTEZE2dUYa8sgE12QWUz+CSZ2lWaI7VL7Vq33EHp+jTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629301; c=relaxed/simple;
	bh=2DbWDYjza1SkYsmTlbpOTRK2eL/770f99FYdCiA2dBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NId+Hf7icZlfQrZrhfN9r1zd0HkRPyfrx+WQUz+UK3lm3kPgVOqPaDTnSEeouIbL0WCTnru2qhxYjFw2LIwofXMS0w2KgEqX3o9R5Qke9tfGHan9y0q3zdfuyTMuX6uMln1/HjDUAhVhR/hYfWvrSFhNmRsO4oBm6Ez/46GHt80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovUNNCh7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ScrwLiIi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725629298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=okCkEAsw+g+yieCo6wMsRClSv7d2JSxFHt6CIpki8pw=;
	b=ovUNNCh7JSySIe+kUpshqv4kRV8XVzIljMVf5y8tAlpkiDupQvTNKAkB+Q53w7ZloHSxhl
	/mFh4xnIAHv1xPXkObF/S5Wy3RVVBom4W2iPBwFvziyRo9M5o8CAASajI/rs8eVthhrmhD
	VP/c/iXTdYSZobOD90eCQl7v8kmw7QS2FJgmRVfeUgqkcbPqufjYOK/hoatUOjTZaj8RfH
	zeCIe8h3JCiWY89ATjydQJ7NoXtqNLJ2OFPPczvcAPyqHITGZreURu/hJyuIF2ulS8NBy5
	2EqUwXiDWMQxWfMrU7g6kITc3KNfUuQ/gN2cJP1+VnBLfg+sITKrwxALMVFO/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725629298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=okCkEAsw+g+yieCo6wMsRClSv7d2JSxFHt6CIpki8pw=;
	b=ScrwLiIigTOglCbYCm10x0n1dpqxZS3/iaVqKWkcI2DkejlrjTjwRI3S3Rz07JuquScsVg
	pQSzvRX8qtfp5QBQ==
To: netdev@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net 0/2] net: hsr: Use the seqnr lock for frames received via interlink port.
Date: Fri,  6 Sep 2024 15:25:30 +0200
Message-ID: <20240906132816.657485-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is follow-up to the thread at
	https://lore.kernel.org/all/20240904133725.1073963-1-edumazet@google.com/

I hope the two patches in a series targeting different trees is okay.
Otherwise I will resend.

Sebastian


