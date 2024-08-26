Return-Path: <netdev+bounces-121788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5595EA04
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9131F20F8F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC978563E;
	Mon, 26 Aug 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbQMaAxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684A376E6
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656234; cv=none; b=l4M38/Hk/enVfUpz6xwlT6xly4PqmmrrwM1IvqtYcSbMi0C/vVusLYFpBEuAhJ+tDJC7PNfBslGnxoZE2Hum676nSOf58EPmDSyr5AXWZgZfEJVXPWxDLDd2xRhuKxNx6wMbcMa/IiVIWyS/clK3UiCHwsrJILnABGKd538dkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656234; c=relaxed/simple;
	bh=tn9R2l1jwi5xKNv0uqQ9iGdQ/3/feMO4ZdqZgGfWjfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pT6BKiQl9Gz0nOTh4RlKpqaKYbF5RPU3GQIzsKn6gEeM4McjzZznpYVWwN69FRobxGt+8RBD1J9+SvBddLKJg/kf47p66jYFBiFPA8niwZoa/pxDcp8VDYbpT8AdAE0VP6zW1K0k0NQKomalCioiZhDZYKrzSSwnP/MacFFS4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbQMaAxE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so376291566b.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 00:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724656231; x=1725261031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn9R2l1jwi5xKNv0uqQ9iGdQ/3/feMO4ZdqZgGfWjfU=;
        b=mbQMaAxEf8NQ6XvdegVYBU4u0+5PggDWM6UWK2vHi503MHcF4FF8oBq4lI6h2ETKPP
         GmJ4DzN6juDWoSCbdtnMMGmJCRMFWI0MtofqnNxbFBQpZoy8gtuVmhtqdAVXoVOsH275
         CRBnm3xF5uKkruWc/2SiLmlAtJZirB34mNQH2rWi0T0JBMh4u7rakgSLsSO7KpsEaCje
         3XyeWJe+WBHJQd5if2wC4wkBHtcWnFKHvN4y+a8IN1AUrIWXSIdcez5z2byerVztwNvU
         bEwSqizdPZ71HajDPFy9o9iowpGNyTPI0n5jdXMdsbrAD6T4o9IbU0jCAB00AKjXOGe6
         7jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656231; x=1725261031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn9R2l1jwi5xKNv0uqQ9iGdQ/3/feMO4ZdqZgGfWjfU=;
        b=FTHvFZJEtw/4I9sIsoAvY2il4aG3SJ4ID8Xrp8T7kLwG9cfuMfBp3hAJ26PWrNP/9i
         uAnYCiKn6XsNnnsg0ahLqnIWChdWmZ/yVFvuNw73IZm+koj4VDAHxdoTRNe1CPOMQvmF
         yh84Fz2iGmhCNks7ahQaAQpN0zWVczLlJNJN7bldz5JnCkQiz9F92u97g6LQVLgQhbXY
         Q1d4Jt4SBackpU4PhJJiV5AScL5jN8kKgM1QHEMk7mUM6sH3XfkN6BRPmh07IRPVT+2c
         a9Y37NB/4duEEyxMPLI9piOJno8GLbKROzbA9VT67X9P7+tYm7oGybO8GDVXGreC89Qz
         GbCw==
X-Forwarded-Encrypted: i=1; AJvYcCUzaGFNOhUrxC/tXesGUGN0K8p/Ozphfcl6HgRVn/HHCHhCyJo9YaQgjs9PHQywIjQ8HftSeGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFU/G1GSNV72PbOfJNwrWpL/c3+CWc5ia7ssOW1+r1bf8x3sM
	GYwKo1qU8m8PhpnHowNH5iudwOCn6up8Tomk9LBL5RZAk7VX7oFwlHIYf3ntu+4V8bgj7bMb6Lw
	L+ydwKhm5xpvvYnPOa9PV5Id0aNEKAcNci4dh
X-Google-Smtp-Source: AGHT+IHTYGDqJy1vlZm1r6VXpa/Rw11PRvdqCreST3H5r1TqQVU7BX7MQCwnLlXrSGV4l+TxBhJkQauttRzKax7MMa8=
X-Received: by 2002:a17:906:6a28:b0:a6f:53a7:adaa with SMTP id
 a640c23a62f3a-a86a516e33emr632912966b.11.1724656230833; Mon, 26 Aug 2024
 00:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826092625.2637632-1-liumingrui@huawei.com>
In-Reply-To: <20240826092625.2637632-1-liumingrui@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 09:10:16 +0200
Message-ID: <CANn89iKtf2oNPJTP-Ts=MA1e5KNHbN77NWCOKGp37SMeosXxCw@mail.gmail.com>
Subject: Re: [PATCH -next] af_packet: display drop field in packet_seq_show
To: Liu Mingrui <liumingrui@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 3:26=E2=80=AFAM Liu Mingrui <liumingrui@huawei.com>=
 wrote:
>
> Display the dropped count of the packet, which could provide more
> information for debugging.
>
> Signed-off-by: Liu Mingrui <liumingrui@huawei.com>

Old /proc interface is legacy, we do not accept changes in it.

Instead, change net/packet/diag.c , iproute2/ss and use "ss -0".

Also, your patch is not correct, because of getsockopt( ...
PACKET_STATISTICS ... )

