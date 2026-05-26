Return-Path: <netdev+bounces-291902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KCRBdTxFWp7fQcAu9opvQ
	(envelope-from <netdev+bounces-291902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:17:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4BA5DBE36
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3645B3012E5D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8042A3C0A1B;
	Tue, 26 May 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhQCpH8v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBAE3C0A0D;
	Tue, 26 May 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822730; cv=none; b=VxhuzOXONEhhFC5Ch78KV/hKsy9WN1WOznmATTL+dI/wyR2/6IcqaBBF1C0/rV64W4PB51VBIYKYc5iuvwtEAUp6v1ly9ZO8xrGGBj6/gpYg8qE6Qyr4G5RxcXZALIDu08kxCbjfIOVMO7R/sa8/RU1QfW2wttR+h46+yzfFruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822730; c=relaxed/simple;
	bh=D2/KY7HzAmw+OKeeC2vv10GDt6jF/DRms1ZYmtvYdsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRi4kzv4xBUapArVl+0OaTNzF8QeT6LtbXnHZfuGZET04HW27cPc36xx9r1JEXgXwVQoYHWfbhMyAsx7aUSEf+kqpHL/oliAw8Qv2IJqy7Ml2GUqgjfekzMo3sq7j9VNV/+s3A3IJ3aw3N6FtGnCXG0biUvUSP2LF54HKtCmPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhQCpH8v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FEB1F000E9;
	Tue, 26 May 2026 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779822728;
	bh=rdLhsfS1LF4WRuiNqbk90kQPvVDMpLUfgaUXBjogJ2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YhQCpH8vhFhRAXV+oksqTWj/4a+ExyhBzmBZ4pKFo4zdSjNvkwOiBBxNda06IdBJm
	 P5Ur9oQzVzQ0bws7wL1+M8MZGZpNGROL5YxxXjDBb1QVBjteauU2H4tuJ3ExSVnU5S
	 1KmASO59lsaOBS3xoHCz8IC2tLfzLhohAgjaDa3rM6cIbsiY/a/glrBKVzU9nVkLWG
	 ORCD3pPWKQJLCrUuURr1e6nxlPtL0Sca+t2188EdxmjaL5HUid3E3fQ6DPeU3SSoaH
	 2j+h5OgTJededIUe59GOszbk9ynlbQypoiZGbu2mlpwFkgIqgO+kiaYJez4VExATCg
	 qjD8pNj6OEa1Q==
From: Simon Horman <horms@kernel.org>
To: yun.zhou@windriver.com
Cc: 'Simon Horman' <horms@kernel.org>,
	david+nfc@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bongsu.jeon@samsung.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing
Date: Tue, 26 May 2026 20:07:30 +0100
Message-ID: <20260526190728.2294767-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522021326.1164807-1-yun.zhou@windriver.com>
References: <20260522021326.1164807-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291902-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev,nfc];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sashiko.dev:url]
X-Rspamd-Queue-Id: 0B4BA5DBE36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing

This commit adds bounds checking to nci_core_init_rsp_packet_v1() and
nci_core_init_rsp_packet_v2() to prevent reads of uninitialized memory
when parsing malformed CORE_INIT_RSP packets.

Link: https://syzkaller.appspot.com/bug?extid=46ca2592193f2fb3debc

> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> index 9eeb862825c5f..61fbe31b427eb 100644
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -50,11 +50,19 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
[ ... ]
>  	ndev->nfcc_features = __le32_to_cpu(rsp_1->nfcc_features);
>  	ndev->num_supported_rf_interfaces = rsp_1->num_supported_rf_interfaces;
>  
>  	ndev->num_supported_rf_interfaces =
>  		min((int)ndev->num_supported_rf_interfaces,
>  		    NCI_MAX_SUPPORTED_RF_INTERFACES);
>  
> +	if (skb->len < sizeof(*rsp_1) + rsp_1->num_supported_rf_interfaces +
> +		       sizeof(*rsp_2))
> +		return NCI_STATUS_SYNTAX_ERROR;

Simon says: As noted, the issue flagged below pre-dates this patch.
	    I do not suggest increasing the scope of this patchset for
	    this.  But you may want to look at it in the context of
	    follow-up.

[Severity: High]
This isn't a bug introduced by this patch, but does temporarily updating
ndev->num_supported_rf_interfaces without holding ndev->req_lock create a
TOCTOU race?

The nci_core_init_rsp_packet_v1() function is processed asynchronously in
nci_rx_work(), temporarily setting ndev->num_supported_rf_interfaces to
the unclamped value from the packet before it is clamped to
NCI_MAX_SUPPORTED_RF_INTERFACES.

Concurrently, if a thread executing nci_init_complete_req() iterates over
ndev->supported_rf_interfaces using ndev->num_supported_rf_interfaces as
the limit, could it read past the bounds of the 4-element array?

Simon says: On the other hand, the issue flagged below seems to have
            been introduced by this patch and I'd appreciate it if
	    you could look over it.

Additionally, if the new length validation check returns early with
NCI_STATUS_SYNTAX_ERROR, doesn't it leave ndev->num_supported_rf_interfaces
updated but the array contents uninitialized, causing further state
corruption?

>  	memcpy(ndev->supported_rf_interfaces,
>  	       rsp_1->supported_rf_interfaces,
>  	       ndev->num_supported_rf_interfaces);
[ ... ]
> @@ -87,15 +99,26 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
>  				      const struct sk_buff *skb)
>  {
>  	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
> -	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
> +	const u8 *supported_rf_interface;
> +	const u8 *skb_end = skb->data + skb->len;

Simon says: I believe the issue described below is a non-issue
            because I think that skbs are always linear in this context.

[Severity: Medium]
Does using skb->len to compute skb_end assume SKBs are strictly linear?

The skb->len field represents the total packet length, including any paged
fragments. If the SKB is nonlinear, skb_end will point past the end of the
linear buffer allocation.

Iterating through *supported_rf_interface++ up to skb_end could result in
out-of-bounds memory reads.

Could we use skb_tail_pointer() or pskb_may_pull() to guarantee contiguous
bytes in the linear region?

[ ... ]

Simon says: Like the first issue, I believe this one is pre-existing,
            should not effect the progress of this patch, but could
	    be looked at in the context of follow-up.

[Severity: High]
This is a pre-existing issue, but does lockless iteration and concurrent
modification of ndev->conn_info_list lead to linked list corruption and
use-after-free?

The ndev->conn_info_list is iterated locklessly by functions like
nci_get_conn_info_by_conn_id() (called from nci_tx_work()) and
nci_get_conn_info_by_dest_type_params() (called from nci_nfcc_loopback()).

Concurrently, nci_rx_work() can process an injected
NCI_OP_CORE_CONN_CLOSE_RSP packet via nci_core_conn_close_rsp_packet(),
which directly calls list_del() and devm_kfree() on the connection object
without acquiring any synchronization locks.

Because tx_work and rx_work operate on independent workqueues, couldn't an
injected packet free the object while it is actively being iterated by
another CPU, resulting in a use-after-free read and linked list corruption?

