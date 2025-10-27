Return-Path: <netdev+bounces-233286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B691C0FD5A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38CA64F8D87
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C22D6E72;
	Mon, 27 Oct 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZKYkzL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA12D6E6C
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588101; cv=none; b=VTfMzpygh+pFdjtXoT5SffNXbHwAF7YnMg7+LZtCn8gAFnXL17+yuHpNYVul4BbA3WEuEBTRQI4Ng5yp80kzvhCP8uJaSjS+O6E7KFnm1zSPWngjSnHMKrZQdHQ0cD7bcP6C/Ydf/ZFmMSdao45IfG9eyKHcgkJ2Sdpk4NueqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588101; c=relaxed/simple;
	bh=mpuYugK+rI1c71o3F1R6OLtkq3GRFMCdW8Qq7msb1tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diG3C/ut3bzL9fI94N96RW3M90hbZOO35YzJEc0Aw2MgjfADFRZ2d2nax7T+kioC5wwVLtCRqLwE96S8+ipkvPwWWRpqcXSeTdNKaEdYnSKbHygY8/DocDDZMw+Qp4lpDb0bKCO+Q/O4WmDlSTSj1ZO3jYggZJE2fVim3ST1Qu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZKYkzL8; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so1811831e0c.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588098; x=1762192898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCxsGlZttNZYpl8LwNlrLHMdW45ErgIzr+AAVrqKVK8=;
        b=hZKYkzL8xN4f33yb34gA99wE8c0i6zcsa9xneAe7gKq9R0ojWkKdT6DVg7jrcTSvcW
         MsTMFw2T9PvqK0w8WQcJ8XJxalYGQCx2+3+JFvckJTKs09guoRD8oRbTrt2vP/UJZukA
         FpFHsmKMYr8JPRX4IKaUHY2QeJuKop3YuBzRdHtdP0KbpdmNCMPUKF/TgZERKc5dgakQ
         igWq/RDQQ4eEzdYamyU+tVMyRbVIR2KnCWaiMwR+FCfYM/x5TBNPaYm2J90CkvhnCIVw
         O37I+lI7Ya5UtlYpKnr399QwS+g8yvKM+zOIQQt/pjYCJygKFHcm+tUm279lPLjgDB3q
         sk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588098; x=1762192898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCxsGlZttNZYpl8LwNlrLHMdW45ErgIzr+AAVrqKVK8=;
        b=n4bhCTPYsNQjHfTT9R3nyJHJIBnIrQ88bype05vCn61164AKqknqcDT7zx5rNUPVmt
         xabKhpBBAc1Bn0TwNtoTwvIekZYY/AxgtJLM6Eas4SdDrhOiJsBZG9/U+fxmtX2nURxK
         6VUm6rwBBLxJRQ16UcBuUIdyhHHSxrJOLFkbz8sWLriiAFgQ2wFbByqrUWqy2+AZeMo7
         3wpOHLBcEdj+SFbeMf5pr2qB0g6aR0/QyJ01GtAnzlvrjEDUvB2jeuITfRW5yIarc1lI
         3hLX0FjOXTnOsppsMHeHysdHyOSYwEJxxjp/u0xAnEmlj0BH8Rm+XUlAA19CgMcs977H
         v+3g==
X-Gm-Message-State: AOJu0YyLrTickgQ7bGDjevoCWgyEyE54UfpKeenm7rhqtVhJlASvUw1u
	75zkEP5D6OSpPufy7jcGB76Uky1OzQFjbDMVYhx78O3JwWCEiw8tN0j8
X-Gm-Gg: ASbGncusw/j7W6gsLELYph+1zPifK2qwdQ3ODaF4PgMgCsmQ44ffNG2VMHTbhXm8NbB
	NExGgYVWj5JxnF+RIs4AVcqBf4T7l+j98zYx0X0J+zF3CKgzZSSV2k/+W/1dIEMSsrJpBlyrNki
	dbKnToaNu55LNmgI2oLRP6FW66oWBZGT+gtEoayckuBAt2fVp+XPKSCQ+WE1DX6Y36GBbGRT+Gk
	2/Wtx/KKzGwx1UBWGlVi/Er1y+LoEPKmnGlNJuwWipgXIad/frRtem6oJZOTh+V38XTbiGHlL4b
	tjqgxy42ShJ1jOKUzT6Qo5xJZ7C20Iq4XbwowmdhCVM53UTbD468pfN8EylX51KRIxi3hFEBCgi
	BGT6+irnMedTQUJVeQZyhtgTGwwXHF+sMCX9UJLO9kWq1GEf/9Yn+nxTzrHmd8r9yum/l7O/UoQ
	547Gnwcscrjclz5RbzifViruKiXr8=
X-Google-Smtp-Source: AGHT+IHbDqHLZgs9aUovHNeDJ5hg2LyzrxlmTkgEfq+AaY33fP1x9wbRtIhC3vMqCL/GrJDfRZ1I0g==
X-Received: by 2002:a05:6122:4692:b0:557:c0c8:5092 with SMTP id 71dfb90a1353d-558035420bemr271417e0c.15.1761588097477;
        Mon, 27 Oct 2025 11:01:37 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb9fc7esm3157761e0c.23.2025.10.27.11.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 11:01:36 -0700 (PDT)
Message-ID: <370bb59c-ff99-449d-a3ae-f091bb33f029@gmail.com>
Date: Mon, 27 Oct 2025 14:01:32 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ethernet: emulex: benet: fix adapter->fw_on_flash
 truncation warning
To: Ankan Biswas <spyjetfayed@gmail.com>, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, khalid@kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20251024180926.3842-1-spyjetfayed@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251024180926.3842-1-spyjetfayed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 14:09, Ankan Biswas wrote:
> The benet driver copies both fw_ver (32 bytes) and fw_on_flash (32 bytes)
> into ethtool_drvinfo->fw_version (32 bytes), leading to a potential
> string truncation warning when built with W=1.
> 
> Store fw_on_flash in ethtool_drvinfo->erom_version instead, which some
> drivers use to report secondary firmware information.
> send
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
> ---

Hey Ankan,
When submitting patches with version 2 or afterwards, you should
generally put information about what changed from version 1 to version
2. This changelog helps people keep track of what changed in subsequent
versions.

Also, did you do any testing for this patch?

>  .../net/ethernet/emulex/benet/be_ethtool.c    | 100 ++++++++++--------
>  1 file changed, 54 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
> index f9216326bdfe..42803999ea1d 100644
> --- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
> +++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
> @@ -221,12 +221,20 @@ static void be_get_drvinfo(struct net_device *netdev,
>  	struct be_adapter *adapter = netdev_priv(netdev);
>  
>  	strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> -	if (!memcmp(adapter->fw_ver, adapter->fw_on_flash, FW_VER_LEN))
> +	if (!memcmp(adapter->fw_ver, adapter->fw_on_flash, FW_VER_LEN)) {
>  		strscpy(drvinfo->fw_version, adapter->fw_ver,
>  			sizeof(drvinfo->fw_version));
> -	else
> -		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
> -			 "%s [%s]", adapter->fw_ver, adapter->fw_on_flash);
> +
> +	} else {
> +		strscpy(drvinfo->fw_version, adapter->fw_ver,
> +			sizeof(drvinfo->fw_version));
> +
> +		/*
> +		 * Report fw_on_flash in ethtool's erom_version field.
> +		 */
> +		strscpy(drvinfo->erom_version, adapter->fw_on_flash,
> +			sizeof(drvinfo->erom_version));
> +	}
>  
>  	strscpy(drvinfo->bus_info, pci_name(adapter->pdev),
>  		sizeof(drvinfo->bus_info));
> @@ -241,7 +249,7 @@ static u32 lancer_cmd_get_file_len(struct be_adapter *adapter, u8 *file_name)
>  	memset(&data_len_cmd, 0, sizeof(data_len_cmd));
>  	/* data_offset and data_size should be 0 to get reg len */
>  	lancer_cmd_read_object(adapter, &data_len_cmd, 0, 0, file_name,
> -			       &data_read, &eof, &addn_status);
> +				   &data_read, &eof, &addn_status);
>  
>  	return data_read;
>  }
> @@ -252,7 +260,7 @@ static int be_get_dump_len(struct be_adapter *adapter)
>  
>  	if (lancer_chip(adapter))
>  		dump_size = lancer_cmd_get_file_len(adapter,
> -						    LANCER_FW_DUMP_FILE);
> +							LANCER_FW_DUMP_FILE);

Also, are you simply changing the tab length here? Any particular reason?

>  	else
>  		dump_size = adapter->fat_dump_len;
>  
> @@ -301,13 +309,13 @@ static int lancer_cmd_read_file(struct be_adapter *adapter, u8 *file_name,
>  }
>  
>  static int be_read_dump_data(struct be_adapter *adapter, u32 dump_len,
> -			     void *buf)
> +				 void *buf)
>  {
>  	int status = 0;
>  
>  	if (lancer_chip(adapter))
>  		status = lancer_cmd_read_file(adapter, LANCER_FW_DUMP_FILE,
> -					      dump_len, buf);
> +						  dump_len, buf);
>  	else
>  		status = be_cmd_get_fat_dump(adapter, dump_len, buf);
>  
> @@ -635,8 +643,8 @@ static int be_get_link_ksettings(struct net_device *netdev,
>  
>  			supported =
>  				convert_to_et_setting(adapter,
> -						      auto_speeds |
> -						      fixed_speeds);
> +							  auto_speeds |
> +							  fixed_speeds);
>  			advertising =
>  				convert_to_et_setting(adapter, auto_speeds);
>  
> @@ -683,9 +691,9 @@ static int be_get_link_ksettings(struct net_device *netdev,
>  }
>  
>  static void be_get_ringparam(struct net_device *netdev,
> -			     struct ethtool_ringparam *ring,
> -			     struct kernel_ethtool_ringparam *kernel_ring,
> -			     struct netlink_ext_ack *extack)
> +				 struct ethtool_ringparam *ring,
> +				 struct kernel_ethtool_ringparam *kernel_ring,
> +				 struct netlink_ext_ack *extack)
>  {
>  	struct be_adapter *adapter = netdev_priv(netdev);
>  
> @@ -737,7 +745,7 @@ static int be_set_phys_id(struct net_device *netdev,
>  						 &adapter->beacon_state);
>  		if (status)
>  			return be_cmd_status(status);
> -		return 1;       /* cycle on/off once per second */
> +		return 1;		/* cycle on/off once per second */

I'm not sure, but it looks like you are adding formatting changes to
code that you are not necessarily changing. Is my interpetation correct?>
>  	case ETHTOOL_ID_ON:
>  		status = be_cmd_set_beacon_state(adapter, adapter->hba_port_num,
> @@ -764,7 +772,7 @@ static int be_set_dump(struct net_device *netdev, struct ethtool_dump *dump)
>  	int status;
>  
>  	if (!lancer_chip(adapter) ||
> -	    !check_privilege(adapter, MAX_PRIVILEGES))
> +		!check_privilege(adapter, MAX_PRIVILEGES))
>  		return -EOPNOTSUPP;
>  
>  	switch (dump->flag) {
> @@ -873,7 +881,7 @@ static int be_test_ddr_dma(struct be_adapter *adapter)
>  }
>  
>  static u64 be_loopback_test(struct be_adapter *adapter, u8 loopback_type,
> -			    u64 *status)
> +				u64 *status)
>  {
>  	int ret;
>  
> @@ -883,7 +891,7 @@ static u64 be_loopback_test(struct be_adapter *adapter, u8 loopback_type,
>  		return ret;
>  
>  	*status = be_cmd_loopback_test(adapter, adapter->hba_port_num,
> -				       loopback_type, 1500, 2, 0xabc);
> +					   loopback_type, 1500, 2, 0xabc);
>  
>  	ret = be_cmd_set_loopback(adapter, adapter->hba_port_num,
>  				  BE_NO_LOOPBACK, 1);
> @@ -920,7 +928,7 @@ static void be_self_test(struct net_device *netdev, struct ethtool_test *test,
>  
>  		if (test->flags & ETH_TEST_FL_EXTERNAL_LB) {
>  			if (be_loopback_test(adapter, BE_ONE_PORT_EXT_LOOPBACK,
> -					     &data[2]) != 0)
> +						 &data[2]) != 0)
>  				test->flags |= ETH_TEST_FL_FAILED;
>  			test->flags |= ETH_TEST_FL_EXTERNAL_LB_DONE;
>  		}
> @@ -999,10 +1007,10 @@ static int be_get_eeprom_len(struct net_device *netdev)
>  	if (lancer_chip(adapter)) {
>  		if (be_physfn(adapter))
>  			return lancer_cmd_get_file_len(adapter,
> -						       LANCER_VPD_PF_FILE);
> +							   LANCER_VPD_PF_FILE);
>  		else
>  			return lancer_cmd_get_file_len(adapter,
> -						       LANCER_VPD_VF_FILE);
> +							   LANCER_VPD_VF_FILE);
>  	} else {
>  		return BE_READ_SEEPROM_LEN;
>  	}
> @@ -1022,10 +1030,10 @@ static int be_read_eeprom(struct net_device *netdev,
>  	if (lancer_chip(adapter)) {
>  		if (be_physfn(adapter))
>  			return lancer_cmd_read_file(adapter, LANCER_VPD_PF_FILE,
> -						    eeprom->len, data);
> +							eeprom->len, data);
>  		else
>  			return lancer_cmd_read_file(adapter, LANCER_VPD_VF_FILE,
> -						    eeprom->len, data);
> +							eeprom->len, data);
>  	}
>  
>  	eeprom->magic = BE_VENDOR_ID | (adapter->pdev->device<<16);
> @@ -1074,7 +1082,7 @@ static void be_set_msg_level(struct net_device *netdev, u32 level)
>  }
>  
>  static int be_get_rxfh_fields(struct net_device *netdev,
> -			      struct ethtool_rxfh_fields *cmd)
> +				  struct ethtool_rxfh_fields *cmd)
>  {
>  	struct be_adapter *adapter = netdev_priv(netdev);
>  	u64 flow_type = cmd->flow_type;
> @@ -1140,8 +1148,8 @@ static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>  }
>  
>  static int be_set_rxfh_fields(struct net_device *netdev,
> -			      const struct ethtool_rxfh_fields *cmd,
> -			      struct netlink_ext_ack *extack)
> +				  const struct ethtool_rxfh_fields *cmd,
> +				  struct netlink_ext_ack *extack)
>  {
>  	struct be_adapter *adapter = netdev_priv(netdev);
>  	u32 rss_flags = adapter->rss_info.rss_flags;
> @@ -1154,7 +1162,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
>  	}
>  
>  	if (cmd->data != L3_RSS_FLAGS &&
> -	    cmd->data != (L3_RSS_FLAGS | L4_RSS_FLAGS))
> +		cmd->data != (L3_RSS_FLAGS | L4_RSS_FLAGS))
>  		return -EINVAL;
>  
>  	switch (cmd->flow_type) {
> @@ -1174,7 +1182,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
>  		break;
>  	case UDP_V4_FLOW:
>  		if ((cmd->data == (L3_RSS_FLAGS | L4_RSS_FLAGS)) &&
> -		    BEx_chip(adapter))
> +			BEx_chip(adapter))
>  			return -EINVAL;
>  
>  		if (cmd->data == L3_RSS_FLAGS)
> @@ -1185,7 +1193,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
>  		break;
>  	case UDP_V6_FLOW:
>  		if ((cmd->data == (L3_RSS_FLAGS | L4_RSS_FLAGS)) &&
> -		    BEx_chip(adapter))
> +			BEx_chip(adapter))
>  			return -EINVAL;
>  
>  		if (cmd->data == L3_RSS_FLAGS)
> @@ -1211,7 +1219,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
>  }
>  
>  static void be_get_channels(struct net_device *netdev,
> -			    struct ethtool_channels *ch)
> +				struct ethtool_channels *ch)
>  {
>  	struct be_adapter *adapter = netdev_priv(netdev);
>  	u16 num_rx_irqs = max_t(u16, adapter->num_rss_qs, 1);
> @@ -1237,14 +1245,14 @@ static int be_set_channels(struct net_device  *netdev,
>  	 * combined and either RX-only or TX-only channels.
>  	 */
>  	if (ch->other_count || !ch->combined_count ||
> -	    (ch->rx_count && ch->tx_count))
> +		(ch->rx_count && ch->tx_count))
>  		return -EINVAL;
>  
>  	if (ch->combined_count > be_max_qp_irqs(adapter) ||
> -	    (ch->rx_count &&
> -	     (ch->rx_count + ch->combined_count) > be_max_rx_irqs(adapter)) ||
> -	    (ch->tx_count &&
> -	     (ch->tx_count + ch->combined_count) > be_max_tx_irqs(adapter)))
> +		(ch->rx_count &&
> +		 (ch->rx_count + ch->combined_count) > be_max_rx_irqs(adapter)) ||
> +		(ch->tx_count &&
> +		 (ch->tx_count + ch->combined_count) > be_max_tx_irqs(adapter)))
>  		return -EINVAL;
>  
>  	adapter->cfg_num_rx_irqs = ch->combined_count + ch->rx_count;
> @@ -1265,7 +1273,7 @@ static u32 be_get_rxfh_key_size(struct net_device *netdev)
>  }
>  
>  static int be_get_rxfh(struct net_device *netdev,
> -		       struct ethtool_rxfh_param *rxfh)
> +			   struct ethtool_rxfh_param *rxfh)
>  {
>  	struct be_adapter *adapter = netdev_priv(netdev);
>  	int i;
> @@ -1285,8 +1293,8 @@ static int be_get_rxfh(struct net_device *netdev,
>  }
>  
>  static int be_set_rxfh(struct net_device *netdev,
> -		       struct ethtool_rxfh_param *rxfh,
> -		       struct netlink_ext_ack *extack)
> +			   struct ethtool_rxfh_param *rxfh,
> +			   struct netlink_ext_ack *extack)
>  {
>  	int rc = 0, i, j;
>  	struct be_adapter *adapter = netdev_priv(netdev);
> @@ -1295,7 +1303,7 @@ static int be_set_rxfh(struct net_device *netdev,
>  
>  	/* We do not allow change in unsupported parameters */
>  	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> -	    rxfh->hfunc != ETH_RSS_HASH_TOP)
> +		rxfh->hfunc != ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
>  
>  	if (rxfh->indir) {
> @@ -1309,27 +1317,27 @@ static int be_set_rxfh(struct net_device *netdev,
>  		}
>  	} else {
>  		memcpy(rsstable, adapter->rss_info.rsstable,
> -		       RSS_INDIR_TABLE_LEN);
> +			   RSS_INDIR_TABLE_LEN);
>  	}
>  
>  	if (!hkey)
> -		hkey =  adapter->rss_info.rss_hkey;
> +		hkey =	adapter->rss_info.rss_hkey;
>  
>  	rc = be_cmd_rss_config(adapter, rsstable,
> -			       adapter->rss_info.rss_flags,
> -			       RSS_INDIR_TABLE_LEN, hkey);
> +				   adapter->rss_info.rss_flags,
> +				   RSS_INDIR_TABLE_LEN, hkey);
>  	if (rc) {
>  		adapter->rss_info.rss_flags = RSS_ENABLE_NONE;
>  		return -EIO;
>  	}
>  	memcpy(adapter->rss_info.rss_hkey, hkey, RSS_HASH_KEY_LEN);
>  	memcpy(adapter->rss_info.rsstable, rsstable,
> -	       RSS_INDIR_TABLE_LEN);
> +		   RSS_INDIR_TABLE_LEN);
>  	return 0;
>  }
>  
>  static int be_get_module_info(struct net_device *netdev,
> -			      struct ethtool_modinfo *modinfo)
> +				  struct ethtool_modinfo *modinfo)
>  {
>  	struct be_adapter *adapter = netdev_priv(netdev);
>  	u8 page_data[PAGE_DATA_LEN];
> @@ -1417,8 +1425,8 @@ static int be_set_priv_flags(struct net_device *netdev, u32 flags)
>  
>  const struct ethtool_ops be_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
> -				     ETHTOOL_COALESCE_USE_ADAPTIVE |
> -				     ETHTOOL_COALESCE_USECS_LOW_HIGH,
> +					 ETHTOOL_COALESCE_USE_ADAPTIVE |
> +					 ETHTOOL_COALESCE_USECS_LOW_HIGH,
>  	.get_drvinfo = be_get_drvinfo,
>  	.get_wol = be_get_wol,
>  	.set_wol = be_set_wol,


