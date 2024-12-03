Return-Path: <netdev+bounces-148602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED79E2919
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A178E282E9F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924C1FAC45;
	Tue,  3 Dec 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="swUKoHjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A61F4731
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246705; cv=none; b=giOxN+BvPTTO9qPvWh/w4CL9zjxK/DM+L1VJ8/a8oBdSWPp6tQYcyVbPAzIIz0ISsx/cdySY5La69pWTf1JUdp71/95354qNE9+GmqKWsjdf2qEzL0KeWeTh42zygHn4mcIqVgMEp6zMX4iiH7M8vU97dh9Hg0IY7OOOHx2moxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246705; c=relaxed/simple;
	bh=S+DV4vomlAhrWT8NL5FQwF27Xis8NyVEDDUdlUYe3hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtACPdCdTEsKT6BTdZNWtaFvaEgKCIh3GGZEGrIsj84BsQ7IGr2Pnz1EdxsGzpHMchAl2sRkSRBLyjdOY1Jo31gJU1TQMIEQIUTx5A4mGeJtkLVjAXeEZjUMANiodXPS63NBYlRW/I0jMqSF8SpAU7GxUKe89FNrlDVOYhxN2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=swUKoHjl; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fcf59a41ddso93957a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 09:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733246701; x=1733851501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDIAp0k+WulLvelBjh0iQOU14uQ0KAvxIWVqAJex2I8=;
        b=swUKoHjlhCq4CTm29QqyIPDNg0hvTkNZIBSeepo30ryOb/aaE8JvRt6mlMpvGP2iQe
         I5TQppJdw0IKoeBmELxHPpmNcdP1S8+ooVgGfnSNgfWrYbsBnXK2oeeIkwaKfR95iQOp
         yX9ob52SML4TIm7biqV8wydOzM08Ez329oTNMTyhQ4/3sF6NQPIgcB6cLNuPC0JhnT2g
         VHSR98Xrya6Rfn0qOlSqghjB+PwFIVoN7uAFg4ZpTZD7Bqh3jsjSnkKWPeeFeIAunrc5
         NylRzO/YT1tVHQq6/zYqj/q3hea73bYEPJuInq7/8kd809xMe2peckF6e7jOqixINfEe
         0sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246701; x=1733851501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDIAp0k+WulLvelBjh0iQOU14uQ0KAvxIWVqAJex2I8=;
        b=H4VWB5UykL0e1Xh08tIok2U0xa3XQhHI1KsX5mGftkJHL0w9nqkVKDTj/KkINyL+C6
         cl9rHaEqIHD/2/eI1aUizJ54B0pSYwFuBicIrcPZmVDmMLrdlK8SppIRUs12De8Srd2l
         m+pAwojzb5iEDJNOJPlqrIWW6JTyaDQqE+xyGfvhe1ndNI2k9C7syb1rPAmHjBwFYRp/
         aIup+vuY8fiZbRQDGnpanNvJs/7ftIzjMcrewft55ysvcxmbguSamDp7ZuxjdK4QHlVz
         DoR0t3YG2O0McsrvZpE0MqkBZnsZNO4Q9UNunHNlJpI0SafEy4oG3o85wWvuiG8J41UW
         qhAw==
X-Forwarded-Encrypted: i=1; AJvYcCWFMBwZi0GAeKijyNO0RH42dhhltWStp1YFzceK6Ua7xuAwrcOnl9bVVaP1z5/0jD5n4lTZLB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4ID31qYvCvzJJDLpuVRRtKincO9fsfv+1786it7450uqt3be
	TNapDbdWrX/NBIFg5DPfCXqzEdxQfgqGH5JkqJqC00lG2z+9MSE/r/CKqJEaVPE=
X-Gm-Gg: ASbGnctYkHv/G2wlzFs6NTgwOQIK72y2fojYhP1giPiGGF2gxudzwUYwqWNyEN6Dhy4
	3sC/51ndi4SdSdD//xVgfmoief493d4xfpI4ET5haiVue0rTxOXUrikJh/5qr7ZCiV0+IYUQpwk
	RShtRGyObCS3LVrJF26B72xAUjcY/smo8AttqXh4x+21h3NCZGTbN7ku04x0+Lp7QwhqGCEW2QJ
	U0uiGmkD3Ls/IV5IiAnNoS0xGbamGbf4uhneunFa+Cd9Wo+6Ydz5bV3QwjgslVv65kqw/jo2xvO
	GCohG1C65yJgeHCbRhimXIdqRyM=
X-Google-Smtp-Source: AGHT+IFVttCytH4uriYlAc5b6vwoVfhSr0LlSgnBO9ywPRQ8142EzJA8hps3tzOfjvW84YqxE5vXHw==
X-Received: by 2002:a05:6a20:c908:b0:1e0:d240:19c with SMTP id adf61e73a8af0-1e16539f323mr5225858637.6.1733246701595;
        Tue, 03 Dec 2024 09:25:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f571sm10707168b3a.58.2024.12.03.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:25:01 -0800 (PST)
Date: Tue, 3 Dec 2024 09:24:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>, Aditya Prabhune
 <aprabhune@nvidia.com>, Hannes Reinecke <hare@suse.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Arun Easi <aeasi@marvell.com>, Jonathan Chocron
 <jonnyc@amazon.com>, Bert Kenward <bkenward@solarflare.com>, Matt Carlson
 <mcarlson@broadcom.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Jean
 Delvare <jdelvare@suse.de>, Alex Williamson <alex.williamson@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>
Subject: Re: [PATCH v3] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241203092456.5dde2476@hermes.local>
In-Reply-To: <18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org>
References: <18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 14:15:28 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> The Vital Product Data (VPD) attribute is not readable by regular
> user without root permissions. Such restriction is not needed at
> all for Mellanox devices, as data presented in that VPD is not
> sensitive and access to the HW is safe and well tested.
> 
> This change changes the permissions of the VPD attribute to be accessible
> for read by all users for Mellanox devices, while write continue to be
> restricted to root only.
> 
> The main use case is to remove need to have root/setuid permissions
> while using monitoring library [1].
> 
> [leonro@vm ~]$ lspci |grep nox
> 00:09.0 Ethernet controller: Mellanox Technologies MT2910 Family [ConnectX-7]
> 
> Before:
> [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> -rw------- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> After:
> [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> -rw-r--r-- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> 
> [1] https://developer.nvidia.com/management-library-nvml
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v3:
>  * Used | to change file attributes
>  * Remove WARN_ON
> v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
>  * Another implementation to make sure that user is presented with
>    correct permissions without need for driver intervention.
> v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
>  * Changed implementation from open-read-to-everyone to be opt-in
>  * Removed stable and Fixes tags, as it seems like feature now.
> v0:
> https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
> ---
>  drivers/pci/vpd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index a469bcbc0da7..a7aa54203321 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -332,6 +332,13 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
>  	if (!pdev->vpd.cap)
>  		return 0;
>  
> +	/*
> +	 * Mellanox devices have implementation that allows VPD read by
> +	 * unprivileged users, so just add needed bits to allow read.
> +	 */
> +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> +		return a->attr.mode | 0044;
> +
>  	return a->attr.mode;
>  }
>  

Could this be with other vendor specific quirks instead?

Also, the wording of the comment is awkward. Suggest:
	On Mellanox devices reading VPD is safe for unprivileged users.

