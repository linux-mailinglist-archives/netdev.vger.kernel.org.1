Return-Path: <netdev+bounces-275869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7fmXDvad1GnDvwcAu9opvQ
	(envelope-from <netdev+bounces-275869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:02:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C135C3AA242
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18CA6300681F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 06:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0A37C0E1;
	Tue,  7 Apr 2026 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSYr6cPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE8229B18
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 06:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541747; cv=none; b=JHIvf0j59l6TF3qgAEOO3cJKBBi+7oaifV/1pDTz3sXn2wQx5A+XgtzIRUrFQmIjlAQINiU9CO4V3ksxWbPQu0d3bFsKAXLTHH0XBNcSfUs0z2ErNkZbu3p3GhAnWpn0GgEli89gad5Gj//EvFHvUMop7+ztki0V7hS/sOUrK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541747; c=relaxed/simple;
	bh=0H9VniHkzeScDYxm/6T7jaHVl7KRkm/Ov7jjRgrBk6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIi1UCEuOIfRejV3us3DdVeqEAyoL03jRH13+a32X9i5hT7vtVYWQ8Xe1pWQQMZMLlffIx4g8vKMpJKROWb6prVRFJDUt0a9JYtQPhUPHzeJIiHHVyJJaU3vkKTjJpdlskI/esqbsFgeyBvygnZ+OmlB44uMP2GUk9yYHXEhkdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSYr6cPA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b24fede2acso25585875ad.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 23:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775541746; x=1776146546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+UZVknFvzZ+CFZRKBwEomqUEvo570iJuDBzJawHtDk=;
        b=aSYr6cPAGxt3Xk7EuXlKysqU+50BosfIlUki+v2Tc6Dy69Vt4fbcu5g5c6yVihUJ3t
         DkTesnWuWRCGo6N88hNEHSWWB6mzLnrhwbfLkSxL5Fdzn/l1lDUObjz3br7yX8Dnwjyt
         gOv8yrWj5sFA0mvKE2XFc6JqanDjZgV0ZGJqLBcd/H/GVOfYE0sSgcPup36Sdt1pWRaa
         ASLsKJOep6FXQ60U9TGbZ58SlIFrlg98y1s9K9xSavQDRvCt2m4Fr4ycN1i5UW0kyqo8
         DJrOjYjXksVBZbmBTv5Qz+Ts9X1qIqsjXK62dre58mSpUIA+s/HJZxBrtfKuKT0FiS1L
         HpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775541746; x=1776146546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+UZVknFvzZ+CFZRKBwEomqUEvo570iJuDBzJawHtDk=;
        b=qaA8IyUtrQ3HN5MizJtXoVzpbOKS2xjBbuP3U81F1Hi63ZtiX7y/q2T0TJeFCEYoPF
         InlDgG/rPCwuBX6FIQ+Q1mEn3n/npeTziWU4GgRPPnRy3ESYOJvAesS4eOrp7f8CXToM
         RZHIs2eYO09wW9HcXZYQbzNG+lGF9hOXFb41BGznWZwmlpvV43Eu0VpKGwExWVVlISJq
         MOAmcn8E2tVvT4HiuGn201RNKh7M7qsNXNpihFl+xN6AKxCMX5qasiXuvByHJbgFnWBK
         WGjGRvxnQjXiHbBd3o1JXLDjBBpm3lVeCAJVhYYnv7J8WEU4wEn7wFN9ciLb6cZgLuK4
         Vu0g==
X-Gm-Message-State: AOJu0Yy4xXIVGCR7g4YOTeXu0xpY8Orr0blWlgshn0iJ8IBcMvwURUS/
	POLKfH2XN1LVXYOCzHuAIxM5MgoyTHsxI+6f1RtwXAes9KCR1/CNGz/jSs7QeZK4I8A=
X-Gm-Gg: AeBDieuEw6iLvFfLjDUjWYWFf+U4AqnJ5VYt7l8EJZ1mR3gsVPjR11hU6l+bVhYZHBQ
	Y71shHRG8ueykKjUt5EyC6cBmuo7Is/eYB17ctVj8hFvGiXlTDpc7zs0krfcxAEZoYRIIBsBG51
	SkRzZ+9A++dXIloN3bSqDM+GdP3em5pa1nal3LUj8Uk0OIKhaOPRemDOgVHcYDUWwo/vZnlgJfn
	Uq2lcrADq+f6guSThBhC6J/um3isC1eStnP20tYa6zT/irf7mYf9+5LiHNm5QcyoIdwxzDH1qBl
	5Pox8k5h0If0hXw9ukG/lkIS5LNA0hRfSbd6rtnCMfkSdpbzYAE5lmaau77hHBzvIqN3YanRdQQ
	A7nPkBJYkhvoNxW2cC2MxUE2tSPfcVU52UvZSUa5JFXf2HkdJfHgocILOMwFCZeQ02I/IE238Al
	EJ40neregTox8J8E5YK/cSkaNrzsFTP2gJNhI=
X-Received: by 2002:a17:903:22c6:b0:2b2:680c:2193 with SMTP id d9443c01a7336-2b2818b3ae8mr164243585ad.31.1775541745820;
        Mon, 06 Apr 2026 23:02:25 -0700 (PDT)
Received: from C6-AF-E1-B8-1C-91 ([106.216.138.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm174986745ad.29.2026.04.06.23.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 23:02:25 -0700 (PDT)
From: Adith-Joshua <adithalex29@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [RFC bpf] Ingress RX queue provenance across cpumap redirect
Date: Tue,  7 Apr 2026 11:32:03 +0530
Message-ID: <20260407060203.3391-1-adithalex29@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-275869-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adithalex29@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C135C3AA242
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

While working with XDP programs using cpumap redirection, I observed that
ctx->rx_queue_index becomes 0 after xdp_buff -> xdp_frame conversion and
execution on the remote CPU.

This is expected since xdp_frame does not carry xdp_rxq_info and cpumap
re-invokes XDP in a new execution context.

---

## Motivation

Some XDP deployments use cpumap as part of a multi-stage packet processing
pipeline, where XDP is effectively used as a distributed processing model
across CPUs rather than a single RX invocation.

In such setups, ingress RX queue identity (rx_queue_index) is sometimes
used beyond the initial hook not only for debugging, but for maintaining
consistent observability and pipeline semantics across stages. This includes:

  - maintaining consistent per-RX-queue accounting across cpumap and later
    XDP stages
  - preserving RSS-based classification identity for traffic analysis and
    validation of NIC steering behavior across a distributed pipeline
  - enabling end-to-end telemetry correlation from hardware queue origin
    through CPU-side processing
  - supporting reproducibility of packet processing paths in asynchronous
    cpumap-driven execution where scheduling and CPU assignment may vary

In these cases, rx_queue_index acts as a stable ingress classification anchor.
Losing this information at the cpumap boundary breaks the assumption that
XDP programs operate on a logically continuous packet context across stages.

---

## Design observation

Current behavior appears intentional:

  - xdp_frame does not carry xdp_rxq_info
  - cpumap executes XDP in a new RX context
  - RX metadata is not considered part of redirected packet state

This suggests that RX provenance is currently scoped strictly to the NIC RX
invocation context, and is not carried across execution boundaries such as
cpumap or devmap.

---

## Question

Is RX queue provenance expected to be part of the XDP execution model across
redirect boundaries, or is it explicitly considered out of scope once a packet
is passed through cpumap/devmap?

---

## Alternative direction (for clarification only)

One possible model could be to treat ingress RX metadata as optional,
non-authoritative context and expose it via a helper-based mechanism
(e.g. ingress queue accessor), rather than embedding it in xdp_frame or
xdp_rxq_info.

However, I am not assuming this is aligned with existing design principles,
and would appreciate clarification on whether such a model is desirable at all.

To be explicit, I am not proposing that rx_queue_index itself be preserved
in xdp_frame or across cpumap, nor any change to existing struct layouts.

The question is whether ingress RX queue identity is intended to be
representable beyond the initial NIC RX invocation, particularly in
redirect-based XDP pipelines.

This question is motivated by cases where cpumap is used as part of a
multi-stage XDP processing pipeline, where loss of ingress queue identity
removes a stable classification signal that can otherwise be useful for:

  - correlating packets across distributed XDP execution stages
  - validating RSS / hardware steering behavior in software datapaths
  - maintaining consistent per-queue observability across cpumap boundaries
  - reconstructing ingress-to-processing paths in asynchronous CPU offload

The intent is to understand whether these requirements are intentionally
out of scope in the current XDP execution model, or whether a helper-based
or metadata-based abstraction is expected for such use cases.

---

## Follow-up

If this aligns with intended design, I would be happy to explore a concrete
proposal or implementation.

Thanks,
Adith

