Return-Path: <netdev+bounces-197823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB37AD9F59
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 21:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1F77A5B4C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50E2D23A0;
	Sat, 14 Jun 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnyxLXUf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880D1E8320;
	Sat, 14 Jun 2025 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749928412; cv=none; b=DJJc/Vjxv4+F6irdd0oF5JaWIP43rFxMJvGHMrDtNjFtSJua3JibWD8V2rdJVaH7CSSqPhTXU9NJzDQK2Lybt/WTy1B5vailiVDpidzVm2alCGQC39j6/jstkPaWtA9Z4aPzLi73wIyd1YOoBd64F+u0L3UOiJiTcgrv77Fp04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749928412; c=relaxed/simple;
	bh=QcqBRvfJQvc5pYZiDg3HscRZqlrgHExx7Nb5GFswF3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNsoQXlc8RFg4kDUi+xb17bQLH/YjVeYgGWMsgZl/yO/CqiYIZEc3T8TIwf63p8PcvDqDxxV+wWQiKhgDYtkD9mVkF12IEnNkva46+E8SpJQeFLkNkTofU6O42chBkF+kEyU43m08FQEOsz9bpQjZxUe7qSG+FWCDU8xRwZlMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnyxLXUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A57C4CEEB;
	Sat, 14 Jun 2025 19:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749928411;
	bh=QcqBRvfJQvc5pYZiDg3HscRZqlrgHExx7Nb5GFswF3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KnyxLXUfl1AnHsgjB2TzBn9DyyEqxXLUxmGeVkU9mv+wrKp8bwnlGDUxdriOpYwQj
	 vIR5YWEaBwEa+9TnkcMfvImyNNO1S5XE91jB3WyhAZmGIzs2kIQ+2YTPGdbGdg/EkJ
	 mjMlzfsjuPEH5Nt0scCrqob716ABX3gyBKjnh8lIVDAmAKHxOebiZiW2H5Z5Rnn36K
	 rO0GOXqXouJKkCdT1MrQNN/gqa8rmrLPgLcacFpahFw+6p65+ubu2qI4LRjkd1Nd+i
	 KeiWfYu5kS3gjeU67TQwA99wAbaVAsD6P9sw7nikEcgXJCnE92HD43dYuOhb5aAw3Z
	 rlh0Px/ih05oQ==
Date: Sat, 14 Jun 2025 12:13:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 04/13] net: pse-pd: Add support for PSE
 power domains
Message-ID: <20250614121329.7720ff33@kernel.org>
In-Reply-To: <20250610-feature_poe_port_prio-v13-4-c5edc16b9ee2@bootlin.com>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-4-c5edc16b9ee2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 10:11:38 +0200 Kory Maincent wrote:
> +static void __pse_pw_d_release(struct kref *kref)
> +{
> +	struct pse_power_domain *pw_d = container_of(kref,
> +						     struct pse_power_domain,
> +						     refcnt);
> +
> +	regulator_put(pw_d->supply);
> +	xa_erase(&pse_pw_d_map, pw_d->id);
> +}
> +
> +/**
> + * pse_flush_pw_ds - flush all PSE power domains of a PSE
> + * @pcdev: a pointer to the initialized PSE controller device
> + */
> +static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
> +{
> +	struct pse_power_domain *pw_d;
> +	int i;
> +
> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		if (!pcdev->pi[i].pw_d)
> +			continue;
> +
> +		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
> +		if (!pw_d)
> +			continue;
> +
> +		kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release,
> +			       &pse_pw_d_mutex);
> +	}
> +}

AFAIU the release function (__pse_pw_d_release) is supposed to release
the mutex. 

