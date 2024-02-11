Return-Path: <netdev+bounces-70797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466185078C
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 02:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECED1F22F1F
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 01:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72C215B3;
	Sun, 11 Feb 2024 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="X0qbNY/K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79162367
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707613260; cv=none; b=BSrdrGWXrb/cEo4MVbHYCSITVZ7IXqWL97E5JLrh17889FR7gTXoXTTVdtRnRBjIATuADYuJLV9Rs3MQGjVSYVORPNFAuhdlChXIpqCnxEV+i5smvMx1HuFRecz2H2l1f1/fP0H9gFLsgegFrajcBjo5RYCEegEoFz1gITb53gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707613260; c=relaxed/simple;
	bh=n5dltBH1hr9DQN9D5xUK9szXy5huG6RWIdCNTxYcpLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6X0WOcWDKJNIN1tTtxb5wUL3hUPzhhvicEPRlIIhJm6Imx/lpaPI4mOh1t5/5hn0ir0JgVlXs3T4aZzprB5b3naFkoLgHaCZrFEkWwEbLK5QPuvde/5+2sKI95RvNWO0d++F/QfZe0OMAA+oXfaaI/66/o3LhAdUpTWzWIS6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=X0qbNY/K; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c031776e0cso319539b6e.0
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 17:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707613257; x=1708218057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY2UXv5SP8rnWnhVpcj9JpdINZZFc6RlCnO0HhdWmyA=;
        b=X0qbNY/K/QjsfRya8QjM49VlqkuoEhEq18H1n7dHAKGeWcZ1vR77ezeHiyqwhN62MX
         MtXVEXdVT1/82cbNuZldkqp2iZ8isPAfIIgdtsXSTEPRFOTBR15NBBKwnFgE0gArO+OW
         85pfQ1ezAnb1MACKx15OcvnZEfyWrI7CJn+Odb7g69DF3/jVfVoztj+0izlPx6t69cUU
         qrsiunmBl6IRrPifNeVHSjJq/6zUWq6+4nuXaLykqBOcBtMXDmCEOC7ih8elbTl/Zb+4
         jzabDc8+wjukCrDba0bygn1GMEjQ3TVDj2n2O/MtPmuvxfvDGVz1lbH+5ZFoMLq+iajm
         +80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707613257; x=1708218057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY2UXv5SP8rnWnhVpcj9JpdINZZFc6RlCnO0HhdWmyA=;
        b=LhdYGsYuY2hfu3gPlfWkZgjr/DDK13JWJpbBr/lPKBNMScyBX2NgAo5U8o6Myu9z8p
         2ic98GuBmftcJ3AvzuOj1zTsqJsOAKRmowNloZDIGBdh8W1QbS4uaekAmvsA2ESzBkHE
         +NyNosmoArRzanDUNfuLBtN3z9q2AIfCAKP4UdD6krON7I3lTAC2wH0TT4d9QsCUzRVq
         XXAwjc/46tBvp4WOuo0CCmsJfYwLRHXj/4xNN9MBy7F4y5H/TpOjDksNNEbZs9lgrmuw
         rWzukViunVlZmdryMJweHh26C6q0HrLsrMxCWi7ZKaLgeSwA8xwbn9S5ZXhIF48zq+xT
         iMig==
X-Gm-Message-State: AOJu0YykfipUGpfx/eLWn8++zN37Ti3cCClkIAPRqTU4HmwcQNIizmhG
	+vhnyk0faoh95Y80OBQYDP800aTWDvawdwWLSVDy7W7Nb6J+3ZZwPXj8EeXsLJK8ksQECM7gODb
	N
X-Google-Smtp-Source: AGHT+IFzv+6s/tGJX4h0xsrX+U/5YTGqLSWeWtlRMJ/NeRbLZeAYAK0K6naIPzfoNhCf4PDOBDJLTQ==
X-Received: by 2002:a05:6358:7596:b0:178:c57d:8f4 with SMTP id x22-20020a056358759600b00178c57d08f4mr5784833rwf.4.1707613257306;
        Sat, 10 Feb 2024 17:00:57 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id w12-20020a056a0014cc00b006e04c3b3b5esm2836215pfu.163.2024.02.10.17.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 17:00:57 -0800 (PST)
Date: Sat, 10 Feb 2024 17:00:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Takanori Hirano <me@hrntknr.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] tc: Add support json option in filter.
Message-ID: <20240210170055.30fcea14@hermes.local>
In-Reply-To: <0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
References: <20240209083743.2bd1a90d@hermes.local>
	<0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Feb 2024 10:08:03 +0000
Takanori Hirano <me@hrntknr.net> wrote:

>  	}
> +	if (tb[TCA_FLOW_MODE]) {
> +		close_json_object();
> +	}
>  	return 0;
>  }

This last bit is problematic, the JSON encoding should not change
based on whether flow mode is present or not.

Also, brackets not needed around single statement

