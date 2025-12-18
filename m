Return-Path: <netdev+bounces-245303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD6CCB24B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC0D31064EB
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A12F532F;
	Thu, 18 Dec 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MD8f1rwn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jf7F5Ili"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DE33033D
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049292; cv=none; b=bMEuFDfxOugsf5oQ2padIoo+Z0GA/0zKYrhdeugqpAF5jKEAWpUM2hcJ45xA0ggrklh64XJV6IXSheoOAUlX/dZuNotS1Nkm7D8bnsy344dgt429OTLcfqjlCfBY9GIMYFp3/G56kgE0siCo5scQws9PXRXUhUT9YTKXzDU5U3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049292; c=relaxed/simple;
	bh=OBug7yiFsFF6n1aW8KPArHWd9Qc43lse5OYmR0uVPM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgshzLvgK1aETRNAO/hN8Ui7/TCGW43XFLbReq7Lnxx4wrv664KPh4OciLRotsVHeXUXpTuumHIZLPWWEutu4oZ0/bwjNT3Sd4pjAnHsaLW44R8mOinNqv2FZ2d8uQXWPTXVHTDgtjNTUF7ZK5V2+nD3Qwn3Xx0xfkI556gzOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MD8f1rwn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jf7F5Ili; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766049286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dXqEGFcpHGxpgB5BTy87mhAk/a/akgsWpH/Fvq9SeUA=;
	b=MD8f1rwnDkJIuP4whzt+G3CZ15UcXo4ayzwnkPap86FmmgSEwP9IfSBSz+Dq2rNad1H08z
	lHpKAqPXVkLwQjXi0CGK/8OgfFw3oyZ62NouPIjc7niUduwbpioKH2RSkFJAtMtc2OIZoK
	ZPACNTOfstmTPmve5DLyih3AZFDZokc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-DH1DKbE3NeW5y0_RCzYVcA-1; Thu, 18 Dec 2025 04:14:44 -0500
X-MC-Unique: DH1DKbE3NeW5y0_RCzYVcA-1
X-Mimecast-MFC-AGG-ID: DH1DKbE3NeW5y0_RCzYVcA_1766049284
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b79f6dcde96so58318766b.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 01:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766049284; x=1766654084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXqEGFcpHGxpgB5BTy87mhAk/a/akgsWpH/Fvq9SeUA=;
        b=jf7F5Ilih4J5U+U+MhvGup9YYyzr9lXI4VwXKHh+zFoarptsPOvs4WqoQIkI28Dq1r
         Q6oUrBVHeAK08HY61kKA0sBBaAjVXe3mpjfOkp6GQuj9EFs7Iw8yVOb2WtXqfNP5H6C2
         mP32uqN3JwD8yo9/ndol3QNNksSMx41fL10bTIx9GdFeSOHDNcTVhCsCWHh+nJFQC3Ma
         ziGLCyq/L3IwCRcGaT1iUfcFCxWXi/Q0IsosKXk5x4AN+7EIpGvABU85FoFUuNTtSdCQ
         7HVAwjmcomxISZiyFfsjEPqQg5T619XFSSuLlriBGvL5Xu4VlrVPAJLdPguXL/m4TfCI
         3yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766049284; x=1766654084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXqEGFcpHGxpgB5BTy87mhAk/a/akgsWpH/Fvq9SeUA=;
        b=NKK1l4us7I0c9WZE6Ja5ON169yKgE9YkeW8cJ4WrK6eWTjHyi6+2VLIGAEHexXUZcs
         V8yyVUckXosiR6VfcS/HbFVbiLobP8hJN0zfV6uwo2M351/iNSO4TG78nrB3AoGOji+f
         UCqeT1iKrk6JaDucg+2JQKXahxBEVV2ArC91Wf8rXqz2/+I8Y1I8ioUcJdbMw92Q6g9o
         jI873wxnKTwNH34CQoWfdzko3f3SIxxLEC/BlWLq5N7WgsJFEYxiQsCQFomj6K9/28/G
         C2evZZ46nCnZXqWc1oevsDqvk6ljcYihzyddnc9JWoeiR8mk3fPy32hFWMndp1y05lgi
         rU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUD1t5OQWMQY2nwHn/BLz+ERp7NGxrFjY0MkBOWAUCbmp3x6nB4jNZb2TGHxAdvRLoNpB74sHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4+TCyxSaNPBIWPdUY1T+Z2GEE8kq4urjUlqXKTx/c0oix18B
	n2T7qelvnpK8BPLBaUJzmer6A2zH6EqChjB6OV6qzDI5Z9NxrbZ0c0YD4hVkGbEWXFubGWmnHXn
	5bs1qQELEVVneSTgcBi72f2ifVTKJBFwbLZeDPcUrDZITFPPcpJYmbih/Lw==
X-Gm-Gg: AY/fxX5uxxcXY6KimWeoQoS9UM38bumPCC5952xyT3CW8dYZ5CCNtJLW12B+ZTZMd+v
	9fkDRI0PScOJ8483NhkJA+vg5/d6OLs6hzwxypa2JQ/mqe1CZnYxsAW9UbVFlTMhkBgbbdlJv0+
	29dZQfma63WBecr85PRnEwFhnZIH7bGC+pMikFynvCjzsT4E7PgHDdRKmsAUv2oHlrdKYXJGZap
	S7juu+MQGvoc7Lhfi8GepZtgUelcPiq8hUmLMPQTzg0eJ+ekjN+scNNiltfeEnzTgXp41hsfEN6
	1YV0pAiv5VqD7Kz+TfOlU9pJ4KPpScsI/vw/00Mcrz1dwlz8QIPz6MoqL0cSCkzKBdhj7jeUGTD
	F9SbtnoHWwoxs9mk=
X-Received: by 2002:a17:907:3f1a:b0:b73:7d96:5c97 with SMTP id a640c23a62f3a-b7d23c19b99mr2120357266b.34.1766049283490;
        Thu, 18 Dec 2025 01:14:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCcnT3/k3O13h2XJKclpGQV7xCUe86HYVyLKx9bzOqHgpuxUTtkhw6t1OXOATKEcDYxaHB4A==
X-Received: by 2002:a17:907:3f1a:b0:b73:7d96:5c97 with SMTP id a640c23a62f3a-b7d23c19b99mr2120353666b.34.1766049282887;
        Thu, 18 Dec 2025 01:14:42 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b802351fa2esm170144466b.71.2025.12.18.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:14:42 -0800 (PST)
Date: Thu, 18 Dec 2025 10:14:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 3/4] vsock/test: fix seqpacket message bounds test
Message-ID: <dt6tg3ehtz55kej2d27youm2naqjnaieczop7pzodry4lp75yi@nv5ujnxxj5oj>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-4-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251217181206.3681159-4-mlbnkm1@gmail.com>

On Wed, Dec 17, 2025 at 07:12:05PM +0100, Melbin K Mathew wrote:

I honestly don't understand why you changed the author of this patch.
Why not just including the one I sent to you here:
https://lore.kernel.org/netdev/CAGxU2F6TMP7tOo=DONL9CJUW921NXyx9T65y_Ai5pbzh1LAQaA@mail.gmail.com/

If there is any issue, I can send it separately.

Stefano

>The test requires the sender (client) to send all messages before waking
>up the receiver (server).
>
>Since virtio-vsock had a bug and did not respect the size of the TX
>buffer, this test worked, but now that we have fixed the bug, it hangs
>because the sender fills the TX buffer before waking up the receiver.
>
>Set the buffer size in the sender (client) as well, as we already do for
>the receiver (server).
>
>Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> tools/testing/vsock/vsock_test.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9e1250790f33..0e8e173dfbdc 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -351,6 +351,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> {
>+	unsigned long long sock_buf_size;
> 	unsigned long curr_hash;
> 	size_t max_msg_size;
> 	int page_size;
>@@ -363,6 +364,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>+	sock_buf_size = SOCK_BUF_SIZE;
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+				sock_buf_size,
>+				"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+				sock_buf_size,
>+				"setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+
> 	/* Wait, until receiver sets buffer size. */
> 	control_expectln("SRVREADY");
>
>-- 
>2.34.1
>


