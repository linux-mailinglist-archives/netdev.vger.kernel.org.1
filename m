Return-Path: <netdev+bounces-188995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BBAAFCB9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F036D1894EFA
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27F26E16B;
	Thu,  8 May 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI4iS9Mq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F826D4F8
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714023; cv=none; b=hky0CHeojmpw+qGLR9DwP9wVgwtj8kPiCRPIB6sKHdAYfe1ORRcVsFURyHN6juZ+gF2rljDdMXCOB7zTllPOhH6/P+0aDvByBA+LzuGnq+MwnJO0a525t4i9QZOAKq0WkhkGGYr68qvYULREO1SBIm5GMqU12PjjpjdvGee+9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714023; c=relaxed/simple;
	bh=wThSVBwzmoJLTfHkfr41NVmaasgxmNoL/bVIkHKdo/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mK2Vni8CQrx8qWe3LNM/HkgiAy383oW0JcfhlGJlR5IX+hYc+Xy1khW+BxcWCwCmBZ4lVoQ4e2qu9pT1i6uJCeGI9HVjAATkdu5N+7x5050+6uVeupakNVUr0+VJKb9DGDTKH3cR4YW+dGaKL/YK6riEV8k2oIvEVSM0zYnOMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI4iS9Mq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746714020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1KcuC1xrFnlcJ1MsHim/31AFnZb3C+RZr0o19KYuHuI=;
	b=UI4iS9MqPQDH9zu6GsISXRVWStEM6tzUx5it9RqyNLu7V8aod6++CDHJXfTFQCAnHKs4E7
	5CaX1e7urGzlVwnVM1Z11DA24Zaer2DE/1Z3EJANlvxO3SkzrriRFgZh9uYnkcOLhFcfXm
	cUeQzkEO9zXnABQM7Yqv7iA11SuOxhw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-t0KblqlMNyuzrFcrfPilRg-1; Thu, 08 May 2025 10:20:19 -0400
X-MC-Unique: t0KblqlMNyuzrFcrfPilRg-1
X-Mimecast-MFC-AGG-ID: t0KblqlMNyuzrFcrfPilRg_1746714018
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acf16746a74so109345066b.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 07:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714017; x=1747318817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KcuC1xrFnlcJ1MsHim/31AFnZb3C+RZr0o19KYuHuI=;
        b=Q6wsaompmK/BTyElo76JR3JL7Jnv/z3YtqYX2CiLB5/jDWxz8m4NxqmK1OXf3AEWXW
         T49PF8BigymRQGdSwLSHjGEuPgTeHi4nKJPBSi0vD7ZXCSXAL9b9K5W8mvamns0g+968
         nTWPyr0fXvwH7gz8fc8EOnYS6AhnjY1hb09FYJE4d3/fg0TfxWOXgr0kfoYKVdy0PrsQ
         weULt1Q5xog3CDbAO4x+EB3sTPQlF4oAcBW57KEo4HWgFYgkoJ8dIsdkir26yiZDlUyy
         nCG1t3Y7ZiQDRd67xXiw37wot50GyD/0k09MWTqEShSh0msOZVgAKgumISetfiD/KFMs
         zOew==
X-Gm-Message-State: AOJu0YyKIgiuRPi9zM89aUbewCJDJ4Z0/7aJ3BjLANWcaXs2A/TvXNLl
	AJTLpMtztYZI7GJzFIGAd06ZwOllmJR4Ow6hSPoHDZJvEG2BpYTuiYudAV/YYsp7Zjk1eb1E03K
	t21tJI2vYVZ2fwDQdRGtwP5lV1SF0ZgVPBDVZPLbQC06HHtT+cBQ8+SqrWwhE1k51cQvnHVcKy0
	D0sFjN0pnwR2BZ3oapI74XBcpq5qQVE6rgzJ66Ow==
X-Gm-Gg: ASbGncugy46Hf8pXL16fPwWkXv8P8io+nm0lUCAn6EzfbwKyP2xCOaSapux42OJt3NB
	H3xterWD/3nbLxWvfIk0yIcNWbH6jn7v5wXoVyaobVI0S1B/wrY1HgUW1HKM9aPDXFZnyBODvO+
	lgVFYay+R3GBb6PPbe0QQVo6lrT+WH9SAXsYZ6j3GoEyoJTR2EjH1NieTqkbXhCmbt3wPGPFCjb
	UGBWgsv/hbwYFTDs2j+TPfWMJC2yq940afbkNCC4rSQ2fWhtZHarXkHpFY76/XCLMCdm+UkicJK
	ef/RCMuEgpHPDTBAu7hgVau+oA==
X-Received: by 2002:a17:906:a088:b0:ad2:e08:ea00 with SMTP id a640c23a62f3a-ad20e08f24bmr92965466b.9.1746714017451;
        Thu, 08 May 2025 07:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF/hUx02Zz2WoX+JCoxsMrV4CfxurR8vP/WKpaYlG35vY287928sPfk+pmToqAmT2lRFVVTA==
X-Received: by 2002:a17:906:a088:b0:ad2:e08:ea00 with SMTP id a640c23a62f3a-ad20e08f24bmr92961466b.9.1746714016846;
        Thu, 08 May 2025 07:20:16 -0700 (PDT)
Received: from localhost.localdomain ([193.207.221.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a1e60sm1089667366b.47.2025.05.08.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:20:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next 0/2] vsock/test: improve sigpipe test reliability
Date: Thu,  8 May 2025 16:20:03 +0200
Message-ID: <20250508142005.135857-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running the tests continuously I noticed that sometimes the sigpipe
test would fail due to a race between the control message of the test
and the vsock transport messages.

While I was at it I also improved the test by checking the errno we
expect.

Stefano Garzarella (2):
  vsock/test: retry send() to avoid occasional failure in sigpipe test
  vsock/test: check also expected errno on sigpipe test

 tools/testing/vsock/vsock_test.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

-- 
2.49.0


