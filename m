Return-Path: <netdev+bounces-299669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1yJWMUqRMGruUQUAu9opvQ
	(envelope-from <netdev+bounces-299669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:56:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C617368AAEB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:56:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kymMV65v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299669-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299669-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1A5E300692A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0836DA03;
	Mon, 15 Jun 2026 23:56:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6C36CE10;
	Mon, 15 Jun 2026 23:56:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567813; cv=none; b=pot/6hEB905xenNgav2vSOl0CkVJ+yNomimoGo7nSYkCHKrvHnQUL7JNGh4Y2H22QBEvkplQkUpQBpbfzHea3l0kAqyq3O3ksL9CVInTQDQkRXOb2E3bsSVI92W7oOo4sVrwQ+v1g/XygbjIoz1pSZv+r50IXpG8CcNyIKN25jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567813; c=relaxed/simple;
	bh=LJtK9mZM7kywa2rPFq3gYAKpF8+eYnFVeg2Ecwt1OU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3zUJPNSkslca7vkj1DGdlQkVotMPtFEeNZP3FFag23QzWIKGvakAQLS+Zv0vzmkTHGcKKSUMaHJgUqECZw108rslcNSo5mr0rQpTRR+qXPnU5xAlZ1F12+bbfPp15+wJTplWPpfdGvDvjIVp0l9RhL/3T/hCjAI8Ok7D01jHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kymMV65v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6311F000E9;
	Mon, 15 Jun 2026 23:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567812;
	bh=lJEnxYGCbj5TvE1QVpgrLjoHAqGb8zTkxlQcMAr3Mig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kymMV65vyu5+28IZrhslIGMndd1tbyO2pRIHwA8OvR/XcWwZyOu922lY3xxiesC5h
	 nNEc553Wo/AmWZ/w+wXm06HfQw9BEX2VGQKNkMpzwTr+c4O+fyg4pzNFtA1eIjTDBS
	 op3wV7lBYkR12fZAw5YLpvbkZrIYMiDVH+k89T/qxL+rb1iWy+pgGT1Yy6X8tAP2gx
	 SYz31a6Yt3F0jcSXSkJFxMEe/S1N9330yBfItlAA+R8jr048bdDaugarWPFZ6TzZzs
	 S7n/ecuxY/pE1dLYa4UJzJSNzCroYSMveax6meWUL6rJVp8QlDk91kgPEnPG1yh68n
	 hyjVXOJOiPzPA==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	chester.a.unal@arinc9.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 5/8] net: dsa: mt7530: replace mt7530_read with regmap_read
Date: Mon, 15 Jun 2026 16:56:49 -0700
Message-ID: <20260615235649.1060736-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <c6fc9cfae9762bf8d8a136339c91d4a76a307355.1781312667.git.daniel@makrotopia.org>
References: <c6fc9cfae9762bf8d8a136339c91d4a76a307355.1781312667.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:kuba@kernel.org,m:chester.a.unal@arinc9.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C617368AAEB

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: mt7530: replace mt7530_read with regmap_read

This commit removes the mt7530_read() wrapper and converts every caller
to use regmap_read() directly. The WARN_ON_ONCE / dev_err and the
return-zero-on-failure behaviour the wrapper provided are dropped.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index fe7e4ab5ae9c..4168adca949f 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -152,28 +152,15 @@ core_clear(struct mt7530_priv *priv, u32 reg, u32 val)
>  
>  
>  static u32
> -mt7530_read(struct mt7530_priv *priv, u32 reg)
> +mt7530_mii_poll(struct mt7530_dummy_poll *p)
>  {
> -	int ret;
>  	u32 val;
>  
> -	ret = regmap_read(priv->regmap, reg, &val);
> -	if (ret) {
> -		WARN_ON_ONCE(1);
> -		dev_err(priv->dev,
> -			"failed to read mt7530 register\n");
> -		return 0;
> -	}
> +	regmap_read(p->priv->regmap, p->reg, &val);
>  
>  	return val;
>  }

[Medium]
The old wrapper guaranteed val == 0 on failure. The new mt7530_mii_poll()
declares val without an initializer and ignores the regmap_read() return
code, so on a failed underlying transfer val is whatever was on the stack.

Looking at drivers/net/dsa/mt7530-mdio.c::mt7530_regmap_read():

    ret = bus->write(bus, priv->mdiodev->addr, 0x1f, page);
    if (ret < 0)
        return ret;

    lo = bus->read(bus, priv->mdiodev->addr, r);
    hi = bus->read(bus, priv->mdiodev->addr, 0x10);

    *val = (hi << 16) | (lo & 0xffff);

When the page-select write fails, *val is not written. mt7530_mii_poll()
is the polling callback used by readx_poll_timeout() in mt7530_fdb_cmd(),
mt7530_vlan_cmd(), mt7530_setup() and mt7531_setup() with predicates
such as val != 0 (post-reset stability), !(val & ATC_BUSY) and
!(val & VTCR_BUSY).

Previously a broken MDIO transport produced val == 0 and the post-reset
poll deterministically timed out. Can the new code spuriously satisfy
the val != 0 predicate from an uninitialized stack slot, then feed that
same garbage into (val & MT7530_XTAL_MASK) to choose 25/40 MHz settings
in mt7530_pll_setup()?

> @@ -365,9 +354,9 @@ mt7531_pll_setup(struct mt7530_priv *priv)
>  	u32 hwstrap;
>  	u32 val;
>  
> -	val = mt7530_read(priv, MT7531_CREV);
> -	top_sig = mt7530_read(priv, MT7531_TOP_SIG_SR);
> -	hwstrap = mt7530_read(priv, MT753X_TRAP);
> +	regmap_read(priv->regmap, MT7531_CREV, &val);
> +	regmap_read(priv->regmap, MT7531_TOP_SIG_SR, &top_sig);
> +	regmap_read(priv->regmap, MT753X_TRAP, &hwstrap);

[Medium]
Same concern applies to all the read-modify-write sequences in
mt7531_pll_setup(), e.g.:

    regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
    val &= ~EN_COREPLL;
    regmap_write(priv->regmap, MT7531_PLLGP_EN, val);

If regmap_read() fails, val is uninitialized and is then OR'd / AND'd
with constants and written straight back into PLLGP / COREPLL control
registers. Was there a reason to drop the wrapper's return-zero (and
WARN_ON_ONCE / dev_err) behaviour without either initializing these
locals to 0 or checking the return code?

> @@ -1010,7 +999,7 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
>  
>  	mutex_lock(&priv->reg_mutex);
>  
> -	val = mt7530_read(priv, MT753X_MTRAP);
> +	regmap_read(priv->regmap, MT753X_MTRAP, &val);

[Low]
mt7530_setup_port5() declares val as int, but regmap_read()'s third
parameter is unsigned int *. The previous code hid this through the
u32 return of mt7530_read() and an implicit assignment conversion;
the direct call now passes &val with mismatched signedness. Should this
be u32 val; like the other call sites in this file (sparse and
-Wpointer-sign would flag this)?

> @@ -2436,7 +2435,7 @@ mt7530_setup(struct dsa_switch *ds)
>  		return ret;
>  	}
>  
> -	id = mt7530_read(priv, MT7530_CREV);
> +	regmap_read(priv->regmap, MT7530_CREV, &id);
>  	id >>= CHIP_NAME_SHIFT;
>  	if (id != MT7530_ID) {
>  		dev_err(priv->dev, "chip %x can't be supported\n", id);

[Medium]
The chip-ID gating in mt7530_setup() and mt7531_setup() was previously
deterministic-fail on MDIO read errors (id == 0 after the wrapper).
With id now uninitialized on failure, can this check spuriously match
or mismatch on garbage and either mis-bind a wrong-id chip or refuse a
real one?

> @@ -2690,7 +2689,7 @@ mt7531_setup(struct dsa_switch *ds)
>  	/* MT7531AE has got two SGMII units. One for port 5, one for port 6.
>  	 * MT7531BE has got only one SGMII unit which is for port 6.
>  	 */
> -	val = mt7530_read(priv, MT7531_TOP_SIG_SR);
> +	regmap_read(priv->regmap, MT7531_TOP_SIG_SR, &val);
>  	priv->p5_sgmii = !!(val & PAD_DUAL_SGMII_EN);

[Medium]
And here, p5_sgmii is set from val & PAD_DUAL_SGMII_EN after an
unchecked read; if the read fails, would this latch a wrong p5_sgmii
state from stack contents and then drive different mt7531_pll_setup()
vs. GPIO mode programming below?

The commit message says:

    The WARN_ON_ONCE error logging is dropped as regmap provides its
    own error handling.

Is that accurate for this driver? regmap_read() does not zero *val on
error and does not log; with all new call sites discarding the return
value, the converted paths appear to have no error handling at all,
which seems like a behavioural regression compared to the prior
wrapper. Would initializing the affected locals to 0 (matching the
old return-zero-on-failure semantics), or checking the regmap_read()
return code at the sites that derive subsequent hardware programming
(chip ID, XTAL select, PLL RMW, post-reset poll), be appropriate here?
-- 
pw-bot: cr

