Return-Path: <netdev+bounces-276860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OY3AtxR12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EDF3C6DF5
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CBE2300766B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D8E371CE6;
	Thu,  9 Apr 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTeZnJK4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360D35F5F2
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718873; cv=pass; b=k+Bl45d2mkii8KTjQnbqBR4N16qEaj1NcGmzKM75c6suVf+GiQJPI+E4JP7yth+l0/HqGEL2TTGmtvafWANF0xDv0B5kWx/IU1s6uEvRVJ2PjyAK5Ouy4zwXXgAQ+boXaUYovsBAQ1qr/NALYZTSJmAqCFThBVlkuNvJNFeft/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718873; c=relaxed/simple;
	bh=O/rCGEdj6v7veKxo2TKTxPoU+xHM5u/di/Zn9g+TZc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B27k5DTK3CdEakQMPx9Nj5Z7ayrjXeMkFvsDsv+L9WZ2E5U17u+QynPTiLbfB3AA1GgBGzYVdeWu1RAPE6d7KryFvD9nUYpxhJIIXcG/iSHWlvDIeXZMmX7P+UtQRkqeDlsAThtWQPunH3ogYaW6EBHR/Lk20C4f2ROINYarqfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTeZnJK4; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b3488fb31so6342671cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775718871; cv=none;
        d=google.com; s=arc-20240605;
        b=T1J8peFm+xIvuRd7FwOSHPOOSZqiVgkjwl1B3lhFRmCE7Tf62BhXveuVal/eGHSm8U
         uUj3AHL83Oa9OF4oe1SZTPCQlIw01HHmQsr0zL3mxXsaBDCEcCzpWYpd17wYQNzo4dmc
         KmM2J3gSf75LLOk92XwZ9sinjwjwG/KKNqiEneCaKbxJn159CDfHsUELONxpROxZZFAL
         Sau+K8Bb8i9+LKKJ8UIKFPqZt891mKQQ29auQcTQrSfO263L2SY+I0pOsiEGPEagFaWi
         Mo/G97EnO8hkfS+iVmioFacOH2lzdVCM0MWgqMAyDpxqjFGQrExEaUO6sR4hzGKHPl5l
         u8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O/rCGEdj6v7veKxo2TKTxPoU+xHM5u/di/Zn9g+TZc8=;
        fh=y41q9BIzSSo9G0LJxKRzDJWi3qm39XuL/zcHpUx56Eg=;
        b=OfVubck6MG4+KFzxUDEPgBIE/yCdac4sWzxYdAZj+wj1SgevURuViwqgSMmAMBszjO
         W90Tfi+m/7HvIUc0iClq75jQ1ivxEDZ6KhZXytasefGNm0GcYmeVFpsLyev+OpWqD2QH
         POTiHHiySJGeUtMeNI6IHc6fqbOh7Z1vSHtmsQJn1lH+XLv8qdNr7tlLM3t8eZuPEBBP
         bFMXqqPMdhkDcHFzDiSVjTwdTbmHdBu2qFcf+Nf7d2gWI6g7NsgXksleJYLXdp/EyOOZ
         1V/qN0GaD8oKhj3Fr7FCAXO24akbgxZIy6+tHUxRzxTDyPngyOta43eV5M70J5KKIPXa
         zsSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775718871; x=1776323671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/rCGEdj6v7veKxo2TKTxPoU+xHM5u/di/Zn9g+TZc8=;
        b=BTeZnJK46ur4hLsUAWidIip6BN8630eoIxocK/CvzDV1kdohmRppEx8274eHQxRxEE
         AXAnpyw38tDEMqGdpg/Et+2575YpGo9hGhPAl4wzhDlkWE2MPuGvML9BCyVZWxx6HDHe
         3fxx9sZ/maEu2TlNPsLsF0P+gXtDUmRljqGoxhywmIdo61oBdwDWqjYdwk8xlRB6SWNg
         pRQEv7C4UJXQB7YnjinTgYVseEUSK3IpSEFlGz0c3PiRl+PzcE/PdKhxTTOlXZsK+JXP
         7QwS3RS9yhVMgncDYlxYEadVk9rZDbsWPkyFdLpF4o4Kol7RxVhvzOQ1FOnjmSaoGOlO
         SyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775718871; x=1776323671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/rCGEdj6v7veKxo2TKTxPoU+xHM5u/di/Zn9g+TZc8=;
        b=Dbmd+fEsIhPLzjKaz7VMwnXaQjV3bQSMjL9VBUvgt+hYSeWElBFlsz+W42/3E7cS3W
         kfUYNZhPq4+zQLYI4pJ+zc323dNvXYZM0blNfm6NcHuMH0hIVYC7JbmlTLFYvNDrEGdm
         UCEEq7HkxapiY2nF28FPTR5Cyz7KvLcvyeTuJxtolIlIvS21lki+86f6s2YDnJyXSIfn
         mCfg/4ZufPKMeRJ6cwS9dY6bwRlLO0x7AqXjGjwpiTjXNT1KsbS9W66itsAGwZH3gP+U
         QMHx2dAQVLEY3Bfh4o9A5tRjOxv9FIs8qxfrstkAgBL82zNqlaqgwAO/3rmwkKFoxSJC
         n4Aw==
X-Gm-Message-State: AOJu0Yx/j8XCD56gUresneu+wsgVFtfzVVG/bHq7bL16s6Xa7cRBL3aZ
	pwPK8pk9Ei/dkOZBPT6Ab8cNLnpI0QQQ3a+x61ZPUrOUkNy/F8VfHHUN8iLFXV/EMfFwdYnwOCi
	7i9A816vEDsHzskkJKPSHKtGujEyvD8wLsiq3LlusZJ2Nj86hU2mCrQ9E1D0=
X-Gm-Gg: AeBDieueUr8jJFFoHhxgudHJB0oeCvd6sPCZvHkMF1CfQQci2jWTp4xg26JX9RCHiDh
	aJihvGMd8ZJ1tvW9+xUa7nDLP/RlmtTwPIVkkGgi/l6ujZh0n76bnHuXUAb+ZAnDWpwL2ijXpnM
	Gnq0S3h/2Z51CwBMWab5xcU1jvk2OOwEh7nCucgpF4el9L51UTz3c8f5QKjpu2wu5+nOM/xIhZQ
	6cDGipBh+1ptcipbLHhvDCUwM4VkHyHwMCCiwFtr7MGCsBd00gZxgVn+VSnZVrT64orBpXnalgH
	VqLpGe8=
X-Received: by 2002:ac8:7f54:0:b0:50d:8afe:6424 with SMTP id
 d75a77b69052e-50dc1aaca6fmr29332701cf.26.1775718870594; Thu, 09 Apr 2026
 00:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408223113.2009304-1-ashutoshdesai993@gmail.com>
In-Reply-To: <20260408223113.2009304-1-ashutoshdesai993@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 00:14:17 -0700
X-Gm-Features: AQROBzCSZjqC7WxLyd69mDFlcPaaFqG3Z0K7OPePW3_0TJSmqyIBxWCuQcM2DB8
Message-ID: <CANn89i+ZrVZMZKeGHuxv1cMARUkYv2+nyrDfYAK_QAbqSBPz1w@mail.gmail.com>
Subject: Re: [PATCH] nfc: hci: fix OOB heap read on short HCP frames.
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276860-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 76EDF3C6DF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 3:31=E2=80=AFPM Ashutosh Desai
<ashutoshdesai993@gmail.com> wrote:
>
> Both nfc_hci_recv_from_llc() and nfc_hci_msg_rx_work() read byte 1 of
> an sk_buff (the HCP message header field) without first verifying the
> buffer contains at least NFC_HCI_HCP_HEADER_LEN (2) bytes.
>
> The SHDLC LLC layer only filters zero-length frames; a single-byte
> I-frame from a malicious NFC peer therefore reaches the HCI reassembly
> path where packet->message.header is read one byte past the valid data.
> The same issue is present in the NCI HCI implementation (nci/hci.c)
> via nci_hci_data_received_cb() and nci_hci_msg_rx_work().
>
> Add an explicit length check before accessing the message header at
> all four locations, freeing the skb on malformed input.
>
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---

Same answer: Testing skb->len alone is not enough.

skbs can have fragments, pskb_may_pull() or skb_linearize() would be needed=
.

