Return-Path: <netdev+bounces-298659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Uz4JHkHLGqjJwQAu9opvQ
	(envelope-from <netdev+bounces-298659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:19:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08992679B67
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:19:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b4BVk191;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298659-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ABB430DAE8F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1F3ED3B4;
	Fri, 12 Jun 2026 13:19:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64F153BE9;
	Fri, 12 Jun 2026 13:19:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270386; cv=none; b=H7ymIDFJUkSDBM0azwrI/VxHtE122kZ9E59/RxWArdHTheudEtlOFBmPLOQyQiMDSTZsAMtm0lSEfE58cstXXeCnZyxZlTsjXs9s4t8mZI/Nbk1hiGO5R4LXJY6Q6Q7AVBZVgHtg7EdMMeQpK5Jm9py+9zsGjkX9/nIgoPQzJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270386; c=relaxed/simple;
	bh=lB/VZDEXwZgo61e9YOFfO5LUxisQb83oF5X9fTKXBug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDC3NjTxHRytMtE8xQ3dzV7Jm+LvKVZQfjk787AFIAwMQMj709tCjBx1ZRc6BxjfDFbb5aD+hiaggtJk6BbHmELBTpJHRBmzLZ2gtYm+TXTgAUFTuqEBUo9e1tO9SQ/jiByVAnblmMQOzibLd5XxNl4tBWvgMDgxN587a5ABjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4BVk191; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072A61F000E9;
	Fri, 12 Jun 2026 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781270385;
	bh=l2FkAmVGkxh4UCL4UyctSxXoA/a+FkT+bqwYQo5vk9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b4BVk1915ssqV0k2g+jbmv4AJgxxYOuzWM4y79qOVqvpX2UczWEenkW5ZIkMRyYBt
	 3X2OM46P3rVTetfOvz0rE9joSDY2ZbtTF9iANrzrqCQtQCbkHyQiBh6i7IC/Jmcz0q
	 +Eq96cjVa5S/E5teK2fzPA+GZFI8CMLapdqjIEEhwZIrm7Zb38RUs0rzBtPs9WnpUw
	 z/6h2w4quLqgXD/otOav3H+Qq5BlknTuZd322OvNg5kRh/BYLeGvUZGMSX/ok6gO0e
	 vIHm2S6VyZ3vBxseA2cVjTewxLPzjRIs4UBNpu+cb5RUpy4OOVO84XKlqWbLBMChcb
	 LswRka3Tgt2JQ==
From: Simon Horman <horms@kernel.org>
To: hexlabsecurity@proton.me
Cc: Simon Horman <horms@kernel.org>,
	david@ixit.cz,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: nci: add data_len bound checks to activation parameter extractors
Date: Fri, 12 Jun 2026 14:18:15 +0100
Message-ID: <20260612131813.674622-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610064104.143042-1-hexlabsecurity@proton.me>
References: <20260610064104.143042-1-hexlabsecurity@proton.me>
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
	TAGGED_FROM(0.00)[bounces-298659-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:horms@kernel.org,m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08992679B67

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says:

The error type issue below - the first issue - does seem of
concern in the context of this patch.

While I think the other issues, which are flagged as pre-existing,
can be considered in the context of possible follow-up.

---
nfc: nci: add data_len bound checks to activation parameter extractors

This patch adds data_len bounds checking to the NCI activation parameter
extractors to prevent slab out-of-bounds reads. It introduces a data_len
parameter to guard against empty regions before consuming inner length
bytes.

> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index c96512bb86531..753f4cf087489 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -525,15 +525,19 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
>  
>  static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
>  						 struct nci_rf_intf_activated_ntf *ntf,
> -						 const __u8 *data)
> +						 const __u8 *data, __u8 data_len)
>  {
>  	struct activation_params_nfca_poll_iso_dep *nfca_poll;
>  	struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
>  
>  	switch (ntf->activation_rf_tech_and_mode) {
>  	case NCI_NFC_A_PASSIVE_POLL_MODE:
> +		if (data_len < 1)
> +			return -EINVAL;

[Severity: Medium]
Is the correct error type being returned here?

nci_extract_activation_params_iso_dep() is called by
nci_rf_intf_activated_ntf_packet() and its return value is assigned to err,
which is later passed to nci_req_complete(ndev, err).

nci_req_complete() expects an NCI_STATUS_* positive integer constant.
If the POSIX error code -EINVAL (-22) is returned, nci_to_errno() will
truncate it to 234. It will then be incorrectly translated to -ENOSYS
through the default case of its switch statement.

Should a valid NCI status code like NCI_STATUS_INVALID_PARAM or
NCI_STATUS_RF_PROTOCOL_ERROR be used instead? The same behavior appears
in the updated nci_extract_activation_params_nfc_dep() below.

>  		nfca_poll = &ntf->activation_params.nfca_poll_iso_dep;
>  		nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);

[ ... ]

> @@ -806,12 +822,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
>  		switch (ntf.rf_interface) {
>  		case NCI_RF_INTERFACE_ISO_DEP:
>  			err = nci_extract_activation_params_iso_dep(ndev,
> -								    &ntf, data);
> +								    &ntf, data,
> +								    ntf.activation_params_len);

[Severity: Critical]
This isn't a bug introduced by this patch, but could the parsing of
atr_res_len allow for a stack memory disclosure?

In nci_rf_intf_activated_ntf_packet(), the ntf structure is allocated on
the stack without zero-initialization.

If a malformed packet specifies an activation_params_len >= 1 but the inner
atr_res_len is clamped to less than 15 (NFC_ATR_RES_GT_OFFSET), would this
cause an integer underflow?

net/nfc/nci/ntf.c:nci_store_general_bytes_nfc_dep() {
    ...
    ndev->remote_gb_len = min_t(__u8,
        (ntf->activation_params.poll_nfc_dep.atr_res_len
            - NFC_ATR_RES_GT_OFFSET),
        NFC_ATR_RES_GB_MAXSIZE);
    ...
    memcpy(ndev->remote_gb,
           (ntf->activation_params.poll_nfc_dep.atr_res
            + NFC_ATR_RES_GT_OFFSET),
           ndev->remote_gb_len);
}

Because __u8 is unsigned, a negative result from the subtraction underflows
to a large positive value, which min_t() then clamps to
NFC_ATR_RES_GB_MAXSIZE (47).

Could this result in copying up to 47 uninitialized stack bytes into
ndev->remote_gb, which might later be broadcast to userspace?

[Severity: High]
This is a pre-existing issue, but is there also a 1-byte stack disclosure
in the NFC-A passive poll parameter parsing?

In nci_extract_rf_params_nfca_passive_poll(), sel_res is only initialized
if sel_res_len != 0:

net/nfc/nci/ntf.c:nci_extract_rf_params_nfca_passive_poll() {
    if (nfca_poll->sel_res_len != 0) {
        if (data_len < 1)
            return ERR_PTR(-EINVAL);
        nfca_poll->sel_res = *data++;
    }
}

If sel_res_len is 0, nfca_poll->sel_res remains uninitialized. Because
nfca_poll points into the local uninitialized ntf stack variable in
nci_rf_intf_activated_ntf_packet(), it retains whatever garbage was on
the stack.

Later, nci_add_new_protocol() unconditionally copies this uninitialized byte:

net/nfc/nci/ntf.c:nci_add_new_protocol() {
    ...
    target->sel_res = nfca_poll->sel_res;
    ...
}

When userspace queries the targets, this byte is sent out unconditionally:

net/nfc/netlink.c:nfc_genl_send_target() {
    ...
    if (nla_put_u8(msg, NFC_ATTR_TARGET_SEL_RES, target->sel_res))
    ...
}

Would it be safer to zero-initialize the ntf structure at the start of
nci_rf_intf_activated_ntf_packet(), or set sel_res to 0 when sel_res_len
is 0?

>  			break;
>  
>  		case NCI_RF_INTERFACE_NFC_DEP:

