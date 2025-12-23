Return-Path: <netdev+bounces-245888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E0CCDA007
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06A1F3026B17
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA32E1C57;
	Tue, 23 Dec 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cngqIstP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwHHbJOy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC802D5C68
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766508660; cv=none; b=qbwM+NmweW2j+C+9uLdk/Qu1G35ueaiye276x6t/buwE+dqrzovhZNuR2Sdj6qd/3Oyp62hNRQWC4yXABdGffCcoHnrrcs913Yj7ygDQd++N4xoAe9fl/YA0ePR59CZx/VU04FthmY5QAVNgkgRhQ5TKjybXJIn+lzvs5Gr8EOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766508660; c=relaxed/simple;
	bh=oeeTQc9kh8tiDzBTogIJh4tx2yTZCyvYeGymBiksIG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8Izy5o4Hyf9Wc8gXcaHHNbqolMY9wsehcc22oP7asTa4OI8dcaIahm70i8gPaPScUciLls5Jq2egUMJuLUtfYjGb7aKW2neu3S+0DtR8PNFqFL2svv6qsPWPkZmqjtMYPIlh4Sxs5AvXRUCq+3uYJBbaPWdS4vINjFNFc2nuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cngqIstP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwHHbJOy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766508657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqJClaecT7bQO5wRvV9Omgfdvbdj1KDOA3tj0f3pjp8=;
	b=cngqIstPfkoI6SZYCjs7ORaZWlPoD0sBwKjkkL4HyftH347tNmiJek3kKdz9pDt/r0VQiU
	qYRJ6tSmpYDjo0ed3YBdXj/O5MW8QmEApz+f5TYZXm1CT8HSu7Dn0Blyj0LPv8jgbd2OI+
	L0Rdw0uMv4vYRVJe4+4f3PhQAkc1S/k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-W8FpCdoKNhS62TyUAPGAFw-1; Tue, 23 Dec 2025 11:50:55 -0500
X-MC-Unique: W8FpCdoKNhS62TyUAPGAFw-1
X-Mimecast-MFC-AGG-ID: W8FpCdoKNhS62TyUAPGAFw_1766508654
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64d1b2784beso4039060a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766508654; x=1767113454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqJClaecT7bQO5wRvV9Omgfdvbdj1KDOA3tj0f3pjp8=;
        b=iwHHbJOy6nNfjlc97CiSkM8c6/Z3hYTO1WmmwDzIvl54G4LP47OSw6qG2M4u/T3+56
         8tuJ4qL0+k8G7VdeudxnY3NZcaUvOXUXuxwIjwsKvBkTHYzxv+OKbckcHI2V9nuFRY56
         hDCOBooxmgEsWAN3JFwjyvKtOP1x9ujjrCB2A0xbfddCLiae+rSD9It3GLLogxWQ9A3D
         tkSZrpJuzfV71qDbko4O3Lg7jPfg01Q8csjh7/clt3O8Vt3AYBpE3Y9FapEM3A0vaO0q
         9RQxxVqjXlccnXGlvuoM7ok1SP/gUGVFpu8Kn+mYq5u0UwtSTiNd+8oHuGNQdTgmiLzk
         FlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766508654; x=1767113454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqJClaecT7bQO5wRvV9Omgfdvbdj1KDOA3tj0f3pjp8=;
        b=k6QhDNZONwmkC4DfEoz36JaPly5JwclmSHhJ0d0F2iMqM+sFL3Aqtenqg+X4zmwII3
         CRtWInXiKhSq5Re6L1V9UZNC/qhIaK1a6+NkfG+5+sUWluJ3QKpFAxa8/+mqIGxSf1ky
         H1gC7c1w+pAyK3LVUOC9gfPc97ihu3g7n+uou7St1OCmnErrBbOUqeKPMExRZcnKsPQW
         G+IssjdB9JNzmmRkgulga2bsEtc+BZLCcqZiGURpPfAa+gAFObCsomO5H2d0TZXfCml2
         pPlxUcUQ9FRhYkLX5VDSUqZ8SWyO2cYuOEpCJmPx1/C8pV6Ec0fAQAXm2d/Xq9n0eyom
         duig==
X-Forwarded-Encrypted: i=1; AJvYcCWVRrGzqV2q5+ciHsR7stjJN+q7YVAT8aEMzX+J/Jh5OcEGsnjspUlGHatNO7SMCntnIIIbnb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZQtSYS0I0Grru2xpPqqxMvR1uGRzEP1Jj4B3hLHNe2tTlfJI
	xd7vHKplE/+fcarAPvEwe+dRYjGgRgexFwcZjmUGhOuh2bBW33iFz/8S6bjbNrXt+OKJ+HC3FXi
	RdT4RsrLFXqkrDfrJHBSW/CgQA4n+3xyS2koGwfAxmtUo8xxj/6lQg7x2LV4mec0CMs1R+OU=
X-Gm-Gg: AY/fxX4WzUtRFBSh0qMEfV9DvRIivn13C7M0gLRSLuBkV+w9sqA+BFugGZq8C8xPY/w
	tJ7JzjxiclZ+zuKrHWzYWuQDV5Y58qc3Lv77GrcUXYXB++UpJdrVhFpPtuuD97ShWqM8fb2T6pt
	gmXOqU64GU7nak7IbvIkfH4CF3Th2jCSdYN/TeVn7STRygXDJg3nphjGDS3frAaEBaX1ObxV6U1
	bE7D2LH/8R/WfGS2dkxtLhZYq5uSK1DEJtjl/0G/gses1nwqA/3IGWG05hUuZ2UwdTow9tmjiy9
	dqtUx1P27pnDf+/Z3aY34y8Xkvum2Ld1uvpwyXBmDPBQE/B7qdxAcpY0djSYeq2+qlUZgnrxO2u
	NVajZKmyF4+bJKH5G
X-Received: by 2002:a17:907:72cd:b0:b76:791d:1c5c with SMTP id a640c23a62f3a-b8036eba988mr1360525366b.9.1766508653958;
        Tue, 23 Dec 2025 08:50:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFngH3YLsbRayu5ybgJw8PMv72mVXGzRctJqQbYOaNglPLvvDbrvjX+L7BBepansUQFsg6KPg==
X-Received: by 2002:a17:907:72cd:b0:b76:791d:1c5c with SMTP id a640c23a62f3a-b8036eba988mr1360523666b.9.1766508653521;
        Tue, 23 Dec 2025 08:50:53 -0800 (PST)
Received: from sgarzare-redhat ([193.207.129.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm1431627666b.39.2025.12.23.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:50:52 -0800 (PST)
Date: Tue, 23 Dec 2025 17:50:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Message-ID: <aUrIDT-Tg5SpXhlO@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
 <aUpualKwJbT9W1ia@sgarzare-redhat>
 <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
 <aUqWtwr0n2RO7IB-@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aUqWtwr0n2RO7IB-@sgarzare-redhat>

On Tue, Dec 23, 2025 at 02:20:33PM +0100, Stefano Garzarella wrote:
>On Tue, Dec 23, 2025 at 12:10:25PM +0100, Michal Luczaj wrote:
>>On 12/23/25 11:27, Stefano Garzarella wrote:
>>>On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>>>>Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>>>>handled by vsock's implementation.
>>>>
>>>>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>---
>>>>tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>>>>1 file changed, 33 insertions(+)
>>>>
>>>>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>index 9e1250790f33..8ec8f0844e22 100644
>>>>--- a/tools/testing/vsock/vsock_test.c
>>>>+++ b/tools/testing/vsock/vsock_test.c
>>>>@@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>>>>	close(fd);
>>>>}
>>>>
>>>>+static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>>>>+{
>>>>+	int fd;
>>>>+
>>>>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>>+	if (fd < 0) {
>>>>+		perror("connect");
>>>>+		exit(EXIT_FAILURE);
>>>>+	}
>>>>+
>>>>+	vsock_wait_remote_close(fd);

On a second look, why we need to wait the remote close?
can we just have a control message?

I'm not sure even on that, I mean why this peer can't close the
connection while the other is checking if it's able to set zerocopy?


>>>>+	close(fd);
>>>>+}
>>>>+
>>>>+static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>>>>+{
>>>>+	int fd;
>>>>+
>>>>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>>>>+	if (fd < 0) {
>>>>+		perror("accept");
>>>>+		exit(EXIT_FAILURE);
>>>>+	}
>>>>+
>>>>+	enable_so_zerocopy_check(fd);
>>>
>>>This test is passing on my env also without the patch applied.
>>>
>>>Is that expected?
>>
>>Oh, no, definitely not. It fails for me:
>>36 - SOCK_STREAM accept()ed socket custom setsockopt()...36 - SOCK_STREAM
>>accept()ed socket custom setsockopt()...setsockopt err: Operation not
>>supported (95)
>>setsockopt SO_ZEROCOPY val 1
>
>aaa, right, the server is failing, sorry ;-)
>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>>I have no idea what's going on :)
>>
>
>In my suite, I'm checking the client, and if the last test fails only 
>on the server, I'm missing it. I'd fix my suite, and maybe also 
>vsock_test adding another sync point.

Added a full barrier here: 
https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com

Thanks,
Stefano


