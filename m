Return-Path: <netdev+bounces-266011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJUtKPH3r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:52:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 451A8249B94
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6069B3035AA2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3E437FF7A;
	Tue, 10 Mar 2026 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRDsRv7r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FE3815F5
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139920; cv=none; b=fSYKaAD+99dHHh9bzHzXBLMOxNo5ISdtC8IosDXUjIatkjK+XTF6/fj3ZpXcwnPZN+R4N8pQpeCWTMckjbAAoawEUd/nh2OaZ50yehTfk7H6qADIpWSZP0pcTJB8GqcjZ06Qh7h9lk9Z7btDhE0Q4VdTk55FKL2ESorFFe/mkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139920; c=relaxed/simple;
	bh=i5vYJBwHRXJfWhae2oDiIamXGXr5RqdZJkfOFiWZMP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPh6I1BgvY+huoqljVabap863RJ6mY40na8qd+3FXmNdXrbdk72+gtwZ2YEE9OA/oNmFjfirR89BXD7sOJSNmsiKbAlyLhQsHLTwGdhM82T5ZQ4ix44UdptIDtcj56ZQ5mWoycYSWzNv7C2uEkOf0meBq1lslw3DPVPsXZQu020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRDsRv7r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773139918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKc3aHAj0boBEgJzdS5yoX2Q0KiMJN3KYISfmqHL2AM=;
	b=fRDsRv7rRL4NoXjlFxWgJUoI4fPzEFznTZwvKOZMXe55GUepIG1RwLryrK01hNQIUK6AhA
	T5pjjCiWWtyKe7OtFolZUnIxifWJ1ZrcER5dlwaONk/qslzDIzULIBO0g+ISJXohtT3LDr
	XUBTs048iskg85rtOVa1x4mHJzq7sCI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-PKtLV66oMBqsCx4EFd4JWA-1; Tue,
 10 Mar 2026 06:51:53 -0400
X-MC-Unique: PKtLV66oMBqsCx4EFd4JWA-1
X-Mimecast-MFC-AGG-ID: PKtLV66oMBqsCx4EFd4JWA_1773139911
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 614101956050;
	Tue, 10 Mar 2026 10:51:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35016180075C;
	Tue, 10 Mar 2026 10:51:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jiawenwu@trustnetic.com
Cc: kees@kernel.org,
	michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	richardcochran@gmail.com,
	mengyuanlou@net-swift.com,
	jacob.e.keller@intel.com,
	joe@dama.to,
	linux@armlinux.org.uk,
	abdun.nihaal@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	davem@davemloft.net,
	larysa.zaremba@intel.com,
	netdev@vger.kernel.org,
	leitao@debian.org
Subject: Re: [net-next,v4,10/10] net: wangxun: implement pci_error_handlers ops
Date: Tue, 10 Mar 2026 11:51:41 +0100
Message-ID: <20260310105141.167206-1-pabeni@redhat.com>
In-Reply-To: <20260306063211.20536-11-jiawenwu@trustnetic.com>
References: <20260306063211.20536-11-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 451A8249B94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266011-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,lunn.ch,gmail.com,net-swift.com,intel.com,dama.to,armlinux.org.uk,google.com,davemloft.net,vger.kernel.org,debian.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wangxun: implement pci_error_handlers ops

This commit adds PCIe AER error handling support by implementing
pci_error_handlers operations. The implementation includes error
detection, slot reset, and resume callbacks with device state tracking.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index bb77bdce69d2..86b318647a3c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c

[ ... ]

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
> +		pci_save_state(pdev);
> +		pci_wake_from_d3(pdev, false);
> +
> +		wx->do_reset(wx->netdev, false);
> +		result = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	pci_aer_clear_nonfatal_status(pdev);
> +
> +	return result;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 5a21478a592b..1cd73b424d7f 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -3418,7 +3418,8 @@ static void wx_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
>  	*enable_wake = !!wufc;
>  	wx_control_hw(wx, false);
>
> -	pci_disable_device(pdev);
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
>  }
>
>  int wx_suspend(struct pci_dev *pdev, pm_message_t state)

Does this code correctly handle the WX_STATE_DISABLED bit across suspend/resume
cycles?

The AER recovery path clears this bit in wx_io_slot_reset():

wx_err.c:wx_io_slot_reset() {
	...
	clear_bit(WX_STATE_DISABLED, wx->state);
	...
}

But the normal PM resume path doesn't clear it. Looking at wx_resume() in
wx_lib.c (lines 3436-3464), after calling pci_enable_device_mem()
successfully, the WX_STATE_DISABLED bit remains set from the earlier
suspend.

This means after a suspend/resume cycle:
1. wx_suspend() calls wx_dev_shutdown() which sets WX_STATE_DISABLED
2. wx_resume() calls pci_enable_device_mem() but doesn't clear the bit
3. A subsequent wx_dev_shutdown() (from second suspend or shutdown) will see
   the bit already set and skip pci_disable_device(), leaving the device
   enabled

The same stale bit affects ngbe_remove() and txgbe_remove(), which would skip
pci_disable_device() if the device was previously suspended and resumed.

Should wx_resume() clear WX_STATE_DISABLED after successfully enabling the
device, matching the pattern in wx_io_slot_reset()?


