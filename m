Return-Path: <netdev+bounces-212733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB25B21AFD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB3A46483A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E164926529E;
	Tue, 12 Aug 2025 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="shUaeEyw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9326AE4
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967359; cv=none; b=OT5qSyKi4nIq0J0sKB7W+77xE8P6dpBMnkIHAvGGjOnnpyAMgrF8nfZdfFh24kjvzOB8ihUucNI9RZCUsWiknanhOTlutJP9l9AE+kjfSueL24WCfYNHduS+dbfK2hbZEop5F1kfIfqT6aob1XHvrPusOEY1Onu4l1T3Q/G7x/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967359; c=relaxed/simple;
	bh=rm8grsvms2WhvI2q7p0+/GDhogd3wvky4eCdKd0jVw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPj6bi8kcUXNO5HcX7qofRcC5As/+ydZaDRq9h2tEnnbJrljc9gSpwbo3l4EfXN+qgfSw/v9faQKpyZPj+gGuQRkimLA+zQ/geAv8IfgDaXNxlsPCBmArJdw/WBJjQcO08pUir7na6ESY+fSyHYGuIiGr/HlitLzLyMr4t2jxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=shUaeEyw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so3220969f8f.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754967356; x=1755572156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaNGPrWjmnTPowxr0CbHYZ1ZyLh5Oz8pGCpT2AN7nlE=;
        b=shUaeEywaFmaiv3V2gJJCAfG7ZM6MpimZSpLKbCBoxHiJMrOHE+I71J7NkNymNZI/l
         tkVEC8df5TVUmReMq5RUJ3mngYffsjc3ZJxKIdBJezH7bwK4kpujR2XcdAEfe4Uc7Hn9
         o/xxddF3CyknHhCEiwPnxejfOxeffFYXq0A9lMOXGfFlb/nEPLu8DMUCxUVY9eCX/WFl
         XbbfhPn+gBr87xEKo/LfbxI+CzeRpci0V5Hvysj1ugQv+74dpr4mHdpd+7hlLEge1OfN
         SMitHKd2hNtqxdrbYZM/2EsyiqFTt/M/ISbbrWt9TZh6dsTRyKa1YfEYvB2BljEuvHTu
         pe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754967356; x=1755572156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaNGPrWjmnTPowxr0CbHYZ1ZyLh5Oz8pGCpT2AN7nlE=;
        b=JXDblCml7YAn+21QVgnVU4o2PnZel2inBxn+F8J9RvJHBhAd/mgzd1XQaaS77hpXin
         UNMkFk87Tuun8TTlfcUB2wKLbHszFLo/znDYRFVWy5V0i1rZweg8/26xchajERYJRrvy
         dCVkCtSlRhElelcwE2+wy4mLIXTX8bhDsrpbs8QcmPTERccdUKLfwc3L0/ZJn1NPalxG
         FhJay8luuQpyqMOtEGvSIhD0BuL8WKpzOE8jCYqj3ibyFjJnfY/6aPPBGHYJBPSqW9az
         m2LNn+6/ZuvvYuE89Ee9SGp1VqNnX6gz/tLWUlQ0WtbDXpE5MJt5vrFJkRwJHYGg9ASB
         4kCg==
X-Gm-Message-State: AOJu0Yxa02ASWFtYllCG7WRRbztxNG51SNHJcz8CC+lXj7I+N6fiX9j+
	bX3ApYdi/iW61GfjuSjoNCZEjzvXLY8UFjeqvxfdNICPH6FPDwcTJ8nO/wm+jtpFdCc=
X-Gm-Gg: ASbGncv8dxsvHebMNHsjzFi7CWOq3zg1DAKNMCczmT9+/qsfghHUS8Ycg7Xe06uyQh+
	hCQr90zLsbKTLPaeSz89JmlnF+Lzon7GyQiusOQSjxawrUUBJWRY8YQ0csnKYWLADFXrh8eHzdg
	mfSC4j2gcR0UHM/nEhEMnJNFKGguu0lUrUOMzE3xOyBnjhZvADksHfRBfTkH3shl20S0bD/w1pA
	4KFzBgJ/NVBrT6HHPdJpL8zCeFiOXd0xIu64Dg+fO+2sO8cqVOm7XgN67S0d6ED6/PGJUQngHvK
	KSDzmLCvRbWlXRA6mvBKptgbtDdkPi4FITZrDZAnu+qCGWuXxhBYISCF9EeXtD5Ex9nj8/Bx6gb
	qbZVRISwNuAd5tfW6yd+aMDwJX8NPr0VwMkLPEFcHEkl49mxU0U70tUfc+8y3/cn+T0nOHsItAI
	g=
X-Google-Smtp-Source: AGHT+IEhjopQaMVDobBwmMICvrZGhctilICZ6dRWmn7WV43NtFnNvJYy426rnBUp+6XSBBsGwxiuSw==
X-Received: by 2002:a05:6000:2511:b0:3b7:8dd1:d7a1 with SMTP id ffacd0b85a97d-3b910fe4134mr1252284f8f.19.1754967355606;
        Mon, 11 Aug 2025 19:55:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453d6esm42412997f8f.37.2025.08.11.19.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 19:55:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 19:55:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
 pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
 haliu@redhat.com, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next v4 1/1] iproute: Extend bonding's
 "arp_ip_target" parameter to add vlan tags.
Message-ID: <20250811195548.252e17f5@hermes.local>
In-Reply-To: <20250811232857.1831486-2-wilder@us.ibm.com>
References: <20250811232857.1831486-1-wilder@us.ibm.com>
	<20250811232857.1831486-2-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 16:28:18 -0700
David Wilder <wilder@us.ibm.com> wrote:

> @@ -520,7 +625,7 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  		}
>  
>  		if (iptb[0]) {
> -			print_string(PRINT_FP, NULL, " ", NULL);
> +			print_color_string(PRINT_FP, COLOR_INET, NULL, " ", NULL);

I am confused, this is printing only a blank, why the color?

