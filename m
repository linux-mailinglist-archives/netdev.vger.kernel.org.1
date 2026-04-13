Return-Path: <netdev+bounces-277938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMQuAIwz3GlMOAkAu9opvQ
	(envelope-from <netdev+bounces-277938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:06:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4A3E6735
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5E283003342
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD11C69D;
	Mon, 13 Apr 2026 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKh3b9SF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E51CFBA
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776038791; cv=none; b=Wyul6M4qdKZvIZJR2Iv9ITLntdnFnC6HSVGT2bnpfPYiOIXaAIbEzhQQrgXyg7780G3gWEC4wosujWRiCblNReHzhZPvlO6Sk4+7okZAAnwVrkd8AA9y70WoUC5ueN80/6WkzlUcpc0om6Ab4RTJIZboaNPGK6L0BU3ei7zoSNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776038791; c=relaxed/simple;
	bh=cN1O9COQ4H/r3RdSU8pK3htoPaZJP3YrdcpxmdMj1qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsQd/XDGYcH4bTHA/ERH7jgJgDTxT8Po5FI+mH8gJMhSIgNI4F2HAYsr93LHmKtewqfthEmapFQNGSknSOrfZf2bqCen2Eoy1aRbEaqfgLfbAn/OQ73Znvtx+yj5g/UEqnbHHPJkY2AuPjMV/eI5IANXm/Y0uWfHZg925z/vjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKh3b9SF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899d6b7b073so40063076d6.2
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776038789; x=1776643589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN1O9COQ4H/r3RdSU8pK3htoPaZJP3YrdcpxmdMj1qg=;
        b=WKh3b9SFr3e+4q9Px9uOP6rpqGPUd865pQQkPrts+vhtHSSzYIzz/nW/iCKYtQS5w6
         qwq8TViggLwePyzZzctbgALxpx4ISHH2InUrpbjGXTEw5u3gM1A0x1Qg6DAVko8qjvSS
         onHIE/jsV++8PbBWaDPBttOua0Y78uvfdoj69cybEwPCvNtcf0XlW5IvjFPIz2Xma7n4
         aJAzW+Y/OlKMjO/RPG47xU3lrUU8nmuoBIRH68LHQQBgCz1oo31GzWqqxoHUz05wKiii
         95c/nJ0fJR11pVPyeIET2wch+OtamyYxZMXbQaVT5C7fm7oaSvKC6g4y+UIF88lpfXgW
         R53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776038789; x=1776643589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cN1O9COQ4H/r3RdSU8pK3htoPaZJP3YrdcpxmdMj1qg=;
        b=MgHejUPToyRypHc2f0Ce3K/+doa+5eb20A0DV7F4eQHhdSkeze+jc+JMZS3uXpILSc
         sHQDtyV2Wucsv3pzh1LpjyO1xpOpDJm3Hy9oNZdHrBzVfrGIHcW88hmgzui2+AGRAnTP
         mEpRCoym7xFSXbkSzAiQaoo3HJbHQoxpzKk24ktQc+nZol0QpHpqt/THNh3IXRyWJ4lQ
         I6CgcmeHCi1OBBGMejWuXFg4JnkdVKWfYJ5v99QWtQ+4tv/Hvra4oIQnnjtAA07fMedl
         IQRO6U4BHDW/nyLmkppm/mK3KvyMfqzU4DRqB1a/SwjINLJ0ir5+G+7xYTcFhucV8VPn
         vi0g==
X-Gm-Message-State: AOJu0Yz6w79VMzqH1nXDIjFrXZRpjOIdJ4hkQHjAr1KjYpgNlTnR+nZA
	5fsFXt8Sxq0kBkYRlzw0L2SKcOkaEj3ItE44wYNf8nxXcy/svCXFEurC
X-Gm-Gg: AeBDieuMjv5qK7zKcP+Mn3adQWnU1FBkCRUi4x1Vj2V0NWnga9nMoCdPhEmMM/raEuN
	yZ5BZQyaJ7SvKU29sF5sApHKIEq5UKfaTXLtoXuEPRHmuwgMV47s7yNTEfEEMsr04l+WmbLMPRh
	2lGBYKsCgXfsMzRlk9pXYRBeK1vT2d52GJsZczmqOSFSNtCfuVb+Jtd8sks+vx3pOnTgWSDWMn7
	QJz98rEsBjoDnxl7sNpOZ/dzVfZfDiwDYCCT4eFFTFKOFRp9oZfxbtpuyMtpX5GhExKGlyol1Cv
	STmVxYTrhsUlp5JMOFGu5qeIO1taDT0hYoueY6W+HUwkR/UsyHbZ/IMFp9fkV+wpx3SRZiQzWrZ
	WB8WsfgIEXCK400nL5zcczFL+oZH7Kd5xn6oi46vMszknX2oZGmunEuOdgP3xbkCAtbLdnnXl/D
	I2YPP+qrHCl8Kro38oQqbJJp504S3P1r7voGtZj1WVd+16koRfk/mmt9eNtIvzWXyoDRespK/Q0
	6HrTpq6sErb+rER0S8xZMZU0OZW
X-Received: by 2002:a05:6214:4b08:b0:8ac:a4f9:da76 with SMTP id 6a1803df08f44-8aca4f9de89mr63620936d6.26.1776038789393;
        Sun, 12 Apr 2026 17:06:29 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac8aea242fsm71371026d6.34.2026.04.12.17.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 17:06:28 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: hci: fix OOB heap read on short HCP frames
Date: Mon, 13 Apr 2026 00:06:27 +0000
Message-Id: <20260413000627.3273477-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412134218.34cbe88d@kernel.org>
References: <20260412134218.34cbe88d@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277938-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99B4A3E6735
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 13:42:18 -0700 Jakub Kicinski wrote:
> As Eric mentioned elsewhere - he did not suggest any of this,
> merely reviewed your submission.

Agree, that tag was incorrect on my part. Will remove it in the
next version.

> How did a broken packet get enqueued in the first place?

You are right to point that out. nfc_hci_recv_from_llc() already
gates the queue with pskb_may_pull(), so a short skb cannot reach
nfc_hci_msg_rx_work() to begin with. The same holds for the nci
path. Those two checks are redundant and will be dropped in v3.

