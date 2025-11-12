Return-Path: <netdev+bounces-237951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47984C51F5F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C66188F4B3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E32EFD9E;
	Wed, 12 Nov 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5+8scvW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdFDwoYi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF382F28E5
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946654; cv=none; b=gSEoEsQRNPaJ6ASCiC9N0IWpppVo4j1QsU+Yhdw7r4YX7xiwUm476vUj/KO9EWlM2Y9KqwlRiNr8n0UExiNBOcMYSaBSLvNsBM8E75xoZaf0ecsYdybTwZ41oXL2aLgNRQaaBt/khZeMj/dpYAif1Kcrj9AWJVzAJdgkOweinM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946654; c=relaxed/simple;
	bh=7/0V7WKhYDg3U+bnov+MRIZUZa6EKfNx7qtPM/VQN+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6bNWZ7U2dXbdHBHyKp7f+tG5iuOVLDbXDM8z7nTz6viFyobasZXcrErb9afAsyQs1DahITaDdiY63a4SfrbQUx78mG+ZKwObkc2OH0bAHoyR6XqzQ6EpFagEzdkyviMGnfJDIBXjD4xyHVh8eCUdoUoqrgqfKeUXXNR4IOjbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5+8scvW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdFDwoYi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRM3b2n1y1d90nSJ+/3SrEo8VmC6gmyRB7DQ+Gs04+A=;
	b=e5+8scvW3gGKt4wz+KnPwcx91gRAHOOaSN4Q1EMFHHwhrUNwkF+UDAQhh2Nuj7OgG96cb5
	+7S9y/WCbB2QOLaS9eizUPWz73WrTGcmOkhIx1f4NP4EB4k/hj7nuobZx5vcvGznmKZgvo
	vbBqOXJXY9PilgqgwbxJS38a/jBqqjs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-g30wwYHeOvi_ktbL7xdusQ-1; Wed, 12 Nov 2025 06:24:09 -0500
X-MC-Unique: g30wwYHeOvi_ktbL7xdusQ-1
X-Mimecast-MFC-AGG-ID: g30wwYHeOvi_ktbL7xdusQ_1762946649
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecf9548410so16829251cf.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946648; x=1763551448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRM3b2n1y1d90nSJ+/3SrEo8VmC6gmyRB7DQ+Gs04+A=;
        b=fdFDwoYiemwCy9WiGcBYbq9Q913Kvvfa0+2wntbchXUbzL/pnh4l2Yr5JAzVsC24p+
         7skjiAdo3GzkK9TZTk+tGCRJXaP3kOCGf5hIbjVPI7YBKPyZIGaNGH0mUW948QMhRbkR
         YZA/c9bKSUnpqzcMcHqDXHb6DcQ/Xl766UGmdu5Nx3RPzUuLZ0yUpBIO9Z3cBNh9twCw
         9MeFs9xHaBxrTraxJIfZvndG8TWXcxc1sVlSD4yLHxu9kpuWie7vFmxqUgzXpEg2bSos
         P5yWKj3/f4ZrPa5+iTv9PoEEkrBu7ucnNLC0PrMiuGjKm2EFUiIDDaj4OVeADlnjc2rY
         TOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946648; x=1763551448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRM3b2n1y1d90nSJ+/3SrEo8VmC6gmyRB7DQ+Gs04+A=;
        b=EJHD6QY1KbCSYTR2bnz1XTIToZEBtd+gepsPBGF41M0dGxncAkgvKXTyN4f9aoEBT/
         0oL2y6FbU0GYIM53U6Wi9y020hFPkS9U6+FoE/k0kyam8pZB7g67P7gwuVG87ipW9aZv
         vqEhFt79nfx11M8GnknZ5Fb2vV+IHUEjDvLjy6Bzdmia/12eTglr7a47e/Sxt0i3vOo7
         mdfsy9JT/rN90K8Mje2iA/PSTy5LWX6Q9UIxWGFctjlFQsRRajWv7OP033/E7NZKSZuh
         6qr8ixNXZRMmL9bFb9iB/nnkjYrszaNpKcY7SB/zp9cPH8jiTNnPJTnySMXabwblUqSx
         rZPg==
X-Forwarded-Encrypted: i=1; AJvYcCWvBbCpr9RBM1icZrHY3phbUxoskU4In66RYthRBQqWmHzQjD1bO23AnUDlqOUnzT2j8y889Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6comxOmHtsnAP9pO5PZjtDYjuoITAph2/5E0i6PySI2ZeVT+y
	nsICAWKdsQ2fkzJ1oZ8bNhuMDYRtjlMMsPo62d6VwR16raHow/9ilJnWm5gBP6dPK+UF/WgjoP8
	cllDpofiHgYDLgzhH5FYY/5BhyQcJFVSd931Z32eL63WwAbJ1epF912jUmZKb8zBCQg==
X-Gm-Gg: ASbGnctIEguaurKGuY0INq2tm+TeThLZJaWwdjIDN9RIWMN1vhwyHqje9O7cbUuqDV/
	nSggATX3czTN6F1srEa/9EnYTtX6AzQAseNcuLSrYRn5HM9VwYtMQAyiXdvbHbUZwztbHL6yYuu
	fHz+qg1Tx21mXTQWcFpm6UC79fuBpo0L3MnWGTvaG4RMM2PTyNhIDXnA6rucaDqM9O/eKm1CRRe
	Yn8siOM1Buuls1vPhoYhbqlVKlsBvtCQgN32o57Fv8xtx/rrJ4K4Wn8wDmD+xBskUf2w4bnRUjY
	DXbP0XKfSDylCV8PBwGCDrfn5zuQSMSrNAl4k7xsnJHTcERjzL+dTbzdgouf/wwci4PZnHj3QJo
	g8x61EAJ8cpexTQ8FlinlxDE30DsAnVo7H6hi29rFfckeIZkyztU=
X-Received: by 2002:ac8:7f0c:0:b0:4ed:afb4:5e2a with SMTP id d75a77b69052e-4eddbdd580emr30525751cf.68.1762946648360;
        Wed, 12 Nov 2025 03:24:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi9lfYrqcHRO06/1BdvE4+TDOFgR+mc1Xy/qr6FjnRCvkl3aS8R3iVlzWEotM9WMLpQRj+pQ==
X-Received: by 2002:ac8:7f0c:0:b0:4ed:afb4:5e2a with SMTP id d75a77b69052e-4eddbdd580emr30525511cf.68.1762946647933;
        Wed, 12 Nov 2025 03:24:07 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6f88sm172172785a.30.2025.11.12.03.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:24:07 -0800 (PST)
Date: Wed, 12 Nov 2025 12:24:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Message-ID: <jnhqclrso3uy7ptqutykcsaocu2fh26wi6jm6s5ny4eldnv7zx@4wblegex46a7>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:57AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Reduce the time waiting for the QEMU pidfile from three minutes to five
>seconds. The three minute time window was chosen to make sure QEMU had
>enough time to fully boot up. This, however, is an unreasonably long
>delay for QEMU to write the pidfile, which happens earlier when the QEMU
>process starts (not after VM boot). The three minute delay becomes
>noticeably wasteful in future tests that expect QEMU to fail and wait a
>full three minutes for a pidfile that will never exist.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 6889bdb8a31c..bd231467c66b 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
> readonly VSOCK_CID=1234
> readonly WAIT_PERIOD=3
> readonly WAIT_PERIOD_MAX=60
>-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>+readonly WAIT_QEMU=5
> readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
> declare -A PIDFILES
>
>@@ -236,7 +236,7 @@ vm_start() {
> 		--append "${KERNEL_CMDLINE}" \
> 		--rw  &> ${logfile} &
>
>-	timeout "${WAIT_TOTAL}" \
>+	timeout "${WAIT_QEMU}" \
> 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
> }
>
>
>-- 
>2.47.3
>


