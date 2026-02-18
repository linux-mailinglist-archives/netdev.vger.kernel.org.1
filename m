Return-Path: <netdev+bounces-259199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH7lG0E9lWlpNgIAu9opvQ
	(envelope-from <netdev+bounces-259199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:17:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C33FC152F1E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E10E300E3AA
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FE02EACF9;
	Wed, 18 Feb 2026 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcWX9SB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D272E7BD6
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388185; cv=none; b=K3e5XpdrpSB/EM5cl+hVo+PHQXIUmlkCFhSEPD1xu3PyK+fQzpiqngv96rRqSGmd8eRIoE2GBinm1kpOBIlqnVMFpIpVB1sWX75U5vTTV3oa5p9Z/20in+NleFaH4IzOZQtXux1tMqRMJ6yZTFF9E+32nK14dwZtBxpYoMKq7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388185; c=relaxed/simple;
	bh=0+P+y+lElXMF3tTwcsU7YJna11M/GeqMe6959eZffXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Qx+B6pKShgCO5+CAsU8EFLZw2Yv3VXUF/V9lG6GR21UX85h98j4wrbA/JikM+w/EmLRFpQ4x7NETyoSnCYzoy42uTCDO2NjrYPZLb2ej7Kd+q3HN6wnx0Az+pKb614X/eM6QvbIq5WPB3hyjHpCNF/QnDbCfSygBNQUMqQ/VIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcWX9SB8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso2039846a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771388184; x=1771992984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+P+y+lElXMF3tTwcsU7YJna11M/GeqMe6959eZffXo=;
        b=ZcWX9SB8QML/eU3/+e63XKDLUbFoS4mTsNdKfZj1SaZ8v7TX94COFQ2ks5y1EI3Lvu
         WVNSZQgyAL2QjeezySiVmW6pQCAou9cvgTpWFBGBtdksRqXoUIehxUxm/cUOjZq53vmF
         pmTSD6vtPvLcpZBgY559DFvkse7lj9kID9AexbOa0hz3y20VqMnZZrYpOTsKLYDJUCOY
         o6L/uoKlxx5E1jpJJLaxwqbOc901387B4NROAXsgY+UZvjWMQx2A47B7aab05Z9LxamD
         tOJBUbDNvxvrS4+G9kYLRe4dckw4ByZvj07tPpZ13I94MtD9OtLaXRWjFc440ovnbLq0
         yK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771388184; x=1771992984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+P+y+lElXMF3tTwcsU7YJna11M/GeqMe6959eZffXo=;
        b=Nw44IMHHd5e+Iy+M3PzBs4gAR2aOAnoeLWXhbazTdfHom2OHaBCpnUEiyVXHgzBaYE
         Hr4YM0cZdduDpVAaS63v0er4OOdQoYHQapmB9Uk9P0wc0BfzMhiKKLDkbiuJrn9KmJcA
         KVqumleuuj+dwowmbqYP4lCSxLoQ76nO+IoDLxgTCT8kzIXCD7v+o0oGuI3WA0haD0nt
         fkG+xjx1dLsYrYs1tdxgBkKbwi14vZJYqAat2nx0rM3EID5pTlZD5AOhoPbDN9E1uECo
         WpOoI/ULGepWdjQ58mbPULltch6oHV4xKsfebJuLx/AP9aa2qAo6WKnPIENj8P82XPfH
         PTsw==
X-Forwarded-Encrypted: i=1; AJvYcCVErMygy6bt4R6w/kkGk+66PYOcNIdW+NJI7WLJakuHtPmWZFGOTmH7sw01Y8HCQowpWP649k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTDoLSvFfaBKuH/qvLnHDGssF1jkrnQL8xghm/Y8QfjNrmnSk
	QrwPQAa3KbVcrGqt+oCLBBCo4O+NRW4qROSCRKFkjSeYnERsH8csKilbbavhEjIl
X-Gm-Gg: AZuq6aILrJ3GXV6DrehbX+vBiNZxP8/KAAChKMQnrMUtu/oPrbHc3sjp6Per463Ilbm
	FysXDKHLH5R5rYaxufqoAGxompSCtZRBM9bg/1Q4JqEaSml88gSFBgLxcMef33AuBYJZzXHXLE0
	kUaOIlaFqnoV17kDwGAMKBsESsi5MTFbf1Wgs/kChhEXpFEeYPLsLW/JRGuKQoO6KVoRuMmAISN
	efeYFIQ5GLbqqbYtXABlZOWyTZ/w3Xld74vFVEsqBKIoBNJkXIP2+2GXMxkn2WXF5bmBZ/1XYMu
	hl4VfxI7+VRHw2KtU2LH9qOEZdkB7mSf1BjokqdHfrZvaknnBUyrvxjDO6uAj/LmmIbombkYgSn
	MMS/PZTbE4YtqygAKn13VqIRceq1i6kjGyQc9TEO1AoXelB5Xy4zmWhQnFFlWJYs8fDpZksnWKA
	DU5HxfwV1UqyWjqJqHxw3t5aQINpuk7ktqeyMrAZ/u3bH6lC9v1Nsh6a0V4s3NepbyMpBcyO2gW
	t4GDSV9pTnopE1JdTpkhGTjBsmyRQW5TJLmXPKH
X-Received: by 2002:a17:902:ce09:b0:2ab:1dad:e500 with SMTP id d9443c01a7336-2ad50e8dd66mr6918255ad.18.1771388184212;
        Tue, 17 Feb 2026 20:16:24 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:c906:adbd:f506:1dbc:e3f3:e38e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a72e444sm123802185ad.34.2026.02.17.20.16.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 20:16:23 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: kuba@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Subject: Re: [PATCH] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
Date: Wed, 18 Feb 2026 09:46:15 +0530
Message-Id: <20260218041615.35817-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,fomichev.me,iogearbox.net,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259199-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anandkrshawheritage@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C33FC152F1E
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 Jakub Kicinski <kuba@kernel.org> wrote:
> Why are you populating netdev with xdpf->dev_rx when the
> bpf_warn_invalid_xdp_action() above did not? Either both or neither should?

Good catch -- the NULL is a pre-existing inconsistency.
Will fix it to use xdpf->dev_rx in v2.

Thanks,
Anand

