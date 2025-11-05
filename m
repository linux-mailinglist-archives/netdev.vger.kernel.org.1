Return-Path: <netdev+bounces-235829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A579DC36259
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51C0734619C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D5314B74;
	Wed,  5 Nov 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4y70iGw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lXSKymJZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85321246BB2
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354149; cv=none; b=exLVU135WGExHjkfnWuN91NEQN4D9+Uti72OxIV62CkDckYEB70bE/IfODakeXOpsffr8TkdKbT47/bV+q2qRnLrLfg+VSmOtnoXT4px1cOudXZCHULNzF+ZuqyJZ8/G0NHxnV8lh0MBlYOVraTIU3uMNmdg08kGex1YA15BasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354149; c=relaxed/simple;
	bh=YfvMW72encoRkud0wVtm/A7j2WUacp04L3fsNBayHvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYzdws3HLRfb91AfXWIasl5qtaWCC/gQNUocfu95reQWcLUlJ6MOLJYFLI0PVE54Pxs5KZrH1RpLAmFiaCg64uqbAVPadzogrQtuLbBjAXBihhL2iR9M/1H3kD1T2XQBgjW7SH4mni5YgpRrMpyDdvGCk5k7+y4eLmYUHtS2lV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4y70iGw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lXSKymJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
	b=T4y70iGwCcNYnAEoMHPTMmdakBZgvBt62dsOD+/QC8CwN3XiV4HOfRxHkG961/9RA7WfUf
	VMhC7xfU9DdZSdliG1ny2KFBlfpV9KNubbGM/aF/D8G++sEfFCRcqGJX+FYk9RsDHE2K8n
	X6ZmowgXr7DJ6z/2s8eBAcGOsmSjEzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-NyUZWkzbPRS26pgDpqB-2w-1; Wed, 05 Nov 2025 09:49:05 -0500
X-MC-Unique: NyUZWkzbPRS26pgDpqB-2w-1
X-Mimecast-MFC-AGG-ID: NyUZWkzbPRS26pgDpqB-2w_1762354144
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475dabb63f2so36173195e9.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 06:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762354143; x=1762958943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
        b=lXSKymJZLRal60Vh76tTo85Oz6Ng9PEp/SrkcphQ9kZ7PQyiuc+90rnnuzfn3ne7/I
         W3bc+6sREp9EkKnVgWIqvLfinym7NqMG1SW5b4isQkqah6R4F3w2yarBiutxX9/aeWqw
         M5HuZQmfSN5rwol1BkpVuUJx7F1zLe/9SmHm/prlIoQacB68rzeImmNmKdQFOtYoma7Q
         rnhIMZYmaGD8WdlBGq5g5Qr0jIqwf9dVxhhtX08Fjtv3RRUvGaVuOOLd7nIO9gtVGYw+
         iHtjaHQ+bxMqxSA3vR0YTMRxEovgjgwVtWuR4fzykypPbZEGxykQJhlr7NoZiHP3Nb74
         KwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354143; x=1762958943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
        b=THxXYOp2kiK/7kRgH4eOrgxv5PaoVX+nh1yV0XUQ6b/MF63mwDPACbm2PUz8K6whJv
         jHiKxqALdbrRH1pwxgvyv/SrgR23F0r+MRJiDNLKet7QWWK22kCKDVlUJ+Xvbd6TuEVp
         EgZn5WgNompGbXWkmuSJhu9s0hePOxTvDqhCT4ErfhLK0KY0KJLx79Jm+LqmOzJvLPWC
         84UC3qXS5Bj5zilVdBFK40mbEk5PG+cy7lfSELjDfTr6aFhH2+vrdhkxhyVKDKQrEvbk
         yQ3GFu30fgJ7WQqKO0hLd87sXrUaOZo3tMKVps5ngkfY4k1w8oyoGtRGvgoeE2qmddZO
         m7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUf4pw3xBI73pVdRDaiefR+8g6aKJP3Iz5h8mJx9vQWlGOmSt2vdJyWr9nDGus0DPwWowu3k/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaykFh1bca0GSvSKGZdh1EANvfugW6pI/8Rv5MgNez2dHx3MZF
	qT1o02Ye4j2bH4UOC+OOc9171WRKXJxyMHhkjBbF12PWt5EUwZh/eTG2O44MpmN8KyPh/TjoPUt
	PLZscGsJF4T/kGrw6+8YEgY5k9xG/nlmMcYN8J2Opd/nzMzQwIc6WG7KVCrLr2hHZAA==
X-Gm-Gg: ASbGnctlWZNW8Kr0wlRLTRFO67tPWdfwaUHYfKqW+vHs++8iSCwKH0fMqNJGTUghb/5
	x3uvKu02Wf2OkLaJSXZBGw0Cs0C4nyCa5Z+OA3j4T+590oVLSJrs5CpJ4Sfldw3x+g5vrgtVuZu
	2fxxEgp+ZX8ne3rITcpDhgVWDwRJEKvrZidZCwGSNqpvZMrQsZj8bsZcH/QsB/QuHrGBL4rISc4
	plenq4MB1gsZHsSto5B/n9UDk6eJGsJvXQFMIVPVzPBS85w6x2VaDRu8mMNSrpQkMtlqaRF/0P1
	Wlf+kNl55Egj7rhOtuxPotTcjJyM+FM9ZvKp4JV+iogcRtqshmd3dalMbm1+SWRb93Lz89lEyog
	=
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr30953915e9.6.1762354143240;
        Wed, 05 Nov 2025 06:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJCkXVCaYKB38WQ9mVlW2atyii43mXLtD2rPfe/M0bgqyi++PixdCT104cVwdbGCHZnaBsew==
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr30953665e9.6.1762354142802;
        Wed, 05 Nov 2025 06:49:02 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18f41bsm10751085f8f.9.2025.11.05.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:49:01 -0800 (PST)
Date: Wed, 5 Nov 2025 15:48:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 11/12] selftests/vsock: add vsock_loopback
 module loading
Message-ID: <ubfxj7koxuztrlrydfpjxenu7sdydq45rnhxkpmuurjfqvyh4j@mwzsqsioqzs5>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:39:01PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add vsock_loopback module loading to the loopback test so that vmtest.sh
>can be used for kernels built with loopback as a module.
>
>This is not technically a fix as kselftest expects loopback to be
>built-in already (defined in selftests/vsock/config). This is useful
>only for using vmtest.sh outside of kselftest.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 0657973b5067..cfb6b589bcba 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -434,6 +434,8 @@ test_vm_client_host_server() {
> test_vm_loopback() {
> 	local port=60000 # non-forwarded local port
>
>+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
>+
> 	if ! vm_vsock_test "server" 1 "${port}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>-- 
>2.47.3
>


