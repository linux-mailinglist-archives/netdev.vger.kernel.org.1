Return-Path: <netdev+bounces-237957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F8C52012
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB7F3BB3EB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7155130FF26;
	Wed, 12 Nov 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQVxioWc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcAd8N0D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BE30FC18
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946897; cv=none; b=dql/yMQCKgvFYtNtzwOeBUBNnLNquhpmbd9XyY3FtaEk5g+CPlx6k+IvKqNrX3Sv66GWLqzK8yJPGg+DpQr/9IzKAbQnQI2yyhLnvPwjeQz6Kapsfa5Y0lesia66XN/QuJXggSfGcj9MKigbvfDmTC7NfJnYraq/00wJcc5BPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946897; c=relaxed/simple;
	bh=w9b2RxEPIpBQFFaebpQtwOH3HfQgFg+EyEqHMhWr7p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZrFzv7IInwJKh+qeMp3PKzTJxExi6pXqn4t+NPaMSHmGXIH7EPx3Dy0IhDANHQBs3uTMno+RuwWcKiswBU5LukhXTOQKW8zDt/4ENzuk4oaoVa1mOKqvqkKUpQy9r+BX7XlCzoNsUyYpePgzUqyIEImJzAxB7ijPL8y3fBdX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQVxioWc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcAd8N0D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
	b=jQVxioWcqTqSRT9YcOr+iMl0pjlcqzaEtV4Gtrs5FzVEnclIVWc0XjK8hfXP6tqpBQBV30
	A5L9V0+4wxH1E2kEycn660zdD0UuT5n8M1Zp0RVcfMsxr0jdZlUceNkOR9kzbA/4ctke8g
	dGfO41ZS35vIJvemyWD9gCEArD9dmS4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-r0skQrUvN4SKbwn3_gxqsA-1; Wed, 12 Nov 2025 06:28:13 -0500
X-MC-Unique: r0skQrUvN4SKbwn3_gxqsA-1
X-Mimecast-MFC-AGG-ID: r0skQrUvN4SKbwn3_gxqsA_1762946893
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8803f43073bso26320556d6.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946893; x=1763551693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
        b=UcAd8N0DErhar9fdaQ1F4OZvc0G/9LAs90XoqqiIbWoJH0uZtg13duTIZvta02E2Ek
         DNkdX8YCAy/7sUjbliF4Q+YEv09aTx47g3wFEI2kbofCZZEvREnlrqXbwUybF70bcq/I
         FwhfCScCXEK6gpUfdlQgrATTnkq/yoCpaOiJ4KkIqX86YAGfc4Ktb6hf0JeU5JyPY568
         nKYiZUMrcHZY1k/b4NcrgTSEyE/NdXrDnOy5+yhTcTCXp0sXvxTWGdGRJyEtuL1i59cS
         OzMGdDgR+DJ08RZsDDl4f1/5exMr5xYUtjo6Knj1Gki/qcYtt3DnYoX7gIfRYZTIU34d
         iCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946893; x=1763551693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
        b=B5TCndoOBM7cqSlOk1eqL7IDbVPlA8QVNSGkrBsdJztwsQ4/JfcrUja4pzMEZdT2a5
         NVhukJK/1be4sMYPiOJ1Y0Dtyl1ynktOuknsUxDkUeks9DJQkcRs9WwEqdwwEc63Mexc
         XlDy+RTDggvnj+bqhTB1LKr5xUwsfr39x2BOxGN+0VrBl/s51P2WevEEsYXbYMrc6fNM
         RR6LwpDKNbD/5SI/JFqKuDg/BKCMZMk13NtB8gySucPRxZowrJIeWQcRiDe+8E6NrdJx
         S3dR1VJTF+i+t8PIksyNMayq0FpW2yYDNo6alV//AF8no0/20fJs1QMMRzzsjbNmsS5C
         ChWA==
X-Forwarded-Encrypted: i=1; AJvYcCW62mWCTOPlrHAWreEqp02lRoS8t5tiprzQRmCMkjMIIJ9dJOr6nMxnZs9uDTM81IPxX6I1SBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZpnKYezqRmSMLvtEiurn8fglNIgO4xFoptVhqBELJ4awG5mC
	/INMwwhcQUeGjJBewgIckMeTMAsNQSUVUfG7EgsENCntn2hHbgUtIhzRfoI8/yklMv4PI3oUBS6
	LPz2pPY09vZ8BX/IsGpXNvVGmqMH40FogsM1NNcpQiCoGexbltmvPUFJGwA==
X-Gm-Gg: ASbGncu6mdPBZxpZ+vhQyEDZYwcOXFtjOyylvRb+N1jdaE8zZNvl6DiPGfhCDUCSMRy
	259Fpg7kDVCeVuqobMYHMX2RwywJO1DUksraeFPubBE0lB691DLpuacBPC9f0nsFfSbmmAp2ULd
	yN6MlSkgs18jKTunM4hm885JBZcqJvQ6VmQu/9syRgyry2ROvY+d2K0B20l/bEejR++Bx3ms8LP
	13IcFP019Qw/gFmLcwqnpiVdTyW6NMZ/CkCHbNxUVq2CIvekSC1tUoyzz1sle07PfrjxFre9oWp
	JQ0hBlMV124oynIVnfXsW4XE02I3NsR6h8bRYkKB5IwCr85bbqqK4nuo/MTJLo6GAIkPgbEz1SH
	Emg0ELQdoGCyyfvWPVEsKrhrQeKusV3DCNhAWR2nTKW/GbPR0E8c=
X-Received: by 2002:a05:6214:2248:b0:880:298b:3a6d with SMTP id 6a1803df08f44-88271a2a00emr36352956d6.35.1762946893350;
        Wed, 12 Nov 2025 03:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnA7ozYlvXHQMnpycDhkhnMaFa5erx7IOPg689k7NBMlvaatOo3MEwHXk4xMfYTAwAfX3oqA==
X-Received: by 2002:a05:6214:2248:b0:880:298b:3a6d with SMTP id 6a1803df08f44-88271a2a00emr36352786d6.35.1762946892999;
        Wed, 12 Nov 2025 03:28:12 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896a8d9sm92866156d6.17.2025.11.12.03.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:28:12 -0800 (PST)
Date: Wed, 12 Nov 2025 12:28:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Message-ID: <r5uyojkue5zgoiixgmrjoew6pe6p7jzhd4hsudoxdirwummht3@fclnufaabg6g>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:01:03AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Disable shellcheck rules SC2317 and SC2119. These rules are being
>triggered due to false positives. For SC2317, many `return
>"${KSFT_PASS}"` lines are reported as unreachable, even though they are
>executed during normal runs. For SC2119, the fact that
>log_guest/log_host accept either stdin or arguments triggers SC2119,
>despite being valid.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 42e155b45602..c7b270dd77a9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -7,6 +7,8 @@
> #		* virtme-ng
> #		* busybox-static (used by virtme-ng)
> #		* qemu	(used by virtme-ng)
>+#
>+# shellcheck disable=SC2317,SC2119
>
> readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
>
>-- 
>2.47.3
>


