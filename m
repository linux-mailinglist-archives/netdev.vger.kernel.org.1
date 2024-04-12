Return-Path: <netdev+bounces-87535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9908A373A
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 22:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC1D1C22CC2
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354583F8E2;
	Fri, 12 Apr 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMGfo1wM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62BB3F9E1
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954823; cv=none; b=KfZvYg67AUPXUONmI1/WOqWLoR9ZBSf6wu0vfUOUJCmI5kND6ub1s2BrLUy3XkAAi0GXW7Dx/+lT1No1vcB2nR7tuZ/nkl0v1QYfIWusQ56hjM8wkvWMrTdjUnEnnPV4YibzT6qKceBTtIhdeXACMDWSk1EJxLl3JysaV1QDMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954823; c=relaxed/simple;
	bh=YbDtsX6Bxnl33uhn4lJTpEdXyZqFprD4LyrXiZo/sBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+HGYyRbObI/b76ciGAknwq5hMybKdYqwhjOpt3H/6LgDoFIA0rYIgzCK5MR+oqYkqr9kdCJlXyqU5OiAEWn9PyoJL13EQ03NM1WZ1wDKuj6gc5ASaNSkaT7TJMr2agLQbCBjHR6kBBt06bGUep6zDWLQs13mSWjealwQSOotrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMGfo1wM; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4dac5a3fbeaso516100e0c.3
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954820; x=1713559620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KmL2nyn4jWlGFSn8KqIuSl3GHAumDP1gAvaqPxNDoQ=;
        b=FMGfo1wMOSPh/uxIPDOA+/vxnHrGARop/Sc9bGMyitRWptUtI/bZ+4xTp3c/SeI17x
         lc1iUTZLaxQ05TbARka3zxlUxaHw3SSoViw7HDg+GtTpc9zoJtnL1+Lt9GpHz5JxZHmT
         a4gI7w+uLnU+qE9kLOUQUYIR8sZbuj9f/elwSHo9Sr/mzZeUuOpmJ/fI+08KBQNVwqAu
         PVyySDwNDkoB5OpVLRzduOUSBwLRvt8mJvZXS6T1UiZzfRNinWEUuH7Eze1wJKl2Ig8F
         xzqXnIBkazP1bKnfCis8vhwRYneMf4DLcIAvlZOXDac7PCv1NGaDwJU/w/VwHu8vSgDb
         NSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954820; x=1713559620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KmL2nyn4jWlGFSn8KqIuSl3GHAumDP1gAvaqPxNDoQ=;
        b=J4k/9u/rJ2/7vw5y0PtSeFSkn6vLOkdoKzAzZIL0GW0yGzdlz8iU84YGJfTlM1/7kn
         N6Vx1eL8n/dT1XRfBMnIrG4aaX1jwlP1nxuxceEifdK4reYY408l2reOxWrhTvb3mgew
         NFWkXPE6SRPwMd1tTY6EAPf6SC1Kowj4VG+jogp7X1peOGAiLoifRf0F1n1yZRl2rZ1c
         d8zyF0eIIbnYn1uA0KuP4fpDCXc31tb0/0Uv/nqToFEUJpNp7Nk+WNNlAwT5IWe/0Rum
         3YxYhNnPoVRQ02XDC6Yu8vMdmv6Ldo8K6xFLBgP0R2TNiQhgE1fx/GWUYvYSsX3euoQ+
         7R7Q==
X-Gm-Message-State: AOJu0YyblTEkSCmWnU6gzj2cjpE6VlQ7YfR50mwoqCquvs1KgC9xiku3
	2UFbkoiiLX2CYX3hpbJS85Ormlw8QE+ap6GHxyKMwXxyv0HznJ/p
X-Google-Smtp-Source: AGHT+IHM2miLX2tcVafyyhzFoWw8So4ETDOFnSZdLf8WCGGhlntQHz7m+UVucs06+uQ1URBh6HdI1A==
X-Received: by 2002:a05:6122:2221:b0:4d4:32e1:e7b4 with SMTP id bb33-20020a056122222100b004d432e1e7b4mr3944460vkb.4.1712954820361;
        Fri, 12 Apr 2024 13:47:00 -0700 (PDT)
Received: from localhost ([142.169.16.165])
        by smtp.gmail.com with ESMTPSA id ee2-20020a0562140a4200b0069b5839d26dsm1276761qvb.9.2024.04.12.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:47:00 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:46:58 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 6/6] selftests: virtio_net: add initial tests
Message-ID: <ZhmdwiGi-r6eDyB-@f4>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412151314.3365034-7-jiri@resnulli.us>

On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce initial tests for virtio_net driver. Focus on feature testing
> leveraging previously introduced debugfs feature filtering
> infrastructure. Add very basic ping and F_MAC feature tests.
> 
> To run this, do:
> $ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
> 
> Run it on a system with 2 virtio_net devices connected back-to-back
> on the hypervisor.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/drivers/net/virtio_net/Makefile |   5 +
>  .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
>  .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
>  create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 6dab886d6f7a..a8e40599c65f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -20,6 +20,7 @@ TARGETS += drivers/s390x/uvdevice
>  TARGETS += drivers/net
>  TARGETS += drivers/net/bonding
>  TARGETS += drivers/net/team
> +TARGETS += drivers/net/virtio
>  TARGETS += dt
>  TARGETS += efivarfs
>  TARGETS += exec
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
> new file mode 100644
> index 000000000000..c6edf5ddb0e4
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+ OR MIT
> +
> +TEST_PROGS = basic_features.sh
> +
> +include ../../../lib.mk

Makefile is missing something like

TEST_FILES = \
	virtio_net_common.sh \
	#

TEST_INCLUDES = \
	../../../net/forwarding/lib.sh \
	../../../net/lib.sh \
	#

Without those, these files are missing when exporting the tests, such as
with:

cd tools/testing/selftests/
make install TARGETS=drivers/net/virtio_net/
./kselftest_install/run_kselftest.sh

