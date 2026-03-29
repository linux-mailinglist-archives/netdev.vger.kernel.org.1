Return-Path: <netdev+bounces-272981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEt9AVl7yWmIyQUAu9opvQ
	(envelope-from <netdev+bounces-272981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:19:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C4353C29
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5F9B300293B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F32D0292;
	Sun, 29 Mar 2026 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Yzqi9vRd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XKxdYa0f"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B42C11FE;
	Sun, 29 Mar 2026 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774811987; cv=none; b=emEwK9z/QAJno3MicI8jrWdLcR/gvpMbAQF8sKV08aK14FhJFCwAoqE9ZyMkb9sv4X2iG/EOQIuYb2HKLe5+jml+vH/paMRzxtZIF2Jw8KnqfEFEbHkU/U8bTZS0+9gnwMM4oQ4N2kcYS/IsGOtukj/WFxSDdQ5Vn/EjNlFkyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774811987; c=relaxed/simple;
	bh=zFBeQYVNC8x00m5+sFnrPZHbxYdH+e/c8dDnAvyzjjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvOaLSUc+JbMm8fnQSqJvDc/rVQRM5U4X745YEAiG+GXn90opBcf842AKo0XeygjeewZ83fGKQzG0RYyKNu36vxVqIzfwx6eDigq8vShaHp00HQMBoC7hix9nOChFepCmaatK11qxm805vqeqKdFrs3CWoCe43YkH8Yg9mexLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Yzqi9vRd; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XKxdYa0f; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fkPMf5JcXzB13n;
	Sun, 29 Mar 2026 21:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774811982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFBeQYVNC8x00m5+sFnrPZHbxYdH+e/c8dDnAvyzjjI=;
	b=Yzqi9vRdr3SzSz/PJxm9wPPE7JRSgQ/ZYEkbz/LeBREPvgbdEC7UFd9NxbEugUsljn4fYL
	pOj6qkIAospxyMfvRo6kQNjdIUd4ftfSDEFVn+VUgCHqCtHS81zRAljYkf48SCC5PYgsmS
	/ocNsBuAaZDzezDe7PppuXMBZJ252Hri5QoR8xz0SNVP9VmylqFEWC4bVFFHPob1ygkmJ9
	bkX/SgvP5E7Q5DXRzlBlPAA2iEgulVwZ5oy6fZ95d2pZwfYmFuvCz/gavIzO7P/j6b1vby
	O18mkLocKA3cGulov6qgxyl78VJlMVLmuG5y1OQbHoE8hXv75138BdZAGF+nEg==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774811981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFBeQYVNC8x00m5+sFnrPZHbxYdH+e/c8dDnAvyzjjI=;
	b=XKxdYa0fOj9oVb2kHeHX50gd/ZweDUg0Yk2mZz3rDFqWbpC828eQRWM+tMvtHNJQgdnw2+
	vV+HFhd5dzOumP1fIuRY/oVwb9Wnk62njaNYzf0IzsFhpvvennzcF/6NyDJ6Y+pKAH9ZIL
	9BnJzy/ENYm7xAhpH0OLYRqk89qTaspYi4ML8dvIUJRAzzMT2sWL/p4XB9xb/RnT1HYm+Z
	8g99vA2YkY53PTgUi39lnXtlpfVk5PlxojbK8JhxEoWYFbU4VaIv1rRC48dlb63aAPKfCo
	Ptlat7eWIGDa12/0ZciZESoKzIfAfGld7SN7V+PVTCbgKQEXk++6sovSSaf9tg==
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mashiro.chen@mailbox.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH 0/5] hamradio: mkiss: modernize and clean up mkiss driver
Date: Mon, 30 Mar 2026 03:19:23 +0800
Message-ID: <20260329191923.821284-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260329103508.4905cc09@kernel.org>
References: <20260329103508.4905cc09@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 18kjeg8guodyyrajkz9fgufneradckas
X-MBO-RS-ID: cf6a7534abaa90038c8
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272981-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E87C4353C29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

Thank you for the quick review and for pointing out the Netdev policy
regarding clean-up patches. I apologize for the noise; I was not fully
aware of the specific guidelines for the Netdev subsystem in this regard.

I will respect these guidelines and focus my further contributions on
functional improvements or bug fixes.

Regarding the current series, I understand them do not meet the Netdev
Standard for clean-up patches and I will drop these submissions.

Thank you again for your time and guidance.

Best Regards,
Mashiro Chen

