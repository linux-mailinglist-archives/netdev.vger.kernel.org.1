Return-Path: <netdev+bounces-260237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI0/DnXTnGkJLAQAu9opvQ
	(envelope-from <netdev+bounces-260237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:23:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF06217E44E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D481630263F4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31A437882A;
	Mon, 23 Feb 2026 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7XZnINy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4B352F9B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885425; cv=none; b=EmT1T2udxwK4stNRtSlcbyzyMBVnspxS797ozTu9X2WDgS9RTQKTTUyZgwX/qRaegRYZ0iPLQvo+nhSh46MIzEsVJ9qsACNPPRYKkjogv4cb6B0zPZgNYJ7RuF1nQJ7TOfjxeJwd97rBopj7ajCkXj+lmXlWtPyseK/nHVCwyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885425; c=relaxed/simple;
	bh=r+zYQuR+IhIEk/lN5WufLgjwbRfegNXzbfu8KsNPI0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMFh217EvnHs7i908OkSKXlEBV7y8roUja5oNC7xWAhL5vcOYOk8Bimf75IHfnPocHTYHIjOvBsGzEoKOR0GosfNLPIBoKZlzPmqxWXfGLSRawME6rgrduRPeVGFVZAxhKnNT8OWd74B2eGg7w1CyW2TdevXjGxwW814Gzg1Wy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7XZnINy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402B1C116C6;
	Mon, 23 Feb 2026 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885425;
	bh=r+zYQuR+IhIEk/lN5WufLgjwbRfegNXzbfu8KsNPI0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7XZnINyKAN6L1+E6TRRgGtq6cF2jpJosfe0Ws31Ek6lXdj1o7V0vZC1OYHglahZG
	 9IK3UeCkxIZZ7+8KbtDJLJD6SSQQiJobiWutk2EWI4aagCVzdw9aep8NW1tNK/B3iR
	 HZ/qTDvf4GnL0Ee6shULxcstSXCC+Z1i55ZbpKUupucdrb4fmHUiIFIJa+F1L0yE/M
	 b3WgJpXGr5QBu9hV7EDbFkHlFf9F0mb1fVmImqRU5HScli3EP2ZZK7BVq78ykDcZj3
	 ktJ916mco8HwyDioyH7sS3dKlUk3Bqvo3V/rjOzeJqGDsZFcNmHDFQrgVrdFzjyzaH
	 wGKp4YiAU8dfA==
Date: Mon, 23 Feb 2026 14:23:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Shantiprasad Shettar
 <shantiprasad.shettar@broadcom.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 17/62] bnxt_en: Make bnxt_resume() easier to analyze
Message-ID: <20260223142344.62457ab3@kernel.org>
In-Reply-To: <20260223214950.2153735-18-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
	<20260223214950.2153735-18-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260237-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DF06217E44E
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 13:49:05 -0800 Bart Van Assche wrote:
> Pass the same argument to netdev_lock() and netdev_unlock(). This patch
> prepares for enabling the Clang thread-safety analysis functionality. No
> functional change intended.

Please split out the 13(?) netdev patches to a separate series.
If you CC us on a subset of the series out CI will not test it.
Please keep in mind that we ask to wait at least 24h between
resubmissions
-- 
pw-bot: cr

