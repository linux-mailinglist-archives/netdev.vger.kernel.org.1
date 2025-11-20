Return-Path: <netdev+bounces-240588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D207C76A0D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 587C828A0C
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 23:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE012D6E4F;
	Thu, 20 Nov 2025 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgXfHQM+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98121E0BA
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681810; cv=none; b=UZHCNOEEHJzNMGoE7atR5z2csr0DNrX5b5Uc/kd0D9wNh03gC+xgxOdKKtzeunNiQmLHocrYAAlUH5C28MwWT+IZdnN1zM8EZHVSwTc6PKvR+3w0RrG4mqF8lhKuV6wtci6Knxz3Q88sL+Y7oRoIMkiI9A+88hu++VJxQ/BQdRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681810; c=relaxed/simple;
	bh=xgZokAZNABaDEkJOi6XbkoiCbaV/hMr2HbQKs7w9K+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLEm6a3D9tC2+7zqvG9jw6JgXLgKb7k875TvBwUGqBl+kzTRWMhrbrOYr2yRKfWhXWUlOw94t0Czeg/3aWkP/+jUjBWqS91+0RCowx2rfGPVBjX0NBnsth+pW6HfgP560jZREY1agduy2yB9pox7ab3bxM0/llHcYJtoIrPUniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgXfHQM+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787c9f90eccso15671097b3.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 15:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763681806; x=1764286606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7F8K5d92SUopdRevdYJsWlM5dC1gAVlWHDuGfPJviq0=;
        b=UgXfHQM+VzkoT9pZfTjeVQlBCkbkgN9lOhxDBGbx0kE7YcuvwPUZT0Avoe4dhS9Aqg
         YCg7oivtWKHNQhRlcbmsCgF9uldDucelEvevo+NCYiL9xGjmR5XmDzkauyVdiZqnmT4V
         GA2sJQJZhOrvDcF6H6JcxgUfhMj/Ajzp3zwc+ch2yY8P0icYsqJHp8fGajiyWE050y1s
         UHghG0pqVnXzJZjZl5KCxy/LsGC8CAWsHpWdyDfI1Jd52NpsbkIgWF43Id8wxwmZrDnP
         YfCB7qi8RKznsBlzAEQ2bUirfrcq/ZRvOpYjuHTr7LwJ/yEqXVUi1/gFM89PAfgM2cvv
         7IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763681806; x=1764286606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7F8K5d92SUopdRevdYJsWlM5dC1gAVlWHDuGfPJviq0=;
        b=rNbO096xX3XiVeauqVRd8mrRTa7epHCUEtRgZser4MoGvmWtcBMmQ/ANs46d0xv9ue
         pR16tzAbfq9IP81jIOQzWEBRlS4xrSpYckJEB+uec78kYGjjJosBVuXcji/14jkX5zyX
         8zgfgqFI03BpORu4OPekjbVyfl5YqVIn+nDuphVMT56clbHUcx9e+sxOavQHEBCoOcw3
         4uewPQnYaA3jV50zKWsbm/jGR6wrnxlNMrHuW7PhPail2DS46P6ls/niGdEgPl07UFR9
         Dp2mJZXdCbnO/4+XGKlHZffXnJ6m8oXYWxmjNGefa5rceo0Lmnbu6hjSoLEv9VDoFC7J
         qSLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYOZ/HuKBdWR+ud3nxiVa7DwVz0/9RwZm59h0jaFA2grmV6J4N0Dc1cmNt0SK2NqxO+3BdXvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxrlvi5pPLaRbSDZy5XDuCYgWLfFKK//LyJc8U75JUDL0r6Ejp
	QyO/sx8K8Od0b4pJBVEY914yrleuTYC2ARKvg/sF89lYlCofptbHkJl9
X-Gm-Gg: ASbGncsWUM7JIyXhAYNKFE7/+zE+9jWH+2kEUKz41zbI+3wUrUUf3AXDcyLWHGfWUed
	aqm/MZ3YJaeaeGtCB0cuQBFKc639ZUjpKid6Bd055ZDZL/8LVBU2MAUc+H9R9TxOfVlGKqaMNII
	r97WVxBuM5IlL0V6frU/jKe0LCL2gfAumv0tLbuy9wVFUtAYEdX+Mzpd71aYvxCShCquIRRS70j
	61ftyEIiH0Alqm3gQ3yHLtWyA4tUWN+0+DA5lWN3Y6A75bUelrbRo/FCITQMvugZEN45V5AHAHW
	gyNCMVV+cpiQGLBMK/A5oi3Qhh9BhHR9MSgTBdevuEpyLkHC9yIaLAq/Z1rRrNqTOCpLudzJPVl
	3JEVjZJQL7MN4QYxRwDlh1Q7WWocfBHKe6c58Y6PveVzZTBHP2KyeRBjNDfCKX1c8T6Bd21bLgI
	IXAn49rO01oswCEoXHvF/CymnjsiJwfAzYBK8YXGFCI9KfdMo=
X-Google-Smtp-Source: AGHT+IG936bzBd2t2ZDaxj9CFy9XI4BtCUEGOQ719Q5cTSLOuBM3YS+5i5WksDX1Mm7w5hHfQZBozg==
X-Received: by 2002:a05:690c:620e:b0:787:e384:4e7 with SMTP id 00721157ae682-78a8b55db14mr1407957b3.51.1763681806540;
        Thu, 20 Nov 2025 15:36:46 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a7f19sm11526177b3.20.2025.11.20.15.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:36:46 -0800 (PST)
Date: Thu, 20 Nov 2025 15:36:44 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 10/11] selftests/vsock: add tests for host
 <-> vm connectivity with namespaces
Message-ID: <aR+mDOF5/NOXa6/h@devvm11784.nha0.facebook.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-10-df08f165bf3e@meta.com>
 <s6zhozplsbiodcy77me7xhbhrbrozaanglbvcc474v6q77cc3w@ckaftl4qebwa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s6zhozplsbiodcy77me7xhbhrbrozaanglbvcc474v6q77cc3w@ckaftl4qebwa>

On Tue, Nov 18, 2025 at 07:15:03PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 17, 2025 at 06:00:33PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add tests to validate namespace correctness using vsock_test and socat.
> > The vsock_test tool is used to validate expected success tests, but
> > socat is used for expected failure tests. socat is used to ensure that
> > connections are rejected outright instead of failing due to some other
> > socket behavior (as tested in vsock_test). Additionally, socat is
> > already required for tunneling TCP traffic from vsock_test. Using only
> > one of the vsock_test tests like 'test_stream_client_close_client' would
> > have yielded a similar result, but doing so wouldn't remove the socat
> > dependency.
> > 
> > Additionally, check for the dependency socat. socat needs special
> > handling beyond just checking if it is on the path because it must be
> > compiled with support for both vsock and unix. The function
> > check_socat() checks that this support exists.
> > 
> > Add more padding to test name printf strings because the tests added in
> > this patch would otherwise overflow.
> > 
> > Add vm_dmesg_start() and vm_dmesg_check() to encapsulate checking dmesg
> > for oops and warnings.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v10:
> > - add vm_dmesg_start() and vm_dmesg_check()
> > 
> > Changes in v9:
> > - consistent variable quoting
> > ---

...

> > 
> > +test_ns_diff_global_host_connect_to_global_vm_ok() {
> > +	local oops_before warn_before
> > +	local pids pid pidfile
> > +	local ns0 ns1 port
> > +	declare -a pids
> > +	local unixfile
> > +	ns0="global0"
> > +	ns1="global1"
> > +	port=1234
> > +	local rc
> > +
> > +	init_namespaces
> > +
> > +	pidfile="$(create_pidfile)"
> > +
> > +	if ! vm_start "${pidfile}" "${ns0}"; then
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	vm_wait_for_ssh "${ns0}"
> > +	oops_before=$(vm_dmesg_oops_count "${ns0}")
> > +	warn_before=$(vm_dmesg_warn_count "${ns0}")
> > +
> > +	unixfile=$(mktemp -u /tmp/XXXX.sock)
> 
> Should we remove this file at the end of this test?
> 

Conveniently, socat does both the create and destroy for us.

> > +test_ns_diff_global_host_connect_to_local_vm_fails() {
> > +	local oops_before warn_before
> > +	local ns0="global0"
> > +	local ns1="local0"
> > +	local port=12345
> > +	local dmesg_rc
> > +	local pidfile
> > +	local result
> > +	local pid
> > +
> > +	init_namespaces
> > +
> > +	outfile=$(mktemp)
> > +
> > +	pidfile="$(create_pidfile)"
> > +	if ! vm_start "${pidfile}" "${ns1}"; then
> > +		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	vm_wait_for_ssh "${ns1}"
> > +	oops_before=$(vm_dmesg_oops_count "${ns1}")
> > +	warn_before=$(vm_dmesg_warn_count "${ns1}")
> > +
> > +	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
> 
> Should we wait for the listener here, like we do for TCP sockets?
> (also in other place where we use VSOCK-LISTEN)

Definitely, I didn't know ss could do this.

Best,
Bobby

