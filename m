Return-Path: <netdev+bounces-295010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pT+/HUXaIGr78QAAu9opvQ
	(envelope-from <netdev+bounces-295010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:52:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DEE63C4A4
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=msAiTRUt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295010-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295010-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F8D301CF9A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E85A281532;
	Thu,  4 Jun 2026 01:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42779242D6C;
	Thu,  4 Jun 2026 01:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537840; cv=none; b=eTBFRHziK/OJ/yABMmNbwoe0VoVKe3/NKX2ON2VOOEpbrrv2k5v/ckver60e43azHNQLnzXOertWGRyGWoy+m1zauaN9ix3jsIMxoVVDMaGw6cTThAzfSsD80LvZLDVOJ2ByIb4txgFlL4/E7VSmn0ozznI1HAK+D6pl/sVd6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537840; c=relaxed/simple;
	bh=4d4FKeLGhzRYRcMtTh8ANGrfqNeU0zSqFOpFk//IBU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6SM6L+bzyYkxo2eJ31JSOoYwCcgPCycyszYAtwlz3Jws269PK/wnS7Po3TR4FhUNgP9UUcXiY4DFKFewPCnJC24Hh3kj9fnlKc3jOjNk0rAE59dNHxzgRAaFNA7PX/AalOSIAc16KEfK+DtS6i4e14dAH4mI3FxFqah7oj4afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msAiTRUt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D33D1F00893;
	Thu,  4 Jun 2026 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780537838;
	bh=WIk/bu2+rOSo+7IeghZDBGuhnmk/8IslE1AEZgNlpvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=msAiTRUtIkRWS8+SPirzDuA7Ch1xnxJq3G+o7Cz7MQg/M1GERqbP6QFJDfLMY8oL2
	 MrwwERGbLoQ02EYyfhH0JpS79z9EzJyskJuGJfzV2HbF1OJYE+t2idCzIl/eBGwJHe
	 frkGSPt4AuK7zhDSs1IJ6t3V6K2puTfx7G9pXtqUaS6oIZWoTtRDeohe84Yfo2K7jh
	 7hM2C4hPfb9EzVAqDi7aaHqg2EVcEnl5LK2o//09P9YXNyH6S2mtm/RU/6dNzz+sES
	 an9pvdgilaANV5ocAhaUTyI+rTiE2Mdq7xh0drmYXdJCMLCkLQK4ukN39jRizJHaTg
	 H1wS6lEO1qqUQ==
Date: Wed, 3 Jun 2026 18:50:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jiri Pirko
 <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>, Petr Oros
 <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Grzegorz Nitka
 <grzegorz.nitka@intel.com>
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin
 type
Message-ID: <20260603185037.05f8c6a0@kernel.org>
In-Reply-To: <20260531194423.383366-2-ivecera@redhat.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
	<20260531194423.383366-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295010-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:ivecera@redhat.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:grzegorz.nitka@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,resnulli.us,microchip.com,kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9DEE63C4A4

On Sun, 31 May 2026 21:44:20 +0200 Ivan Vecera wrote:
> Add DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
> the NCO mode of a DPLL. When connected as a DPLL input, the DPLL
> enters NCO mode where the output frequency is adjusted by the host
> via the PTP clock interface.
> 
> Update the fractional-frequency-offset and fractional-frequency-
> offset-ppt attribute documentation to note that for INT_NCO pins
> these attributes represent the DPLL's current output frequency
> offset from its nominal frequency.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Purely going on intuition here but feels like NCO should be a mode
(enum dpll_mode) rather than one of the input pins?

More acks here would be great, Vadim, Arkadiusz, Grzegorz... ?

> v2:
>   - Clarify int-nco pin type documentation to describe frequency
>     control via the PTP clock interface instead of generic "controlled
>     by the host".
>   - Tighten FFO attribute documentation for INT_NCO pins to describe
>     the DPLL's output frequency offset from nominal frequency.
>   - Mention both fractional-frequency-offset (PPM) and
>     fractional-frequency-offset-ppt attributes in the commit message.
> ---
>  Documentation/netlink/specs/dpll.yaml | 13 +++++++++++++
>  drivers/dpll/dpll_nl.c                |  2 +-
>  include/uapi/linux/dpll.h             |  4 ++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index 91a172617b3a9..5cdb93e8649a0 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -162,6 +162,13 @@ definitions:
>        -
>          name: gnss
>          doc: GNSS recovered clock
> +      -
> +        name: int-nco
> +        doc: |
> +          Device internal numerically controlled oscillator.
> +          When connected as a DPLL input, the DPLL enters NCO mode
> +          where the output frequency is adjusted by the host via
> +          the PTP clock interface.
>      render-max: true
>    -
>      type: enum
> @@ -453,6 +460,9 @@ attribute-sets:
>            offset on the media associated with the pin. Inside
>            the pin-parent-device nest it represents the frequency
>            offset between the pin and its parent DPLL device.
> +          For pins of type PIN_TYPE_INT_NCO this represents
> +          the DPLL's current output frequency offset from its
> +          nominal frequency.
>            Value is in PPM (parts per million).
>            This is a lower-precision version of
>            fractional-frequency-offset-ppt.
> @@ -499,6 +509,9 @@ attribute-sets:
>            offset on the media associated with the pin. Inside
>            the pin-parent-device nest it represents the frequency
>            offset between the pin and its parent DPLL device.
> +          For pins of type PIN_TYPE_INT_NCO this represents
> +          the DPLL's current output frequency offset from its
> +          nominal frequency.
>            Value is in PPT (parts per trillion, 10^-12).
>            This is a higher-precision version of
>            fractional-frequency-offset.
> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
> index b1d9182c7802f..2dab99202764f 100644
> --- a/drivers/dpll/dpll_nl.c
> +++ b/drivers/dpll/dpll_nl.c
> @@ -61,7 +61,7 @@ static const struct nla_policy dpll_pin_id_get_nl_policy[DPLL_A_PIN_TYPE + 1] =
>  	[DPLL_A_PIN_BOARD_LABEL] = { .type = NLA_NUL_STRING, },
>  	[DPLL_A_PIN_PANEL_LABEL] = { .type = NLA_NUL_STRING, },
>  	[DPLL_A_PIN_PACKAGE_LABEL] = { .type = NLA_NUL_STRING, },
> -	[DPLL_A_PIN_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 5),
> +	[DPLL_A_PIN_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 6),
>  };
>  
>  /* DPLL_CMD_PIN_GET - do */
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index cb363cccf2e2a..9245827de3cfd 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -127,6 +127,9 @@ enum dpll_type {
>   * @DPLL_PIN_TYPE_SYNCE_ETH_PORT: ethernet port PHY's recovered clock
>   * @DPLL_PIN_TYPE_INT_OSCILLATOR: device internal oscillator
>   * @DPLL_PIN_TYPE_GNSS: GNSS recovered clock
> + * @DPLL_PIN_TYPE_INT_NCO: Device internal numerically controlled oscillator.
> + *   When connected as a DPLL input, the DPLL enters NCO mode where the output
> + *   frequency is adjusted by the host via the PTP clock interface.
>   */
>  enum dpll_pin_type {
>  	DPLL_PIN_TYPE_MUX = 1,
> @@ -134,6 +137,7 @@ enum dpll_pin_type {
>  	DPLL_PIN_TYPE_SYNCE_ETH_PORT,
>  	DPLL_PIN_TYPE_INT_OSCILLATOR,
>  	DPLL_PIN_TYPE_GNSS,
> +	DPLL_PIN_TYPE_INT_NCO,
>  
>  	/* private: */
>  	__DPLL_PIN_TYPE_MAX,


