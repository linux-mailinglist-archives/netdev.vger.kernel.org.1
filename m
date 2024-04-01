Return-Path: <netdev+bounces-83773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DDB893D9D
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468A01C218B1
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158750A8F;
	Mon,  1 Apr 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8ntGDeY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F27481D5
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986816; cv=none; b=Oymuz1caEqU/T0IOylEY4EyJ5Sa6EcN4AF4Zqnm+sjey/Uf0Zm8ZhUf8dVgyRpsHTLdKwhct6zuaiK/O4FNLrkf2p9m8vQZWxELThteGao2nXmIIWVO5eJ2C4hcjOBWzuagzqB7s8NPz5o7hYClBh2vpgEP/cLAtZD5SyItLII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986816; c=relaxed/simple;
	bh=PQ4g9f5DrXFqYCguitl1X3Zo+BkL7mlCWZPowFOgeBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLl01GVM9Uulv/wqzsK3c3RWiTatzrxxZ5iCEIBOGZnPoppSLnos0N3rsr4rzqoF8DN6TAL0yDV8W0aGUpAbi7HGc+OeRymtE0is6sCojGZAu7JYtkz2gxPs/nr0QD8/cJcH97vNy39irerKqdipRbdnOL7GEA+MTOS097EQPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8ntGDeY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4734ae95b3so533499566b.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711986812; x=1712591612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NOEEOy+FjOftmDpkpgKqII5upFUQcLnLC6HRuYiQr+U=;
        b=a8ntGDeYEFkKpik2DK0jDZswoWUcKZXQnWjGgutHKd7URvfX3hIyXdOliFNOl8DkId
         sI3UgdeqOChSPvgp5LH0EN7jYwD9DPLgF97d6IlUHKWmoL7v5Pf4AOWmIF24pF3h5DtI
         xFCMH79gEgEW3Zkaw1RFDNNJa9APGmIcWk6bmvRjYHeLFZLNLmcUItVVh04tbKEmPTYp
         TCFV/wNLlhyeP7NnsVI1Ys+65DNKpy0f+97f7/+vbFqvt7wbQsIiW6ag8gNF/8Admp8F
         kn9ZtiU9HhrYMgUcR6gNRHcJOH9UMZ93l4uDYmVsfX+7jUHyFbu4siSWdUEj/KDWGde5
         bZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986812; x=1712591612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOEEOy+FjOftmDpkpgKqII5upFUQcLnLC6HRuYiQr+U=;
        b=bqXzKSWA9KIB63AAHHoiiVj1lhydrw9Tu35bPlNre3QVbJuiSGdfOzQenhjpPncHiP
         8Q2c3/kq9c9ODiYDX3NvjKUPdY6j8S8N7qC/4M7VRX6rfnhGwX0Gw5qCJBu/Xw6KYIEN
         S04NWROqavEQ8Lx5jEYQ1nj4JXokLG75EQzvclMmMEbiAvKeyU11XjpqS9QvRM5H2d7a
         XE0jFI7EWXET4+AkbAJj8EJBlrY7Ha1vtMhR9UBnpdQhYg1pZVZre4MbdcTKlARqnLN3
         fyFrhtr2+XnbT8Blur7OeU+XYXkjlzIBgwiNJsgbJaqCrcp8qH+RW3+cygOHLP0UOuja
         txIw==
X-Forwarded-Encrypted: i=1; AJvYcCWvAxwWk9v0fulS360xHINU6/su6PhmwyEFgSO+sLrJELZTElDiqnzIL03bU5Aad5BnSeDTcTPtVPEsn73LpdSMpLcNfFN3
X-Gm-Message-State: AOJu0Yzsw+iqyI+1Ll6vYoQ6zNmKyrmYPhVq6u7nnqOaulRH6pzbqs8a
	RJjTi8ChyT7ntzjwIHcDkLs2QYorK1r1CeatjhbpnIY0L9J688FK
X-Google-Smtp-Source: AGHT+IEFGB8QR6TbeGmmZ1G77MZBY/8FZ1NDvyYsh+c6aG3SzQ3gCjVoez3BT1j4PFaCjx5OB7Avbg==
X-Received: by 2002:a17:906:1699:b0:a4e:6223:250b with SMTP id s25-20020a170906169900b00a4e6223250bmr2339522ejd.15.1711986812038;
        Mon, 01 Apr 2024 08:53:32 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id re26-20020a170906d8da00b00a474ef94fddsm5435369ejb.70.2024.04.01.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:53:29 -0700 (PDT)
Date: Mon, 1 Apr 2024 18:53:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] dsa: move call to driver port_setup
 after creation of netdev.
Message-ID: <20240401155327.bn7sttch6kzij5n7@skbuf>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-1-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-1-221b3fa55f78@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2od7ytfxsi7cusvn"
Content-Disposition: inline
In-Reply-To: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-1-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-1-221b3fa55f78@lunn.ch>


--2od7ytfxsi7cusvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Title: "net: dsa:" prefix, no "."

On Mon, Apr 01, 2024 at 08:35:46AM -0500, Andrew Lunn wrote:
> The drivers call port_setup() is a good place to add the LEDs of a
> port to the netdev representing the port. However, when port_setup()
> is called in dsa_port_devlink_setup() the netdev does not exist
> yet. That only happens in dsa_user_create() which is latter in

later

> dsa_port_setup().
> 
> Move the call to port_setup() out of dsa_port_devlink_setup() and to
> the end of dsa_port_setup() where the netdev will exist.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/dsa/devlink.c | 17 +----------------
>  net/dsa/dsa.c     |  3 +++
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
> index 431bf52290a1..9c3dc6319269 100644
> --- a/net/dsa/devlink.c
> +++ b/net/dsa/devlink.c
> @@ -294,20 +294,12 @@ int dsa_port_devlink_setup(struct dsa_port *dp)
>  	struct dsa_switch_tree *dst = dp->ds->dst;
>  	struct devlink_port_attrs attrs = {};
>  	struct devlink *dl = dp->ds->devlink;
> -	struct dsa_switch *ds = dp->ds;
>  	const unsigned char *id;
>  	unsigned char len;
> -	int err;
>  
>  	memset(dlp, 0, sizeof(*dlp));
>  	devlink_port_init(dl, dlp);
>  
> -	if (ds->ops->port_setup) {
> -		err = ds->ops->port_setup(ds, dp->index);
> -		if (err)
> -			return err;
> -	}
> -
>  	id = (const unsigned char *)&dst->index;
>  	len = sizeof(dst->index);
>  
> @@ -331,14 +323,7 @@ int dsa_port_devlink_setup(struct dsa_port *dp)
>  	}
>  
>  	devlink_port_attrs_set(dlp, &attrs);
> -	err = devlink_port_register(dl, dlp, dp->index);
> -	if (err) {
> -		if (ds->ops->port_teardown)
> -			ds->ops->port_teardown(ds, dp->index);
> -		return err;
> -	}
> -
> -	return 0;
> +	return devlink_port_register(dl, dlp, dp->index);
>  }
>  
>  void dsa_port_devlink_teardown(struct dsa_port *dp)
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index 09d2f5d4b3dd..6ffee2a7de94 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -520,6 +520,9 @@ static int dsa_port_setup(struct dsa_port *dp)
>  		break;
>  	}
>  
> +	if (ds->ops->port_setup)
> +		err = ds->ops->port_setup(ds, dp->index);
> +

This overwrites the not-yet-checked "err", masking the dsa_user_create()
return code, and breaking the error handling logic below. Not to
mention, if ds->ops->port_setup() fails for a user port, we should call
dsa_user_destroy().

>  	if (err && dsa_port_enabled)
>  		dsa_port_disable(dp);
>  	if (err && dsa_port_link_registered)
> 
> -- 
> 2.43.0
> 

It would have been good for the API, if we want the netdev to be
available for user ports at port_setup() time, for it to be available at
port_teardown() time as well. So dsa_port_devlink_teardown() needs
changing too.

Additionally, for CPU and DSA ports, this change will make
ds->ops->port_enable() be visible from the driver API earlier than
ds->ops->port_setup(), which isn't exactly intuitive or great or better
than before.

In fact, I think it's very difficult not to make mistakes changing the
code in its current form. These 3 patches I've prepared - which replace
this patch - should help (see attached).

--2od7ytfxsi7cusvn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-consolidate-setup-and-teardown-for-shared-po.patch"

From 205b3503ca15c93ba8e90d42bb2855fa0c8497e3 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 1 Apr 2024 17:43:29 +0300
Subject: [PATCH 1/3] net: dsa: consolidate setup and teardown for shared ports

CPU and DSA ports have the same port setup and teardown logic, only the
string that gets printed on error differs. Consolidate the code paths.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 09d2f5d4b3dd..64369fa5fd07 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -479,23 +479,6 @@ static int dsa_port_setup(struct dsa_port *dp)
 		dsa_port_disable(dp);
 		break;
 	case DSA_PORT_TYPE_CPU:
-		if (dp->dn) {
-			err = dsa_shared_port_link_register_of(dp);
-			if (err)
-				break;
-			dsa_port_link_registered = true;
-		} else {
-			dev_warn(ds->dev,
-				 "skipping link registration for CPU port %d\n",
-				 dp->index);
-		}
-
-		err = dsa_port_enable(dp, NULL);
-		if (err)
-			break;
-		dsa_port_enabled = true;
-
-		break;
 	case DSA_PORT_TYPE_DSA:
 		if (dp->dn) {
 			err = dsa_shared_port_link_register_of(dp);
@@ -504,7 +487,8 @@ static int dsa_port_setup(struct dsa_port *dp)
 			dsa_port_link_registered = true;
 		} else {
 			dev_warn(ds->dev,
-				 "skipping link registration for DSA port %d\n",
+				 "skipping link registration for %s port %d\n",
+				 dsa_port_is_cpu(dp) ? "CPU" : "DSA",
 				 dp->index);
 		}
 
@@ -543,10 +527,6 @@ static void dsa_port_teardown(struct dsa_port *dp)
 	case DSA_PORT_TYPE_UNUSED:
 		break;
 	case DSA_PORT_TYPE_CPU:
-		dsa_port_disable(dp);
-		if (dp->dn)
-			dsa_shared_port_link_unregister_of(dp);
-		break;
 	case DSA_PORT_TYPE_DSA:
 		dsa_port_disable(dp);
 		if (dp->dn)
-- 
2.34.1


--2od7ytfxsi7cusvn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-net-dsa-break-out-port-setup-and-teardown-code-per-p.patch"

From b3876b65634004dc16648016820077b21a6270dd Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 1 Apr 2024 18:01:28 +0300
Subject: [PATCH 2/3] net: dsa: break out port setup and teardown code per port
 type

It is very hard to make changes to the control flow of dsa_port_setup(),
and this is because the different port types need a different setup
procedure.

By breaking these out into separate functions, it becomes clearer what
needs what, and how the teardown should look like.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 102 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 35 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 64369fa5fd07..5d65da9a1971 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -460,12 +460,69 @@ static void dsa_tree_teardown_cpu_ports(struct dsa_switch_tree *dst)
 			dp->cpu_dp = NULL;
 }
 
-static int dsa_port_setup(struct dsa_port *dp)
+static int dsa_unused_port_setup(struct dsa_port *dp)
+{
+	dsa_port_disable(dp);
+
+	return 0;
+}
+
+static void dsa_unused_port_teardown(struct dsa_port *dp)
+{
+}
+
+static int dsa_shared_port_setup(struct dsa_port *dp)
 {
-	bool dsa_port_link_registered = false;
 	struct dsa_switch *ds = dp->ds;
-	bool dsa_port_enabled = false;
-	int err = 0;
+	bool link_registered = false;
+	int err;
+
+	if (dp->dn) {
+		err = dsa_shared_port_link_register_of(dp);
+		if (err)
+			return err;
+
+		link_registered = true;
+	} else {
+		dev_warn(ds->dev,
+			 "skipping link registration for %s port %d\n",
+			 dsa_port_is_cpu(dp) ? "CPU" : "DSA",
+			 dp->index);
+	}
+
+	err = dsa_port_enable(dp, NULL);
+	if (err && link_registered)
+		dsa_shared_port_link_unregister_of(dp);
+
+	return err;
+}
+
+static void dsa_shared_port_teardown(struct dsa_port *dp)
+{
+	dsa_port_disable(dp);
+	if (dp->dn)
+		dsa_shared_port_link_unregister_of(dp);
+}
+
+static int dsa_user_port_setup(struct dsa_port *dp)
+{
+	of_get_mac_address(dp->dn, dp->mac);
+
+	return dsa_user_create(dp);
+}
+
+static void dsa_user_port_teardown(struct dsa_port *dp)
+{
+	if (!dp->user)
+		return;
+
+	dsa_user_destroy(dp->user);
+	dp->user = NULL;
+}
+
+static int dsa_port_setup(struct dsa_port *dp)
+{
+	int err;
 
 	if (dp->setup)
 		return 0;
@@ -476,38 +533,17 @@ static int dsa_port_setup(struct dsa_port *dp)
 
 	switch (dp->type) {
 	case DSA_PORT_TYPE_UNUSED:
-		dsa_port_disable(dp);
+		err = dsa_unused_port_setup(dp);
 		break;
 	case DSA_PORT_TYPE_CPU:
 	case DSA_PORT_TYPE_DSA:
-		if (dp->dn) {
-			err = dsa_shared_port_link_register_of(dp);
-			if (err)
-				break;
-			dsa_port_link_registered = true;
-		} else {
-			dev_warn(ds->dev,
-				 "skipping link registration for %s port %d\n",
-				 dsa_port_is_cpu(dp) ? "CPU" : "DSA",
-				 dp->index);
-		}
-
-		err = dsa_port_enable(dp, NULL);
-		if (err)
-			break;
-		dsa_port_enabled = true;
-
+		err = dsa_shared_port_setup(dp);
 		break;
 	case DSA_PORT_TYPE_USER:
-		of_get_mac_address(dp->dn, dp->mac);
-		err = dsa_user_create(dp);
+		err = dsa_user_port_setup(dp);
 		break;
 	}
 
-	if (err && dsa_port_enabled)
-		dsa_port_disable(dp);
-	if (err && dsa_port_link_registered)
-		dsa_shared_port_link_unregister_of(dp);
 	if (err) {
 		dsa_port_devlink_teardown(dp);
 		return err;
@@ -525,18 +561,14 @@ static void dsa_port_teardown(struct dsa_port *dp)
 
 	switch (dp->type) {
 	case DSA_PORT_TYPE_UNUSED:
+		dsa_unused_port_teardown(dp);
 		break;
 	case DSA_PORT_TYPE_CPU:
 	case DSA_PORT_TYPE_DSA:
-		dsa_port_disable(dp);
-		if (dp->dn)
-			dsa_shared_port_link_unregister_of(dp);
+		dsa_shared_port_teardown(dp);
 		break;
 	case DSA_PORT_TYPE_USER:
-		if (dp->user) {
-			dsa_user_destroy(dp->user);
-			dp->user = NULL;
-		}
+		dsa_user_port_teardown(dp);
 		break;
 	}
 
-- 
2.34.1


--2od7ytfxsi7cusvn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-net-dsa-move-call-to-driver-port_setup-after-creatio.patch"

From afebdb6e4b52101e863aa36a2fedb5828d93ed4c Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 1 Apr 2024 18:25:51 +0300
Subject: [PATCH 3/3] net: dsa: move call to driver port_setup after creation
 of netdev

The driver-facing method port_setup() is a good place to add the LEDs of
a port to the netdev representing the port. However, when port_setup()
is called in dsa_port_devlink_setup(), the netdev does not exist
yet. That only happens in dsa_user_create(), which is later in
dsa_port_setup().

Move the call to port_setup() out of dsa_port_devlink_setup() and to
the end of dsa_port_setup() where the netdev will exist. For the other
port types, the call to port_setup() and port_teardown() remains where
it was before (functionally speaking), but now it needs to be open-coded
in their respective setup/teardown logic.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/devlink.c | 17 +-------------
 net/dsa/dsa.c     | 59 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index 431bf52290a1..9c3dc6319269 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -294,20 +294,12 @@ int dsa_port_devlink_setup(struct dsa_port *dp)
 	struct dsa_switch_tree *dst = dp->ds->dst;
 	struct devlink_port_attrs attrs = {};
 	struct devlink *dl = dp->ds->devlink;
-	struct dsa_switch *ds = dp->ds;
 	const unsigned char *id;
 	unsigned char len;
-	int err;
 
 	memset(dlp, 0, sizeof(*dlp));
 	devlink_port_init(dl, dlp);
 
-	if (ds->ops->port_setup) {
-		err = ds->ops->port_setup(ds, dp->index);
-		if (err)
-			return err;
-	}
-
 	id = (const unsigned char *)&dst->index;
 	len = sizeof(dst->index);
 
@@ -331,14 +323,7 @@ int dsa_port_devlink_setup(struct dsa_port *dp)
 	}
 
 	devlink_port_attrs_set(dlp, &attrs);
-	err = devlink_port_register(dl, dlp, dp->index);
-	if (err) {
-		if (ds->ops->port_teardown)
-			ds->ops->port_teardown(ds, dp->index);
-		return err;
-	}
-
-	return 0;
+	return devlink_port_register(dl, dlp, dp->index);
 }
 
 void dsa_port_devlink_teardown(struct dsa_port *dp)
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5d65da9a1971..d8aa869e17ba 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -462,6 +462,15 @@ static void dsa_tree_teardown_cpu_ports(struct dsa_switch_tree *dst)
 
 static int dsa_unused_port_setup(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+	int err;
+
+	if (ds->ops->port_setup) {
+		err = ds->ops->port_setup(ds, dp->index);
+		if (err)
+			return err;
+	}
+
 	dsa_port_disable(dp);
 
 	return 0;
@@ -469,6 +478,10 @@ static int dsa_unused_port_setup(struct dsa_port *dp)
 
 static void dsa_unused_port_teardown(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->port_teardown)
+		ds->ops->port_teardown(ds, dp->index);
 }
 
 static int dsa_shared_port_setup(struct dsa_port *dp)
@@ -490,8 +503,23 @@ static int dsa_shared_port_setup(struct dsa_port *dp)
 			 dp->index);
 	}
 
+	if (ds->ops->port_setup) {
+		err = ds->ops->port_setup(ds, dp->index);
+		if (err)
+			goto unregister_link;
+	}
+
 	err = dsa_port_enable(dp, NULL);
-	if (err && link_registered)
+	if (err)
+		goto port_teardown;
+
+	return 0;
+
+port_teardown:
+	if (ds->ops->port_teardown)
+		ds->ops->port_teardown(ds, dp->index);
+unregister_link:
+	if (link_registered)
 		dsa_shared_port_link_unregister_of(dp);
 
 	return err;
@@ -499,23 +527,50 @@ static int dsa_shared_port_setup(struct dsa_port *dp)
 
 static void dsa_shared_port_teardown(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+
 	dsa_port_disable(dp);
+	if (ds->ops->port_teardown)
+		ds->ops->port_teardown(ds, dp->index);
 	if (dp->dn)
 		dsa_shared_port_link_unregister_of(dp);
 }
 
 static int dsa_user_port_setup(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+	int err;
+
 	of_get_mac_address(dp->dn, dp->mac);
 
-	return dsa_user_create(dp);
+	err = dsa_user_create(dp);
+	if (err)
+		return err;
+
+	if (ds->ops->port_setup) {
+		err = ds->ops->port_setup(ds, dp->index);
+		if (err)
+			goto user_destroy;
+	}
+
+	return 0;
+
+user_destroy:
+	dsa_user_destroy(dp->user);
+	dp->user = NULL;
+	return err;
 }
 
 static void dsa_user_port_teardown(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+
 	if (!dp->user)
 		return;
 
+	if (ds->ops->port_teardown)
+		ds->ops->port_teardown(ds, dp->index);
+
 	dsa_user_destroy(dp->user);
 	dp->user = NULL;
 }
-- 
2.34.1


--2od7ytfxsi7cusvn--

