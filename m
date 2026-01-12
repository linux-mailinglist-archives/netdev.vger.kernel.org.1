Return-Path: <netdev+bounces-249215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5230D15BDC
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 00:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A8513009D70
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC3429E109;
	Mon, 12 Jan 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRSpo6Xy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E239296BD2
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259408; cv=none; b=tSv82g7OybMUQFPjycAAQRPK5I+H+RW967VsrRd9abbjLlyYq3gyWUwOBly280XpDOAimr2LDZR1ZTPJ2vvUnVCyPnGDFiC2Wj1c0nEOHjOOEJohKHQFCbmoK8/WEhf168P//346EGxTx7+y+QsY55bbhzQQOPQ/78hFdLilD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259408; c=relaxed/simple;
	bh=KIMwqLz67vxIHDlV6V8ZemzGx4XBD8NNzqOzyuAG+UU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OQZv3UwOT2V9e+RnA7u4iuPmtevVuZJORYEh+BThTfXuB29QMALqTmK98fcBUVPuRa9J2G7WFKUBxwihbDkvfBQZHh/vaUKCpDNIHde1elBUADKrmbF3IBcAC3chQ9EyKQVJA/ekPmblLHKcn048CmYYkwAliomX4jv4PGvK8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRSpo6Xy; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ac363a9465so6049598eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768259406; x=1768864206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nr3qS8YvLTsu9x6NwsT9BcYQwikNzECAjN6lT6kPblA=;
        b=VRSpo6XypMiSadvLvCPn1dcfGmu+BsSba4RQpV2O+rr0uaAbprwVtqSno2kxjRX90b
         u1qg3wl3L/8sS1Qu5s3NpcF6JKIZZ8yZuNW6JZyif6nA30wzzrcMNdcbbc2ow8BznsVA
         T+cp3rnBivUK3stjK3U8PSjnE80t40AnoSD3GcJMPjaYm7/2SAygwZhhEoM7cNHCHLhE
         HOR9TKt8iiIxyKmybu8ZrVFtmtirmmokXEMxQ3UVITm0KPkNRQ0hI525KyOhacPF4Ryw
         egHC+QP6NH5aLd4MZAAeboOK4902Qqx+U6AEpiOShNKg+9kjlZUepZn4XGiT74K7v5RM
         sLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259406; x=1768864206;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nr3qS8YvLTsu9x6NwsT9BcYQwikNzECAjN6lT6kPblA=;
        b=cLukyd5TmoeT1oqsGZDFQTTAr/5aEMC49vhB0hxtX9oc7TFCb4HXTtxHUraHQHS/up
         t5HV2hM/oxNwdBciosH7o1ITeFD5rWkRNeoCeB10znE64eQ7aRk3g4CprHIwuZCcqnDh
         X99xRcomiXytKFRaIz3SkJag7tkd6KCuyMOTg7d6QyQfFFPrxPM4N7dNfGhmLYxbV9Gl
         bsP6/SyTtW/yAx5R4ogEfCi0wVLs9QKxuDGjflOxq/lWbG3nDBmNfXEfQ79FAm4xLbQl
         HLsy0+eUZoDUSPxgSD2Wi5NW5zzrANmiKRf1TUW86Wfyo3r+H6/p9p1uEZSeeBfjhnSk
         xaHw==
X-Gm-Message-State: AOJu0YzhhijzMVFxOmgImwmy4LASfN1yZBAz6Rb810oVAU9W3MlCVG44
	tVyFBP01ATI0ED8BnBZjQFpWES9jhyHSdpXtgRvcStzbu2N+RTmA2uhW3n92+jsBjImuwC60sjz
	tzY9V5Q==
X-Google-Smtp-Source: AGHT+IEDbDNrcyQ2vSmllcOSSpijsN5OpYTJ0xGlmFWgFknZJ97PGmeMno98rJYaDiuIMbOXb+kZIRS9INA=
X-Received: from dybnb47.prod.google.com ([2002:a05:7300:ccaf:b0:2a4:64c9:8bc8])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d207:b0:2b0:5c14:dec1
 with SMTP id 5a478bee46e88-2b17d3219ffmr14309405eec.36.1768259406423; Mon, 12
 Jan 2026 15:10:06 -0800 (PST)
Date: Mon, 12 Jan 2026 23:09:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112230944.3085309-1-boolli@google.com>
Subject: [PATCH 0/2] idpf: skip NULL pointers during deallocation.
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"

In idpf txq and rxq error paths, some pointers are not allocated in the
first place. In the corresponding deallocation logic, we should not
deallocate them to prevent kernel panics.

Li Li (2):
  idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL.
  idpf: skip deallocating txq group's txqs if it is NULL.

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.52.0.457.g6b5491de43-goog


