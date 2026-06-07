Return-Path: <netdev+bounces-296239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8VYHJ/pvJWrHIAIAu9opvQ
	(envelope-from <netdev+bounces-296239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:19:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2946509ED
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:19:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=TD2h83CY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296239-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296239-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B15113037410
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2B3A7F7E;
	Sun,  7 Jun 2026 13:18:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A14371890
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 13:18:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838298; cv=none; b=U82ReT6sTKRq+Kgd5S84QxjXordE/K9pmGsQsyCnFH3u18tvedKfNrbBcgD3mJ5KYHUlb84Z75RfgI4oxzN3vsHAEZE7hYAQvkMKZg8kjsexitG414m7mUTWoa+KfZEfcyNbVYA0Kl/nZ+twNTusaW17eYjkBGioxSo7y0v34OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838298; c=relaxed/simple;
	bh=JVzHRA0qNe5PmaoL3NcuxTPdLc5I8zz6mVvDQe9+8Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXjSiwa/sGqm/nQEXEXaugJqnQotPGs/oN0yLx/Q2RBWUIpXQ7Ydaeu1Rk3DNG8r5apR8mJ16CdrlpCXO4QvnHS++V1NWr/lvM0DRCssxkJSZ5ptvlaIJ1bXz7nZLWPoUKBKFZu8UDr3/LqvcM7MzfhFONSt8jiQhyE0x361q/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TD2h83CY; arc=none smtp.client-ip=209.85.214.226
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2bf125989f2so24277035ad.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 06:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838296; x=1781443096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfVUV08jVaZxylIY4Wp2JU/+msgArLD3EBWtB73Ew10=;
        b=AYoSPfUCmpATprC/JZb1rwknGVv561NE6ZS/faP6RFxcSz4g0yZ1KYzNd1R/ZtetLa
         2OKO2ZXSIw3pb9nFvePk2UsJgNng+qEL2VJ1RTXl3qWM6Xa6/LL11qAlhWcvOJz13C8F
         D7f/OwRo2KBMbf8z2+QjlIy6ZjA02F3u49163ZkKCou3Q5MMMf02QhzUDMlmxXqLHz25
         dryyxaB8dSXGMKwXkvd1b2pSJPIgPYI4nBm1TFrmmPW5KXPVilKXk1sRoKhtJTikvXIy
         KvHqOSLPDOdeXfLMfw4nf3Ygc+U1fku/t6JrcmnBDwqDlvYX+cr4frq9Wbc0NfCn13II
         wx+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+n4OZ3N410G6uyaugNtCKu4IMBePUUzVAUGB6M3Obc1vMRGYUB1ZqE+InYXtUT1jLmU+vPvZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynhekBiKlDBUDNWj661OF8bIAL2lrGeNnGYR4wJ5a3Pj6IPS9q
	q8VDNsGFJK+DxUIHe/CDvKOalkaDyM1jKz2ET3DIIahu9sP73QLYTnlafKuhoHMCFKNOonuvtq4
	dOeet4ok2w451lGiDrXZdojT2mOyCQl+3D3ATYH5mPpTZVCpNSextxitIA2NO3OWvKpbqKbmTTg
	0IN23XtDsXNaLyCC1ENTUGzSwtDn2eZt264ufPGEKlbRs7q1fV6a8M/SK9RkX5RhRDYqlKRWgzZ
	up7AB3Qj2Y=
X-Gm-Gg: Acq92OFmTzqv/YaQ5Ggs8vsC015oqTGP/CDWLT9WZ/FP2ls2/1D2KsDbeXD2yIRn9Ep
	kRsZimpsPfWgnzRXjCdHIrosBJAxfdW7zx78MSWCS115neVst2jpwq1k/aDzoeaiml5a96BPq+J
	lxV/3W6sDgGxtP1YWsheWG2QgDJnboHO75wY4ZDN0MkasItykS8eB1OHmATQubZmmor0Qk/c8tY
	JRnPxwUvaJkOQqI245el5h4ZzunGTL7Nx/lFvgm2lYIODcRsd5wFTpc3pkG2B7xL6Vy8NjdbrYz
	nfU9up07CBXyU6/9wGA68AsAC6y9v6/P2unr5dSZpwgx7Hr3IihgiX+5VzAio6BYOGoaERo5Py5
	7bXUjvfQlzzdKmzSKxQdKlFRfWHKoaJOjzZZOmtOs8T1vCxZHVdcZcaXsHWDBwqe76rps6/PpDB
	brENjT36daLJEKNC3yVbJhSJXqyCIFoU0pnGnBzFJktIiJWkda8y/DQ5yg5R+l8gxsKstjcQ==
X-Received: by 2002:a17:902:fc46:b0:2c0:b9a1:6493 with SMTP id d9443c01a7336-2c1e7b082b4mr124710485ad.10.1780838295763;
        Sun, 07 Jun 2026 06:18:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c164f70746sm14333805ad.7.2026.06.07.06.18.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2026 06:18:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8423f544944so2565560b3a.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1780838294; x=1781443094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfVUV08jVaZxylIY4Wp2JU/+msgArLD3EBWtB73Ew10=;
        b=TD2h83CYOioOG7dnPDIhz/mgGtuUpxDqOu2Lr7E1Hue3hcRqncSTKU65yJnRLOpLlO
         G0ztFeN3xRF/N7rIdZz+aVfK+6/D2s4OKqk8XaUBx0t/tx2GTXilApt/LgM2dgHIhHJe
         L1mAyBTb9XnBIBa7TOv01WElkAwL2wez3dMx8=
X-Forwarded-Encrypted: i=1; AFNElJ/RsoshOcn2UemIRBxevrddmIU1lsD5xWBUji8wya4Hcj9JBPfbmufl319I7E537XIZjxqMeHA=@vger.kernel.org
X-Received: by 2002:a05:6a00:90a7:b0:842:57e8:1bda with SMTP id d2e1a72fcca58-842b0e81fcemr11520009b3a.19.1780838294242;
        Sun, 07 Jun 2026 06:18:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:90a7:b0:842:57e8:1bda with SMTP id
 d2e1a72fcca58-842b0e81fcemr11519984b3a.19.1780838293735; Sun, 07 Jun 2026
 06:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aiNM1CY2-StPilxW@hpe.com>
In-Reply-To: <aiNM1CY2-StPilxW@hpe.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sun, 7 Jun 2026 18:48:02 +0530
X-Gm-Features: AVVi8CcbwXg_-54C8vUiXN0aD0OE7a5FsKXgc9jUqy_8-3VgP_3g4XG7RflFM9o
Message-ID: <CALs4sv1xboUxNCZMarHUnD2s52ZE3WYLWE8UZXbBQFNRdhYfCg@mail.gmail.com>
Subject: Re: [PATCH] bnxt_en: Fix NULL pointer dereference
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: michael.chan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296239-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kyle.meyer@hpe.com,m:michael.chan@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:from_mime,broadcom.com:email,hpe.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B2946509ED

On Sat, Jun 6, 2026 at 3:55=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com> wrot=
e:
>
> PCIe errors detected by a Root Port or Downstream Port cause error
> recovery services to run on all subordinate devices regardless of
> administrative state.
>
> The .error_detected() callback, bnxt_io_error_detected(), disables
> and synchronizes IRQs via bnxt_disable_int_sync(), which calls
> bnxt_cp_num_to_irq_num() to map completion rings to IRQs using
> bp->bnapi.
>
> Since bp->bnapi is allocated on NIC open and freed on NIC close, PCIe
> error recovery on a closed NIC can dereference a NULL pointer.
>
> Check if bp->bnapi is NULL before disabling and synchronizing IRQs.
>
> Fixes: e5811b8c09df ("bnxt_en: Add IRQ remapping logic.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

LGTM. Thanks.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 008c34cff7b4..ec38a0a40875 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -5748,7 +5748,7 @@ static void bnxt_disable_int_sync(struct bnxt *bp)
>  {
>         int i;
>
> -       if (!bp->irq_tbl)
> +       if (!bp->irq_tbl || !bp->bnapi)
>                 return;
>
>         atomic_inc(&bp->intr_sem);
> --
> 2.51.0
>

