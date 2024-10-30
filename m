Return-Path: <netdev+bounces-140339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D885B9B605D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDE52823CB
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E71E3DC2;
	Wed, 30 Oct 2024 10:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FA1E32C5;
	Wed, 30 Oct 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284806; cv=none; b=XG3fiWVdJs339ygu9El8Z/exX9ENt7bBd9JrNXFqs2jVQsPswA26XSVG5zL7/MMHddx8NO02qHJBMj+EBRfr4lbOayJV570jbOMsuQTQi+NYrywa9gaN4PzmVFsCEfLk6DP4cos2fTr/nhwJXlEQqvjG5/8xynOMHP9a6Zk+GUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284806; c=relaxed/simple;
	bh=gUypjv136vIPJsIzg8jqp7/twb7LsTDatq73P6OdXqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjG2ybodClkHg2yrKzJJjbv7gzNx1KLR/9Ooy+ocPAMCaH0Hg9T/ImU3sS238yoAOkYvXDoI9t6ExsdLHhUcI8KPAjNbIiUNeybMklASpudUZfF4iBszmdyCEBhEF6lTj2drubmn1tlPKfj0ZF42ezQDKFhBABia54MSR9X0tAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso99526341fa.3;
        Wed, 30 Oct 2024 03:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730284802; x=1730889602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5zeClzjkLB2fwj5NuKVJcICjOwHMYB7WeUASTb/YtI=;
        b=YDphLn4brCoN13V27OTf6smI+JOLfkc0TmWVlBW3ekZCf+ZrHY7SfBLF4V9ejCFwZR
         aWVlUX52aHZnZyhpitNSdB6RpGjS3KmC2LkdYvmXm3uPLo6TtzAff/lKdkp0FGMezwPH
         2Uw28bChgOg/jM9Amn5KQRk+sS+zobtlYLTpGpZI8UtIyl0ITZrpkfCi8UNXjtLys7fl
         PrbmYfPRb3kYGyoS/rdSrXh1dR6a4L+C+BgA4Xk1U6wH2RyOgK4sg9BaObTaBV+F7PNw
         ENwfoUTK35R2OUJ0fHzlmlW72P1KYezYO7n5xmQX8LBJSycLtL5kcXa/ZnCGKz8MFSk7
         BIBA==
X-Forwarded-Encrypted: i=1; AJvYcCWYIF4fmBAzgFp+36eu10+sCSfaGbCFoC0PH4xZ7m+YA3QeSrtlWMQM/ssZr24s51FojOmnS2Mic/cu3xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGu6TnaJ72aKlNPLV37ohrDQ3inYBJMyxfHL0clC7hNOnUM8KV
	YINccTpsjfJW2HKblaEU2cjg4gkoqyNcT+0dJrtcnyM1GxCBXXK8
X-Google-Smtp-Source: AGHT+IF1BeMOioe7t/P4H3j1JzkGprhgTWXKnwqJJVpJqtv4+UpyysQM6plM71Gz04mozafT9jF6YA==
X-Received: by 2002:a05:651c:211c:b0:2fb:63b5:c0bc with SMTP id 38308e7fff4ca-2fcbdf60dfdmr108666691fa.3.1730284801674;
        Wed, 30 Oct 2024 03:40:01 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a0887besm558559566b.207.2024.10.30.03.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:40:01 -0700 (PDT)
Date: Wed, 30 Oct 2024 03:39:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Radu Bulie <radu-andrei.bulie@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sean Anderson <sean.anderson@linux.dev>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/3] soc: fsl_qbman: use be16_to_cpu() in
 qm_sg_entry_get_off()
Message-ID: <20241030-enigmatic-mayfly-of-triumph-d571bb@leitao>
References: <20241029164317.50182-1-vladimir.oltean@nxp.com>
 <20241029164317.50182-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029164317.50182-2-vladimir.oltean@nxp.com>

On Tue, Oct 29, 2024 at 06:43:15PM +0200, Vladimir Oltean wrote:
> struct qm_sg_entry :: offset is a 13-bit field, declared as __be16.
> 
> When using be32_to_cpu(), a wrong value will be calculated on little
> endian systems (Arm), because type promotion from 16-bit to 32-bit,
> which is done before the byte swap and always in the CPU native
> endianness, changes the value of the scatter/gather list entry offset in
> big-endian interpretation (adds two zero bytes in the LSB interpretation).
> The result of the byte swap is ANDed with GENMASK(12, 0), so the result
> is always zero, because only those bytes added by type promotion remain
> after the application of the bit mask.
> 
> The impact of the bug is that scatter/gather frames with a non-zero
> offset into the buffer are treated by the driver as if they had a zero
> offset. This is all in theory, because in practice, qm_sg_entry_get_off()
> has a single caller, where the bug is inconsequential, because at that
> call site the buffer offset will always be zero, as will be explained in
> the subsequent change.
> 
> Flagged by sparse:
> 
> warning: cast to restricted __be32
> warning: cast from restricted __be16
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

