Return-Path: <netdev+bounces-301697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rm09Ef/5O2rQhAgAu9opvQ
	(envelope-from <netdev+bounces-301697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:38:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE346BFB6C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:38:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mh0mn97N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301697-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301697-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 890A93001A68
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954E30C62D;
	Wed, 24 Jun 2026 15:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EF3B8130
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:34:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315297; cv=none; b=DwWskUiyqT9yKOMxmThL0Tv7plgL1GATpz0gT5FpA/AsICc0ktqw4ffF0gOEsZ+8xBvGuNaMRfJWWtUOeqdP49FHVx/IpH3jx9ki5bLRSmgdXBYNR1gGTG1AXzBMkGmJ/Y8mA/iZCoj29rK8ZoQim19jwvomj/EAmhdAv5jt8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315297; c=relaxed/simple;
	bh=FeGXhUrr7KAwWqca7WaPTlQuO3/AIw6AM+jlNzcvHIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IM+3R8YQlMBZS1thubwtjsRdr1bv2XJSKkgDio7HRsXNu6n8ot03UWaLN2B1bfu08bBJ5zxA2mwbFCipC4+VuC3qXj0Po1qMj7MUQlqEm1vZau8TDHMeaGEUFFKXb+c6umfyp1fvxLgbnhIFRraZ7/9+FJh/gdYk1UEh+tTNf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh0mn97N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA981F000E9;
	Wed, 24 Jun 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782315292;
	bh=FeGXhUrr7KAwWqca7WaPTlQuO3/AIw6AM+jlNzcvHIY=;
	h=Date:From:To:Cc:Subject;
	b=mh0mn97N5LyuDTd+Oh8kqgDg+iqoUorVLwSd9/m6AdkfeAQqQI6aPjTw4KN3IIuKh
	 5EFHWxwPtTAvKTQWrrJydD8Gbcm1stf2DxF2YIr9XVW+kXtd32PAXPUji9tA+LLJLR
	 HUcCg/6Dh7zMuoan9VsxP6rEYiD7ixohKMLX0TvyeEBYw5roqcNYGFJaaOl5B5aFee
	 h+N+BTHdQTuZ2RgEctlLprL8nZP3eSrtBbnks8KAPR/eeUwlPh5sLa1y2UNdaDjFOH
	 cfUdLs1UdqqZRNrZUF7jpU4EO+GQKMhBpE4ZLA/YR+dUMGBUKkHNI2FJIKDBv51HRX
	 GD/juSdXZwDnw==
Date: Wed, 24 Jun 2026 08:34:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Pielech <adrian.pielech@intel.com>, Przemyslaw Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [TEST] GRO on i40e looks off
Message-ID: <20260624083451.2c15b16b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301697-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:adrian.pielech@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FE346BFB6C

Hi!

Looking thru the stability reports GRO tests on i40e stand out.
It's bad across multiple test cases but IPv4 IP ID cases are
a very good example. These tests are solid across all platforms
but on i40e they fail half of the time both in Intel CI and
in netdev CI.

