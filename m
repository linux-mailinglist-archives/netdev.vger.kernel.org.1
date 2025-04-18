Return-Path: <netdev+bounces-184181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71648A939FC
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B8F7A492E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D1213E6A;
	Fri, 18 Apr 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITF4l0rc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5652139D1;
	Fri, 18 Apr 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990884; cv=none; b=WHACYdXlLczAARehzrMn5MIDp+kYNSUNbWd0VXJOxu7wrJRv7oZGWY5nTFOwLCMkT/kYxucPVXHfWCBPPAZnBj1M+bzy79phC1KhNySFdpim8YEl5cg8xzpSZjHm6i7MjvydmtfNxOl6f0OqjZ3ECKKUFgCy3q1/nGtTilMfxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990884; c=relaxed/simple;
	bh=Ei4hL6/iq+Fcex69xWAqM/CXlKvWLYHQG9EDDXMJvik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpNnYExIL24TkuhWfZ1TtINiyAHWQExZDGzEjeRWViIhpYnc3QQ1aBE/YV7fpmUC3veOYruRFBzXUx4r4HMQFaySwqLQhy6mJzd/aUyd97oUvR0KmhkZ92o16VqXyUGqGgs0zfr6OjvSUkNAfkAj4N5yL5M7/obNyGGz0AnnlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITF4l0rc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e8484bb895so559196a12.0;
        Fri, 18 Apr 2025 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744990881; x=1745595681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/cWTo90FQUpqjGK8y/mmDlFDVu6Jy0NFCw7BclObhA=;
        b=ITF4l0rcaAdOPj/9WXMVx1rnceAg6Hv4CPCoJTTXgpEmheubPkeSf7A0vWYLimnMFf
         Ax/vBG3rneEm5Kkk3aC+njRxilRIxtf0oGw6yqfQ4ckqBeDX1kcnw2+i41dTAUpe1C0E
         4fiit87CmU6WL6b3BVCbJtXnx8cgf+CReYKD37vbN/n9MZCWAj6/0vHwFlwk0+R4mTOX
         YfVFoTivsQK3SZiqmsErQAjhcbBwiMXd+YENfk+vmNGw6NiXEAYQ46Cf79ErtkukKiaX
         8ZReaREZS39bUjp2K4ErJg+Ww9or2KwhsEQMNqUROK+MqGCPrHBbOYt1Ays6pIYhuTC1
         dQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744990881; x=1745595681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/cWTo90FQUpqjGK8y/mmDlFDVu6Jy0NFCw7BclObhA=;
        b=SJoE6jtAVjc2/kKrq4NSwYzk/0t+eWGPPNPyLzaicCiUtdQrj2v/MzMvBgTzRJB2xR
         nOP3xBRaTc4/2Tw8oBn5A3e9MmX/Y3kzVebAOKUoo3AxS8+JEmNsZshuEmDGtPiF2Sy/
         +TwHKitH6WV+nJubVE52gSEn77GUeLruCK1OFjRP6wi/nnciTfpb5VhqPHTeoygEHn7+
         Fk6Je+7Zecy/IjVTmnPymZZojVlX+vEONI3/1lsvW4z4/s5VpLaV/i14BFDrTK/XZWmj
         XBXjA6cIFg1+7Krk4m27KAud34p8wbTwyrQfrbI9t98UlEXR7UJXMu9wzhVk+j9i0Nrp
         7zog==
X-Forwarded-Encrypted: i=1; AJvYcCXQCqb73xP6f6J6GPb2auXzQTGaBAydK34jhDV4cKdIJ+Ux+xAsDAxZswPE1gPqjKVfaXbiGubzUCfxh0I=@vger.kernel.org, AJvYcCXzfZjfl8bAfcqgCBhnbLyD/EVlza+UrvfmIWUGaGTi7AF4yxJr46p/DvN74nqR1c4Y5mXSC86K@vger.kernel.org
X-Gm-Message-State: AOJu0YxIok1OA0aBs26tpFll/+houXlCkIIkKzsxpa3WL1Z7M3J0cD/G
	LPbQFqP757E4cwQWZMd7Tp1AYwwFQ5Pk4f/mD6E1lw5UTgxj98oJ
X-Gm-Gg: ASbGncvGSasEQ4pYK0YBhGz8t6Aifk5xi/oez07QbsEyrumDtQnrKh59RdpIEOtBitS
	g7oc4fbe+nP3FJ5EgWnvWxlU5ydb63Z7qni5MhOnPCEF129ghdz4wmcncNcbkaXQD6V7wHeT1aK
	tCLaBMNXDVAEGeI7zh/7j6TqlZnBAHuG7KyUPNRTb1GRIv6wQfHmp1Ij5G9uDDonL7HvKAV+oIN
	hO2pTeVCWDLIFOjURTKtzO1EBYOqQxpk27exkFZN8CnvAFG6Y6yM2o6UnAOEQlrEqd7XthYBqAP
	2IcT6J6oP2JNHgwtcgtmY6q4k4WB
X-Google-Smtp-Source: AGHT+IEkRAOdwHdMRa6d2QlCY5Yrw6uQ9t0434Mw1NfnH0yIfWXjkcyamqR6CUsapH+iG9W1uhu/lw==
X-Received: by 2002:a05:6402:4301:b0:5f4:ca86:916c with SMTP id 4fb4d7f45d1cf-5f628524a18mr946596a12.3.1744990880873;
        Fri, 18 Apr 2025 08:41:20 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625595590sm1128785a12.41.2025.04.18.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 08:41:19 -0700 (PDT)
Date: Fri, 18 Apr 2025 18:41:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 net-next 04/14] net: enetc: add MAC filtering for
 i.MX95 ENETC PF
Message-ID: <20250418154117.jcd6xxnwot4nmhek@skbuf>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411095752.3072696-5-wei.fang@nxp.com>

On Fri, Apr 11, 2025 at 05:57:42PM +0800, Wei Fang wrote:
>  static const struct enetc_pf_ops enetc4_pf_ops = {
>  	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
>  	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
> @@ -303,12 +489,55 @@ static void enetc4_pf_free(struct enetc_pf *pf)
>  	enetc4_free_ntmp_user(pf->si);
>  }
>  
> +static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
> +{
> +	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
> +	struct enetc_pf *pf = enetc_si_priv(si);
> +	struct net_device *ndev = si->ndev;
> +	struct enetc_hw *hw = &si->hw;
> +	bool uc_promisc = false;
> +	bool mc_promisc = false;
> +	int type = 0;
> +
> +	if (ndev->flags & IFF_PROMISC) {
> +		uc_promisc = true;
> +		mc_promisc = true;
> +	} else if (ndev->flags & IFF_ALLMULTI) {

enetc4_psi_do_set_rx_mode() runs unlocked relative to changes made
to ndev->flags, so could you at least read it just once to avoid
inconsistencies?

Speaking of running unlocked: if I'm not mistaken, this code design
might lose consecutive updates to ndev->flags, as well as to the address
lists, if queue_work() is executed while si->rx_mode_task is still
running. There is a difference between statically allocating and
continuously queuing the same work item, vs allocating one work item
per each ndo_set_rx_mode() call.

In practice it might be hard to trigger an actual issue, because the
call sites serialize under rtnl_lock() which is so bulky that
si->rx_mode_task should have time to finish by the time ndo_set_rx_mode()
has a chance to be called again.

I can't tell you exactly how, but my gut feeling is that the combination
of these 2 things is going to be problematic.

