Return-Path: <netdev+bounces-304892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0CDXAyplS2rJQgEAu9opvQ
	(envelope-from <netdev+bounces-304892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:19:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CC70E06B
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:19:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=m1UTlFor;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304892-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304892-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FA87320A011
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FBC3EB0FE;
	Mon,  6 Jul 2026 07:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D03998B2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 07:28:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322934; cv=none; b=JO5U7A6DezlbLBPV5vA159sb/6jBaCvdFdoeG5MuRTgqegi2lkHKQHruWbHrE/v00hJV4N6y6peGnbfOAJD+gYbXhd9jOjq7i/jhjlaoVyj/yCe/ddiQ6aJc0VbODaiJQDi7C6R1ig1Qv4kJ/k0isUWVtwNjvKFITOJODOhsVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322934; c=relaxed/simple;
	bh=3nC7EDiteJaQsMWkNW7fi42061f/xrNSpCB13TugYHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaNWmgvgnhBZz9j1u2XwAqiFnfHmQc/7LF2VMm1VHaikJjr9xDG7g5DLA+Kzl5SjVrq9E0djb0F8OhWZZswE8jaIkZ30iuHhzYbaM0EUvVyqpSMP4C3uQBHZvQs/0deLz6UzEgcrsm0X5uxZ19X5Wb/JucmbE0/PLSAHKV7G68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m1UTlFor; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 891E11A0E84;
	Mon,  6 Jul 2026 07:28:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 53B88601A2;
	Mon,  6 Jul 2026 07:28:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68D3B11BB9B69;
	Mon,  6 Jul 2026 09:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783322919; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eSOkrYUq282mC0wg3I1U8x+/l24BUAzAh+Eaa//kxMs=;
	b=m1UTlForGyldaeUGWNBaFZLbnmhTb+aSlwg/rkT4svQqH/wVLWm9p57VLvqZLdUuVRDdkC
	WSe6euYvurFrP9Z94G/M1vY6/rwmVHPz/BsIiGdpyF/JEkdVM1zVIwK0TrNjYw+BzC0QOz
	JJka+y5xre6GCHTeZGiQvnr0tlVjhVxaxDKRXliq5y/9ph2kdEtzjzUPSjXnZkFZ+VbdVI
	MkQjCzUuWOSbmOGXTevJ717cKh6vzft2PlAohmb+tusrLBQYSUc7bB6jYpBWIeDca+uQmq
	sTIq7M/HYQTo8N1oq7bHpajBqtpmyO/9nLOBSFVn2nJNDio1aDLAvgup3F5dEw==
Message-ID: <e90fe206-7b19-4445-b4b2-ab276a745105@bootlin.com>
Date: Mon, 6 Jul 2026 09:28:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: sfp: allow prefix matching in quirk
 lookup
To: Martino Dell'Ambrogio <tillo@tillo.ch>, netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260705185440.136496-1-tillo@tillo.ch>
 <20260705185440.136496-2-tillo@tillo.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260705185440.136496-2-tillo@tillo.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304892-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tillo@tillo.ch,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tillo.ch:email,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A34CC70E06B

Hi,

On 7/5/26 20:54, Martino Dell'Ambrogio wrote:
> Some clone SFP modules (notably XGS-PON ONT sticks) ship malformed
> EEPROMs where the vendor PN field is filled with non-printable garbage
> past the trailing legitimate characters instead of SFF-8472 mandated
> space padding.

:(

> The current sfp_match() requires an exact full-field
> length match: sfp_strlen() returns 16 (no trailing spaces or NULs to
> strip), but strlen() of the quirk string is shorter, so the length
> comparison rejects the entry before strncmp() is even called and the
> quirk silently never applies. The kernel then honors the module's
> spurious TX_FAULT signal and the SFP state machine eventually disables
> the module.
> 
> Add a prefix_match flag to struct sfp_quirk and a SFP_QUIRK_F_PREFIX
> macro. When set, sfp_match() compares only strlen() leading bytes of
> the quirk string, ignoring trailing field bytes. Existing exact-match
> quirks are unaffected (prefix_match defaults to false via zero-init in
> the existing SFP_QUIRK macros).
> 
> Signed-off-by: Martino Dell'Ambrogio <tillo@tillo.ch>
> ---
>  drivers/net/phy/sfp.c | 22 +++++++++++++++++-----
>  drivers/net/phy/sfp.h |  1 +
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index f520206..e7ba642 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -516,6 +516,13 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
>  	{ .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
>  #define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
>  #define SFP_QUIRK_F(_v, _p, _f) SFP_QUIRK(_v, _p, NULL, _f)
> +/* Like SFP_QUIRK_F, but matches as a prefix. Use for clone modules
> + * that fill EEPROM trailing bytes with garbage instead of the
> + * SFF-8472-mandated space padding, so sfp_strlen can't trim the
> + * field down to the legitimate length.
> + */
> +#define SFP_QUIRK_F_PREFIX(_v, _p, _f) \
> +	{ .vendor = _v, .part = _p, .support = NULL, .fixup = _f, .prefix_match = true }
>  
>  static const struct sfp_quirk sfp_quirks[] = {
>  	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
> @@ -626,13 +633,16 @@ static size_t sfp_strlen(const char *str, size_t maxlen)
>  	return size;
>  }
>  
> -static bool sfp_match(const char *qs, const char *str, size_t len)
> +static bool sfp_match(const char *qs, const char *str, size_t len, bool prefix)
>  {
> +	size_t qs_len;
> +
>  	if (!qs)
>  		return true;
> -	if (strlen(qs) != len)
> +	qs_len = strlen(qs);
> +	if (prefix ? qs_len > len : qs_len != len)
>  		return false;
> -	return !strncmp(qs, str, len);
> +	return !strncmp(qs, str, qs_len);
>  }

The variable naming qs_len and the "if(<ternary operator>)" aren't very easy
to process. It's correct but could use a few comments to explain that for
prefix match, we only compare up to the PN/Vendor string length.

But there's already a good comment on the macro definition, I'm personally
OK with this.

>  
>  static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
> @@ -645,8 +655,10 @@ static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
>  	ps = sfp_strlen(id->base.vendor_pn, ARRAY_SIZE(id->base.vendor_pn));
>  
>  	for (i = 0, q = sfp_quirks; i < ARRAY_SIZE(sfp_quirks); i++, q++)
> -		if (sfp_match(q->vendor, id->base.vendor_name, vs) &&
> -		    sfp_match(q->part, id->base.vendor_pn, ps))
> +		if (sfp_match(q->vendor, id->base.vendor_name, vs,
> +			      q->prefix_match) &&
> +		    sfp_match(q->part, id->base.vendor_pn, ps,
> +			      q->prefix_match))
>  			return q;
>  
>  	return NULL;
> diff --git a/drivers/net/phy/sfp.h b/drivers/net/phy/sfp.h
> index 879dff7..867e45e 100644
> --- a/drivers/net/phy/sfp.h
> +++ b/drivers/net/phy/sfp.h
> @@ -12,6 +12,7 @@ struct sfp_quirk {
>  	void (*support)(const struct sfp_eeprom_id *id,
>  			struct sfp_module_caps *caps);
>  	void (*fixup)(struct sfp *sfp);
> +	bool prefix_match;
>  };
>  
>  struct sfp_socket_ops {

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

