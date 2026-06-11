Return-Path: <netdev+bounces-298009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y5jyLmhzKmoYpgMAu9opvQ
	(envelope-from <netdev+bounces-298009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:35:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F666FE9E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:35:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=INMC3OS7;
	dkim=pass header.d=redhat.com header.s=google header.b=DpbJQzK2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298009-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298009-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEE69301389D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620C351C06;
	Thu, 11 Jun 2026 08:35:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FE34B410
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:35:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166936; cv=none; b=rxCjKaFLGy0bOboYN7dnlcid1P/LPoDXaedDW4c/73BLD4/w+n8v2YSlIstGhs+SyPS3F3EBvN4e4PGTJiM5Cv6XC9p2oMQ2vgy2dxF1zhX1iA1cP4tkxxXM/n5SFnwpabskybZ5whAXIR107pIYgh8h8LPI09vO6gnVkSlEm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166936; c=relaxed/simple;
	bh=3rO17jRlAOsrSbJB0ZIw2moUqwsxu1pGNuVPbz2lh0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzadL3DGj+pbgP+4SUcsWFyFo4tRIG/6VJroi1b4jwlmhbFhDAPu5vvKbEDHHILBQ+o+P0k3fdZXn9sDCL/o6+5o/zfxSlQpDWS5QjXT356S6HPPJ1hAYD2uZnM7gXSYwheD/ivkU23+yoNEBnEAb3F655Vjx/VMo/BxttvouVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INMC3OS7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpbJQzK2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0nATCJiZ4/9NOe9aaTS6Uk2On+QYrgr6XLP0GHNht0=;
	b=INMC3OS7569GrAvQmJMNoRUeMWp3BSfc9664pET95CT8NEmtCv6lVlFOEA/r0phGoGwYnS
	qKr9GizcQ9ztsh4qI0sun65EXggJo7wREfCYumAfR74nhha+lnVYs9DLn6m8gYDXut24Q0
	iR0WTA83pQ3DPhWgNk2sudBMBKMBpzQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-2HP_q6nuNnW_d2RV6IqaZA-1; Thu, 11 Jun 2026 04:35:32 -0400
X-MC-Unique: 2HP_q6nuNnW_d2RV6IqaZA-1
X-Mimecast-MFC-AGG-ID: 2HP_q6nuNnW_d2RV6IqaZA_1781166931
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5aa68daac65so4555563e87.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781166930; x=1781771730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0nATCJiZ4/9NOe9aaTS6Uk2On+QYrgr6XLP0GHNht0=;
        b=DpbJQzK2L4nnoVGQUmGvuTubeEw02NL/J9qdbk1SlMvlOBbsIfPjJrgJ9f0JuOqtE8
         PYRFmODm20QnkLDrjP9Adc/QyW5Mapp1jHeiDoNC487Y2/Jf0opESM9AkF+cydwtSStx
         OZoJwEMRTG+LtolFfVgRatKqQfBpxG9vTBDpmxmkSvIBBxWSSF6926WAqO54Gy+X6zMT
         jkKPRmhHkMamW49U/FBF8gXD32GgNGj/aUVNOrM9fJ/klMN1/aPmkoya7tnPk/fyLbZv
         18CTy28ggmQjUaNJ8UIOWuA+i7jBn0iSY6CQsj4U0HEfk3zsz8jqo01vcuFJak0KrOj3
         egDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166930; x=1781771730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0nATCJiZ4/9NOe9aaTS6Uk2On+QYrgr6XLP0GHNht0=;
        b=eQ77xM30jeww5Ksa6E5pgSnIHuLOwOChyvOR4AHjwiVIVzfahOpkX8/lbMSDMp1RT+
         wwHDbR3ylB5v0cmAwhAE3C+Y87f5Vynql1pKFdlnTAU4xsmNxhTkoVMitO9w5CdGXx4d
         DmOG97TCBCwT5B3Z21VwREWX+bAMoEgwJTKbCx7FazTVP2hLdZE2VngwK0AFgPQwPo/m
         hi3F1UbaCgpNlPMTMcS6E9jGou8xS0G3btUeFAegybdcctycmcm7wEYY52JzR6XHK6hn
         8dfJE6wB9UA1ktmfFzyxOb/PfywCe+Lej6ER4T+sY6fabrbsHqDeHxAj+7VHH6lesxBz
         Qutg==
X-Gm-Message-State: AOJu0YwyFakttQ7K48nYXZsMNKLaHAtpT38tLqorYoxwu5I5gSQ+/zZ8
	3k9jL6w/9nD1acM14+VU6trUGxlG9KYH42BZLsWaOQfx5OwKM9+FbPijQgofDWgCcLADV6Bnh5K
	y653DC52xFLq+lsHZx/W+yguKUttS/n/ZRAl4Dt9hnxivVuF5UIPZRIeesA==
X-Gm-Gg: Acq92OGrKW2oa7nZbS/AeSv/IsryYei46M3DZLbq2rKxIG9nEuzsdfQR2DtLC5jcmwm
	rChckonWkz80FM9tb52Nb1PhynVhlM40N1ncBCJ8wr/yt7Lg+Je8lU0I0Ov8Zfid2u37969s1Mn
	PZZ0H9p+0oyegEGT8bTPbd4smfyCgVQVinTwhdlcbw7mNfDIWfppae/zQfjJQ2YaLCXucxEvC7d
	u/G4tAKboEIVt3V+cSN0hsJWW+Ydq6Os2Zi3XnM+dwpmYqwYR4qdzIEPTEG2VL6CBLcsdFHkRq8
	oSUVIivtnBN7ZOJ9G+ZYzOcimEysfIcwq/CTKgZFB4/HDp8Cit2z3AgNcbyfbtWfbW6RX1G/GCr
	+C1vHNeObZtyqY1iIsBUR5i2ZPKB2awJjwcl6Hx+lphSJge7K4Dmyi0K/c/TKDLxIq+PxFzUNG3
	e1OgNtZA==
X-Received: by 2002:ac2:51cd:0:b0:5aa:77b2:fec8 with SMTP id 2adb3069b0e04-5ad27fb70bfmr571630e87.27.1781166930400;
        Thu, 11 Jun 2026 01:35:30 -0700 (PDT)
X-Received: by 2002:ac2:51cd:0:b0:5aa:77b2:fec8 with SMTP id 2adb3069b0e04-5ad27fb70bfmr571612e87.27.1781166929711;
        Thu, 11 Jun 2026 01:35:29 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97b042sm6167879e87.47.2026.06.11.01.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:35:29 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:35:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aipyNh_qseEUxj6Y@sgarzare-redhat>
References: <20260611021317.69362-1-rafdog35@gmail.com>
 <20260611021317.69362-3-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611021317.69362-3-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298009-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sgarzare-redhat:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A6F666FE9E

On Thu, Jun 11, 2026 at 02:13:17AM +0000, Raf Dickson wrote:
>Callers of vsock_remove_pending() must also call sk_acceptq_removed()
>to keep sk_ack_backlog consistent. Move the call into
>vsock_remove_pending() itself to make it automatic and prevent future
>callers from forgetting it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c       | 3 +--
> net/vmw_vsock/vmci_transport.c | 5 +----
> 2 files changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 73e6416ee9..b9772a0205 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -493,6 +493,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
> 	list_del_init(&vpending->pending_links);
> 	sock_put(listener);
> 	sock_put(pending);
>+	sk_acceptq_removed(listener);
> }

I'm unsure about the ordering of patches. Now that I'm looking at this, 
it's clear that 2 patches are really related and can't be split without 
breaking the bisectability.

Maybe we can keep these patches separated (which I like) if we introduce 
the vsock_pending_to_accept() I suggested with an initial patch of the 
series (feel free to chose another name, I'm not great at naming xD).

Thanks,
Stefano

> EXPORT_SYMBOL_GPL(vsock_remove_pending);
>
>@@ -761,8 +762,6 @@ static void vsock_pending_work(struct work_struct *work)
>
> 	if (vsock_is_pending(sk)) {
> 		vsock_remove_pending(listener, sk);
>-
>-		sk_acceptq_removed(listener);
> 	} else if (!vsk->rejected) {
> 		/* We are not on the pending list and accept() did not reject
> 		 * us, so we must have been accepted by our user process.  We
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 91516488a7..a417403c8d 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -980,11 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 			err = -EINVAL;
> 		}
>
>-		if (err < 0) {
>+		if (err < 0)
> 			vsock_remove_pending(sk, pending);
>-			sk_acceptq_removed(sk);
>-		}
>-
> 		release_sock(pending);
> 		vmci_transport_release_pending(pending);
>
>-- 
>2.54.0
>


