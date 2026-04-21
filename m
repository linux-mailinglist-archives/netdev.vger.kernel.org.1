Return-Path: <netdev+bounces-280056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id knkXIhg952kK5wEAu9opvQ
	(envelope-from <netdev+bounces-280056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:02:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C764388C2
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 727F9301C972
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7B3A3E7F;
	Tue, 21 Apr 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMlWzJvs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88A3A1D1C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762054; cv=none; b=BmZHrwG9PtYcYKVO8TyUckZf92KGN/6EUoFhCJdxt8FlrwH3l+2UAAVgJnnfUgR2JNrWDoKLbLQ0QEbIxG6fss+QRLpuomAqh4GXwPrPxBk6w5iPCXeUeIS9ZlyP1LY83a+PNPnsS4prZNFRgWD+ZIlwXjES9DPy+unBeCbA81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762054; c=relaxed/simple;
	bh=5O3E4beXCFsn+2omG2JaeUU9yR3L603oMfZIX81POm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocBoKG7WavFaUHUE92AGaqyuy9t+6C3L+hUVtOYMGnCg9W6pQ5/zyICWMKAwi7sLlUfoRCqhsN+OYfTcdTgoN5mnIuiqNdfmtpzI7fav4PQZGKdpZBMM5DujZnjCP35iKooz4/n02hRDnDTYyYoFbJmj9WRvX3hvC/hDIylAgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMlWzJvs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso25711421fa.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776762052; x=1777366852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uqEjO1x7U0hEHfUcPuuf7JjPHoK2TE27oUo7PzQd9s=;
        b=YMlWzJvs+gPhRHvzCNYFK2kg736BhSRlf1DYEcuTmjSBA1qHk0kTzyhqg5NB5wFjuu
         8FFrGFHQHN+tQOo2RYXBo+j+GMwk2aBU7iZxqPX7lvyee029TFfelkAhbzGqQZqsOlSh
         zDLoekKcIehCZF6k4mqEC8HxEnK8bCVAS+1Wkdjuu+4od2SN3I8Iy1GPY2dKn6oI1r+9
         fSnqaP/tmVAiMrA0mMYf+KbLmUGNj/tPzPsYjcdnD7QFnqq0h8xvDBU/Vc9nQxEEz5lz
         Q9RVuNJNsANRnqwO1cJxlYYj9BEkWtKrmEzuzmK69bdyZo1IvefiSojAYQ5HkdC0JxqG
         DLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762052; x=1777366852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4uqEjO1x7U0hEHfUcPuuf7JjPHoK2TE27oUo7PzQd9s=;
        b=DKYZa7gFyCPUJFljHnAIaw7+6XkxFkxEWH1QYIF5OCvgofGUe7SfAmZF/rLAEotoRi
         b16faaqK/SpcahbzkKQ+gNKQOmezpOqfdEezBa2hwP7ThUvfUJLm6mqg39TKEfbhfFPU
         n+Ww0KvqZLLkUhNzkSXwR6WZFpfcMC4dAnE4t8SfRfyG1iSZEWiPxMXrPmX1VqJPF7Hj
         NGQXRlBPbnT/uOaoweoOi+O0IspKeqFMVaErZmrHhaW+dnmmOoetEhyXS60A+ux/jqlH
         m/eioIShGa4+eTCNbvVOLojAtr9LCndjhmq1vMQDGGcrqu0P1Bz7MXVt+8lfRwy8T/Fb
         0SPA==
X-Forwarded-Encrypted: i=1; AFNElJ9yMqic23uQuBuVXPUFovgBE/I/gQBAvEHLVTYG8ARSdJ9K0VL7w8dGJ7OP+81KG5kore1l8sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pEWoRCIuK9BGQs0JV0hDz2CfyJK3NkTtKCrveOyxeBS9sZxA
	q8+IpKFUpaSkT06089t25uajem2AUjHz11Y2HnNeLbMELfb+v8xlpW5b
X-Gm-Gg: AeBDieuzRuz/gBDpBnOc8cM6nAEdrdC3VCddbo6sM30f76dLx03RUkp5CeFVxsqd6eD
	+oaTnDF7ODJt2MMLYremQ2CbCk6JLn67Z+rSTZxugTWOj6PPkYUqomP66ocNUMmcE0bIVG8YA7m
	r3hi+OVw/oKFNMlEcQSKu+GGgZSov4WXxP7GZ5MACwnd5YUjsv0nK4ZJJFIxo/SvFIvFKK5fVqj
	HMH+dbEhXp1dp1jGksvjpj42tzU7kQCo0bt6Lgtvrh9lSgxmlD2kSBt5vyDNafoFhv76VdRpYkO
	9ZnuE+bHjm9vKHEOfMfvMjJeUFzK+tb0gfh2i/c9/iVw+wL1x/gpN3ZNhAm+DsZTngFhrs2GWZm
	/GIMralgXvdToTxmRskomEmkn7M68D4GubW9EPET0ffs7FUkKAIRsgVgjAcULHnremlg59D7BpH
	OfBxzOfE/utaI/IaUChU01tsAvS8Nd1JA=
X-Received: by 2002:a05:651c:b0f:b0:38e:7e2:3324 with SMTP id 38308e7fff4ca-38ec7b693f9mr50643341fa.27.1776762051353;
        Tue, 21 Apr 2026 02:00:51 -0700 (PDT)
Received: from thinkpad ([178.205.156.194])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb75b033sm28583931fa.39.2026.04.21.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:00:51 -0700 (PDT)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Min Li <min.li.xe@renesas.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] mfd: rsmu_spi: add 8a34002 support
Date: Tue, 21 Apr 2026 12:07:10 +0300
Message-ID: <20260421090710.395591-3-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421090710.395591-1-dev.mbstr@gmail.com>
References: <20260421090710.395591-1-dev.mbstr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280056-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devmbstr@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2C764388C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add separate compatible string and spi_devcie_id to support 8a34002.

Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>
---
 drivers/mfd/rsmu_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index 55c5698e7e77..2d4ad9606aec 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -242,6 +242,7 @@ static void rsmu_spi_remove(struct spi_device *client)
 static const struct spi_device_id rsmu_spi_id[] = {
 	{ "8a34000",  RSMU_CM },
 	{ "8a34001",  RSMU_CM },
+	{ "8a34002",  RSMU_CM },
 	{ "82p33810", RSMU_SABRE },
 	{ "82p33811", RSMU_SABRE },
 	{}
@@ -251,6 +252,7 @@ MODULE_DEVICE_TABLE(spi, rsmu_spi_id);
 static const struct of_device_id rsmu_spi_of_match[] = {
 	{ .compatible = "idt,8a34000",  .data = (void *)RSMU_CM },
 	{ .compatible = "idt,8a34001",  .data = (void *)RSMU_CM },
+	{ .compatible = "idt,8a34002",  .data = (void *)RSMU_CM },
 	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
 	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
 	{}
-- 
2.53.0


