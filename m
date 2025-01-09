Return-Path: <netdev+bounces-156858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C3A08090
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F333A1433
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5730C19CC1F;
	Thu,  9 Jan 2025 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJHrkX/L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96E2F43
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451055; cv=none; b=WHohx4n3d0LJbYiNtlKQF4M4i7b/3jCctgvue8RZ+6uNrdQDn2bXQi6Fs6LUBRx5T+pETGR5k58I9oyqW7e5lRgbpJX5/knuqpP4HZ9txzO1BZeA/2q3lc1GShYpWeJBJ18RW09YzcNROxiOKkDGh2NLciXrIJ1+uLiKAEWV2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451055; c=relaxed/simple;
	bh=Jhtvix7xSu3NnLP8KBl8g422PKpvaIRqarLc6lutKPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNkBjdf+QKclUdqMcPD3/DUSHrrl0i6LCYC4BvB0Xod74zgWTykymzNekNf/vfaGx0K4QTdlQUisSgba+8RgL8iqk3ewPMECr0LPuJwFroexgwlD9W8nM6FkG/twvqHCiCgKSCTQCqONY7ViqIlTxikJaAfp3GLaydjGIBYdEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJHrkX/L; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163affd184so19375ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 11:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736451053; x=1737055853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4oGp2x/UCnR+jaxZ+9JKVEatLAse5UBIsi8oCs7U7Y=;
        b=vJHrkX/LtKXoWq7Zqx2PleHUF/UMMO0UwiUGd/4ZJcltI+ERfUFRQ/fzLAZktEbvT+
         GU3D3dxr3re3G6oGz7PivFZiIKxyOAGS5/ZaSNUEUlIFS5EpzJawdk0EyzmqZHjz81A9
         hAR4pJ+0qO/7xRgR+PLFguefPMsT+jdTiD/xLusZqo4Tlj8DM6DbjNdEszc4fuQkHG5C
         nTdxNtr2CqUaLfBdMMRqsdFQ+kR/xFLq1Us79G9NVwhTrazeW9PfT2fdv+EXgFlGQx99
         pN37x9oS7Ddjhi29gE/lLl6exkzC86R0DuPdx0mqIjPKyeIrozZ4n28rnw1ZScwfGuzt
         EqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736451053; x=1737055853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4oGp2x/UCnR+jaxZ+9JKVEatLAse5UBIsi8oCs7U7Y=;
        b=isaVCkFcy/5nHMIdU1lMyfbm2oO2Cj7ItuRE/U+80xstBF7PVDtY6YNHPQWrCVmJAn
         mxd1qeUFgAvMPp2viC0FHCQJlnySh2U/fYhqfvAzUZ+tqvK22XCQlzPMwqMY8heB/10/
         TgVWJo2vBRebhIwKab6urYOp08uy20+jnJI93EKPATlEBmZaui1KBGGvuQV9tNaMrOwF
         PkrQjyoifoz7wNYJpObnyL16OQMSe4S96ESO95Y65N8oE/jgBKLnn9UJRUV7e5IO6A0Z
         s9uURWrqdTl+AJ9CEbbiWjEBottCjSFtyeELWIh92RkV04TvCQ9cYHmtg0/kCn/gkNNh
         IALA==
X-Forwarded-Encrypted: i=1; AJvYcCVYkKCAzaT2OlRGNZVKugi+OoCyoEbg3Hnq7s6f9C5XfCK8dfJ4xcTQpVVJNwqfmwgrQVgJuzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNqkJYmcDeu68yin3QXi4LWb77wES9F4ir9jGqVN6iXSMkkJJ
	5PKseZdjlxUvQIEiwhTcYmsvdtIhajxuLJm7PTgjilzIFpPUhgV2GxBxcgFlwA==
X-Gm-Gg: ASbGncuSSp/E6xLxu73R0Yu/MWO+chV7QXkWmj4FhXs+AGl6Fd5DGq8h6t6O9TmpDm8
	6blKgeJNW91Pg2s5eyv0y+hdtDFUBHj81oCC6WaR5jZkzti+Fjdljss7GuOIS6ZCjsbKbOi8nKH
	z6Ntcq9RKSAB3b8Uf52uRUZ462Th9QlmY9KRUGQ/WqHlMNAYTLlJHvrbyIgJyVZlig8pekP+g3o
	TrCior+xoaQMyqlmnvE/66iy4oQ9JyFI3P+M9Da4dfbIM/seER7v2fewVQO1Vbi9wG+GwIdNUlX
	sgAdJ59HIcXd+2xM7y8=
X-Google-Smtp-Source: AGHT+IFzCNaUMLZQpS69edpNe2wTv3yaxb8Nr5prG24P/7W0nGcPA5P5+q8wd2dZxn6wPzbERuUARA==
X-Received: by 2002:a17:902:74ca:b0:21a:5501:9d3 with SMTP id d9443c01a7336-21aa0a7e7a5mr123485ad.21.1736451052856;
        Thu, 09 Jan 2025 11:30:52 -0800 (PST)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5594512f0sm1827201a91.36.2025.01.09.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 11:30:52 -0800 (PST)
Date: Thu, 9 Jan 2025 19:30:48 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
Message-ID: <Z4Aj6KqkQGHXAQLK@google.com>
References: <20241218203740.4081865-1-dualli@chromium.org>
 <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com>
 <Z32fhN6yq673YwmO@google.com>
 <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
 <Z4Aaz4F_oS-rJ4ij@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Aaz4F_oS-rJ4ij@google.com>

On Thu, Jan 09, 2025 at 06:51:59PM +0000, Carlos Llamas wrote:
> Did you happen to look into netlink_register_notifier()? That seems like
> an option to keep the device vs netlink socket interface from mixing up.
> I believe we could check for NETLINK_URELEASE events and do the cleanup
> then. I'll do a quick try.

Yeah, this quick prototype worked for me. Although I haven't looked at
the api details closely.

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 536be42c531e..fa2146cf02a7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
+static int binder_netlink_notify(struct notifier_block *nb,
+	+	+	+	 unsigned long action,
+	+	+	+	 void *data)
+{
+	struct netlink_notify *n = data;
+	struct binder_device *device;
+
+	if (action != NETLINK_URELEASE)
+	+	return NOTIFY_DONE;
+
+	hlist_for_each_entry(device, &binder_devices, hlist) {
+	+	if (device->context.report_portid == n->portid)
+	+	+	pr_info("%s: socket released\n", __func__);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block binder_netlink_notifier = {
+	.notifier_call = binder_netlink_notify,
+};
+
 static int __init binder_init(void)
 {
+	int ret;
@@ -7244,6 +7259,8 @@ static int __init binder_init(void)
+	+	goto err_init_binder_device_failed;
+	}

+	netlink_register_notifier(&binder_netlink_notifier);
+
+	return ret;

 err_init_binder_device_failed:


With that change we get notified when the socket that registered the
report exits:

  root@debian:~# ./binder-netlink
  report setup complete!
  ^C[   63.682485] binder: binder_netlink_notify: socket released


I don't know if this would be the preferred approach to "install" a
notification callback with a netlink socket but it works. wdyt?

--
Carlos Llamas

