Return-Path: <netdev+bounces-79792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9504587B654
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 03:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29CC2868A3
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 02:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCCE1A38F8;
	Thu, 14 Mar 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifkIBM+J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBD4439
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382402; cv=none; b=Gc9WL5kqH1sKW3Utxf6xR1/uzeJX8sXExswropXjoUVOUI4SjX/sRCP5KzYq5ACVXR3iRD0JlBu8GcHJhWT1uAQAhOmXlfpsLs2ZkcwN0XPHPldgEAwsrwFB7z7bXK1LljCaRonFMHFPppKnugKmiYvf55qonR3cKQ85CwOgYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382402; c=relaxed/simple;
	bh=y8bC6Lbo6BQvGgXx0LGzYBuFWY/SM/QxxCBA9RLnH+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p22ZK04tyiPfh5M89wkUOctId1WrqN+YyvzDENgTQiX7Wog32KYF4v7b/lB16GlaI+S3uRvg5GdTpxCn5RJm0NDpFxTcO2yfWnrYA4/sJ8ZqwOJgBnRCvDWFL5DZCVoVzri88YdUVPBzCv7tVdK40iNU0vUnASdGGLwNgOZlsWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifkIBM+J; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so187853241.1
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710382400; x=1710987200; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjimw3sTNCeiSCH0jYhkBEJLjAjRE7HY42sxEG70XLQ=;
        b=ifkIBM+J6ZVZmKrcFk+jVxL3oOfs+sX4YW5MjN+VX/4F1rjxW0gA/7I1FZkHvavoQF
         TXT7t2e7IKb6eDbF40NcRioyCLp+iH0dMDgbAaoB+J06FkRdBKdfw7nVr1F/F8A+cBtF
         E5D79HMTUJ7lVZmobwwpc4bpTMO6ePQhKJb+TZIaWo1+I+EJDPP2QYdaEz25dieQ0pL0
         SuNBkIIXMwX1reFIlggdbUUTqz/uEWNsGlEuez9aQiZ08FkO3ARAmr3yJSFa02V7Xhf7
         7QBU2V1/ASsZJAbwvXseC3YRe++IrMS53+Vcxq/LWpCT9FjSbIH2T/6j3Ij7tWvgNxuG
         /CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710382400; x=1710987200;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zjimw3sTNCeiSCH0jYhkBEJLjAjRE7HY42sxEG70XLQ=;
        b=HtZmd9kQF55oIZGs+ym6yZo+D56n/gVgf7sp1WMT+VYv2IN5HuSa1ptlNNCGcJw62m
         yN+snH586VeS9ieDGl+YFktjdpcDTgbOTeDLJ1gkbS5ucKt4rVazE6+Z6ePjzgl88PKW
         qlnGxY8BzowOJ1T3AcbFLFuk3PB7GmfAsdDo1hbQkfTavz27x9J9C6ZiOLIDVlafWEMx
         38FEecUFfwK+WfVappOYM6/hCFTakmyWesUJrZpqqBAtwK8sNmdPpwabTDpvnZAdpTCF
         Fq3mMV3DBE8ztc5wmCPQZSfhnFq2C33dA6fIFz+RPiIi1AUyiN8mXjpsZU1LaX6a9tlg
         85uA==
X-Gm-Message-State: AOJu0YyCtFKXeU6TcY89gxK8zaKmxQpVY26/62l+mpp/TT+IK3IP5dgW
	A6GHRf9ygzbj+Qh7dr76DqYZadngMO+6vwqIYmeiMHHuEfrIq7+N
X-Google-Smtp-Source: AGHT+IE51xWd3r6F1PoNt9b1C1sRfUBSZFV9GLO0VlXxeBf14jinFUfXAvtZtnsYMm9VztkDL6xOAg==
X-Received: by 2002:a05:6102:727:b0:474:ceda:fd14 with SMTP id u7-20020a056102072700b00474cedafd14mr658333vsg.3.1710382400199;
        Wed, 13 Mar 2024 19:13:20 -0700 (PDT)
Received: from zijie-lab ([2620:0:e00:550a:e7a1:321b:1b99:1b12])
        by smtp.gmail.com with ESMTPSA id h27-20020a05620a21db00b007885e5a81cbsm222639qka.79.2024.03.13.19.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 19:13:19 -0700 (PDT)
Date: Wed, 13 Mar 2024 21:13:18 -0500
From: Zijie Zhao <zzjas98@gmail.com>
To: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, chenyuan0y@gmail.com
Subject: [drivers/net/netdevsim] Question about possible memleak
Message-ID: <ZfJdPoN7be+5ohpl@zijie-lab>
Reply-To: zzjas98@gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Netdevsim Developers,

We are curious whether the function `nsim_bus_dev_new` might have a memory leak.

The function is https://elixir.bootlin.com/linux/v6.8/source/drivers/net/netdevsim/bus.c#L275
and the relevant code is 
```
static struct nsim_bus_dev *
nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queues)
{
	struct nsim_bus_dev *nsim_bus_dev;
	int err;

	nsim_bus_dev = kzalloc(sizeof(*nsim_bus_dev), GFP_KERNEL);
	...

	err = device_register(&nsim_bus_dev->dev);
	if (err)
		goto err_nsim_bus_dev_id_free;

	return nsim_bus_dev;

err_nsim_bus_dev_id_free:
	ida_free(&nsim_bus_dev_ids, nsim_bus_dev->dev.id);
	put_device(&nsim_bus_dev->dev);
	nsim_bus_dev = NULL;
err_nsim_bus_dev_free:
	kfree(nsim_bus_dev);
	return ERR_PTR(err);
}
```

Here if the `err_nsim_bus_dev_id_free` label is entered, `nsim_bus_dev` will be assigned `NULL` and then `kfree(nsim_bus_dev)` will not free the allocated memory.

Please kindly correct us if we missed any key information. Looking forward to your response!

Best,
Zijie


