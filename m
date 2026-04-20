Return-Path: <netdev+bounces-279876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPNAK2Vx5mlgwgEAu9opvQ
	(envelope-from <netdev+bounces-279876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:33:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78747432E53
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460BA3060379
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A585C37F758;
	Mon, 20 Apr 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUhZT+Cg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83050379980
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705067; cv=none; b=lIy+1ue4aknpyKwxGOj0+1BgybhbrqCojzoRb5ZoelHLpo8n9lD6YB36uhoZ1QeXXcWpjlJlS4qRtjylgJnCL4kC7hMIaprxKFHmop3XfqfMOtYpvcIsUw6A49YQWQjo3y1KMUQHS471+DNWM29Wt1RtmgKGFGF3OB+4KLDE3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705067; c=relaxed/simple;
	bh=hnLqiUuA8Wfe7PvAAwrdR7vJUTOt1Rmp26QJzmYBlG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDvd4aa0JvJEGx5xSBtObUN2O+ewweFjvsoOm3vrAEsqdjlcjcCr7KNG1y5a8vuAhcUNdACfKIqC/n3w4TNHkAcHgVJlbHX59NzAtCDmqGJkkwEHxSc5O37eOxhm4nCX3AKiWaGLDtL8eKPcSYDHBsGzgTXyGcbtcThtWYNIXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUhZT+Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB29C19425;
	Mon, 20 Apr 2026 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776705067;
	bh=hnLqiUuA8Wfe7PvAAwrdR7vJUTOt1Rmp26QJzmYBlG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUhZT+CgOr9e2W4NrjQqMKkHAUpW/SNn4Uzz8+depaMM6EDGE0auQe2L3od6Hii54
	 Duf9+WBadn9+/AK4gV1qvZcBEYktzItp/mt2sCAcUy1KJReEqFWZJsTHSxZZNxh8Du
	 WM+fjWtp8+uYcTdsqmFtNAOgf/ExT/f0tTztgLW4lRiVIyT7JX4L2uiihGCVSxum9N
	 7cqO3qms331rIR/h54UFeJsyJbKXLegdJbskPVQIRkAAQeJJQJLv7xjY+KIF1mXfTw
	 dMsAdutGpsXP5QxSX6BanWKji8lfFCdsTflBndHzGQlqgTIDvJPDH8hKwU0lLbiP+j
	 tnUq2C7n8fWWQ==
Date: Mon, 20 Apr 2026 10:11:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mISDN: fix socket/device lifetime and naming
 races
Message-ID: <20260420101105.1c5f9fcc@kernel.org>
In-Reply-To: <CANAAWHJKfRVO++ZdXYAKSaTH8JCBi_Xeu4DE-Ldaa6zu2Kub6A@mail.gmail.com>
References: <20260414071322.30851-1-shuvampandey1@gmail.com>
	<cover.1776446840.git.shuvampandey1@gmail.com>
	<CANAAWHJKfRVO++ZdXYAKSaTH8JCBi_Xeu4DE-Ldaa6zu2Kub6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279876-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78747432E53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 19 Apr 2026 06:09:03 +0545 Shuvam Pandey wrote:
> Please ignore v2 for now. I=E2=80=99m reworking the series and will send a
> corrected v3.

Please hold off until Thursday, I'm intending to delete ISDN from the
tree. Please resend if the code still exists in Linus's tree at that
point.

