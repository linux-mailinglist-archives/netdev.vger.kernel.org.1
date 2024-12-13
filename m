Return-Path: <netdev+bounces-151574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB89F009C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 01:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EEA16A102
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5381373;
	Fri, 13 Dec 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/JtUqdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB964A31;
	Fri, 13 Dec 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048032; cv=none; b=i68XNvYd0N8WTvP4eolWx1ZxKrGfYf3Xua4MgYoKIEoKn0oL3R1+VnZQgXoZfHAXTbagNri326x7UrkSk8HgzUySPTm8tq31rv5rw+h+JJUgHwU8ud326d1yKRfsLgdVmJEMeIkdHSe+idDzwJtBRNv98PsEABVynTnFqbGg0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048032; c=relaxed/simple;
	bh=9p7YHaZbq/dx9n2Yjc/OIF1INCIhH6YHwdTFSkpy1CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgZb8yavdnpfVYA9VuelDkl7yqd5qfY+F+5s2YAFI0bL0qbWd7e0cK/h097Ph9pSm3KJfUC+trgnOJQWdQOqNvQiSDq9k3G5iALnJQBlexOGAcRQ//8vkMBf68kEmTvIA+e1fEqkhYObzH8CZmWwfXoiFmLyjUNG4FEFk13NkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/JtUqdg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa67bc91f87so15055966b.1;
        Thu, 12 Dec 2024 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734048028; x=1734652828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcclPUIV9hN7sAKsxaBgUUDDyLhCyXI/utLd1IiKtfY=;
        b=O/JtUqdglciY+So1V8eEHuHYyHlwDjmyjNo1iu6/WXHUozeRhWf9VXOvC30Aykw30W
         V8YjAkmENz3V+rYMqrsHEyqnoZYXxQjM4fU5uFzACrq82u3nEtIVzZUVo84ceUNK7ZQd
         vBW1RLHy3cxAI/ZTAFWj+yNwz+9QcgFdRxJAPyGi+FN91diSK9BpsFrOm1c0g8LbF8uF
         HLwpaeQqo9rSbd36G9XHUOgbYqcjYAregYQo4vnlTsc6nXZwXJ/12TtP1jh1U5GZCyKA
         IyDkOTR4nV03xJ7/egssKwN36DQdrJkWu5+aVLk5UQnzG4HSCjnr57geZWOJGPNKwk+8
         ekqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734048028; x=1734652828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcclPUIV9hN7sAKsxaBgUUDDyLhCyXI/utLd1IiKtfY=;
        b=g2uB8S5qYMKzfrTkkFhZGg5XbHWoLmAA0FQkJSQNNwiv0tpzwODwH58AkJE7LVLpFw
         LNAw9Py4VsJSnE1nAzgJyudWwNdujZUZ0f0K4SLQR2Hcj1Wfwk6dNXrwiWRpb5DZRzN4
         kXpn+XW2rHbhC3Oj5y/oBT8wmlmWfAz/+ug3LG29a4SdH1C1MKNY0uCjIga1/nCDo3oY
         4vq6RBskO1863pAo6wR3rf0ZyeXRc5eCmJAyADDJIzVHsaWj9F67LLtMIfgNulS4GoZ5
         mH9q2iXzdw7tDBjgp4Zvg5b8X84f5BOa/d2816VVfgcmIM/TO9Y+C8zfMtTI/o7C+v6r
         b2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/G2Puyv7zM4FU4+Jqvl4ym+XTEEjzN6A2pRZYwUO+/qAY/spwGk/IU5OY/RIt3zL86wCF3Ake@vger.kernel.org, AJvYcCXqmtIrYVX7vosMC+qNyvW9bwhuGio7yQJInN4Hk+wgaMZTqAj3Cw84qWWkS3QOpdQXCVIBtCpOoXyGD6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxueyNIJwKbLNzVK2lBDc4iIO8XTavbuy6Y8Te8B2JJacg/BQu4
	NxCCudQGRETPRkOCJVfrGUX7lTJVZaSIz43cFa6XlvpzdOsHmL2X
X-Gm-Gg: ASbGncs4wn1WyKwzgsz+Zrtf0FXqfjPr8+XcsytHnFO45LnAt8+qQwSYUlMb27di8U0
	+fvzmMTmxKWdmOh+i+70WOIqmw80z/EMqckhcfAv5uP50tZKH44cy02CgNksKO3Oli85bEKEkIE
	008XN3G1mwturYDmsutx+P0NErvwa4tmbfjJhxy5M7Af6PtRT5flaatVNlwgJ99ObZGyABVG5jg
	lT3Ef1axNonvq4Cz5mtV8cTldcofFAYzGz9Fgjjy1YC
X-Google-Smtp-Source: AGHT+IEX0vHAiQvbAxuBHI2nFlWSLhH5iA+A6F1sg1Z0GU8++HkwbQyAuRfuKlroxaJU9N1xhb9/kQ==
X-Received: by 2002:a05:6402:50cc:b0:5d0:b7c5:c406 with SMTP id 4fb4d7f45d1cf-5d63c2e16c1mr90402a12.1.1734048028037;
        Thu, 12 Dec 2024 16:00:28 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b60789asm10731626a12.37.2024.12.12.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:00:26 -0800 (PST)
Date: Fri, 13 Dec 2024 02:00:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Message-ID: <20241213000023.jkrxbogcws4azh4w@skbuf>
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241212215132.3111392-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241212215132.3111392-1-tharvey@gateworks.com>

On Thu, Dec 12, 2024 at 01:51:32PM -0800, Tim Harvey wrote:
> commit 331d64f752bb ("net: dsa: microchip: add the enable_stp_addr
> pointer in ksz_dev_ops") introduced enabling of the reserved multicast
> address table function to filter packets based on multicast MAC address
> but only configured one MAC address group, group 0 for
> (01-80-C2-00)-00-00 for bridge group data.
> 
> This causes other multicast groups to fail to be received such as LLDP
> which uses a MAC address of 01-80-c2-00-00-0e (group 6).
> 
> Enabling the reserved multicast address table requires configuring the
> port forward mask for all eight address groups as the mask depends on
> the port configuration.

Personal experience reading your commit message: it took me a long while
to realize that the reason why the 8 pre-configured Reserved Multicast
table entries don't work is written here: "the mask depends on the port
configuration." It is absolutely understated IMO.

> The table determines the forwarding ports for
> 48 specific multicast addresses and is addressed by the least
> significant 6 bits of the multicast address. Changing a forwarding
> port mask for one address also makes the same change for all other
> addresses in the same group.
> 
> Add configuration of the groups as such:
>  - leave these as default:
>    group 1 (01-80-C2-00)-00-01 (MAC Control Frame) (drop)
>    group 3 (01-80-C2-00)-00-10) (Bridge Management) (all ports)
>  - forward to cpu port:
>    group 0 (01-80-C2-00)-00-00 (Bridge Group Data)
>    group 2 (01-80-C2-00)-00-03 (802.1X access control)
>    group 6 (01-80-C2-00)-00-02, (01-80-C2-00)-00-04 – (01-80-C2-00)-00-0F
>  - forward to all but cpu port:

Why would you not forward packets to the CPU port as a hardcoded configuration?
What if the KSZ ports are bridged together with a foreign interface
(different NIC, WLAN, tunnel etc), how should the packets reach that?

>    group 4 (01-80-C2-00)-00-20 (GMRP)
>    group 5 (01-80-C2-00)-00-21 (GVRP)
>    group 7 (01-80-C2-00)-00-11 - (01-80-C2-00)-00-1F,
>            (01-80-C2-00)-00-22 - (01-80-C2-00)-00-2F

Don't you want to forgo the (odd) hardware defaults for the Reserved Multicast
table, and instead follow what the Linux bridge does in br_handle_frame()?
Which is to trap all is_link_local_ether_addr() addresses to the CPU, do
_not_ call dsa_default_offload_fwd_mark() for those packets (aka let the
bridge know that they haven't been forwarded in hardware, and if they
should reach other bridge ports, this must be done in software), and let the
user choose, via the bridge group_fwd_mask, if they should be forwarded
to other bridge ports or not?

> 
> Datasheets:
> [1] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9897S-Data-Sheet-DS00002394C.pdf
> [2] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9896C-Data-Sheet-DS00002390C.pdf
> [3] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9893R-Data-Sheet-DS00002420D.pdf
> [4] https://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf
> [5] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS00002419D.pdf
> [6] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ9567R-Data-Sheet-DS00002329.pdf
> [7] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ9567R-Data-Sheet-DS00002329.pdf

[6] and [7] are the same.

Also, you'd better specify in the commit message what's with these datasheet
links, which to me and I suppose all other non-expert readers, are pasted here
out of the blue, with no context.

Like for example: "KSZ9897, ..., have arbitrary CPU port assignments, as
can be seen in the driver's ksz_chip_data :: cpu_ports entries for these
families, and the CPU port selection on a certain board rarely coincides
with the default host port selection in the Reserved Multicast address
table".

> 
> Fixes: 331d64f752bb ("net: dsa: microchip: add the enable_stp_addr pointer in ksz_dev_ops")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/net/dsa/microchip/ksz9477.c | 84 +++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index d16817e0476f..d8fe809dd461 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1138,25 +1138,24 @@ void ksz9477_config_cpu_port(struct dsa_switch *ds)
>  	}
>  }
>  
> -int ksz9477_enable_stp_addr(struct ksz_device *dev)
> +static int ksz9477_reserved_muticast_group(struct ksz_device *dev, int index, int mask)
>  {
> +	const u8 *shifts;
>  	const u32 *masks;
>  	u32 data;
>  	int ret;
>  
> +	shifts = dev->info->shifts;
>  	masks = dev->info->masks;
>  
> -	/* Enable Reserved multicast table */
> -	ksz_cfg(dev, REG_SW_LUE_CTRL_0, SW_RESV_MCAST_ENABLE, true);
> -
> -	/* Set the Override bit for forwarding BPDU packet to CPU */
> -	ret = ksz_write32(dev, REG_SW_ALU_VAL_B,
> -			  ALU_V_OVERRIDE | BIT(dev->cpu_port));
> +	/* write the PORT_FORWARD value to the Reserved Multicast Address Table Entry 2 Register */

In netdev the coding style limits the line length to 80 characters where
that is easy, like here.

> +	ret = ksz_write32(dev, REG_SW_ALU_VAL_B, mask);
>  	if (ret < 0)
>  		return ret;
>  
> -	data = ALU_STAT_START | ALU_RESV_MCAST_ADDR | masks[ALU_STAT_WRITE];
> -
> +	/* write to the Static Address and Reserved Multicast Table Control Register */
> +	data = (index << shifts[ALU_STAT_INDEX]) |
> +		ALU_STAT_START | ALU_RESV_MCAST_ADDR | masks[ALU_STAT_WRITE];
>  	ret = ksz_write32(dev, REG_SW_ALU_STAT_CTRL__4, data);
>  	if (ret < 0)
>  		return ret;
> @@ -1167,8 +1166,75 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
>  		dev_err(dev->dev, "Failed to update Reserved Multicast table\n");
>  		return ret;
>  	}
> +	return ksz9477_wait_alu_sta_ready(dev);
> +}
> +
> +int ksz9477_enable_stp_addr(struct ksz_device *dev)
> +{
> +	int ret;
> +	int cpu_mask = dsa_cpu_ports(dev->ds);
> +	int user_mask = dsa_user_ports(dev->ds);

Also, in netdev, the coding style is to sort lines with variable
declarations in the reverse order of their length (so-called reverse
Christmas tree).

> +	/* array of indexes into table:
> +	 * The table is indexed by the low 6 bits of the MAC address.
> +	 * Changing the PORT_FORWARD value for any single address affects
> +	 * all others in group
> +	 */
> +	u16 addr_groups[8] = {

Array can be static const. Also, since all elements are initialized,
specifying its size explicitly is not necessary ("[8]" can be "[]").

> +		/* group 0: (01-80-C2-00)-00-00 (Bridge Group Data) */
> +		0x000,
> +		/* group 1: (01-80-C2-00)-00-01 (MAC Control Frame) */
> +		0x001,
> +		/* group 2: (01-80-C2-00)-00-03 (802.1X access control) */
> +		0x003,
> +		/* group 3: (01-80-C2-00)-00-10) (Bridge Management) */
> +		0x010,
> +		/* group 4: (01-80-C2-00)-00-20 (GMRP) */
> +		0x020,
> +		/* group 5: (01-80-C2-00)-00-21 (GVRP) */
> +		0x021,
> +		/* group 6: (01-80-C2-00)-00-02, (01-80-C2-00)-00-04 – (01-80-C2-00)-00-0F */
> +		0x002,
> +		/* group 7: (01-80-C2-00)-00-11 - (01-80-C2-00)-00-1F,
> +		 *          (01-80-C2-00)-00-22 - (01-80-C2-00)-00-2F
> +		 */
> +		0x011,
> +	};
> +
> +	/* Enable Reserved multicast table */
> +	ksz_cfg(dev, REG_SW_LUE_CTRL_0, SW_RESV_MCAST_ENABLE, true);
> +
> +	/* update reserved multicast address table:
> +	 * leave as default:
> +	 *  - group 1 (01-80-C2-00)-00-01 (MAC Control Frame) (drop)
> +	 *  - group 3 (01-80-C2-00)-00-10) (Bridge Management) (all ports)
> +	 * forward to cpu port:
> +	 *  - group 0 (01-80-C2-00)-00-00 (Bridge Group Data)
> +	 *  - group 2 (01-80-C2-00)-00-03 (802.1X access control)
> +	 *  - group 6 (01-80-C2-00)-00-02, (01-80-C2-00)-00-04 – (01-80-C2-00)-00-0F
> +	 * forward to all but cpu port:
> +	 *  - group 4 (01-80-C2-00)-00-20 (GMRP)
> +	 *  - group 5 (01-80-C2-00)-00-21 (GVRP)
> +	 *  - group 7 (01-80-C2-00)-00-11 - (01-80-C2-00)-00-1F,
> +	 *            (01-80-C2-00)-00-22 - (01-80-C2-00)-00-2F
> +	 */
> +	if (ksz9477_reserved_muticast_group(dev, addr_groups[0], cpu_mask))
> +		goto exit;

err = (function return code), and print it with %pe, ERR_PTR(err) please.
We want to distinguish between -ETIMEDOUT in ksz9477_wait_alu_sta_ready()
vs whatever ksz_write32() may return.

> +	if (ksz9477_reserved_muticast_group(dev, addr_groups[2], cpu_mask))
> +		goto exit;
> +	if (ksz9477_reserved_muticast_group(dev, addr_groups[6], cpu_mask))
> +		goto exit;
> +	if (ksz9477_reserved_muticast_group(dev, addr_groups[4], user_mask))
> +		goto exit;
> +	if (ksz9477_reserved_muticast_group(dev, addr_groups[5], user_mask))
> +		goto exit;
> +	if (ksz9477_reserved_muticast_group(dev, addr_groups[7], user_mask))
> +		goto exit;
>  
>  	return 0;
> +
> +exit:
> +	dev_err(dev->dev, "Failed to update Reserved Multicast table\n");
> +	return ret;
>  }
>  
>  int ksz9477_setup(struct dsa_switch *ds)
> -- 
> 2.34.1
> 


