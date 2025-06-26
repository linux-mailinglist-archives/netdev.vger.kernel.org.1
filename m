Return-Path: <netdev+bounces-201384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA8AE93E4
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C9F16E418
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4FE1B4248;
	Thu, 26 Jun 2025 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ/Ws0qC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568411AAA1E
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750903924; cv=none; b=F5xCiZ9uIk1qCxNe+RLdYk4IBXJeEmrU3AJhD8Tvl8EscLOwD4hgH1+lj6Tc/d9OFDpM8TBhCengo3ZzM/Vc6tTlPOd3khxD1xX08EEXm8Ru2cUFxFIaWOzuPzAQtcn8e6lH6+329U5MVfAH8CijZWQRlv5z2ZYMsOQ7SdGa1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750903924; c=relaxed/simple;
	bh=dlu1oOBDb0G0LhtCbGJphyh/kQYZX8m/ub+ch/48lTM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wt58xV97NfIkdOZWEar4mYpDjBckT8ncON/B9KDxWjlhb7XIAX+Vhmbhs21iTgpUm0Wcm04qxIqKRegKrN9dpaTHj3XTjD8vqpjYy+SsXd2ftRt/Hcv7r70GRn3bQ2XjwfVh7C/LVID2qW5A5S93yvCb5at+Kh4k+Gr0Xukj5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ/Ws0qC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e1d8c2dc2so5404897b3.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 19:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750903922; x=1751508722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCY1KeB66b7fmFJnlWcA8wXX5bGvO+8egACKlF7Srpc=;
        b=iQ/Ws0qChegZdc8x5oFMktywDGtPIxlYUPKwEb6z7xojPt0ikITfaptN89ghlM9HwE
         wWM3YIRl6gKNxlV3nMPjbyVmNNcdC2esfMne9ZWyWPntKGN5+QrKg4wylHveX0BXfXDB
         r8JQKyzvfAF7F+AYTUxa0wgWmUIuL/OKagcXZ2y2p6o+/V+RXdioQxCe59NNzDbOKDqd
         QaBNPcWLW0UBSPmMszYJoxS4/60b6ih1RNN11IY7AmRvGdOq93dnZjGI7AQsyxpcc12C
         MzeMrhkk1SbVB9JKjK4ahCqL5JvWsLTMb6o/jxW9ygZzC1yinV9m7Rr5iPqQ9hVvOPpp
         ofSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750903922; x=1751508722;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kCY1KeB66b7fmFJnlWcA8wXX5bGvO+8egACKlF7Srpc=;
        b=qzWKVYEDv+pwz2L379dCmEwFYCK4rtA77bpYDDcFddXjnIZj8/laBIq1NqLNxIj97F
         YKtBmd3o2lkvDeYnEGQ2K8SEYVyl6ms6MWSw3x+nSKKDt3xFDeG6l1/A0JiG6xky64JW
         KkognDAOWjkf85fq6YJ3B2BP9AqIyF4Eod7fgbIU/0UgjHU/ywnKSq8VpO746s8uXuwi
         bLmnW/fC+2RmGpKuXghRqeo1Hv1jZ75AOQkOYowCvvE+bN78j9m4/nczIGvaLXFyxN3l
         2Nq3/DOvgXEq+GhGoEgpXhXzGnSAnQtGxNuQC1RryrpNLdXvtLm6EsHQOrXWjNGi6gjE
         /Klw==
X-Forwarded-Encrypted: i=1; AJvYcCWsjTNR+SGL1DOC2y88w8hoGbU0OyVyOZ/Hf+t4VK6nzoDmHac5M91v62DKWzp4vO6DCpDV1gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywVdbGuHxS8V278X6rA+a0bja05E+qdUw3UaYu15R2c6fzcgX
	3y+PjgkvRK+/gZ8IPGqqrnhcEgoaT6ftMA5avLDYDJqWWr79M7EJ2pRj
X-Gm-Gg: ASbGncvIjqwt5M6MaAWaOPdehmI6soKT8A4UW6Xmud0EAlBqXiun2oY0Es+acV8ZbmT
	tH5CLqeArB11Wd2iB312VMqN1yhba/0S6y7O192++y116hnX8V85V0BNMh/MYgSd8G4c/6wmZ+p
	xmrDlEQAd6qSXkLwOfX5waVMH6NuHYcjQKDSlifGiUBXQiM0dWFwlfPwW1BOhFhGTGlBglLJvkj
	56KQ06i/ery9G5hVN3EPb5jgKFy3d/XtniOyh7Z0wj6jvI6wrhz0YCS0Zl8Xyogq2ZThrDeA2HY
	wlBVuUsj6LI6gAB31vRp8t01KwP+2g+/86SmL0D2bCyZ5OCLp3GqKGDMEPkHDlStD+xkg/FaZf3
	0bGas11rc1aS9Pacu1RRmVzLMo/vUxPLARJ2A5BbQzA==
X-Google-Smtp-Source: AGHT+IFStOQrnZ0kRqb2yl5GKZFeYdrPlYU3gUoNtnClKc/nE+dGNoCLWvPJpUrbamqhu/KduqcMqA==
X-Received: by 2002:a05:690c:380d:b0:712:d946:788e with SMTP id 00721157ae682-71406cd2533mr79141497b3.14.1750903922319;
        Wed, 25 Jun 2025 19:12:02 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4b96c1dsm26849247b3.62.2025.06.25.19.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 19:12:01 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:12:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685cac7163d82_2a5da429488@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625135210.2975231-9-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-9-daniel.zahka@gmail.com>
Subject: Re: [PATCH v2 08/17] net: psp: add socket security association code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add the ability to install PSP Rx and Tx crypto keys on TCP
> connections. Netlink ops are provided for both operations.
> Rx side combines allocating a new Rx key and installing it
> on the socket. Theoretically these are separate actions,
> but in practice they will always be used one after the
> other. We can add distinct "alloc" and "install" ops later.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>

>  /**
>   * struct psp_dev_ops - netdev driver facing PSP callbacks
>   */
> @@ -109,6 +145,28 @@ struct psp_dev_ops {
>  	 * @key_rotate: rotate the device key
>  	 */
>  	int (*key_rotate)(struct psp_dev *psd, struct netlink_ext_ack *extack);
> +
> +	/**
> +	 * @rx_spi_alloc: allocate an Rx SPI+key pair
> +	 * Allocate an Rx SPI and resulting derived key.
> +	 * This key should remain valid until key rotation.
> +	 */
> +	int (*rx_spi_alloc)(struct psp_dev *psd, u32 version,
> +			    struct psp_key_parsed *assoc,
> +			    struct netlink_ext_ack *extack);
> +
> +	/**
> +	 * @tx_key_add: add a Tx key to the device
> +	 * Install an association in the device. Core will allocate space
> +	 * for the driver to use at drv_data.
> +	 */
> +	int (*tx_key_add)(struct psp_dev *psd, struct psp_assoc *pas,
> +			  struct netlink_ext_ack *extack);
> +	/**
> +	 * @tx_key_del: remove a Tx key from the device
> +	 * Remove an association from the device.
> +	 */
> +	void (*tx_key_del)(struct psp_dev *psd, struct psp_assoc *pas);
>  };

This Tx driver API is necessary for devices that store keys in an
on-device key database.

The preferred device model for PSP is keys-in-descriptor, in line with
the protocol design goal of O(1) device state. 

In that case, can the driver leave these callbacks NULL? And, in the
driver tx datapath, access the tx key from psp_sk_assoc().

