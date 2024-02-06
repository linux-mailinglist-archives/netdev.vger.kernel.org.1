Return-Path: <netdev+bounces-69384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067D384AF32
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387701C21FCE
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475B1292E2;
	Tue,  6 Feb 2024 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2arM7NTX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5C1292CF
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205743; cv=none; b=AUQmEP2hOIy9xrSBsk46kCHInfsnbhxU6Z8cKiwdfNLn1KF5JZtu723kQoGWFZzq63l8simx+ncIKpFCyWFGXhApTL/SpmxKMkdj34mA4nAjAJ37bO4m+ItZO7yzFqTkkX72jen5Atd2iKi3V85wfgd+boPUc6n9/B6nb3lZSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205743; c=relaxed/simple;
	bh=DVSVry8QUfNI9NZsVylGd/PE5JoHNBhUbUUx9ZvDQoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWqZfAxJ9AGkNVQdaFqzQu6vGmUd/AyIvUd6x8V/elKmKXAXLZ+Xrx+5QWt4UqymbfVYTslezXwHv4PDgr9Y0jbFYOYm+R3q0K9c2G/6NQPicwIowjIBuxd8bqXyiVtlzujC1bw4TP+KDrT2uwxkIyVWvWmZyt+GKRjTZjPQAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2arM7NTX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a34c5ca2537so720534066b.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 23:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707205738; x=1707810538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJKn79ThxV0dUrRx4qir0XoAFeN9oqOEUZr0M7zgDFg=;
        b=2arM7NTXcxcMS5uKbgf69G4MmNyascflqMuonbZ1/CpvIK6Eb1gWlth/iBpGN/l3Tx
         XG14SyTK9Zf7jXcN7RC5ZF++6NcZ34GdYO5M7D/ltzRkzJUJMlh/g266xxgI6z8aWuzc
         517yPKfB6vxgzRzFPIEhMIT8qzLhT5YXlv7DYP6ADh+f33WFvA67T2b64FLwT2afSTcg
         TUSy1H43WAVKEYz0WEybD3qj7Mry26g+rhhS+tncK06pItP1NwFnxPLBE7GliZb3OwKO
         vq3SuWyCRO5DEeZoQG8WhhEKZP7Fg0SWgG3kPeC+JVkaXkiZ22WuM6ZxsX8Yiwyo+QKZ
         Ih2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205738; x=1707810538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJKn79ThxV0dUrRx4qir0XoAFeN9oqOEUZr0M7zgDFg=;
        b=oAYcupP9aPHF5QAXyqOjQeyL8qeVpd/tZjedMfaNNqUlg1qpGL9n455irdOmbZOAjP
         7d7wUguxaz/0TH4x7xk2ZIUvcY1s/qt+1+aoOmb3emn8xJ9FTOHymmqikY44r3Fozct4
         w0U14AAZXUTXhDahWTWcEZi4PdNW1C90tynBJah6MGoRnoicJvY9BdxVPPFGkgj1mVkG
         R8LqoUe/l6I6k4ozNblaruoS/lz9pq5n0ZjiePpQuXJVCop7dTtdOxd/mT6mK8al6m5J
         F2s0oPyRIv5QJWr87EF/1a23g5zGjHyU0c0lMrvCwXG5/I/89kuZgOAiEVb570D4u5c+
         oA0A==
X-Gm-Message-State: AOJu0Yxoma23RyYllDQt72m/1MD4nO97czhhNRFjSL7zWtBl71SQg2N6
	rKCl4F/w+lfG33Gx36vNuqqvtKjyER9ht6faT9ii2zUIhwf7SS7LO38F/l/qkZV/he2U7xLYIhc
	SF48=
X-Google-Smtp-Source: AGHT+IHu8WdxsYnIMc955GvapNWLw+X4PnWUob+77bB83azddW/5kJzboNQSEXRLpuODezgGplBJcA==
X-Received: by 2002:a17:906:81d2:b0:a35:b7e6:e6f1 with SMTP id e18-20020a17090681d200b00a35b7e6e6f1mr1310238ejx.1.1707205738172;
        Mon, 05 Feb 2024 23:48:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXl+7bMuB1xz7SO7D8A5QptYxxzDPinWo+O+Dv748APm9mzQg3MmOJor6nka0hTvfGw+QjdPabtefpjCHnHUXQN0gKPDoJi2dw1z6+YwyH5OlQdBPX0llYCOW0lBmcYnrA=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id uz9-20020a170907118900b00a36f28baa8dsm810466ejb.111.2024.02.05.23.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:48:57 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com
Subject: [patch net-next] dpll: check that pin is registered in __dpll_pin_unregister()
Date: Tue,  6 Feb 2024 08:48:53 +0100
Message-ID: <20240206074853.345744-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Similar to what is done in dpll_device_unregister(), add assertion to
__dpll_pin_unregister() to make sure driver does not try to unregister
non-registered pin.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dpll/dpll_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 61e5c607a72f..93c1bb7a6ef7 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -29,6 +29,8 @@ static u32 dpll_pin_xa_id;
 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
 #define ASSERT_DPLL_NOT_REGISTERED(d)	\
 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
+#define ASSERT_DPLL_PIN_REGISTERED(p) \
+	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
 
 struct dpll_device_registration {
 	struct list_head list;
@@ -631,6 +633,7 @@ static void
 __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		      const struct dpll_pin_ops *ops, void *priv)
 {
+	ASSERT_DPLL_PIN_REGISTERED(pin);
 	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv);
 	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv);
 	if (xa_empty(&pin->dpll_refs))
-- 
2.43.0


