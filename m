Return-Path: <netdev+bounces-191821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79DABD6AF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F13AA224
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A772A276054;
	Tue, 20 May 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="So5Z+G/k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3210E4
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740290; cv=none; b=n7Wmm7ubmvZRVTQB57gU48biVvjK5KA7i+c+DPIAjq/m/gO6YUl8NPZW8/AdTlAcZEbp2Vtht666FSJEaA1Qf8bk6eyYeP49oeFOwmXaIC5+X8433kBRetpwBylI+OoIqvE6MNaRCvr+Hri88JrT46dOwOesTnOzZsSaKEKHC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740290; c=relaxed/simple;
	bh=TuAIH9bfwGkhs90AUwbat8H9o+RJq1imxYa/lL35UsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfEYYPeA0mtbdJGn1k3PJj98F0FONvJ/GzPzZjxzDyaUv7/z6JBYWvafmfGoJnqpnayC2ZimF65e2u1L4sXkYkzRLsd4cTbgth5Hucx9erefo5UmDfZqWZ39J5Q+vL5VcKdImdC0tQv44phMvMsQR3qh5jCvGwC/JMQuqGfZ3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=So5Z+G/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747740287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fe9XgeFRrKR14t48Y5t/+VDl1Nkl0xKTWni0QoyTko0=;
	b=So5Z+G/kboV42mNWEuw9o90/UDzI7cL2WjNHNVqWUu5oh+SEdO+7wF6rBZtVHFgvORy+ON
	qZF1LQVU/1dt4O+I2XCYZLOzdnyij8l0CeFR0MOXAX4ETYm5pidLXqVDiiXjiGqawCSdq/
	zAGBW/E5H7vSVpeEF0zAdAKG7gq1un0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-VR1EtAS0Oluwt6UmlygzPQ-1; Tue, 20 May 2025 07:24:46 -0400
X-MC-Unique: VR1EtAS0Oluwt6UmlygzPQ-1
X-Mimecast-MFC-AGG-ID: VR1EtAS0Oluwt6UmlygzPQ_1747740285
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3703c1fe7so984771f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 04:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747740285; x=1748345085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe9XgeFRrKR14t48Y5t/+VDl1Nkl0xKTWni0QoyTko0=;
        b=CZNtjP+f6IffTZuxzVeIxH5NlCzp18WTimylVoGv4ZIe8NBGlfcx3B5QjOFAXFqy9V
         ckJapc1APuCcenJ+fd1tYu0wh5XR/BPuQAr8HmXARjyt2bp9jToREVs+vW0TfI6hte34
         viMMloex6NSsYLSbmiN/DNK823nTAwTcGinpSTycJ5inB+bD+e9HNGWStT7M6srqdwXz
         0Z885iLQrQOjno9BbSULQ82Qfv5+3LKjrkOiyV9o0FerIgNvfKbdm3rZ55w9s6wRELZe
         TURypDAUqkHHU3arcaUS2EX4PaSs9xl9KM4ontYk3oOdIXy83OktDu0Zy9QAJ9flsmux
         K0ug==
X-Forwarded-Encrypted: i=1; AJvYcCXQGn5FtImY9H0VTg89NH7vNwuPqyDlP7d61jHXvjIZZWGw0mDjNLUQHJFOWDz2J4mUzcjgajw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgQVxTRa9BWRbomrm+hbW5rgwmdmUuS+wtZAzx1Wdecr0pTME
	RigyLnw60mDIQQS4XPuf9T+AHlHHWOIpd1MznIHU/TeAhlO/ZpRuid3OdPtW1qZvmLaPW2Zl01U
	40PbXO50C+I9j7c+x8bKyLSuPEsnlCF+WuE8MeYmFt1ubdd3FyVegdwTyAA==
X-Gm-Gg: ASbGncsNLmVaJaXS5YQ6mcgmWtaUMNJPJ4JK8sFLbshslpZs9ZFoeS24Hvh4N0qs+Eh
	P6QJR+AUZolZWuXrR+gUok2yQSc2lq21JSDEO6cIeA3x0ZlOXxIxzzrPVahMEPol+Qk0XOESzGS
	C6qED4hrAbJTTyNYTJmg1d7b0dMehnpqvZxXF1l7HPqWlFvjn2kS4IsENTQkyErUsrD33imJ6sZ
	JDTeDExZMS10Cvp8DnwmnRXQpTzuKIhypxLq0uERzP1YLtrnVBqVe74/CEAkOC1J4xeV8+qmNkD
	S4/JRKxTIVhNl2XbLLk=
X-Received: by 2002:a05:6000:2304:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a35fe65fb8mr12718954f8f.1.1747740285495;
        Tue, 20 May 2025 04:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEofFs1HXEriOPCetmLcj952oc2+OEDOvFvT2d4euNrXMvEB2EHBEoF9oG/uDbOigZv9W8Xdg==
X-Received: by 2002:a05:6000:2304:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a35fe65fb8mr12718940f8f.1.1747740285150;
        Tue, 20 May 2025 04:24:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6254bsm16428674f8f.52.2025.05.20.04.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:24:44 -0700 (PDT)
Message-ID: <0d3a3a42-4141-4c4d-b25a-3c9181d5842e@redhat.com>
Date: Tue, 20 May 2025 13:24:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 12:00 AM, Bobby Eshleman wrote:
> +tap_prefix() {
> +	sed -e "s/^/${TAP_PREFIX}/"
> +}

I think there is no need to the tap prefix to the output you intend to
'comment out', the kselftest infra should already add the tap prefix
mark to each line generated by the test,

> +
> +tap_output() {
> +	if [[ ! -z "$TAP_PREFIX" ]]; then

AFAICS TAP_PREFIX is a not empty string constant, so this function is
always a no op. If so it should be dropped.

Otherwise LGTM, thanks,

Paolo


