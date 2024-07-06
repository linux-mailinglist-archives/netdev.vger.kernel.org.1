Return-Path: <netdev+bounces-109631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53229293EE
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521F52831AB
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5F71B3A;
	Sat,  6 Jul 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Or+5RC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43254C3D0
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720274025; cv=none; b=Qj/JYgikWc1ni1HAFNwNv/rcMXYbj0nlGftK8gk5ijDfzTwjIVXxblXlX9huEs5p/24wigtxlLjIR5lVPaKBnMeaauQil/S1Ei76xclCoG4/+XP5TaEge7GvL8HpxOuuiMBjVLuypEDoWTeAX2XdVHJsbjZuU8npG7uDXTbDSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720274025; c=relaxed/simple;
	bh=HvDnSRgcm7lQ8qUtV+hO9G66uJipikccUT9YBOOxlHg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aEOoeMr+Ws5KOPdyuMD6OmKtSwxf07ETNXtqv75UoYZSHAcDn8pKxTm7wYbGEQKNl6DixU8hr/ReRHGeKb3AUJvfgiTisFwuSmu+QrRdwka1OCcxNyT4SF5o8w7qiBlLOkZMV0IV3FZw+WyIbknVuKkepq4RDht9NGjdP9JU4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Or+5RC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79ef7ecc7d4so107338785a.0
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720274022; x=1720878822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwVF6MZu0lHB0fVsks3TXMBE9BXW3MUVus1J2mzS5Tw=;
        b=D4Or+5RC9ssY39WHKYDviRTZUbWOqv+oK6KilqX0kmlVP5mursvLjHenoOjjgJ2qtP
         HhuBH0QDpdryHMPHSwjNfIfifGVChWpNHj0flerdSQXOpmsHR9R5MnlAPTIFfD7CRKEJ
         9niZLvAfPb9YaC4YJf3KWC2ihVvGFggBRXFgJJor4VoLAe3CWcgkmt7I66rpPYhRoC0p
         tou93QKelaNTeoDCaYEDsD5drW5r2KtTWLFaiMHDeNnu/YUb53oDVvQ3JMECsaIeq1tD
         3TfBorUCnC5CZLVNJboCwvXh3TKbNVu9dxleM7NQRi6hIVapYoaZnGoM6pjAekTKlvbO
         9JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720274022; x=1720878822;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QwVF6MZu0lHB0fVsks3TXMBE9BXW3MUVus1J2mzS5Tw=;
        b=GgXeMmoewznIpPYbR9kZ57LVgFcbrwzpMO9izIt+aFmkpRupHHJOukooXx5Qi4C1uC
         xxd1C09/N+A2SNfdb4g/HsDx2AhJOIxwJwutZSgKUvhmi+2/1rqYinH2kniIXzjjL3ZN
         vvxzIRAG5vVxiWyIsMQuykeRA0jCfqGZxT0tCJ5piXuFLBNnQPx3OQbbIeK9r0q6GlvZ
         meI4rTfFtBNkpceqj5WpE8oLuOdcvW+2z82623JlrjQ4ZsXDSFynU7EpCn1F/Y0GJ5gp
         K1zxTgO0grZhI9hOGZtSfDiIwZfCea1gJwV6dbQ+S3r3KqpfAdU5UPvEGEPQQqf8CDcl
         tTiw==
X-Gm-Message-State: AOJu0YyYzHkye/NoNY09GRG9ec0MZ2/8wyT6dmsx9b+iizPA68vBhhvw
	DGywsDDIuWPlGUtpaHsqbODQaFV2MVQNPT7S/XORwh+u7+xwSUI1
X-Google-Smtp-Source: AGHT+IHmN8HqLjhWkTbKcGuGKpysod5xM1bWzBtaOg7ugXGCMQahyGSNWffSajtAdCv9oi1GhwQb+w==
X-Received: by 2002:a05:620a:22c6:b0:79d:8798:7f21 with SMTP id af79cd13be357-79eee170138mr720396585a.10.1720274022380;
        Sat, 06 Jul 2024 06:53:42 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79ef9aa8889sm139974785a.20.2024.07.06.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 06:53:41 -0700 (PDT)
Date: Sat, 06 Jul 2024 09:53:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 petrm@nvidia.com, 
 przemyslaw.kitszel@intel.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <66894c659cee8_12869e2942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240705015725.680275-2-kuba@kernel.org>
References: <20240705015725.680275-1-kuba@kernel.org>
 <20240705015725.680275-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: rss_ctx: fix cleanup in
 the basic test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The basic test may fail without resetting the RSS indir table.
> While at it reformat the doc a tiny bit.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/rss_ctx.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> index 475f2a63fcd5..de2a55c0f35c 100755
> --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -64,9 +64,8 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
>  
>  
>  def test_rss_key_indir(cfg):
> -    """
> -    Test basics like updating the main RSS key and indirection table.
> -    """
> +    """Test basics like updating the main RSS key and indirection table."""
> +
>      if len(_get_rx_cnts(cfg)) < 2:
>          KsftSkipEx("Device has only one queue (or doesn't support queue stats)")
>  
> @@ -89,6 +88,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
>  
>      # Set the indirection table
>      ethtool(f"-X {cfg.ifname} equal 2")
> +    reset_indir = defer(ethtool, f"-X {cfg.ifname} default")
>      data = get_rss(cfg)
>      ksft_eq(0, min(data['rss-indirection-table']))
>      ksft_eq(1, max(data['rss-indirection-table']))
> @@ -104,7 +104,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
>      ksft_eq(sum(cnts[2:]), 0, "traffic on unused queues: " + str(cnts))
>  
>      # Restore, and check traffic gets spread again
> -    ethtool(f"-X {cfg.ifname} default")
> +    reset_indir.exec()

When is this explicit exec needed?

