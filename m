Return-Path: <netdev+bounces-138344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055239ACF80
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03D21F24E4A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7E1ADFF7;
	Wed, 23 Oct 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="OPOI0/P6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CDE3A1DA
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698867; cv=none; b=XXUNgcgnRVbkAfGegylk2np7OFi9vCZ8tKkfqh5nXckwf56qDHoFsNB/Yg1rNSuxcV9EKHqbKM7eIWyqtdpYR0GXS+bEu+Hqraas9YctXbS0PFEo4lmAMtpvrXBlh4+ip/ew5oskKk8XzK2jETm7UsZ0DUj6HozCoIOQdhCDtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698867; c=relaxed/simple;
	bh=/l9tVy/+tEZcuHuzumgQzmEI3qtqhZqedhhthEKGNlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQljcQ0JOcyljOnw1lSwci0j0mluq5quY/1GT+6fTorYqlTdWNSRnNtCgHPP265ukyeLR4Dxcr3nGuV/5yr+OSsyfmEwDIsfI2Ut/i2QN0U0ZEl38HrQSpD6YN5Uv9TtSN1ECBO6aEf53EJy1HHcMpdatMmqQKzYY/1lFIqbRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=OPOI0/P6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c6f492d2dso81132835ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729698865; x=1730303665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgOAp3hvWt5GdvaxoN8cVKNZwX6rcNgcVsds9Hspb1M=;
        b=OPOI0/P653ya9pEki2ciHVXTz2icjvf4gQkSXUsChpT0Bm8r2B0J6pdW4BBRmP1ShG
         AAEQ14Tix6OVRmYB737FCwIECK8BgWxyI7WEKukoyZzvVeMtliCq9BFWwSQIKaepALym
         jMUQ9VsiG/iTotGbVF14L9LqM0JOB/WpPuRjpqKnIfoD8u9vb1YUO0GePMEWwNEHgYUz
         szSHIzVglCsBV5lp+jhFq7QGqJFEaZ2g/V9ow2P1/GKMWesBB9OgqFx8DP/Ijfy/q9hy
         j5wCXMHpVkiCFZq+JRqbUOClzHwKjo8Xjzx+vgTLYPIqHBqUK9Mw/bjo5T/YY68TZ/LG
         3Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698865; x=1730303665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgOAp3hvWt5GdvaxoN8cVKNZwX6rcNgcVsds9Hspb1M=;
        b=oINav2SJpWZywiokXYUhba7TQVRwIjnZY6+1lGoSTykma+6Il7I1B6Gv9l6OTHePfI
         pWJN4MEYkkExKegXMLOZL/m01gusDgB+bIoNpLR0jZm34dAopdBQsCgfWTFodnoWLLJp
         pv4ahgi3D5xxrar4Any6OpHiddi4CvSfaPLNWWCZWFM6GcZpW9c1it4X/rEywvZP+qw7
         rjM/MNUN4Dk4qWSoZu34GprB8lZPEeHkwPXqMtPnI4ItHibAXqPRy1zL6EXbY+rkDtgy
         +6mwq2QkfqZrSf8+vUFnkZAJ8CVm1EFTXtC6Y60SGms/eWVxRJt7vf4L/IkI0zYHundP
         K9kQ==
X-Gm-Message-State: AOJu0YxCAY+HTgP+Ck3qTFHaVLpgfw5ghqR7+CFJW86BWDvim5ItJkxr
	L2XfsgwPb+DidkPQ6y6GZEqg6E0gbslBpfj5CXN2VZxFEG/KJ4MP6mXTHxzjXqY=
X-Google-Smtp-Source: AGHT+IGQkyH2Y1LYAUEgKMQrpcobuFw30oLgfMwc/q7VoZ0O77ne4ql/iGADiyP7OhW9cJxdDRGcPQ==
X-Received: by 2002:a17:902:c944:b0:20e:5777:1b81 with SMTP id d9443c01a7336-20fa9eb5b58mr29938495ad.50.1729698865635;
        Wed, 23 Oct 2024 08:54:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafd36esm7121435a12.6.2024.10.23.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:54:25 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:54:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
 jhs@mojatatu.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v2 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20241023085423.7e842346@hermes.local>
In-Reply-To: <20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com>
References: <20241023110434.65194-1-chia-yu.chang@nokia-bell-labs.com>
	<20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 13:04:34 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> +	if (tb[TCA_DUALPI2_ALPHA] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_ALPHA]) >= sizeof(__u32))
> +		print_float(PRINT_ANY, "alpha", "alpha %f ",
> +			((float)rta_getattr_u32(tb[TCA_DUALPI2_ALPHA])) /
> +			ALPHA_BETA_SCALE);

Since this is repeated maybe a simple helper function

			get_scaled_alpha(tb[TCA_DUALPI2_ALPHA])


