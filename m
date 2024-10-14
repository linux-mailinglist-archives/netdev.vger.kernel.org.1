Return-Path: <netdev+bounces-135086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC1E99C2AF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FD5281114
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7E140E2E;
	Mon, 14 Oct 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LF4TAhJP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D52B9A6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893502; cv=none; b=jd3jAkeugdO516Ay9vanwFw7S5qdGSf+1/vrA98paX2Rw3sqpCqGRyaRNRrBhes2KcBXDWWLx4fECit6ggGg2GwIiuUVtFOm4OR7ewKVytP0lTdyXOqTDGIwW9ruBoCzJp0L8WE92lkjMW5htb63cCWB75yM99PwAH5Gyqjrr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893502; c=relaxed/simple;
	bh=C/S7uUJV+ORPIlh72pWeWGo24p9KHoLbPFQ5cMMUYAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qja+zHuDEyvWewljq9Ts3lvnuasVm5tj29Wz+RNCs5iIO3MvbHBB7plTwqcaSqre/gbzX6MCbeADj3a/t+b191W8JjKiBH3gC55oGmKQIqpKpOyQ4z6H5PRpng0rTLB2FfwboSwyoh8MZ1mGKV+iTY6f8q7R1WK9nF1zbEwJ3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LF4TAhJP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43116f8a3c9so44460535e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728893498; x=1729498298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qWoo1kkqjr9irWeSjlL15fWHEEjygxg5BMj89zjpps=;
        b=LF4TAhJPmrJMXQBodemg+5Boa1Q2A68IZSnPhaHppCrxtGo6nxpZcJ8JD18Rkog+fg
         fpSNa5Bv+8xJX8fXZyAPOaS/DHsSLzQRqrGG93W3RUP8DT9n0j86VWMLfdzClEb8+D7U
         Tz0WJEO35lws1ME4UcDasusJa08w0zEj5269cqPFB5Zc9M9yK03m4+54AgRx7+fAwGO0
         BcqP/+6W0fmmwovM6sGtb9xuusXHT70xB9ofOscD1h5oqhrCxVOVFc2L7Hf+flk4prHo
         JhlAI1Dy2y1V+/esDKMyM706Efvb1dM8dQXUJ8xhD44wRywV0nthqM7KXUBPN08YQaZK
         gqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893498; x=1729498298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qWoo1kkqjr9irWeSjlL15fWHEEjygxg5BMj89zjpps=;
        b=J7hYg7vp1g0sf2b8AkTImqp0hSTrLdw4fCu3z2re8ITfc77USyR/2CZ0lAaTyEWAwf
         fPCjKoXo33JVn2eaubyU+tLTEdNCYzMzfrOaDFr58LOrsJhVIfZJo3lZ+4dUSDBrI1YI
         dV12jBzYrUWEvQemJTGxBbNcubz1Wtt92gjhhhDE5Y9Nznw6KIh76xLHijYuY29Ed0cN
         F6bO+tCHh8bL+KWg3sIxfLaSyL7qPzQE5rZ4PiI+vL3jpr9N9ZXNtW3nA5lpSKbTfkSI
         QcRJU4GY5CsNReMpMAvWwdZrreNpt8+ER85tDpVjw2YQOcPgP6i4csJxFsTbk3IfnAQ/
         JPyA==
X-Gm-Message-State: AOJu0YzOaixhr5k8pUnEtOdBz2VsP2b1UtmzDsOjTBLLQwm64qqhTmly
	ody6tAesEFDQ6975XknsdBVaP2lcQTXwoAYRswgLlYvEidm5RT91m0fM5TGf+V+23RbViGMsd9U
	YLGw=
X-Google-Smtp-Source: AGHT+IE1NcdGxGtuOYOvIOVww2XMcP66f8MDhQtya5JBz6TWAUsK/xuv9BS0423RR98jNAq/2ysUSw==
X-Received: by 2002:a05:600c:1e0a:b0:42c:b995:20db with SMTP id 5b1f17b1804b1-431255cea70mr96553755e9.5.1728893497638;
        Mon, 14 Oct 2024 01:11:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430c7e653absm147566995e9.0.2024.10.14.01.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:11:36 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com
Subject: [PATCH net-next v3 0/2] dpll: expose clock quality level
Date: Mon, 14 Oct 2024 10:11:31 +0200
Message-ID: <20241014081133.15366-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Some device driver might know the quality of the clock it is running.
In order to expose the information to the user, introduce new netlink
attribute and dpll device op. Implement the op in mlx5 driver.

Example:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --dump device-get
[{'clock-id': 13316852727532664826,
  'clock-quality-level': ['itu-opt1-eeec'],    <<<<<<<<<<<<<<<<<
  'id': 0,
  'lock-status': 'unlocked',
  'lock-status-error': 'none',
  'mode': 'manual',
  'mode-supported': ['manual'],
  'module-name': 'mlx5_dpll',
  'type': 'eec'}]

---
v2->v3:
- changed "itu" prefix to "itu-opt1"
- changed driver op to pass bitmap to allow to set multiple qualities
  and pass it to user over multiple attrs
- enhanced the documentation a bit
v1->v2:
- extended quality enum documentation
- added "itu" prefix to the enum values

Jiri Pirko (2):
  dpll: add clock quality level attribute and op
  net/mlx5: DPLL, Add clock quality level op implementation

 Documentation/netlink/specs/dpll.yaml         | 35 ++++++++
 drivers/dpll/dpll_netlink.c                   | 24 ++++++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 81 +++++++++++++++++++
 include/linux/dpll.h                          |  4 +
 include/uapi/linux/dpll.h                     | 24 ++++++
 5 files changed, 168 insertions(+)

-- 
2.47.0


