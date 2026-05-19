Return-Path: <netdev+bounces-289364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOO6E/ozDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:57:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37357BB9B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23FC7309F030
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FE44BCA8;
	Tue, 19 May 2026 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6W6fJ5a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2B46AF24
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183925; cv=none; b=upcGfe8pvaNWmyc/k2kj2kYzXU4N8Q+d2yNL3NyE36zMwYRUpLcIXNNr5m8qRJwMJo037zZDwPOp+kGU3Vlqv6dXyC3HilpRHpJEu7HhMFMIVcPOijje4Jsw/l6J3CNU8bp8q7yuLOJFP8xr3udcU6oxvWJfghVNozP9ziLJgRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183925; c=relaxed/simple;
	bh=PPkfS0W4BdASGFSHdqAdDDD4AgJNZzgTh5rgfqXdaX4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=W4LCdPvdA1j9rR4xnW3q8PLFO8BxQGmwpne83Ym1VKJiu8p8WI/XfsZClN9qWZP0+Z27iD+UL9EwVLzGQvkzuohH0C7Qzh+xFzOFb9Erw4x5vI3ZcdLObISpkiijr2Ky9NyX5qwAnTSa11JS10MdtqJpVh8bTBuYyiyWYSXzDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6W6fJ5a; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d146705b4so36157325e9.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779183922; x=1779788722; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPkfS0W4BdASGFSHdqAdDDD4AgJNZzgTh5rgfqXdaX4=;
        b=K6W6fJ5auRy8/bjjuJabgnqjPq7t7+XvhGoRUBBUVDf91yVaPrBgtoYp8LViUnfDTh
         XGyMCu7te46osP/+vac1rTicDdHJl6QGRDttPkCcB4rBiHhUtgizKwKjMlf2p07anJkO
         VmDno4rbUY9y6fMCSXoeJA7QKWqGNRwRsvAAJ4D2wby8r0JFKUDoUmn8HqA4nh8Y4WJk
         uVheW/8BjXFDCZ30/WpcqyUwV6Lg/oTwcqhZnqQ1AizyQ1JiH+xLtiZCfEB6b3fpxUar
         pUjNwbjfaWhz9GYnvR2sSriv6jZ2k/p7Z3a2ybeD8SfY/iVvoaaDDSaPQtJPqAh0iJux
         aOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183922; x=1779788722;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPkfS0W4BdASGFSHdqAdDDD4AgJNZzgTh5rgfqXdaX4=;
        b=bxkXIUvfXY/kOKOePNm+9UB3pVmvElr/JtJ8J7FO5xz30YQBC3nUwGxsZ+dy7y0YkK
         InYMd2oi91SpmTpIjft/0fAUK4hb708PefF0053DSLO2MXadMpuhwUrHiEdL9uSfPYgu
         hwd3O15f6pIKa2hABecPZp99nDYeu6FE/gYFq2PBtECyJqkLioQi6l82zpUo3qGekeCm
         JqyMTdc8Ba8D9hcAJXBfFu5mgNTvsZVj2Cmel5pRej52sPuRsVqhdZ2X7xPZJ5xzFoml
         BXFufEdYKFxJUcm9cd9ZJObkHhA8YYE25CCUbje0vZzQp3TIoJ4yjEFZS1LPEl11WzDr
         GK9g==
X-Gm-Message-State: AOJu0YzFulLKyOpuLrSebFm/s11knum/p2/+2jMu3p8lyk10FHYsILqC
	kMW6IyaPZfjEWFv/EjnniFpblTn+rWYItLadvY5eY/+DHjVmzkRItGEk
X-Gm-Gg: Acq92OEEp8K3JesUq83H5uRxuuMHqlw35dnvW8vx2froNf212wMf3prwHmajCaTFCUG
	XWr7IfGWK7trkmZDGZ6FLlb7Tcp0Qt6zIk/eTQToFYbC+6m01EqypqCwBjpNSqG+rKbLGdLTpdj
	E4MlNhdLvhDOidEgWS3DYBWq3Y1Y1nqmJqEuMR3To9e8d5JZ1nFZT2DcCvamXbFfH5a5jcB8fp5
	GtAoFtw2GyjgyqX66uiLA+jEmGbCO3cHEhn5t5M8c/vFP6SOGwcplyK7E0sFCsfinDqJ1s0nVAA
	yPBZHZkkglos40u5RV2K/MWq3Ixt1LpPLIbyGaHunhfJJmf25WaK5WKA2DbmymEBK9Feop5QMWp
	7uwAEYsNaNo18XGKcSO9FdvCVrmxG3VVoqKhRz8eXsglWreRNhX6ywUVvI4I/rfjtwTqycRZxJy
	FF5de5ObnTaCV/kOMt3gtYn+DqtiMShoaAYTwm
X-Received: by 2002:a05:600c:858d:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48fe66129efmr196051975e9.27.1779183921381;
        Tue, 19 May 2026 02:45:21 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm307063585e9.4.2026.05.19.02.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:45:20 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  aconole@redhat.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] netlink: specs: add OVS packet family specification
In-Reply-To: <20260518164029.439928-2-houminxi@gmail.com>
Date: Tue, 19 May 2026 10:44:03 +0100
Message-ID: <m233znvin0.fsf@gmail.com>
References: <20260518164029.439928-1-houminxi@gmail.com>
	<20260518164029.439928-2-houminxi@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289364-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F37357BB9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Minxi Hou <houminxi@gmail.com> writes:

> Add YAML netlink spec for the OVS_PACKET_FAMILY (ovs_packet).
> This completes the set of OVS genetlink family specs (ovs_datapath,
> ovs_flow, ovs_vport already exist).
>
> The spec defines three operations: MISS (event), ACTION (event),
> and EXECUTE (do). MISS and ACTION are kernel-to-userspace upcalls
> sent via genlmsg_unicast(); EXECUTE is the only registered genl
> operation.
>
> Key, actions, and egress-tun-key attributes are typed as binary
> rather than nest because the nested attribute definitions belong
> to the ovs_flow spec and cross-spec references are not supported
> by the YNL framework.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

