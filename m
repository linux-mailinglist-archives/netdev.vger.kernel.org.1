Return-Path: <netdev+bounces-166997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CAA3845C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713853A6DCD
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F121C177;
	Mon, 17 Feb 2025 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="h5KdNqs7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CB21B1B4
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797914; cv=none; b=P7OaN5avHEi1CvdpPXCZG5t8ZnwPTi5Qs3hZQ86VWeRgM1cKY8Ic20KV/5IwaTB5sN9ZQbIuBVkDpTPvHvqMh4XL7uBL+sNatpPeU4FASPxrZnQD9lRpdQbl7mlYFbewQegbBo+rLDegr0yxGZWiWJstPfOPHmGJwyRX+JbCZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797914; c=relaxed/simple;
	bh=lfr78p2A5jVRefCaAiXdLlhJV27jO/Mj83xebGp1A/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXcWC2R+GR3O0L7b6ofvykWfjZ6omKa94KHZoPKj/UN4XphsYeG3cl9dNGjz4YwBjalkmRxotIGx0GAVKl/Uyj1L9wcHgsXsX7WbexTenStD3AXcfK+uordWUU78DN7PrAyfxpnEM54kvggi3aSHWCoNB94DZ1Pg7ulKMKTsMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=h5KdNqs7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb9709b5b5so202756966b.2
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 05:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739797911; x=1740402711; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZGSnWSOdmnmCIeNKYOM1u4DOTrlY1/eGIJ0sCCrHWpg=;
        b=h5KdNqs71ZFZrMeTbma21TIpfMLaMf98j+DC1FrC7EZpUS7xOxMBAjpOYRY3VGZlyY
         JA1o8x0zaNsl3dis5tOIsNGDRp070GQtV2R3etUBd1r9XPSdjfx59nxb8jtU/ci8iYhj
         /SlgSkucECe2HOuDP1ps7qf6665dH9VvMv3TVKWZ+F/AS+Rf+p92GMPf43aA8aFGKltK
         HmxHW1Pb6f+oX+oce5bCZYw+dbQHC0P0aWGn+wdbbViIXBI5RJnjJGAU6oI7J+qnhI44
         K9oTPmJyKEoMxpQswI/5OC24t7hudVRRPmKogHEaRP662fFynbChPZbn7q2WvyT/MLJd
         yU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739797911; x=1740402711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGSnWSOdmnmCIeNKYOM1u4DOTrlY1/eGIJ0sCCrHWpg=;
        b=MZOE6HGG7RDWs7bbPSLUXTGwUpVts3RpKZaIz+mT6sbs2L1oRC+CY3zc0ZVcy+UE7s
         SaV3nRyjvM4OmQtqQO6JHGlpGRuFrd01VXflpRePP2wGMDgXmN6ELbhM5I1ySvObfPpw
         STK+FXq/dpb1q+4BaZG8Chba6H6HeUhjSZ/nHyQTqb6vhX+Dv4LomaWg0ZvRwuNSOxZO
         RJobqo95QzhtIC/PgHlS07mui4UPde1iPuMvPImap4hMjgxtRpGvGY+fcwjtxjPJzV0n
         ZmWTXrpJ5l5R8Rh3y9RmXw+2maLF5nJR5b+NY+roxT350hw5VcCKFmO/MbQ7mr2J7GXM
         0nFw==
X-Forwarded-Encrypted: i=1; AJvYcCXV1kD814NC5EsFq7bS9pkAhoVBjZB2julec6qTTaxBOikrnVdlcsiRyKUl3wMHN2xRdbxz34g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DTKygX5Anmp0eBaChemsYeeIWtTS+SpWa8wKJpgTiTCL8DCW
	u3oEOH/xy1unIPRCs9TkrouX86vYd8eZdUD8ryrHu9bCD6sgTxX2QsOZZvWEV0o=
X-Gm-Gg: ASbGncuMYN4xJwuL6yPrmL0E5hKGYZdBdmG2SRAizHAypkLPPhbtoyjAjm4Ia2PUVkK
	9+yS82vq1qVUMBBcd+40husp9usS1J8sYD+EMHWhD5Ktws+CTVbY9yFgbVPeTN0JNTrj087CiTX
	HLL+VgAFV+JTNPVkWJJQMFdNOWKYlVwYesccgYlHmvYvezM59Liu7N3rD1yFL77HZPLXXMLxO6q
	ykFCvG03lACQqvC0OJZxgMJrW/yNoyoYGbg5isgDyP/LiDCbubYifMnyRZWmckG3A75tyfQM9jk
	7h1hYRLUHcFWKeWuBdU=
X-Google-Smtp-Source: AGHT+IF7eAjnnASC5mMtuD0jAnM9vQ/BTp2C94jPW9Gre/tx/a0fMDK9WsSvCEbqFxAyTRPFsyMA7Q==
X-Received: by 2002:a17:907:7752:b0:aa6:7091:1e91 with SMTP id a640c23a62f3a-abb70c406dbmr864474866b.11.1739797910577;
        Mon, 17 Feb 2025 05:11:50 -0800 (PST)
Received: from jiri-mlt ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb80ba68aesm409310666b.23.2025.02.17.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:11:50 -0800 (PST)
Date: Mon, 17 Feb 2025 14:11:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
Message-ID: <v4zcjfsyv3iffd35wf5hflsjzyug5gwyoartisttyvwt3glufz@5a2ato6hmob2>
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>

Mon, Feb 03, 2025 at 06:21:24PM +0100, toke@redhat.com wrote:
>Network management daemons that match on the device permanent address
>currently have no virtual interface types to test against.
>NetworkManager, in particular, has carried an out of tree patch to set
>the permanent address on netdevsim devices to use in its CI for this
>purpose.
>
>To support this use case, add a debugfs file for netdevsim to set the
>permanent address to an arbitrary value.
>
>Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>---
> drivers/net/netdevsim/netdev.c    | 44 +++++++++++++++++++++++++++++++++++++++
> drivers/net/netdevsim/netdevsim.h |  1 +
> 2 files changed, 45 insertions(+)
>
>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>index 42f247cbdceecbadf27f7090c030aa5bd240c18a..3a7fcc32901c754eadf7d6ea43cd0ddc29586cf9 100644
>--- a/drivers/net/netdevsim/netdev.c
>+++ b/drivers/net/netdevsim/netdev.c
>@@ -782,6 +782,47 @@ static const struct file_operations nsim_qreset_fops = {
> 	.owner = THIS_MODULE,
> };
> 
>+static ssize_t
>+nsim_permaddr_write(struct file *file, const char __user *data,
>+		    size_t count, loff_t *ppos)
>+{
>+	struct netdevsim *ns = file->private_data;
>+	u8 eth_addr[ETH_ALEN];
>+	char buf[32];
>+	ssize_t ret;
>+
>+	if (count >= sizeof(buf))
>+		return -EINVAL;
>+	if (copy_from_user(buf, data, count))
>+		return -EFAULT;
>+	buf[count] = '\0';
>+
>+	ret = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
>+		     &eth_addr[0], &eth_addr[1], &eth_addr[2],
>+		     &eth_addr[3], &eth_addr[4], &eth_addr[5]);
>+	if (ret != 6)
>+		return -EINVAL;
>+
>+	rtnl_lock();
>+	if (netif_running(ns->netdev)) {
>+		ret = -EBUSY;
>+		goto exit_unlock;
>+	}
>+
>+	memcpy(ns->netdev->perm_addr, eth_addr, sizeof(eth_addr));
>+
>+	ret = count;
>+exit_unlock:
>+	rtnl_unlock();
>+	return ret;
>+}
>+
>+static const struct file_operations nsim_permaddr_fops = {
>+	.open = simple_open,
>+	.write = nsim_permaddr_write,
>+	.owner = THIS_MODULE,
>+};

Well, hwaddr is not a runtime config, it's rather provisioning time
config. I believe the best fit would be to put it to new_device_store()
or new_port_store().

We already implement couple of things there in new_device_store(), like
port count and number of queues.


>+
> static ssize_t
> nsim_pp_hold_read(struct file *file, char __user *data,
> 		  size_t count, loff_t *ppos)
>@@ -997,6 +1038,9 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
> 	ns->qr_dfs = debugfs_create_file("queue_reset", 0200,
> 					 nsim_dev_port->ddir, ns,
> 					 &nsim_qreset_fops);
>+	ns->permaddr_dfs = debugfs_create_file("perm_addr", 0200,
>+					       nsim_dev_port->ddir, ns,
>+					       &nsim_permaddr_fops);
> 
> 	return ns;
> 
>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>index dcf073bc4802e7f7f8c14a2b8d94d24cd31f1f7b..fffec5dbf80759240a323f7c3630c79c5c68faec 100644
>--- a/drivers/net/netdevsim/netdevsim.h
>+++ b/drivers/net/netdevsim/netdevsim.h
>@@ -140,6 +140,7 @@ struct netdevsim {
> 	struct page *page;
> 	struct dentry *pp_dfs;
> 	struct dentry *qr_dfs;
>+	struct dentry *permaddr_dfs;
> 
> 	struct nsim_ethtool ethtool;
> 	struct netdevsim __rcu *peer;
>
>---
>base-commit: 0ad9617c78acbc71373fb341a6f75d4012b01d69
>change-id: 20250128-netdevsim-perm_addr-5fca47a08157
>
>

