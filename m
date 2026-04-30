Return-Path: <netdev+bounces-282707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACWXDBUU82llxAEAu9opvQ
	(envelope-from <netdev+bounces-282707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:34:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6B49F489
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E3963006456
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DE38E106;
	Thu, 30 Apr 2026 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faxmaluo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k1qg7WDn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AF3FE352
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538066; cv=none; b=IitE5BC1439bSnRx6M4ijJ/Yl6H98S/aT5dXBUXiyfv6t0WalCOU4XEGc0+A/vUQ5nK0JhMe0/hvnWt1iC5Wkslnoz4G9cffuufcNP6T9U6F1c9WhtXo599sZ3X0x0t9UYHXbJGbsyKIY0pYpHVSJbLQ1gyoxS8B89hcjZexXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538066; c=relaxed/simple;
	bh=wp6i5yz5igievl5eS1cJGX+vlZhEPpjcwVvLdzAhazY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeVgSFQ6S5foUhy5JNQTaxC4mm6T/UErxTEJDz5aAsO7eCv5n688jLa64v4u93oRyoAanvZUvCZ59wGWfE8eHC8Ki2TM7YY0rzoTE3KNEdU/0r91QbM9J5sss7nI37Nj/JOUl0qV4X8mzfBfquUhCZ66GsqJn1ToGlq6UbOB9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faxmaluo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k1qg7WDn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777538063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emvQxe1ftI4ZTLw3aYvwKyHpME9NJ/2PF6gArXN491w=;
	b=faxmaluocLDkLc+uMrD1+03oCL3y4N/4I24m0XsjbWwCO9eF6asMyTfoHBxtjy4PRwMGF6
	48+JUa8rl9iVbCMmZ+J5gyG3XW4j7Ua/ea5OE+PW1D7WCrhbY/jOc721kycESLZ2rbEmVG
	e/QX3uRgzoAE+L6u35C+nImRE0NeSOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-wQr5suKMPB2IxxcEnTD2TA-1; Thu, 30 Apr 2026 04:34:22 -0400
X-MC-Unique: wQr5suKMPB2IxxcEnTD2TA-1
X-Mimecast-MFC-AGG-ID: wQr5suKMPB2IxxcEnTD2TA_1777538061
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so13471865e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777538061; x=1778142861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emvQxe1ftI4ZTLw3aYvwKyHpME9NJ/2PF6gArXN491w=;
        b=k1qg7WDnQPgPvyyQsTJyGwUbX8x2XVF0Z+lvI7M/tHmshO8WabT6WhzXPpwEt3Bac7
         ki5MFk1xDeE+echG8CUHUZ31eRiyEfo0oX2g9g7HNwBTkM/AGgkBpSInmo/IESB7AIz5
         V9NRLn6YlmkYmTJvjqd/Ip0Mq5godhFWS4UqgoLUJ7xzuq4WHiH+wHBHT1sizR00dtah
         10n4MgI5BwwrW0JXUgZkdYs+jXc92flp6d9wTR5e+AdgB39ltnvUDkgu+mSF+Y508+vH
         YW7YyaSoFpTkUPetEa3DDOWND7+thvy52eoYJji6xKcAZzeUNzzAd+WLE+9cn6Y98biy
         ZSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777538061; x=1778142861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emvQxe1ftI4ZTLw3aYvwKyHpME9NJ/2PF6gArXN491w=;
        b=IX4//Hf45/tfGLn/W2v4cJZXPZml8T5AJFaf+f69/o1+K4v/SsTH+BOIK5QywyHRIZ
         VQ1m0sgy8iN49SYHYtAIJvnbM+tUDkDq18WclPilt1Qzkdqaqs+z9dlWDNcidLHO9UKf
         vNLHWparZxhUfoANO/PHI5EOyMV2a/26vrfxEWX+pQr3prlaYjNsRL5ZrEUht0q8ryc2
         kkftO5V1puIH165bCbWa6pHOA9ERvHf9JA5ehHgV9ZES+niRtfdm2iA2FzQCgB8qt+M7
         gC3GkKYn994MFn9xbFLfQK3gPfPQWXYo6PQUA0l6agewq1tAesfT0ZyHjoU7RjWgIHc7
         QC3g==
X-Forwarded-Encrypted: i=1; AFNElJ/UQIze4UBiZYTRn0MYo00GnPHK2Uq81ctMtxQ3m5sSlAQuSrHhVydzy17ifr85lbTlc42vRnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVOI7ykNAHKOqhgNzYcnl4ReShwpuWf+Q3YcHNvrntYjmXQuK
	xLiKGR7RKrbgAg43OlbED31slCONZIp3pY8hgSsCJnRjIDTKuE6MG45T8Cde34EsSagwunirQpU
	B6yrvBUt0K3P0REj5N+3ExgkX01xiPeIy01zHaJHraP4IqhdvdaT9fC8IJQ==
X-Gm-Gg: AeBDievEmU0cxstkwVhHeY4WFG41h/HpQyNXPXSe6fuhV92c7Wzzwh8yX8pJtxK3i5y
	YM0eLjLhLpOBbdUy0MQVtsnlBivKi8NooKQDx8uQv78IRmZGqj8vDqz84Z7ec+gakubZte8uvaC
	I+/4TVqSFPwuOpcV3bYf6irdnbglgO0K7vG5+H1ZV1zDCPT003LDzRwdSYjZoAvlUVDr+Hzk3ez
	frnlOr+v0wiefdhqJoaoB7N311ke54z5pwVi7ghxSDfUlPZph0LqROj95oNVehPhAgCjTByUbrd
	q0wkDRWgceCJVscZOKKjvS1W9Yxcc2TTrHx7FB8zGbqYjFF0AI0cNnxi2h85ox5EWjGaMLsEJTT
	ML3AV1Uv/39HmVyG8EyBjZ5YSHV8uYwxdX7Ej4eaequfh6JK/pQp4V/7ov8HwqEHXOQ==
X-Received: by 2002:a05:600c:34c6:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a85e7c80amr22868325e9.8.1777538060749;
        Thu, 30 Apr 2026 01:34:20 -0700 (PDT)
X-Received: by 2002:a05:600c:34c6:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a85e7c80amr22867675e9.8.1777538060200;
        Thu, 30 Apr 2026 01:34:20 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2e8a6csm55874855e9.5.2026.04.30.01.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 01:34:19 -0700 (PDT)
Message-ID: <799458d9-729d-4589-987d-2518e31a7bde@redhat.com>
Date: Thu, 30 Apr 2026 10:34:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 5/5] net: wangxun: implement
 pci_error_handlers ops
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Breno Leitao <leitao@debian.org>,
 Joe Damato <joe@dama.to>, Jacob Keller <jacob.e.keller@intel.com>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
References: <20260428021156.13564-1-jiawenwu@trustnetic.com>
 <20260428021156.13564-6-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428021156.13564-6-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D0B6B49F489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	TAGGED_FROM(0.00)[bounces-282707-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/28/26 4:11 AM, Jiawen Wu wrote:
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index e7c9dcb148b5..1aefae402c8e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -3,11 +3,118 @@
>  
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/aer.h>
>  
>  #include "wx_type.h"
>  #include "wx_lib.h"
>  #include "wx_err.h"
>  
> +/**
> + * wx_io_error_detected - called when PCI error is detected
> + * @pdev: Pointer to PCI device
> + * @state: The current pci connection state
> + *
> + * Return: pci_ers_result_t.
> + *
> + * This function is called after a PCI bus error affecting
> + * this device has been detected.
> + */
> +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> +					     pci_channel_state_t state)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +
> +	netdev = wx->netdev;
> +	if (!netif_device_present(netdev))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	rtnl_lock();
> +	netif_device_detach(netdev);
> +
> +	if (netif_running(netdev))
> +		wx->close_suspend(wx);
> +
> +	if (state == pci_channel_io_perm_failure) {
> +		rtnl_unlock();
> +		return PCI_ERS_RESULT_DISCONNECT;

Sashiko says:

On the pci_channel_io_perm_failure path here, WX_STATE_DISABLED is not
set and pci_disable_device() is not called.  When the PCI core then
follows up with .remove(), ngbe_remove()/txgbe_remove() do:
	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
		pci_disable_device(pdev);
Since the bit is still clear, pci_disable_device() is invoked on a
device that has already been torn down by the PCI core on the
perm_failure path.  Should the perm_failure branch also set
WX_STATE_DISABLED (and arguably call pci_disable_device()) for symmetry
with the NEED_RESET branch below and with how drivers like ixgbe handle
this case?

> +	}
> +
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
> +	rtnl_unlock();
> +
> +	/* Request a slot reset. */
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +/**
> + * wx_io_slot_reset - called after the pci bus has been reset.
> + * @pdev: Pointer to PCI device
> + *
> + * Return: pci_ers_result_t.
> + *
> + * Restart the card from scratch, as if from a cold-boot.
> + */
> +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	pci_ers_result_t result;
> +
> +	if (pci_enable_device_mem(pdev)) {
> +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> +		result = PCI_ERS_RESULT_DISCONNECT;
> +	} else {
> +		/* make all bar access done before reset. */
> +		smp_mb__before_atomic();
> +		clear_bit(WX_STATE_DISABLED, wx->state);
> +		pci_set_master(pdev);
> +		pci_restore_state(pdev);
> +		pci_wake_from_d3(pdev, false);
> +
> +		wx->do_reset(wx->netdev, false);
> +		result = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	pci_aer_clear_nonfatal_status(pdev);

Sashiko says:

Should pci_aer_clear_nonfatal_status() be called on the
PCI_ERS_RESULT_DISCONNECT path where pci_enable_device_mem() failed?
It runs unconditionally here, and when CONFIG_PCIEAER=n the stub in
include/linux/aer.h returns -EINVAL, which is also ignored.  Would it
be cleaner to only call this on the recovered path?

> +
> +	return result;
> +}
> +
> +/**
> + * wx_io_resume - called when traffic can start flowing again.
> + * @pdev: Pointer to PCI device
> + *
> + * This callback is called when the error recovery driver tells us that
> + * its OK to resume normal operation.
> + */
> +static void wx_io_resume(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +	int err;
> +
> +	netdev = wx->netdev;
> +	rtnl_lock();
> +	if (netif_running(netdev)) {
> +		err = netdev->netdev_ops->ndo_open(netdev);
> +		if (err) {
> +			wx_err(wx, "Failed to open netdev after reset\n");
> +			goto out;
> +		}
> +	}
> +	netif_device_attach(netdev);
> +out:
> +	rtnl_unlock();

Sashiko says:

What state is the netdev left in when ndo_open() fails here?
wx_io_error_detected() called netif_device_detach(), which clears
__LINK_STATE_PRESENT but leaves __LINK_STATE_START set, so
netif_running() still returns true.  On ndo_open() failure, the 'out'
label skips netif_device_attach() and returns void (so the AER core
gets no error signal).
If ngbe_open()/txgbe_open() partially succeeded and then failed on an
internal error path that freed rings/IRQs/phylink resources, the netdev
is then left with netif_running()==true, __LINK_STATE_PRESENT clear,
and the hardware resources released.  The service_timer and
service_task are still running, and wx_reset_subtask() does:
	if (!netif_running(wx->netdev) ||
	    test_bit(WX_STATE_RESETTING, wx->state))
		return;
	...
	if (test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
		if (wx->do_reset)
			wx->do_reset(wx->netdev, true);
	}
Can a subsequent wx_reset_subtask() tick then dereference the already
freed ring/IRQ state through wx->do_reset()?

/P


