Return-Path: <netdev+bounces-291071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK2vFjJsEWpLlwYAu9opvQ
	(envelope-from <netdev+bounces-291071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:58:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596295BE0F2
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8C1A30046BD
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090937FF57;
	Sat, 23 May 2026 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R86vouQV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D637F8D0
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779526700; cv=none; b=gK2N0+kNzpE4kY4jyQeEMiEIegAws9lg3+9FijeHnVrESH/adPCYDpjDc+F8hAcDcHt/JpYH6MAwkcKqKp6F9WGLGm2BpfXaZKMn12lU7oDrVxf4ZuM9AjwKTwsqfkF4U5inP7LLhkEt3huxAhXWQBoVRVDJx8eqfhDrQm8alvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779526700; c=relaxed/simple;
	bh=HFuauo/R/DdqeAYPIpnc7Zt+6L1MoBuerEr2NwcI18A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv2v8qSyiOXW6GXrNEDd/noCfn42XgqS+GuvBsOgkCuhKPvhwFxIEIIMMDu/C8z/WHteFVVK8Ee+nAahwhmSaM1lRsXHTN3MD0Bmukfe1Ata9JKSsjLTtYUbN8ycsYOweEpEEEz2jBzjclZRggrnVRFQD3/3J99/KJ0PQG4Jatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R86vouQV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so7341676a91.0
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779526698; x=1780131498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta9Hhm/O5mRGfpKzafCBp6sb1vl/zPPnwuKJ/b1Ef4U=;
        b=R86vouQViAFR7Lz9U4suLf/Xuc3dNWArhge3NXamXAPTSIYRYakIfpGZgZOyED+r2p
         +96KiiNmj90I3ega8+nO9SJxlEvcAk9je6YB2NaJmMvTdmayuw0I/r/EZtcPIlhrpNCJ
         DinHqofISWVufsybpVjJTv1acvWCRp2WtJ8jhdykbtSLZ1Yq/xjPdNKI2uAOdkG9Makw
         zz2mirkeKw/LUK6WusX+vafZm9vYXcpEXL9eXv20FvVONxtkAtdqy8WChclGpLx5Q7MX
         G1wlF6Y3tcRRWBsC8z2coAtbhkkITlXBDAaZq+zD7OZOJhHNMRiwq8Ju5obSdnvk7Yoo
         4r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779526698; x=1780131498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ta9Hhm/O5mRGfpKzafCBp6sb1vl/zPPnwuKJ/b1Ef4U=;
        b=C1WfWF6m0R0Nx0/LBdk6LGIL+/Qrw+YuERnk/7J5gZR4J1cmDrFmyZpO4wVtogMtAD
         SSSI2GjdJDc9XD58abegB12sdawVhEWx3wCQi9k1F2/9KrURiouqlmaZRqLUX58goiYD
         S0SsYtDuSzkfTJsBb1ucWlR71exS2Gtwx2Y5IxZ/8mRn0GKqGFHvst3yDhXN7xsPzE3z
         qAh/fONhoBdOypduhgeYpSwrYV72uh1VYRb656fPDJ6W0NScUDuoWUvP4J+HKwSNqJHK
         6ejKI3dHcxKyMlZxrItvixfnPm4lJJfAslKwgtKY3HKnbyWhDeY3hch/6Gx7wbHOK3nd
         AeIQ==
X-Gm-Message-State: AOJu0YwMD6FNfA350td/zb0RvViYB4VwFJo9VjJvc4G9az3ItoWZGb4o
	d3BH/ON/+amB7b8H1m0PnSbT3LcD6sUy3H6FnLpS0PNkJ3O7pZ5St7zkLE2w23Djqcm0FQ==
X-Gm-Gg: Acq92OE4AtxMmPv2GKG3jrSMPVV8FFqYsJDCskW1Y5+nuUZddACaKBtwu7T7mbcZirh
	GcFagScrGPsA1YSnnp+LGNlWpdkQfOPaQVUA82zvRYvzkbhTNHhgJ6SRX1RBp+YxW3NAdsiOSPo
	0qr7IoakQU6ZODSLv2hu/rNZXoWdOqu16p3MOhf/1Ok+ib9d6Uok62489PKlljlUY3Tawo5ccCD
	mI6CTQPKkJ2/XGGg1vMdSJm5G84PpCPd6flpigDSNhu+dxayERpcP+xA5XRMjX/LGdRNzIxwi1N
	+jlyA5s4r12dVaoW2wAkZlCPb9Xyobw6O/e1yZpyktr2hAS1ezzg2zZPTSz3RbRHekE/CnyI875
	bAD5eOUkz/zK9PaczeN0tKM9UbPW15JwKn+oSnuVJG104XcQAiBcR7htufKbrF0645ipft+2GrX
	50j6CNoYdlkDGVyLQRg9QhFOJJLjR4Y/MBi7f+Etau
X-Received: by 2002:a17:90b:3505:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36a671ddedcmr7040382a91.0.1779526698191;
        Sat, 23 May 2026 01:58:18 -0700 (PDT)
Received: from ip6-dynamic-adsl.viettel.vn ([2a09:bac5:55f8:25af::3c1:44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a723cee01sm3873352a91.14.2026.05.23.01.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:58:17 -0700 (PDT)
From: lazyming <minhnguyen.080505@gmail.com>
X-Google-Original-From: lazyming <nvminh232@clc.fitus.edu.vn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	w@1wt.eu,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
Date: Sat, 23 May 2026 15:58:09 +0700
Message-ID: <20260523085809.26331-1-nvminh232@clc.fitus.edu.vn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-291071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,clc.fitus.edu.vn:mid]
X-Rspamd-Queue-Id: 596295BE0F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I reviewed the Sashiko AI review of this patch and it raised two
issues worth noting:

1. Stale shinfo after skb_orphan_frags (vhost_net path) -- this can
   lead to UAF when skb_zcopy_clear() fires on a destructor_arg that
   was already freed by skb_copy_ubufs().

2. SKBFL_MANAGED_FRAG_REFS page ref leak (io_uring path) -- page refs
   from skb_frag_ref() are never released because skb_release_data()
   skips __skb_frag_unref() when MANAGED_FRAG_REFS is set.

Both are pre-existing bugs in the carve helpers, not introduced by
this patch. This patch only fixes the missing net_zcopy_get() for the
MSG_ZEROCOPY TCP path (SKBFL_ZEROCOPY_ENABLE without SKBFL_SHARED_FRAG),
which is unrelated to either issue above.

Could you re-review this patch? Issue 1 in particular looks genuinely
dangerous and probably deserves a separate fix from someone familiar
with the vhost_net zcopy path.

