Return-Path: <netdev+bounces-138348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF54F9ACFA0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6698EB25DB0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C881C7610;
	Wed, 23 Oct 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Rt2TrPIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2C1B4F2E
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699275; cv=none; b=WqKIRltlodWNy7/5dqr/EkASFr+EUcHgovZtaPlz175NmX5US25HPCY3Y7ub8ABAmHAm05OR63eh4V5Tk5pvPCQRxvN0+L6H2RA2R88xOUOm6mKXLUgy6emmBfaNpe7zlSIYaxCG0OTJBdGyCw1bS12gekOtxgL6/Zz8BY4k43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699275; c=relaxed/simple;
	bh=Qm9hdNHnULnQdbuCa2qpGbixxlwdtcNdVOA7bWBhpyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4U4wIjexh0ULSgZdcDuqWZGiHhJEKLGTEaNAnrEV0y0zgPtH4CSj/OoS/ZI/qzeNBDhLDlEZE8V5zCwwYVf3XJmDw09ZyqpmYIsc65vbO2C1jPatceKxxW9ZHg69RNobi3rjCDKk5bFnCOo9SdeEgce4vif7+1I6azD9VxQCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Rt2TrPIp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf3e36a76so68997435ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729699274; x=1730304074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYa1ykawRI9uTUprAimgFXdYwW/poPfSD2KgK59NrpU=;
        b=Rt2TrPIp/DoBDN0UgS84P8S/cyNp30mCJB5naXu3A5lD2DgnMqZBFJCl3boXU4XFHZ
         jLktGP9JquDTqhw2fZZD88z8lTAEhNfLmkma0nXxbAP06goyCFP4uJFyTQHxcmuq3CWa
         PT1ISRBI9Bza0l+maLYvwjrtcqb9lvi0YqO0n9xRNuCWFzPWs+D4w+7O+my98KkcZw1B
         +xJ+qiKsvWLWYzrYMZmaRoevIFaO30woJGFVFvLQmhVk0PhvbgEwGwsj196N1kWrONRr
         MG8tJXi1SKjrNt41X/NN9FeDs7B7adn4XWhWh4iihEDP7IwQdNvKoe6RPgU4GNTfMFZD
         3DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699274; x=1730304074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYa1ykawRI9uTUprAimgFXdYwW/poPfSD2KgK59NrpU=;
        b=V4Rmjyqpy4Y9frvyyk1GT8KP/aiFT+V1SI+INazPVaZe9roRnNcIOuN3tDC6nW6rKW
         V+L10F94az3hXwdzfeCiXDWzwevy6jWK294XGG3q1uV7LeHzCF+LbpxumsshJoZgcmEE
         tRnTpUECIgcHFrHkU8POvBtUXdFFaf6YVDRgLdscLc2cEvUrf7WsE5lt1zmFeNAaO/bC
         IpCr8G1geQtgLKYTIhqisPpf6GIVYfqtKjOwlZIzR/hNl4T5ullK2oWExK3LZM6vHqkg
         rrCQ+JpWGPClZoUruvEPMt7Q24loQXEKY3WxnCD0Dxm/5LSDUvalg5yXuwxNXq/AOPm5
         SApw==
X-Gm-Message-State: AOJu0Yyk2qrHncb2BJUowyZqbVTz5x0vGFLHRrJ8TiaNrBsNr3hkfPWh
	j2EexgARzew1+09GoXjyK9wVt8nEyyuJURo1iDuNO/SCTKmRlAJn7B3/83ahdvw=
X-Google-Smtp-Source: AGHT+IFivVYA6ryQo/HxCMMgmRtF+JHnedEcCrXhc8btram2Og0/2ScvPXHX0DQBO529fOMNP9gE7A==
X-Received: by 2002:a17:902:f545:b0:20c:bff7:2e5f with SMTP id d9443c01a7336-20fa9e06ae0mr40298635ad.13.1729699273345;
        Wed, 23 Oct 2024 09:01:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd27dsm59016855ad.168.2024.10.23.09.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:01:13 -0700 (PDT)
Date: Wed, 23 Oct 2024 09:01:10 -0700
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
Message-ID: <20241023090110.559de7d3@hermes.local>
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

> +	if (tb[TCA_DUALPI2_SPLIT_GSO] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_SPLIT_GSO]) >= sizeof(__u8)) {
> +		if (rta_getattr_u8(tb[TCA_DUALPI2_SPLIT_GSO]))
> +			print_bool(PRINT_ANY, "split_gso",
> +				   "split_gso ", true);
> +		else
> +			print_bool(PRINT_FP, NULL,
> +				   "no_split_gso ", true);
> +	}

Since split gso is a true/false value, then maybe something like:
	if (tb[TCA_DUALPI2_SPLIT_GSO]) {
		u8 split_gso = rta_getattr_u8(tb[TCA_DUALPI2_SPLIT_GSO]);

		print_string(PRINT_FP, NULL, "%ssplit_gso", split_gso ? "" : "no_");
		print_bool(PRINT_JSON, "split_gso", NULL, !!split_gso);
	}


