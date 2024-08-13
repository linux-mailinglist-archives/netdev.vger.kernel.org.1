Return-Path: <netdev+bounces-118005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39869503C0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261CC1F2275B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370141990BB;
	Tue, 13 Aug 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6DHWpY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C0198E90;
	Tue, 13 Aug 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548853; cv=none; b=TbIK6aMKiQ13IQ6SmxFfUF4234DOdZSOcA6tv2KQHn3No5DOqzYIWciJtxow2Zo9I45U6CiSD5Q6t5vj0ACeOhmA9VsHfE96RcZUBPBCLRz9sBoNCdoQJ6QEoU4tbMzhfu4FpWWApq/bHnfmQjMzbVcqdF/VNSSLbyQLKR7Xwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548853; c=relaxed/simple;
	bh=2DJCosDzcUDolj/tK96nNC4qhoUEoVo8FvfKAbVWBC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJAKRUDsMIEMPmKGakJdEtk7lT9xqMD1meSSX0HxWBc0FolNZKvP9KzWSQShmKuo67ZDpZ9RblkYue/E+IDgEdbLA4y3EZ1v0xWWf0MX80kGOiGYhZp1UQUvgtBKhh+OC5CD62c0t0BLsCJ9+9wwKXXEbm6b/tjkE/fhvO6EywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6DHWpY4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso41341645e9.1;
        Tue, 13 Aug 2024 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723548849; x=1724153649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0eWLTuKbirGiqkpxqRewLWPNs7IRhY6QQeXDJp7JMU=;
        b=m6DHWpY41FrBTJsdi1dGyPkQWhpP9MB1tSPXm0pLTlWNRXtNOu1Ib0CZyY/HDuAOuv
         reig2FogfYXb6egrUS+jbl5yuBf8xHfIG4ysFHpwGAatI85Q8XknmRWw66qJYnaTAtfu
         s3gI1DEPq7P05FDmGsJFut85MdjaZQI/xhV4CmjQwce+ChCiYvFD4iqOS0g3PhUnM+rx
         33NJNONetGDoiszAXGPZeYQmIIvJutS1nIdHjAmb+32bUIvhTR1F5j2kyj74evmbs8tb
         gspIopm+xV6IZZWIMUvF+pbu6HqdCzN72+Ux2nNNVt3a8S2uxAG8kPtRacaJC4Wkjd1Z
         kZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723548849; x=1724153649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0eWLTuKbirGiqkpxqRewLWPNs7IRhY6QQeXDJp7JMU=;
        b=Y3Z6j7cDaVU3tH3ZDsofgOoyI1TQ/+L3DYbTvco9jOfDq8d7XMiRaN7iWpdhl7XzaF
         zmeQNUJasJinAsoxPBDwHeTVN7Pr2GZP+X/ZILlyVpfSYVmMhVo4OoRBW3MlXM4wc67C
         wTQZUTfegHCprMWThmcDh2eQYlZlIL0GxukNU0VNLXSAV6CEb0kH+S/l5tkvLas7W0FS
         D+pfi6tQrFQ75wsRRX2nj6htUZaIIuu1o+pAfjjTTS3mIAFELXpbhRDNmoOnqqAEQ09w
         Mg1zdpr2M6YLRC2UOR/By09lOafkKJYkYEC4+WjWwEX8IVtvz+a7SNYeWFJMaoyB1OG2
         BcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtutQN4dOVCIlDILrZSxycuC6NWRdtPkzk9Amn6vS2u4tk9eSXwE4A3Wc0ZfG7tp/wbRFwvnokbGK3PqcTuOOXy/xnZIMf/eceh+N3
X-Gm-Message-State: AOJu0YxdlIKojB3PMJVAJ4tDWYGiGayUbNjbd7b/cSMaj+7rXI1MEBlv
	gBIC4iypFNwoEOzmYAIFXqxPrJ9O1A2f1LP8rtF8JW5fHf6/kcGe
X-Google-Smtp-Source: AGHT+IEPzHL/+PAmJq8gVnlaVVs9VmpfGrYOdrV2DeJaPy2+yiUqOYZZR8Y/pYofNUr0fkGzf7tC2Q==
X-Received: by 2002:a05:600c:4e87:b0:426:5216:3247 with SMTP id 5b1f17b1804b1-429d47f43c5mr21606945e9.6.1723548848927;
        Tue, 13 Aug 2024 04:34:08 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77510asm229422805e9.33.2024.08.13.04.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 04:34:08 -0700 (PDT)
Date: Tue, 13 Aug 2024 14:34:05 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: vsc73xx: implement FDB operations
Message-ID: <20240813113405.a65caznayd2tsx2v@skbuf>
References: <20240811195649.2360966-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811195649.2360966-1-paweldembicki@gmail.com>

On Sun, Aug 11, 2024 at 09:56:49PM +0200, Pawel Dembicki wrote:
> This commit introduces implementations of three functions:
> .port_fdb_dump
> .port_fdb_add
> .port_fdb_del
> 
> The FDB database organization is the same as in other old Vitesse chips:
> It has 2048 rows and 4 columns (buckets). The row index is calculated by
> the hash function 'vsc73xx_calc_hash' and the FDB entry must be placed
> exactly into row[hash]. The chip selects the row number by itself.

You mean "selects the bucket" maybe?

> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 302 +++++++++++++++++++++++++
>  drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
>  2 files changed, 304 insertions(+)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index a82b550a9e40..7da1641b8bab 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -46,6 +46,8 @@
>  #define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
>  
>  #define CPU_PORT	6 /* CPU port */
> +#define VSC73XX_NUM_FDB_RECORDS	2048

Terminology issue perhaps, but do you call a "record" as something that
holds 1 FDB entry, or 4? There should be 2048 * 4 records, and 2048 "rows"?

There's also vsc73xx_port_read_mac_table_entry(), which calls an FDB
"entry" an array of 4 addresses. Do you have a consistent name for a
switch data structure that holds a single address?

> +#define VSC73XX_NUM_BUCKETS	4
>  
>  /* MAC Block registers */
>  #define VSC73XX_MAC_CFG		0x00
> @@ -197,6 +199,21 @@
>  #define VSC73XX_SRCMASKS_MIRROR			BIT(26)
>  #define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
>  
> +#define VSC73XX_MACHDATA_VID			GENMASK(27, 16)
> +#define VSC73XX_MACHDATA_VID_SHIFT		16
> +#define VSC73XX_MACHDATA_MAC0_SHIFT		8
> +#define VSC73XX_MACHDATA_MAC1_SHIFT		0
> +#define VSC73XX_MACLDATA_MAC2_SHIFT		24
> +#define VSC73XX_MACLDATA_MAC3_SHIFT		16
> +#define VSC73XX_MACLDATA_MAC4_SHIFT		8
> +#define VSC73XX_MACLDATA_MAC5_SHIFT		0
> +#define VSC73XX_MAC_BYTE_MASK			GENMASK(7, 0)
> +
> +#define VSC73XX_MACTINDX_SHADOW			BIT(13)
> +#define VSC73XX_MACTINDX_BUCKET_MASK		GENMASK(12, 11)
> +#define VSC73XX_MACTINDX_BUCKET_MASK_SHIFT	11
> +#define VSC73XX_MACTINDX_INDEX_MASK		GENMASK(10, 0)
> +
>  #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
>  #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
>  #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
> @@ -204,6 +221,7 @@
>  #define VSC73XX_MACACCESS_VALID			BIT(10)
>  #define VSC73XX_MACACCESS_LOCKED		BIT(9)
>  #define VSC73XX_MACACCESS_DEST_IDX_MASK		GENMASK(8, 3)
> +#define VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT	3
>  #define VSC73XX_MACACCESS_CMD_MASK		GENMASK(2, 0)
>  #define VSC73XX_MACACCESS_CMD_IDLE		0
>  #define VSC73XX_MACACCESS_CMD_LEARN		1
> @@ -329,6 +347,13 @@ struct vsc73xx_counter {
>  	const char *name;
>  };
>  
> +struct vsc73xx_fdb {
> +	u16 vid;
> +	u8 port;
> +	u8 mac[6];

u8 mac[ETH_ALEN]

> +	bool valid;
> +};
> +
>  /* Counters are named according to the MIB standards where applicable.
>   * Some counters are custom, non-standard. The standard counters are
>   * named in accordance with RFC2819, RFC2021 and IEEE Std 802.3-2002 Annex
> @@ -1829,6 +1854,278 @@ static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
>  		vsc73xx_refresh_fwd_map(ds, port, state);
>  }
>  
> +static u16 vsc73xx_calc_hash(const unsigned char *addr, u16 vid)
> +{
> +	/* VID 5-0, MAC 47-44 */
> +	u16 hash = ((vid & GENMASK(5, 0)) << 4) | (addr[0] >> 4);
> +
> +	/* MAC 43-33 */
> +	hash ^= ((addr[0] & GENMASK(3, 0)) << 7) | (addr[1] >> 1);
> +	/* MAC 32-22 */
> +	hash ^= ((addr[1] & BIT(0)) << 10) | (addr[2] << 2) | (addr[3] >> 6);
> +	/* MAC 21-11 */
> +	hash ^= ((addr[3] & GENMASK(5, 0)) << 5) | (addr[4] >> 3);
> +	/* MAC 10-0 */
> +	hash ^= ((addr[4] & GENMASK(2, 0)) << 8) | addr[5];
> +
> +	return hash;
> +}
> +
> +static int
> +vsc73xx_port_wait_for_mac_table_cmd(struct vsc73xx *vsc)
> +{
> +	int ret, err;
> +	u32 val;
> +
> +	ret = read_poll_timeout(vsc73xx_read, err,
> +				err < 0 ||
> +				((val & VSC73XX_MACACCESS_CMD_MASK) ==
> +				 VSC73XX_MACACCESS_CMD_IDLE),
> +				VSC73XX_POLL_SLEEP_US, VSC73XX_POLL_TIMEOUT_US,
> +				false, vsc, VSC73XX_BLOCK_ANALYZER,
> +				0, VSC73XX_MACACCESS, &val);
> +	if (ret)
> +		return ret;
> +	return err;
> +}
> +
> +static int vsc73xx_port_read_mac_table_entry(struct vsc73xx *vsc, u16 index,
> +					     struct vsc73xx_fdb *fdb)
> +{
> +	int ret, i;
> +	u32 val;
> +
> +	if (!fdb)
> +		return -EINVAL;
> +	if (index >= VSC73XX_NUM_FDB_RECORDS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < VSC73XX_NUM_BUCKETS; i++) {
> +		vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX,
> +			      (i ? 0 : VSC73XX_MACTINDX_SHADOW) |
> +			      i << VSC73XX_MACTINDX_BUCKET_MASK_SHIFT |
> +			      index);

Could you check for error codes from vsc73xx_read() and vsc73xx_write()
as well? This is applicable to the entire patch.

> +		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +		if (ret)
> +			return ret;
> +
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_MACACCESS,
> +				    VSC73XX_MACACCESS_CMD_MASK,
> +				    VSC73XX_MACACCESS_CMD_READ_ENTRY);
> +		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +		if (ret)
> +			return ret;
> +
> +		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACACCESS,
> +			     &val);
> +		fdb[i].valid = val & VSC73XX_MACACCESS_VALID;
> +		if (!fdb[i].valid)
> +			continue;
> +
> +		fdb[i].port = (val & VSC73XX_MACACCESS_DEST_IDX_MASK) >>
> +			      VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT;
> +
> +		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACHDATA,
> +			     &val);
> +		fdb[i].vid = (val & VSC73XX_MACHDATA_VID) >>
> +			     VSC73XX_MACHDATA_VID_SHIFT;
> +		fdb[i].mac[0] = (val >> VSC73XX_MACHDATA_MAC0_SHIFT) &
> +				VSC73XX_MAC_BYTE_MASK;
> +		fdb[i].mac[1] = (val >> VSC73XX_MACHDATA_MAC1_SHIFT) &
> +				VSC73XX_MAC_BYTE_MASK;
> +
> +		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACLDATA,
> +			     &val);
> +		fdb[i].mac[2] = (val >> VSC73XX_MACLDATA_MAC2_SHIFT) &
> +				VSC73XX_MAC_BYTE_MASK;
> +		fdb[i].mac[3] = (val >> VSC73XX_MACLDATA_MAC3_SHIFT) &
> +				VSC73XX_MAC_BYTE_MASK;
> +		fdb[i].mac[4] = (val >> VSC73XX_MACLDATA_MAC4_SHIFT) &
> +				VSC73XX_MAC_BYTE_MASK;
> +		fdb[i].mac[5] = (val >> VSC73XX_MACLDATA_MAC5_SHIFT) &
> +				VSC73XX_MAC_BYTE_MASK;
> +	}
> +
> +	return ret;
> +}
> +
> +static void
> +vsc73xx_fdb_insert_mac(struct vsc73xx *vsc, const unsigned char *addr, u16 vid)
> +{
> +	u32 val;
> +
> +	val = (vid << VSC73XX_MACHDATA_VID_SHIFT) & VSC73XX_MACHDATA_VID;
> +	val |= (addr[0] << VSC73XX_MACHDATA_MAC0_SHIFT);
> +	val |= (addr[1] << VSC73XX_MACHDATA_MAC1_SHIFT);
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACHDATA, val);
> +
> +	val = (addr[2] << VSC73XX_MACLDATA_MAC2_SHIFT);
> +	val |= (addr[3] << VSC73XX_MACLDATA_MAC3_SHIFT);
> +	val |= (addr[4] << VSC73XX_MACLDATA_MAC4_SHIFT);
> +	val |= (addr[5] << VSC73XX_MACLDATA_MAC5_SHIFT);
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACLDATA, val);
> +}
> +
> +static int vsc73xx_fdb_del_entry(struct vsc73xx *vsc, int port,
> +				 const unsigned char *addr, u16 vid)
> +{
> +	struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
> +	u16 hash = vsc73xx_calc_hash(addr, vid);
> +	int bucket, ret;
> +
> +	mutex_lock(&vsc->fdb_lock);
> +
> +	ret = vsc73xx_port_read_mac_table_entry(vsc, hash, fdb);
> +	if (ret)
> +		goto err;
> +
> +	for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
> +		if (fdb[bucket].valid && fdb[bucket].port == port &&
> +		    !memcmp(addr, fdb[bucket].mac, ETH_ALEN))

ether_addr_equal()

> +			break;
> +	}
> +
> +	if (bucket == VSC73XX_NUM_BUCKETS) {
> +		/* Can't find MAC in MAC table */
> +		ret = -ENODATA;
> +		goto err;
> +	}
> +
> +	vsc73xx_fdb_insert_mac(vsc, addr, vid);
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX, hash);
> +
> +	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +	if (ret)
> +		goto err;
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACACCESS,
> +			    VSC73XX_MACACCESS_CMD_MASK,
> +			    VSC73XX_MACACCESS_CMD_FORGET);
> +	ret =  vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +err:
> +	mutex_unlock(&vsc->fdb_lock);
> +	return ret;
> +}
> +
> +static int vsc73xx_fdb_add_entry(struct vsc73xx *vsc, int port,
> +				 const unsigned char *addr, u16 vid)
> +{
> +	struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
> +	u16 hash = vsc73xx_calc_hash(addr, vid);
> +	int bucket, ret;
> +	u32 val;
> +
> +	mutex_lock(&vsc->fdb_lock);
> +
> +	vsc73xx_port_read_mac_table_entry(vsc, hash, fdb);
> +
> +	for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
> +		if (!fdb[bucket].valid)
> +			break;
> +	}
> +
> +	if (bucket == VSC73XX_NUM_BUCKETS) {
> +		/* Bucket is full */
> +		ret = -EOVERFLOW;
> +		goto err;
> +	}
> +
> +	vsc73xx_fdb_insert_mac(vsc, addr, vid);
> +
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX, hash);
> +	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +	if (ret)
> +		goto err;
> +
> +	val = (port << VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT) &
> +	      VSC73XX_MACACCESS_DEST_IDX_MASK;
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +			    VSC73XX_MACACCESS,
> +			    VSC73XX_MACACCESS_VALID |
> +			    VSC73XX_MACACCESS_CMD_MASK |
> +			    VSC73XX_MACACCESS_DEST_IDX_MASK |
> +			    VSC73XX_MACACCESS_LOCKED,
> +			    VSC73XX_MACACCESS_VALID |
> +			    VSC73XX_MACACCESS_CMD_LEARN |
> +			    VSC73XX_MACACCESS_LOCKED | val);
> +	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +
> +err:
> +	mutex_unlock(&vsc->fdb_lock);
> +	return ret;
> +}
> +
> +static int vsc73xx_fdb_add(struct dsa_switch *ds, int port,
> +			   const unsigned char *addr, u16 vid, struct dsa_db db)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +
> +	if (!vid) {
> +		switch (db.type) {
> +		case DSA_DB_PORT:
> +			vid = dsa_tag_8021q_standalone_vid(db.dp);
> +			break;
> +		case DSA_DB_BRIDGE:
> +			vid = dsa_tag_8021q_bridge_vid(db.bridge.num);

I appreciate the intention, but if you don't set ds->fdb_isolation
(which you don't, although I believe the driver satisfies the documented
requirements), db.bridge.num will always be passed as 0 in the
.port_fdb_add() and .port_fdb_del() methods. Thus, dsa_tag_8021q_bridge_vid(0)
will always be different than what dsa_tag_8021q_bridge_join() selects
as VLAN-unaware bridge PVID for your ports. The FDB entry will be in a
different VLAN than what your switch classifies the packets to. This
means it won't match.

Assuming this went through a reasonable round of testing (add bridge FDB
entry towards expected port, make sure it isn't sent to others) and this
issue was not noticed, then maybe the switch performs shared VLAN learning?
Case in which, if you can't configure it to independent VLAN learning,
it does not pass the ds->fdb_isolation requirements, plus the entire
dance of picking a proper VID is pointless, as any chosen VID would have
the same behavior.

> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return vsc73xx_fdb_add_entry(vsc, port, addr, vid);
> +}
> +
> +static int vsc73xx_fdb_del(struct dsa_switch *ds, int port,
> +			   const unsigned char *addr, u16 vid, struct dsa_db db)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +
> +	if (!vid) {
> +		switch (db.type) {
> +		case DSA_DB_PORT:
> +			vid = dsa_tag_8021q_standalone_vid(db.dp);
> +			break;
> +		case DSA_DB_BRIDGE:
> +			vid = dsa_tag_8021q_bridge_vid(db.bridge.num);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return vsc73xx_fdb_del_entry(vsc, port, addr, vid);
> +}
> +
> +static int vsc73xx_port_fdb_dump(struct dsa_switch *ds,
> +				 int port, dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
> +	struct vsc73xx *vsc = ds->priv;
> +	u16 i, bucket;
> +
> +	mutex_lock(&vsc->fdb_lock);
> +
> +	for (i = 0; i < VSC73XX_NUM_FDB_RECORDS; i++) {
> +		vsc73xx_port_read_mac_table_entry(vsc, i, fdb);
> +
> +		for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
> +			if (!fdb[bucket].valid || fdb[bucket].port != port)
> +				continue;
> +
> +			/* We need to hide dsa_8021q VLANs from the user */
> +			if (vid_is_dsa_8021q(fdb[bucket].vid))
> +				fdb[bucket].vid = 0;
> +			cb(fdb[bucket].mac, fdb[bucket].vid, false, data);

"cb" is actually dsa_user_port_fdb_do_dump(). It can return -EMSGSIZE
when the netlink skb is full, and it is very important that you
propagate that to the caller:

	err = cb();
	if (err)
		goto unlock;

otherwise, you might notice that large FDB dumps will have missing FDB entries.

> +		}
> +	}
> +
> +	mutex_unlock(&vsc->fdb_lock);
> +	return 0;
> +}
> +
>  static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
>  	.mac_config = vsc73xx_mac_config,
>  	.mac_link_down = vsc73xx_mac_link_down,
> @@ -1851,6 +2148,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.port_bridge_join = dsa_tag_8021q_bridge_join,
>  	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
>  	.port_change_mtu = vsc73xx_change_mtu,
> +	.port_fdb_add = vsc73xx_fdb_add,
> +	.port_fdb_del = vsc73xx_fdb_del,
> +	.port_fdb_dump = vsc73xx_port_fdb_dump,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
>  	.port_stp_state_set = vsc73xx_port_stp_state_set,
>  	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
> @@ -1981,6 +2281,8 @@ int vsc73xx_probe(struct vsc73xx *vsc)
>  		return -ENODEV;
>  	}
>  
> +	mutex_init(&vsc->fdb_lock);
> +
>  	eth_random_addr(vsc->addr);
>  	dev_info(vsc->dev,
>  		 "MAC for control frames: %02X:%02X:%02X:%02X:%02X:%02X\n",
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index 3ca579acc798..a36ca607671e 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -45,6 +45,7 @@ struct vsc73xx_portinfo {
>   * @vlans: List of configured vlans. Contains port mask and untagged status of
>   *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
>   *	vlans.
> + * @fdb_lock: Mutex protects fdb access
>   */
>  struct vsc73xx {
>  	struct device			*dev;
> @@ -57,6 +58,7 @@ struct vsc73xx {
>  	void				*priv;
>  	struct vsc73xx_portinfo		portinfo[VSC73XX_MAX_NUM_PORTS];
>  	struct list_head		vlans;
> +	struct mutex			fdb_lock; /* protects fdb access */

Redundant comment since it's already in the kernel-doc?

>  };
>  
>  /**
> -- 
> 2.34.1
> 

