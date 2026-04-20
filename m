Return-Path: <netdev+bounces-279631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEcFKnSO5WnXlQEAu9opvQ
	(envelope-from <netdev+bounces-279631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:24:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF1B4263BD
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D8E13001FAC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4C346FB5;
	Mon, 20 Apr 2026 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/fcdclG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C660A40DFDB
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651887; cv=pass; b=tp0UPxx64Zf8Kj/uieSqAC/hMsZiRLCpxHlFAZPfqleVKrUSuP459arBuWF8AeEVoATg6G82I+hY7u6QvDSHETjMszI6D58UDIVEIwy0OVzstcaFps0+H2woJxQL31gsPwpJm4BQer2GxtDxVYTjwRA9SJUZpaFDeAWLbiPrCvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651887; c=relaxed/simple;
	bh=+/OZNPz0g85UpTrciHl8vuB76dwrC4RJyHbllPrqc7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R76P4oa7GhKD3cGDD5rN/9ezAwlfReQOR1uM/v0TEw3hVX/JY32b9Z/SV2wPOEv5ZA+PbntdQ+ODdUSQhpQWcEcrXvgmfCWw315PjPaN4cMt0ICHmrSN+62zbJ39lGEDbZsXyZrWw+6rb/fupd02Wlt8CTwkN7frvIPObeW+ZIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/fcdclG; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671c24f23b1so3855661a12.0
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 19:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651884; cv=none;
        d=google.com; s=arc-20240605;
        b=i8xG8b2JSI4HwjYwQOUnEZ23prndrhhggmWcQfk7fs1P2/j7oUn6OqbVPCK8eun8ic
         LkupTHie4VcrL0Az0yN17x9wwhXAf/WqVefsHWxWGWwgsJ+cch4xralz7qE30/wP2nKX
         5uvPPt/tONqSBPbbEuDnilj9YHyI3DyUrGvh3kzbqNd4H9RIHi0zAnNEmETNmY9meq7Z
         h61Bmm3xtDm+SZ7eL9bn3LZaq8cIY7pGu+Y6QUgnUX5vW5y6KHGw240B5lB6G57gBW4U
         fSaP0C/jhA7tfxit5rMsSva8hazWgNYz8EPLQB16DfrMOTf5WexP+KYSp0uNok2cbt9k
         g0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+/OZNPz0g85UpTrciHl8vuB76dwrC4RJyHbllPrqc7Q=;
        fh=4qdo6KEopMsl3yB5WtxT+1oteIWUzs9Bje9oo+CWVEE=;
        b=iqfAJHH2siSgSEOefhLUW5hojbnhjAKuADG2X+z5x9twUJH2VQcO4yQY/XaFH15kGf
         ZNDQaTs8GTxWYE4LSxrcReqPjGSYtbGllyta7Vj/v5cFd5Qh2THmJd2gTLy42OiJzn8B
         Iz9MlAdegX51XwtTML6baELM+lpFWFYkYshE0ilBhKEuY1Y1v4VBwxXDf74iFKHK92D4
         cET3P7O1OipTR9VDA0LoY4XgfcLXG0nKp5LK2/1mVmEZMYJfptgwo9DYaHQyAM6mu7PE
         o5Ba5hvDsl4h+03z+xacGmNAGTDXyNtwfjzAmJpM2Frizp/CXwhgRHeSJJlBdXw8c5v5
         iH1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776651884; x=1777256684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/OZNPz0g85UpTrciHl8vuB76dwrC4RJyHbllPrqc7Q=;
        b=o/fcdclGj8K2rc2ZKy5A+7sYnt2jSWxbc4g96ieFWQISL8pdEFBzsEIg4KcuOcN6wW
         B3DXjWx55O96j3+udvf+Dkvk4yQ6AZXcXsVXNS5tNq3Sk4mNhDF+Y2wr/lx/xHaviZpV
         K0UJkZZolLExTrUX/8KBH74WfXI3HaPO98Ie0TsFIre9xDPkK/w8zTmA8AMZBKBoUpv6
         jNdbUEjBKDF9WrmuAgKMf2koE75GENnL8ZcZsaLl+KYnU4gRjITt1B1YNpMgp5UjQTGf
         sHH0YJZzb4tLPVL89mnMXyJhGG/O7UxYNMK+hd7Zx9H9MUBNP9K9gH2pVa3ibd9bo5jq
         8zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776651884; x=1777256684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/OZNPz0g85UpTrciHl8vuB76dwrC4RJyHbllPrqc7Q=;
        b=aWE0jh7MVBpACyzU6DNIAROdXUCuuPKWjAZeW0R7hvawLDChpEsFiHaGZOBj52nfr0
         NPaAwNs4NBeAdRK+ZfqVXl3p9okx5laSXk2Fr5ggCDAz3Xnd0YtylJFAffhl51x6EknG
         zjSTNYW0sY5E0GkDTT2D+9Fku+3Tmd7p/j+P9MofVyiKwNumWxrvF/AuSAR2AdKJMipE
         rHwP9Ff/Bj/vBYc8WETnuSJccQkBEXR4QHFCHqPh8IHPchXNaRr7OhyOhMPme/5q4leA
         +7ffhgzqcvxdkVp9/XOMhBwspOTpZp6KiRYYsnNK6M6G1p8/EKranlaxku0WJjbOcueY
         QUDg==
X-Gm-Message-State: AOJu0YzfM7oNBHI97FNvLTXNGBrWYm6un1LqHfE02bwyQMEw2XRzK8Q5
	wFRbhIBt2AEf7RxZQDkaIQLoR4aUXuVnvue4rkLI013pBwH/q1dgYOfqs5U/2MEsq1KuxD1uMzi
	Ovw8XNSG4BtPzENH33ZDYj7R+N4mep+arBP96
X-Gm-Gg: AeBDiet6cU+HQBrBWStYsexROlOv2gvLVx0wMTABIunqsSPidvFGyhY6/MgzCEy1/DQ
	AHcHaxMViNlpPUMrEDDjca5GdEOBfKLLce/JA4ewUt1DiodKIz3pWohdZ1/ZrGmqTfAJFLFgbpn
	/7evEW8wlxNfuq6TGdB5BUrLh+pn3g8gPDdEX0brm9aSfUV2lO4S2gxRs7Hx96kdQ+2AY8tOXdG
	FbuniSOaD4ngQjjFBHZPMOhfybHCfFQwD3xYZT4d4hu3IlKrXXQz2j2djRv7zAGxqSw9ZuA8frQ
	OvhVQfyYfQlpU046A/JruQWHZoMrP1tA2KNDnWXV6ahoz30ggRngPouKyZVMAaM=
X-Received: by 2002:a05:6402:3203:b0:674:83b3:3c8e with SMTP id
 4fb4d7f45d1cf-67483b33e1cmr1892932a12.28.1776651883920; Sun, 19 Apr 2026
 19:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <400a6387-a444-4576-af6d-26be5410bce3.ref@yahoo.com> <400a6387-a444-4576-af6d-26be5410bce3@yahoo.com>
In-Reply-To: <400a6387-a444-4576-af6d-26be5410bce3@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 19 Apr 2026 23:24:30 -0300
X-Gm-Features: AQROBzD_k39L0lLIJuFna5FadoazF99NwMp8V_QJS2cXOYHq3NXBBwdUNl_JERM
Message-ID: <CAJq09z61zkAB3V6TzmxvWeTxR8acZdY=fb-gLaHtjXB41HLdnA@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: realtek: rtl8365mb: fix mode mask calculation
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279631-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com,pqrs.dk];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9BF1B4263BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK macro was shifting
> the 4-bit mask (0xF) by only (_extint % 2) bits instead of
> (_extint % 2) * 4. This caused the mask to overlap with the adjacent
> nibble when configuring odd-numbered external interfaces, selecting
> the wrong bits entirely.
>
> Align the shift calculation with the existing ...MODE_OFFSET macro.
>
> Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
> Signed-off-by: Abdulkader Alrezej <alrazj.abdulkader@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

This bug specifically affected ext1 (Port 6) for all digital interface
modes except DISABLED (0x0) and RGMII (0x1).

The error caused the mask for ext1 to overlap with the adjacent nibble
of ext0. Since ext0 is currently unused by all supported devices in
this family, the incorrect mask was zeroing bits that were already
expected to be zero, masking the failure.

However, for ext1, the incorrect shift left the effective mask with
only a single bit (bit 4) instead of the full 4-bit nibble (bits 4-7).
This meant the driver could only successfully write values 0x0 or 0x1.
Any mode requiring bits [7:5] (such as MII, RMII, or HSGMII) would
have been effectively written as 0x0 or 0x1, breaking those
configurations.

The original chip for this driver, RTL8365MB-VC, does utilize ext1,
but as the driver currently only implements RGMII mode, the hardware
result remained coincidentally correct:

Before patch: (0x0001 << 4) & 0x001E = 0x0010
After patch: (0x0001 << 4) & 0x00F0 = 0x0010

Tests on my device, TP-Link Archer C5v4, show no problem before and no
regressions, as ext1/port6 is not connected on that specific hardware.

Backporting note: There is no strict need to backport this fix to
stable trees, as only the RGMII mode was actually implemented and it
happened to work despite the logical error.

Regards,

Luiz

