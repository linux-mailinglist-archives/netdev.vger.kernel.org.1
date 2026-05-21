Return-Path: <netdev+bounces-290194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF+1KH5pDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:10:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874F59DEAD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 326FC3016780
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A7320CAD;
	Thu, 21 May 2026 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dubdhw8z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B23233F4;
	Thu, 21 May 2026 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329403; cv=none; b=KfCMT188ZeZA2J9m9/qjhnrqtglY1Alue7WpQjbKZzddqGIkn2dcL0qucS9TV6IdvnuHP8u4iXYo9RF4A7kqadO0EK5JeTaIrE/pco54/pqwRFXorIicr1Qzqrx8n1IW89eIH2gZ7fpgfqACzc5OIcbpzyWzUQSeo0/P4yYe7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329403; c=relaxed/simple;
	bh=et615VKUp2mJkdNVmODpM1HniXIK74aGvwUMT/4COkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tj3nkVTlxpoPOaLj6XSpdKbEy57JEqPouFxLcVdzWAAAjSF6jZRDE2X+Kh5U4b1MqhkpS7V7dI6gqhO3I0/WqfXsJLXLldM8RnzXoee7PN6+CLpb04m8CPvpm5w+GbTt7/6kBSb54C/XcjnCxeDXet6GhIO/SFWf1wHSsBpIqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dubdhw8z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA931F000E9;
	Thu, 21 May 2026 02:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329402;
	bh=6+qoFVJmwdyvB5EVkiPqQeKzot1eM4j7yIgyIlL2nkA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dubdhw8zP0v/M/JpUXCfMhXuYjvSUArqW8C85b6sz49rpUk4ksnG2/9pbH9EiBkze
	 SkFkJHXN4LLKz0Hq5GDsbS4EtpnKYJs4LkhcLS1B8Egwonqq7v74dbbjVVg+8RAts2
	 1yeg0cydQmYXqHEw35XtQ8vp1DhrZl2RUlQtWaIjEuP8glPOFZr0TcvyBkefwXefEm
	 YX09wuZQTDkOFqSGrjqJ005fKwvTS+W4fZxrg4MjXOCQManBR3fiIWfd9YdMYAFmR3
	 TxPEBiMxCJF9DANCbXgm5iZZnz8gGPh+6hd1VTSYzsRni8E6JVa+Z+aaFRl4N5amw1
	 va5gtVzwmZU8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF83930C38;
	Thu, 21 May 2026 02:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] dpll: zl3073x: fix memory leak on pin registration
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932941239.3832404.17092382705971841087.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:12 +0000
References: <20260519132205.161847-1-ivecera@redhat.com>
In-Reply-To: <20260519132205.161847-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, poros@redhat.com, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-290194-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4874F59DEAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 15:22:05 +0200 you wrote:
> If zl3073x_dpll_pin_register() fails, the allocated pin is not yet
> added to zldpll->pins list. The error path calls
> zl3073x_dpll_pins_unregister() which only iterates pins on the list,
> so the current pin is leaked. Free the pin before jumping to the error
> label.
> 
> Additionally move the pin->dpll_pin = NULL assignment in
> zl3073x_dpll_pin_register() from err_register to the common
> err_pin_get path. When dpll_pin_get() fails, pin->dpll_pin holds an
> ERR_PTR value. Without this fix the subsequent zl3073x_dpll_pin_free()
> would trigger a spurious WARN because it checks pin->dpll_pin for
> non-NULL.
> 
> [...]

Here is the summary with links:
  - [net,v2] dpll: zl3073x: fix memory leak on pin registration failure
    https://git.kernel.org/netdev/net/c/fa997ddef508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



