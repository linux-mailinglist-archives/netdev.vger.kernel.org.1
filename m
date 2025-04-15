Return-Path: <netdev+bounces-182726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D48A89C68
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2DB18972B0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458C29CB53;
	Tue, 15 Apr 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6L8Scty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0528E609;
	Tue, 15 Apr 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716265; cv=none; b=AXBUNrUAPOWaSRB0MI5SgE2ArAj4OOGUDWbxO00mnP3lioRNNaxrEbql/HCvhECA+lEYH5GSKFeWo4qnfsa4VxNGbEyN5qXZ+Iph36XAo5/muYRjTCBsDBs0Wq7Qh3kCoxhAkyTTvfom3rI6gHS40R0/M/SDyPsvhOIlOOTX1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716265; c=relaxed/simple;
	bh=O/DIg1N6fb8zPatRjNFTmfTiNYT3NSBz0LuOqeRSbPM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVwoMXtZUfje2R0Xivw4OCDmVp+OnuZO6A9UDS1o/5e/l3GAk66+wdyfWipJZyQPZ8Fa6LLWNf2ufAR/gdol3i1jcr9BvVrbElTIrQFZnlnZvOtWFDhO8CF6ymfk7YCmB4Bo9Ld/9xf5uCN8H1NHDlw8sJ/WvQrOh+1UeEoQk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6L8Scty; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf257158fso38485025e9.2;
        Tue, 15 Apr 2025 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744716262; x=1745321062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ynT09J8hxHl3dYCL6DhSzuVwAwBo68S1e5NgOzza1wc=;
        b=L6L8SctypmN3Dg2ETYnSTJSIzVHesR1wKqoIZEjDQHR1k0usqoJP0tcWg+ITKPFebq
         hmQTwH16fHnpy64uR7PCM6LDckkmGm13TZ7S6TvMwQ/8DMNC7woBOKhTyGgcbRBxvP20
         1MPKqpk1DDJXmYjDYbKrJM81md07B64Hg3TGZ+5qDJnjcb2qfPb5SnCyrA+Fw+0P7wcR
         MbQrZQ1W1CWfmrFxm/t07OD/P0jIVjbMSyxx1fmG2iaX6S+2SanSUQTMILeNsESAagN3
         QAAi/n14ssoTObyek0kaDNTimE+P6fI6mlx0CCw92MUZvf+qjye9hYVcpTRKvEzJzEgW
         11AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744716262; x=1745321062;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynT09J8hxHl3dYCL6DhSzuVwAwBo68S1e5NgOzza1wc=;
        b=QEoyNhIFd18MYC3nm/50LqX1yE27olcMwdzN2Jt5Y2rxECpiORLcsT9isas/Wqgd/W
         DybUN0HYgfP9Ux/FfNOUq7Snfn345b5O7MGCWMh+TAcjBYEijjdtdC2d/MvIjR+1KODo
         mDtqwgMw9tdthI3KVMjHxuz8X8IlWCTb9HM+JaoMBvGKki24L3QrY5FgjlHWbfJs3sBR
         IcudYGFmmdOPiXZw30DgN+B7aZR7vmoo9KZF5N/7rmvVPHegDyvAEWya8WWp8xocyUSt
         odEkrqtxe+BrrOJs7tWi+xl0rQ6amzjmqifwFwxMTzKzkMVC6jPA+q0PHyg4DsrJUNgJ
         5Z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOhPfBC1weX137u9ORyTCtatyZbe5wdC81tE4lkV9lgwOQLlH97JAxJXLSJdXn6MttWTm5Hich@vger.kernel.org, AJvYcCVnQNBGRaBe1lDQrEE08apxRMBIjtZUZGRYaHAAdr537FOVHWkIm4hXOssyQovFKGvbOY8T8hC7byWl@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWUnWKE/346UszyR/xeN4/mr0jepbJ9ltt3mfnOoOtcFIF7Pl
	+qE093eJlvSciwjfhTkmSQiEzDeWXUeQhciq4wZqB6MfKQEvSKgK
X-Gm-Gg: ASbGncuynjkv2eFBrWZg4tv11tPcviWvcWEhNmkpIIRqiXY9SACj2ngWjkWfDS8WgS/
	2ZFIKbOoktlq1pi5lZJom5j+a4MbdaVAJ8rONHOH+HfscR8IImz4cAhzpx14UiY/zXNAIqTjoC6
	bc8Da/dqWidWF/ciH0/I/1G22cDZwE3gKf/lXm+/rI6TWcKlPEBXsLduR3mUoQ/UNZrH2OOXTzB
	JGAfwg40hFAQ7KvpHin1vSwfA7bh32RNtgPG5sKjVjzM18+GL+iG4DEpF+mhS83giy9U7jMKFx0
	7Sat1NLv2WLgjO5M4A51c4nmXfJVRZAoZIEhfJjpe+eX9Qk/dvNxFrdbDuH6Ne2z0I2jb3j6muI
	tQBfgGZQ1n0i+
X-Google-Smtp-Source: AGHT+IF9qHXYHWvV7YvPtLmXZfGEXP7FE8MPbmSNCmTo1jCDJZv0BVbO0zV1Eq7gQfSztur3bAi1QA==
X-Received: by 2002:a05:600c:c87:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43f4aafa03amr92832885e9.18.1744716261866;
        Tue, 15 Apr 2025 04:24:21 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-95-100.retail.telecomitalia.it. [95.249.95.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce0asm13987368f8f.70.2025.04.15.04.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:24:21 -0700 (PDT)
Message-ID: <67fe41e5.5d0a0220.1003f3.9737@mx.google.com>
X-Google-Original-Message-ID: <Z_5B4J-weY45HLYw@Ansuel-XPS.>
Date: Tue, 15 Apr 2025 13:24:16 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
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
 <Z_4o7SBGxHBdjWFZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_4o7SBGxHBdjWFZ@shell.armlinux.org.uk>

On Tue, Apr 15, 2025 at 10:37:49AM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 10, 2025 at 11:53:35AM +0200, Christian Marangi wrote:
> > +#define VEND1_IPC_DATA0			0x5808
> > +#define VEND1_IPC_DATA1			0x5809
> > +#define VEND1_IPC_DATA2			0x580a
> > +#define VEND1_IPC_DATA3			0x580b
> > +#define VEND1_IPC_DATA4			0x580c
> > +#define VEND1_IPC_DATA5			0x580d
> > +#define VEND1_IPC_DATA6			0x580e
> > +#define VEND1_IPC_DATA7			0x580f
> 
> Do you use any of these other than the first? If not, please remove
> them, maybe adding a comment before the first stating that there are
> 8 registers.
>

No since the macro is used. Also from Andrew request I will declare the
max number of IPC data register so yes I can drop.

> > +static int aeon_ipcs_wait_cmd(struct phy_device *phydev, bool parity_status)
> > +{
> > +	u16 val;
> > +
> > +	/* Exit condition logic:
> > +	 * - Wait for parity bit equal
> > +	 * - Wait for status success, error OR ready
> > +	 */
> > +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS, val,
> > +					 FIELD_GET(AEON_IPC_STS_PARITY, val) == parity_status &&
> > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_RCVD &&
> > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_PROCESS &&
> > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_BUSY,
> > +					 AEON_IPC_DELAY, AEON_IPC_TIMEOUT, false);
> 
> Hmm. I'm wondering whether:
> 
> static bool aeon_ipc_ready(u16 val, bool parity_status)
> {
> 	u16 status;
> 
> 	if (FIELD_GET(AEON_IPC_STS_PARITY, val) != parity_status)
> 		return false;
> 
> 	status = val & AEON_IPC_STS_STATUS;
> 
> 	return status != AEON_IPC_STS_STATUS_RCVD &&
> 	       status != AEON_IPC_STS_STATUS_PROCESS &&
> 	       status != AEON_IPC_STS_STATUS_BUSY;
> }
> 
> would be better, and then maybe you can fit the code into less than 80
> columns. I'm not a fan of FIELD_PREP_CONST() when it causes differing
> usage patterns like the above (FIELD_GET(AEON_IPC_STS_STATUS, val)
> would match the coding style, and probably makes no difference to the
> code emitted.)
> 

You are suggesting to use a generic readx function or use a while +
sleep to use the suggested _ready function?

> > +}
> > +
> > +static int aeon_ipc_send_cmd(struct phy_device *phydev,
> > +			     struct as21xxx_priv *priv,
> > +			     u16 cmd, u16 *ret_sts)
> > +{
> > +	bool curr_parity;
> > +	int ret;
> > +
> > +	/* The IPC sync by using a single parity bit.
> > +	 * Each CMD have alternately this bit set or clear
> > +	 * to understand correct flow and packet order.
> > +	 */
> > +	curr_parity = priv->parity_status;
> > +	if (priv->parity_status)
> > +		cmd |= AEON_IPC_CMD_PARITY;
> > +
> > +	/* Always update parity for next packet */
> > +	priv->parity_status = !priv->parity_status;
> > +
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_CMD, cmd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Wait for packet to be processed */
> > +	usleep_range(AEON_IPC_DELAY, AEON_IPC_DELAY + 5000);
> > +
> > +	/* With no ret_sts, ignore waiting for packet completion
> > +	 * (ipc parity bit sync)
> > +	 */
> > +	if (!ret_sts)
> > +		return 0;
> > +
> > +	ret = aeon_ipcs_wait_cmd(phydev, curr_parity);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*ret_sts = ret;
> > +	if ((*ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_SUCCESS)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int aeon_ipc_send_msg(struct phy_device *phydev,
> > +			     u16 opcode, u16 *data, unsigned int data_len,
> > +			     u16 *ret_sts)
> > +{
> > +	struct as21xxx_priv *priv = phydev->priv;
> > +	u16 cmd;
> > +	int ret;
> > +	int i;
> > +
> > +	/* IPC have a max of 8 register to transfer data,
> > +	 * make sure we never exceed this.
> > +	 */
> > +	if (data_len > AEON_IPC_DATA_MAX)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&priv->ipc_lock);
> > +
> > +	for (i = 0; i < data_len / sizeof(u16); i++)
> > +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i),
> > +			      data[i]);
> > +
> > +	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
> > +	      FIELD_PREP(AEON_IPC_CMD_OPCODE, opcode);
> > +	ret = aeon_ipc_send_cmd(phydev, priv, cmd, ret_sts);
> > +	if (ret)
> > +		phydev_err(phydev, "failed to send ipc msg for %x: %d\n",
> > +			   opcode, ret);
> > +
> > +	mutex_unlock(&priv->ipc_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int aeon_ipc_rcv_msg(struct phy_device *phydev,
> > +			    u16 ret_sts, u16 *data)
> > +{
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
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&priv->ipc_lock);
> 
> I think the locking here is suspicious.
> 
> aeon_ipc_send_msg() takes the lock, writes the registers, and waits for
> the success signal, returning the status, and then drops the lock.
> 
> Time passes.
> 
> aeon_ipc_rcv_msg() is then called, which extracts the number of bytes to
> be read from the returned status, takes the lock, reads the registers,
> and then drops the lock.
> 
> So, what can happen is:
> 
> 	Thread 1			Thread 2
> 	aeon_ipc_send_msg()
> 					aeon_ipc_send_msg()
> 	aeon_ipc_rcv_msg()
> 					aeon_ipc_rcv_msg()
> 
> Which means thread 1 reads the reply from thread 2's message.
> 
> So, this lock does nothing to really protect against the IPC mechanism
> against races.
> 
> I think you need to combine both into a single function that takes the
> lock once and releases it once.
>

Mhhh I think I will have to create __ function for locked and non-locked
variant. I think I woulkd just handle the lock in the function using
send and rcv and maybe add some smatch tag to make sure the lock is
taken when entering those functions.

-- 
	Ansuel

