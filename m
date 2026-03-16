Return-Path: <netdev+bounces-268212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGmlNpw0uGnXaQEAu9opvQ
	(envelope-from <netdev+bounces-268212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:49:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E829DA30
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 531C5300D70D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD643ACEF8;
	Mon, 16 Mar 2026 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="RwFEXyDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED13CE4B5
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679770; cv=none; b=GM5PUmXtNEUrB6yX9vXw3tMfF68cRuipPgqCkXZX/UZlTA5hDarZJfK0KB3oWwJTFpDsq3VLnukGOvhnq5sIOATAgJS0zDgvcsH3UCYQu7teVt9+H3UoHGTFzmKWX8gYolTUQssoMDwgzX4ZK8jxuAnlNfkg5hf/4cgXeWcDfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679770; c=relaxed/simple;
	bh=FhZtqePpHiDmUz3kiu5dJsvvDDTQqWtAFcUhiOp8xbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q397l9k3eVpyNWamSmUWtUOHnN1ZjKsrZ8W4dh83nognX3kZWCOF92N6uNiNpKgBgR19FWKxrirM8/p0sKuwac4apX8yMFyTwwn8eSrvozvUgtmz5l6pflOd1eUPQs4TgI3KqKVTwGetpJYzhAVO7mpf0nvJ9G6z25MfUPdUuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=RwFEXyDf; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so5529712e87.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773679767; x=1774284567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REy0ulTuPqZXnhB/EsRa7VlyQlK2ftmiDyWrH5fDGzc=;
        b=RwFEXyDfUIOKTUn8ympWeCgo8NgO5HBLuALGOwoykijnoFtGZ6QOeJWhRH9ML9hcJJ
         VjK5ovPAREq7IdX0s8FqDByY5CmKyTtqJ0OT+Zn84FvZ0AmmGT+nXUS0wlpL5gwiVMFc
         UjLCxxA/xVmbpZwKzf8CtOuYvsv6Wl4tFKNvT09yOVwZIM3tVLHgqfDA7dyHy8QVtkTs
         mmCJzCRRY4o/Tnay9zqWJQbLoTfJt7pLqPu2+5FXEtwJXw+7eXgf5YIFdwkMB0b9PrfE
         U1qmhEUzuJfY0KMGEwsMBNpyqFmQoFUrfH1x6HlaXSP+0Cb/stVmNDzh56lbTkmSGJxL
         aNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773679767; x=1774284567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REy0ulTuPqZXnhB/EsRa7VlyQlK2ftmiDyWrH5fDGzc=;
        b=Vvz6dcWPIaiSZXlnyRuKRr3b7xb+OspWLeWxcIXSbiqlAEnv83jW+sQuaCt8WTf3AJ
         K1/baDS63yX8h0wKlnlikoU6TGSfBm3Olq/n8gt2/u4GJzIuMKYDo8hCPH6PJxUdmRby
         WS2t2jMw+NjwhQtfgGBMSpqNMwmQB5IqRryURNyZYiGFRUaAlubtm+oBwAQdUltWMOGm
         mNCbgWICvsBdf2sWmgWCTtSclpvp45wr+S79Ho2agFd2ckTFvudDyWMUHnTHRe++2cmp
         S0R9aR3xVka3MwfgdaPuCdDN1TEgAfTYyIa5jzivUszjZYrPjfqDJSc2oxraF53psaso
         Fo1Q==
X-Gm-Message-State: AOJu0Yw7AndegCtw4EcSMCwmxHNFNcFsMefSkcOQ043sA+zdbxXdzEn4
	3dz3UQMRsUWvIIU0u83iZCSSc9Li/XdJ59w/IQwknsDP5WYzK28lQeX3wf878ivdxlsNgKT6a/9
	0UQXSyfto7GRZWSu+cnVmEdJpZ2yVf0KvRN1F
X-Gm-Gg: ATEYQzwjesGfbXI/Z9WIbniLdhvooJgk8ozHNW3FRfJFm8duNAU2oCTkMFapN3OQkT/
	XB9jqEviDfQDg4zVfPpG99G9JQqwN5bZUa30K3NefLu5j2h6ekLIydLKfDBf9eJk063z0YRlYts
	uW+WAJ708r1D2jsXEkUnaBAXZo2KVX9R/HkfcVL0pw48J6o+VdCAH7PnsBhnSmhLUUFXFu6LMQ2
	ZM9AhoayzEnNf7pEAL3qnqthpBuh1hJykebWOcXl+BK952XAY9SjpjV7qw8jpXzCNwTGNl75/gf
	3c6x4XTljSPDu6M0w4nLwj2F5dq07plW9E/BwS6fDz0DP6LIG5UF4XAz7gM/HTSbydnZGgW1low
	mkr9e5KEZohvPq0r0nEIUy4ga+JcfUndm2CIo/vzFdPlyq8fLofZjaK8CU0+9EdI26wkK463Fqw
	==
X-Received: by 2002:a05:6512:3b85:b0:5a1:3f3f:a299 with SMTP id 2adb3069b0e04-5a162b20052mr4219023e87.45.1773679766799;
        Mon, 16 Mar 2026 09:49:26 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a156154b2dsm1355421e87.45.2026.03.16.09.49.26;
        Mon, 16 Mar 2026 09:49:26 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 58FDA19FB5;
	Mon, 16 Mar 2026 17:49:26 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	andrea.mayer@uniroma2.it,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	paolo.lungaroni@uniroma2.it,
	ahabdels@cisco.com,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH iproute2-next 0/2] Add support for seg6 tunsrc
Date: Mon, 16 Mar 2026 17:49:05 +0100
Message-Id: <20260316164907.1255510-1-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,uniroma2.it,gmail.com,6wind.com,cisco.com];
	TAGGED_FROM(0.00)[bounces-268212-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:dkim,6wind.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 759E829DA30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the new per-route seg6 "tunsrc" parameter.

A rebase of uapi headers is required (net-next patch is being reviewed).

Justin Iurman (2):
  seg6: add tunsrc support in iproute_lwtunnel
  man8: update seg6 encap documentation

 ip/iproute_lwtunnel.c  | 31 +++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in | 13 ++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.39.2


