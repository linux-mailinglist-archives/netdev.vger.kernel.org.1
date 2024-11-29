Return-Path: <netdev+bounces-147872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520439DE9F0
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133D2280D64
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F3913D619;
	Fri, 29 Nov 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc9O3DKx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283DF12C54B
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895316; cv=none; b=XfP+P06qVPcIUxMAXEy9Hj3544CMidF1rkAviZwX454e09+5J7LyFzrlrW8yb3y2KWVbUandUVG34eYL/9/8VfNEvPP7+FMbE2qtyze7sKt5nolkHp0gkLd7yoV1oSLcuTATBv/RR2x3mpJCNa8bHEn0bmzMpOdwp9YDirn1AfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895316; c=relaxed/simple;
	bh=g0d8tJLFN5aJdiQfOflzlLhCSXPKEwQEG/2j/vZl8Ys=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nNpDbQHKpBbl5sM9EcGjDMgg4mK8DFTss/xiqnCkLIyqXMAauSLGsvXB4/S+7UgnXex4m0MJ9yesm9sOH024QwpwpZdeNnuBJbFWgH+MschjacG40q3A0xjnk843/SYOhIUskkb2qdGkktxISS3uWK5lkRfSemyv9SqrIPS6NIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc9O3DKx; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b672a70f4eso137659485a.1
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 07:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895314; x=1733500114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fZmFquivfpsRX4ovRuebdXrWSPlFb6167yx7/D4Gv8=;
        b=bc9O3DKxqdUG4SIqD8AST3Jn5OqYG7R2+/Ex4CEyEnCGTA0gHg794DYQwuuYgjd8ZR
         v+PzpAzbMs5z/Nx7bDNGVu51/QKyz14rFSHRTjr4gIy6XO7L9DeBQlS7ex8gU9kSiVv+
         1FX5JpBzgu7/l+tdUloyO+ITAM7cUlXGIQKPpZ6b2pnPfolm5lhdsp8SmYDmqnu/RXTe
         71ELR+AGBp2L3Wdi6AfBYNWbor6FTVMYFyiYn6oPXvtndrNYY2eXZ61KYmfxo732NhaO
         GJ2aYGcTS4XkWpL/u6XNwTPVvArpAuuGaLDn1WpHjazH/RIYLKeFvx/NT/aXiZ1FM4Io
         ieNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895314; x=1733500114;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9fZmFquivfpsRX4ovRuebdXrWSPlFb6167yx7/D4Gv8=;
        b=Kd6SnvH3DgtTWcJuLBuhG6gHyetxpO8KIKIiQ3Y2qx+kb9sxuoykAcekI7jf/vQvI4
         kPiyJ2IQnY2HSzCYaSsOvmBBWlQcjNndstivWgpkSpnmJ3rCRHWUkOjL7S7XVAh5b6Wk
         3dkO9pts7UChW7FD5Qx6l/gAJCXguqY31Fixu9tK6GMvYnTPREWBttjF7qoqWOI6+7M5
         /Y4U/Fl+Bh596bIG1y1KgG2FxZq85BAatPw01RW1CdCacebPmGhxX13L4ZoedjrwWTg6
         ccEZLww41Dl9g27RuSwFPaOP409TMovXYhOHEbBIuddI1nvvlu8TgmKI7ED+UKS0uRMh
         J5+A==
X-Gm-Message-State: AOJu0YxscusWzpm9M9CpJckfJe/gZn+dZHTLrz+xYaZG5JCLHt2ljtsH
	YIA/NadfFr48CTpqPiutVcl/yr4RzvDUlfmlL7JJpXEjwUUfGerz
X-Gm-Gg: ASbGncvHmR4Z7sarYsu0bcAgcDxDNlh/NMK0EhUEmMSnwMInRELGFyU4+inzN1miLEk
	YvbcM958+dV3dg4GMgnY0dh/H1rbso6A+4ETWeXAmxmWBH9cZyxiz+FF3mWA6Bf08sCuM4c5Dw4
	CDeRxBFMyuec7l/fx6zZD66FDwhXc0+wbx3I9RXc42kvoviQnujKJ3XS1MGTos57zzEjz+BRLiD
	499zef8uGnOKFP4r2Yk64o1DoKodBP/v6MEos2oK1dAEtfhqDLjqniQnXtZ2BJTeu9ZrX5CO6LU
	BayOJFDqt5HxYKSN7lkBiA==
X-Google-Smtp-Source: AGHT+IGC0M0tgAcIG7IBoef9nUKFozo8QRmbCfwEMu3jKIF4G/ftFfQgV4H1+wEcw6ICac2x9IABig==
X-Received: by 2002:a05:6214:a6d:b0:6d8:8256:41d7 with SMTP id 6a1803df08f44-6d88256548dmr59309366d6.33.1732895314141;
        Fri, 29 Nov 2024 07:48:34 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d880e81c86sm10972986d6.106.2024.11.29.07.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:48:33 -0800 (PST)
Date: Fri, 29 Nov 2024 10:48:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <6749e251407f0_23772a2948f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241126035849.6441-10-milena.olech@intel.com>
References: <20241126035849.6441-1-milena.olech@intel.com>
 <20241126035849.6441-10-milena.olech@intel.com>
Subject: Re: [PATCH v2 iwl-next 09/10] idpf: add support for Rx timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> Add Rx timestamp function when the Rx timestamp value is read directly
> from the Rx descriptor. In order to extend the Rx timestamp value to 64
> bit in hot path, the PHC time is cached in the receive groups.
> Add supported Rx timestamp modes.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> v1 -> v2: extend commit message
> 
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c  | 77 ++++++++++++++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 30 ++++++++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  7 +-
>  3 files changed, 111 insertions(+), 3 deletions(-)
> 
> +/**
> + * idpf_ptp_set_rx_tstamp - Enable or disable Rx timestamping
> + * @vport: Virtual port structure
> + * @rx_filter: bool value for whether timestamps are enabled or disabled
> + */
> +static void idpf_ptp_set_rx_tstamp(struct idpf_vport *vport, int rx_filter)
> +{
> +	vport->tstamp_config.rx_filter = rx_filter;
> +
> +	if (rx_filter == HWTSTAMP_FILTER_NONE)
> +		return;
> +

Same question as v1:

Should this clear the bit if it was previously set, instead of
returning immediately?

If not, why not. The function comment says enable or disable.

> +	for (u16 i = 0; i < vport->num_rxq_grp; i++) {
> +		struct idpf_rxq_group *grp = &vport->rxq_grps[i];
> +		u16 j;
> +
> +		if (idpf_is_queue_model_split(vport->rxq_model)) {
> +			for (j = 0; j < grp->singleq.num_rxq; j++)
> +				idpf_queue_set(PTP, grp->singleq.rxqs[j]);
> +		} else {
> +			for (j = 0; j < grp->splitq.num_rxq_sets; j++)
> +				idpf_queue_set(PTP,
> +					       &grp->splitq.rxq_sets[j]->rxq);
> +		}
> +	}
> +}

