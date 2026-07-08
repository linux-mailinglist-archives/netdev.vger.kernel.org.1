Return-Path: <netdev+bounces-305904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a9PnKlaETmpnOQIAu9opvQ
	(envelope-from <netdev+bounces-305904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E8729080
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:09:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q4OSp1zN;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305904-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305904-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB08E30BB13D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9C47AF57;
	Wed,  8 Jul 2026 17:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C214963AA
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:01:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530119; cv=none; b=ir4b7I5iDWEIJHPvN3SyjAXJm9B4pE4JJP0IXDN5IAdsmjlWZccad8CkEMPN0k//bwViA7BXIo/8+K4NzKc8cMQ9zOWvaA6SjzIM/j7s29qyUUW6zuWx69mHBmovr7Sb9juDm/c3LemA4O3Vueu2zgJKlHK+vMC8mhlXdUmlQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530119; c=relaxed/simple;
	bh=Ek+mfmX+MHrHath1XNVnpuD32e3AQSkghDidiLmkRF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsk9Z4Gm3PZaAyi2E3i69rtmo152TCYNzCwSFz0nJSFQXbr8wuWMDPxhFDNcpXos2wLT8H6WvqTYlpDq8I4FB0KCn8qX0UI71hEuFsR3kRjuVDcWGCd2AImJkaVtgI+S9mgB4GmzX/0bYjuPdaBMrLuOHzcivi/f2NY/gU/A7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4OSp1zN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062EF1F00A3A;
	Wed,  8 Jul 2026 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783530118;
	bh=KSKY6okBm/BEPJo91XO3GLsJKMSPpRwBxe9D/gQTvZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q4OSp1zNbfzcAicNOFtu1flScb2FORUdVExfIawmEbELOW/IDgweFGQPFcWSlk1mT
	 vb8chaPPYgBosuG5L/7BiJPinRZHD2UId9OuwxO/A/D8z+5r0fqaI6l7PTvK4n8/0o
	 Bm87As48V4vjSywvep8h92ec+VO/Cw/Yo2oLDaeukDruDK/UTnzpSVRk9nhsVvPRpw
	 GzbHdByIBImutmWcX6o6h6C3zck19D6u3FgD0p12ZdqAIB6SbSLIyOCT+zqIMq4And
	 F80+UobmRPaj/8xIPdIkOiIreJ0h47KS3wX0LUEhauvZLNPHGcZ1U6RjLhiCAu4ccm
	 qoMQaDQGRdvVQ==
From: Simon Horman <horms@kernel.org>
To: jedrzej.jagielski@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v1 3/6] ixgbe: E610: do not disable LSE on driver down/remove
Date: Wed,  8 Jul 2026 18:01:44 +0100
Message-ID: <20260708170145.1514345-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702091553.57112-4-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-4-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305904-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 256E8729080

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ixgbe: E610: do not disable LSE on driver down/remove

This patch removes the calls to ixgbe_disable_link_status_events() in
ixgbe_down() and ixgbe_remove() for the E610 MAC. The intent is to keep
Link Status Events (LSE) enabled when the interface is down or unloading.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 882021c436d0f..83098bf522e42 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
[ ... ]
> @@ -6733,8 +6720,6 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
>  
>  	ixgbe_clean_all_tx_rings(adapter);
>  	ixgbe_clean_all_rx_rings(adapter);
> -	if (adapter->hw.mac.type == ixgbe_mac_e610)
> -		ixgbe_disable_link_status_events(adapter);

[Severity: High]
Does removing this call allow unhandled asynchronous LSE events to permanently
block the ACI mailbox?

If a link event occurs while the driver is down, the firmware can queue an
event in the ACI queue. Upon the next driver load, before the service task
can clear events, commands like ixgbe_get_flash_data() are called.

In ixgbe_aci_send_cmd_execute(), if the EV bit is asserted, the synchronous
response is overwritten by the unhandled asynchronous event from HIDA_2:

        if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C))
                for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
                        raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));

        if (desc->opcode != cpu_to_le16(opcode) &&
            opcode != ixgbe_aci_opc_get_fw_event)
                return -EIO;

Could this result in an opcode mismatch and return -EIO for all future
commands, causing device initialization to fail?

>  }
>  
>  /**
[ ... ]
> @@ -12080,9 +12065,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
>  	set_bit(__IXGBE_REMOVING, &adapter->state);
>  	cancel_work_sync(&adapter->service_task);
>  
> -	if (adapter->hw.mac.type == ixgbe_mac_e610)
> -		ixgbe_disable_link_status_events(adapter);
> -

[Severity: High]
Can the same mailbox blockage happen here during driver unload?

If LSE is not disabled on remove, a link state change (such as a cable
unplug) after unload could leave the ACI queue with pending events.

Would this cause the same -EIO failure during the subsequent ixgbe_probe()
when the driver is loaded again?

>  	if (adapter->mii_bus)
>  		mdiobus_unregister(adapter->mii_bus);
>

