Return-Path: <netdev+bounces-284783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hjmDOY0X+2l3WgMAu9opvQ
	(envelope-from <netdev+bounces-284783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF04D94E8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 038F4300E707
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716873F54C0;
	Wed,  6 May 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q+TKpOTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25E3F2115;
	Wed,  6 May 2026 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063243; cv=none; b=fMOb9GWopFAgo7rh6Iy9rUuk22oaw19Q20AxeLBsSY8qVAhwRn5gRiu+KWra3q+k+4b7uD8uBdkkYGxf6hzumRTKC7fSBzxtu5Xif/EzeWyT470xB+/SGyb5F9hcHMhpjS3MTznBNg/Cg/H/AwVQdNJCAkvNUbipf76EyHEzKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063243; c=relaxed/simple;
	bh=5uroEs9phCoYBtDMntP9oW+5QHXkldm00TKOjwuiSGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9ulDN2dT22onMAE0eAQxX3WhSA1uW40WlK4X6c3fjZjfnxt0pcfX1TIwb0eXS/N4RcTqiA96wlHAkWiUuLmemKUO9iBh3/dn8Wsm5kpu985GXUM1Kb+Wp9HpFlRxujZeNQY3tpzur6Ckx14Xjry8aLRGHPK+KM43EA9bECrtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q+TKpOTs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8E3F91A3542;
	Wed,  6 May 2026 10:27:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FE076053C;
	Wed,  6 May 2026 10:27:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C7CA102F248F;
	Wed,  6 May 2026 12:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778063237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hZlsHugSqqYOr+1oMZj7vNSBKyOY249Wjj8osuKy56w=;
	b=Q+TKpOTsvphmvT1MAoxsIjZVlD31vswUGAoSdOJv2QxtygooCK752jCpR8AA2NiGWG9J56
	/MIihqOIQ2MRvssGRUwGuTVfwluU726wgvouFFqzOH+kRgegpEncwMqMmm4o4omhzkPjAP
	wvsE3cB49VzLWqK1BtxS9y5z6fLTidrwii21G5FZVZGDiyNEQ2w3rIZYwI2Q+fxR34CGjX
	y66suPsc160/eV26VpKMoPPG2ibyJaJjEXJ8fUaerjfmJndz1Xd9A4xhqcNoqW8heaK+uJ
	VNxBrCPlh6ylsbk0vNgHK9VqnPqklOLU4AulpZTbmR+rPjE1V4fo6mgL7Z/wNw==
Message-ID: <3415b009-69e5-40e2-bd3e-5a05cb7a1442@bootlin.com>
Date: Wed, 6 May 2026 12:27:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: sfp: extend SMBus support
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260505200647.1125311-1-jelonek.jonas@gmail.com>
 <20260505200647.1125311-3-jelonek.jonas@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260505200647.1125311-3-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 4EFF04D94E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]

Hi Jonas,

On 05/05/2026 22:06, Jonas Jelonek wrote:
> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> added SMBus access for SFP modules, but limited it to single-byte
> transfers. As a side effect, hwmon is disabled (16-bit reads cannot be
> guaranteed atomic) and a warning is printed.
> 
> Many SMBus-only I2C controllers in the wild support more than just
> byte access, and SFP cages are often wired to such controllers
> rather than to a full-featured I2C controller -- e.g. the SMBus
> controllers in the Realtek longan and mango SoCs, which advertise
> word access and I2C block reads. Today, they cannot drive an SFP at
> all without falling back to the byte-only path.
> 
> Extend sfp_smbus_read()/sfp_smbus_write() so that, in addition to
> the existing byte access, they also use SMBus word access and SMBus
> I2C block access whenever the adapter advertises them. Both
> directions are handled in a single read and a single write helper
> that pick the largest supported transfer per chunk and fall back as
> needed.
> 
> I2C-block is preferred unconditionally when available: the protocol
> carries any length 1..32, so it can serve every chunk -- including
> the 1- and 2-byte tails -- without help from word or byte access.
> Note that this requires I2C_FUNC_SMBUS_I2C_BLOCK, which reads a
> caller-specified number of bytes. This deviates from the official
> SMBus Block Read (length is supplied by the slave) but is widely
> supported by Linux I2C controllers/drivers.
> 
> Capability matrix this implementation supports:
> 
>   - BYTE only:                  works (unchanged behaviour); 1-byte
>                                 xfers, hwmon disabled.
>   - BYTE + WORD:                word for >=2-byte chunks, byte for
>                                 trailing odd byte.
>   - I2C_BLOCK present (with or
>     without BYTE/WORD):         block as the universal transport for
>                                 every chunk.
>   - WORD only (no BYTE/BLOCK):  accepted with WARN_ONCE. Even-length
>                                 transfers work; odd-length transfers
>                                 (e.g. the 3-byte cotsworks fixup
>                                 write) hit the BYTE branch which the
>                                 adapter does not implement, so the
>                                 xfer returns an error and the
>                                 operation is aborted. No mainline
>                                 I2C driver was found to advertise
>                                 WORD without BYTE; the warning lets
>                                 us learn about it if it ever shows
>                                 up.
> 
> Adapters with asymmetric R/W capabilities (e.g. only READ_I2C_BLOCK
> but not WRITE_I2C_BLOCK) remain functionally correct -- the
> per-iteration fallback uses the direction-specific bits -- but the
> shared i2c_max_block_size is sized by the all-bits-set check, so a
> transfer in the better-supported direction is not upgraded. None of
> the mainline I2C bus drivers surveyed during review advertise such
> asymmetry; promoting i2c_max_block_size to per-direction sizes can
> be revisited if needed.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

This looks great, I've given this some testing and so far it works well :) I do have some comment though :

> ---
>  drivers/net/phy/sfp.c | 134 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 107 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index e58e29a1e8d2..8ad650cbe862 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/slab.h>
> +#include <linux/unaligned.h>
>  #include <linux/workqueue.h>
>  
>  #include "sfp.h"
> @@ -756,50 +757,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>  	return ret == ARRAY_SIZE(msgs) ? len : 0;
>  }
>  
> -static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
> -			       void *buf, size_t len)
> +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> +			  size_t len)
>  {
>  	union i2c_smbus_data smbus_data;
>  	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	size_t this_len, transferred;
> +	u32 functionality;
>  	u8 *data = buf;
>  	int ret;
>  
> -	while (len) {
> -		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> -				     I2C_SMBUS_READ, dev_addr,
> -				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> -		if (ret < 0)
> -			return ret;
> +	functionality = i2c_get_functionality(sfp->i2c);
>  
> -		*data = smbus_data.byte;
> +	while (len) {
> +		this_len = min(len, sfp->i2c_max_block_size);

You should be using sfp->i2c_block_size here and not i2c_max_block_size
to account for the modules that require a specific access size.

> +
> +		if (functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
> +			smbus_data.block[0] = this_len;
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_READ, dev_addr,
> +					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			memcpy(data, &smbus_data.block[1], this_len);
> +			transferred = this_len;
> +		} else if (this_len >= 2 &&
> +			   (functionality & I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_READ, dev_addr,
> +					     I2C_SMBUS_WORD_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			put_unaligned_le16(smbus_data.word, data);
> +			transferred = 2;
> +		} else {
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_READ, dev_addr,
> +					     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			*data = smbus_data.byte;
> +			transferred = 1;
> +		}
>  
> -		len--;
> -		data++;
> -		dev_addr++;
> +		data += transferred;
> +		len -= transferred;
> +		dev_addr += transferred;
>  	}
>  
>  	return data - (u8 *)buf;
>  }
>  
> -static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
> -				void *buf, size_t len)
> +static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> +			   size_t len)
>  {
>  	union i2c_smbus_data smbus_data;
>  	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	size_t this_len, transferred;
> +	u32 functionality;
>  	u8 *data = buf;
>  	int ret;
>  
> +	functionality = i2c_get_functionality(sfp->i2c);
> +
>  	while (len) {
> -		smbus_data.byte = *data;
> -		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> -				     I2C_SMBUS_WRITE, dev_addr,
> -				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> -		if (ret)
> -			return ret;
> +		this_len = min(len, sfp->i2c_max_block_size);
> +
> +		if (functionality & I2C_FUNC_SMBUS_WRITE_I2C_BLOCK) {
> +			smbus_data.block[0] = this_len;
> +			memcpy(&smbus_data.block[1], data, this_len);
> +
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			transferred = this_len;
> +		} else if (this_len >= 2 &&
> +			   (functionality & I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> +			smbus_data.word = get_unaligned_le16(data);
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_WORD_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			transferred = 2;
> +		} else {
> +			smbus_data.byte = *data;
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			transferred = 1;
> +		}
>  
> -		len--;
> -		data++;
> -		dev_addr++;
> +		data += transferred;
> +		len -= transferred;
> +		dev_addr += transferred;
>  	}
>  
>  	return data - (u8 *)buf;
> @@ -815,10 +876,29 @@ static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
>  		sfp->read = sfp_i2c_read;
>  		sfp->write = sfp_i2c_write;
>  		max_block_size = SFP_EEPROM_BLOCK_SIZE;
> -	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
> -		sfp->read = sfp_smbus_byte_read;
> -		sfp->write = sfp_smbus_byte_write;
> -		max_block_size = 1;
> +	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA) ||
> +		   i2c_check_functionality(i2c, I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +		/* I2C-block carries any length 1..32, byte serves the
> +		 * 1-byte tail when block is absent: either alone is a
> +		 * complete transport.
> +		 */
> +		sfp->read = sfp_smbus_read;
> +		sfp->write = sfp_smbus_write;
> +
> +		if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_I2C_BLOCK))
> +			max_block_size = SFP_EEPROM_BLOCK_SIZE;
> +		else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_WORD_DATA))
> +			max_block_size = 2;
> +		else
> +			max_block_size = 1;
> +	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_WORD_DATA)) {
> +		/* Word-only: even-length xfers work; odd-length xfers
> +		 * will error out at i2c_smbus_xfer().
> +		 */
> +		WARN_ONCE(1, "sfp: SMBus word-only adapter; odd-length transfers will fail\n");

I think this WARN_ONCE can be moved directly into the
"else if ()" check


> +		sfp->read = sfp_smbus_read;
> +		sfp->write = sfp_smbus_write;
> +		max_block_size = 2;
>  	} else {
>  		sfp->i2c = NULL;
>  		return -EINVAL;

The rest looks good to me :)

Thanks !

Maxime

