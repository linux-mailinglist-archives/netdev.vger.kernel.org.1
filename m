Return-Path: <netdev+bounces-276183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK7HKPJ71WlU6wcAu9opvQ
	(envelope-from <netdev+bounces-276183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:49:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B63B51EC
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AAF3300B452
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C3037DE89;
	Tue,  7 Apr 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuy5WLOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F037B036
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598572; cv=none; b=Gycm/zAKDdwmQ2m0waW5csGGaDcq/AktvViU+xrbHseQgmECUUwNE68EY4Pmk71R/ky5IhhE133GRPlMlhdMkfGAw0gsJQVq/0o6jFX+Kdg5kIzxU8xp2ZHKycxVtxjhHQLd8b1BM28IB004W0ryWNz7V7VwjVb4ymKqrdaEzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598572; c=relaxed/simple;
	bh=786cf498Ck+7N2b3p02kVFc1c2hiRJobfwl7MyR7itI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ge5NnI7O3JDxNlzcfAV/G3K57cjxv5mScirA5f+wckLqR3dJhaDlovO4bvUTjLERg2N4eii0R+EzcTSmwdW0l4/5jHNNhHcQFp78sZDeaUwZzs7RH4NskmwrMz2+Wmi9lcOBj0T5R9r4oqAmvkerZMj1wxw2NGNsfG4MijHM3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uuy5WLOt; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-793fdbb8d3aso58601717b3.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775598570; x=1776203370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjZgk6RqcrwcrJOXiC6eMW3xcA9r0nZNiCoTLL7m1W4=;
        b=Uuy5WLOtfSWaYtHyqyV2OX5kPCN1hR5aY50BPIrt+mhAMTS3v4yxxemoNo5Ic96PsR
         ZNjV/sgTepBKCg6ET/282qPJeR9dFnOswjVVpaob+b+CmRBq1DwwTr0dCPfSAGxChCRG
         aBlIt9Rn4LsV6GSMk2VjJ0DcARFE9r8W+CkTrGNh3/RokVNjyZPcQ6F+OtqEfow9y5FE
         QXNDSFAJsy3WQetL84APWvzF2AyHdmu9RdAPH7ImM/z9Sm2qXF7Li8BuZttFtbzf5Ul0
         1jbPKo+z3Euh+UUGNiCP+e/5fmnbNfXbmIN48i1ze7po+nT59O30bhxMKiUDdS3sX7b+
         XNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598570; x=1776203370;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjZgk6RqcrwcrJOXiC6eMW3xcA9r0nZNiCoTLL7m1W4=;
        b=JM3tHHawr0xyc2h0uGzHFpQJF0/b1J4yhnVjk0zAztLrI8OpmqSkK75WLHKQtqYEtp
         jC+nwkyBM8ShqrtrlFFUuG5vJX/kPO+2S21r+vtoJQ7D2YryN2XE2UMkkH5Ne44VLWKi
         6b6n6flQ34UjjbMDC2O+p9PHqi7DOWs/TGrMd8ZJZRo9irUx+/DeNDYTzEBO82OpTmZ1
         z+PKolgZScC42bu7DUsf3J/vUgBcLMlpEVz+/B3YDZqZJSIHe3h57LQFg1yCdtD2kk5x
         dPTUz4MBGET2FoCCJW3i4Fdaz5DT+xa6mLKmZLHy7//uuKMyIdXiQqPBCJm9oOm9dcGI
         XjLA==
X-Gm-Message-State: AOJu0YyOmgz0I6v1lZ9hr60MDmb4/aksmT3S5Ukl1oLQHNp9uES7oSBW
	SxxHPUaUFlwDRvZRbysWUXMYOYfUf0BPEGYCuR4azP0a65KiECDhGqo4
X-Gm-Gg: AeBDietCHlwesWGo2N5ebADCC+XAKAo15wU+i/5hO81yw9Jzwj0xpYnXJ55i2mhPV72
	nQk+pi7xCiypCxcnRNWupLilCOXgELJXBbZJFeCOwzsiJwm0dTnECbPVfyClkVne3TIuUcQyG4h
	CcoO1M1iW28EEKa3IYW7oxFN68fDtcr14a19TRnCdR4BpRnSwTRq6hyIGBk7Ou2PkwRiJE5IZex
	ZP30w4nUeW9Lg/XXKk4fJCBjIZ51wQfIhFwBDPcRmk8gTjOVnfEwHCZCVT+vNSHV1SxQSFxq5E6
	Wn2JkNs7Ng+PguQ90LmBLV44GlPoW4zpfYeDCtdhscHGwW3ehyrTfo+7AC+Pl2zGtarordJoUwk
	8OIJN96leNNVcb/1Qxq1HNAMhEArVXUd2qLYV7puyRqcvjKfsTjp8pF7FY5vF3NQGBZkxbK8VuI
	vApEGvtVurOi2WIM/cLkgkquOzG1wjPSyi5Wn5H/7kkJnteqnzIzqsuVZmwA7Xx6apuWoLXRgy4
	D5j
X-Received: by 2002:a05:690c:83:b0:79f:7972:f89a with SMTP id 00721157ae682-7a4d556ac32mr177080107b3.28.1775598569814;
        Tue, 07 Apr 2026 14:49:29 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7abfc962dfbsm409127b3.47.2026.04.07.14.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:49:29 -0700 (PDT)
Date: Tue, 07 Apr 2026 17:49:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 kiran.kella@broadcom.com, 
 akhilesh.samineni@broadcom.com, 
 sachin.suman@broadcom.com
Message-ID: <willemdebruijn.kernel.327df0cb46f23@gmail.com>
In-Reply-To: <20260406222305.4111170-3-akhilesh.samineni@broadcom.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-3-akhilesh.samineni@broadcom.com>
Subject: Re: [PATCH net-next 2/3] netdevsim: psp: handle the new crypt-offset
 and spi-threshold get/set operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276183-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 781B63B51EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Akhilesh Samineni wrote:
> Implement the crypt-offset and spi-threshold get/set in netdevsim PSP.
> 
> Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> ---
>  drivers/net/netdevsim/netdevsim.h | 2 ++
>  drivers/net/netdevsim/psp.c       | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index c904e14f6b3f..3ad7d42391c0 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -117,6 +117,8 @@ struct netdevsim {
>  		struct psp_dev *dev;
>  		u32 spi;
>  		u32 assoc_cnt;
> +		u8  crypt_offset;
> +		u32 spi_threshold;
>  	} psp;
>  
>  	struct nsim_bus_dev *nsim_bus_dev;
> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> index 0b4d717253b0..9098edf00c5c 100644
> --- a/drivers/net/netdevsim/psp.c
> +++ b/drivers/net/netdevsim/psp.c
> @@ -122,6 +122,11 @@ static int
>  nsim_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
>  		    struct netlink_ext_ack *extack)
>  {
> +	struct netdevsim *ns = psd->drv_priv;
> +
> +	ns->psp.crypt_offset = conf->crypt_offset;
> +	ns->psp.spi_threshold = conf->spi_threshold;
> +
>  	return 0;
>  }
>  
> @@ -249,6 +254,7 @@ int nsim_psp_init(struct netdevsim *ns)
>  	if (err)
>  		return err;
>  
> +	ns->psp.spi_threshold = PSP_SPI_THRESHOLD_DEFAULT;
>  	debugfs_create_file("psp_rereg", 0200, ddir, ns, &nsim_psp_rereg_fops);
>  	return 0;

Default initialization should probably all complete before the device
is made visible with psp_dev_create.

