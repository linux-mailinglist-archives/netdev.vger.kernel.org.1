Return-Path: <netdev+bounces-79919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5187C0A4
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E641C20F2D
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4271B58;
	Thu, 14 Mar 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sLflCxsp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7218E20
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431507; cv=none; b=jzfCUi8Vh+a83I5vATNB86x1kU0NlId7Ydsh8g2jWUc9OWaaFdLzxbW+uO/ZKNNt9q5HudJ85yrPgnv2tmErIT4FGECX9sjKJ8Cw4a26lcClziwOAPK4kZbe3qRh0bPyFypHSIcfgj2qcxDh5oPXKJkG8IQIrRuSh5zeNkYdKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431507; c=relaxed/simple;
	bh=UlQma6YHvY6Kpm5Co34llIhVoM59noyMEIRJZSrJ7F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYDXp94dxYvnhZ5HamvRPBjZoz2KjMRLBqILJGOfobWeRjuiHP0GjmIaHGuu6xZWWsZLtpTIQiMTQiMU3tQ/usTA3v141u5CiGxhzE3A+rJoKgD0EZgbcTyH1lpC9TGgcv+HiBgMEMCsIvp1uvX0+C6dEUSR0e1jr1MSAHfhuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=sLflCxsp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6ce174d45so713210b3a.3
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710431505; x=1711036305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbza2NjqMLPLBSItzG6iqI05PIFt3Qkd6TLrhXLE8CY=;
        b=sLflCxsp5DXhVpY54I+XhZ64sCwJHEdB9Oxl5HciDDbzlV+6OxC/o4YIO4cK6oReVu
         VMt1Fk8Q9AD3v2uKOu6yes9DhjxZHa2Zv5H+MtbZ3KsY8kBqZgKLgDCYssrJ5CJliCpr
         ba8KoQXQXF4CyOhL2afz1Y/wvSGEmp+wFaUQX5416BIvk3/GxuR6WAjrj3wJ8K9ImTgr
         sin//I0P7kLdkqd4Et49gCZLQDmOvTbPDHeB+tuQd9G1/D+4EDxAJFn6/LaBZe7Iqvkd
         h5S8ANHiopgWgKXpTrVqgRk9pbWpe2wavtfqNFjCIs0ooe1I9PlUtrFvzagWVJ6lnArz
         g78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431505; x=1711036305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbza2NjqMLPLBSItzG6iqI05PIFt3Qkd6TLrhXLE8CY=;
        b=ZgIWUP5XN+CWrW3XeXM4Y6bNZaE2R6iAqJ8h51KeGuHeXRlVpjl6ElMUE3hrUy5hGq
         BxAFHv4vW/rRKelMXz47R5OpN1ojtmnFNv4SwTYSBW/95Qh7D1Hrjh5Eu61lP2c+NnrA
         CPTDNIgpfKZRNArOms38iYidAVeXVqcsqAG+YlaikL+fKq9CQkhnevY6RtUjVi8rE8y1
         qlQijRx39/euzbKL1BscQwwbEsrFdo8w6TaIOlqpWVhB+gndfzpOl3QnaOGoX93040KZ
         ARdgERwHjDuwFcGq61jkv6h7O9fHaOJioH9EwxsRHGjvymSv+AmyYy0DEL8iS+d30hCI
         F3/g==
X-Forwarded-Encrypted: i=1; AJvYcCVaVz0yQZq7UCWkwvC7gE+nAVyrza7R7dheIGkcpxLfs6De0DuqbQTwlXnnKx5JMruR0O7OZ95sSY6S+OwAGZ5PEklOaWx+
X-Gm-Message-State: AOJu0Yz11sJzKFpZv5KQzIQqseIEqsIx3wDOzHC/4t9y9JSCdi3a+aq6
	HncgLs8YnxDZWvyoMNFlh2v9we0r5s6xcRBTwOVV+N32gda/8vYYO26oq1WxlUA=
X-Google-Smtp-Source: AGHT+IHbzV8zz7vPFBCgfmHGs24JR6llAQPukd2t2DvExQrq0jtddEkbo8iyE8STFaUMU5nJuTdKlg==
X-Received: by 2002:a05:6a00:8b88:b0:6e6:cf40:2d63 with SMTP id ig8-20020a056a008b8800b006e6cf402d63mr1459627pfb.11.1710431505514;
        Thu, 14 Mar 2024 08:51:45 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id lb15-20020a056a004f0f00b006e6b9dd81bdsm1685241pfb.99.2024.03.14.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:51:45 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:51:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, <netdev@vger.kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "Jakub Kicinski" <kuba@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH iproute2-next v2 2/4] ip: ipnexthop: Support dumping
 next hop group stats
Message-ID: <20240314085143.251f10be@hermes.local>
In-Reply-To: <66b2df7b7226a5a25bfcf32c9ef7f41394729ef4.1710427655.git.petrm@nvidia.com>
References: <cover.1710427655.git.petrm@nvidia.com>
	<66b2df7b7226a5a25bfcf32c9ef7f41394729ef4.1710427655.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 15:52:13 +0100
Petr Machata <petrm@nvidia.com> wrote:

> Next hop group stats allow verification of balancedness of a next hop
> group. The feature was merged in kernel commit 7cf497e5a122 ("Merge branch
> 'nexthop-group-stats'"). Add to ip the corresponding support. The
> statistics are requested if "ip nexthop" is started with -s.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Checkpatch complains:

WARNING: braces {} are not necessary for single statement blocks
#273: FILE: ip/ipnexthop.c:568:
+	if (show_stats) {
+		op_flags |= NHA_OP_FLAG_DUMP_STATS;
+	}

total: 0 erro

