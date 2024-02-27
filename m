Return-Path: <netdev+bounces-75397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02928869BBF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DFC1C204E8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D011482FC;
	Tue, 27 Feb 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="00Xx+0Oi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFC1474AB
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050399; cv=none; b=P2PnTSHXX7LfwSoZ2L6Wr032G1hhCPp3vRNUOnGQxduHhymZ/NSf/7raP3sUMXl56RGUFjCSD00D83JC6pSnF6JZAvAVhbjcaQ3BzuM51S3pY2CjSBEPxedie+4QhAUbqKm3wasaaa0FlyAy0C6+9ZkofzJQZQNLw6e3O78pefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050399; c=relaxed/simple;
	bh=GgMIs7CnGsj0Oiwid0N1vSiT6igOmfDfHV3du4XW2XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D87/OFLFdhXyRDi3p0a5QekaLc5RZPyzPua9bsCpaDUlqSdPgpEAk4Y5ytFeEG0BRECbQJHj3o0Kc3bRWu0T2YdqqVTMJ1AR/ec47JOOxevMWOBHwDSQZJtTWZ99kiKeHvITYAXx97ZL/RMz21du7PawhYdItkR9IK7wi38yK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=00Xx+0Oi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so10625241fa.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709050394; x=1709655194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0zlUbDRUti/0fQkXKr609F+U7sVS+VPdTOuFz0F/Bk=;
        b=00Xx+0Oi1EXJ3i4nM0YKBbQitPdIU0owy6WyMLxh2HPwX67VUy5/50bLkDmQoJtVY7
         ZttcMohwTP0XbjfHr8JC8L7pIqGrTD++5WZcYlMbgqVFTXeOslg/NMLY8BG2IiS9XBxR
         KAHKNrbSuhXa4wuU2OJy8E8g78iVISLH2/7z39U/07BKuWjM/pwHaK/Creb9NPxjfl9R
         ppWrbSs1hRHQjc+ZHJOfsKv4PAJ7Xy6R7YB5FPf0tweM8VcUJIXvQpXBEMVGAPCa4RyV
         bTvo3IEqnprR/3trdhGSjw9cL7hzGzxA/6P6GNEX2Fl0tLHqa3jhbdAiFZTG19sTHpl+
         P55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050394; x=1709655194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0zlUbDRUti/0fQkXKr609F+U7sVS+VPdTOuFz0F/Bk=;
        b=brka8xLijudxfZTKryR1BSq8IeM66pv56KflFLeTXKus4xBMouCiTPmwdpTNVmC4dx
         4is7Wn1YoCilC77xE4zaL/7mILXEmfze9NP98xp2Nml4g8Xd/wR4F6OiuL3fw8k7FjY1
         brWvcbgPZc2gA/2vQTqDwQZ7/Ih6wEvtFYf1BmHg1saNoIRUE71tipJiOHMgeUSNbWsc
         j+g0CHhM+uqFVqH7q6pwNEDh5HG8P3/SsPpiROyMwO+8uRsXMVAzouOCUcx2wpOhKXlJ
         1SzHwGq3a2/chRRFoYzF/xVSgGjU6KTdS+33425z8D6KZlNNe7GQvCsylOww0vQn9cS9
         uugA==
X-Forwarded-Encrypted: i=1; AJvYcCWQAN4ke2On21wm4TERFsHQgfxDNn4qUAjCy6mUFY6xl3UFND0W+j5XG4Wk+4gjy6FW4rQhn4uwo7KDAG5NwzCxmpwdqjn3
X-Gm-Message-State: AOJu0YyqOXJnHeg/YcDK+SAabBb3dsiDR6xOLPtDUd19B+MKA9vujg9C
	n2bEo+OquEEzw7j5RJB0zG2fjS4D3PuPXhfNkuts3TtbVgGibs76pMe/+ZfA8Lo=
X-Google-Smtp-Source: AGHT+IGdncA4Y+RRQwxvVBuwQR7ctR1zSWoNVd6L0U1b5mZoDC5tYdlxznJIjlJBo0jpK+3MajGWdg==
X-Received: by 2002:ac2:5e3c:0:b0:512:a959:af3d with SMTP id o28-20020ac25e3c000000b00512a959af3dmr5733841lfg.52.1709050394044;
        Tue, 27 Feb 2024 08:13:14 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b0033b79d385f6sm11694326wri.47.2024.02.27.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:13:12 -0800 (PST)
Date: Tue, 27 Feb 2024 17:13:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de, michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com,
	cfontain@redhat.com
Subject: Re: [PATCH v4] ice: Add get/set hw address for VFs using devlink
 commands
Message-ID: <Zd4KFZINps0CloD-@nanopsycho>
References: <20240224124406.11369-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224124406.11369-1-ksundara@redhat.com>

Sat, Feb 24, 2024 at 01:44:06PM CET, ksundara@redhat.com wrote:
>Changing the MAC address of the VFs are not available
>via devlink. Add the function handlers to set and get
>the HW address for the VFs.
>
>Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 88 +++++++++++++++++++-
> 1 file changed, 87 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index 80dc5445b50d..c3813edd6a76 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1576,6 +1576,91 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
> 	devlink_port_unregister(&pf->devlink_port);
> }
> 
>+/**
>+ * ice_devlink_port_get_vf_mac_address - .port_fn_hw_addr_get devlink handler
>+ * @port: devlink port structure
>+ * @hw_addr: MAC address of the port
>+ * @hw_addr_len: length of MAC address
>+ * @extack: extended netdev ack structure
>+ *
>+ * Callback for the devlink .port_fn_hw_addr_get operation
>+ * Return: zero on success or an error code on failure.
>+ */
>+
>+static int ice_devlink_port_get_vf_mac_address(struct devlink_port *port,
>+					       u8 *hw_addr, int *hw_addr_len,
>+					       struct netlink_ext_ack *extack)
>+{
>+	struct devlink_port_attrs *attrs = &port->attrs;
>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	struct devlink *devlink = port->devlink;
>+	struct ice_pf *pf;
>+	struct ice_vf *vf;
>+	int vf_id;
>+
>+	pf = devlink_priv(devlink);
>+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
>+		pci_vf = &attrs->pci_vf;
>+		vf_id = pci_vf->vf;
>+	} else {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");
>+		return -EADDRNOTAVAIL;
>+	}
>+	vf = ice_get_vf_by_id(pf, vf_id);
>+	if (!vf) {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
>+		return -EINVAL;
>+	}
>+	ether_addr_copy(hw_addr, vf->dev_lan_addr);
>+	*hw_addr_len = ETH_ALEN;
>+
>+	ice_put_vf(vf);
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_port_set_vf_mac_address - .port_fn_hw_addr_set devlink handler
>+ * @port: devlink port structure
>+ * @hw_addr: MAC address of the port
>+ * @hw_addr_len: length of MAC address
>+ * @extack: extended netdev ack structure
>+ *
>+ * Callback for the devlink .port_fn_hw_addr_set operation
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int ice_devlink_port_set_vf_mac_address(struct devlink_port *port,

Better to have "fn" in the name of the function, so it is clear this
sets the mac of function itself.


>+					       const u8 *hw_addr,
>+					       int hw_addr_len,
>+					       struct netlink_ext_ack *extack)
>+{
>+	struct net_device *netdev = port->type_eth.netdev;
>+	struct devlink_port_attrs *attrs = &port->attrs;
>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	u8 mac[ETH_ALEN];
>+	int vf_id;
>+
>+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
>+		pci_vf = &attrs->pci_vf;
>+		vf_id = pci_vf->vf;
>+	} else {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");

How exactly this can happen? I'm pretty sure it can't.


>+		return -EADDRNOTAVAIL;
>+	}
>+
>+	if (!netdev) {

How exactly this can happen? I'm pretty sure it can't.


>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the netdev");
>+		return -EADDRNOTAVAIL;
>+	}
>+	ether_addr_copy(mac, hw_addr);
>+
>+	return ice_set_vf_mac(netdev, vf_id, mac);

It's misleading to call ice_set_vf_mac like this. It is originally used
by legacy ip vf api, where the netdev is the PF netdev. Here you pass
devlink port representor netdev. Internally ice_set_vf_mac() gets
pointer to struct ice_pf.

Could you please use:
struct ice_pf *pf = devlink_priv(devlink);
and pass it to some variant of ice_set_vf_mac() function?


pw-bot: cr


>+}
>+
>+static const struct devlink_port_ops ice_devlink_vf_port_ops = {
>+	.port_fn_hw_addr_get = ice_devlink_port_get_vf_mac_address,
>+	.port_fn_hw_addr_set = ice_devlink_port_set_vf_mac_address,
>+};
>+
> /**
>  * ice_devlink_create_vf_port - Create a devlink port for this VF
>  * @vf: the VF to create a port for
>@@ -1611,7 +1696,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> 	devlink_port_attrs_set(devlink_port, &attrs);
> 	devlink = priv_to_devlink(pf);
> 
>-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
>+	err = devlink_port_register_with_ops(devlink, devlink_port,
>+					     vsi->idx, &ice_devlink_vf_port_ops);
> 	if (err) {
> 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
> 			vf->vf_id, err);
>-- 
>2.39.3 (Apple Git-145)
>

