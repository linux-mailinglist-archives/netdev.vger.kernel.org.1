Return-Path: <netdev+bounces-80149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA98A87D2FA
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF5C1C20C68
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF84AED8;
	Fri, 15 Mar 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhmbOdGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A53FE47
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524661; cv=none; b=pptu7R7HITgY9Bq7SYWJGKD+Y3dDV8v/n6ggrPE+N4cz3NFvSCPCMVOMINgVj3+XiRk7N5C+E0Su/4rgyGBrDF5yqGDch88WZ1nIC9Z78oMIsVhSANLG9KOgIXNLggv84VrBXeI6iEjWvm18AgYGACazBpQuc9DOnRaZ8Jfy4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524661; c=relaxed/simple;
	bh=IGvnvPx+HAm+FarKSIxGtvtHS82uZz8HhhBrIx5+4Ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nt0kgJeGcrvVzUCCj1Ya/g04P48NT22to31N5UIAMzaNHRz8OgqXdnLuT4xmAsL5azIVSzBGJ/rw8JTyLEiIpiOaos5KN2yPcRZWkhpXGgcPOhkGZ0Dml/Mu+dadW2VCrDUpHDGTqHq5LrcUFkDUVrio93A+vgj7OCTP1auH36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhmbOdGo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so3979659276.0
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710524659; x=1711129459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=syBj8zoIL67+v7E092FZU0Ar7T56G0QEhxcd8/OzuIw=;
        b=uhmbOdGo4IHfQvprnTGEGzrDYMcy5b8eaFcXFdF4o5Z4h1/OH9e1BBQ4JDmaTUVyT+
         n0UZltWBDx6bx6CnWCKiA5o/dIm4jb4wYBtCbQGDMo3r+i5avPViQBCoXZekfI2QKcIe
         K6ZTWtDMl7tgBx1rPq2+OfhyQMHAV+yYSBUlznF96CfSfWpiaorzMjn2onKfoRFei3kp
         uv/XrA+VxeHN9/K9PRNu1DMHX4XSmPccQFSsoZ8pR0w0R2ELrDL09cYuAW12oYRR1e9Z
         c4ynC16EQu2/8sODegKRuMLugOkhynwshUmG6f22IqvNFBd4R5Yr8j661tD/W+RZjnLN
         0FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710524659; x=1711129459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syBj8zoIL67+v7E092FZU0Ar7T56G0QEhxcd8/OzuIw=;
        b=ejRYdfA6nupA3XuKCDZ6/H0AmFo2VGWQ53GsZrejyVut4TdHjchQpJkSMGocHOzC0y
         vuNG36qRppIpikfzILrcDvdBnIMBDn2Coq4Ps4oNxdyBgrZDVMeBQiN3vXxH1LyYevSI
         aEvvbKRnvTyvuj9J+2YsDRZvCeuz7xwvMD+kNozTt4FOVs9+0LXY8uuDdYHOoiJa/H6c
         QmfEOqQiJs0aGnzX6g+8RXllC9MTti6mTm4KYKxSdg3a0RJ9fwK64HXwwTMhg6udVK9P
         upG+D75qEQu8Fk7ngQ3+JKCMJfsWsDl1GsKtBTpCcoIQMwfOyg/PPGql0KpG6Ka4Eohc
         Ou6w==
X-Forwarded-Encrypted: i=1; AJvYcCVMpDmVGWUmrZu5Z9EIPOQJeHjLlEFyPcBxzsyDsJTnsk2fdMhNChI66iQ5oZuqog0ESOsTko3J6cY3d2lMxBMmzRDgfsag
X-Gm-Message-State: AOJu0YwJdHtJFqedCPoN0mfRQ9/JGAdWFsguUu3o9f5VVB2C5qpqltP/
	+h3EJPoxNIrBB+OHkMeUfGf71gWT2RyJZYJEAUttNmg/vVBb7CPxvY9ToXrVHiG9tQ==
X-Google-Smtp-Source: AGHT+IHJYrHu+9A4J7kbEFnrIYxNdFbHUNxbl3Jz/1uZ22EFPWeWn/jAjRwt2/QnvOCJJAT8oeTlfCE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:248e:b0:dcc:54d0:85e0 with SMTP id
 ds14-20020a056902248e00b00dcc54d085e0mr820369ybb.11.1710524659252; Fri, 15
 Mar 2024 10:44:19 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:44:17 -0700
In-Reply-To: <20240315140726.22291-5-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315140726.22291-1-tushar.vyavahare@intel.com> <20240315140726.22291-5-tushar.vyavahare@intel.com>
Message-ID: <ZfSI8UftKDGWTgUC@google.com>
Subject: Re: [PATCH bpf-next 4/6] selftests/xsk: implement set_hw_ring_size
 function to configure interface ring size
From: Stanislav Fomichev <sdf@google.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="utf-8"

On 03/15, Tushar Vyavahare wrote:
> Introduce a new function called set_hw_ring_size that allows for the
> dynamic configuration of the ring size within the interface.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 35 ++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 32005bfb9c9f..aafa78307586 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -441,6 +441,41 @@ static int get_hw_ring_size(struct ifobject *ifobj)
>  	return 0;
>  }
>  
> +static int set_hw_ring_size(struct ifobject *ifobj, u32 tx, u32 rx)

Hmm, now that we have set/get, should we put them into
network_helpers.c? These seem pretty generic if you accept
iface_name + ethtool_ringparam in the api.

> +{
> +	struct ethtool_ringparam ring_param = {0};
> +	struct ifreq ifr = {0};
> +	int sockfd, ret;
> +	u32 ctr = 0;
> +
> +	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (sockfd < 0)
> +		return errno;
> +
> +	memcpy(ifr.ifr_name, ifobj->ifname, sizeof(ifr.ifr_name));
> +
> +	ring_param.tx_pending = tx;
> +	ring_param.rx_pending = rx;
> +
> +	ring_param.cmd = ETHTOOL_SRINGPARAM;
> +	ifr.ifr_data = (char *)&ring_param;
> +

[..]

> +	while (ctr++ < SOCK_RECONF_CTR) {

Is it to retry EINTR? Retrying something else doesn't make sense
probably? So maybe do only errno==EINTR cases? Will make it more
generic and not dependent on SOCK_RECONF_CTR.


> +		ret = ioctl(sockfd, SIOCETHTOOL, &ifr);
> +		if (!ret)
> +			break;
> +		/* Retry if it fails */
> +		if (ctr >= SOCK_RECONF_CTR) {
> +			close(sockfd);
> +			return errno;
> +		}

[..]

> +		usleep(USLEEP_MAX);

Same here. Not sure what's the purpose of sleep? Alternatively, maybe
clarify in the commit description what particular error case we want
to retry.

