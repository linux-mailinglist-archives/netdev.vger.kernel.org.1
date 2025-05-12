Return-Path: <netdev+bounces-189657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934DAB317C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34083A3494
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953D2580F8;
	Mon, 12 May 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD1DSRcq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4B2571CC
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038164; cv=none; b=SBXqtKLlcBCgaIeNg6pMNBb6gMTUg53q6apwQ+l3TUNMwLdgXY1BZ3dt+M0kHvWSExEQhYcExh0nwgFIhP+rsiKPdhG9tRHsP6gA9vS56sZejXDK74h1QhTUhS5ZfJKdHItkXrek7GulSy0wKQ0rW6NdaT0aNzwYp2eUe9vBcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038164; c=relaxed/simple;
	bh=wkPvuxzwYWOXVVomNwcvWfTH+uzlwNO2XLW2lOLJ77o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwy40audktX3NKj5+EXn2IWvciHrizTQMDV9bJQtBVF7U68Wubc/gPJQHlpuLiwbCGqmzGKDPe17BkjcSC1/CpCsZGJ7tiTT/b1/NWq/lDcKaGexcthJHbHdZoZLse1sP1NslOLvnrDJRBC23kiR5SUGoI3NvK7FjA8dBUSd2UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD1DSRcq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e7eff58a0so39480065ad.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747038162; x=1747642962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SbIux9qepY/T4DtKTVBIC4DVICTqd4/QbfW6x9rAi50=;
        b=jD1DSRcqRpDRPFewtVYCh2L2ffyE9ecRLhJkV3jZVdrmcMLoijv+xhcU2p2gLALl4J
         5EfJLP5Nk24GcRaS3g+zd03yPP/8Z/VqavnfaX4UQXcCv6LnLquawJgPVl57fAkp9X0p
         U5Bjjxlg/poBNxy1xTB3ODcz+YgakL7EhhNwQycMSknoRFJs7eqkKg57SePnPaXM9PZR
         DtgP1RvFRBwewmE4rRNKu4b1BY9xBSRqkL7oidXv1ZmFc20tcDW+fh0D4ktz1gTgcswN
         4SU1qq5+SSQVn/xFrY5HM4P6T8kVRqVKkK62OlQcZ4bl+HZKvMqFFI0oYYAf3b7+ylCc
         pqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038162; x=1747642962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbIux9qepY/T4DtKTVBIC4DVICTqd4/QbfW6x9rAi50=;
        b=tlBe6Dvei7pQ4n7yYFho9qySq6HbzSjaVYGsYHzjyaSFJ5Oy/tGkMEjHpBDE3xKWcA
         sw3KtLMOociI2KVBldXkaBgNBScKvU3s64VyQwEn7Vj2k9y7K8OEJi6JZX6/xcXHepuy
         Oi/DqQpVMHgZtyAP+1TmizqBy+AARNgrk6zuZA1G6U9VnPyeDzLODb3qBtgEmD3ITlpb
         974LHIm51L4CLKi4Iz/ADy8XNjy7YpQCmC8WLVEkA+3j+u25Xvh4kWe0qS1W2fvlOwoK
         sEqGqi+z81oirQw36VILaCxIK5fxQA9kwtl94JGP2MpIw786JzTgHCWXKQjvHhQd0QAP
         ncRA==
X-Gm-Message-State: AOJu0YzMrhXqB4SsUQDbvXUYT8hL/bfvqYpjRHNz4D0lLHEzyYttINHt
	trZf6FWQyLKshYFzPuO6EK3E/42F4M141zTUS7rhMHaOaSDJOrTH
X-Gm-Gg: ASbGncu+JjP5kFcT6TvUDlyMg+ItgSFqttLgT0imXhMBXda4fbmUDrhilBupLthK6hs
	uq70zVO/OFoWeBgCZy7+fK4Weypv4Q2P0fxPwt5UNlsnicEgtslhb2iQIg7I6sQJsrwYi6bFoXE
	A1OpsHSroQ3jsD5G1WGjDWvgSaVmiw0Ze4/LKmvLIePY1FtRxXG7/r8X5wy+O5TQNfXDUdRXU8F
	j0GyRYsOuDptBAK3vS9n8eGcgNRwE3HKvaluoYjMR1DPo822L+RxlAbj1JU4PhwuuBTqSpKOopq
	gi2D8qOkuqf0lki12h+tHpQsm2quqYRi6gugA0RJx4hGyeVDlo9Iigslz/QzkvpB5bM=
X-Google-Smtp-Source: AGHT+IGo2hbcl/+mwOjQv9OuCl46lOsnKepnHbTgbeqY0OWa3iCk3KO6BPFdyOo/DXAkaSWJ/TgPqg==
X-Received: by 2002:a17:902:db12:b0:224:2384:5b40 with SMTP id d9443c01a7336-22fc8b5fad3mr201243965ad.24.1747038161936;
        Mon, 12 May 2025 01:22:41 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc75477fesm57345355ad.17.2025.05.12.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:22:41 -0700 (PDT)
Date: Mon, 12 May 2025 08:22:34 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: tonghao@bamaicloud.com
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option
 for 802.3ad
Message-ID: <aCGvynxFVglsf1St@fedora>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-2-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510044504.52618-2-tonghao@bamaicloud.com>

On Sat, May 10, 2025 at 12:45:01PM +0800, tonghao@bamaicloud.com wrote:
> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
> index 1e13bb170515..76f2a1bf57c2 100644
> --- a/drivers/net/bonding/bond_sysfs.c
> +++ b/drivers/net/bonding/bond_sysfs.c
> @@ -752,6 +752,23 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
>  static DEVICE_ATTR(ad_user_port_key, 0644,
>  		   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>  
> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct bonding *bond = to_bond(d);
> +	const struct bond_opt_value *val;
> +
> +	val = bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
> +			bond->params.broadcast_neighbor);

nit: please take care of the code alignment here

> +
> +	return sysfs_emit(buf, "%s %d\n", val->string,
> +			bond->params.broadcast_neighbor);

                       here
> +}
> +
> +static DEVICE_ATTR(broadcast_neighbor, 0644,
> +		   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);

and here.

Thanks
Hangbin

