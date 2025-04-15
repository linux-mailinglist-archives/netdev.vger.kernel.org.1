Return-Path: <netdev+bounces-182724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B7AA89C3D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FF7AA42E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6F3291158;
	Tue, 15 Apr 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBWPPHBy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA11E0E0C;
	Tue, 15 Apr 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715983; cv=none; b=PL+8zVpWPJ3g/UeJA/ykFUAJh9rfM548TeQFLK0BePFRSLsfco70an1xX0iJl/ZiYacsWmjJYru4IgXiXzgSPzHg94m9p7A2F+9Y96cs+oOycwCKnFKIHdNAFgQri2O7wGv1LsrgikJKAoPPh/PI4JVWcA0VtanpG1ehSK7G75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715983; c=relaxed/simple;
	bh=mJ9D77XU697x5coVarp+a0/reR2v3QxlG7QlwoBwlMY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kauqHjcxhINUQ67onrvPjmlOOt9wx6rFtsOzZFMRPXa0HDxNOeZen7malWYBGu1huFD97fRjTiXhXCfUP7UzoGaj9tWIN6Yn2Dalcmmnidrnouk3T01j2IkRlQy8tLWwXfeeVm4xUhDX3UvE1KW2HF22q3bsEjIKP91eYccLi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBWPPHBy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so44875445e9.1;
        Tue, 15 Apr 2025 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744715980; x=1745320780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gfZ+B7bBElpHwN8wD255ZzmNgu0YV2y+0mNMVTYrv/A=;
        b=EBWPPHByM0FQ5siXPEVX9XjuwoE6T7RLb4kXugqQvxExOqTVmXwLx274D2g9X/70Qz
         MiRCTde2clsIvzzLJsk9hSYF+mLIuFr8cgsYdfbE7exsVwM2iHmUHe9fuEt9Tx7PYLgY
         HlM1RlQ0WiZkOFv1tkTHlDExyFEZ1uo13Pslrm7uO9+RPvvz+miLtJXGq7sjbegm+Ybr
         I6OvCorcPv/2JqS4mSoKCXhcOraJmz49SZWU5LGtfY8UUpj5yLu86/Yy48XlgyrBA+2L
         bFp0TVB/eFlrzaHrMF675gh0N06GEBQdnMg+uma1TTYQW63w5jGZvpbux96SdtTUvrgq
         EC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715980; x=1745320780;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfZ+B7bBElpHwN8wD255ZzmNgu0YV2y+0mNMVTYrv/A=;
        b=AuTrrguRtu0y9AJXzA87O664LE6JEjnO+9Wl08K/RgBcgmiR7eoccba25Dc+XdfoxZ
         GDMZQ0x/nT8gxXVtUMDcJ6DpmLZZ3hI0RRMV9HbR/5UYKSYfYrjdzwVGzYhNQeaH6Sm2
         JtpersqIzbbwWAFQguLa8r3GfAGdKWbOTgno5e771BBFbakXZUnpNk9YWap2Ai3+Ph0Z
         coSWt8UPIZLfphctWhGLdGJ/5qLeXKaijCApKHe27c17rabhzJutcSq6R6Y27bzOcjDv
         toYKvbonpvSoytvyB1jwGi5enks3+5bLCZuaR73sWObWruh0LdJ723yCgneG/IK7fE+p
         QkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0KdKjvVuaVWBq5RwDkBfOlg3/eyYzdK5OG0QH9mSLvIftVko0zjaRJGtfnEHBCna6Kuc3YrK3@vger.kernel.org, AJvYcCW8OL7ulTuFum06ifiqFLuYtvCRtIAk1gY5POEsP5vSIEmtqsy+HkF4l3Da1UTcmohXXE1j2+rpI0Ks@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7DsxVeauM1g3squyGG8YPj6vCothK6sK+eeUsXQ14E7jpP1G
	5jF4Xh4QAiZaW0duaQVuCH3h5gY+sqeNJx3q+LLpKr++R0hZ+GM8
X-Gm-Gg: ASbGncvhcBa1hWE3H/gqlAMOvlK12I2j1RXmWiRnov5QFxNnXEfz1NL5Ao9oHM9q7+C
	TiUO9ApwQH4WyQ9OzIKniqkbG2Q5tkE3pizyLpRAQaryfOA7MQjU7/6uBmrcFS8tRUwXXfzeN2n
	mvRNNFSMR4xJUOqhe05py+0PbNVCfASUG3cb00KKkaAOkAh4Rvou3ua2clTzhViSfCFRhdypEZV
	Mt/6G1B5sOItd54ta3Kx+4bf1RTLMEIEIIzx5Vt8whUX/1jtlXLRry+KF9W/pI6KKETog2lVB3D
	QuBdGtDpQce9l/9cYdRfbTxmSwpcnFE/Cfl6kNs9NS0YWFesUCHyE+DhWFw1g024xZDfUyuVYON
	aCZQX8vp47Bge
X-Google-Smtp-Source: AGHT+IH8rvcaALTnKD4/4bboN3WpgVyXCmr0LP11MsqvJyR0D2AFTcVcoxHUVRdJg7ECOtYZSkG/mA==
X-Received: by 2002:a05:6000:2282:b0:39c:2673:4f10 with SMTP id ffacd0b85a97d-39edc32909amr2197576f8f.23.1744715979890;
        Tue, 15 Apr 2025 04:19:39 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-95-100.retail.telecomitalia.it. [95.249.95.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc99sm211365045e9.29.2025.04.15.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:19:39 -0700 (PDT)
Message-ID: <67fe40cb.050a0220.130904.f08d@mx.google.com>
X-Google-Original-Message-ID: <Z_5AxgkSTH8prWyF@Ansuel-XPS.>
Date: Tue, 15 Apr 2025 13:19:34 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [net-next PATCH v7 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
 <20250410095443.30848-6-ansuelsmth@gmail.com>
 <8760a101-4536-474f-a0db-5b88ed4c0ec2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8760a101-4536-474f-a0db-5b88ed4c0ec2@lunn.ch>

On Tue, Apr 15, 2025 at 03:14:13AM +0200, Andrew Lunn wrote:
> > +#define AEON_MAX_LDES			5
> 
> AEON_MAX_LEDS?
> 
> > +#define AEON_IPC_DELAY			10000
> > +#define AEON_IPC_TIMEOUT		(AEON_IPC_DELAY * 100)
> > +#define AEON_IPC_DATA_MAX		(8 * sizeof(u16))
> 
> > +
> 
> > +static int aeon_ipc_rcv_msg(struct phy_device *phydev,
> > +			    u16 ret_sts, u16 *data)
> > +{
> 
> It would be good to add a comment here about what the return value
> means. I'm having to work hard to figure out if it is bytes, or number
> of u16s.
> 
> > +	struct as21xxx_priv *priv = phydev->priv;
> > +	unsigned int size;
> > +	int ret;
> > +	int i;
> > +
> > +	if ((ret_sts & AEON_IPC_STS_STATUS) == AEON_IPC_STS_STATUS_ERROR)
> > +		return -EINVAL;
> > +
> > +	/* Prevent IPC from stack smashing the kernel */
> > +	size = FIELD_GET(AEON_IPC_STS_SIZE, ret_sts);
> > +	if (size > AEON_IPC_DATA_MAX)
> > +		return -EINVAL;
> 
> This suggests size is bytes, and can be upto 16?
> 
> > +
> > +	mutex_lock(&priv->ipc_lock);
> > +
> > +	for (i = 0; i < DIV_ROUND_UP(size, sizeof(u16)); i++) {
> > +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i));
> > +		if (ret < 0) {
> > +			size = ret;
> > +			goto out;
> > +		}
> > +
> > +		data[i] = ret;
> 
> and this is looping up to 8 times reading words.
> 
> > +static int aeon_ipc_get_fw_version(struct phy_device *phydev)
> > +{
> > +	char fw_version[AEON_IPC_DATA_MAX + 1];
> > +	u16 ret_data[8], data[1];
> 
> I think there should be a #define for this 8. It is pretty fundamental
> to these message transfers.
> 
> > +	u16 ret_sts;
> > +	int ret;
> > +
> > +	data[0] = IPC_INFO_VERSION;
> 
> Not a normal question i would ask for MDIO, but are there any
> endianness issues here? Since everything is in u16, the base size for
> MDIO, i doubt there is.
>

In theory not, anything comes to mine that might be problematic? 

> > +	ret = aeon_ipc_send_msg(phydev, IPC_CMD_INFO, data,
> > +				sizeof(data), &ret_sts);
> > +	if (ret)
> > +		return ret;
> 
> > +	ret = aeon_ipc_rcv_msg(phydev, ret_sts, ret_data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> 
> but ret is in bytes, not words, so we start getting into odd
> situations. Have you seen the firmware return an add number of bytes
> in its message? If it does, is it clear which part of the last word
> should be used.
> 

ret is size from IPC STATUS that return the transmitted data in bytes.
I use u16 to follow the fact that there are 8 rw IPC data register.

The returned firmware value is 1.8.2 for example and that is 5 bytes.

We allocate 17 bytes for the firmware string and we pass a buffer of 8
u16 (16 bytes)

Am I missing something?

> > +
> > +	/* Make sure FW version is NULL terminated */
> > +	memcpy(fw_version, ret_data, ret);
> > +	fw_version[ret] = '\0';
> 
> 
> Given that ret is bytes, this works, despite ret_data being words.
> 
> 	Andrew

-- 
	Ansuel

